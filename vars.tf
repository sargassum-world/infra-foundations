# Also depends on the following environment variables:
# ZEROTIER_CENTRAL_TOKEN
# GOOGLE_CREDENTIALS
# HCLOUD_TOKEN

variable "gcp-project-id" {
  type        = string
  description = "GCP project ID"
}
