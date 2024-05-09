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
    random = {
      source  = "hashicorp/random"
      version = "3.6.1"
    }
  }
}

provider "google" {
  project     = var.project
  region      = var.region
  zone        = var.zone
  credentials = var.gcp-creds
}

provider "random" {
}