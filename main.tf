# This Terraform configuration file creates resources for integrating Expel Workbench with Google Kubernetes Engine (GKE).

# If onboarding at the Organization level, it creates a new project for integration resources.
resource "google_project" "expel_gke_integration_project" {
  count      = (var.org_id != null && var.project_id == null) ? 1 : 0
  name       = var.expel_project_id
  project_id = var.expel_project_id
  org_id     = var.org_id
}

# Creates a service account in the specified (or newly created) project.
resource "google_service_account" "expel_svc_acct" {
  project      = var.project_id == null ? var.expel_project_id : var.project_id
  account_id   = "${var.prefix}-${var.service_account_name}"
  display_name = "${var.prefix}-${var.service_account_name}"
  description  = "Expel Workbench GKE Integration"
}

# Creates a service account key for the service account.
resource "google_service_account_key" "expel_svc_acct_key" {
  service_account_id = google_service_account.expel_svc_acct.name
}

# Creates a Pub/Sub topic for GKE logs.
resource "google_pubsub_topic" "expel_pubsub_topic" {
  project = var.project_id == null ? var.expel_project_id : var.project_id
  name    = "${var.prefix}-gke-log-topic"
}

# Grants the necessary permissions to the service account to publish logs to the Pub/Sub topic.
resource "google_pubsub_topic_iam_member" "expel_sink_publisher_permissions" {
  project = var.project_id == null ? var.expel_project_id : var.project_id
  role    = "roles/pubsub.publisher"
  topic   = google_pubsub_topic.expel_pubsub_topic.name
  member  = var.org_id == null ? google_logging_project_sink.expel_log_sink[0].writer_identity : google_logging_organization_sink.expel_log_sink[0].writer_identity
}

# Creates a Pub/Sub subscription for consuming GKE logs.
resource "google_pubsub_subscription" "expel_pubsub_subscription" {
  project = var.project_id == null ? var.expel_project_id : var.project_id
  name    = "${var.prefix}-gke-log-subscription"
  topic   = google_pubsub_topic.expel_pubsub_topic.name

  ack_deadline_seconds  = var.pubsub_ack_deadline_seconds
  retain_acked_messages = false
}

# Grants the necessary permissions to the service account to subscribe to the Pub/Sub subscription.
resource "google_pubsub_subscription_iam_member" "expel_pubsub_permissions" {
  project      = var.project_id == null ? var.expel_project_id : var.project_id
  member       = "serviceAccount:${google_service_account.expel_svc_acct.email}"
  role         = "roles/pubsub.subscriber"
  subscription = google_pubsub_subscription.expel_pubsub_subscription.name
}

# Creates a log sink for exporting GKE logs to the Pub/Sub topic at the project level.
resource "google_logging_project_sink" "expel_log_sink" {
  count                  = (var.org_id == null && var.project_id != null) ? 1 : 0
  project                = var.project_id
  name                   = "${var.prefix}-gke-log-sink"
  description            = "Expel GKE log sink"
  destination            = "pubsub.googleapis.com/${google_pubsub_topic.expel_pubsub_topic.id}"
  unique_writer_identity = true

  # This filter determines what logs are published to the Pub/Sub topic.
  filter = var.log_sink_filter
}

# Creates a log sink for exporting GKE logs to the Pub/Sub topic at the organization level.
resource "google_logging_organization_sink" "expel_log_sink" {
  count            = (var.org_id != null && var.project_id == null) ? 1 : 0
  org_id           = var.org_id
  name             = "${var.prefix}-gke-log-sink"
  description      = "Expel GKE log sink"
  destination      = "pubsub.googleapis.com/${google_pubsub_topic.expel_pubsub_topic.id}"
  include_children = true

  # This filter determines what logs are published to the Pub/Sub topic.
  filter = var.log_sink_filter
}
