# Also depends on the following environment variables:
# GOOGLE_CREDENTIALS

variable "zerotier_central_api_token" {
  type        = string
  description = "API access token for ZeroTier Central"
  sensitive   = true
}

variable "desec_api_token" {
  type        = string
  description = "API token for deSEC"
  sensitive   = true
}

variable "gcp_billing_account_id" {
  type        = string
  description = "GCP billing account ID"
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
