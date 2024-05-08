resource "google_artifact_registry_repository" "frontend-app" {
  location      = var.region
  repository_id = var.frontend_app_name
  description   = "frontend app"
  format        = "DOCKER"
}