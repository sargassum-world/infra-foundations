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

# HTTPS DNS Challenge
# Needed for HTTPS with *.s.infra.sargassum.world and *.d.infra.sargassum.world

# FIXME: Are there any security holes with this approach compared to using Caddy for the DNS challenge?
resource "acme_certificate" "infra_all_wildcards" {
  account_key_pem = acme_registration.main.account_key_pem
  common_name     = desec_domain.infra.name
  subject_alternative_names = [
    "*.s.${desec_domain.infra.name}",
    "*.s.gcp-us-west1-a-1.d.${desec_domain.infra.name}",
    "*.s.foundations.${desec_domain.infra.name}",
    "*.s.gcp-us-west1-a-1.d.foundations.${desec_domain.infra.name}",
  ]

  dns_challenge {
    provider = "desec"
    config = {
      DESEC_TOKEN = var.desec_api_token
      DESEC_TTL   = 3600
    }
  }
}
