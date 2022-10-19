resource "desec_rrset" "txt" {
  domain  = var.name_parent_domain
  subname = var.name_subname
  type    = "TXT"
  records = ["\"zerotier-net-id=${zerotier_network.network.id}\""]
  ttl     = 3600
}

# Services (with HTTPS reverse proxying through gcp-us-west1-a-1)

resource "desec_rrset" "services_wildcard_a" {
  domain  = var.name_parent_domain
  subname = "*.s.${var.name_subname}"
  type    = "A"
  records = var.service_reverse_proxies_ipv4
  ttl     = 3600
}

resource "desec_rrset" "services_wildcard_aaaa" {
  domain  = var.name_parent_domain
  subname = "*.s.${var.name_subname}"
  type    = "AAAA"
  records = var.service_reverse_proxies_ipv6
  ttl     = 3600
}

# HTTPS DNS Challenge
# Needed for HTTPS with *.s.infra.sargassum.world and *.d.infra.sargassum.world

# Right now we're using this because Caddy can't solve HTTP or TLS-ALPN challenges from the ZeroTier network
# FIXME: Are there any security holes with this approach compared to using Caddy for the DNS challenge?
resource "acme_certificate" "wildcards" {
  account_key_pem = var.acme_account_key
  common_name     = var.name_parent_domain
  subject_alternative_names = concat(
    ["*.s.${var.name_subname}.${var.name_parent_domain}"],
    [for subname in var.service_device_subnames : "*.s.${subname}.${var.name_parent_domain}"],
  )

  dns_challenge {
    provider = "desec"
    config = {
      DESEC_TOKEN = var.acme_desec_api_token
      DESEC_TTL   = 3600
    }
  }
}
