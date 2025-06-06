---
title: Self-service password reset policies
description: Learn about the different Microsoft Entra self-service password reset policy options
ms.service: entra-id
ms.subservice: authentication
ms.topic: conceptual
ms.date: 05/15/2025
ms.author: justinha
author: justinha
manager: femila
ms.reviewer: tilarso
ms.custom: has-azure-ad-ps-ref, azure-ad-ref-level-one-done, sfi-ga-nochange
---
# Password policies and account restrictions in Microsoft Entra ID

In Microsoft Entra ID, there's a password policy that defines settings like the password complexity, length, or age. There's also a policy that defines acceptable characters and length for usernames.

When self-service password reset (SSPR) is used to change or reset a password in Microsoft Entra ID, the password policy is checked. If the password doesn't meet the policy requirements, the user is prompted to try again. Azure administrators have some restrictions on using SSPR that are different to regular user accounts, and there are minor exceptions for trial and free versions of Microsoft Entra ID.

This article describes the password policy settings and complexity requirements associated with user accounts. It also covers how to use PowerShell to check or set password expiration settings.

## Username policies

Every account that signs in to Microsoft Entra ID must have a unique user principal name (UPN) attribute value associated with their account. In hybrid environments with an on-premises Active Directory Domain Services environment synchronized to Microsoft Entra ID using Microsoft Entra Connect, by default the Microsoft Entra ID UPN is set to the on-premises UPN.

The following table outlines the username policies that apply to both on-premises accounts that are synchronized to Microsoft Entra ID, and for cloud-only user accounts created directly in Microsoft Entra ID:

| Property | UserPrincipalName requirements |
| --- | --- |
| Characters allowed |A-Z<br>a-z<br>0-9<br>' \. - \_ ! \# ^ \~ |
| Characters not allowed |Any "\@\" character that's not separating the username from the domain.<br>Can't contain a period character "." immediately preceding the "\@\" symbol |
| Length constraints |The total length must not exceed 113 characters<br>There can be up to 64 characters before the "\@\" symbol<br>There can be up to 48 characters after the "\@\" symbol |

<a name='azure-ad-password-policies'></a>

## Microsoft Entra password policies

A password policy is applied to all user accounts that are created and managed directly in Microsoft Entra ID. Some of these password policy settings can't be modified, though you can [configure custom banned passwords for Microsoft Entra password protection](tutorial-configure-custom-password-protection.md) or account lockout parameters.

By default, an account is locked out after 10 unsuccessful sign-in attempts with the wrong password. The user is locked out for one minute. The lockout duration increases after further incorrect sign-in attempts. [Smart lockout](howto-password-smart-lockout.md) tracks the last three bad password hashes to avoid incrementing the lockout counter for the same password. If someone enters the same bad password multiple times, they aren't locked out. You can define the smart lockout threshold and duration.

The following Microsoft Entra password policy options are defined. Unless noted, you can't change these settings:

| Property | Requirements |
| --- | --- |
| Characters allowed |A-Z<br>a-z<br>0-9<br>@ # $ % ^ & * - _ ! + = [ ] { } &#124; \ : ' , . ? / \` ~ " ( ) ; < ><br>Blank space |
| Characters not allowed | Unicode characters |
| Password restrictions |A minimum of 8 characters and a maximum of 256 characters.<br>Requires three out of four of the following types of characters:<br>- Lowercase characters<br>- Uppercase characters<br>- Numbers (0-9)<br>- Symbols (see the previous password restrictions) |
| Password expiry duration (Maximum password age) |Default value: **No expiration**. If the tenant was created before 2021, it has a **90** day expiration value by default. You can check current policy with [Get-MgDomain](/powershell/module/microsoft.graph.identity.directorymanagement/get-mgdomain).<br>The value is configurable by using the [Update-MgDomain](/powershell/module/microsoft.graph.identity.directorymanagement/update-mgdomain) cmdlet from the Microsoft Graph module for PowerShell.|
| Password expiry (Let passwords never expire) |Default value: **false** (indicates that passwords have an expiration date).<br>The value can be configured for individual user accounts by using the [Update-MgUser](/powershell/module/microsoft.graph.users/update-mguser) cmdlet. |
| Password change history | The last password *can't* be used again when the user changes a password. |
| Password reset history | The last password *can* be used again when the user resets a forgotten password. |

If you enable *EnforceCloudPasswordPolicyForPasswordSyncedUsers*, the Microsoft Entra password policy applies to user accounts synchronized from on-premises using Microsoft Entra Connect. In addition, if a user changes a password on-premises to include a unicode character, the password change may succeed on-premises but not in Microsoft Entra ID. If password hash synchronization is enabled with Microsoft Entra Connect, the user can still receive an access token for cloud resources. But if the tenant enables [User risk-based password change](~/identity/conditional-access/policy-risk-based-user.md), the password change is reported as high risk. 

The user is prompted to change their password again. But if the change still includes a unicode character, they could get locked out if [smart lockout](howto-password-smart-lockout.md) is also enabled. 

## Risk based password reset policy limitations

If you enable [EnforceCloudPasswordPolicyForPasswordSyncedUsers](~/identity/conditional-access/policy-risk-based-user.md), a cloud password change is required once a high risk is identified. The user is prompted to change their password when they sign in to Microsoft Entra ID. The new password must comply with both the cloud and on-premises password policies. 
 
If a password change meets on-premises requirements but fails to meet cloud requirements, the password change succeeds if password hash synchronization is enabled. For example, if the new password includes a Unicode character, the password change can be updated on-premises but not in the cloud. 

If the password didn't comply with the cloud password requirements, it isn't updated in the cloud, and the account risk doesn't decrease. The user still receives an access token for cloud resources, but they're prompted to change their password again the next time they access cloud resources. The user doesn't see any error or notification that their chosen password failed to meet the cloud requirements.

## Administrator reset policy differences

By default, administrator accounts are enabled for self-service password reset, and a strong default *two-gate* password reset policy is enforced. This policy may be different from the one you defined for your users, and this policy can't be changed. You should always test password reset functionality as a user without any Azure administrator roles assigned.

The two-gate policy requires two pieces of authentication data, such as an email address, authenticator app, or a phone number, and it prohibits security questions. Office and mobile voice calls are also prohibited for trial or free versions of Microsoft Entra ID. 

The SSPR administrator policy doesn't depend upon the Authentications method policy. For example, if you disable third party software tokens in the Authentication methods policy, administrator accounts can still register third party software token applications and use them, but only for SSPR. 

A two-gate policy applies in the following circumstances:

* All the following Azure administrator roles are affected:
  * Application Administrator
  * Authentication Administrator
  * Billing Administrator
  * Compliance Administrator
  * Cloud Device Administrator
  * Directory Synchronization Accounts (an admin role assigned to the Microsoft Entra Connect service)
  * Directory Writers
  * Dynamics 365 Administrator
  * Exchange Administrator
  * Global Administrator
  * Helpdesk Administrator
  * Intune Administrator
  * Microsoft Entra Joined Device Local Administrator
  * Partner Tier1 Support
  * Partner Tier2 Support
  * Password Administrator
  * Power Platform Administrator
  * Privileged Authentication Administrator
  * Privileged Role Administrator
  * Security Administrator
  * Service Support Administrator
  * SharePoint Administrator
  * Skype for Business Administrator
  * Teams Administrator
  * Teams Communications Administrator
  * Teams Devices Administrator
  * User Administrator

* If 30 days elapsed in a trial subscription 

  -Or-
  
* A custom domain is configured for your Microsoft Entra tenant, such as *contoso.com*

  -Or-

* Microsoft Entra Connect synchronizes identities from your on-premises directory

You can disable the use of SSPR for administrator accounts using the [Update-MgPolicyAuthorizationPolicy](/powershell/module/microsoft.graph.identity.signins/update-mgpolicyauthorizationpolicy) PowerShell cmdlet. The `-AllowedToUseSspr:$true|$false` parameter enables/disables SSPR for administrators. Policy changes to enable or disable SSPR for administrator accounts can take up to 60 minutes to take effect. 

### Exceptions

A one-gate policy requires one piece of authentication data, such as an email address or phone number. A one-gate policy applies in the following circumstances:

- It's within the first 30 days of a trial subscription 

  -Or-

- A custom domain isn't configured (the tenant is using the default **.onmicrosoft.com*, which isn't recommended for production use) and Microsoft Entra Connect isn't synchronizing identities.

## Password expiration policies

[User Administrators](../role-based-access-control/permissions-reference.md#user-administrator) can use the [Microsoft Graph](/powershell/microsoftgraph/) to set user passwords not to expire.

You can also use PowerShell cmdlets to remove the never-expires configuration or to see which user passwords are set to never expire.

This guidance applies to other providers, such as Intune and Microsoft 365, which also rely on Microsoft Entra ID for identity and directory services. Password expiration is the only part of the policy that can be changed.

> [!NOTE]
> By default only passwords for user accounts that aren't synchronized through Microsoft Entra Connect can be configured to not expire. For more information about directory synchronization, see [Connect AD with Microsoft Entra ID](~/identity/hybrid/connect/how-to-connect-password-hash-synchronization.md#password-expiration-policy).

### Set or check the password policies by using PowerShell

To get started, [download and install the Microsoft Graph PowerShell module](/powershell/microsoftgraph/installation) and [connect it to your Microsoft Entra tenant](/powershell/microsoftgraph/authentication-commands#using-connect-mggraph).

After the module is installed, use the following steps to complete each task as needed.

### Check the expiration policy for a password

1. Open a PowerShell prompt and [connect to your Microsoft Entra tenant](/powershell/microsoftgraph/authentication-commands#using-connect-mggraph) as at least a [User Administrator](../role-based-access-control/permissions-reference.md#user-administrator).

1. Run one of the following commands for either an individual user or for all users:

   * To see if a single user's password is set to never expire, run the following cmdlet. Replace `<user ID>` with the user ID of the user you want to check:

       ```powershell
       Get-MgUser -UserId <user ID> -Property UserPrincipalName, PasswordPolicies | Select-Object @{N="PasswordNeverExpires";E={$_.PasswordPolicies -contains "DisablePasswordExpiration"}}
       ```

   * To see the **Password never expires** setting for all users, run the following cmdlet:

       ```powershell
       Get-MgUser -All -Property UserPrincipalName, PasswordPolicies | Select-Object UserPrincipalName, @{N="PasswordNeverExpires";E={$_.PasswordPolicies -contains "DisablePasswordExpiration"}}
       ```

### Set a password to expire

1. Open a PowerShell prompt and [connect to your Microsoft Entra tenant](/powershell/microsoftgraph/authentication-commands#using-connect-mggraph) as at least a [User Administrator](../role-based-access-control/permissions-reference.md#user-administrator).

1. Run one of the following commands for either an individual user or for all users:

   * To set the password of one user so that the password expires, run the following cmdlet. Replace `<user ID>` with the user ID of the user you want to check:

       ```powershell
       Update-MgUser -UserId <user ID> -PasswordPolicies None
       ```

   * To set the passwords of all users in the organization so that they expire, use the following command:

       ```powershell
       Get-MgUser -All | foreach $_ { Update-MgUser -UserId $_.Id -PasswordPolicies None }
       ```

### Set a password to never expire

1. Open a PowerShell prompt and [connect to your Microsoft Entra tenant](/powershell/microsoftgraph/authentication-commands#using-connect-mggraph) as at least a [User Administrator](../role-based-access-control/permissions-reference.md#user-administrator).
1. Run one of the following commands for either an individual user or for all users:

   * To set the password of one user to never expire, run the following cmdlet. Replace `<user ID>` with the user ID of the user you want to check:

       ```powershell
       Update-MgUser -UserId <user ID> -PasswordPolicies DisablePasswordExpiration
       ```

   * To set the passwords of all the users in an organization to never expire, run the following cmdlet:

       ```powershell
       Get-MgUser -All | foreach $_ { Update-MgUser -UserId $_.Id -PasswordPolicies DisablePasswordExpiration }
       ```

   > [!WARNING]
   > Passwords set to `-PasswordPolicies DisablePasswordExpiration` still age based on the `LastPasswordChangeDateTime` attribute. Based on the `LastPasswordChangeDateTime` attribute, if you change the expiration to `-PasswordPolicies None`, all passwords that have a `LastPasswordChangeDateTime` older than 90 days require the user to change them the next time they sign in. This change can affect a large number of users.

## Next steps

To get started with SSPR, see [Tutorial: Enable users to unlock their account or reset passwords using Microsoft Entra self-service password reset](tutorial-enable-sspr.md).

If you or users have problems with SSPR, see [Troubleshoot self-service password reset](./troubleshoot-sspr.md).
