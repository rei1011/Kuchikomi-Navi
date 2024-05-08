# enableapo.sh(gcloud)で最初にAPIを有効化しているが、disable_dependent_services=trueが設定できないためtfで管理
resource "google_project_service" "service" {
  for_each = toset([
    "cloudapis.googleapis.com",
    "sql-component.googleapis.com",
    "sqladmin.googleapis.com",
    "run.googleapis.com",
    "compute.googleapis.com",
    "cloudbuild.googleapis.com",
    "secretmanager.googleapis.com",
    "artifactregistry.googleapis.com"
  ])
  service                    = each.value
  disable_dependent_services = true
}