@echo off
echo ----------------------------------------------
echo Making Certificate Signing Request (CSR)
echo and RSA Private Key (protected by pass phrase)
echo ----------------------------------------------

openssl req -new -days 365 -out newcert-csr.pem -keyout newcert-key.pem
