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

# ZeroTier Network

resource "desec_rrset" "zerotier" {
  domain  = desec_domain.infra.name
  subname = "foundations"
  type    = "TXT"
  records = ["\"zerotier-net-id=${zerotier_network.foundations.id}\""]
  ttl     = 3600
}
