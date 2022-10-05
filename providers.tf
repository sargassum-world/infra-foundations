provider "tfe" {}

provider "zerotier" {}

provider "google" {
  project = var.gcp_project_id
  region  = "us-west1"
  zone    = "us-west1-a"
}

provider "nomad" {
  address = "https://${google_compute_address.us_west1_a_1.address}:4646"
  # Note: the Nomad server should be locked down with the ACL system, e.g. with the NOMAD_TOKEN
  # environment variable
}
