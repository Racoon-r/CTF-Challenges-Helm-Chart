{{/*
Return challenge name.
*/}}
{{- define "challenge.name" -}}
{{- default .Values.challenge.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Return namespace.
*/}}
{{- define "challenge.namespace" -}}
{{- default .Release.Namespace | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "challenge.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | replace " " "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Return image of the challenge.
*/}}
{{- define "challenge.image" -}}
{{- $registry := .Values.challenge.image.registry -}}
{{- $repository := .Values.challenge.image.repository -}}
{{- if .Values.challenge.image.digest -}}
{{- $digest := .Values.challenge.image.digest -}}
{{- $separator := "@" -}}
{{- printf "%s/%s%s%s" $registry $repository $separator $digest -}}
{{- else -}}
{{- $tag := (.Values.challenge.image.tag  | default "latest") -}}
{{- $separator := ":" -}}
{{- printf "%s/%s%s%s" $registry $repository $separator $tag -}}
{{- end -}}
{{- end -}}

{{/*
Return image of the database
*/}}
{{- define "challenge.db.image" -}}
{{- $registry := .Values.database.image.registry -}}
{{- $repository := .Values.database.image.repository -}}
{{- if .Values.database.image.digest -}}
{{- $digest := .Values.database.image.digest -}}
{{- $separator := "@" -}}
{{- printf "%s/%s%s%s" $registry $repository $separator $digest -}}
{{- else -}}
{{- $tag := (.Values.database.image.tag  | default "latest") -}}
{{- $separator := ":" -}}
{{- printf "%s/%s%s%s" $registry $repository $separator $tag -}}
{{- end -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "challenge.labels.standard" -}}
app.kubernetes.io/version: {{ .Chart.AppVersion }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/name: {{ include "challenge.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/*
Common match labels
*/}}
{{- define "challenge.labels.matchLabels" -}}
app.kubernetes.io/version: {{ .Chart.AppVersion }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/name: {{ include "challenge.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "challenge.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
{{- default (include "challenge.name" .) .Values.serviceAccount.name }}
{{- else -}}
{{- default "default" .Values.serviceAccount.name -}}
{{- end -}}
{{- end -}}
