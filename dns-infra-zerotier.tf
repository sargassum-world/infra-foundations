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
  records = desec_rrset.zerotier_device_gcp_us_west1_a_1_a.records
  ttl     = 3600
}

resource "desec_rrset" "zerotier_wildcard_aaaa" {
  domain  = desec_domain.infra.name
  subname = "*.s.foundations"
  type    = "AAAA"
  records = desec_rrset.zerotier_device_gcp_us_west1_a_1_aaaa.records
  ttl     = 3600
}
