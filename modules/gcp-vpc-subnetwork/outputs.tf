output "name" {
  description = "Name of the instance"
  value       = var.name
}

output "gcp_subnetwork_id" {
  description = "ID of the GCP VPC subnetwork"
  value       = google_compute_subnetwork.subnetwork.id
}
