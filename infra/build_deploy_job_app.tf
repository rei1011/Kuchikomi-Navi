# jobのimageを保存するためのregistryを作成
resource "google_artifact_registry_repository" "job_app" {
  location      = var.region
  repository_id = var.job_app_name
  description   = "job app"
  format        = "DOCKER"
  cleanup_policy_dry_run = false
  cleanup_policies {
    id     = "delete"
    action = "DELETE"
    condition {
      tag_state    = "ANY"
    }
  }
  cleanup_policies {
    id     = "keep"
    action = "KEEP"
    most_recent_versions {
      keep_count            = 2
    }
  }
}

# mainブランチのコミットを検知してimageのビルド & registryへimageのpush & Cloud Runへのデプロイを実行
resource "google_cloudbuild_trigger" "job_app_trigger" {
  name     = "${var.job_app_name}-trigger"
  location = var.region
  repository_event_config {
    repository = google_cloudbuildv2_repository.github_repository.id
    push {
      branch = "^main$"
    }
  }
  filename = "infra/job_cloudbuild.yaml"

  substitutions = {
    _SECRET_NAME                    = var.rails_secret_id
    _SERVICE_NAME                   = var.job_app_name
    _REGION                         = var.region
    _DATABASE_NAME                  = var.database_name
    _DATABASE_USER                  = var.db-user
    _DATABASE_SOCKET                = "/cloudsql/${var.project}:${var.region}:${var.database_instance_name}"
    _ARTIFACT_REPOSITORY_IMAGE_NAME = "${var.region}-docker.pkg.dev/${var.project}/${var.job_app_name}/${var.job_app_name}"
    _DATABASE_PASSWORD_KEY          = var.database_password_key
    _INSTANCE_NAME                  = var.database_instance_name
    _RUN_JOB                        = "true"
  }
}