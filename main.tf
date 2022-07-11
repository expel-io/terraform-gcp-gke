resource "google_service_account" "expel_svc_acct" {
  project      = var.project
  account_id   = "${var.prefix}-${var.service_account_name}"
  display_name = "${var.prefix}-${var.service_account_name}"
  description  = "Expel Workbench GKE Integration"
}

resource "google_service_account_key" "expel_svc_acct_key" {
  service_account_id = google_service_account.expel_svc_acct.name
}

# This role grants permissions to list and describe GKE clusters in the project
# includedPermissions:
# - container.clusters.get
# - container.clusters.list
# - resourcemanager.projects.get
# - resourcemanager.projects.list
resource "google_project_iam_member" "expel_gke_permissions" {
  project = var.project
  role    = "roles/container.clusterViewer"
  member  = "serviceAccount:${google_service_account.expel_svc_acct.email}"
}

# description: Access to browse GCP folders, orgs, and projects (required to discover GKE clusters).
# includedPermissions:
# - resourcemanager.folders.get
# - resourcemanager.folders.list
# - resourcemanager.organizations.get
# - resourcemanager.projects.get
# - resourcemanager.projects.getIamPolicy
# - resourcemanager.projects.list
# name: roles/browser
resource "google_project_iam_member" "expel_browser_permissions" {
  project = var.project
  role    = "roles/browser"
  member  = "serviceAccount:${google_service_account.expel_svc_acct.email}"
}

resource "google_pubsub_subscription_iam_member" "expel_pubsub_permissions" {
  project      = var.project
  member       = "serviceAccount:${google_service_account.expel_svc_acct.email}"
  role         = "roles/pubsub.subscriber"
  subscription = google_pubsub_subscription.expel_pubsub_subscription.name
}

resource "google_pubsub_topic" "expel_pubsub_topic" {
  project = var.project
  name    = "${var.prefix}-gke-log-topic"
}

resource "google_pubsub_subscription" "expel_pubsub_subscription" {
  project = var.project
  name    = "${var.prefix}-gke-log-subscription"
  topic   = google_pubsub_topic.expel_pubsub_topic.name

  ack_deadline_seconds  = var.pubsub_ack_deadline_seconds
  retain_acked_messages = false
}

resource "google_pubsub_topic_iam_member" "expel_sink_publisher_permissions" {
  project = var.project
  role    = "roles/pubsub.publisher"
  topic   = google_pubsub_topic.expel_pubsub_topic.name
  member  = google_logging_project_sink.expel_log_sink.writer_identity
}

resource "google_logging_project_sink" "expel_log_sink" {
  project                = var.project
  name                   = "${var.prefix}-gke-log-sink"
  description            = "Expel GKE log sink"
  destination            = "pubsub.googleapis.com/${google_pubsub_topic.expel_pubsub_topic.id}"
  unique_writer_identity = true

  # this filter determines what logs are published to the pub/sub topic
  filter = var.log_sink_filter
}