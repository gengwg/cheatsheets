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

Check SANs:

```
$ openssl x509 -noout -ext subjectAltName -in /var/lib/kubernetes/etcd.pem
X509v3 Subject Alternative Name:
    DNS:kubernetes.default, DNS:api01.example.com, DNS:ctrlplane003.example.com, DNS:api01.glb.example.com, IP Address:2620:XXX, IP Address:FDF5:XXXX, IP Address:FDF5:XXXX
```

### validate certificates match private key

https://ma.ttias.be/openssl-validate-that-certificate-matches-signs-the-private-key/

If you md5sum the certs directly, they look different (possibly due to newline char different. i'm not sure why).

```
# md5sum service-account.pem
7f26fa5b042f64d57faa3a35ac07b049  service-account.pem
# md5sum ~/service-account.pem
b363e6adf6da897360bf2eecc125490e  /root/service-account.pem
```

Correct way to validate they are the same is:

```
# openssl rsa -noout -modulus -in service-account.pem  2> /dev/null | openssl md5
(stdin)= d41d8cd98f00b204e9800998ecf8427e
# openssl rsa -noout -modulus -in ~/service-account.pem  2> /dev/null | openssl md5
(stdin)= d41d8cd98f00b204e9800998ecf8427e
```

### Inspect PEM with multiple certificates

If your test.pem file contains multiple certificates, you can inspect all of them using the following method. Requires keytool is available.

```
keytool -printcert -file test.pem
```
