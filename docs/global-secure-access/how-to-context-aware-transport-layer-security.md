---
title: Context Aware Transport Layer Security Inspection (Preview)
description: Learn how to create a context aware Transport Layer Security inspection policy and assign it to users in your organization.
author: HULKsmashGithub
ms.author: jayrusso
ms.service: global-secure-access
ms.topic: how-to 
ms.reviewer: teresayao
ms.date: 02/10/2025


#customer intent: As a Global Secure Access administrator, I want to create a context aware Transport Layer Security inspection policy and assign the policy to users in my organization.   
---

# Context aware Transport Layer Security inspection (Preview)
> [!IMPORTANT]
> The context aware Transport Layer Security inspection policy feature is currently in PREVIEW.   
> This information relates to a prerelease product that might be substantially modified before release. Microsoft makes no warranties, expressed or implied, with respect to the information provided here.

A significant percentage of internet traffic is encrypted. By terminating Transport Layer Security (TLS) at the edge, Global Secure Access can inspect and apply security policies to decrypted traffic, which allows for threat detection, content filtering, and granular access controls.
 
This article shows how to create a context aware Transport Layer Security inspection policy and assign the policy to users in your organization.

## Prerequisites
To test the functionality provided in this preview, you need the following high-level prerequisites: 
- A Microsoft Entra tenant onboarded to the TLS Inspection Private Preview. We've completed this setup for you in the tenant you shared with us.  
- An Azure Subscription associated with the tenant. The subscription is required to store your root or intermediate Conditional Access (CA) certificate within an Azure Key Vault.  
- One or more test devices (or virtual machines) running Windows 10 or 11 that are Microsoft Entra ID Joined or Microsoft Entra ID Hybrid Joined to the tenant.  
- A trial license for Microsoft Entra Internet Access.  
- [Global Secure Access prerequisites](how-to-configure-web-content-filtering.md). 

## Create a context aware TLS inspection policy
To create a context aware Transport Layer Security inspection policy and assign the policy to users in your organization, complete the following steps:
1. [Enable the TLS inspection portal link](#step-1-enable-the-tls-inspection-portal-link)
1. [Upload a certificate for TLS termination](#step-2-global-secure-access-admin-upload-a-certificate-for-tls-termination)
1. [Create a TLS inspection policy](#step-3-global-secure-access-admin-create-a-tls-inspection-policy)
1. [Assign the TLS inspection policy](#step-4-global-secure-access-admin-assign-the-tls-inspection-policy)
1. [Create a conditional access policy](#step-5-global-secure-access-admin-create-a-conditional-access-policy)
1. [Test the configuration](#step-6-test-the-configuration)

### Step 1: Enable the TLS inspection portal link
The first step in the process is to enable the TLS inspection portal link.
1. Go to https://aka.ms/TLSpreview-portal and [I need **specific steps** here]. 

### Step 2: Global Secure Access admin: upload a certificate for TLS termination
The next step is to upload a certificate for TLS termination.
1. Sign in to the [Microsoft Azure portal](https://portal.azure.com/) with the tenant's admin credentials.  
1. Create a Key Vault in the Azure subscription.  
1. Add permissions under Access control (IAM) > + Add.  
    1. Add the following permissions to the Microsoft's Service Principal (ZTNA Network Access Control Plane) to give access to use Conditional Access certificate for TLS termination:   
        - Key Vault Certificates User   
        - Key Vault Secrets User    
    1. Add Key Vault Certificates Officer role to your administrator account for uploading the certificate   
1. Upload a test CA certificate. (Don't use a production certificate. The certificate must have a blank password and include the Private Key.) If you have no access to a testing CA certificate, a self-signed certificate can be created for testing purposes using the script in the appendix. Once the certificate is saved in your KeyVault, copy the certificate identifier URL: Certificates > Import > Add certificate with empty password > Save.   
1. While on the certificate properties, select “Download in CER format” to download the certificate. You need to import this certificate on all your test devices from the Trusted Root Certificates store.   
1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as a [Global Secure Access Administrator](../identity/role-based-access-control/permissions-reference.md#global-secure-access-administrator).   
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
Next, assign the TLS inspection policy. There are two options to link the TLS policy to a security profile:
#### Option 1: Link the TLS policy to the baseline profile.   
With this method, the baseline profile policy is evaluated last and applies to all user traffic.   
1. In the Microsoft Entra admin center, navigate to **Secure** > **Security Profiles**.
1. Select **Edit Baseline profile**.
1. In the **Link policies** view, link the TLS policy and assign a desired priority to the security profile.
:::image type="content" source="media/how-to-context-aware-transport-layer-security/baseline-profile.png" alt-text="Screenshot of the Link policies view showing a list of policy names and their priorities.":::   

#### Option 2: Selective TLS inspection for users/groups
1. In the Microsoft Entra admin center, navigate to **Secure** > **Security Profiles**.
1. Select **Edit User Profile**.
1. In the **Link policies** view, link the TLS policy and assign a desired priority to the security profile.
:::image type="content" source="media/how-to-context-aware-transport-layer-security/user-profile.png" alt-text="Screenshot of the Link policies view showing a list of policy names and their priorities.":::   

### Step 5: Global Secure Access admin: create a conditional access policy
In this step, create a conditional access policy for a specific user, group, or other conditional access context condition and assign the Global Secure Access security profile.   
[I need **specific steps** here]

### Step 6: Test the configuration
For the final step, test the configuration.
1. Make sure the end user device has Conditional Access Cert installed. 
1. Set up the Global Secure Access client:
    - Disable Secure DNS and built-in DNS.   
    - Block QUIC traffic from your device. QUIC isn't supported yet in Microsoft Entra Internet Access. Most websites support fallback to TCP when QUIC can't be established. For improved user experience, you can deploy a Windows Firewall rule that blocks outbound UDP 443: @New-NetFirewallRule -DisplayName "Block QUIC" -Direction Outbound -Action Block -Protocol UDP -RemotePort 443.   
    - Ensure Internet Access Traffic Forwarding is enabled.   
    - Point the service to the EAP environment. 
> [!NOTE]
> This step will be unnecessary once the feature is generally available. 
    - From the following list, select an IP address that is close to your location:

|IP address    |City    |
|---------|---------|
|151.206.33.221    |Chicago, IL United States (Central)    |
|151.206.32.13    |Manassas, VA United States (East)    |
|151.206.35.32    |Pune, India    |
|151.206.34.89    |Frankfurt, Germany    |
|151.206.32.19    |San Jose, CA United States (West)    |
|151.206.35.20    |Singapore, Singapore    |

    -  Open C:\Windows\System32\drivers\etc\hosts in admin mode and append:    
    <IP address> <tenantid>.internet.client.globalsecureaccess.microsoft.com   
    Note: the <tenantid> should be the same Tenant ID provided for preview onboarding.

3. Open a browser on a client device and visit the example websites for testing. See the [Test cases](#test-cases) section for examples. 

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
1. In the [Microsoft Entra admin center](https://entra.microsoft.com/), navigate to **Global Secure Access** > **Security Profiles** and remove the link to the TLS inspection policy.   
1. Delete TLS inspection policy.    
1. Under **Global settings/Session control**, clear the **keyvault URL** value from the **Input** box. 
1. Select **Save**.   

## Appendix
### Feedback
To provide feedback, complete the five-minute [TLS Inspection survey](https://forms.office.com/r/MxHhn67E8X).

## Create a self-signed test CA certificate
To create a new CA certificate, run the following PowerShell code on a Windows device and export it to C:\temp. Edit the code as required. 

```powershell
    $params = @{ 
    Type = 'Custom' 
    Subject = 'CN=TLSPreviewRootCA' 
    KeySpec = 'Signature' 
    KeyExportPolicy = 'Exportable' 
    KeyUsage = 'CertSign' 
    KeyUsageProperty = 'Sign' 
    KeyLength = 2048 
    HashAlgorithm = 'sha256' 
    NotAfter = (Get-Date).AddMonths(6) 
    CertStoreLocation = 'Cert:\CurrentUser\My' 
    TextExtension = @("2.5.29.19={text}CA=true") 
    } 
    $cert = New-SelfSignedCertificate @params 
    
    $pwd = New-Object System.Security.SecureString 
    Export-PfxCertificate -Cert $cert -FilePath C:\temp\ATPPreviewRootCA.pfx -Password $pwd  
```

## Related content
* [Global Secure Access Frequently asked questions](resource-faq.yml)
