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

variable "acme_server" {
  type        = string
  description = "ACME CA server API path"
}

variable "acme_email" {
  type        = string
  description = "Contact email address for ACME registration"
}

variable "gcp_credentials" {
  type        = string
  description = "GCP account credentials for authentication"
}

variable "gcp_billing_account_id" {
  type        = string
  description = "GCP billing account ID for the main GCP project"
}

variable "gcp_project_id" {
  type        = string
  description = "GCP project ID for the main GCP project"
}

variable "gcp_vm_orchestrator_image" {
  type        = string
  description = "Orchestrator VM image for the main GCP project"
}

variable "gcp_planktoscope_credentials" {
  type        = string
  description = "GCP account credentials for authentication for the Planktoscope-supported GCP project"
}

variable "gcp_planktoscope_billing_account_id" {
  type        = string
  description = "GCP billing account ID for the Planktoscope-supported GCP project"
}

variable "gcp_planktoscope_project_id" {
  type        = string
  description = "GCP project ID for the Planktoscope-supported GCP project"
}

variable "gcp_planktoscope_vm_worker_image" {
  type        = string
  description = "Worker VM image for the Planktoscope-supported GCP project"
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

variable "dns_root" {
  type        = string
  description = "Root domain name"
}

variable "dns_infra_ds" {
  type        = list(string)
  description = "DS records for the infra subname under the root domain name"
}
