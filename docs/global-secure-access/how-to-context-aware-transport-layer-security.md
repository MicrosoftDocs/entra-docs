---
title: Context Aware Transport Layer Security Inspection (Preview)
description: Learn how to create a context aware Transport Layer Security inspection policy and assign it to users in your organization.
author: HULKsmashGithub
ms.author: jayrusso
ms.service: global-secure-access
ms.topic: how-to 
ms.reviewer: teresayao
ms.date: 02/06/2025


#customer intent: As a <role>, I want <what> so that <why>.
---

# Context aware Transport Layer Security inspection (Preview)
> [!IMPORTANT]
> The context aware Transport Layer Security inspection policy feature is currently in PREVIEW.   
> This information relates to a prerelease product that might be substantially modified before it's released. Microsoft makes no warranties, expressed or implied, with respect to the information provided here.

A significant percentage of internet traffic is encrypted. By terminating Transport Layer Security (TLS) at the edge, Global Secure Access can inspect and apply security policies to decrypted traffic, which allows for threat detection, content filtering, and granular access controls.
 
This article shows how to create a context aware Transport Layer Security inspection policy and assign the policy to users in your organization.

## Prerequisites
To test the functionality provided in this preview, you'll need the following high-level prerequisites: 
- A Microsoft Entra tenant that has been onboarded to the TLS Inspection Private Preview. We have done this for you already for the tenant you have shared with us.  
- An Azure Subscription associated with the tenant. This is required to store your root or intermediate CA certificate within an Azure Key Vault.  
- One or more test devices (or virtual machines) running Windows 10 or 11 that are Entra ID Joined or Entra ID Hybrid Joined to the tenant.  
- Trial Entra Internet Access licenses.  
- [Global Secure Access prerequisites](how-to-configure-web-content-filtering.md). 

## Create a context aware TLS inspection policy
[Introduce the procedure: need some additional into language here.]

### Step 1: Enable the TLS inspection portal link
The first step in the process is to enable the TLS inspection portal link.
1. Go to https://aka.ms/TLSpreview-portal and 
1. [I need specific steps here]. 

### Step 2: Global Secure Access admin: upload a certificate for TLS termination
The next step is to upload a certificate for TLS termination.
1. Sign in to the [Microsoft Azure portal](http://portal.azure.com/) with the tenant's admin credentials.  
1. Create a Key Vault in the Azure subscription.  
1. Add permissions under Access control (IAM) > + Add.  
    1. Add the following permissions to the Microsoft's Service Principal (ZTNA Network Access Control Plane) to give access to use CA certificate for TLS termination:   
        - Key Vault Certificates User   
        - Key Vault Secrets User    
    1. Add Key Vault Certificates Officer role to your administrator account for uploading the certificate   
1. Upload a test CA certificate (Please don't use a production certificate. The cert must have a blank password and include the Private Key.) If you have no access to a testing CA, a self-signed certificate can be created for testing purposes using the script in the appendix. Once the certificate is saved in your KeyVault, copy the certificate identifier URL:  Certificates > Import > Add certificate with empty password > Save.   
1. While on the certificate properties, select “Download in CER format” to download the certificate. You will need to import this certificate on all your test devices from the Trusted Root Certificates store.   
1. Sign in to the [Microsoft Entra admin center](http://entra.microsoft.com/) with the tenant's admin credentials.   
1. Navigate to **Global Secure Access** > **Global settings** > **Session management**.   
1. Switch to the **TLS Inspection** tab and enter a **key vault URL** in the input field.
1. Select **Save**. 
:::image type="content" source="media/how-to-context-aware-transport-layer-security/key-vault.png" alt-text="Screenshot of the Session Management screen open to the TLS Inspection tab.":::   

### Step 3: Global Secure Access admin: create a TLS inspection policy
Next, create a TLS inspection policy.
1. In the Microsoft Entra admin center, navigate to **Secure** > **TLS inspection policies**.   
1. Create a new policy with **Action** set to “Inspect”.   
1. Select **Save**. 
This configuration enables TLS termination for all traffic categories except Education, Finance, Government, and Health and medicine.
:::image type="content" source="media/how-to-context-aware-transport-layer-security/inspection-policy.png" alt-text="Screenshot of the Create a TLS inspection policy screen open to the Review tab.":::   

### Step 4: Global Secure Access admin: assign the TLS inspection policy

### Step 5: Global Secure Access admin: create a conditional access policy

### Step 6: Test the configuration

## Test cases
1. As an end user, navigate to https://www.linked.com. Inspect the certificate information and confirm the Global Secure Access certificate.
:::image type="content" source="media/how-to-context-aware-transport-layer-security/certificate-viewer-linkedin.png" alt-text="Screenshot of the Certificate Viewer with the Global Secure Access certificate highlighted.":::    
1. As an end user, navigate to a site that belongs to one of the bypassed categories: Education, Finance, Government, Health and medicine, and confirm that the certificate is the original certificate.   
:::image type="content" source="media/how-to-context-aware-transport-layer-security/certificate-viewer-rutgers.png" alt-text="Screenshot of the Certificate Viewer with the original certificate highlighted.":::   
1. Create and test a web content filtering rule:
    1. As a Global Secure Access admin, create a web content filtering rule to block job search categories. Link the rule to a security profile, associating it with a conditional access policy for the user.  
    1. As an end user, navigate to https://www.linkedin.com. You should be able to access the page. Then navigate to https://www.linked.com/jobs. The block JobSearch category rule blocks your access based on the URL, now available after TLS termination.   
    1. As a Global Secure Access admin, check the traffic logs from the Microsoft Entra admin center.
    :::image type="content" source="media/how-to-context-aware-transport-layer-security/traffic-logs.png" alt-text="Screenshot of the traffic logs from the Microsoft Entra admin center."::: 


## Clean up resources
To disable TLS inspection:
1. In the [Microsoft Entra admin center](entra.microsoft.com), navigate to **Global Secure Access** > **Security Profiles** and remove the link to the TLS inspection policy.   
1. Delete TLS inspection policy.    
1. Under **Global settings/Session control**, clear the **keyvault URL** value from the **Input** box. 
1. Select **Save**.   

## Related content
* [Related article title](link.md)
* [Related article title](link.md)
* [Related article title](link.md)
