/*
** Terraform Configuration File **
*
*  This Terraform configuration file sets the required providers and version for the project.
*
* - The `google` provider is required and its source is set to `hashicorp/google` with a version constraint of "~> 4.10.0".
* - The required Terraform version is set to ">= 1.1.0".
*
* Make sure to have the necessary provider plugins installed and the correct Terraform version before applying this
* configuration.
*/
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.10.0"
    }
  }
  required_version = ">= 1.1.0"
}
