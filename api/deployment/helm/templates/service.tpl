apiVersion: v1
kind: Service
metadata:
  name: {{ .Chart.Name }}
  labels:
    {{- include "devops-knowledge-share-api.labels" . | nindent 4 }}
  {{- with .Values.service.annotations }}
  annotations:
    {{- range $key, $value := . }}
    {{ $key }}: |
    {{- tpl $value $ | nindent 6 }}
    {{- end }}
  {{- end }}
spec:
  type: {{ .Values.service.type }}
  ports:
    - port: {{ .Values.service.port }}
      targetPort: http
      name: http
      {{ if  eq .Values.service.type "NodePort" }}
      nodePort: {{ .Values.service.nodePort }}
      {{- end }}
  selector:
    {{- include "devops-knowledge-share-api.selectorLabels" . | nindent 4 }}
