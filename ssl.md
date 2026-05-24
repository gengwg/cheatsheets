limit max reuse of domain validation data and organization data to 397 days.

With the exception[9] of Extended Validation Certificates for .onion domains, it is otherwise not possible to get a wildcard Extended Validation Certificate – instead, all fully qualified domain names must be included in the certificate and inspected by the certificate authority.

A domain validated certificate (DV) is an X.509 public key certificate typically used for Transport Layer Security (TLS) where the domain name of the applicant is validated by proving some control over a DNS domain.

The sole criterion for a domain validated certificate is proof of control over whois records, DNS records file, email or web hosting account of a domain. Typically control over a domain is determined using one of the following:

    Response to email sent to the email contact in the domain's whois details
    Response to email sent to a well-known administrative contact in the domain, e.g. (admin@, postmaster@, etc.)
    Publishing a DNS TXT record
    Publishing a nonce provided by an automated certificate issuing system

A domain validated certificate is distinct from an Extended Validation Certificate in that this is the only requirement for issuing the certificate.[3] In particular, domain validated certificates do not assure that any particular legal entity is connected to the certificate, even if the domain name may imply a particular legal entity controls the domain. 

As of 2020, all major browsers user interfaces display EV and OV and DV certificates identically, but provide options to query the type of certificate via multiple clicks.

As the low assurance requirements allow domain validated certificates to be issued quickly without requiring human intervention, domain validated certificates have a number of unique characteristics:

    Domain validated certificates are used in automated X.509 certificate issuing systems, such as Let's Encrypt.
    Domain validated certificates are often cheap or free.
    Domain validated certificates can be generated and validated without any documentation.
    Most domain validated certificates can be issued instantly (in less than a minute) via special tools which automate issuing process.

In a typical public-key infrastructure (PKI) scheme, the certificate issuer is a certificate authority (CA),[2] usually a company that charges customers to issue certificates for them. By contrast, in a web of trust scheme, individuals sign each other's keys directly, in a format that performs a similar function to a public key certificate. 

The connecting client conducts certification path validation, ensuring that:

    The subject of the certificate matches the host name (not to be confused with the domain name) to which the client is trying to connect.
    A trusted certificate authority has signed the certificate.

The Subject field of the certificate must identify the primary host name of the server as the Common Name. A certificate may be valid for multiple host names (e.g., a domain and its subdomains.) Such certificates are commonly called Subject Alternative Name (SAN) certificates or Unified Communications Certificates (UCC). These certificates contain the Subject Alternative Name field, though many CAs also put them into the Subject Common Name field for backward compatibility. If some of the host names contain an asterisk (*), a certificate may also be called a wildcard certificate. 

Once the certification path validation is successful, the client can establish an encrypted connection with the server.

Internet-facing servers, such as public web servers, must obtain their certificates from a trusted, public certificate authority (CA).

Client certificates authenticate the client connecting to a TLS service, for instance to provide access control.[4] Because most services provide access to individuals, rather than devices, most client certificates contain an email address or personal name rather than a host name. In addition, the certificate authority that issues the client certificate is usually the service provider to which client connects because it is the provider that needs to perform authentication.

A self-signed certificate is a certificate with a subject that matches its issuer, and a signature that can be verified by its own public key. 

For most purposes, such a self-signed certificate is worthless. However, the digital certificate chain of trust starts with a self-signed certificate, called a "root certificate," "trust anchor," or "trust root." A certificate authority self-signs a root certificate to be able to sign other certificates.

An intermediate certificate has a similar purpose to the root certificate; its only use is to sign other certificate. However, an intermediate certificate is not self-signed. A root certificate or another intermediate certificate need to sign it. An end-entity or leaf certificate is any certificate that cannot sign other certificates. For instance, TLS/SSL server and client certificates, email certificates, code signing certificates, and qualified certificates are all end-entity certificates.

In the X.509 trust model, a certificate authority (CA) is responsible for signing certificates. These certificates act as an introduction between two parties, which means that a CA acts as a trusted third party. A CA processes requests from people or organizations requesting certificates (called subscribers), verifies the information, and potentially signs an end-entity certificate based on that information. To perform this role effectively, a CA needs to have one or more broadly trusted root certificates or intermediate certificates and the corresponding private keys. CAs may achieve this broad trust by having their root certificates included in popular software, or by obtaining a cross-signature from another CA delegating trust. Other CAs are trusted within a relatively small community, like a business, and are distributed by other mechanisms like Windows Group Policy.

Certificate authorities are also responsible for maintaining up-to-date revocation information about certificates they have issued, indicating whether certificates are still valid. They provide this information through Online Certificate Status Protocol (OCSP) and/or Certificate Revocation Lists (CRLs). Some of the larger certificate authorities in the market include IdenTrust, DigiCert, and Sectigo.[8]

The policies and processes a provider uses to decide which certificate authorities their software should trust are called root programs. 

Browsers other than Firefox generally use the operating system's facilities to decide which certificate authorities are trusted. So, for instance, Chrome on Windows trusts the certificate authorities included in the Microsoft Root Program, while on macOS or iOS, Chrome trusts the certificate authorities in the Apple Root Program.[9] Edge and Safari use their respective operating system trust stores as well, but each is only available on a single OS. Firefox uses the Mozilla Root Program trust store on all platforms.

The Mozilla Root Program is operated publicly, and its certificate list is part of the open source Firefox web browser, so it is broadly used outside Firefox. For instance, while there is no common Linux Root Program, many Linux distributions, like Debian,[10] include a package that periodically copies the contents of the Firefox trust list, which is then used by applications.

All web browsers come with an extensive built-in list of trusted root certificates, many of which are controlled by organizations that may be unfamiliar to the user.[1] Each of these organizations is free to issue any certificate for any web site and have the guarantee that web browsers that include its root certificates will accept it as genuine. In this instance, end users must rely on the developer of the browser software to manage its built-in list of certificates and on the certificate providers to behave correctly and to inform the browser developer of problematic certificates.

The list of built-in certificates is also not limited to those provided by the browser developer: users (and to a degree applications) are free to extend the list for special purposes such as for company intranets.[16] This means that if someone gains access to a machine and can install a new root certificate in the browser, that browser will recognize websites that use the inserted certificate as legitimate.

In cryptography, a PKI is an arrangement that binds public keys with respective identities of entities (like people and organizations). The binding is established through a process of registration and issuance of certificates at and by a certificate authority (CA). Depending on the assurance level of the binding, this may be carried out by an automated process or under human supervision. When done over a network, this requires using a secure certificate enrollment or certificate management protocol such as CMP.

Public key cryptography is a cryptographic technique that enables entities to securely communicate on an insecure public network, and reliably verify the identity of an entity via digital signatures.

A public key infrastructure (PKI) is a system for the creation, storage, and distribution of digital certificates which are used to verify that a particular public key belongs to a certain entity. The PKI creates digital certificates which map public keys to entities, securely stores these certificates in a central repository and revokes them if needed.[6][7][8]

A PKI consists of:[7][9][10]

    A certificate authority (CA) that stores, issues and signs the digital certificates;
    A registration authority (RA) which verifies the identity of entities requesting their digital certificates to be stored at the CA;
    A central directory—i.e., a secure location in which keys are stored and indexed;
    A certificate management system managing things like the access to stored certificates or the delivery of the certificates to be issued;
    A certificate policy stating the PKI's requirements concerning its procedures. Its purpose is to allow outsiders to analyze the PKI's trustworthiness.

Principle of a public key infrastructure. CA: certification authority, RA: registration authority, VA: validation authority Rough outline: A user applies for a certificate with his public key at a registration authority (RA). The latter confirms the user's identity to the certification authority (CA) which in turn issues the certificate. The user can then digitally sign a contract using his new certificate. His identity is then checked by the contracting party with a validation authority (VA) which again receives information about issued certificates by the certification authority.

The primary role of the CA is to digitally sign and publish the public key bound to a given user. This is done using the CA's own private key, so that trust in the user key relies on one's trust in the validity of the CA's key. When the CA is a third party separate from the user and the system, then it is called the Registration Authority (RA), which may or may not be separate from the CA.

In this model of trust relationships, a CA is a trusted third party – trusted both by the subject (owner) of the certificate and by the party relying upon the certificate.

PKIs of one type or another, and from any of several vendors, have many uses, including providing public keys and bindings to user identities which are used for:

    Encryption and/or sender authentication of e-mail messages (e.g., using OpenPGP or S/MIME);
    Encryption and/or authentication of documents (e.g., the XML Signature or XML Encryption standards if documents are encoded as XML);
    Authentication of users to applications (e.g., smart card logon, client authentication with SSL/TLS). There's experimental usage for digitally signed HTTP authentication in the Enigform and mod_openpgp projects;
    Bootstrapping secure communication protocols, such as Internet key exchange (IKE) and SSL/TLS. In both of these, initial set-up of a secure channel (a "security association") uses asymmetric key—i.e., public key—methods, whereas actual communication uses faster symmetric key—i.e., secret key—methods;
    Mobile signatures are electronic signatures that are created using a mobile device and rely on signature or certification services in a location independent telecommunication environment;[24]
    Internet of things requires secure communication between mutually trusted devices. A public key infrastructure enables devices to obtain and renew X509 certificates which are used to establish trust between devices and encrypt communications using TLS.

OpenSSL is the simplest form of CA and tool for PKI. It is a toolkit, developed in C, that is included in all major Linux distributions, and can be used both to build your own (simple) CA and to PKI-enable applications. (Apache licensed)

Vault[28] tool for securely managing secrets (TLS certificates included) developed by HashiCorp. (Mozilla Public License 2.0 licensed)

Boulder, an ACME-based CA written in Go. Boulder is the software that runs Let's Encrypt.

Currently the majority of web browsers are shipped with pre-installed intermediate certificates issued and signed by a certificate authority, by public keys certified by so-called root certificates.

In cryptography, a certificate authority or certification authority (CA) is an entity that issues digital certificates. A digital certificate certifies the ownership of a public key by the named subject of the certificate. This allows others (relying parties) to rely upon signatures or on assertions made about the private key that corresponds to the certified public key. A CA acts as a trusted third party—trusted both by the subject (owner) of the certificate and by the party relying upon the certificate. The format of these certificates is specified by the X.509 or EMV standard.

The client uses the CA certificate to authenticate the CA signature on the server certificate, as part of the authorizations before launching a secure connection.

Usually, client software—for example, browsers—include a set of trusted CA certificates. This makes sense, as many users need to trust their client software. A malicious or compromised client can skip any security check and still fool its users into believing otherwise. 

A CA issues digital certificates that contain a public key and the identity of the owner. The matching private key is not made available publicly, but kept secret by the end user who generated the key pair. The certificate is also a confirmation or validation by the CA that the public key contained in the certificate belongs to the person, organization, server or other entity noted in the certificate.

In essence, the certificate authority is responsible for saying "yes, this person is who they say they are, and we, the CA, certify that".

## security domain

a security domain corresponds to a public key infrastructure (pki), the space where a root certificate authority is recognized. entities within a security domain can implement tls-based mutual authentication to secure communications.

an entity == client. person, machine, pod in a container env, or a service.

- certificate: type 509 or ssh.. used by entity (users, services, and hosts) for transport layer tls authentication
- cat token: entity uses this for application later authentication.

certificates define identity. manage certs: distribution, renewals, revocation.

graphapi for services.
interngraph for users.

cats usedto authenticate an external entity (client) to a resource (service) in prod.
this requires opening token service to external connections in a secure way.

cats only function to provide authentication at the application layer. while tls still provide confidentiality of communications at the transport layer.

```
client --> proxy --> ra --> ca
```

only certs and cat tokens are used for prod access (tls + application alyer authentication).
other id proof used for id mgmtn (cer and cat provisioning).

cat token is per request.
ssl cert is per connection.

## authentication process

- check identity proof provided by the client
- check security domain specific policies

X.509 certificates bind an identity to a public key using a digital signature. In the X.509 system, there are two types of certificates. The first is a CA certificate. The second is an end-entity certificate. A CA certificate can issue other certificates. The top level, self-signed CA certificate is sometimes called the Root CA certificate. Other CA certificates are called intermediate CA or subordinate CA certificates. An end-entity certificate identifies the user, like a person, organization or business. An end-entity certificate cannot issue other certificates. An end-entity certificate is sometimes called a leaf certificate since no other certificates can be issued below it.


An organization that wants a signed certificate requests one from a CA using a protocol like Certificate Signing Request (CSR), Simple Certificate Enrollment Protocol (SCEP) or Certificate Management Protocol (CMP). The organization first generates a key pair, keeping the private key secret and using it to sign the CSR. The CSR contains information identifying the applicant and the applicant's public key that is used to verify the signature of the CSR - and the Distinguished Name (DN) that is unique for the person, organization or business. The CSR may be accompanied by other credentials or proofs of identity required by the certificate authority.

The CSR will be validated using a Registration Authority (RA), and then the certification authority will issue a certificate binding a public key to a particular distinguished name. The roles registration authority and certification authority are usually separate business units under separation of duties to reduce the risk of fraud.

An organization's trusted root certificates can be distributed to all employees so that they can use the company PKI system.[citation needed] Browsers such as Internet Explorer, Firefox, Opera, Safari and Chrome come with a predetermined set of root certificates pre-installed, so SSL certificates from major certificate authorities will work instantly; in effect the browsers' developers determine which CAs are trusted third parties for the browsers' users.[citation needed] For example, Firefox provides a CSV and/or HTML file containing a list of Included CAs.

In practice, a DV certificate means a certificate was issued for a domain like example.com after someone responded to an email sent to webmaster@example.com. An EV certificate means a certificate was issued for a domain like example.com, and a company like Example, LLC is the owner of the domain, and the owner was verified by Articles of Incorporation.

There are several commonly used filename extensions for X.509 certificates. Unfortunately, some of these extensions are also used for other data such as private keys.

    .pem – (Privacy-enhanced Electronic Mail) Base64 encoded DER certificate, enclosed between "-----BEGIN CERTIFICATE-----" and "-----END CERTIFICATE-----"
    .cer, .crt, .der – usually in binary DER form, but Base64-encoded certificates are common too (see .pem above)
    .p7b, .p7c – PKCS#7 SignedData structure without data, just certificate(s) or CRL(s)
    .p12 – PKCS#12, may contain certificate(s) (public) and private keys (password protected)
    .pfx – PFX, predecessor of PKCS#12 (usually contains data in PKCS#12 format, e.g., with PFX files generated in IIS)

A certificate chain (see the equivalent concept of "certification path" defined by RFC 5280 section 3.2) is a list of certificates (usually starting with an end-entity certificate) followed by one or more CA certificates (usually the last one being a self-signed certificate), with the following properties: 

    The Issuer of each certificate (except the last one) matches the Subject of the next certificate in the list
    Each certificate (except the last one) is signed by the secret key corresponding to the next certificate in the chain (i.e. the signature of one certificate can be verified using the public key contained in the following certificate)
    The last certificate in the list is a trust anchor: a certificate that you trust because it was delivered to you by some trustworthy procedure

A → B means "A is signed by B" (or, more precisely, "A is signed by the secret key corresponding to the public key contained in B").

"To allow for graceful transition from the old signing key pair to the new signing key pair, the CA should issue a certificate that contains the old public key signed by the new private signing key and a certificate that contains the new public key signed by the old private signing key. Both of these certificates are self-issued, but neither is self-signed. Note that these are in addition to the two self-signed certificates (one old, one new)."

X509v3 Subject Alternative Name: DNS describes the hostnames for which it could be used. 

In a TLS connection, a properly-configured server would provide the intermediate as part of the handshake. However, it's also possible to retrieve the intermediate certificate by fetching the "CA Issuers" URL from the end-entity certificate. 

This is an example of an intermediate certificate belonging to a certificate authority. This certificate signed the end-entity certificate above, and was signed by the root certificate below. Note that the subject field of this intermediate certificate matches the issuer field of the end-entity certificate that it signed. Also, the "subject key identifier" field in the intermediate matches the "authority key identifier" field in the end-entity certificate.

This is an example of a self-signed root certificate representing a certificate authority. Its issuer and subject fields are the same, and its signature can be validated with its own public key. Validation of the trust chain has to end here. If the validating program has this root certificate in its trust store, the end-entity certificate can be considered trusted for use in a TLS connection. Otherwise, the end-entity certificate is considered untrusted.

Exploiting a hash collision to forge X.509 signatures requires that the attacker be able to predict the data that the certificate authority will sign. This can be somewhat mitigated by the CA generating a random component in the certificates it signs, typically the serial number. The CA/Browser Forum has required serial number entropy in its Baseline Requirements Section 7.1 since 2011.[34] 


TLS/SSL and HTTPS use the RFC 5280 profile of X.509, as do S/MIME (Secure Multipurpose Internet Mail Extensions) and the EAP-TLS method for WiFi authentication. Any protocol that uses TLS, such as SMTP, POP, IMAP, LDAP, XMPP, and many more, inherently uses X.509.

SSH generally uses a Trust On First Use security model and doesn't have need for certificates. However, the popular OpenSSH implementation does support a CA-signed identity model based on its own non-X.509 certificate format.[47]


