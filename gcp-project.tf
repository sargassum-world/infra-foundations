# Note: depends on google_project_service.cloudbilling
resource "google_project" "foundations" {
  name                = var.gcp_project_id
  project_id          = var.gcp_project_id
  billing_account     = var.gcp_billing_account_id
  auto_create_network = false
}
