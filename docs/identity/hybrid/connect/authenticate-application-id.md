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
Entra Connect uses the [Microsoft Entra Connector account](entra/identity/hybrid/connect/reference-connect-accounts-permissions#accounts-used-for-microsoft-entra-connect.md) to authenticate and sync identities from Active Directorty to Entra ID. This account uses username and password to authenticate requests. To enhance the security of the service, we are rolling out an application identity that uses Oauth 2.0 client credential flow with certificate credentials. In this new method, Entra or Administrator will create a single tenant 3rd party application in Entra ID and use one of the relevant certificate management options below for the credentials.

Microsoft Entra Connect provides 3 options for application/certificate management: 

1. [Managed by Microsoft Entra Connect (Recommended)](#managed-by-microsoft-entra-connect-recommended)
2. [Bring Your Own Application (BYOA)](#bring-your-own-application-byoa)
3. [Bring Your Own Certificate (BYOC)](#bring-your-own-certificate-byoc)

## Managed by Microsoft Entra Connect (Recommended) 
Microsoft Entra Connect manages the application and certificate including creation, rotation and deletion of the certificate. The certificate is stored in the Current User store. For optimal protection of the certificate’s private key, it is recommended that the machine employs a Trusted Platform Module (TPM) solution to establish a hardware-based security boundary. When a TPM is available, key service operations are performed within a dedicated hardware environment. In contrast, if a TPM cannot be used, Entra Connect defaults to storing the certificate in the Current User store and marks the private key as non-exportable for additional protection. However, without the hardware isolation provided by a TPM, the private key is secured solely by software safeguards and does not achieve the same level of protection. For more information on TPM, see [Trusted Platform Module Technology Overview](/windows/security/hardware-security/tpm/trusted-platform-module-overview). 

 :::image type="content" source="media/authenticate-application-id/auth-1.png" alt-text="Diagram of authentication with application id." lightbox="media/authenticate-application-id/auth-1.png":::

Microsoft recommendeds the Microsoft Entra Connect certificate management option as we manage the keys and automatically rotate the certificate on expiry.

The Microsoft Entra Managed is set up during initial installation or upgrade process on the Entra Connect Connect Wizard as shown below

*Installation Wizard Image*

This can also be set up during a second pass on the wizard as shown below

*Second pass Wizard image*

## Bring Your Own Application (BYOA) 
In this set up, the customer administrator manages the application that will be used by Entra Connect Sync to authenticate to Entra, the application permissions and certificate credential used by the application. 

## Bring Your Own Certificate (BYOC) 

In this set up, the administrator manages the certificate credential used by the application. The administrator is responsible for creating the certificate, rotation and deletion of unused/expired certificates. The certificate should be stored in the Current User store. The admistrator is responsible for securing the private key of the certificate and ensuring only Microsoft Azure AD Sync service can access the private key for signing. 
> [!NOTE]
> - It is recommended to use the TPM to provide a hardware-based security boundary, as opposed to the Current User store. To check the status of your TPM use the [Get-TPM](/powershell/module/trustedplatformmodule/get-tpm?view=windowsserver2025-ps) PowerShell cmdlet. If using Hyper-V VMs, the TPM can be enabled by checking Security &gt; Enable Trusted Platform Module. This can only be done on a  generation 2 virtual machines. Generation 1 virtual machines can't be converted to a generation 2 virtual machines. For more information see [Generation 2 virtual machine security settings for Hyper-V](/windows-server/virtualization/hyper-v/learn-more/generation-2-virtual-machine-security-settings-for-hyper-v) and [Enable Trusted launch on existing Azure Gen2 VMs](/azure/virtual-machines/trusted-launch-existing-vm)


## Prerequisites
The following prerequisites are required to implement authentication using application identity.

- [Microsoft Entra Connect](https://www.microsoft.com/download/details.aspx?id=47594) version [x.x.x.x](reference-connect-version-history.md) or greater.
- Microsoft Entra account with at least a [Hybrid Identity Administrator](../../role-based-access-control/permissions-reference.md#hybrid-identity-administrator) role.
- On-premises Active Directory Domain Services environment with Windows Server 2016 operating system or later. 

The following are additional requirements for the BYOC certificate management option
- A certificate is created in an HSM or TPM using a CNG provider and the private key is marked as non-exportable. The following certificate configurations are supported:
  - KeyLength: 2048
  - KeyAlgorithm: RSA
  - KeyHashAlgorithm: SHA256
- Grant the ADSync service account permission to perform signing using the private key
- A certificate can also be created in the Current User (not recommended). See [Create a self-signed public certificate to authenticate your application](/entra/identity-platform/howto-create-self-signed-certificate). A warning event 1014 will be emitted if TPM is not used.

The following are additional requirements for the BYOA application management option
- The customer creates a certificate as instructed in BYOC Prerequisites above.
- Customer registers an application with Entra and creates service principal.
- Customer registers the certificate with the application 

## Onboarding to Application Based Authentication using PowerShell
Microsoft Entra Connect uses username and password by default for authenticating to Microsoft Entra ID. To onboard to Application Based Authentication, an administrator needs to perform the following steps.

> [!NOTE]
> Ensure that you're on the Microsoft Entra Connect server and the ADSync PowerShell module is installed.

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
   Add-EntraApplicationRegistration –UserPrincipalName <AdminUserPrincipalName>
```
 - Use BYOC:
 
 > [!NOTE] 
 > The certificate SHA256Hash needs to be provided when registering the application. 

 ``` powershell
  Add-EntraApplicationRegistration –UserPrincipalName <AdminUserPrincipalName> -CertificateSHA256Hash <CertificateSHA256Hash>
 ```
Replace &lt;AdminUserPrincipalName&gt; with the AdminUserPrincipalName and &lt;CertificateSHA256Hash&gt; with the CertificateSHA256Hash 

4. Link Entra Application with Microsoft Entra Connect Sync using Administrator credentials. 

 - Managed by Microsoft Entra Connect:
 ``` powershell
  Add-ADSyncApplicationRegistration –UserPrincipalName <AdminUserPrincipalName>
 ```
 - Use BYOC:
 
``` powershell
   Add-ADSyncApplicationRegistration –UserPrincipalName <AdminUserPrincipalName> -CertificateSHA256Hash <CertificateSHA256Hash> ```

Replace &lt;AdminUserPrincipalName&gt; with the AdminUserPrincipalName and &lt;CertificateSHA256Hash&gt; with the CertificateSHA256Hash

5. Run a verification to confirm that you're now using application identity. Run the cmdlet below to get the current authentication and ensure it has the Connector Identity Type as **Application**. 

 ``` powershell
 Get-ADSyncEntraConnectorCredential
 ```

5. Re-enable the scheduler to begin synchronization service using command below
 ``` powershell
 Set-ADSyncScheduler -SyncCycleEnabled $true
 ```

 ## Certificate Rotation using PowerShell
Microsoft Entra Connect will warn if the certificate rotation is due. That is, expiring in less than or equal to 150 days. It will emit an error if certificate is already expired. These warnings (Event Id 1011) and errors (Event Id 1012) can be found in the Application event log. This message will be emitted at the scheduler frequency if maintenance is enabled, and the scheduler isn't suspended. Run `Get-ADSyncSchedulerSettings` to see if scheduler is suspended or maintenance is enabled or disabled.

When you get a warning from Microsoft Entra Connect Sync when using the BYOC option, it's **highly recommended you generate a new key and certificate and rotate the certificate** used by Connect Sync using PowerShell.

If the certificate is managed by Microsoft Entra Connect, **no action** is required from your end unless the scheduler is suspended or maintenance disabled. If this is the case, you'll have to manually manage certificate rotation by going through the steps below.


1. Disable the scheduler to ensure no sync cycles run until this change is completed. Use the following PowerShell cmdlet to disable the scheduler.

 ``` powershell
 Set-ADSyncScheduler -SyncCycleEnabled $false
 ```
2. Invoke certificate credential rotation. When the customer is in BYOC mode, the new certificate SHA256Hash must be provided.

 ``` powershell
 Invoke-ADSyncApplicationCredentialRotation –UserPrincipalName <AdminUserPrincipalName> -CertificateSHA256Hash &lt;CertificateSHA256Hash>
 ```

Replace &lt;AdminUserPrincipalName&gt; with the UserPrincipalName of the Microsoft Entra ID hybrid administrator, &lt;CertificateSHA256Hash&gt; with the CertificateSHA256Hash 

The new certificate SHA256Hash is optional if you have used the default mode but have maintenance disabled.

3. Get the current authentication and confirm it has the Connector Identity Type as **Application**. Use the following PowerShell cmdlet to verify the current authentication.
 
 ``` powershell
 Get-ADSyncEntraConnectorCredential
 ```
4. Re-enable the scheduler to begin synchronization service. 

 ``` powershell
 Set-ADSyncScheduler -SyncCycleEnabled $true
 ```
5. Verify synchronization cycle is successful.
6. Remove the old certificate from Current User store

You may rotate the certificate at any point in time as deemed necessary, even if the current certificate is still not due for rotation or the current certificate has already expired.

## Certificate revocation process
The certificate revocation process allows Authentication Policy Administrators to revoke a previously issued certificate from being used for future authentication. The certificate revocation won't revoke already issued tokens of the user. For more information on this process see [Understanding the certificate revocation process](../../authentication/concept-certificate-based-authentication-technical-deep-dive.md#understanding-the-certificate-revocation-process)

## Roll back to legacy service account using PowerShell
If you want to go back to the legacy service account, you have the option to revert to using service account to mitigate the issue promptly using PowerShell. Use the steps below to roll back to the service account.

1. Disable the scheduler with below command to ensure no sync cycles run until this change is completed
 
 ``` powershell
 Set-ADSyncScheduler -SyncCycleEnabled $false
 ```
2. Add the service account username and password by entering below commands

 ``` powershell 
 $HACredential
 ```
3. You'll be prompted to enter your Microsoft Entra ID Administrator UserPrincipalName and the password. Enter the username and password.

4. Next, add the service account

 ``` powershell
Add-ADSyncAADServiceAccount -AADCredential $HACredential
 ```

5. Get the current authentication mechanism with below command and to confirm that the ConnectorIdentityType is back to **ServiceAccount**.
 
 ``` powershell
Get-ADSyncEntraConnectorCredential
 ```
6. Re-enable the scheduler to begin synchronization service using command below

 ``` powershell
 Set-ADSyncScheduler -SyncCycleEnabled $true
 ```

## Remove legacy service account using PowerShell
Once you have transitioned to Application Based Authentication and Sync is working as expected, you may remove the old username and password service account using PowerShell.
Use the steps below to remove the legacy service account.

1. Add the service account username and password by entering below commands

 ``` powershell 
 $HACredential
 ```
 2. You'll be prompted to enter your Microsoft Entra ID Administrator UserPrincipalName and the password. Enter the username and password.

 3. Next, add the service account

 ``` powershell
 Remove-ADSyncAADServiceAccount -AADCredential $HACredential -Name <$serviceAccountName>
 ```

The ServiceAccountName is the first part of the UserPrincipalName of the service account used in Microsoft Entra ID. You can find this user in the list of users in Entra Portal. If UPN is contoso@fabrikam.com then use **contoso** as the ServiceAccountName

## Next steps

- [What is Microsoft Entra Connect V2?](whatis-azure-ad-connect-v2.md)
- [Microsoft Entra Connect cloud sync](/azure/active-directory/cloud-sync/what-is-cloud-sync)
- [Microsoft Entra Connect version history](reference-connect-version-history.md)
