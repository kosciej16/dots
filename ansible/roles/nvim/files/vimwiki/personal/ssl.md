A Certificate is a method used to distribute a public key and other information about a server and the organization who is responsible for it. Certificates can be digitally signed by a Certification Authority, or CA. A CA is a trusted third party that has confirmed that the information contained in the certificate is accurate.

openssl genrsa -des3 -out server.key 2048
openssl rsa -in server.key -out server.key.insecure
openssl req -new -key server.key -out server.csr
openssl x509 -req -days 365 -in server.csr -signkey server.key -out server.crt
