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
  role    = each.value
  member  = "serviceAccount:${var.project_num}@cloudbuild.gserviceaccount.com"
  project = var.project
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
