resource "nomad_job" "zerotier_agent" {
  jobspec = templatefile("${path.module}/nomad-job-zerotier-agent.hcl.tftpl", {
    group       = "gcp_us_west1_a_1"
    private_key = zerotier_identity.gcp_us_west1_a_1.private_key
    public_key  = zerotier_identity.gcp_us_west1_a_1.public_key
  })

  hcl2 {
    enabled = true
  }
}
