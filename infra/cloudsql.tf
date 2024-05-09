resource "google_sql_database_instance" "db_instance" {
  name             = "main"
  database_version = "MYSQL_8_0_36"
  region           = var.region
  settings {
    tier = "db-f1-micro"
  }
}

resource "google_sql_database" "db" {
  name     = "main_db"
  instance = google_sql_database_instance.db_instance.name
}

resource "random_password" "db_password" {
  length  = 20
  special = true
}

resource "google_sql_user" "example_user" {
  name     = "user"
  instance = google_sql_database_instance.db_instance.name
  password = random_password.db_password.result
  host     = "%"
}