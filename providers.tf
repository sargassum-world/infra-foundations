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
  # address   = "http://${desec_rrset.service_nomad_a.subname}${desec_rrset.service_nomad_a.domain}:4646"
  address   = "http://gcp-us-west1-a-1.d.infra.sargassum.world:4646"
  secret_id = var.nomad_secret_id
}

provider "acme" {
  server_url = var.acme_server
}
