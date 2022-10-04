provider "tfe" {}

provider "zerotier" {}

provider "google" {
  project = var.gcp_project_id
  region  = "us-west1"
  zone    = "us-west1-a"
}

provider "nomad" {
  address = "https://${google_compute_instance.us_west1_a_1.network_interface[0].network_ip}:4646"
}
