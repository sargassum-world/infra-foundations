# Main Project

module "vpc_network" {
  source = "./modules/gcp-vpc-network"

  name = "foundations"

  depends_on = [
    google_project_service.iap
  ]
}

module "vpc_subnetwork_gcp_us_west1" {
  source = "./modules/gcp-vpc-subnetwork"

  name           = "foundations-us-west1"
  gcp_network_id = module.vpc_network.gcp_network_id
  gcp_region     = "us-west1"
  ipv4_cidr      = "10.64.0.0/24"
}

# Planktoscope Project

module "vpc_network_planktoscope" {
  source = "./modules/gcp-vpc-network"

  name = "foundations"

  depends_on = [
    google_project_service.iap_planktoscope
  ]

  providers = {
    google = google.planktoscope
  }
}

module "vpc_subnetwork_planktoscope_gcp_us_west1" {
  source = "./modules/gcp-vpc-subnetwork"

  name           = "foundations-us-west1"
  gcp_network_id = module.vpc_network_planktoscope.gcp_network_id
  gcp_region     = "us-west1"
  ipv4_cidr      = "10.64.64.0/24"

  providers = {
    google = google.planktoscope
  }
}

# Network Peering

resource "google_compute_network_peering" "main_planktoscope" {
  name         = "main-planktoscope"
  network      = module.vpc_network.gcp_network_self_link
  peer_network = module.vpc_network_planktoscope.gcp_network_self_link
}

resource "google_compute_network_peering" "planktoscope_main" {
  provider     = google.planktoscope
  name         = "planktoscope-main"
  network      = module.vpc_network_planktoscope.gcp_network_self_link
  peer_network = module.vpc_network.gcp_network_self_link
}
