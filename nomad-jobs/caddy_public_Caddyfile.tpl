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
{{ range $serviceInfo := nomadServices -}}
  {{- if $serviceInfo.Tags | contains $filter -}}
    {{- range $service := nomadService $serviceInfo.Name -}}

{{ $service.Name | toLower }}.s.infra.sargassum.world {
  reverse_proxy {{ $service.Address }}:{{ $service.Port }}
}

    {{- end -}}
  {{- end -}}
{{- end }}

# Nomad-Orchestrated Services

{{ $hostPattern := `caddy\.reverse_proxy\.host=(.*)` -}}
{{- range $serviceInfo := nomadServices -}}
  {{- if $serviceInfo.Tags | contains $filter -}}
    {{- range $tag := $serviceInfo.Tags -}}
      {{- if $tag | regexMatch $hostPattern -}}
        {{- range $service := nomadService $serviceInfo.Name -}}

{{ $tag | regexReplaceAll $hostPattern "$1" }} {
  reverse_proxy {{ $service.Address }}:{{ $service.Port }}
}

        {{- end -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}
{{- end }}
