{{ if ne .Values.environment "local" -}}
---
kind: IngressSecret
apiVersion: di.liatrio.com/v1
metadata:
  name: {{ include "devops-knowledge-share-api.fullname" . }}-cert
  annotations:
    "helm.sh/hook": "pre-install,pre-upgrade"
    "helm.sh/hook-weight": "-1" # NOTE: Ingress secret needs to be deployed before gateway otherwise failure
    "helm.sh/hook-delete-policy": "before-hook-creation"
spec:
  cert: {{ .Values.environment | printf "certs/devops-knowledge-share-api-%s.crt" | .Files.Get | b64enc }}
  path_to_key: secret/devops-knowledge-share-api/{{ .Values.environment }}/{{ include "devops-knowledge-share-api.name" . }}/tlscert
{{- end }}
