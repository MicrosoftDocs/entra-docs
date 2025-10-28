---
title: Configure Transport Layer Security Inspection (Preview)
description: Learn how to configure a Transport Layer Security inspection certificate authority
author: HULKsmashGithub
ms.author: jayrusso
manager: dougeby
ms.service: global-secure-access
ms.topic: how-to 
ms.reviewer: teresayao
ms.date: 09/10/2025


#customer intent: As a Global Secure Access administrator, I want to configure a context-aware Transport Layer Security inspection policy and assign the policy to users in my organization.   
---

# Configure Transport Layer Security inspection settings (Preview)
Transport Layer Security (TLS) inspection in Microsoft Entra Internet Access uses a two-tier Intermediate certificate model to issue dynamically generated leaf certificates for decrypting traffic. This article explains how to configure the Certificate Authority (CA) that serves as the Global Secure Access (GSA) intermediate CA, including signing and uploading the certificate.

> [!IMPORTANT]
> The Transport Layer Security inspection feature is currently in PREVIEW.   
> This information relates to a prerelease product that might be substantially modified before release. Microsoft makes no warranties, expressed or implied, with respect to the information provided here.   
> While in preview, don't use TLS inspection in production environments.    
 


## Prerequisites   
To complete the steps in this process, you must have the following prerequisites in place:      
- A Public Key Infrastructure (PKI) service to sign the Certificate Signing Request (CSR) and generate an intermediate certificate for TLS inspection. For testing scenarios, you can also use a self-signed root certificate created with OpenSSL.   
- A trial license for Microsoft Entra Internet Access.  
- [Global Secure Access prerequisites](how-to-configure-web-content-filtering.md) 

### Global Secure Access admin: create a CSR and upload the signed certificate for TLS termination
To create a CSR and upload the signed certificate for TLS termination:
1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com/) as a [Global Secure Access Administrator](../identity/role-based-access-control/permissions-reference.md#global-secure-access-administrator).
1. Browse to **Global Secure Access** > **Secure** > **TLS inspection policies**.
1. Switch to the **TLS inspection settings** tab.
1. Select **+ Create certificate**. This step starts with generating a Certificate Sign Request (CSR). 
1. In the **Create certificate** pane, fill in the following fields:
   - **Certificate name**: This name appears in the certificate hierarchy when viewed in a browser. It must be unique, contain no spaces, and be no more than 12 characters long. You can't reuse previous names.
   - **Common name** (CN): Common name, for example, Contoso TLS ICA, that identifies the intermediate certificate.
   - **Organizational Unit** (OU): Organization name, for example, Contoso IT.
1. Select **Create CSR**. This step creates a .csr file and saves it to your default download folder.
:::image type="content" source="media/how-to-transport-layer-security/create-certificate.png" alt-text="Screenshot of the Create certificate pane with fields filled and the Create CSR button highlighted.":::   

1. Sign the CSR using your PKI service. Make sure **Server Auth** is in Extended Key Usage and `certificate authority (CA)=true`, `keyCertSign,cRLSign`, and `basicConstraints=critical,CA:TRUE` in Basic Extension. Save the signed certificate in .pem format. If you're testing with a self-signed certificate, follow the instructions to [use OpenSSL to sign the CSR](#test-with-a-self-signed-root-certificate-authority-using-openssl). 
   
1. Select **+Upload certificate**.
1. In the Upload certificate form, upload the certificate.pem and chain.pem files.
1. Select **Upload signed certificate**.
:::image type="content" source="media/how-to-transport-layer-security/upload-certificate.png" alt-text="Screenshot of Upload certificate form with example certificate and chain certificate files in the upload fields."::: 

1. After the certificate uploads, the status changes to **Active**.   
:::image type="content" source="media/how-to-transport-layer-security/status-active.png" alt-text="Screenshot of the TLS inspection settings tab with the certificate status set to Active.":::   


### Test with a self-signed root certificate authority using OpenSSL
For **testing purposes only**, use a self-signed root certificate authority (CA) that you create with OpenSSL to sign the CSR. 
1. If you don't already have one, first create an *openssl.cnf* file with this configuration:
```ini
[ rootCA_ext ]
subjectKeyIdentifier = hash
authorityKeyIdentifier = keyid:always,issuer
basicConstraints = critical, CA:true
keyUsage = critical, digitalSignature, cRLSign, keyCertSign

[ interCA_ext ]
subjectKeyIdentifier = hash
authorityKeyIdentifier = keyid:always,issuer
basicConstraints = critical, CA:true, pathlen:1
keyUsage = critical, digitalSignature, cRLSign, keyCertSign

[ signedCA_ext ]
basicConstraints = critical, CA:true
keyUsage = critical, digitalSignature, cRLSign, keyCertSign
extendedKeyUsage = serverAuth

[ server_ext ]
subjectKeyIdentifier = hash
authorityKeyIdentifier = keyid:always,issuer
basicConstraints = critical, CA:false
keyUsage = critical, digitalSignature
extendedKeyUsage = serverAuth
```

2. Create a new root certificate authority and private key using the following *openssl.cnf* config file:   
```openssl req -x509 -new -nodes -newkey rsa:4096 -keyout rootCAchain.key -sha256 -days 370 -out rootCAchain.pem -subj "/C=US/ST=US/O=Self Signed/CN=Self Signed Root CA" -config openssl.cnf -extensions rootCA_ext```
1. Sign the CSR using the following command:
 ```openssl x509 -req -in <CSR file> -CA rootCAchain.pem -CAkey rootCAchain.key -CAcreateserial -out signedcertificate.pem -days 370 -sha256 -extfile openssl.cnf -extensions signedCA_ext```
1. Upload the signed certificates (```signedcertificate.pem```and ```rootCAchain.pem```) according to the steps in [Create a CSR and upload the signed certificate for TLS termination](#step-1-global-secure-access-admin-create-a-csr-and-upload-the-signed-certificate-for-tls-termination).

### Powershell examples to configure certificate authority for TLS inspection
Examples of configuring TLS certificate using ADCS and OpenSSL can be found in below links: 
* [Create a TLS certificates using ADCS](scripts/powershell-active-directory-certificate-service.md)
* [Create a TLS certificate using OpenSSL](scripts/powershell-open-secure-sockets-layer.md) 

## Related content
* [What is Transport Layer Security inspection?](concept-transport-layer-security.md)
* [Frequently asked questions for Transport Layer Security inspection](faq-transport-layer-security.yml)
