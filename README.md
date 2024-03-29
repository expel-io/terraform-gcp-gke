# terraform-gcp-gke
Terraform module for configuring Google Kubernetes Engine (GKE) to integrate with [Expel Workbench](https://workbench.expel.io/).

Configures a log sink to send data to a pub/sub queue that
[Expel Workbench](https://workbench.expel.io/) consumes.

:exclamation: Terraform state may contain sensitive information. Please follow best security practices when securing your state.

## Usage

### Onboarding a GCP Organization with Expel Workbench
When the `org_id` variable is set, this module will create the resources required to onboard all GKE clusters in a GCP organization to Expel Workbench.
```hcl
module "expel_gcp_gke" {
  source  = "expel-io/gke/gcp"
  version = "1.0.1"
  # The GCP Organization ID to onboard
  org_id = "my-gcp-project-id"
}
```

### Onboarding a GCP Project with Expel Workbench
When the `project_id` variable is set, this module will create the resources required to onboard all GKE clusters in a specific project to Expel Workbench.
```hcl
module "expel_gcp_gke" {
  source  = "expel-io/gke/gcp"
  version = "1.0.1"
  # The GCP Project ID to onboard
  project_id = "my-gcp-project-id"
}
```
Once you have configured your GCP environment, go to
https://workbench.expel.io/settings/security-devices?setupIntegration=kubernetes_gke and create a GKE
security device to enable Expel to begin monitoring your AWS environment.

## Permissions
The permissions allocated by this module allow Expel Workbench to perform investigations and discover GKE clusters in the environment.

## Limitations
1. Will always create a new log sink
2. Will always create a new pub/sub queue

See Expel's Getting Started Guide for GKE for more onboarding information.

<!-- begin-tf-docs -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.1.0 |
| <a name="requirement_google"></a> [google](#requirement\_google) | ~> 4.10.0 |
## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 4.10.0 |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_expel_project_id"></a> [expel\_project\_id](#input\_expel\_project\_id) | When onboarding at the organization level, a new project will be created with this ID. | `string` | `"expel-gke-integration"` | no |
| <a name="input_iam_role_name"></a> [iam\_role\_name](#input\_iam\_role\_name) | The name of the IAM role to be created for Expel | `string` | `"ExpelIntegrationKubernetesReader"` | no |
| <a name="input_log_sink_filter"></a> [log\_sink\_filter](#input\_log\_sink\_filter) | The log sink filter that determines what logs are delivered to pub/sub and consumed by Expel. | `string` | `"(resource.type=gke_cluster OR resource.type=k8s_cluster)\n-proto_payload.method_name=\"io.k8s.core.v1.nodes.proxy.get\"\n-proto_payload.method_name=\"io.k8s.coordination.v1.leases.update\"\n-proto_payload.method_name=\"io.k8s.core.v1.limitranges.update\"\n-proto_payload.method_name=\"io.k8s.autoscaling\"\n"` | no |
| <a name="input_org_id"></a> [org\_id](#input\_org\_id) | The organization ID to onboard with Expel Workbench. | `string` | `null` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | A prefix to group all Expel integration resources. | `string` | `"expel-integration"` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The project ID to onboard with Expel Workbench. | `string` | `null` | no |
| <a name="input_pubsub_ack_deadline_seconds"></a> [pubsub\_ack\_deadline\_seconds](#input\_pubsub\_ack\_deadline\_seconds) | The number of seconds pub/sub will wait for a subscriber to acknowledge receiving a message before re-attempting delivery. | `number` | `600` | no |
| <a name="input_service_account_name"></a> [service\_account\_name](#input\_service\_account\_name) | The name of the service account to be created for Expel. | `string` | `"gke-account"` | no |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_pubsub_subscription_name"></a> [pubsub\_subscription\_name](#output\_pubsub\_subscription\_name) | Name of the Kinesis data stream Expel will consume from |
| <a name="output_service_account_key"></a> [service\_account\_key](#output\_service\_account\_key) | The service account credentials required by Expel for onboarding |
## Resources

| Name | Type |
|------|------|
| [google_logging_organization_sink.expel_log_sink](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/logging_organization_sink) | resource |
| [google_logging_project_sink.expel_log_sink](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/logging_project_sink) | resource |
| [google_organization_iam_custom_role.expel_k8s_role](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/organization_iam_custom_role) | resource |
| [google_organization_iam_member.expel_browser_role_binding](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/organization_iam_member) | resource |
| [google_organization_iam_member.expel_k8s_role_binding](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/organization_iam_member) | resource |
| [google_project.expel_gke_integration_project](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project) | resource |
| [google_project_iam_custom_role.expel_k8s_role](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_custom_role) | resource |
| [google_project_iam_member.expel_browser_role_binding](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.expel_k8s_role_binding](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_pubsub_subscription.expel_pubsub_subscription](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/pubsub_subscription) | resource |
| [google_pubsub_subscription_iam_member.expel_pubsub_permissions](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/pubsub_subscription_iam_member) | resource |
| [google_pubsub_topic.expel_pubsub_topic](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/pubsub_topic) | resource |
| [google_pubsub_topic_iam_member.expel_sink_publisher_permissions](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/pubsub_topic_iam_member) | resource |
| [google_service_account.expel_svc_acct](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [google_service_account_key.expel_svc_acct_key](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account_key) | resource |
<!-- end-tf-docs -->
