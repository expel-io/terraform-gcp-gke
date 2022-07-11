variable "project" {
  type = string
}

variable "region" {
  type = string
}

provider "google" {
  region = var.region
}

module "expel_gcp_gke_integration" {
  source = "../../"

  # The project to onboard GKE logs for
  project = var.project
  # A prefix applied to all created resources
  prefix = "expel-integration"
  # How long pub/sub waits for an acknowledgement
  pubsub_ack_deadline_seconds = 600
  # Filter that determines what logs Expel collects
  log_sink_filter = <<EOT
(resource.type=gke_cluster OR resource.type=k8s_cluster)
-proto_payload.method_name="io.k8s.core.v1.nodes.proxy.get"
-proto_payload.method_name="io.k8s.coordination.v1.leases.update"
-proto_payload.method_name="io.k8s.core.v1.limitranges.update"
-proto_payload.method_name="io.k8s.autoscaling"
EOT
}

output "expel_gcp_gke_integration" {
  value     = module.expel_gcp_gke_integration
  sensitive = true
}
