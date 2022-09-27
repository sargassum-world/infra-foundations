provider "zerotier" {}

provider "google" {
  project = var.gcp-project-id
  region  = "us-west1"
  zone    = "us-west1-a"
}

