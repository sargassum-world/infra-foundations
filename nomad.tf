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
  jobspec = templatefile("./nomad-jobs/caddy.hcl.tftpl", {
    datacenter            = "sargassum-foundations"
    ztoverlay_certificate = module.zerotier_network_foundations.acme_certificate
    ztoverlay_private_key = module.zerotier_network_foundations.acme_private_key
    caddyfile = templatefile("./nomad-jobs/caddy_Caddyfile.tpl.tftpl", {
      root_domain             = desec_domain.root.name
      infra_domain            = desec_domain.infra.name
      zerotier_network_domain = "${module.zerotier_network_foundations.name_subname}.${desec_domain.infra.name}"
      acme_email              = var.acme_email
    })
  })

  hcl2 {
    enabled = true
  }

  # FIXME: Currently this is impossible. See https://github.com/hashicorp/terraform/issues/31713
  # lifecycle {
  #   replace_triggered_by = [
  #     module.orchestrator_gcp_us_west1_a_1.gcp_instance,
  #   ]
  # }
}
