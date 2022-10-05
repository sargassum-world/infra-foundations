# Also depends on the following environment variables:
# ZEROTIER_CENTRAL_TOKEN
# GOOGLE_CREDENTIALS
# HCLOUD_TOKEN

variable "desec_api_token" {
  type        = string
  description = "API token for deSEC"
  sensitive   = true
}

variable "gcp_project_id" {
  type        = string
  description = "GCP project ID"
}

variable "gcp_vm_orchestrator_image" {
  type        = string
  description = "Orchestrator VM image"
}

variable "nomad_secret_id" {
  type        = string
  description = "Secret ID for Nomad ACL token"
  sensitive   = true
}

variable "nomad_accessor_id" {
  type        = string
  description = "Accessor ID for Nomad ACL token"
}
