# 以下を参考にCloud BuildとGitHubのrepositoryを接続
# https://cloud.google.com/build/docs/automating-builds/github/connect-repo-github?hl=ja&generation=2nd-gen#terraform_1

# frontend appのimageを保存するためのregistryを作成
resource "google_artifact_registry_repository" "frontend-app" {
  location      = var.region
  repository_id = var.frontend_app_name
  description   = "frontend app"
  format        = "DOCKER"
  cleanup_policies {
    id     = "delete"
    action = "DELETE"
    condition {
      tag_state = "ANY"
    }
  }
  cleanup_policies {
    id     = "keep"
    action = "KEEP"
    most_recent_versions {
      keep_count = 2
    }
  }
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