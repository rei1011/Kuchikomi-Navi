# 以下を参考にCloud BuildとGitHubのrepositoryを接続
# https://cloud.google.com/build/docs/automating-builds/github/connect-repo-github?hl=ja&generation=2nd-gen#terraform_1

resource "google_artifact_registry_repository" "frontend-app" {
  location      = var.region
  repository_id = var.frontend_app_name
  description   = "frontend app"
  format        = "DOCKER"
}

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

resource "google_cloudbuild_trigger" "frontend_app_trigger" {
  location = var.region
  repository_event_config {
    repository = google_cloudbuildv2_repository.github_repository.id
    push {
      branch = "^main$"
    }
  }
  filename = "infra/cloudbuild.yaml"

  substitutions = {
    _REGION                         = var.region
    _ARTIFACT_REPOSITORY_IMAGE_NAME = "${var.region}-docker.pkg.dev/${var.project}/${var.frontend_app_name}/${var.frontend_image_name}"
  }
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