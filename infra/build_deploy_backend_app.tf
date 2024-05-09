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
# Cloud RunとCloud Buildにrailsのmaster keyへアクセするための権限を付与
resource "google_secret_manager_secret_iam_member" "secret_iam_member" {
  for_each = toset([
    "serviceAccount:${var.project_num}@cloudbuild.gserviceaccount.com",
    "serviceAccount:${var.project_num}-compute@developer.gserviceaccount.com",
  ])
  secret_id = var.secret_id
  role      = "roles/secretmanager.secretAccessor"
  member    = each.value
}

# Cloud Build に Cloud SQL へのアクセス権を付与
resource "google_project_iam_member" "name" {
  project = var.project
  role    = "roles/cloudsql.client"
  member  = "serviceAccount:${var.project_num}@cloudbuild.gserviceaccount.com"
}

# mainブランチのコミットを検知してimageのビルド & registryへimageのpush & Cloud Runへのデプロイを実行
resource "google_cloudbuild_trigger" "backend_app_trigger" {
  name     = "${var.backend_app_name}-trigger"
  location = var.region
  repository_event_config {
    repository = google_cloudbuildv2_repository.github_repository.id
    push {
      branch = "^main$"
    }
  }
  filename = "infra/backend_cloudbuild.yaml"
}