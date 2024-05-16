# backend appのimageを保存するためのregistryを作成
resource "google_artifact_registry_repository" "backend_app" {
  location      = var.region
  repository_id = var.backend_app_name
  description   = "backend app"
  format        = "DOCKER"
}

# railsのmaster keyを保存するためのSecret Managerを作成
resource "google_secret_manager_secret" "rails_secret" {
  secret_id = var.rails_secret_id
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
  secret_id = var.rails_secret_id
  role      = "roles/secretmanager.secretAccessor"
  member    = each.value

  depends_on = [google_secret_manager_secret.rails_secret, google_secret_manager_secret_version.rails_secret_version]
}

# Cloud SQLへ接続するためのパスワードを保存するためのSecret Managerを作成
resource "google_secret_manager_secret" "database_password_secret" {
  secret_id = var.database_password_key
  replication {
    auto {}
  }
  depends_on = [google_project_service.service]
}
resource "google_secret_manager_secret_version" "database_password_secret_version" {
  secret      = google_secret_manager_secret.database_password_secret.id
  secret_data = var.db-password
  depends_on  = [google_project_service.service]
}

# Cloud RunとCloud BuildにCloud SQLのパスワードへアクセするための権限を付与
resource "google_secret_manager_secret_iam_member" "database_password_secret_iam_member" {
  for_each = toset([
    "serviceAccount:${var.project_num}@cloudbuild.gserviceaccount.com",
    "serviceAccount:${var.project_num}-compute@developer.gserviceaccount.com",
  ])
  secret_id  = var.database_password_key
  role       = "roles/secretmanager.secretAccessor"
  member     = each.value
  depends_on = [google_secret_manager_secret.database_password_secret, google_secret_manager_secret_version.database_password_secret_version]
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

  substitutions = {
    _SECRET_NAME                    = var.rails_secret_id
    _SERVICE_NAME                   = var.backend_app_name
    _REGION                         = var.region
    _DATABASE_NAME                  = var.database_name
    _DATABASE_USER                  = var.db-user
    _DATABASE_SOCKET                = "/cloudsql/${var.project}:${var.region}:${var.database_instance_name}"
    _ARTIFACT_REPOSITORY_IMAGE_NAME = "${var.region}-docker.pkg.dev/${var.project}/${var.backend_app_name}/${var.backend_app_name}"
    _DATABASE_PASSWORD_KEY          = var.database_password_key
    _INSTANCE_NAME                  = var.database_instance_name
    _ALLOW_ORIGINS                  = "https://frontend-app-uuwuit3kva-de.a.run.app"
    _RUN_JOB                        = "false"
  }
}