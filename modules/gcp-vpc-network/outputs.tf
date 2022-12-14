output "name" {
  description = "Name of the network"
  value       = var.name
}

output "gcp_network_id" {
  description = "ID of the GCP VPC network"
  value       = google_compute_network.network.id
}

output "gcp_network_self_link" {
  description = "Self-link of the GCP VPC network"
  value       = google_compute_network.network.self_link
}
