# TODO: replace deployment-specific strings with template variables throughout this file
{
  email "lietk12@gmail.com"
}

# Service Nomad

nomad.s.infra.sargassum.world,
nomad.s.gcp-us-west1-a-1.d.infra.sargassum.world {
  reverse_proxy localhost:4646
}

nomad.s.foundations.infra.sargassum.world,
nomad.s.gcp-us-west1-a-1.d.foundations.infra.sargassum.world {
  reverse_proxy localhost:4646

  tls "/secrets/ztoverlay.crt" "/secrets/ztoverlay.key"
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

{{ $service.Name | toLower }}.s.foundations.infra.sargassum.world {
  reverse_proxy {{ $service.Address }}:{{ $service.Port }}

  tls "/secrets/ztoverlay.crt" "/secrets/ztoverlay.key"
}
      {{- end -}}
    {{- end -}}
  {{- end -}}
{{- end -}}
