resource "desec_domain" "root" {
  name = "sargassum.world"
}

# Sub-Zones

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

# Services

resource "desec_rrset" "device_gcp_us_west1_a_1_services_wildcard_a" {
  domain  = desec_domain.root.name
  subname = "*.s"
  type    = "A"
  records = [google_compute_address.us_west1_a_1.address]
  ttl     = 3600
}

# HTTPS DNS Challenge
# Needed for HTTPS with *.s.sargassum.world

# FIXME: Are there any security holes with this approach compared to using Caddy for the DNS challenge?
resource "acme_certificate" "root_wildcards" {
  account_key_pem           = acme_registration.dns.account_key_pem
  common_name               = desec_domain.root.name
  subject_alternative_names = ["*.s.${desec_domain.root.name}"]

  dns_challenge {
    provider = "desec"
    config = {
      DESEC_TOKEN = var.desec_api_token
      DESEC_TTL   = 3600
    }
  }
}

# SendGrid DNS challenge
# Needed for fider.sargassum.world

resource "desec_rrset" "sendgrid_cname" {
  domain  = desec_domain.root.name
  subname = "em7308"
  type    = "CNAME"
  records = ["u29124363.wl114.sendgrid.net."]
  ttl     = 3600
}

# Needed for fider.sargassum.world
resource "desec_rrset" "sendgrid1_cname" {
  domain  = desec_domain.root.name
  subname = "s1._domainkey"
  type    = "CNAME"
  records = ["s1.domainkey.u29124363.wl114.sendgrid.net."]
  ttl     = 3600
}

# Needed for fider.sargassum.world
resource "desec_rrset" "sendgrid2_cname" {
  domain  = desec_domain.root.name
  subname = "s2._domainkey"
  type    = "CNAME"
  records = ["s2.domainkey.u29124363.wl114.sendgrid.net."]
  ttl     = 3600
}
