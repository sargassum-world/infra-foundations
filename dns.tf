resource "desec_domain" "root" {
  name = var.dns_root
}

# Sub-Zones

resource "desec_rrset" "infra_ds" {
  domain  = desec_domain.root.name
  subname = "infra"
  type    = "DS"
  records = var.dns_infra_ds
  ttl     = 3600
}

# Services

resource "desec_rrset" "root_services_wildcard_a" {
  domain  = desec_domain.root.name
  subname = "*.s"
  type    = "A"
  records = [module.orchestrator_gcp_us_west1_a_1.public_ipv4]
  ttl     = 3600
}

# SendGrid DNS challenge
# Needed for fider.sargassum.world
# TODO: can we make Terraform obtain the subnames and records to set from SendGrid?

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
