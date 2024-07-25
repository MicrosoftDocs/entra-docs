---
title: Revoke user access in an emergency in Microsoft Entra ID
description: How to revoke all access for a user in Microsoft Entra ID

ms.service: entra-id
ms.subservice: users
ms.topic: how-to
author: barclayn
ms.author: barclayn
manager: amycolannino
ms.reviewer: krbain
ms.date: 11/21/2023
ms.custom: it-pro, has-azure-ad-ps-ref, azure-ad-ref-level-one-done
---

# Revoke user access in Microsoft Entra ID

Scenarios that could require an administrator to revoke all access for a user include compromised accounts, employee termination, and other insider threats. Depending on the complexity of the environment, administrators can take several steps to ensure access is revoked. In some scenarios, there could be a period between the initiation of access revocation and when access is effectively revoked.

To mitigate the risks, you must understand how tokens work. There are many kinds of tokens, which fall into one of the patterns mentioned in the sections below.

## Access tokens and refresh tokens

Access tokens and refresh tokens are frequently used with thick client applications, and also used in browser-based applications such as single page apps.

- When users authenticate to Microsoft Entra ID, part of Microsoft Entra, authorization policies are evaluated to determine if the user can be granted access to a specific resource.  

- If authorized, Microsoft Entra ID issues an access token and a refresh token for the resource.  

- Access tokens issued by Microsoft Entra ID by default last for 1 hour. If the authentication protocol allows, the app can silently reauthenticate the user by passing the refresh token to the Microsoft Entra ID when the access token expires.

Microsoft Entra ID then reevaluates its authorization policies. If the user is still authorized, Microsoft Entra ID issues a new access token and refreshes token.

Access tokens can be a security concern if access must be revoked within a time that is shorter than the lifetime of the token, which is usually around an hour. For this reason, Microsoft is actively working to bring [continuous access evaluation](~/identity/conditional-access/concept-continuous-access-evaluation.md) to Office 365 applications, which helps ensure invalidation of access tokens in near real time.  

## Session tokens (cookies)

Most browser-based applications use session tokens instead of access and refresh tokens.  

- When a user opens a browser and authenticates to an application via Microsoft Entra ID, the user receives two session tokens. One from Microsoft Entra ID and another from the application.  

- Once an application issues its own session token, access to the application is governed by the application's session. At this point, the user is affected by only the authorization policies that the application is aware of.

- The authorization policies of Microsoft Entra ID are reevaluated as often as the application sends the user back to Microsoft Entra ID. Reevaluation usually happens silently, though the frequency depends on how the application is configured. It's possible that the app may never send the user back to Microsoft Entra ID as long as the session token is valid.

- For a session token to be revoked, the application must revoke access based on its own authorization policies. Microsoft Entra ID can't directly revoke a session token issued by an application.  

## Revoke access for a user in the hybrid environment

For a hybrid environment with on-premises Active Directory synchronized with Microsoft Entra ID, Microsoft recommends IT admins to take the following actions. If you have a **Microsoft Entra-only environment**, skip to the [Microsoft Entra environment](#azure-active-directory-environment) section.


### On-premises Active Directory environment

As an admin in the Active Directory, connect to your on-premises network, open PowerShell, and take the following actions:

1. Disable the user in Active Directory. Refer to [Disable-ADAccount](/powershell/module/activedirectory/disable-adaccount).

    ```PowerShell
    Disable-ADAccount -Identity johndoe  
    ```

2. Reset the user's password twice in the Active Directory. Refer to [Set-ADAccountPassword](/powershell/module/activedirectory/set-adaccountpassword).

    > [!NOTE]
    > The reason for changing a user's password twice is to mitigate the risk of pass-the-hash, especially if there are delays in on-premises password replication. If you can safely assume this account isn't compromised, you may reset the password only once.

    > [!IMPORTANT]
    > Don't use the example passwords in the following cmdlets. Be sure to change the passwords to a random string.

    ```PowerShell
    Set-ADAccountPassword -Identity johndoe -Reset -NewPassword (ConvertTo-SecureString -AsPlainText "p@ssw0rd1" -Force)
    Set-ADAccountPassword -Identity johndoe -Reset -NewPassword (ConvertTo-SecureString -AsPlainText "p@ssw0rd2" -Force)
    ```

<a name='azure-active-directory-environment'></a>

### Microsoft Entra environment

As an administrator in Microsoft Entra ID, open PowerShell, run `Connect-MgGraph`, and take the following actions:

1. Disable the user in Microsoft Entra ID. Refer to [Update-MgUser](/powershell/module/microsoft.graph.users/update-mguser).

    ```PowerShell
    $User = Get-MgUser -Search UserPrincipalName:'johndoe@contoso.com' -ConsistencyLevel eventual
    Update-MgUser -UserId $User.Id -AccountEnabled:$false
    ```

2. Revoke the user's Microsoft Entra ID refresh tokens. Refer to [Revoke-MgUserSignInSession](/powershell/module/microsoft.graph.users.actions/revoke-mgusersigninsession).

    ```PowerShell
    Revoke-MgUserSignInSession -UserId $User.Id
    ```

3. Disable the user's devices. Refer to [Get-MgUserRegisteredDevice](/powershell/module/microsoft.graph.users/get-mguserregistereddevice).

    ```PowerShell
    $Device = Get-MgUserRegisteredDevice -UserId $User.Id 
    Update-MgDevice -DeviceId $Device.Id -AccountEnabled:$false
    ```

>[!NOTE]
> For information on specific roles that can perform these steps review [Microsoft Entra built-in roles](~/identity/role-based-access-control/permissions-reference.md)


[!INCLUDE [Azure AD PowerShell deprecation note](~/../docs/reusable-content/msgraph-powershell/includes/aad-powershell-deprecation-note.md)]

## When access is revoked

Once admins have taken the above steps, the user can't gain new tokens for any application tied to Microsoft Entra ID. The elapsed time between revocation and the user losing their access depends on how the application is granting access:

- For **applications using access tokens**, the user loses access when the access token expires.

- For **applications that use session tokens**, the existing sessions end as soon as the token expires. If the disabled state of the user is synchronized to the application, the application can automatically revoke the user's existing sessions if it's configured to do so.  The time it takes depends on the frequency of synchronization between the application and Microsoft Entra ID.

## Best practices

- Deploy an automated provisioning and deprovisioning solution. Deprovisioning users from applications is an effective way of revoking access, especially for applications that use sessions tokens or allow users to sign in directly without a Microsoft Entra or Windows Server AD token. Develop a process to also deprovision users to apps that don't support automatic provisioning and deprovisioning. Ensure applications revoke their own session tokens and stop accepting Microsoft Entra access tokens even if they're still valid.

  - Use [Microsoft Entra app provisioning](~/identity/app-provisioning/user-provisioning.md). Microsoft Entra app provisioning typically runs automatically every 20-40 minutes. [Configure Microsoft Entra provisioning](~/identity/saas-apps/tutorial-list.md) to deprovision or deactivate users in SaaS and on-premises applications. If you were using [Microsoft Identity Manager](/microsoft-identity-manager/mim-how-provision-users-adds) to automate the deprovisioning of users from on-premises applications, you can use Microsoft Entra app provisioning to reach on-premises applications with a [SQL database](~/identity/app-provisioning/on-premises-sql-connector-configure.md), [non-AD directory server](~/identity/app-provisioning/on-premises-ldap-connector-configure.md) or [other connectors](~/identity/app-provisioning/on-premises-custom-connector.md).
  - For on-premises applications using Windows Server AD, you can configure Microsoft Entra Lifecycle Workflows to [update users in AD (preview)](~/id-governance/lifecycle-workflow-on-premises.md) when employees leave.
  
  - Identify and develop a process for applications that requires manual deprovisioning, such as the [automated ServiceNow ticket creation with Microsoft Entra Entitlement Management](~/id-governance/entitlement-management-ticketed-provisioning.md) to open a ticket when employees lose access. Ensure admins and application owners can quickly run the required manual tasks to deprovision the user from these apps when needed.
  
- [Manage your devices and applications with Microsoft Intune](/mem/intune/remote-actions/device-management). Intune-managed [devices can be reset to factory settings](/mem/intune/remote-actions/devices-wipe). If the device is unmanaged, you can [wipe the corporate data from managed apps](/mem/intune/apps/apps-selective-wipe). These processes are effective for removing potentially sensitive data from end users' devices. However, for either process to be triggered, the device must be connected to the internet. If the device is offline, the device will still have access to any locally stored data.

> [!NOTE]
> Data on the device cannot be recovered after a wipe.

- Use [Microsoft Defender for Cloud Apps to block data download](/defender-cloud-apps/use-case-proxy-block-session-aad) when appropriate. If the data can only be accessed online, organizations can monitor sessions and achieve real-time policy enforcement.

- Use [Continuous Access Evaluation (CAE) in Microsoft Entra ID](~/identity/conditional-access/concept-continuous-access-evaluation.md). CAE allows admins to revoke the session tokens and access tokens for applications that are CAE capable.  

## Next steps

- [Secure access practices for Microsoft Entra administrators](~/identity/role-based-access-control/security-planning.md)
- [Add or update user profile information](~/fundamentals/how-to-manage-user-profile-info.yml)
- [Remove or Delete a former employee](/microsoft-365/admin/add-users/remove-former-employee)
