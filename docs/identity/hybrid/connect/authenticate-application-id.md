---
title: 'Authenticate to Microsoft Entra ID using Application Identity'
description: This article describes how to allow the Microsoft Entra Connect application to authenticate with Microsoft Entra ID with modern, more secure credentials. 

author: billmath
manager: femila
ms.service: entra-id
ms.topic: conceptual
ms.tgt_pltfrm: na
ms.date: 12/16/2024
ms.subservice: hybrid
ms.author: billmath
---

# Authenticate to Microsoft Entra ID using Application Identity 

Microsoft Entra Connect provides 2 options for certificate management: 

1. Managed by Microsoft Entra Connect (Recommended) 
2. Bring Your Own Certificate (BYOC) 

## Managed by Microsoft Entra Connect (Recommended) 
Microsoft Entra Connect manages the application and certificate including creation, rotation and deletion of the certificate. The certificate is created in the Current User store with the private key securely stored inside the TPM. The private key is marked as non-exportable, which means it will never leave the TPM boundary. For more information on TPM, see [Trusted Platform Module Technology Overview](/windows/security/hardware-security/tpm/trusted-platform-module-overview). 

 :::image type="content" source="media/authenticate-application-id/authenticate-1.png" alt-text="Diagram of authentication with application id." lightbox="media/authenticate-application-id/authenticate-1.png":::

Microsoft recommendeds this certificate management option as we manage the keys and automatically roll over the certificate on expiry.

## Bring Your Own Certificate (BYOC) 

Microsoft Entra Connect Sync manages the application identity that will be used by Entra Connect Sync to authenticate to Microsoft Entra ID, and you manage the certificate credential used by the application. Your administrator is responsible for creating the certificate, rotation and deletion of unused/expired certificates. The certificate should be created in the Local Machine store. You are responsible for securing the private key of the certificate and ensuring only Microsoft Azure AD Sync service can access the private key for signing. 

## Prerequisites
The following prerequisites are required to implement authentication using application identity.

- [Microsoft Entra Connect](https://www.microsoft.com/download/details.aspx?id=47594) version [x.x.x.x](reference-connect-version-history.md) or greater.
- Microsoft Entra account with at least a [Hybrid Identity Administrator](../../role-based-access-control/permissions-reference.md#hybrid-identity-administrator) role.
- On-premises Active Directory Domain Services environment with Windows Server 2016 operating system or later. 
- Transport Layer Security,[TLS 1. 2](reference-connect-tls-enforcement.md)

The following are additional requirements depending on which certificate management option you select.

### Managed by Entra Connect Sync Prerequisites 
- TPM 2.0 is present and ready to use.  To check the status of your TPM use the [Get-TPM](/powershell/module/trustedplatformmodule/get-tpm?view=windowsserver2025-ps) PowerShell cmdlet.
- Maintenance is enabled and the scheduler is not suspended.

> [!NOTE]
> If using Hyper-V VMs, the TPM can be enabled by checking Security > Enable Trusted Platform Module. This can only be done on a Gen 2 VMs. Gen 1 VMs cannot be converted to a Gen 2 VMs. 

### II.	BYOC Prerequisites
- A certificate is created in an HSM using a CNG provider and the private key is marked as non-exportable. The following certificate configurations are supported:
    a.	KeyLength: 2048
    b.	KeyAlgorithm: RSA
    c.	KeyHashAlgorithm: SHA256

For more information on creating a certificate on the local machine, see [Create a self-signed public certificate to authenticate your application](h/entra/identity-platform/howto-create-self-signed-certificate)

## Onboarding to Certificate Based Authentication
Microsoft Entra Connect uses username and password by default for authenticating to Microsoft Entra ID. To onboard to Certificate Based Authentication, an administrator needs to perform the following steps.

> [!NOTE]
> Ensure that you are on the Microsoft Entra Connect server and the ADSync PowerShell module is installed.

1. Use the PowerShell command below to verify the current authentication method
 
 ``` powershell
 Get-ADSyncEntraConnectorCredential
 ```
 This should return the Connector Identity Type as **ServiceAccount**. 

2. Disable the scheduler to ensure no sync cycles run until this change is completed.

 ``` powershell
Set-ADSyncScheduler -SyncCycleEnabled $false
 ```

3. Register an application and create a service principal in Microsoft Entra ID.

  - Managed by Microsoft Entra Connect:
    
     ``` powershell
     Add-EntraApplicationRegistration –UserPrincipalName &lt;AdminUserPrincipalName&gt;
     ```

  - Use BYOC:
  
  > [!NOTE] 
  > The certificate thumbprint needs to be provided when registering the application. 

     ``` powershell
     Add-EntraApplicationRegistration –UserPrincipalName &lt;AdminUserPrincipalName&gt; -CertificateThumbprint &lt;certificateThumbprint&gt;
     ```

Replace &lt;AdminUserPrincipalName&gt; with the UserPrincipalName of the Entra administrator and &lt;certificateThumbprint&gt; with the CertificateThumbPrint 

4. Link Entra Application with Microsoft Entra Connect Sync using Administrator credentials. 

  - Managed by Microsoft Entra Connect:
 ``` powershell
 Add-ADSyncApplicationRegistration –UserPrincipalName &lt;AdminUserPrincipalName&gt;
 ```
  - Use BYOC:
 
 ``` powershell
 Add-ADSyncApplicationRegistration –UserPrincipalName &lt;AdminUserPrincipalName&gt; -CertificateThumbprint &lt;certificateThumbprint&gt; 
 ```
Replace &lt;AdminUserPrincipalName&gt; with the UserPrincipalName of the Entra administrator, &lt;certificateThumbprint&gt; with the CertificateThumbPrint 

5. Run a verification to confirm that we are now using application identity. Run the cmdlet below to get the current authentication and ensure it has the Connector Identity Type as **Application**. 

 ``` powershell
 Get-ADSyncEntraConnectorCredential
 ```

5. Re-enable the scheduler to begin synchronization service using command below
 ``` powershell
 Set-ADSyncScheduler -SyncCycleEnabled $true
 ```