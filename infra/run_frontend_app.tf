resource "google_cloud_run_v2_service" "default" {
  name     = var.frontend_app_name
  location = var.region

  template {
    scaling {
      min_instance_count = 0
      max_instance_count = 1
    }
    containers {
      image = "${var.region}-docker.pkg.dev/${var.project}/${var.frontend_app_name}/${var.frontend_image_name}:latest"
    }
  }
}

resource "google_cloud_run_v2_service_iam_binding" "default" {
  location = google_cloud_run_v2_service.default.location
  name     = google_cloud_run_v2_service.default.name
  role     = "roles/run.invoker"
  members = [
    "allUsers"
  ]

  depends_on = [google_project_service.service]
}
