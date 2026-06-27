resource "google_compute_network" "signal_vpc" {
  name                    = "signal-vpc-${var.environment}"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "signal_subnet" {
  name          = "signal-subnet-${var.environment}"
  ip_cidr_range = "10.0.0.0/24"
  region        = var.region
  network       = google_compute_network.signal_vpc.id

  secondary_ip_range {
    range_name    = "pods"
    ip_cidr_range = "10.1.0.0/16"
  }

  secondary_ip_range {
    range_name    = "services"
    ip_cidr_range = "10.2.0.0/20"
  }
}

resource "google_compute_firewall" "allow_internal" {
  name    = "signal-allow-internal-${var.environment}"
  network = google_compute_network.signal_vpc.name

  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }

  source_ranges = ["10.0.0.0/8"]
}
