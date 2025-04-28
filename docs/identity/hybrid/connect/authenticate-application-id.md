---
title: 'Authenticate to Microsoft Entra ID using Application Identity'
description: This article describes how to allow the Microsoft Entra Connect application to authenticate with Microsoft Entra ID with modern, more secure credentials. 

author: billmath
manager: femila
ms.service: entra-id
ms.topic: conceptual
ms.tgt_pltfrm: na
ms.date: 04/25/2025
ms.subservice: hybrid
ms.author: billmath
---

# Authenticate to Microsoft Entra ID using Application Identity 

Entra Connect uses the [Microsoft Entra Connector account](reference-connect-accounts-permissions.md#accounts-used-for-microsoft-entra-connect) to authenticate and sync identities from Active Directory to Entra ID. This account uses username and password to authenticate requests. To enhance the security of the service, we're rolling out an application identity that uses Oauth 2.0 client credential flow with certificate credentials. In this new method, Entra or Administrator will create a single tenant third party application in Entra ID and use one of the relevant certificate management options below for the credentials.

Microsoft Entra Connect provides 3 options for application/certificate management: 

1. [Managed by Microsoft Entra Connect (Recommended)](#managed-by-microsoft-entra-connect-recommended)
2. [Bring Your Own Application (BYOA)](#bring-your-own-application-byoa)
3. [Bring Your Own Certificate (BYOC)](#bring-your-own-certificate-byoc)

## Managed by Microsoft Entra Connect (Recommended) 
Microsoft Entra Connect manages the application and certificate including creation, rotation and deletion of the certificate. The certificate is stored in the Current User store. For optimal protection of the certificate’s private key, it's recommended that the machine employs a Trusted Platform Module (TPM) solution to establish a hardware-based security boundary. When a TPM is available, key service operations are performed within a dedicated hardware environment. In contrast, if a TPM can't be used, Entra Connect defaults to storing the certificate in the default Microsoft Software Key Storage Provider and marks the private key as nonexportable for additional protection. However, without the hardware isolation provided by a TPM, the private key is secured solely by software safeguards and doesn't achieve the same level of protection. For more information on TPM, see [Trusted Platform Module Technology Overview](/windows/security/hardware-security/tpm/trusted-platform-module-overview). 

 :::image type="content" source="media/authenticate-application-id/auth-1.png" alt-text="Diagram of authentication with application ID." lightbox="media/authenticate-application-id/auth-1.png":::

Microsoft recommends the Entra Connect certificate management option as we manage the keys and automatically rotate the certificate on expiry. This is the default option in Entra Connect Sync versions equal to or higher than 2.4.252.0. 

> [!NOTE]
> We use the maintenance task to check if the certificate is due for rotation and automatically rotate the certificate, so if the scheduler is suspended or maintenance task is disabled, auto rotation won't happen even though the certificate is managed by Entra Connect Sync.

 ## Bring Your Own Application (BYOA) 

In this set up, the customer administrator manages the application that will be used by Entra Connect Sync to authenticate to Entra, the application permissions and certificate credential used by the application. The administrator [registers a Microsoft Entra app and creates a service principal.](../../../identity-platform/howto-create-service-principal-portal.md)


## Bring Your Own Certificate (BYOC) 


In this set up, the administrator manages the certificate credential used by the application. The administrator is responsible for creating the certificate, rotation, and deletion of unused/expired certificates. The certificate must be stored in the Local Machine store. The administrator is responsible for securing the private key of the certificate and ensuring only Microsoft Azure AD Sync service can access the private key for signing. 

> [!NOTE]
> it's recommended to use a TPM or an HSM to provide a hardware-based security boundary, as opposed to the default. To check the status of your TPM use the [Get-TPM](/powershell/module/trustedplatformmodule/get-tpm?view=windowsserver2025-ps) PowerShell cmdlet. If using Hyper-V VMs, the TPM can be enabled by checking Security &gt; Enable Trusted Platform Module. This can only be done on a generation 2 virtual machines. Generation 1 virtual machines can't be converted to a generation 2 virtual machines. For more information, see [Generation 2 virtual machine security settings for Hyper-V](/windows-server/virtualization/hyper-v/learn-more/generation-2-virtual-machine-security-settings-for-hyper-v) and [Enable Trusted launch on existing Azure Gen2 VMs](/azure/virtual-machines/trusted-launch-existing-vm)


## Prerequisites
The following prerequisites are required to implement authentication using application identity.

>[!IMPORTANT]
> New Microsoft Entra Connect Sync Versions will only be available via the Microsoft Entra admin center 
>
> Following up on our earlier [What’s New](../../../fundamentals/whats-new.md#general-availability---download-microsoft-entra-connect-sync-on-the-microsoft-entra-admin-center) communication, new versions of Microsoft Entra Connect Sync are only available on the [Microsoft Entra Connect blade](https://entra.microsoft.com/#view/Microsoft_AAD_Connect_Provisioning/AADConnectMenuBlade/%7E/GetStarted) within Microsoft Entra Admin Center and will no longer be released to the [Microsoft Download Center](https://www.microsoft.com/en-us/download/details.aspx?id=47594).

- [Microsoft Entra Connect](https://www.microsoft.com/download/details.aspx?id=47594) version [2.4.252.0](reference-connect-version-history.md) or greater.
- Microsoft Entra account with at least a [Hybrid Identity Administrator](../../role-based-access-control/permissions-reference.md#hybrid-identity-administrator) role.
- On-premises Active Directory Domain Services environment with Windows Server 2016 operating system or later.
- Optional: TPM 2.0 present and ready to use (recommended for security)

The following are additional requirements for the BYOC certificate management option
- A certificate is created in an HSM or TPM using a CNG provider and the private key is marked as non-exportable. A warning event 1014 will be emitted if TPM isn't used. The following certificate configurations are supported:
 - KeyLength: 2048
 - KeyAlgorithm: RSA
 - KeyHashAlgorithm: SHA256
- The created certificate is stored in the LocalMachine store
- Grant the ADSync service account permission to perform signing using the private key

The following are additional requirements for the BYOA application management option
- The customer creates a certificate as instructed in BYOC Prerequisites above.
- Customer registers an application with Entra and creates service principal.
- Customer registers the certificate with the application 


## Installation and upgrade (Managed by Microsoft Entra Connect)
The Microsoft Entra Connect Sync managed application and credential is automatically set up during initial installation for new installs. You can confirm that Microsoft Entra Connect is using the application identity by using the PowerShell cmdlet `Get-ADSyncEntraConnectorCredential`

 :::image type="content" source="media/authenticate-application-id/auth-2.png" alt-text="Screenshot of Get-ADSyncEntraConnectorCredential." lightbox="media/authenticate-application-id/auth-2.png":::

For upgrades, you can select the **Configure application based authentication to Microsoft Entra ID (Preview)** box.

 :::image type="content" source="media/authenticate-application-id/auth-3.png" alt-text="Screenshot of configuring application based authentication." lightbox="media/authenticate-application-id/auth-3.png":::

 If you didn't select the box during upgrade, you'll be shown the following recommendation once installation completes.

 :::image type="content" source="media/authenticate-application-id/auth-5.png" alt-text="Screenshot of recommendation." lightbox="media/authenticate-application-id/auth-5.png":::

If you didn't select the box during upgrade, or want to switch to application based authentication you can do this through tasks.

In tasks, select **Configure application based authentication to Microsoft Entra ID (Preview)** and then follow the prompts.

 :::image type="content" source="media/authenticate-application-id/auth-4.png" alt-text="Screenshot of configuring application based authentication under tasks." lightbox="media/authenticate-application-id/auth-4.png":::


### Onboarding to Application Based Authentication using PowerShell
This section is only relevant if using the BYOC or BYOA option. 
Microsoft Entra Connect versions lower than 2.4.252.0 use username and password by default for authenticating to Microsoft Entra ID. To onboard to Application Based Authentication, an administrator needs to perform the following steps on Microsoft Connect Sync version equal to or higher than 2.4.252.0.

> [!NOTE]
> Ensure that you're on the Microsoft Entra Connect server and the ADSync PowerShell module is installed.

1. Use the PowerShell command to verify the current authentication method.
 
 ``` powershell
 Get-ADSyncEntraConnectorCredential
 ```
 This should return the Connector Identity Type currently in use. 

2. Disable the scheduler to ensure no sync cycles run until this change is completed.

 ``` powershell
Set-ADSyncScheduler -SyncCycleEnabled $false
 ```

3. Register an application and create a service principal in Microsoft Entra ID.

 - Managed by Microsoft Entra Connect:
 
``` powershell
 Add-EntraApplicationRegistration
```
 - Use BYOC:
 
 > [!NOTE] 
 > The certificate SHA256Hash needs to be provided when registering the application. 

 ``` powershell
 Add-EntraApplicationRegistration -CertificateSHA256Hash &lt;CertificateSHA256Hash>
 ```
Replace &lt;CertificateSHA256Hash&gt; with the CertificateSHA256Hash 

4. Link Entra Application with Microsoft Entra Connect Sync using Administrator credentials. 

 - Managed by Microsoft Entra Connect:
 ``` powershell
 Add-ADSyncApplicationRegistration
 ```
 - Use BYOC:
 
``` powershell
 Add-ADSyncApplicationRegistration -CertificateSHA256Hash <CertificateSHA256Hash>
```
 - Use BYOA:
 
``` powershell
 Add-EntraApplicationRegistration -CertificateSHA256Hash <CertificateSHA256Hash> –ApplicationAppId <appId>
```
Replace &lt;CertificateSHA256Hash&gt; with the CertificateSHA256Hash and &lt;appId&gt; with the Id of the application created in Entra

5. Run a verification to confirm that you're now using application identity. Run the following cmdlet to get the current authentication and ensure it has the Connector Identity Type as **Application**. 

 ``` powershell
 Get-ADSyncEntraConnectorCredential
 ```

6. Re-enable the scheduler to begin synchronization service using the following cmdlet.
 ``` powershell
 Set-ADSyncScheduler -SyncCycleEnabled $true
 ```
7. [Remove the Directory Synchronization Account (DSA) from Entra ID (Recommended)](#remove-legacy-service-account-using-powershell)

 ## Viewing the Certificate
 You can view the certificate information by going to tasks and then selecting **View or export current configuration** and then scroll down to certificate details. The following table provides information about the certificate.

|Property|Description|
|-----|-----|
|Certificate managed by|Whether the certificate is managed by Microsoft Entra Connect Sync or BYOC.|
|Automatic rotation enabled|Whether or not automatic rotation is enabled.|
|Certificate thumbprint|Unique identifier for the certificate|
|Certificate SHA256 Hash|A fingerprint for the certificate generated using the SHA-256 hashing algorithm.|
|Subject name|Identifies the entity associated with the certificate|
|Issued by|Who is the issuer of the certificate|
|Serial number|Uniquely identifies the certificate among certs by the same issuer|
|Not valid before|The first date that the certificate is valid.|
|Not valid after|The last date the certificate is valid.|

 :::image type="content" source="media/authenticate-application-id/auth-7.png" alt-text="Screenshot of certificate." lightbox="media/authenticate-application-id/auth-7.png":::


 ## On-Demand Certificate Rotation 
Microsoft Entra Connect will warn if the certificate rotation is due. That is, expiring in less than or equal to 150 days. It will emit an error if certificate is already expired. These warnings (Event ID 1011) and errors (Event ID 1012) can be found in the Application event log. This message will be emitted at the scheduler frequency if maintenance is enabled, and the scheduler isn't suspended. Run `Get-ADSyncSchedulerSettings` to see if scheduler is suspended or maintenance is enabled or disabled.

If the certificate is managed by Microsoft Entra Connect, **no action** is required from your end unless the scheduler is suspended or maintenance disabled. If this is the case, you'll have to manually manage certificate rotation by going through the steps.

### Using the wizard
 Once you have application authentication enabled you'll see an additional option in tasks. The **Rotate application certificate** option will now be available. From here, you can rotate the certificate manually. However, Microsoft recommends the Entra Connect certificate management option as we manage the keys and automatically rotate the certificate on expiry. This is the default option in Entra Connect Sync versions equal to or higher than 2.4.252.0. 

 :::image type="content" source="media/authenticate-application-id/auth-6.png" alt-text="Screenshot of rotate application certificate under tasks." lightbox="media/authenticate-application-id/auth-6.png":::

### Using PowerShell
When you get a warning from Microsoft Entra Connect Sync when using the BYOC option, it's **highly recommended you generate a new key and certificate and rotate the certificate** used by Connect Sync using PowerShell.


1. Disable the scheduler to ensure no sync cycles run until this change is completed. Use the following PowerShell cmdlet to disable the scheduler.

 ``` powershell
 Set-ADSyncScheduler -SyncCycleEnabled $false
 ```
2. Invoke certificate credential rotation when using the Entra Managed option (default mode) but the scheduler is suspended or maintenance disabled.

 ``` powershell
 Invoke-ADSyncApplicationCredentialRotation
 ```

If in BYOC mode, the new certificate SHA256Hash must be provided.

 ``` powershell
 Invoke-ADSyncApplicationCredentialRotation -CertificateSHA256Hash <CertificateSHA256Hash>
 ```

Replace &lt;CertificateSHA256Hash&gt; with the CertificateSHA256Hash 


3. Get the current authentication and confirm it has the Connector Identity Type as **Application**. Use the following PowerShell cmdlet to verify the current authentication.
 
 ``` powershell
 Get-ADSyncEntraConnectorCredential
 ```
4. Re-enable the scheduler to begin synchronization service. 

 ``` powershell
 Set-ADSyncScheduler -SyncCycleEnabled $true
 ```
5. Verify synchronization cycle is successful.
6. Remove the old certificate from Current User store for BYOC and BYOA options.

You may rotate the certificate at any point in time as deemed necessary, even if the current certificate is still not due for rotation or the current certificate has already expired.

## Certificate revocation process
The certificate revocation process allows Authentication Policy Administrators to revoke a previously issued certificate from being used for future authentication. The certificate revocation won't revoke already issued tokens of the user. For more information, see [Understanding the certificate revocation process](../../authentication/concept-certificate-based-authentication-technical-deep-dive.md#understanding-the-certificate-revocation-process)

## Remove legacy service account using PowerShell
Once you have transitioned to Application Based Authentication and Sync is working as expected, it's **strongly recommended** that you remove the legacy DSA username and password service account using PowerShell. If using a custom account that can't be removed, deprivilege it and remove the DSA role from it.

Use the following steps to remove the legacy service account.

1. Add the service account username and password.

 ``` powershell 
 $HACredential
 ```
 2. You'll be prompted to enter your Microsoft Entra ID Administrator UserPrincipalName and the password. Enter the username and password.

 3. Next, add the service account.

 ``` powershell
 Remove-ADSyncAADServiceAccount -AADCredential $HACredential -Name <$serviceAccountName>
 ```

The ServiceAccountName is the first part of the UserPrincipalName of the service account used in Microsoft Entra ID. You can find this user in the list of users in Entra Portal. If UPN is contoso@fabrikam.com then use **contoso** as the ServiceAccountName

## Rollback to legacy service account using PowerShell
If you want to go back to the legacy service account, you have the option to revert to using service account to mitigate the issue promptly using PowerShell. Use the following steps to rollback to the service account.

 > [!NOTE] 
 > As part of the rollback, we'll need to recreate the DSA account. This new account may take up to 15 minutes to take effect so you may get an Access Denied error when you re-enable the Sync Cycle.

1. Disable the scheduler to ensure no sync cycles run until this change is completed.
 
 ``` powershell
 Set-ADSyncScheduler -SyncCycleEnabled $false
 ```
2. Add the service account. You'll be prompted to enter your Microsoft Entra ID Administrator UserPrincipalName and the password. Enter the credentials.

 ``` powershell
Add-ADSyncAADServiceAccount
 ```

3. Get the current authentication mechanism and confirm that the ConnectorIdentityType is back to **ServiceAccount**.
 
 ``` powershell
Get-ADSyncEntraConnectorCredential
 ```
4. Re-enable the scheduler to begin synchronization service.

 ``` powershell
 Set-ADSyncScheduler -SyncCycleEnabled $true
 ```
## Next steps

- [What is Microsoft Entra Connect V2?](whatis-azure-ad-connect-v2.md)
- [Microsoft Entra Connect cloud sync](/azure/active-directory/cloud-sync/what-is-cloud-sync)
- [Microsoft Entra Connect version history](reference-connect-version-history.md)
