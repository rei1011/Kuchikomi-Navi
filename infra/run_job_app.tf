# Job用のCloud Run Jobsを作成
resource "google_cloud_run_v2_job" "job_app" {
  name     = var.job_app_name
  location = var.region

  template {
    template {
      timeout = "1200s"
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
}

# Cloud Scheduler 用のサービス アカウントを作成し、Cloud Run Jobsの実行権限を付与
resource "google_service_account" "scheduler" {
  account_id   = "scheduler-sa"
  description  = "Cloud Scheduler service account; used to trigger scheduled Cloud Run jobs."
  display_name = "scheduler-sa"

  # Use an explicit depends_on clause to wait until API is enabled
  depends_on = [
    google_project_service.service
  ]
}
resource "google_cloud_run_v2_job_iam_member" "scheduler_iam_member" {
  name     = google_cloud_run_v2_job.job_app.name
  location = google_cloud_run_v2_job.job_app.location
  for_each = toset([
    "roles/run.admin",
  ])
  role    = each.value
  member  = "serviceAccount:${google_service_account.scheduler.email}"
  project = var.project

  depends_on = [google_cloud_run_v2_job.job_app, google_service_account.scheduler]
}

# Cloud Run Jobsを定期実行するためのトリガー
resource "google_cloud_scheduler_job" "job" {
  name        = "schedule-job"
  description = "job scheduling"
  # 毎日午前8時にjobを起動
  schedule         = "0 8 * * *"
  attempt_deadline = "320s"
  region           = var.region

  retry_config {
    retry_count = 3
  }

  http_target {
    http_method = "POST"
    uri         = "https://${var.region}-run.googleapis.com/apis/run.googleapis.com/v1/namespaces/${var.project}/jobs/${var.job_app_name}:run"

    oauth_token {
      service_account_email = google_service_account.scheduler.email
    }

  }

  depends_on = [google_cloud_run_v2_job.job_app, google_service_account.scheduler, google_cloud_run_v2_job_iam_member.scheduler_iam_member]
}