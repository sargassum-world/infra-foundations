# GCP us-west1-a-1

locals {
  subname_zerotier_device_gcp_us_west1_a_1 = "gcp-us-west1-a-1.d.${desec_rrset.zerotier_txt.subname}"
}

resource "desec_rrset" "zerotier_device_gcp_us_west1_a_1_a" {
  domain  = desec_domain.infra.name
  subname = local.subname_zerotier_device_gcp_us_west1_a_1
  type    = "A"
  records = zerotier_member.gcp_us_west1_a_1.ip_assignments
  ttl     = 3600
}

resource "desec_rrset" "zerotier_device_gcp_us_west1_a_1_aaaa" {
  domain  = desec_domain.infra.name
  subname = local.subname_zerotier_device_gcp_us_west1_a_1
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

# GCP us-west1-a-1 Services

resource "desec_rrset" "zerotier_device_gcp_us_west1_a_1_services_wildcard_a" {
  domain  = desec_domain.infra.name
  subname = "*.s.${local.subname_zerotier_device_gcp_us_west1_a_1}"
  type    = "A"
  records = desec_rrset.zerotier_device_gcp_us_west1_a_1_a.records
  ttl     = 3600
}

resource "desec_rrset" "zerotier_device_gcp_us_west1_a_1_services_wildcard_aaaa" {
  domain  = desec_domain.infra.name
  subname = "*.s.${local.subname_zerotier_device_gcp_us_west1_a_1}"
  type    = "AAAA"
  records = desec_rrset.zerotier_device_gcp_us_west1_a_1_aaaa.records
  ttl     = 3600
}
