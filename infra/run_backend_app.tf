resource "google_cloud_run_v2_service" "backend_app" {
  name     = var.backend_app_name
  location = var.region

  template {
    scaling {
      min_instance_count = 0
      max_instance_count = 1
    }
    containers {
      image = "${var.region}-docker.pkg.dev/${var.project}/${var.backend_app_name}/${var.backend_image_name}:latest"

      volume_mounts {
        name       = "cloudsql"
        mount_path = "/cloudsql"
      }
    }
    volumes {
      name = "cloudsql"
      cloud_sql_instance {
        instances = [google_sql_database_instance.db_instance.connection_name]
      }
    }
  }
}

resource "google_cloud_run_v2_service_iam_member" "backend_app" {
  location = google_cloud_run_v2_service.backend_app.location
  name     = google_cloud_run_v2_service.backend_app.name
  role     = "roles/run.invoker"
  member   = "allUsers"

  depends_on = [google_project_service.service]
}
