# Unorchestrated Services
# TODO: replace deployment-specific strings like "sargassum.world", "foundations.infra.sargassum.world", "gcp-us-west1-a-1", etc., with template variables throughout this file
# TODO: the public Caddy server should only bind to the public IP address, while the private Caddy server should only bind to the ZeroTier IP addresses

nomad.s.infra.sargassum.world,
nomad.s.foundations.infra.sargassum.world,
nomad.s.gcp-us-west1-a-1.d.infra.sargassum.world,
nomad.s.gcp-us-west1-a-1.d.foundations.infra.sargassum.world {
  reverse_proxy localhost:4646
}

hello.s.gcp-us-west1-a-1.d.foundations.infra.sargassum.world {
  respond "hello, private network!"
}

# Nomad-Orchestrated Services

{{ $enableFilterMatch := "caddy.enable=true" -}}
{{ $publicFilterMatch := "caddy.reverse_proxy.public=true" -}}
{{- $customHostFilterPattern := `caddy\.reverse_proxy\.host=(.*)` -}}

{{ range $serviceInfo := nomadServices -}}
  {{- if $serviceInfo.Tags | contains $enableFilterMatch -}}
    {{- range $tag := $serviceInfo.Tags -}}
      {{- if $tag | regexMatch $customHostFilterPattern -}}
        {{- range $service := nomadService $serviceInfo.Name }}
{{ $tag | regexReplaceAll $customHostFilterPattern "$1" }},
        {{- end -}}
      {{- end -}}
    {{- end -}}
    {{- if $serviceInfo.Tags | contains $publicFilterMatch -}}
      {{- range $service := nomadService $serviceInfo.Name }}
{{ $service.Name | toLower }}.s.sargassum.world,
      {{- end -}}
    {{- end -}}
    {{- range $service := nomadService $serviceInfo.Name }}
{{ $service.Name | toLower }}.s.foundations.infra.sargassum.world {
  reverse_proxy {{ $service.Address }}:{{ $service.Port }}
}
    {{- end -}}
  {{- end -}}
{{- end }}

# Nomad-Orchestrated Services with Custom Names

{{ range $serviceInfo := nomadServices -}}
  {{- if $serviceInfo.Tags | contains $enableFilterMatch -}}
  {{- end -}}
{{- end }}
