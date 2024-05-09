# Cloud BuildがGitHubへアクセするためのPATを管理
resource "google_secret_manager_secret" "github_token_secret" {
  secret_id = "github_token_secret"
  replication {
    auto {}
  }
  depends_on = [google_project_service.service]
}
resource "google_secret_manager_secret_version" "github_token_secret_version" {
  secret      = google_secret_manager_secret.github_token_secret.id
  secret_data = var.gh-token
  depends_on  = [google_project_service.service]
}

# Cloud BuildからSecret Managerに保存されているPATを取得できるように権限を付与
data "google_iam_policy" "serviceagent_secretAccessor" {
  binding {
    role    = "roles/secretmanager.secretAccessor"
    members = ["serviceAccount:service-${var.project_num}@gcp-sa-cloudbuild.iam.gserviceaccount.com"]
  }
}
resource "google_secret_manager_secret_iam_policy" "policy" {
  secret_id   = google_secret_manager_secret.github_token_secret.secret_id
  policy_data = data.google_iam_policy.serviceagent_secretAccessor.policy_data
  depends_on  = [google_project_service.service]
}

# Cloud BuildとGitHubを接続
resource "google_cloudbuildv2_connection" "cloudbuild-connection" {
  location = var.region
  name     = "cloudbuild-connection"

  github_config {
    app_installation_id = var.app_installation_id
    authorizer_credential {
      oauth_token_secret_version = google_secret_manager_secret_version.github_token_secret_version.id
    }
  }
  depends_on = [google_secret_manager_secret_iam_policy.policy]
}
resource "google_cloudbuildv2_repository" "github_repository" {
  location          = var.region
  name              = var.github_app_repo_name
  parent_connection = google_cloudbuildv2_connection.cloudbuild-connection.name
  remote_uri        = "https://github.com/${var.github_owner}/${var.github_app_repo_name}.git"
}

# Cloud BuildからCloud Runへデプロイするための権限を付与
resource "google_project_iam_member" "cloudbuild_iam" {
  for_each = toset([
    "roles/run.admin",
    "roles/iam.serviceAccountUser",
  ])
  role    = each.key
  member  = "serviceAccount:${var.project_num}@cloudbuild.gserviceaccount.com"
  project = var.project
}