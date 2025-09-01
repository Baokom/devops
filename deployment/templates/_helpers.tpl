{{/*
Expand the name of the chart.
*/}}
{{- define "webapp.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "webapp.fullname" -}}
{{- .Values.app.name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "webapp.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "webapp.labels" -}}
helm.sh/chart: {{ include "webapp.chart" . }}
{{ include "webapp.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- with .Values.commonLabels }}
{{ toYaml . }}
{{- end }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "webapp.selectorLabels" -}}
app.kubernetes.io/name: {{ include "webapp.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}



{{/*
Create the name of the configmap to use
*/}}
{{- define "webapp.configMapName" -}}
{{- .Values.app.name }}-config
{{- end }}

{{/*
Create the name of the secret to use
*/}}
{{- define "webapp.secretName" -}}
{{- .Values.app.name }}-secret
{{- end }}

{{/*
Create the name of the service to use
*/}}
{{- define "webapp.serviceName" -}}
{{- .Values.app.name }}-service
{{- end }}

{{/*
Create the name of the ingress to use
*/}}
{{- define "webapp.ingressName" -}}
{{- .Values.app.name }}-ingress
{{- end }}
