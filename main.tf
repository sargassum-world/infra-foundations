provider "zerotier" {}

resource "zerotier_network" "ztnet" {
  name        = "infra.sargassum.world"
  description = "Control plane for sargassum.world"
  private     = true
}
