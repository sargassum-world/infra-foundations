// Also depends on the following environment variables:
// ZEROTIER_CENTRAL_TOKEN
// GOOGLE_CREDENTIALS
// HCLOUD_TOKEN


variable "gce_service_account" {
  type        = string
  description = "The Google Compute Engine service account (not the Terraform service account)"
}
