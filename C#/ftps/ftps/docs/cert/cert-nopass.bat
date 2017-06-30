@echo off
echo -----------------------------------------
echo Making Certificate Signing Request (CSR)
echo and RSA Private Key (without pass phrase)
echo -----------------------------------------

openssl req -new -nodes -days 365 -out newcert-csr.pem -keyout newcert-key.pem
