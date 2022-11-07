variable "org_id" {
  description = "The GCP organization ID to onboard with Expel Workbench."
  type        = string
  default     = null
}

variable "project_id" {
  description = "The GCP project ID to onboard with Expel Workbench."
  type        = string
  default     = null
}

variable "expel_project_id" {
  description = "When onboarding at the GCP organization level, a new project will be created with this ID."
  type        = string
  default     = "expel-gke-integration"
}

variable "service_account_name" {
  description = "The name of the service account to be created for Expel."
  type        = string
  default     = "gke-account"
}

variable "iam_role_name" {
  description = "The name of the IAM role to be created for Expel"
  type        = string
  default     = "ExpelIntegrationKubernetesReader"
}

variable "prefix" {
  description = "A prefix to group all Expel integration resources."
  type        = string
  default     = "expel-integration"

  validation {
    condition     = length(var.prefix) <= 26
    error_message = "Prefix value must be 26 characters or less."
  }
}

variable "pubsub_ack_deadline_seconds" {
  description = "The number of seconds pub/sub will wait for a subscriber to acknowledge receiving a message before re-attempting delivery."
  type        = number
  default     = 600
}

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
