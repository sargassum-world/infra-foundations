# Also depends on the following environment variables:
# ZEROTIER_CENTRAL_TOKEN
# GOOGLE_CREDENTIALS
# HCLOUD_TOKEN

variable "gcp_project_id" {
  type        = string
  description = "GCP project ID"
}

variable "gcp_vm_orchestrator_image" {
  type        = string
  description = "Orchestrator VM image"
}
