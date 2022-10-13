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
      google_compute_instance.us_west1_a_1.boot_disk.initialize_params.image,
    ]
  }
}

data "local_file" "caddy_caddyfile" {
  filename = "${path.module}/nomad-jobs/caddy_Caddyfile.tpl"
}

resource "nomad_job" "caddy" {
  jobspec = templatefile("${path.module}/nomad-jobs/caddy.hcl.tftpl", {
    group             = "gcp_us_west1_a_1"
    affinity          = google_compute_instance.us_west1_a_1.name
    caddyfile         = data.local_file.caddy_caddyfile.content
    infra_certificate = "${acme_certificate.infra_all_wildcards.certificate_pem}"
    infra_private_key = acme_certificate.infra_all_wildcards.private_key_pem
  })

  hcl2 {
    enabled = true
  }

  lifecycle {
    replace_triggered_by = [
      google_compute_instance.us_west1_a_1.boot_disk.initialize_params.image,
    ]
  }
}
