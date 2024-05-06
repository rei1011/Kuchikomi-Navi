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
      version = "4.51.0"
    }
  }
}

provider "google" {
  project = "rapid-stage-422403-r2"
  credentials = var.gcp-creds
}

variable "gcp-creds" {
  default = ""
}

resource "google_compute_network" "vpc_network" {
  name = "terraform-network"
}
