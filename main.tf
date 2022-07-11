resource "google_service_account" "expel_svc_acct" {
  project      = var.project
  account_id   = "${var.prefix}-${var.service_account_name}"
  display_name = "${var.prefix}-${var.service_account_name}"
  description  = "Expel Workbench GKE Integration"
}

resource "google_service_account_key" "expel_svc_acct_key" {
  service_account_id = google_service_account.expel_svc_acct.name
}

# This role grants permissions to list and get Kubernetes resources in GKE
resource "google_project_iam_custom_role" "expel_k8s_role" {
  project     = var.project
  role_id     = var.iam_role_name
  title       = var.iam_role_name
  description = "Grants read-only access to non-sensitive Kubernetes resources"
  permissions = [
    "container.apiServices.get",
    "container.apiServices.getStatus",
    "container.apiServices.list",
    "container.auditSinks.get",
    "container.auditSinks.list",
    "container.backendConfigs.get",
    "container.backendConfigs.list",
    "container.bindings.get",
    "container.bindings.list",
    "container.certificateSigningRequests.get",
    "container.certificateSigningRequests.getStatus",
    "container.certificateSigningRequests.list",
    "container.clusterRoleBindings.get",
    "container.clusterRoleBindings.list",
    "container.clusterRoles.get",
    "container.clusterRoles.list",
    "container.clusters.get",
    "container.clusters.list",
    "container.componentStatuses.get",
    "container.componentStatuses.list",
    "container.controllerRevisions.get",
    "container.controllerRevisions.list",
    "container.cronJobs.get",
    "container.cronJobs.getStatus",
    "container.cronJobs.list",
    "container.csiDrivers.get",
    "container.csiDrivers.list",
    "container.csiNodeInfos.get",
    "container.csiNodeInfos.list",
    "container.csiNodes.get",
    "container.csiNodes.list",
    "container.customResourceDefinitions.get",
    "container.customResourceDefinitions.getStatus",
    "container.customResourceDefinitions.list",
    "container.daemonSets.get",
    "container.daemonSets.getStatus",
    "container.daemonSets.list",
    "container.deployments.get",
    "container.deployments.getScale",
    "container.deployments.getStatus",
    "container.deployments.list",
    "container.endpointSlices.get",
    "container.endpointSlices.list",
    "container.endpoints.get",
    "container.endpoints.list",
    "container.events.get",
    "container.events.list",
    "container.frontendConfigs.get",
    "container.frontendConfigs.list",
    "container.horizontalPodAutoscalers.get",
    "container.horizontalPodAutoscalers.getStatus",
    "container.horizontalPodAutoscalers.list",
    "container.ingresses.get",
    "container.ingresses.getStatus",
    "container.ingresses.list",
    "container.initializerConfigurations.get",
    "container.initializerConfigurations.list",
    "container.jobs.get",
    "container.jobs.getStatus",
    "container.jobs.list",
    "container.mutatingWebhookConfigurations.get",
    "container.mutatingWebhookConfigurations.list",
    "container.namespaces.get",
    "container.namespaces.getStatus",
    "container.namespaces.list",
    "container.networkPolicies.get",
    "container.networkPolicies.list",
    "container.nodes.get",
    "container.nodes.getStatus",
    "container.nodes.list",
    "container.operations.get",
    "container.operations.list",
    "container.persistentVolumeClaims.get",
    "container.persistentVolumeClaims.getStatus",
    "container.persistentVolumeClaims.list",
    "container.persistentVolumes.get",
    "container.persistentVolumes.getStatus",
    "container.persistentVolumes.list",
    "container.petSets.get",
    "container.petSets.list",
    "container.podDisruptionBudgets.get",
    "container.podDisruptionBudgets.getStatus",
    "container.podDisruptionBudgets.list",
    "container.podPresets.get",
    "container.podPresets.list",
    "container.podSecurityPolicies.get",
    "container.podSecurityPolicies.list",
    "container.podTemplates.get",
    "container.podTemplates.list",
    "container.pods.get",
    "container.pods.getStatus",
    "container.pods.list",
    "container.priorityClasses.get",
    "container.priorityClasses.list",
    "container.replicaSets.get",
    "container.replicaSets.getScale",
    "container.replicaSets.getStatus",
    "container.replicaSets.list",
    "container.replicationControllers.get",
    "container.replicationControllers.getScale",
    "container.replicationControllers.getStatus",
    "container.replicationControllers.list",
    "container.resourceQuotas.get",
    "container.resourceQuotas.getStatus",
    "container.resourceQuotas.list",
    "container.roleBindings.get",
    "container.roleBindings.list",
    "container.roles.get",
    "container.roles.list",
    "container.runtimeClasses.get",
    "container.runtimeClasses.list",
    "container.scheduledJobs.get",
    "container.scheduledJobs.list",
    "container.serviceAccounts.get",
    "container.serviceAccounts.list",
    "container.services.get",
    "container.services.getStatus",
    "container.services.list",
    "container.statefulSets.get",
    "container.statefulSets.getScale",
    "container.statefulSets.getStatus",
    "container.statefulSets.list",
    "container.storageClasses.get",
    "container.storageClasses.list",
    "container.storageStates.get",
    "container.storageStates.getStatus",
    "container.storageStates.list",
    "container.storageVersionMigrations.get",
    "container.storageVersionMigrations.getStatus",
    "container.storageVersionMigrations.list",
    "container.thirdPartyObjects.get",
    "container.thirdPartyObjects.list",
    "container.thirdPartyResources.get",
    "container.thirdPartyResources.list",
    "container.tokenReviews.create",
    "container.updateInfos.get",
    "container.updateInfos.list",
    "container.validatingWebhookConfigurations.get",
    "container.validatingWebhookConfigurations.list",
    "container.volumeAttachments.get",
    "container.volumeAttachments.getStatus",
    "container.volumeAttachments.list",
    "container.volumeSnapshotClasses.get",
    "container.volumeSnapshotClasses.list",
    "container.volumeSnapshotContents.get",
    "container.volumeSnapshotContents.getStatus",
    "container.volumeSnapshotContents.list",
    "container.volumeSnapshots.get",
    "container.volumeSnapshots.list",
  ]
}

resource "google_project_iam_member" "expel_k8s_role_binding" {
  project = var.project
  role    = google_project_iam_custom_role.expel_k8s_role.name
  member  = "serviceAccount:${google_service_account.expel_svc_acct.email}"
}

resource "google_project_iam_member" "expel_browser_role_binding" {
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