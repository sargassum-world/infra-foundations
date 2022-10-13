# TODO: replace deployment-specific strings with template variables throughout this file
{
  acme_ca https://acme-staging-v02.api.letsencrypt.org/directory
}

# Service Nomad

nomad.s.foundations.infra.sargassum.world,
nomad.s.gcp-us-west1-a-1.d.foundations.infra.sargassum.world {
  reverse_proxy localhost:4646
}

# Service Hello World (HTTP)

hello.s.foundations.infra.sargassum.world:80,
hello.s.gcp-us-west1-a-1.d.foundations.infra.sargassum.world:80 {
  respond "hello, http!"
}

# Service Hello World (HTTPS)

hello-https.s.foundations.infra.sargassum.world,
hello-https.s.gcp-us-west1-a-1.d.foundations.infra.sargassum.world {
  respond "hello, https!"
}

{{- $enableFilterMatch := "caddy.enable=true" -}}
{{- range $serviceInfo := nomadServices -}}
  {{- if $serviceInfo.Tags | contains $enableFilterMatch }}

# Service {{ $serviceInfo.Name }}
    {{- range $service := nomadService $serviceInfo.Name }}
{{ $service.Name | toLower }}.s.foundations.infra.sargassum.world {
  reverse_proxy {{ $service.Address }}:{{ $service.Port }}
}
    {{- end -}}
  {{- end -}}
{{- end }}
