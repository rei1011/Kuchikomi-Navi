resource "google_sql_database_instance" "db_instance" {
  name             = var.database_instance_name
  database_version = "MYSQL_8_0_36"
  region           = var.region
  settings {
    tier = "db-f1-micro"
  }
}

resource "google_sql_database" "db" {
  name     = var.database_name
  instance = google_sql_database_instance.db_instance.name
}

resource "google_sql_user" "example_user" {
  name     = var.db-user
  instance = google_sql_database_instance.db_instance.name
  password = var.db-password
  host     = "%"
}