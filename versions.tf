terraform {
  cloud {
    organization = "sargassum-world"

    workspaces {
      name = "infra-foundations-prod"
    }
  }

  required_providers {
    zerotier = {
      source  = "zerotier/zerotier"
      version = "~> 1.2.0"
    }
  }
}
