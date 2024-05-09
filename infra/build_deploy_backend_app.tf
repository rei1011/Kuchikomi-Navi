variable "secret_id" {
  default = "rails_master_key"
}

# railsのmaster keyを保存するためのSecret Managerを作成
resource "google_secret_manager_secret" "rails_secret" {
  secret_id = var.secret_id
  replication {
    auto {}
  }
  depends_on = [google_project_service.service]
}
resource "google_secret_manager_secret_version" "rails_secret_version" {
  secret      = google_secret_manager_secret.rails_secret.id
  secret_data = var.rails-master-key
  depends_on  = [google_project_service.service]
}

# Cloud Runからシークレットへのアクセス権を付与
resource "google_secret_manager_secret_iam_binding" "cloudrun_secret_iam_binding" {
  secret_id = var.secret_id
  role      = "roles/secretmanager.secretAccessor"
  members   = ["serviceAccount:${var.project_num}-compute@developer.gserviceaccount.com"]
}

# Cloud Buildからシークレットへのアクセス権を付与
resource "google_secret_manager_secret_iam_binding" "cloudbuild_secret_iam_binding" {
  secret_id = var.secret_id
  role      = "roles/secretmanager.secretAccessor"
  members   = ["serviceAccount:${var.project_num}@cloudbuild.gserviceaccount.com"]
}

# Cloud Build に Cloud SQL へのアクセス権を付与
resource "google_project_iam_binding" "name" {
  project = var.project
  role    = "roles/cloudsql.client"
  members = ["serviceAccount:${var.project_num}@cloudbuild.gserviceaccount.com"]
}