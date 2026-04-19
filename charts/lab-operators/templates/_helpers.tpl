{{/*
_helpers.tpl — lab-operators chart template helpers
*/}}

{{/*
Expand the name of the chart.
*/}}
{{- define "lab-operators.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "lab-operators.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- .Chart.Name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}

{{/*
Common labels applied to all resources.
*/}}
{{- define "lab-operators.labels" -}}
helm.sh/chart: {{ printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/part-of: lab
{{- end }}

{{/*
Selector labels for a given operator name.
Usage: include "lab-operators.selectorLabels" (dict "name" "lab-kubernetes")
*/}}
{{- define "lab-operators.selectorLabels" -}}
app.kubernetes.io/name: {{ .name }}
app.kubernetes.io/component: operator
{{- end }}

{{/*
Pod security context shared by all operators.
*/}}
{{- define "lab-operators.podSecurityContext" -}}
runAsNonRoot: true
runAsUser: 1001
runAsGroup: 1001
fsGroup: 1001
{{- end }}

{{/*
Container security context shared by all operators.
*/}}
{{- define "lab-operators.containerSecurityContext" -}}
allowPrivilegeEscalation: false
readOnlyRootFilesystem: true
capabilities:
  drop: ["ALL"]
{{- end }}

{{/*
Standard liveness probe for all operators.
*/}}
{{- define "lab-operators.livenessProbe" -}}
httpGet:
  path: /healthz/live
  port: health
initialDelaySeconds: 15
periodSeconds: 30
failureThreshold: 3
{{- end }}

{{/*
Standard readiness probe for all operators.
*/}}
{{- define "lab-operators.readinessProbe" -}}
httpGet:
  path: /healthz/ready
  port: health
initialDelaySeconds: 15
periodSeconds: 10
failureThreshold: 3
{{- end }}
