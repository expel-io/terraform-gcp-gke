terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.10.0"
    }
  }
  required_version = ">= 1.1.0"
}
