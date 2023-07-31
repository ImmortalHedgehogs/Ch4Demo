{{ if and .Values.blue.enabled .Values.green.enabled }}
---
apiVersion: networking.istio.io/v1alpha3
kind: DestinationRule
metadata:
  name: {{ include "devops-knowledge-share-api.fullname" . }}
spec:
  host: {{ .Chart.Name }}
  subsets:
    - name: prod
      labels:
        slot: {{ include "devops-knowledge-share-api.productionSlot" . }}
    - name: test
      labels:
        slot: {{ include "devops-knowledge-share-api.testSlot" . }}
{{ end }}
