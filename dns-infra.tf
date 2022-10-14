resource "desec_domain" "infra" {
  name = "infra.sargassum.world"
}

# Services

resource "desec_rrset" "service_nomad_a" {
  domain  = desec_domain.infra.name
  subname = "nomad.s"
  type    = "A"
  records = [google_compute_address.us_west1_a_1.address]
  ttl     = 3600
}
