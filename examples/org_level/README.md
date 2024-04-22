# Org Level

This configuration sets up appropriate GCP resources that are necessary to integrate Expel Workbench with existing GKE clusters in an organization.

This `Org Level` example describes how to onboard all GKE clusters in a GCP organization.

## Table of Contents

- [Variables](#variables)
- [Provider](#provider)
- [Module](#module)
- [Output](#output)
- [Usage](#usage)
- [Prerequisites]](#prerequisites)

## Variables

`region`: The region where the resources will be deployed.
`org_id`: The GCP organization ID to onboard GKE logs for.

## Provider

`google`: The Google Cloud provider configuration, which sets the region based on the input variable.

## Module

`expel_gcp_gke_integration`: The Expel GCP GKE Integration module, which deploys the necessary resources. It requires several input variables to onboard all GKE clusters in a GCP organization to Expel Workbench.

## Output

`expel_gcp_gke_integration`: The output value of the Expel GCP GKE Integration, indicating value is sensitive and should be treated as such.

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
