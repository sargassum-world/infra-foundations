# GCP us-west1-a-1

locals {
  subname_device_gcp_us_west1_a_1 = "gcp-us-west1-a-1.d"
}

resource "desec_rrset" "device_gcp_us_west1_a_1_a" {
  domain  = desec_domain.infra.name
  subname = local.subname_device_gcp_us_west1_a_1
  type    = "A"
  records = [google_compute_address.us_west1_a_1.address]
  ttl     = 3600
}

resource "desec_rrset" "device_gcp_us_west1_a_1_services_wildcard_a" {
  domain  = desec_domain.infra.name
  subname = "*.s.${local.subname_device_gcp_us_west1_a_1}"
  type    = "A"
  records = [google_compute_address.us_west1_a_1.address]
  ttl     = 3600
}
