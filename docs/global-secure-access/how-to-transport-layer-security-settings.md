---
title: Configure TLS inspection with your own certificate
description: Learn how to bring your own certificate authority for Transport Layer Security inspection.
ms.topic: how-to
ms.reviewer: teresayao
ms.date: 08/28/2026
ai-usage: ai-assisted


#customer intent: As a Global Secure Access administrator, I want to use my organization's public key infrastructure for Transport Layer Security inspection.
---

# Configure TLS inspection with your own certificate

Transport Layer Security (TLS) inspection in Microsoft Entra Internet Access uses a two-tier intermediate certificate model to issue dynamically generated leaf certificates for decrypting traffic. This bring your own certificate (BYOC) option lets you use your organization's public key infrastructure (PKI) to sign the certificate authority (CA) that serves as the Global Secure Access intermediate CA.

This article explains how to create a certificate signing request (CSR), sign it with your CA, and upload the signed certificate. If you don't want to operate your own CA for TLS inspection, see [Configure TLS inspection with a Microsoft-managed certificate](how-to-transport-layer-security-settings-managed-certificate.md).

## Prerequisites

To complete the steps in this process, you must have the following prerequisites in place:

- A PKI service to sign the CSR and generate an intermediate certificate for TLS inspection. For testing scenarios, you can also use a self-signed root certificate created with OpenSSL.
- A trial license for Microsoft Entra Internet Access.
- [Global Secure Access prerequisites](how-to-configure-web-content-filtering.md).

## Create a CSR and upload your signed certificate

To create a CSR and upload the signed certificate for TLS termination:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com/) as a [Global Secure Access Administrator](../identity/role-based-access-control/permissions-reference.md#global-secure-access-administrator).
1. Browse to **Global Secure Access** > **Secure** > **TLS inspection policies**.
1. Switch to the **TLS inspection settings** tab.
1. Select **+ Create certificate** to start generating a certificate signing request.
1. In the **Create certificate** pane, fill in the following fields:
   - **Certificate name**: This name appears in the certificate hierarchy when viewed in a browser. It must be unique, contain no spaces, and be no more than 12 characters long. You can't reuse a previous certificate name, even after you delete the certificate.
   - **Common name** (CN): Enter a common name that identifies the intermediate certificate, for example, `Contoso TLS ICA`.
   - **Organizational Unit** (OU): Enter an organization name, for example, `Contoso IT`.
1. Select **Create CSR**. The `.csr` file is saved to your default download folder.

    :::image type="content" source="media/how-to-transport-layer-security-settings/create-certificate.png" alt-text="Screenshot of the Create certificate pane with fields filled and the Create CSR button highlighted." lightbox="media/how-to-transport-layer-security-settings/create-certificate.png":::

1. Sign the CSR using your PKI service. Make sure **Server Auth** is in Extended Key Usage and `certificate authority (CA)=true`, `keyCertSign,cRLSign`, `basicConstraints=critical,CA:TRUE`, and `pathLenConstraint = 1` are in Basic Extension. Save the signed certificate in `.pem` format. If you're testing with a self-signed certificate, follow the instructions to [use OpenSSL to sign the CSR](#test-with-a-self-signed-root-certificate-authority-using-openssl).
   
1. Select **+ Upload certificate**.
1. In the **Upload certificate** form, upload the `certificate.pem` and `chain.pem` files.
1. Select **Upload signed certificate**.

    :::image type="content" source="media/how-to-transport-layer-security-settings/upload-certificate.png" alt-text="Screenshot of Upload certificate form with example certificate and chain certificate files in the upload fields." lightbox="media/how-to-transport-layer-security-settings/upload-certificate.png":::

1. The uploaded certificate defaults to **Disabled** status. Set the status to **Enabled**. You can have one enabled certificate.

    :::image type="content" source="media/how-to-transport-layer-security-settings/status-active.png" alt-text="Screenshot of the TLS inspection settings tab showing certificate status is Enabled." lightbox="media/how-to-transport-layer-security-settings/status-active.png":::

## Test with a self-signed root certificate authority using OpenSSL
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
    subjectKeyIdentifier = hash
    authorityKeyIdentifier = keyid:always,issuer
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

1. Create a new root certificate authority and private key using the following *openssl.cnf* config file:

   ```console
   openssl req -x509 -new -nodes -newkey rsa:4096 -keyout rootCAchain.key -sha256 -days 370 -out rootCAchain.pem -subj "/C=US/ST=US/O=Self Signed/CN=Self Signed Root CA" -config openssl.cnf -extensions rootCA_ext
   ```

1. Sign the CSR using the following command:

   ```console
   openssl x509 -req -in <CSR file> -CA rootCAchain.pem -CAkey rootCAchain.key -CAcreateserial -out signedcertificate.pem -days 370 -sha256 -extfile openssl.cnf -extensions signedCA_ext
   ```

1. Upload `signedcertificate.pem` and `rootCAchain.pem` according to the steps in [Create a CSR and upload your signed certificate](#create-a-csr-and-upload-your-signed-certificate).

## Configure TLS inspection in Microsoft Entra Internet Access

The following video shows how to configure TLS inspection in Microsoft Entra Internet Access using a self-signed certificate created with OpenSSL. It also shows how to build TLS inspection policies, configure security profiles, apply web content filtering, enforce Conditional Access policies, create custom block pages, and implement threat intelligence policies.

 > [!VIDEO 2f8c4249-79c5-4832-bd94-de4f4f647e8c]


## PowerShell examples

For examples that configure a certificate authority for TLS inspection using Active Directory Certificate Services (AD CS) or OpenSSL, see:

- [Create TLS certificates using AD CS](scripts/powershell-active-directory-certificate-service.md)
- [Create a TLS certificate using OpenSSL](scripts/powershell-open-secure-sockets-layer.md)

## Related content

- [Configure TLS inspection with a Microsoft-managed certificate](how-to-transport-layer-security-settings-managed-certificate.md)
- [What is Transport Layer Security inspection?](concept-transport-layer-security.md)
- [Configure Transport Layer Security inspection policies](how-to-transport-layer-security.md)
- [Transport Layer Security inspection frequently asked questions](faq-transport-layer-security.yml)
- [Troubleshoot Transport Layer Security inspection issues](troubleshoot-transport-layer-security.md)
