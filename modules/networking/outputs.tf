output "network_name"    { value = google_compute_network.signal_vpc.name }
output "network_id"      { value = google_compute_network.signal_vpc.id }
output "subnetwork_name" { value = google_compute_subnetwork.signal_subnet.name }
