# Note: this requires the Cloud Billing API to first be enabled
resource "google_project" "foundations" {
  name                = var.gcp_project_id
  project_id          = var.gcp_project_id
  billing_account     = var.gcp_billing_account_id
  auto_create_network = false
}
