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

{{/*
Create the name of the service account to use
*/}}
{{- define "twentysix-cubed.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "twentysix-cubed.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/* Build the DB URL from direct values or separate Vault-injected credentials. */}}
{{- define "twentysix-cubed.databaseUrl" -}}
{{- if .Values.database.url -}}
{{- .Values.database.url -}}
{{- else if or .Values.database.username .Values.database.password -}}
{{- $username := required "database.username is required to build DATABASE_URL" .Values.database.username | trim | urlquery | replace "+" "%20" -}}
{{- $password := required "database.password is required to build DATABASE_URL" .Values.database.password | trim | urlquery | replace "+" "%20" -}}
{{- $host := required "database.host is required to build DATABASE_URL" .Values.database.host -}}
{{- $database := required "database.database is required to build DATABASE_URL" .Values.database.database | urlquery | replace "+" "%20" -}}
{{- $databaseUrl := printf "postgresql://%s:%s@%s:%v/%s" $username $password $host .Values.database.port $database -}}
{{- if .Values.database.sslMode -}}
{{- $sslMode := .Values.database.sslMode | urlquery | replace "+" "%20" -}}
{{- $databaseUrl = printf "%s?sslmode=%s" $databaseUrl $sslMode -}}
{{- end -}}
{{- $databaseUrl -}}
{{- end -}}
{{- end -}}
