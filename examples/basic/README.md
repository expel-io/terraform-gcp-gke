# Basic

This configuration sets up appropriate GCP resources that are necessary to integrate Expel Workbench with existing GKE clusters in a project.

This `Basic` example is the simplest onboarding experience, as it assumes a single GCP project is being onboarded.

## Usage


To run this example you need to execute:

```bash
terraform init
terraform apply -var-file="terraform.tfvars"
```

Note that sensitive values such as the generated service account key are not printed to standard out by default, however they are persisted to the statefile. Please ensure the statefile and it's stored secrets are secured.

 To view the service account key created, run:

```bash
terraform output -json
```

Note that this example may create resources which cost money (pub/sub queue, for example). Run `terraform destroy` when you don't need these resources.

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.1.0 |
| google | ~> 4.10.0 |