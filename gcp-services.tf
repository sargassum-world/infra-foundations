# Note: the Service Usage API and Cloud Resource Manager API must first be manually enabled.
# Also, the service account should have the editor role.

# Main Project

resource "google_project_service" "cloudbilling" {
  service = "cloudbilling.googleapis.com"
}

resource "google_project_service" "iam" {
  service = "iam.googleapis.com"
}

resource "google_project_service" "cloudkms" {
  service = "cloudkms.googleapis.com"
}

resource "google_project_service" "compute" {
  service = "compute.googleapis.com"
}

resource "google_project_service" "iap" {
  service = "iap.googleapis.com"
}

# Planktoscope Project

resource "google_project_service" "cloudbilling_planktoscope" {
  provider = google.planktoscope
  service  = "cloudbilling.googleapis.com"
}

resource "google_project_service" "iam_planktoscope" {
  provider = google.planktoscope
  service  = "iam.googleapis.com"
}

resource "google_project_service" "cloudkms_planktoscope" {
  provider = google.planktoscope
  service  = "cloudkms.googleapis.com"
}

resource "google_project_service" "compute_planktoscope" {
  provider = google.planktoscope
  service  = "compute.googleapis.com"
}

resource "google_project_service" "iap_planktoscope" {
  provider = google.planktoscope
  service  = "iap.googleapis.com"
}
