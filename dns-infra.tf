resource "desec_domain" "infra" {
  name = "infra.sargassum.world"
}

# Services

resource "desec_rrset" "service_nomad_a" {
  domain  = desec_domain.infra.name
  subname = "nomad.s"
  type    = "A"
  records = [
    module.orchestrator_gcp_us_west1_a_1.public_ipv4,
    module.worker_gcp_us_west1_a_2.public_ipv4,
  ]
  ttl = 3600
}

resource "desec_rrset" "service_foundations_nomad_a" {
  domain  = module.zerotier_network_foundations.name_parent_domain
  subname = "nomad.d.${module.zerotier_network_foundations.name_subname}"
  type    = "A"
  records = [module.orchestrator_gcp_us_west1_a_1.zerotier_ipv4]
  ttl     = 3600
}

resource "desec_rrset" "service_foundations_nomad_aaaa" {
  domain  = module.zerotier_network_foundations.name_parent_domain
  subname = "nomad.d.${module.zerotier_network_foundations.name_subname}"
  type    = "AAAA"
  records = [module.orchestrator_gcp_us_west1_a_1.zerotier_ipv6]
  ttl     = 3600
}
