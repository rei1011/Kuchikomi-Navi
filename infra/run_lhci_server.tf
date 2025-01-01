resource "google_cloud_run_v2_service" "lhci_server" {
  name     = var.lhci_server_name
  location = var.region

  template {
    scaling {
      min_instance_count = 0
      max_instance_count = 1
    }
    containers {
      image = "${var.region}-docker.pkg.dev/${var.project}/${var.lhci_server_name}/${var.lhci_image_name}:latest"
    }
  }
}

resource "google_cloud_run_v2_service_iam_member" "lhci_server" {
  location = google_cloud_run_v2_service.default.location
  name     = google_cloud_run_v2_service.default.name
  role     = "roles/run.invoker"
  member   = "allUsers"

  depends_on = [google_project_service.service]
}
