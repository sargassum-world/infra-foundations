resource "nomad_scheduler_config" "config" {
  memory_oversubscription_enabled = true
  preemption_config = {
    batch_scheduler_enabled    = false
    service_scheduler_enabled  = false
    system_scheduler_enabled   = false
    sysbatch_scheduler_enabled = false
  }
}

# Jobs

resource "nomad_job" "caddy" {
  jobspec = templatefile("${path.module}/nomad-jobs/caddy.hcl.tftpl", {
    resource_name         = replace(var.name, "-", "_")
    datacenter            = var.nomad_datacenter
    hostname_constraint   = var.name
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
  detach = false

  hcl2 {
    enabled = true
  }

  lifecycle {
    replace_triggered_by = [
      google_compute_instance.instance.instance_id,
    ]
  }

  timeouts {
    create = "5m"
    update = "5m"
  }
}
