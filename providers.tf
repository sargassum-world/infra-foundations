provider "zerotier" {}

provider "google" {
  project = var.gcp_project_id
  region  = "us-west1"
  zone    = "us-west1-a"
}

provider "nomad" {
  address   = "https://${google_compute_address.us_west1_a_1.address}:4646"
  secret_id = var.nomad_secret_id
}
