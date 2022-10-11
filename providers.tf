provider "local" {}

provider "zerotier" {
  zerotier_central_token = var.zerotier_central_api_token
}

provider "desec" {
  api_token = var.desec_api_token
}

provider "google" {
  project = var.gcp_project_id
  region  = "us-west1"
  zone    = "us-west1-a"
}

provider "nomad" {
  address   = "http://${google_compute_instance.us_west1_a_1.network_interface.0.access_config.0.nat_ip}:4646"
  secret_id = var.nomad_secret_id
}
