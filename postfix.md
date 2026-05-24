// vim: noai:ts=2:sw=2

```
Aug  3 13:49:17 myhost postfix/smtp[31959]: 6A5A04010A26: SASL authentication failed; cannot authenticate to server mail.server.com[]: no mechanism available
Aug  3 13:49:17 myhost postfix/smtp[31959]: warning: SASL authentication failure: No worthy mechs found
```

===>

```
[root@myhost postfix]# yum install cyrus-sasl-plain
[root@myhost postfix]# postfix reload
```

Enable password authentication in `main.cf`.

```
# enable SASL authentication
smtp_sasl_auth_enable = yes
# disallow methods that allow anonymous authentication.
smtp_sasl_security_options = noanonymous
# where to find sasl_passwd
smtp_sasl_password_maps = hash:/etc/postfix/sasl_passwd
# Enable STARTTLS encryption
#smtp_use_tls = yes
#smtp_sasl_mechanism_filter = plain
smtp_sasl_mechanism_filter = LOGIN

# where to find CA certificates
# smtp_tls_CAfile = /etc/ssl/certs/ca-certificates.crt
# not needed!!
smtp_tls_CAfile = /etc/pki/tls/certs/ca-bundle.crt
```

possibly also need:

```
sender_canonical_maps=static:me@example.com
relay_domains = example.com
```

Test Postfix/mailx config:

```
echo "Testing sending mail"  | mailx -v -s "Sending mail from "$(hostname -s)  user@example.com
```
