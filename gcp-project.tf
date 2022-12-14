# Main Project

resource "google_project" "foundations" {
  name                = var.gcp_project_id
  project_id          = var.gcp_project_id
  billing_account     = var.gcp_billing_account_id
  auto_create_network = false

  depends_on = [
    google_project_service.cloudbilling
  ]
}

# Planktoscope Project

resource "google_project" "foundations_planktoscope" {
  provider            = google.planktoscope
  name                = var.gcp_planktoscope_project_id
  project_id          = var.gcp_planktoscope_project_id
  billing_account     = var.gcp_planktoscope_billing_account_id
  auto_create_network = false

  depends_on = [
    google_project_service.cloudbilling_planktoscope
  ]
}
