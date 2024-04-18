# Basic GCP GKE Integration with Expel Workbench

This configuration sets up the necessary GCP resources to integrate Expel Workbench with existing GKE clusters in a single GCP project.

## Table of Contents

- [Variables](#variables)
- [Providers](#providers)
- [Module](#module)
- [Output](#output)
- [Usage](#usage)
- [Prerequisites](#prerequisites)

## Variables

`project_id` : The GCP Project ID to onboard to Expel Workbench.

## Providers

- `google` : The provider for GCP resources.

## Module

- `expel_gcp_gke_integration` : Sets up the necessary GCP resources for the integration.

## Output

- `expel_gcp_gke_integration`: The output of the module, which is sensitive and should be treated as such.

## Usage

Follow these steps to deploy the configuration:

1. Initialize Terraform in your working directory. This will download the necessary provider plugins.
2 Apply the Terraform configuration. Ensure you have a terraform.tfvars file in your working directory with all the necessary variables:

```shell
terraform init
terraform apply -var-file="terraform.tfvars"
```

> **Note**: Sensitive data like the service account key isn't displayed in the standard output. However, it's stored in the statefile. Ensure the statefile and its secrets are secured.

To view the service account key created, run:

```shell
terraform output -json
```

> **Note**: This configuration may create resources that incur costs (pub/sub queue, for example). . To avoid unnecessary charges, run the `terraform destroy` command to remove these resources when they are no longer needed.

## Prerequisites

| Name | Version |
|------|---------|
| terraform | >= 1.1.0 |
| google | ~> 4.10.0 |