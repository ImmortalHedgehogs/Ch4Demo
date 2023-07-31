{{/*
Expand the name of the chart.
*/}}
{{- define "devops-knowledge-share-api.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "devops-knowledge-share-api.fullname" -}}
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
{{- define "devops-knowledge-share-api.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "devops-knowledge-share-api.labels" -}}
helm.sh/chart: {{ include "devops-knowledge-share-api.chart" . }}
app: {{ include "devops-knowledge-share-api.name" . }}
version: {{ default .Chart.AppVersion .Values.tag }}
{{ include "devops-knowledge-share-api.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
{{- if .Values.gitTag }}
tag: {{ .Values.gitTag | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- include "devops-knowledge-share-api.liatrioLabels" . }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "devops-knowledge-share-api.selectorLabels" -}}
app.kubernetes.io/name: {{ include "devops-knowledge-share-api.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
liatrio labels
*/}}
{{- define "devops-knowledge-share-api.liatrioLabels" -}}
{{- if .Values.teamname }}
liatrio.com/managed-by-team: {{ .Values.teamname }}
{{- end -}}
{{- if .Values.reponame }}
liatrio.com/repo: {{ .Values.reponame }}
{{- end -}}
{{- end -}}

{{/*
Image Repository
*/}}
{{- define "devops-knowledge-share-api.container" -}}
{{- if .depObj.image.registry }}
    {{- .depObj.image.registry -}}
    /
{{- end -}}
{{- .depObj.image.repository -}}
:
{{- .depObj.image.tag | default .Chart.AppVersion }}
{{- end -}}

{{ define "devops-knowledge-share-api.productionSlot" -}}
{{- if eq .Values.productionSlot "blue" -}}
blue
{{- else -}}
green
{{- end -}}
{{- end }}

{{ define "devops-knowledge-share-api.testSlot" -}}
{{- if eq .Values.productionSlot "blue" -}}
green
{{- else -}}
blue
{{- end -}}
{{- end }}
