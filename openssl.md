View and parse a certificate:

```
$ openssl x509 -in EntrustRootCertificationAuthority-G2.crt -text -noout
```

Output the full subject DN.

```
$ openssl x509 -in EntrustRootCertificationAuthority-G2.crt -noout -noout -subject
subject=C = US, O = "Entrust, Inc.", OU = See www.entrust.net/legal-terms, OU = "(c) 2009 Entrust, Inc. - for authorized use only", CN = Entrust Root Certification Authority - G2
```

To view only the issuer

```
$ openssl x509 -in EntrustRootCertificationAuthority-G2.crt -noout -issuer
issuer=C = US, O = "Entrust, Inc.", OU = See www.entrust.net/legal-terms, OU = "(c) 2009 Entrust, Inc. - for authorized use only", CN = Entrust Root Certification Authority - G2
```

Output validity period dates:

```
$ openssl x509 -in EntrustRootCertificationAuthority-G2.crt -noout -dates
notBefore=Jul  7 17:25:54 2009 GMT
notAfter=Dec  7 17:55:54 2030 GMT
```

Output the public key in PEM format:

```
$ openssl x509 -in EntrustRootCertificationAuthority-G2.crt -noout -pubkey
-----BEGIN PUBLIC KEY-----
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAuoS2ctueDGvimekwAad2
6jK4lUEaydphTlhyz/72gnm/c2EGCqUn2LNf00VOHHLWTjLycooP94MZ0GqAgABF
HrDH55q/ElcnHKNoLwqHvWprDl5l8xx31dSFjXAhtLMy54ui1YY5ArG40kfO5MlJ
xDun3vtUfVe+8OhuwnmyOgtV4lCYFjITXC94VsHClLPyWuQnmp8k18bs0JslguPM
wsRFxYyXegZrKhGfqQpuSDtv29QRGUL3jwe/9VNfnD70FyzmaaxOMkxid+q36OW7
NLwZi66cUee3frVTsTMi5W3PcDwa+uKbZ7aD9I2lr2JMTeBYrGQ0EgP4to2UYySk
cQIDAQAB
-----END PUBLIC KEY-----
```
