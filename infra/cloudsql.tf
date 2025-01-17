resource "google_sql_database_instance" "db_instance" {
  name             = var.database_instance_name
  database_version = "MYSQL_8_0_36"
  region           = var.region
  settings {
    tier = "db-f1-micro"
  }
}

resource "google_sql_database" "db" {
  name     = var.database_name
  instance = google_sql_database_instance.db_instance.name
}

resource "google_sql_user" "example_user" {
  name     = var.db-user
  instance = google_sql_database_instance.db_instance.name
  password = var.db-password
  host     = "%"
}

# Cloud SQLを起動するjob
resource "google_cloud_scheduler_job" "start_db" {
  name             = "start-db-job"
  description      = "Job to start Cloud SQL instance"
  schedule         = "0 22 * * 1-5"
  time_zone        = "Asia/Tokyo"
  region           = var.region
  attempt_deadline = "30s"
  paused           = false
  http_target {
    http_method = "PATCH"
    uri         = "https://sqladmin.googleapis.com/sql/v1beta4/projects/${var.project}/instances/${google_sql_database_instance.db_instance.id}"
    headers = {
      Content-Type = "application/json"
    }
    body = base64encode(jsonencode({
      "settings" = {
        "activationPolicy" = "ALWAYS",
      }
    }))
    oauth_token {
      service_account_email = google_service_account.cloudsql_scheduler.email
    }
  }

  depends_on = [google_service_account.cloudsql_scheduler, google_project_iam_member.cloudsql_scheduler_iam_member]
}

# Cloud SQLを停止するjob
resource "google_cloud_scheduler_job" "stop_db" {
  name             = "stop-db-job"
  description      = "Job to stop Cloud SQL instance"
  schedule         = "0 23 * * 1-5"
  time_zone        = "Asia/Tokyo"
  attempt_deadline = "30s"
  paused           = false
  http_target {
    http_method = "PATCH"
    uri         = "https://sqladmin.googleapis.com/sql/v1beta4/projects/${var.project}/instances/${google_sql_database_instance.db_instance.id}"
    headers = {
      Content-Type = "application/json"
    }
    body = base64encode(jsonencode({
      "settings" = {
        "activationPolicy" = "NEVER",
      }
    }))
    oauth_token {
      service_account_email = google_service_account.cloudsql_scheduler.email
    }
  }

  depends_on = [google_service_account.cloudsql_scheduler, google_project_iam_member.cloudsql_scheduler_iam_member]
}

# Cloud Scheduler 用のサービス アカウントを作成し、Cloud SQL 用のロールを付与
resource "google_service_account" "cloudsql_scheduler" {
  account_id   = "cloudsql-scheduler-sa"
  description  = "Cloud Scheduler service account; used to trigger scheduled Cloud Run jobs."
  display_name = "cloudsql-scheduler-sa"

  # Use an explicit depends_on clause to wait until API is enabled
  depends_on = [
    google_project_service.service
  ]
}

resource "google_project_iam_member" "cloudsql_scheduler_iam_member" {
  for_each = {
    "cloudschedulerServiceAgent" = "roles/cloudscheduler.serviceAgent",
    "cloudsqlEditor"             = "roles/cloudsql.editor"
  }

  project = var.project
  role    = each.value
  member  = google_service_account.cloudsql_scheduler.member
}