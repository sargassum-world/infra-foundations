# TODO: move these jobs into the gcp-compute-orchestrators.tf file
resource "nomad_job" "zerotier_agent" {
  jobspec = templatefile("${path.module}/nomad-jobs/zerotier-agent.hcl.tftpl", {
    group       = "gcp_us_west1_a_1"
    affinity    = google_compute_instance.us_west1_a_1.name
    private_key = module.orchestrator_gcp_us_west1_a_1.zerotier_private_key
    public_key  = module.orchestrator_gcp_us_west1_a_1.zerotier_public_key
    network     = zerotier_network.foundations.id
  })

  hcl2 {
    enabled = true
  }

  lifecycle {
    replace_triggered_by = [
      google_compute_instance.us_west1_a_1.instance_id,
    ]
  }
}

resource "nomad_job" "caddy" {
  jobspec = templatefile("${path.module}/nomad-jobs/caddy.hcl.tftpl", {
    group                 = "gcp_us_west1_a_1"
    affinity              = google_compute_instance.us_west1_a_1.name
    ztoverlay_certificate = "${acme_certificate.zerotier_wildcards.certificate_pem}${acme_certificate.zerotier_wildcards.issuer_pem}"
    ztoverlay_private_key = acme_certificate.zerotier_wildcards.private_key_pem
    caddyfile = templatefile("${path.module}/nomad-jobs/caddy_Caddyfile.tpl.tftpl", {
      root_domain    = desec_domain.root.name
      device_subname = "gcp-us-west1-a-1"
      acme_email     = var.acme_email
    })
  })

  hcl2 {
    enabled = true
  }

  lifecycle {
    replace_triggered_by = [
      google_compute_instance.us_west1_a_1.instance_id,
    ]
  }
}
