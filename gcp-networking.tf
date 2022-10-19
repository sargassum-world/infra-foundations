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
