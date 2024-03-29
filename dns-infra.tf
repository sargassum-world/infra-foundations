resource "desec_domain" "infra" {
  name = "infra.sargassum.world"
}

# Services

resource "desec_rrset" "service_nomad_a" {
  domain  = desec_domain.infra.name
  subname = "nomad.s"
  type    = "A"
  # This should be the list of IP addresses of all orchestrators
  # TODO: automatically generate this by iterating through all VMs and figuring
  # out which ones have the "orchestrator" nomad role
  records = [module.orchestrator_gcp_us_west1_a_1.public_ipv4]
  ttl     = 3600
}

# We don't publish an IPv4 address because the Nomad server only listens on IPv6
# resource "desec_rrset" "service_foundations_nomad_a" {
#   domain  = module.zerotier_network_foundations.name_parent_domain
#   subname = "nomad.d.${module.zerotier_network_foundations.name_subname}"
#   type    = "A"
#   records = module.orchestrator_gcp_us_west1_a_1.zerotier_ipv4
#   ttl     = 3600
# }

resource "desec_rrset" "service_foundations_nomad_aaaa" {
  domain  = module.zerotier_network_foundations.name_parent_domain
  subname = "nomad.d.${module.zerotier_network_foundations.name_subname}"
  type    = "AAAA"
  # This should be the list of IP addresses of all orchestrators
  # TODO: automatically generate this by iterating through all VMs and figuring
  # out which ones have the "orchestrator" nomad role
  records = module.orchestrator_gcp_us_west1_a_1.zerotier_ipv6
  ttl     = 3600
}
