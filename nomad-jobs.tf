# resource "nomad_job" "zerotier_agent" {
#   jobspec = templatefile("${path.module}/nomad-jobs/zerotier-agent.hcl.tftpl", {
#     group       = "zerotier_agent_gcp_us_west1_a_1"
#     private_key = zerotier_identity.gcp_us_west1_a_1.private_key
#     public_key  = zerotier_identity.gcp_us_west1_a_1.public_key
#   })

#   hcl2 {
#     enabled = true
#   }
# }
#
resource "nomad_job" "zerotier_agent" {
  jobspec = file("${path.module}/nomad-jobs/hello-world.hcl")

  hcl2 {
    enabled = true
  }
}
