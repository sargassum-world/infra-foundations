# TODO: replace deployment-specific strings with template variables throughout this file
{
  default_bind 10.64.0.46
}

# Service Nomad
nomad.s.infra.sargassum.world,
nomad.s.gcp-us-west1-a-1.d.infra.sargassum.world {
  reverse_proxy localhost:4646
}

{{- $enableFilterMatch := "caddy.enable=true" -}}
{{- $publicFilterMatch := "caddy.reverse_proxy.public=true" -}}
{{- $customHostFilterPattern := `caddy\.reverse_proxy\.host=(.*)` -}}
{{- range $serviceInfo := nomadServices -}}
  {{- if $serviceInfo.Tags | contains $enableFilterMatch }}

# Service {{ $serviceInfo.Name }}
    {{ if $serviceInfo.Tags | contains $publicFilterMatch -}}
      {{- range $tag := $serviceInfo.Tags -}}
        {{- if $tag | regexMatch $customHostFilterPattern -}}
          {{- range $service := nomadService $serviceInfo.Name }}
{{ $tag | regexReplaceAll $customHostFilterPattern "$1" }},
          {{- end -}}
        {{- end -}}
      {{- end -}}
      {{- range $service := nomadService $serviceInfo.Name }}
{{ $service.Name | toLower }}.s.sargassum.world {
  reverse_proxy {{ $service.Address }}:{{ $service.Port }}
}
      {{- end -}}
    {{- end -}}
  {{- end -}}
{{- end -}}
