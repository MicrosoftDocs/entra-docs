---
title: Configure Transport Layer Security Inspection (Preview)
description: Learn how to configure a Transport Layer Security inspection policy and assign it to users in your organization.
author: HULKsmashGithub
ms.author: jayrusso
manager: femila
ms.service: global-secure-access
ms.topic: how-to 
ms.reviewer: teresayao
ms.date: 05/28/2025


#customer intent: As a Global Secure Access administrator, I want to configure a context-aware Transport Layer Security inspection policy and assign the policy to users in my organization.   
---

# Configure Transport Layer Security inspection (Preview)
Transport Layer Security (TLS) inspection in Microsoft Entra Internet Access enables decryption and inspection of encrypted traffic at service edge locations. This capability lets Global Secure Access apply advanced security controls like threat detection, content filtering, and granular access policies. Organizations use these access policies to protect against threats that might be hidden in encrypted communications.

> [!IMPORTANT]
> The Transport Layer Security inspection feature is currently in PREVIEW.   
> This information relates to a prerelease product that might be substantially modified before release. Microsoft makes no warranties, expressed or implied, with respect to the information provided here.   
> While in preview, don't use TLS inspection in production environments.    
 
This article explains how to create a context-aware Transport Layer Security inspection policy and assign it to users in your organization.

## Prerequisites   
To complete the steps in this process, you must have the following prerequisites in place:      
- A Public Key Infrastructure (PKI) service to sign the Certificate Signing Request (CSR) and generate an intermediate certificate for TLS inspection. For testing scenarios, you can also use a self-signed root certificate created with OpenSSL.   
- Test devices or virtual machines running Windows that are either Microsoft Entra joined or hybrid joined to your organization's Microsoft Entra ID.  
- A trial license for Microsoft Entra Internet Access.  
- [Global Secure Access prerequisites](how-to-configure-web-content-filtering.md) 

## Create a context-aware TLS inspection policy
To create a context-aware Transport Layer Security inspection policy and assign it to users in your organization, complete the following steps:
1. [Create a CSR and upload the signed certificate for TLS termination](#step-1-global-secure-access-admin-create-a-csr-and-upload-the-signed-certificate-for-tls-termination)
1. [Create a TLS inspection policy](#step-2-global-secure-access-admin-create-a-tls-inspection-policy)
1. [Link the TLS inspection policy to a security profile](#step-3-global-secure-access-admin-link-the-tls-inspection-policy-to-a-security-profile)
1. [Test the configuration](#step-4-test-the-configuration)

### Step 1: Global Secure Access admin: create a CSR and upload the signed certificate for TLS termination
To create a CSR and upload the signed certificate for TLS termination:
1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com/) as a [Global Secure Access Administrator](../identity/role-based-access-control/permissions-reference.md#global-secure-access-administrator).
1. Browse to **Global Secure Access** > **Secure** > **TLS inspection policies**.
1. Switch to the **TLS inspection settings** tab.
1. Select **+ Create certificate**.
1. In the **Create certificate** pane, fill in the following fields:
   - **Certificate name**: This name appears in the certificate hierarchy when viewed in a browser. It must be unique, contain no spaces, and be no more than 12 characters long. You can't reuse previous names.
   - **Common name** (CN): Common name, for example, Contoso TLS ICA, that identifies the intermediate certificate.
   - **Organizational Unit** (OU): Organization name, for example, Contoso IT.
1. Select **Create CSR**.
:::image type="content" source="media/how-to-transport-layer-security/create-certificate.png" alt-text="Screenshot of the Create certificate pane with fields filled and the Create CSR button highlighted.":::   

1. Sign the CSR using your PKI service. Make sure Server Auth is in Extended Key Usage and certificate authority (CA)=true in Basic Extension.
1. Select **+Upload certificate**.
1. In the Upload certificate form, upload the certificate.pem and chain.pem files.
1. Select **Upload signed certificate**.
:::image type="content" source="media/how-to-transport-layer-security/upload-certificate.png" alt-text="Screenshot of Upload certificate form with example certificate and chain certificate files in the upload fields."::: 

1. After the certificate uploads, the status changes to **Active**.   
:::image type="content" source="media/how-to-transport-layer-security/status-active.png" alt-text="Screenshot of the TLS inspection settings tab with the certificate status set to Active.":::   

For a test configuration, see [Test with a self-signed root certificate authority using OpenSSL](#test-with-a-self-signed-root-certificate-authority-using-openssl).  

### Step 2: Global Secure Access admin: create a TLS inspection policy
To create a TLS inspection policy:
1. In the Microsoft Entra admin center, navigate to **Secure** > **TLS inspection policies**.   
1. Create a new policy with **Action** set to **Inspect**.   
1. Select **Save**. This configuration enables TLS termination for all traffic categories except Education, Finance, Government, and Health and medicine.
:::image type="content" source="media/how-to-transport-layer-security/inspection-policy.png" alt-text="Screenshot of the Create a TLS inspection policy screen open to the Review tab.":::   

### Step 3: Global Secure Access admin: link the TLS inspection policy to a security profile
Link the TLS inspection policy to a security profile. 

Before enabling TLS inspection on user traffic, ensure that your organization has established and communicated an appropriate Terms of Use (ToU) for end users. This helps maintain transparency and supports compliance with privacy and consent requirements. 

You can link the TLS policy to a security profile in two ways:
#### Option 1: Link the TLS policy to the baseline profile for all users   
With this method, the baseline profile policy is evaluated last and applies to all user traffic.   
1. In the Microsoft Entra admin center, navigate to **Secure** > **Security profiles**.   
1. Switch to the **Baseline profile** tab.
1. Select **Edit profile**.
1. In the **Link policies** view, select **+ Link a policy** > **Existing TLS inspection policy**.
1. In the Link a TLS inspection policy view, choose a TLS policy and assign it a priority.   
1. Select **Add**.   
:::image type="content" source="media/how-to-transport-layer-security/security-profile-baseline.png" alt-text="Screenshot of the Edit Baseline profile screen showing a list of policy names and their priorities.":::   

#### Option 2: Link the TLS policy to a security profile for specific users or groups
Alternatively, you can add a TLS policy to a security profile and link it to a [conditional access policy](how-to-configure-web-content-filtering.md#create-and-link-conditional-access-policy) for a specific user or group.    
:::image type="content" source="media/how-to-transport-layer-security/conditional-access-group-assignment.png" alt-text="Screenshot of the new conditional access policy form with all fields completed with sample information.":::   

### Step 4: Test the configuration
To test the configuration:
1. Make sure the end user device has the root certificate installed in the Trusted Root Certification Authorities folder.
:::image type="content" source="media/how-to-transport-layer-security/trusted-store.png" alt-text="Screenshot of the Trusted Root Certification Authorities folder.":::   

1. Set up the Global Secure Access client:
    - Disable secure DNS and built-in DNS.  
    - Block QUIC traffic from your device. QUIC isn't supported in Microsoft Entra Internet Access. Most websites support fallback to TCP when QUIC can't be established. For an improved user experience, deploy a Windows Firewall rule that blocks outbound UDP 443: @New-NetFirewallRule -DisplayName "Block QUIC" -Direction Outbound -Action Block -Protocol UDP -RemotePort 443.   
    - Ensure Internet Access Traffic Forwarding is enabled.   
1. Open a browser on a client device and test various websites. Inspect the certificate information and confirm the Global Secure Access certificate.
:::image type="content" source="media/how-to-transport-layer-security/certificate-viewer.png" alt-text="Screenshot of the Certificate Viewer with the Global Secure Access certificate highlighted.":::    

## Disable TLS inspection
To disable TLS inspection:
1. Remove the policy link from the security profile:   
    1. Browse to **Global Secure Access** > **Secure** > **Security profiles**.   
    1. Switch to the **Baseline profile** tab.   
    1. Select **Edit profile**.   
    1. Select the **Link policies** view.
    1. Select the **Delete** icon for the policy you're disabling.
    1. Select **Delete** to confirm.
1. Remove the TLS inspection policy:
    1. Browse to **Global Secure Access** > **Secure** > **TLS inspection policies**.
    1. Select **Actions**.
    1. Select **Delete**.   
1. Remove the TLS inspection policy certificate:
    1. Switch to the **TLS inspection settings** tab.
    1. Select **Actions**.
    1. Select **Delete**.      

## Test with a self-signed root certificate authority using OpenSSL
For **testing purposes only**, use a self-signed root certificate authority (CA) created by OpenSSL to sign the CSR. To test with OpenSSL:
1. If you don't already have one, create an *openssl.cnf* file with the following configuration:
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
```openssl req -x509 -new -nodes -newkey rsa:4096 -keyout rootCA.key -sha256 -days 365 -out rootCA.crt -subj “/C=US/ST=US/O=Self Signed/CN=Self Signed Root CA” -config openssl.cnf -extensions rootCA_ext```   
1. Sign *csr.txt* with the following command:   
```openssl x509 -req -in csr.txt -CA _rootCA.crt_ -CAkey rootCA.key -CAcreateserial -out signedcertificate.crt -days 365 -sha256 -extfile openssl.cnf -extensions signedCA_ext```   
1. Rename *signedcertificate.crt* to *signedcertificate.pem* and *rootCA.crt* to *rootCA.pem*. Upload the signed certificates according to the steps in [Create a CSR and upload the signed certificate for TLS termination](#step-1-global-secure-access-admin-create-a-csr-and-upload-the-signed-certificate-for-tls-termination).

## Related content

* [What is Transport Layer Security inspection?](concept-transport-layer-security.md)
* [Frequently asked questions for Transport Layer Security inspection](faq-transport-layer-security.yml)
