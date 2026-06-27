resource "google_container_cluster" "signal" {
  name     = "signal-${var.environment}"
  location = var.region

  remove_default_node_pool = true
  initial_node_count       = 1

  network    = var.network
  subnetwork = var.subnetwork

  workload_identity_config {
    workload_pool = "${var.project_id}.svc.id.goog"
  }
}

resource "google_container_node_pool" "signal_nodes" {
  name       = "signal-node-pool"
  location   = var.region
  cluster    = google_container_cluster.signal.name
  node_count = var.node_count

  autoscaling {
    min_node_count = 2
    max_node_count = 5
  }

  node_config {
    machine_type = var.machine_type
    disk_size_gb = 50

    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]

    labels = {
      environment = var.environment
      app         = "signal"
    }
  }
}
