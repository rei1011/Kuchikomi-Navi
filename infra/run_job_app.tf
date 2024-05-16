resource "google_cloud_run_v2_service" "job_app" {
  name     = var.job_app_name
  location = var.region

  template {
    scaling {
      min_instance_count = 0
      max_instance_count = 1
    }
    containers {
      image = "${var.region}-docker.pkg.dev/${var.project}/${var.job_app_name}/${var.job_image_name}:latest"

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