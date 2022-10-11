resource "google_project" "foundations" {
  name                = var.gcp_project_id
  project_id          = var.gcp_project_id
  auto_create_network = false
}
