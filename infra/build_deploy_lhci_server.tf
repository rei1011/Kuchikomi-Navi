# lhci serverのimageを保存するためのArtifact Registry
resource "google_artifact_registry_repository" "lhci_server" {
  location      = var.region
  repository_id = var.lhci_server_name
  description   = "lhci server"
  format        = "DOCKER"
  cleanup_policies {
    id     = "delete"
    action = "DELETE"
    condition {
      tag_state = "ANY"
    }
  }
  cleanup_policies {
    id     = "keep"
    action = "KEEP"
    most_recent_versions {
      keep_count = 2
    }
  }
}

resource "google_cloudbuild_trigger" "lhci_server_trigger" {
  name     = "${var.lhci_server_name}-trigger"
  location = var.region
  repository_event_config {
    repository = google_cloudbuildv2_repository.github_repository.id
    push {
      branch = "^(main|lighthouse-ci)$"
    }
  }
  filename = "infra/lhci_cloudbuild.yaml"

  substitutions = {
    _REGION                         = var.region
    _ARTIFACT_REPOSITORY_IMAGE_NAME = "${var.region}-docker.pkg.dev/${var.project}/${var.lhci_server_name}/${var.lhci_image_name}"
    _SERVICE_NAME                   = var.lhci_server_name
  }
}