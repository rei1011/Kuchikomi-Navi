variable "project" {
  default = "rapid-stage-422403-r2"
}
variable "project_num" {
  default = "786726743523"
}

# 無料枠では東京regionが使用できないサービスが存在するため台湾を指定
variable "region" {
  default = "asia-east1"
}

variable "zone" {
  default = "asia-east1-a"
}

variable "github_owner" {
  default = "rei1011"
}

variable "github_app_repo_name" {
  default = "Kuchikomi-Navi"
}

variable "frontend_app_name" {
  default = "frontend-app"
}

variable "frontend_image_name" {
  default = "frontend-app"
}

variable "gcp-creds" {
  default = ""
}

variable "gh-token" {
  default = ""
}

variable "app_installation_id" {
  default = 50451179
}

variable "db-password" {
  default = ""
}