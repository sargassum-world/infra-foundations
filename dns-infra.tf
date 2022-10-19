resource "desec_domain" "infra" {
  name = "infra.sargassum.world"
}

# Services

resource "desec_rrset" "service_nomad_a" {
  domain  = desec_domain.infra.name
  subname = "nomad.s"
  type    = "A"
  records = [module.orchestrator_gcp_us_west1_a_1.public_ipv4]
  ttl     = 3600
}
