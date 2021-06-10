#!/bin/bash

# Read the PEM-encoded CA certificate, base64 encode it, and replace the `${CA_PEM_B64}` placeholder 
#in the YAML
# template with it. Then, create the Kubernetes resource.
ca_pem_b64="$(openssl base64 -A <"ssl_crt/ca.crt")"
sed -e 's@${CA_PEM_B64}@'"$ca_pem_b64"'@g' <"validating_admission_webhook.yaml" \
    | kubectl apply -f -
