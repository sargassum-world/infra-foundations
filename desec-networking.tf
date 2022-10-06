# Root
#
resource "desec_domain" "root" {
  name = "sargassum.world"
}

resource "desec_rrset" "infra_ds" {
  domain  = desec_domain.root.name
  subname = "infra"
  type    = "DS"
  records = [
    "23015 13 2 3ded016af87b9a6627d269d5b160e384d5f25b9daf84803b14122ddd1628661b",
    "23015 13 4 1955d438ee865700d761d741d8a279dfc5ff1d488614cd70cea585b89fea2be1360333e7eb29f319acd95e55ac5ba94d",
  ]
  ttl = 3600
}

# Verification

resource "desec_rrset" "sendgrid_cname" {
  domain  = desec_domain.root.name
  subname = "em7308"
  type    = "CNAME"
  records = ["u29124363.wl114.sendgrid.net."]
  ttl     = 3600
}

resource "desec_rrset" "sendgrid1_cname" {
  domain  = desec_domain.root.name
  subname = "s1._domainkey"
  type    = "CNAME"
  records = ["s1.domainkey.u29124363.wl114.sendgrid.net."]
  ttl     = 3600
}

resource "desec_rrset" "sendgrid2_cname" {
  domain  = desec_domain.root.name
  subname = "s2._domainkey"
  type    = "CNAME"
  records = ["s2.domainkey.u29124363.wl114.sendgrid.net."]
  ttl     = 3600
}

# Unmigrated Services

resource "desec_rrset" "fluitans_caprover_a" {
  domain  = desec_domain.root.name
  subname = "*.cloud.fluitans"
  type    = "A"
  records = ["49.12.214.144"]
  ttl     = 3600
}

resource "desec_rrset" "fluitans_caprover_aaaa" {
  domain  = desec_domain.root.name
  subname = "*.cloud.fluitans"
  type    = "AAAA"
  records = ["2a01:4f8:c010:a153::"]
  ttl     = 3600
}

resource "desec_rrset" "syngnathus_caprover_a" {
  domain  = desec_domain.root.name
  subname = "*.cloud.syngnathus"
  type    = "A"
  records = ["35.212.249.95"]
  ttl     = 3600
}

resource "desec_rrset" "fluitans_a" {
  domain  = desec_domain.root.name
  subname = "fluitans"
  type    = "A"
  records = ["49.12.214.144"]
  ttl     = 3600
}

resource "desec_rrset" "fluitans_aaaa" {
  domain  = desec_domain.root.name
  subname = "fluitans"
  type    = "AAAA"
  records = ["2a01:4f8:c010:a153::"]
  ttl     = 3600
}

resource "desec_rrset" "live_a" {
  domain  = desec_domain.root.name
  subname = "live"
  type    = "A"
  records = ["35.212.249.95"]
  ttl     = 3600
}

resource "desec_rrset" "fider_a" {
  domain  = desec_domain.root.name
  subname = "fider"
  type    = "A"
  records = ["49.12.214.144"]
  ttl     = 3600
}

resource "desec_rrset" "fider_aaaa" {
  domain  = desec_domain.root.name
  subname = "fider"
  type    = "AAAA"
  records = ["2a01:4f8:c010:a153::"]
  ttl     = 3600
}

# Infra

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
