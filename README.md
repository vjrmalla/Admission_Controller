# Admission_Controller
There are two categories of Admission Controllers, Validating and Mutating. A Validating Admission Controller validates the incoming request and returns a binary response, yes or no based on custom logic. An example can be that if a Pod resource doesn’t have certain labels the request is rejected with a message on why. A Mutating Admission Controller modifies the incoming request based on custom logic. An example can be that if an Ingress resource doesn’t have the correct annotations, the correct annotations will be added and the resource will be admitted.

#Validating Admission Controller:
1. Create a Docker image from admission_controller.py with Flask installed.
2. Generate a self signed CA, generate a csr and cert then create a secret based on this cert. See commands to do this task below.
3. Create a Deployment from the created Docker image in a namespace. The service must be secured via SSL. Mount the secret created from the previous step as volumes in the Deployment.
4. Create a Service pointing to the correct ports in same namespace as the Deployment.

# Generate the CA cert and private key
openssl req -nodes -new -x509 -keyout ca.key -out ca.crt -subj "/CN=Admission Controller Webhook CA"
 
# Generate the private key for the webhook server
openssl genrsa -out server.key 2048

Generate a Certificate Signing Request (CSR) for the private key, and sign it with the private key of the CA. The CN is the service name (FQDN) of the webhook application deployment
openssl req -new -key server.key -subj "/CN=webhook-server.webhook-demo.svc" | openssl x509 -req -CA ca.crt -CAkey ca.key -CAcreateserial -out server.crt

