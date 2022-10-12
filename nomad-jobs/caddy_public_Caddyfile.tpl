# Node

gcp-us-west1-a-1.infra.sargassum.world {
  respond "hello, public internet!"
}

gcp-us-west1-a-1.d.foundations.infra.sargassum.world:80 {
  respond "hello, private network!"
}

# Infrastructure Services

nomad.s.infra.sargassum.world {
  reverse_proxy localhost:4646
}

# TODO: enable DNS wildcarding for *.s.infra.sargassum.world in DNS records and make it work with HTTPS
{{ $filter := list "caddy.enable=true" -}}
{{- range $service := nomadServices -}}

{{ $service.Name | toLower }}.s.infra.sargassum.world {
  reverse_proxy {{ $service.Address }}:{{ $service.Port }}
}

{{- end }}

# Nomad-Orchestrated Services

{{ $filter := list "caddy.enable=true" -}}
{{- $hostPattern := "caddy\.reverse_proxy\.host=(.*)" -}}
{{- range $service := nomadServices -}}
  {{- if containsAll $filter $service.Tags -}}
    {{- range $tag := $service.Tags -}}
      {{- if $tag | regexMatch $hostPattern -}}
        {{- $host = $tag | regexReplaceAll $hostPattern "$1" -}}

{{ $host }} {
  reverse_proxy {{ $service.Address }}:{{ $service.Port }}
}

      {{- end -}}
    {{- end -}}
  {{- end -}}
{{- end }}
