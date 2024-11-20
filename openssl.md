## Notes

A digital certificate contains the public key and the identity information of the owner, such as their name, organization, and more, as issued by a trusted Certificate Authority (CA). It does not contain the private key, which is kept secret by the owner to ensure secure communication and authentication.

A Certificate Authority (CA) binds an entity’s identity to a public key by issuing a digital certificate after verifying the entity’s credentials. The digital certificate can be trusted because it is part of a chain of trust anchored in the CA’s root certificate, which is widely recognized and trusted by operating systems and browsers.

- SSL Certificates only provide encryption.
- Trust comes from the CA.

Without the CA’s validation, encryption alone wouldn’t guarantee trust because you wouldn’t know who is on the other side of the secure connection.


## Commands 

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

## Resources

[1] https://www.youtube.com/watch?v=qXLD2UHq2vk&t=10s
Introduction to Digital certificate, this is generic understanding of Public Key Infrastructure, this can give you quick overview of domain we operate.
[2][ https://youtu.be/GSIDS_lvRv4](https://youtu.be/GSIDS_lvRv4)
[3] https://www.youtube.com/watch?v=wzbf9ldvBjM create privatkey, publickey, CSR and certificate
[4] https://youtu.be/vsXMMT2CqqE
[5] https://youtu.be/T4Df5_cojAs](https://youtu.be/T4Df5_cojAs)
[6] https://youtu.be/NmM9HA2MQGI](https://youtu.be/NmM9HA2MQGI)
[7] x509 Certificate Format https://www.youtube.com/watch?v=sYSO13LRfYA

