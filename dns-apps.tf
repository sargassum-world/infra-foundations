resource "desec_rrset" "fluitans_a" {
  domain  = desec_domain.root.name
  subname = "fluitans"
  type    = "A"
  records = [module.orchestrator_gcp_us_west1_a_1.public_ipv4]
  ttl     = 3600
}

# TODO: migrate live.sargassum.world to managed infra
resource "desec_rrset" "live_a" {
  domain  = desec_domain.root.name
  subname = "live"
  type    = "A"
  records = ["35.212.249.95"] # TODO: this should be the address of the compute instance under soe-sargassum-planktoscope, for billing purposes
  ttl     = 3600
}

# TODO: migrate fider.sargassum.world to managed infra
resource "desec_rrset" "fider_a" {
  domain  = desec_domain.root.name
  subname = "fider"
  type    = "A"
  records = ["49.12.214.144"]
  ttl     = 3600
}

# TODO: migrate fider.sargassum.world to managed infra
resource "desec_rrset" "fider_aaaa" {
  domain  = desec_domain.root.name
  subname = "fider"
  type    = "AAAA"
  records = ["2a01:4f8:c010:a153::"]
  ttl     = 3600
}

# TODO: migrate applications off this record
resource "desec_rrset" "fluitans_caprover_a" {
  domain  = desec_domain.root.name
  subname = "*.cloud.fluitans"
  type    = "A"
  records = ["49.12.214.144"]
  ttl     = 3600
}

# TODO: migrate applications off this record
resource "desec_rrset" "fluitans_caprover_aaaa" {
  domain  = desec_domain.root.name
  subname = "*.cloud.fluitans"
  type    = "AAAA"
  records = ["2a01:4f8:c010:a153::"]
  ttl     = 3600
}

# TODO: migrate applications off this record
resource "desec_rrset" "syngnathus_caprover_a" {
  domain  = desec_domain.root.name
  subname = "*.cloud.syngnathus"
  type    = "A"
  records = ["35.212.249.95"]
  ttl     = 3600
}
