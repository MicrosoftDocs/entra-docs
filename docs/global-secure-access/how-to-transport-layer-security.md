---
title: Configure Transport Layer Security Inspection (Preview)
description: Learn how to configure a Transport Layer Security inspection policy and assign it to users in your organization.
author: HULKsmashGithub
ms.author: jayrusso
manager: femila
ms.service: global-secure-access
ms.topic: how-to 
ms.reviewer: teresayao
ms.date: 05/20/2025


#customer intent: As a Global Secure Access administrator, I want to configure a context-aware Transport Layer Security inspection policy and assign the policy to users in my organization.   
---

# Configure Transport Layer Security inspection (Preview)
Because most internet traffic is encrypted, terminating Transport Layer Security (TLS) at the edge allows Global Secure Access to decrypt and inspect traffic. This inspection enables Global Secure Access to enforce security policies such as threat detection, content filtering, and fine-grained access controls, which enhances protection against threats concealed within encrypted communications.

> [!IMPORTANT]
> The Transport Layer Security inspection feature is currently in PREVIEW.   
> This information relates to a prerelease product that might be substantially modified before release. Microsoft makes no warranties, expressed or implied, with respect to the information provided here.   
 
This article explains how to create a context-aware Transport Layer Security inspection policy and assign it to users in your organization.

## Prerequisites   
To complete the steps in this process, you must have the following prerequisites in place:      
- A Public Key Infrastructure (PKI) service to sign the Certificate Signing Request (CSR) and generate an intermediate certificate for TLS inspection. For testing scenarios, you can also use a self-signed root certificate created with OpenSSL.   
- Test devices or virtual machines, running Windows, that are either Microsoft Entra joined or hybrid joined to your organization's Microsoft Entra ID.  
- A trial license for Microsoft Entra Internet Access.  
- [Global Secure Access prerequisites](how-to-configure-web-content-filtering.md). 

## Create a context-aware TLS inspection policy
To create a context-aware Transport Layer Security inspection policy and assign the policy to users in your organization, complete the following steps:
1. [Create a CSR and upload the signed certificate for TLS termination](#step-1-global-secure-access-admin-create-a-certificate-signing-request-csr-and-upload-the-signed-certificate-for-tls-termination)
1. [Create a TLS inspection policy](#step-2-global-secure-access-admin-create-a-tls-inspection-policy)
1. [Assign the TLS inspection policy](#step-3-global-secure-access-admin-assign-the-tls-inspection-policy)
1. [Create a conditional access policy](#step-4-global-secure-access-admin-create-a-conditional-access-policy)
1. [Test the configuration](#step-5-test-the-configuration)

### Step 1: Global Secure Access admin: create a certificate signing request (CSR) and upload the signed certificate for TLS termination
To create a CSR and upload the signed certificate for TLS termination:
1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com/) as a [Global Secure Access Administrator](https://review.learn.microsoft.com/en-us/entra/identity/role-based-access-control/permissions-reference#global-secure-access-administrator).
1. Browse to **Global Secure Access** > **Secure** > **TLS inspection policy**.
1. Switch to the **TLS inspection settings** tab.
1. Select **+ Create certificate**.
1. In the **Create certificate** pane, fill in the following fields:
   - **Certificate name**: Up to 12 characters, no spaces.
   - **Common name** (CN): Identifies the intermediate certificate.
   - **Organizational Unit** (OU): Organization name, for example, Contoso IT.
1. Select **Create CSR**.
:::image type="content" source="media/how-to-transport-layer-security/create-certificate.png" alt-text="Screenshot of the Create certificate pane with fields filled and the Create CSR button highlighted.":::   

7. Sign the CSR using your PKI service. Ensure Server Auth is in Extended Key Usage and certificate authority (CA)=true in Basic Extension.
1. Select **+Upload certificate**.
1. In the Upload certificate form, upload the certificate.pem and chain.pem files.
1. Select **Upload signed certificate**.
:::image type="content" source="media/how-to-transport-layer-security/upload-certificate.png" alt-text="Screenshot of Upload certificate form with example certificate and chain certificate files in the upload fields."::: 

For a test configuration, see [Testing root certificate authority (CA) using OpenSSL](#testing-root-certificate-authority-ca-using-openssl).  

### Step 2: Global Secure Access admin: create a TLS inspection policy
To create a TLS inspection policy:
1. In the Microsoft Entra admin center, navigate to **Secure** > **TLS inspection policies**.   
1. Create a new policy with **Action** set to **Inspect**.   
1. Select **Save**. This configuration enables TLS termination for all traffic categories except Education, Finance, Government, and Health and medicine.
:::image type="content" source="media/how-to-transport-layer-security/inspection-policy.png" alt-text="Screenshot of the Create a TLS inspection policy screen open to the Review tab.":::   

### Step 3: Global Secure Access admin: assign the TLS inspection policy
Next, assign the TLS inspection policy. You can link the TLS policy to a security profile in two ways:
#### Option 1: Link the TLS policy to the baseline profile.   
With this method, the baseline profile policy is evaluated last and applies to all user traffic.   
1. In the Microsoft Entra admin center, navigate to **Secure** > **Security Profiles**.
1. Select **Edit Baseline profile**.
1. In the **Link policies** view, link the TLS policy and assign a desired priority to the security profile.   
:::image type="content" source="media/how-to-transport-layer-security/security-profile-baseline.png" alt-text="Screenshot of the Edit Baseline profile screen showing a list of policy names and their priorities.":::   

#### Option 2: Selective TLS inspection for users/groups
Alternatively, you can add a TLS policy to a security profile and link it to a conditional access policy.
:::image type="content" source="media/how-to-transport-layer-security/security-profile.png" alt-text="Screenshot of the Create a profile screen showing a list of linked policies.":::   

### Step 4: Global Secure Access admin: create a conditional access policy
In this step, [create a conditional access policy](how-to-configure-web-content-filtering.md#create-and-link-conditional-access-policy) for a specific user, group, or other conditional access context condition and assign the Global Secure Access security profile.   
:::image type="content" source="media/how-to-transport-layer-security/conditional-access-group-assignment.png" alt-text="Screenshot of the new conditional access policy form with all fields completed with sample information.":::   

### Step 5: Test the configuration
To test the configuration:
1. Ensure the end user device has the root certificate installed in the Trusted Root Certification Authorities folder.   
:::image type="content" source="media/how-to-transport-layer-security/trusted-store.png" alt-text="Screenshot of the Trusted Root Certification Authorities folder.":::   

1. Set up the Global Secure Access client:
    - Disable secure DNS and built-in DNS.  
    - Block QUIC traffic from your device. QUIC isn't supported in Microsoft Entra Internet Access. Most websites support fallback to TCP when QUIC can't be established. For improved user experience, you can deploy a Windows Firewall rule that blocks outbound UDP 443: @New-NetFirewallRule -DisplayName "Block QUIC" -Direction Outbound -Action Block -Protocol UDP -RemotePort 443.   
    - Ensure Internet Access Traffic Forwarding is enabled.   
1. Open a browser on a client device and test various websites. Inspect the certificate information and confirm the Global Secure Access certificate.
:::image type="content" source="media/how-to-transport-layer-security/certificate-viewer.png" alt-text="Screenshot of the Certificate Viewer with the Global Secure Access certificate highlighted.":::    

## Disable TLS inspection
To disable TLS inspection:
1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com/).
1. Browse to **Global Secure Access** > **Secure** > **TLS inspection policy**.
1. Remove the TLS inspection policy:
    1. Select **Actions**.
    1. Select **Delete**.   
1. Switch to the **TLS inspection settings** tab.
1. Remove the TLS inspection policy certificate:
    1. Select **Actions**.
    1. Select **Delete**.      

## Testing root certificate authority (CA) using OpenSSL
You can use a self-signed root CA created by openSSL to sign the CSR. After you upload the certificate and chain, the policy status changes to **Active** and it's ready to use for TLS inspection. To test using OpenSSL:
1. If you don't already have one, create an `openssl.cnf` file with the following configuration: 
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

2. Create a new root certificate authority and private key using the following `openssl.cnf` config file:   
`openssl req -x509 -new -nodes -newkey rsa:4096 -keyout rootCA.key -sha256 -days 3650 -out rootCA.crt -subj “/C=US/ST=US/O=Self Signed/CN=Self Signed Root CA” -config openssl.cnf -extensions rootCA_ext`   
1. Use the following command to sign csr.txt:   
`openssl x509 -req -in csr.txt -CA rootCA.crt -CAkey rootCA.key -CAcreateserial -out signedcertificate.crt -days 3650 -sha256 -extfile openssl.cnf -extensions signedCA_ext`   
1. Rename `signedcertificate.crt` to `signedcertificate.pem` and `rootCA.crt` to `rootCA.pem` and upload the signed certificates according to the steps in [Create a CSR and upload the signed certificate for TLS termination](#step-1-global-secure-access-admin-create-a-certificate-signing-request-csr-and-upload-the-signed-certificate-for-tls-termination).   

## Related content

* [Transport Layer Security Inspection Overview](concept-transport-layer-security.md)
* [Transport Layer Security Inspection Frequently Asked Questions](<resource-faq.yml>)
