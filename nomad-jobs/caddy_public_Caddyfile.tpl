# Node

gcp-us-west1-a-1.infra.sargassum.world {
  respond "hello, public internet!"
}

gcp-us-west1-a-1.d.foundations.infra.sargassum.world:80 {
  respond "hello, private network!"
}

# Services

nomad.s.infra.sargassum.world {
  reverse_proxy localhost:4646
}

# Applications

# TODO
