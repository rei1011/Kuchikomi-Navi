# 以下を参考にCloud BuildとGitHubのrepositoryを接続
# https://cloud.google.com/build/docs/automating-builds/github/connect-repo-github?hl=ja&generation=2nd-gen#terraform_1

# frontend appのimageを保存するためのregistryを作成
resource "google_artifact_registry_repository" "frontend-app" {
  location      = var.region
  repository_id = var.frontend_app_name
  description   = "frontend app"
  format        = "DOCKER"
}

# Basic認証のユーザー名を保存するためのSecret Managerを作成
resource "google_secret_manager_secret" "basic_auth_user" {
  secret_id = var.basic_auth_user_id
  replication {
    auto {}
  }
  depends_on = [google_project_service.service]
}
resource "google_secret_manager_secret_version" "basic_auth_user_version" {
  secret      = google_secret_manager_secret.basic_auth_user.id
  secret_data = var.basic_auth_user
  depends_on  = [google_project_service.service]
}

# Cloud RunとCloud BuildにBasic認証のユーザー名へアクセするための権限を付与
resource "google_secret_manager_secret_iam_member" "basic_auth_user_secret_iam_member" {
  for_each = toset([
    "serviceAccount:${var.project_num}@cloudbuild.gserviceaccount.com",
    "serviceAccount:${var.project_num}-compute@developer.gserviceaccount.com",
  ])
  secret_id = var.basic_auth_user_id
  role      = "roles/secretmanager.secretAccessor"
  member    = each.value

  depends_on = [google_secret_manager_secret.basic_auth_user, google_secret_manager_secret_version.basic_auth_user_version]
}

# Basic認証のパスワードを保存するためのSecret Managerを作成
resource "google_secret_manager_secret" "basic_auth_password" {
  secret_id = var.basic_auth_password_id
  replication {
    auto {}
  }
  depends_on = [google_project_service.service]
}
resource "google_secret_manager_secret_version" "basic_auth_password_version" {
  secret      = google_secret_manager_secret.basic_auth_password.id
  secret_data = var.basic_auth_password
  depends_on  = [google_project_service.service]
}

# Cloud RunとCloud BuildにBasic認証のパスワードへアクセするための権限を付与
resource "google_secret_manager_secret_iam_member" "basic_auth_password_secret_iam_member" {
  for_each = toset([
    "serviceAccount:${var.project_num}@cloudbuild.gserviceaccount.com",
    "serviceAccount:${var.project_num}-compute@developer.gserviceaccount.com",
  ])
  secret_id = var.basic_auth_password_id
  role      = "roles/secretmanager.secretAccessor"
  member    = each.value

  depends_on = [google_secret_manager_secret.basic_auth_password, google_secret_manager_secret_version.basic_auth_password_version]
}

# mainブランチのコミットを検知してimageのビルド & registryへimageのpush & Cloud Runへのデプロイを実行
resource "google_cloudbuild_trigger" "frontend_app_trigger" {
  name     = "${var.frontend_app_name}-trigger"
  location = var.region
  repository_event_config {
    repository = google_cloudbuildv2_repository.github_repository.id
    push {
      branch = "^main$"
    }
  }
  filename = "infra/frontend_cloudbuild.yaml"

  substitutions = {
    _REGION                         = var.region
    _ARTIFACT_REPOSITORY_IMAGE_NAME = "${var.region}-docker.pkg.dev/${var.project}/${var.frontend_app_name}/${var.frontend_image_name}"
    _SERVICE_NAME                   = var.frontend_app_name
    _BASIC_AUTH_USER_ID             = var.basic_auth_user_id
    _BASIC_AUTH_PASSWORD_ID         = var.basic_auth_password_id
  }
}