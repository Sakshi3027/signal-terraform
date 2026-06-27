resource "google_sql_database_instance" "signal" {
  name             = "signal-postgres-${var.environment}"
  database_version = "POSTGRES_16"
  region           = var.region

  settings {
    tier = var.tier

    backup_configuration {
      enabled    = true
      start_time = "02:00"
    }

    ip_configuration {
      ipv4_enabled    = false
      private_network = var.network_id
    }

    database_flags {
      name  = "max_connections"
      value = "100"
    }
  }

  deletion_protection = false
}

resource "google_sql_database" "signal" {
  name     = "signal"
  instance = google_sql_database_instance.signal.name
}

resource "google_sql_user" "signal" {
  name     = "signal"
  instance = google_sql_database_instance.signal.name
  password = var.db_password
}
