# Infrastructure Services

nomad.s.infra.sargassum.world {
  reverse_proxy localhost:4646
}

# Node Services
# TODO: replace "gcp-us-west1-a-1" with a template variable throughout this file

nomad.s.gcp-us-west1-a-1.d.infra.sargassum.world {
  reverse_proxy localhost:4646
}

# TODO: figure out how to do DNS challenge to get a public HTTPS cert so we can enable HTTPS here
hello.s.gcp-us-west1-a-1.d.foundations.infra.sargassum.world:80 {
  respond "hello, private network!"
}

# Nomad-Orchestrated Services

{{ $enableFilterMatch := "caddy.enable=true" -}}

# TODO: enable DNS wildcarding for *.s.sargassum.world in DNS records and make it work with HTTPS
{{ range $serviceInfo := nomadServices -}}
  {{- if $serviceInfo.Tags | contains $enableFilterMatch -}}
    {{- range $service := nomadService $serviceInfo.Name -}}

{{ $service.Name | toLower }}.s.sargassum.world {
  reverse_proxy {{ $service.Address }}:{{ $service.Port }}
}

    {{- end -}}
  {{- end -}}
{{- end }}

# Nomad-Orchestrated Services with Custom Names

{{ $customHostFilterPattern := `caddy\.reverse_proxy\.host=(.*)` -}}
{{- range $serviceInfo := nomadServices -}}
  {{- if $serviceInfo.Tags | contains $enableFilterMatch -}}
    {{- range $tag := $serviceInfo.Tags -}}
      {{- if $tag | regexMatch $customHostFilterPattern -}}
        {{- range $service := nomadService $serviceInfo.Name -}}

{{ $tag | regexReplaceAll $customHostFilterPattern "$1" }} {
  reverse_proxy {{ $service.Address }}:{{ $service.Port }}
}

        {{- end -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}
{{- end }}
