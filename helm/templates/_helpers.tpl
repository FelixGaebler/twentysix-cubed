{{/*
Expand the name of the chart.
*/}}
{{- define "twentysix-cubed.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "twentysix-cubed.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/* Append a resource suffix to the release name and keep it DNS-label safe. */}}
{{- define "twentysix-cubed.resourceName" -}}
{{- $suffix := .suffix -}}
{{- $maxBaseLength := sub 63 (add 1 (len $suffix)) -}}
{{- $baseName := include "twentysix-cubed.fullname" .root | trunc (int $maxBaseLength) | trimSuffix "-" -}}
{{- printf "%s-%s" $baseName $suffix -}}
{{- end }}

{{- define "twentysix-cubed.secretName" -}}
{{- default (include "twentysix-cubed.resourceName" (dict "root" . "suffix" "secret")) .Values.secretName -}}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "twentysix-cubed.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "twentysix-cubed.labels" -}}
helm.sh/chart: {{ include "twentysix-cubed.chart" . }}
{{ include "twentysix-cubed.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "twentysix-cubed.selectorLabels" -}}
app.kubernetes.io/name: {{ include "twentysix-cubed.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
