resource "desec_domain" "infra" {
  name = "infra.sargassum.world"
}

resource "desec_rrset" "zerotier" {
  domain  = desec_domain.infra.name
  subname = ""
  type    = "TXT"
  records = ["\"zerotier-net-id=${zerotier_network.foundations.id}\""]
  ttl     = 3600
}

resource "desec_rrset" "gcp_us_west1_a_1_a" {
  domain  = desec_domain.infra.name
  subname = "gcp-us-west1-a-1"
  type    = "A"
  records = [google_compute_address.us_west1_a_1.address]
  ttl     = 3600
}
