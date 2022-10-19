resource "desec_rrset" "zerotier_txt" {
  domain  = desec_domain.infra.name
  subname = "foundations"
  type    = "TXT"
  records = ["\"zerotier-net-id=${zerotier_network.foundations.id}\""]
  ttl     = 3600
}

# Services (with HTTPS reverse proxying through gcp-us-west1-a-1)

resource "desec_rrset" "zerotier_wildcard_a" {
  domain  = desec_domain.infra.name
  subname = "*.s.foundations"
  type    = "A"
  records = [module.orchestrator_gcp_us_west1_a_1.zerotier_ipv4]
  ttl     = 3600
}

resource "desec_rrset" "zerotier_wildcard_aaaa" {
  domain  = desec_domain.infra.name
  subname = "*.s.foundations"
  type    = "AAAA"
  records = [module.orchestrator_gcp_us_west1_a_1.zerotier_ipv6]
  ttl     = 3600
}

# HTTPS DNS Challenge
# Needed for HTTPS with *.s.infra.sargassum.world and *.d.infra.sargassum.world

# Right now we're using this because Caddy can't solve HTTP or TLS-ALPN challenges from the ZeroTier network
# FIXME: Are there any security holes with this approach compared to using Caddy for the DNS challenge?
resource "acme_certificate" "zerotier_wildcards" {
  account_key_pem = acme_registration.main.account_key_pem
  common_name     = desec_domain.infra.name
  subject_alternative_names = [
    "*.s.foundations.${desec_domain.infra.name}",
    "*.s.${module.orchestrator_gcp_us_west1_a_1.dns_zerotier_subname}.${desec_domain.infra.name}",
  ]

  dns_challenge {
    provider = "desec"
    config = {
      DESEC_TOKEN = var.desec_api_token
      DESEC_TTL   = 3600
    }
  }
}
