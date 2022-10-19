resource "nomad_scheduler_config" "config" {
  memory_oversubscription_enabled = true
}

# Jobs

# TODO: move these jobs into the gcp-compute-orchestrators.tf file
resource "nomad_job" "zerotier_agent" {
  jobspec = templatefile("${path.module}/nomad-jobs/zerotier-agent.hcl.tftpl", {
    resource_name = replace(var.name, "-", "_")
    datacenter    = var.nomad_datacenter
    affinity      = var.name
    private_key   = zerotier_identity.instance.private_key
    public_key    = zerotier_identity.instance.public_key
    network       = var.zerotier_network_id
  })

  hcl2 {
    enabled = true
  }

  lifecycle {
    replace_triggered_by = [
      google_compute_instance.instance.instance_id,
    ]
  }
}

resource "nomad_job" "caddy" {
  jobspec = templatefile("${path.module}/nomad-jobs/caddy.hcl.tftpl", {
    resource_name         = replace(var.name, "-", "_")
    datacenter            = var.nomad_datacenter
    affinity              = var.name
    ztoverlay_certificate = var.acme_ztoverlay_certificate
    ztoverlay_private_key = var.acme_ztoverlay_private_key
    caddyfile = templatefile("${path.module}/nomad-jobs/caddy_Caddyfile.tpl.tftpl", {
      root_domain             = var.dns_root_domain_name
      infra_domain            = var.dns_infra_domain_name
      zerotier_network_domain = "${var.dns_zerotier_network_subname}.${var.dns_infra_domain_name}"
      device_subname          = var.name
      acme_email              = var.acme_email
    })
  })

  hcl2 {
    enabled = true
  }

  lifecycle {
    replace_triggered_by = [
      google_compute_instance.instance.instance_id,
    ]
  }
}
