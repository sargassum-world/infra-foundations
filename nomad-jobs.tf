# TODO: move these jobs into the gcp-compute-orchestrators.tf file
resource "nomad_job" "zerotier_agent" {
  jobspec = templatefile("${path.module}/nomad-jobs/zerotier-agent.hcl.tftpl", {
    group       = "gcp_us_west1_a_1"
    affinity    = google_compute_instance.us_west1_a_1.name
    private_key = zerotier_identity.gcp_us_west1_a_1.private_key
    public_key  = zerotier_identity.gcp_us_west1_a_1.public_key
    network     = zerotier_network.foundations.id
  })

  hcl2 {
    enabled = true
  }
}

resource "nomad_job" "caddy" {
  jobspec = templatefile("${path.module}/nomad-jobs/caddy.hcl.tftpl", {
    group    = "gcp_us_west1_a_1"
    affinity = google_compute_instance.us_west1_a_1.name
  })

  hcl2 {
    enabled = true
  }
}
