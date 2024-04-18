# This file contains the variable declarations for the GCP organization ID, project ID, and other configuration options
# required for onboarding with Expel Workbench.

# The `org_id` variable represents the GCP organization ID to onboard with Expel Workbench.
variable "org_id" {
  description = "The GCP organization ID to onboard with Expel Workbench."
  type        = string
  default     = null
}

# The `project_id` variable represents the GCP project ID to onboard with Expel Workbench.
variable "project_id" {
  description = "The GCP project ID to onboard with Expel Workbench."
  type        = string
  default     = null
}

# The `expel_project_id` variable represents the ID of the new project to be created when onboarding at the GCP organization level.
variable "expel_project_id" {
  description = "When onboarding at the GCP organization level, a new project will be created with this ID."
  type        = string
  default     = "expel-gke-integration"
}

# The `service_account_name` variable represents the name of the service account to be created for Expel.
variable "service_account_name" {
  description = "The name of the service account to be created for Expel."
  type        = string
  default     = "gke-account"
}

# The `iam_role_name` variable represents the name of the IAM role to be created for Expel.
variable "iam_role_name" {
  description = "The name of the IAM role to be created for Expel."
  type        = string
  default     = "ExpelIntegrationKubernetesReader"
}

# The `prefix` variable represents a prefix to group all Expel integration resources.
variable "prefix" {
  description = "A prefix to group all Expel integration resources."
  type        = string
  default     = "expel-integration"

  validation {
    condition     = length(var.prefix) <= 26
    error_message = "Prefix value must be 26 characters or less."
  }
}

# The `pubsub_ack_deadline_seconds` variable represents the number of seconds pub/sub will wait for a subscriber to acknowledge receiving a message before re-attempting delivery.
variable "pubsub_ack_deadline_seconds" {
  description = "The number of seconds pub/sub will wait for a subscriber to acknowledge receiving a message before re-attempting delivery."
  type        = number
  default     = 600
}

# The `log_sink_filter` variable represents the log sink filter that determines what logs are delivered to pub/sub and consumed by Expel.
variable "log_sink_filter" {
  description = "The log sink filter that determines what logs are delivered to pub/sub and consumed by Expel."
  type        = string
  default     = <<EOT
(resource.type=gke_cluster OR resource.type=k8s_cluster)
-proto_payload.method_name="io.k8s.core.v1.nodes.proxy.get"
-proto_payload.method_name="io.k8s.coordination.v1.leases.update"
-proto_payload.method_name="io.k8s.core.v1.limitranges.update"
-proto_payload.method_name="io.k8s.autoscaling"
EOT
}
