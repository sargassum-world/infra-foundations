output "name" {
  description = "Name of the network"
  value       = var.name
}

output "gcp_network_id" {
  description = "ID of the GCP VPC network"
  value       = google_compute_network.network.id
}
