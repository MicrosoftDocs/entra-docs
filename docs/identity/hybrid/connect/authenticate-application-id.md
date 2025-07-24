---
title: Authenticate to Microsoft Entra ID by Using Application Identity
description: This article describes how to allow the Microsoft Entra Connect application to authenticate with Microsoft Entra ID with modern, more secure credentials. 

author: omondiatieno
manager: mwongerapk
ms.service: entra-id
ms.topic: conceptual
ms.tgt_pltfrm: na
ms.date: 07/24/2025
ms.subservice: hybrid
ms.author: jomondi
---

# Authenticate to Microsoft Entra ID by using application identity

Microsoft Entra Connect uses the [Microsoft Entra Connector account](reference-connect-accounts-permissions.md#accounts-used-for-microsoft-entra-connect) to authenticate and sync identities from Active Directory to Microsoft Entra Connect. This account uses a username and password to authenticate requests.

To enhance the security of the service, we're rolling out an application identity that uses Oauth 2.0 client credential flow with certificate credentials. In this new method, Microsoft Entra or an administrator creates a single tenant non-Microsoft application in Microsoft Entra ID and uses one of the following relevant certificate management options for the credentials.

Microsoft Entra Connect provides three options for application and certificate management:

- [Managed by Microsoft Entra Connect (recommended)](#managed-by-microsoft-entra-connect-recommended)
- [Bring Your Own Application (BYOA)](#bring-your-own-application)
- [Bring Your Own Certificate (BYOC)](#bring-your-own-certificate)

## Managed by Microsoft Entra Connect (recommended)

Microsoft Entra Connect manages the application and certificate, which includes creation, rotation, and deletion of the certificate. The certificate is stored in the `CURRENT_USER` store. For optimal protection of the certificate's private key, we recommend that the machine should use a Trusted Platform Module (TPM) solution to establish a hardware-based security boundary.

When a TPM is available, key service operations are performed within a dedicated hardware environment. In contrast, if a TPM can't be used, Microsoft Entra Connect defaults to storing the certificate in the default Microsoft Software Key Storage Provider and marks the private key as nonexportable for extra protection. Without the hardware isolation provided by a TPM, only software safeguards secure the private key, which doesn't achieve the same level of protection.

For more information on TPM technology, see [Trusted Platform Module technology overview](/windows/security/hardware-security/tpm/trusted-platform-module-overview).

 :::image type="content" source="media/authenticate-application-id/auth-1.png" alt-text="Diagram that shows authentication with application ID." lightbox="media/authenticate-application-id/auth-1.png":::

We recommend the Microsoft Entra Connect  certificate management option because we manage the keys and automatically rotate the certificate on expiry. This behavior is the default option in Microsoft Entra Connect Sync versions equal to or higher than 2.5.3.0.

Microsoft Entra Connect Sync uses the scheduler to check if the certificate is due for rotation and then automatically rotate the certificate. If the scheduler is suspended, autorotation can't happen even though Microsoft Entra Connect Sync manages the certificate.

## Bring Your Own Application

In the Bring Your Own Application (BYOA) setup, the customer administrator manages the application that Microsoft Entra Connect Sync uses to authenticate to Microsoft Entra ID, the application permissions, and the certificate credential that the application uses.

The administrator [registers a Microsoft Entra app and creates a service principal](/graph/tutorial-applications-basics?tabs=http#register-an-application-with-microsoft-entra-id). The application needs the required [permissions](#microsoft-graph-permissions-for-byoa) assigned. 

The following section shows how to set up permissions for BYOA using Microsoft Graph API calls:
  
1. Update application `requiredResourceAccess` to configure required permissions on the application for Microsoft Entra AD Synchronization Service and Microsoft password reset service.

     ```http 
          PATCH /applications(appId='{appId}')
          {
               "requiredResourceAccess": [
                    {
                         "resourceAppId": "aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb",
                         "resourceAccess": [
                              {
                                   "id": "fc7e8088-95b5-453e-8bef-b17ecfec5ba3",
                                   "type": "Role"
                              },
                              {
                                   "id": "e006e431-a65b-4f3e-8808-77d29d4c5f1a",
                                   "type": "Role"
                              },
                              {
                                   "id": "69201c67-737b-4a20-8f16-e0c8c64e0b0e",
                                   "type": "Role"
                              }
                         ]
                    },
                    {
                         "resourceAppId": "bbbbbbbb-2222-3333-4444-cccccccccccc",
                         "resourceAccess": [
                              {
                                   "id": "ab43b826-2c7a-4aff-9ecd-d0629d0ca6a9",
                                   "type": "Role"
                              }
                         ]
                    }
               ]
          }
          ```
     
1. Determine service principal identifier for the following applications:

   - Connect Sync service principal.
   - Microsoft Entra AD Synchronization Service service principal (appId=`bbbbbbbb-2222-3333-4444-cccccccccccc`)
   - Microsoft password reset service service principal (appId=`aaaaaaaa-1111-2222-3333-bbbbbbbbbbbb`) (might not exist if SSPR is not enabled on the tenant)

     ```http
     GET /servicePrincipals(appId='{appId}')
     ```
   Use `id` in the response wherever service principal identifier is needed in the next step.
     
1. Assign app roles to the application service principal:

   1. Add an app role assignment for `ADSynchronization.ReadWrite.All`
     
      ```http
      POST /servicePrincipals(appId='{appId}')/appRoleAssignments
      {
      "principalId": <ConnectSync application service principal identifier>,
      "resourceId": <Microsoft Entra AD Synchronization Service service principal identifier>,
      "appRoleId": "ab43b826-2c7a-4aff-9ecd-d0629d0ca6a9"
      }
      ```

      If password writeback is enabled on the Connect Sync server, add the 3 app role assignments for password reset service.

   1. Add the first app role assignments for password reset service:

      ```http   
      POST /servicePrincipals(appId='{appId}')/appRoleAssignments
      {
      "principalId": <ConnectSync application service principal identifier>,
      "resourceId": <Microsoft password reset service service principal identifier>,
      "appRoleId": "fc7e8088-95b5-453e-8bef-b17ecfec5ba3"
      }
      ```

   1. Add the second app role assignment for password reset service:

      ```http
      POST /servicePrincipals(appId='{appId}')/appRoleAssignments
      {
      "principalId": <ConnectSync application service principal identifier>,
      "resourceId": <Microsoft password reset service service principal identifier>,
      "appRoleId": "e006e431-a65b-4f3e-8808-77d29d4c5f1a"
      }
      ```
     
   1. Add the third app role assignment for password reset service:

      ```http
      POST /servicePrincipals(appId='{appId}')/appRoleAssignments
      {
      "principalId": <ConnectSync application service principal identifier>,
      "resourceId": <Microsoft password reset service service principal identifier>,
      "appRoleId": "69201c67-737b-4a20-8f16-e0c8c64e0b0e"
      }
     ```

The administrator is responsible for creating the certificate, rotation, and deletion of unused or expired certificates. The certificate must be stored in the `LOCAL_MACHINE` store.

The administrator is responsible for securing the private key of the certificate and ensuring that only Microsoft Entra Connect Sync can access the private key for signing.

## Bring Your Own Certificate

In the Bring Your Own Certificate (BYOC) setup, the administrator manages the certificate credential that the application uses. The administrator is responsible for creating the certificate, rotation, and deletion of unused or expired certificates. The certificate must be stored in the `LOCAL_MACHINE` store.

The administrator is responsible for securing the private key of the certificate and ensuring that only Microsoft Entra Connect Sync can access the private key for signing.

We recommend that you use a TPM or a Hardware Security Module (HSM) to provide a hardware-based security boundary, as opposed to the default. To check the status of the TPM, use the [Get-TPM](/powershell/module/trustedplatformmodule/get-tpm) PowerShell cmdlet.

If you use Hyper-V virtual machines (VMs), you can enable the TPM by selecting **Security** > **Enable Trusted Platform Module**. You can do this step only on generation 2 VMs. Generation 1 VMs can't be converted to generation 2 VMs. For more information, see [Generation 2 VM security settings for Hyper-V](/windows-server/virtualization/hyper-v/learn-more/generation-2-virtual-machine-security-settings-for-hyper-v) and [Enable trusted launch on existing Azure Gen2 VMs](/azure/virtual-machines/trusted-launch-existing-vm).

## Prerequisites

The following prerequisites are required to implement authentication by using application identity.

>[!IMPORTANT]
> New Microsoft Entra Connect Sync versions are available only via the Microsoft Entra admin center.
>
> Following up on the [What's New](../../../fundamentals/whats-new.md#general-availability---download-microsoft-entra-connect-sync-on-the-microsoft-entra-admin-center) communication, new versions of Microsoft Entra Connect Sync are available only on the [Microsoft Entra Connect pane](https://entra.microsoft.com/#view/Microsoft_AAD_Connect_Provisioning/AADConnectMenuBlade/%7E/GetStarted) within the Microsoft Entra admin center and will no longer be released to the [Microsoft Download Center](https://www.microsoft.com/en-us/download/details.aspx?id=47594).

- [Microsoft Entra Connect](https://www.microsoft.com/download/details.aspx?id=47594) version [2.5.3.0](reference-connect-version-history.md) or greater.
- Microsoft Entra account with at least a [Hybrid Identity Administrator](../../role-based-access-control/permissions-reference.md#hybrid-identity-administrator) role.
- On-premises Active Directory Domain Services environment with a Windows Server 2016 operating system or later.
- Optional: TPM 2.0 present and ready to use (recommended for security).

The following extra requirements are needed for the BYOC certificate management option:

- A certificate is created in an HSM or TPM by using a Cryptography API: Next Generation provider. The private key is marked as nonexportable. A warning event 1014 is emitted if TPM isn't used. The following certificate configurations are supported:
   - `KeyLength`: 2048
   - `KeyAlgorithm`: RSA
   - `KeyHashAlgorithm`: SHA256
- The created certificate is stored in the `LOCAL_MACHINE` store.
- Grant the Microsoft Entra Connect Sync account permission to perform signing by using the private key.

The following extra requirements are needed for the BYOA application management option:

- The customer creates a certificate as instructed in the preceding BYOC prerequisites.
- The customer registers an application in Microsoft Entra ID and creates a service principal. The necessary [permissions](#microsoft-graph-permissions-for-byoa) are granted via Microsoft Graph API.
- The customer registers the certificate with the application.

## Installation and upgrade (managed by Microsoft Entra Connect)

The Microsoft Entra Connect Sync managed application and credential is automatically set up during initial installation or manual interactive upgrades. To confirm that Microsoft Entra Connect is using the application identity, use the PowerShell cmdlet `Get-ADSyncEntraConnectorCredential`.

 :::image type="content" source="media/authenticate-application-id/auth-2.png" alt-text="Screenshot that shows Get-ADSyncEntraConnectorCredential." lightbox="media/authenticate-application-id/auth-2.png":::

## Onboard to application-based authentication

### Automatic configuration

Starting with version 2.5.74.0 or higher, the service will automatically configure application authentication within a six-hour window if the service is using username and password to authenticate to Microsoft Entra ID.

If application authentication wasn't automatically configured, you can switch to application-based authentication manually using the following options.

If you want to configure application-based authentication using the recommended option (Managed by Microsoft Entra Connect), you can use the wizard or PowerShell. However, if you want to configure application based authentication using BYOC or BYOA, you must use PowerShell.

### Manually - Using the wizard

On the **Additional tasks** pane, select **Configure application-based authentication to Microsoft Entra ID** and then follow the prompts.

 :::image type="content" source="media/authenticate-application-id/auth-4.png" alt-text="Screenshot that shows configuring application-based authentication on the Additional tasks pane." lightbox="media/authenticate-application-id/auth-4.png":::

### Manually - Using PowerShell

> [!NOTE]
> Ensure that you're on the Microsoft Entra Connect server and that the Microsoft Entra Connect Sync PowerShell module is installed.

1. Use the PowerShell command to verify the current authentication method.

     ``` powershell
     Get-ADSyncEntraConnectorCredential
     ```

    This step should return the `ConnectorIdentityType` value currently in use, and the value must be `ServiceAccount` to proceed.

1. Disable the scheduler to ensure that no sync cycles run until this change is completed.
    
     ``` powershell
    Set-ADSyncScheduler -SyncCycleEnabled $false
     ```

1. Register an application and create a service principal in Microsoft Entra ID.

     - Managed by Microsoft Entra Connect:
     
        ``` powershell
         Add-EntraApplicationRegistration
        ```
    
     - Use BYOC:
    
         > [!NOTE]
         > The certificate `SHA256Hash` must be provided when you register the application. Use the [generation script](#script-to-generate-the-sha256-hash-of-the-certificate) to generate the hash.
    
         ``` powershell
         Add-EntraApplicationRegistration -CertificateSHA256Hash <CertificateSHA256Hash>
         ```

        Replace `<CertificateSHA256Hash>` with `CertificateSHA256Hash`.

    - Use BYOA:

       [Register a Microsoft Entra app and create a service principal](/graph/tutorial-applications-basics?tabs=http#register-an-application-with-microsoft-entra-id). Note the application ID because you need it in the next section.

1. Link Microsoft Entra Application with Microsoft Entra Connect Sync by using administrator credentials.

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
         Add-ADSyncApplicationRegistration -CertificateSHA256Hash <CertificateSHA256Hash> –ApplicationAppId <appId>
        ```

    Replace `<CertificateSHA256Hash>` with `CertificateSHA256Hash` and `<appId>` with the ID of the application that was created in Microsoft Entra ID.

1. Run a verification to confirm that you're now using application identity. Run the following cmdlet to get the current authentication and ensure that it has the `ConnectorIdentityType` value as `Application`.

     ``` powershell
     Get-ADSyncEntraConnectorCredential
     ```

1. Reenable the scheduler to begin the synchronization service by using the following cmdlet:

     ``` powershell
     Set-ADSyncScheduler -SyncCycleEnabled $true
     ```

1. [Remove the Directory Synchronization Account (DSA) from Microsoft Entra ID (recommended)](#remove-a-legacy-service-account-by-using-powershell).

## View the current authentication configuration

To view the current authentication configuration, go to **Tasks** and then select **View or export current configuration**. 

If the server is configured to use application-based authentication, you should be able to see the application (client) ID as shown in the following screenshot.

:::image type="content" source="media/authenticate-application-id/authentication-client-id.png" alt-text="Screenshot that shows the client ID." lightbox="media/authenticate-application-id/authentication-client-id.png":::

 Scroll down to the certificate details. The following table provides information about the certificate.
 
|Property|Description|
|-----|-----|
|**Certificate managed by**|Whether Microsoft Entra Connect Sync or BYOC manages the certificate.|
|**Automatic rotation enabled**|Whether automatic rotation or manual rotation is enabled.|
|**Certificate thumbprint**|Unique identifier for the certificate.|
|**Certificate SHA256 hash**|A fingerprint for the certificate generated by using the SHA-256 hashing algorithm.|
|**Subject name**|Identifies the entity associated with the certificate.|
|**Issued by**|Who is the issuer of the certificate.|
|**Serial number**|Uniquely identifies the certificate among certificates by the same issuer.|
|**Not valid before**|The first date that the certificate is valid.|
|**Not valid after**|The last date that the certificate is valid.|

 :::image type="content" source="media/authenticate-application-id/auth-7.png" alt-text="Screenshot that shows the certificate." lightbox="media/authenticate-application-id/auth-7.png":::

If the server is using username and password you should be able to see the account name as shown in the following screenshot.

:::image type="content" source="media/authenticate-application-id/authentication-account-name.png" alt-text="Screenshot that shows the account name." lightbox="media/authenticate-application-id/authentication-account-name.png":::

## On-demand certificate rotation

Microsoft Entra Connect warns if the certificate rotation is due. That is, if expiration is less than or equal to 150 days. It emits an error if the certificate is already expired. You can find these warnings (Event ID 1011) and errors (Event ID 1012) in the Application event log.

This message is emitted at the scheduler frequency if the scheduler isn't suspended. Run `Get-ADSyncSchedulerSettings` to see if the scheduler is suspended.

If Microsoft Entra Connect manages the certificate, *no action* is required from you unless the scheduler is suspended, Microsoft Entra Connect Sync adds the new certificate credential to the application and tries to remove the old certificate credential. If it fails to remove the old certificate credential, an error event appears in the Application logs in the Event Viewer.

If you see this error, run the following cmdlet in PowerShell to clean up the old certificate credential from Microsoft Entra. The cmdlet takes the `CertificateId` value of the certificate that must be removed, which you can obtain from the log or the Microsoft Entra admin center.

 ``` powershell
Remove-EntraApplicationKey -CertificateId <certificateId>
 ```

### Use the wizard

 After application authentication is enabled, you see another option on the **Additional tasks** pane. The **Rotate application certificate** option is now available. From this point, you can rotate the certificate manually. We recommend the Microsoft Entra Connect certificate management option because we manage the keys and automatically rotate the certificate on expiry. This option is the default in Microsoft Entra Connect Sync versions equal to or higher than 2.5.3.0.

 :::image type="content" source="media/authenticate-application-id/auth-6.png" alt-text="Screenshot that shows the Rotate application certificate option on the Additional tasks pane." lightbox="media/authenticate-application-id/auth-6.png":::

### Use PowerShell

When you get a warning from Microsoft Entra Connect Sync when you use the BYOC option, we *highly recommend that you generate a new key and certificate and rotate the certificate* that Microsoft Entra Connect Sync uses by using PowerShell.

1. Disable the scheduler to ensure that no sync cycles run until this change is completed. Use the following PowerShell cmdlet to disable the scheduler:

     ``` powershell
     Set-ADSyncScheduler -SyncCycleEnabled $false
     ```

1. Invoke certificate credential rotation when you use the Microsoft Entra Managed option (default mode) and the scheduler is suspended.

     ``` powershell
     Invoke-ADSyncApplicationCredentialRotation
     ```
    
    In BYOC mode, the new certificate `SHA256Hash` must be provided:
    
     ``` powershell
     Invoke-ADSyncApplicationCredentialRotation -CertificateSHA256Hash <CertificateSHA256Hash>
     ```
    
    In BYOA mode, the new certificate `SHA256Hash` must be provided:
    
    ``` powershell
     Add-EntraApplicationRegistration -CertificateSHA256Hash <CertificateSHA256Hash>
    ```
    
    Replace `<CertificateSHA256Hash>` with the `CertificateSHA256Hash`.
    
1. Get the current authentication and confirm that it has the `ConnectorIdentityType` value as `Application`. Use the following PowerShell cmdlet to verify the current authentication:

     ``` powershell
     Get-ADSyncEntraConnectorCredential
     ```
    
1. Reenable the scheduler to begin the synchronization service:
    
     ``` powershell
     Set-ADSyncScheduler -SyncCycleEnabled $true
     ```

1. Verify that the sync cycle is successful.
1. Remove the old certificate from the `LOCAL_MACHINE` store for BYOC and BYOA options.

You can rotate the certificate at any point in time, even if the current certificate is still not due for rotation or the current certificate expired.

## Script to generate the SHA256 hash of the certificate

``` powershell
# Get raw data from X509Certificate cert
$certRawDataString = $cert.GetRawCertData()

# Compute SHA256Hash of certificate 
$sha256 = [System.Security.Cryptography.SHA256]::Create()
$hashBytes = $sha256.ComputeHash($certRawDataString)

# Convert hash to bytes for PowerShell (Core) 7.1+:
$certHash = [System.Convert]::ToHexString($hashBytes)

# Convert hash to bytes for older PowerShell:
$certHash = ($hashBytes|ForEach-Object ToString X2) -join ''
```

## Resource permission

### ADSynchronization.ReadWrite.All

|Category|Application|Delegated|
|-----|-----|-----|
|`Identifier`|0b41ed4d-5f52-442b-8952-ea7d90719860|0b41ed4d-5f52-442b-8952-ea7d90719860|
|`DisplayText`|Read, write, and manage identity synchronization with on-premises via Microsoft Entra Connect Sync.|Read, write, and manage identity synchronization with on-premises via Microsoft Entra Connect Sync.|
|`Description`|Allows the app to read, write, and manage identity data synced with on-premises via Microsoft Entra Connect Sync.|Allows the app to read, write, and manage identity data synced with on-premises via Microsoft Entra Connect Sync.|
|`AdminConsentRequired`|Yes.|Yes.|

## Microsoft Graph permissions for BYOA

### PasswordWriteback.RefreshClient.All

|Category|Application|Delegated|
|-----|-----|-----|
|`Identifier`|fc7e8088-95b5-453e-8bef-b17ecfec5ba3|-|
|`DisplayText`|Read, write, and manage self-service password reset writeback for the Microsoft Entra Connect Sync Agent.|-|
|`Description`|Allows the app to refresh and re-create on-premises configuration for Microsoft self-service password reset.|-|
|`AdminConsentRequired`|Yes.|-|

### PasswordWriteback.RegisterClientVersion.All

|Category|Application|Delegated|
|-----|-----|-----|
|`Identifier`|e006e431-a65b-4f3e-8808-77d29d4c5f1a|-|
|`DisplayText`|Read, write, and manage self-service password reset client version configuration for the Microsoft Entra Connect Sync Agent.|-|
|`Description`|Allows the app to register a newer version of the on-premises Microsoft Entra Connect Sync Agent.|-|
|`AdminConsentRequired`|Yes.|-|

### PasswordWriteback.OffboardClient.All

|Category|Application|Delegated|
|-----|-----|-----|
|`Identifier`|69201c67-737b-4a20-8f16-e0c8c64e0b0e|-|
|`DisplayText`|Read, write, and manage self-service password reset uninstall/offboard configuration for the Microsoft Entra Connect Sync Agent.|-|
|`Description`|Allows the app to offboard a version of the on-premises Microsoft Entra Connect Sync Agent.|-|
|`AdminConsentRequired`|Yes.|-|

## Certificate revocation process

For self-signed certificates, either Microsoft Entra Managed or BYOC, an administrator must perform manual revocation by removing the `keyCredential` value from Microsoft Entra ID. An on-demand rotation of the certificate is also an option.

For BYOC certificates issued by a Certificate Authority registered with Microsoft Entra, the administrator can follow the [certificate revocation process](../../authentication/concept-certificate-based-authentication-technical-deep-dive.md#understanding-the-certificate-revocation-process).

## Remove a legacy service account by using PowerShell

After you transition to application-based authentication and Microsoft Entra Connect Sync is working as expected, we strongly recommend that you remove the legacy DSA username and password service account by using PowerShell. If you use a custom account that can't be removed, deprivilege it and remove the DSA role from it.

Follow these steps to remove the legacy service account.

1. Add the service account username and password.

     ``` powershell 
     $HACredential
     ```

 1. You're prompted to enter the Microsoft Entra administrator `UserPrincipalName` value and the password. Enter the username and password.

 1. Next, add the service account.

     ``` powershell
     Remove-ADSyncAADServiceAccount -AADCredential $HACredential -Name <$serviceAccountName>
     ```

    The `ServiceAccountName` value is the first part of the `UserPrincipalName` value of the service account used in Microsoft Entra ID. You can find this user in the list of users in the Microsoft Entra admin center. If the UPN is `aringdahl@fabrikam.com`, use `aringdahl` as the `ServiceAccountName` value.

## Roll back to a legacy service account by using PowerShell

If you want to go back to the legacy service account, you can use PowerShell to revert to using the service account to promptly mitigate the issue. Use the following steps to roll back to the service account.

As part of the rollback, you need to re-create the DSA account. This new account might take up to 15 minutes to take effect, so you might get an "Access Denied" error when you reenable the sync cycle.

1. Disable the scheduler to ensure that no sync cycles run until this change is completed.

     ``` powershell
     Set-ADSyncScheduler -SyncCycleEnabled $false
     ```

1. Add the service account. You're prompted to enter the Microsoft Entra administrator `UserPrincipalName` value and the password. Enter the credentials.

     ``` powershell
    Add-ADSyncAADServiceAccount
     ```

1. Get the current authentication mechanism and confirm that the `ConnectorIdentityType` value is back to `ServiceAccount`.

     ``` powershell
    Get-ADSyncEntraConnectorCredential
     ```

1. Reenable the scheduler to begin the synchronization service.

     ``` powershell
     Set-ADSyncScheduler -SyncCycleEnabled $true
     ```

## Related content

- [What is Microsoft Entra Connect V2?](whatis-azure-ad-connect-v2.md)
- [Microsoft Entra Cloud Sync](/azure/active-directory/cloud-sync/what-is-cloud-sync)
- [Microsoft Entra Connect version history](reference-connect-version-history.md)
