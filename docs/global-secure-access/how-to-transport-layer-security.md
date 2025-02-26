---
title: Configure Transport Layer Security Inspection (Preview)
description: Learn how to configure a Transport Layer Security inspection policy and assign it to users in your organization.
author: HULKsmashGithub
ms.author: jayrusso
ms.service: global-secure-access
ms.topic: how-to 
ms.reviewer: teresayao
ms.date: 02/25/2025


#customer intent: As a Global Secure Access administrator, I want to configure a context aware Transport Layer Security inspection policy and assign the policy to users in my organization.   
---

# Configure Transport Layer Security inspection (Preview)
> [!IMPORTANT]
> The Transport Layer Security inspection feature is currently in PREVIEW.   
> This information relates to a prerelease product that might be substantially modified before release. Microsoft makes no warranties, expressed or implied, with respect to the information provided here.

A significant percentage of internet traffic is encrypted. By terminating Transport Layer Security (TLS) at the edge, Global Secure Access can inspect and apply security policies to decrypted traffic, which allows for threat detection, content filtering, and granular access controls.
 
This article shows how to create a context aware Transport Layer Security inspection policy and assign the policy to users in your organization.

## Prerequisites
To test the functionality provided in this preview, you need the following high-level prerequisites: 
- A Microsoft Entra tenant onboarded to the TLS Inspection preview.     
- An Azure Subscription associated with the tenant. The subscription is required to store your root or intermediate Conditional Access (CA) certificate within an Azure Key Vault.  
- One or more test devices (or virtual machines) running Windows 10 or 11 that are Microsoft Entra ID Joined or Microsoft Entra ID Hybrid Joined to the tenant.  
- A trial license for Microsoft Entra Internet Access.  
- [Global Secure Access prerequisites](how-to-configure-web-content-filtering.md). 

## Create a context aware TLS inspection policy
To create a context aware Transport Layer Security inspection policy and assign the policy to users in your organization, complete the following steps:
1. [Upload a certificate for TLS termination](#step-2-global-secure-access-admin-upload-a-certificate-for-tls-termination)
1. [Create a TLS inspection policy](#step-3-global-secure-access-admin-create-a-tls-inspection-policy)
1. [Assign the TLS inspection policy](#step-4-global-secure-access-admin-assign-the-tls-inspection-policy)
1. [Create a conditional access policy](#step-5-global-secure-access-admin-create-a-conditional-access-policy)
1. [Test the configuration](#step-6-test-the-configuration)

### Step 1: Global Secure Access admin: upload a certificate for TLS termination
The next step is to upload a certificate for TLS termination.
1. Sign in to the [Microsoft Azure portal](https://portal.azure.com/) with the tenant's admin credentials.  
1. Create a [key vault in the Azure subscription](/azure/key-vault/general/quick-create-portal).  
1. In the key vault configuration, navigate to **Access control (IAM)** and select **+ Add**.     
    1. Add the following permissions to the Microsoft Service Principal (Zero Trust Network Access (ZTNA) control plane) to give access to use Conditional Access certificate for TLS termination:   
        - Key Vault Certificates User   
        - Key Vault Secrets User    
    1. Add the Key Vault Certificates Officer role to your administrator account for uploading the certificate.   
1. Upload a test CA certificate. 
> [!NOTE]
> Don't use a production certificate. The test CA certificate must have an empty password and include the private key.
   
5. Once the certificate is saved in your key vault, copy the certificate identifier URL: navigate to **Certificates** > **Import** > **Add certificate with empty password** > **Save**.   
1. While viewing the certificate properties, select **Download in CER format** to download the certificate. You need to import this certificate on all your test devices from the Trusted Root Certificates store.   
1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as a [Global Secure Access Administrator](../identity/role-based-access-control/permissions-reference.md#global-secure-access-administrator).   
1. Navigate to **Global Secure Access** > **Settings** > **Session management**.   
1. Switch to the **TLS Inspection** tab and enter the key vault URL in the **Input** field.
1. Select **Save**. 
:::image type="content" source="media/how-to-transport-layer-security/key-vault.png" alt-text="Screenshot of the Session Management screen open to the TLS Inspection tab.":::   

### Step 2: Global Secure Access admin: create a TLS inspection policy
Next, create a TLS inspection policy.
1. In the Microsoft Entra admin center, navigate to **Secure** > **TLS inspection policies**.   
1. Create a new policy with **Action** set to **Inspect**.   
1. Select **Save**. 
This configuration enables TLS termination for all traffic categories except Education, Finance, Government, and Health and medicine.
:::image type="content" source="media/how-to-transport-layer-security/inspection-policy.png" alt-text="Screenshot of the Create a TLS inspection policy screen open to the Review tab.":::   

### Step 3: Global Secure Access admin: assign the TLS inspection policy
Next, assign the TLS inspection policy. There are two options to link the TLS policy to a security profile:
#### Option 1: Link the TLS policy to the baseline profile.   
With this method, the baseline profile policy is evaluated last and applies to all user traffic.   
1. In the Microsoft Entra admin center, navigate to **Secure** > **Security Profiles**.
1. Select **Edit Baseline profile**.
1. In the **Link policies** view, link the TLS policy and assign a desired priority to the security profile.   
:::image type="content" source="media/how-to-transport-layer-security/baseline-profile.png" alt-text="Screenshot of the Edit Baseline profile screen showing a list of policy names and their priorities.":::   

#### Option 2: Selective TLS inspection for users/groups
1. In the Microsoft Entra admin center, navigate to **Secure** > **Security Profiles**.
1. Select **Edit User Profile**.
1. In the **Link policies** view, link the TLS policy and assign a desired priority to the security profile.
:::image type="content" source="media/how-to-transport-layer-security/user-profile.png" alt-text="Screenshot of the Edit User Profile screen showing a list of policy names and their priorities.":::   

### Step 4: Global Secure Access admin: create a conditional access policy
In this step, [create a conditional access policy](how-to-configure-web-content-filtering#create-and-link-conditional-access-policy) for a specific user, group, or other conditional access context condition and assign the Global Secure Access security profile.  

### Step 5: Test the configuration
For the final step, test the configuration.
1. Make sure the end user device has Conditional Access Cert installed. 
1. Set up the Global Secure Access client:
    - Disable Secure DNS and built-in DNS.   
    - Block QUIC traffic from your device. QUIC isn't supported yet in Microsoft Entra Internet Access. Most websites support fallback to TCP when QUIC can't be established. For improved user experience, you can deploy a Windows Firewall rule that blocks outbound UDP 443: @New-NetFirewallRule -DisplayName "Block QUIC" -Direction Outbound -Action Block -Protocol UDP -RemotePort 443.   
    - Ensure Internet Access Traffic Forwarding is enabled.   
1. Open a browser on a client device and visit the example websites for testing. See the [Test cases](#test-cases) section for examples. 

## Validate the Global Secure Access certificate
As an end user, inspect the certificate information and confirm the Global Secure Access certificate.
:::image type="content" source="media/how-to-transport-layer-security/certificate-viewer.png" alt-text="Screenshot of the Certificate Viewer with the Global Secure Access certificate highlighted.":::    

## Disable TLS inspection
To disable TLS inspection:
1. In the [Microsoft Entra admin center](https://entra.microsoft.com/), navigate to **Global Secure Access** > **Security Profiles** and remove the link to the TLS inspection policy.   
1. Delete TLS inspection policy.    
1. Under **Global settings/Session control**, clear the **keyvault URL** value from the **Input** box. 
1. Select **Save**.   

## Related content
* [Learn more about Transport Layer Security Inspection](concept-microsoft-traffic-profile.md)
* [Transport Layer Security Inspection Frequently asked questions](resource-faq.yml)
