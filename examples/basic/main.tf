# This Terraform configuration file deploys a GCP GKE integration with Expel.
# It sets up a Google provider, defines variables for project ID and region,
# and uses a module to onboard GKE logs for the specified project.
# The module creates resources such as a Pub/Sub topic, a log sink, and IAM bindings.
# It also applies a filter to determine which logs Expel collects.
# The output block exposes the module's output, which is sensitive and should be treated as such.

variable "project_id" {
  type = string
  description = "The ID of the GCP project where the GKE integration will be deployed."
}

variable "region" {
  type = string
  description = "The region where the GKE cluster is located."
}

 # Configures the Google provider to use the specified region.
provider "google" {
  region = var.region
}

module "expel_gcp_gke_integration" {
   # The source of the module, which is located in the parent directory.
  source = "../../"

   # The project ID to onboard GKE logs for.
  project_id = var.project_id

  # A prefix applied to all created resources.
  prefix = "expel-integration"

  # How long Pub/Sub waits for an acknowledgement.
  pubsub_ack_deadline_seconds = 600

  # Filter that determines what logs Expel collects.
  log_sink_filter = <<EOT
(resource.type=gke_cluster OR resource.type=k8s_cluster)
-proto_payload.method_name="io.k8s.core.v1.nodes.proxy.get"
-proto_payload.method_name="io.k8s.coordination.v1.leases.update"
-proto_payload.method_name="io.k8s.core.v1.limitranges.update"
-proto_payload.method_name="io.k8s.autoscaling"
EOT

}

# Exposes the output of the module, which is sensitive and should be treated as such.
output "expel_gcp_gke_integration" {
  value     = module.expel_gcp_gke_integration
  sensitive = true

}
