# Node

gcp-us-west1-a-1.infra.sargassum.world {
  respond "hello, public internet!"
}

gcp-us-west1-a-1.d.foundations.infra.sargassum.world:80 {
  respond "hello, private network!"
}

# Infrastructure Services

{{- $filter := "caddy.enable=true" }}

nomad.s.infra.sargassum.world {
  reverse_proxy localhost:4646
}

# TODO: enable DNS wildcarding for *.s.infra.sargassum.world in DNS records and make it work with HTTPS
{{- range nomadServices -}}
  {{- if .Tags | contains $filter -}}
    {{- range nomadService .Name -}}

{{ .Name | toLower }}.s.infra.sargassum.world {
  reverse_proxy {{ .Address }}:{{ .Port }}
}

    {{- end -}}
  {{- end -}}
{{- end }}
