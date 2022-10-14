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

  lifecycle {
    replace_triggered_by = [
      google_compute_instance.us_west1_a_1.instance_id,
    ]
  }
}

data "local_file" "caddy_caddyfile" {
  filename = "${path.module}/nomad-jobs/caddy_Caddyfile.tpl.tftpl"
}

resource "nomad_job" "caddy" {
  jobspec = templatefile("${path.module}/nomad-jobs/caddy.hcl.tftpl", {
    group                 = "gcp_us_west1_a_1"
    affinity              = google_compute_instance.us_west1_a_1.name
    caddyfile             = data.local_file.caddy_caddyfile.content
    acme_email            = var.acme_email
    root_domain           = desec_domain.root
    device_subname        = "gcp-us-west1-a-1"
    ztoverlay_certificate = acme_certificate.zerotier_wildcards.certificate_pem
    ztoverlay_private_key = acme_certificate.zerotier_wildcards.private_key_pem
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
