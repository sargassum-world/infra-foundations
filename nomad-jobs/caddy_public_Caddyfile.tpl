gcp-us-west1-a-1.infra.sargassum.world {
  respond "hello, public internet!"
}

nomad.gcp-us-west1-a-1.infra.sargassum.world {
  reverse_proxy localhost:4646
}

gcp-us-west1-a-1.d.foundations.infra.sargassum.world:80 {
  respond "hello, private network!"
}
