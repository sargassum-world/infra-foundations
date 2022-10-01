provider "zerotier" {}

provider "google" {
  project = var.gcp_project_id
  region  = "us-west1"
  zone    = "us-west1-a"
}

