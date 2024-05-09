# railsアプリからアップロードされた画像などを保存
resource "google_storage_bucket" "example_bucket" {
  name     = "${var.project}_storage"
  location = var.region
}

# storageにアップロードした画像を全ユーザーが閲覧できるように公開
resource "google_storage_bucket_iam_member" "example_bucket_public_access" {
  bucket = "${var.project}_storage"
  role   = "roles/storage.objectViewer"
  member = "allUsers"
}