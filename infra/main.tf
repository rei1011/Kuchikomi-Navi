terraform {
  cloud {
    organization = "Kuchikomi-Navi"

    workspaces {
      name = "prod"
    }
  }
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.28.0"
    }
  }
}

provider "google" {
  project     = var.project
  region      = var.region
  zone        = var.zone
  credentials = var.gcp-creds
}