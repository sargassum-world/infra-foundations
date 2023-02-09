module "zerotier_network_foundations" {
  source = "./modules/zerotier-network"

  name_subname       = "foundations"
  name_parent_domain = desec_domain.infra.name

  zerotier_description      = "Control plane for the foundations of sargassum.world"
  zerotier_ipv6_sixplane    = true
  zerotier_ipv6_rfc4193     = false
  zerotier_flow_rules       = file("${path.module}/zerotier-networking-foundations.flowrules")
  zerotier_routed_ipv4_cidr = "10.144.64.0/24"

  service_reverse_proxies_ipv4 = setunion(
    module.orchestrator_gcp_us_west1_a_1.zerotier_ipv4,
    module.worker_gcp_us_west1_a_2.zerotier_ipv4,
  )
  service_reverse_proxies_ipv6 = setunion(
    module.orchestrator_gcp_us_west1_a_1.zerotier_ipv6,
    module.worker_gcp_us_west1_a_2.zerotier_ipv6,
  )
  service_device_subnames = [module.orchestrator_gcp_us_west1_a_1.dns_zerotier_subname]

  acme_account_key     = acme_registration.main.account_key_pem
  acme_desec_api_token = var.desec_api_token
}
