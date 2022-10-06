resource "desec_domain" "infra" {
  name = "infra.sargassum.world"
}

# Virtual Machines

resource "desec_rrset" "gcp_us_west1_a_1_a" {
  domain  = desec_domain.infra.name
  subname = "gcp-us-west1-a-1"
  type    = "A"
  records = [google_compute_address.us_west1_a_1.address]
  ttl     = 3600
}

# Zerotier Network

resource "desec_rrset" "zerotier" {
  domain  = desec_domain.infra.name
  subname = "foundations"
  type    = "TXT"
  records = ["\"zerotier-net-id=${zerotier_network.foundations.id}\""]
  ttl     = 3600
}

resource "desec_rrset" "zerotier_gcp_us_west1_a_1_a" {
  domain  = desec_domain.infra.name
  subname = "gcp-us-west1-a-1.d.foundations"
  type    = "A"
  records = zerotier_member.gcp_us_west1_a_1.ip_assignments
  ttl     = 3600
}

resource "desec_rrset" "zerotier_gcp_us_west1_a_1_aaaa" {
  domain  = desec_domain.infra.name
  subname = "gcp-us-west1-a-1.d.foundations"
  type    = "AAAA"
  records = [join(":", [
    for chunk in chunklist(split(
      "",
      "fd${zerotier_network.foundations.id}9993${zerotier_identity.gcp_us_west1_a_1.id}"
    ), 4) :
    join("", chunk)
  ])]
  ttl = 3600
}
