---
title: Combined password policy and check for weak passwords in Microsoft Entra ID
description: Learn about the combined password policy and check for weak passwords in Microsoft Entra ID

ms.service: entra-id
ms.subservice: authentication
ms.custom: has-azure-ad-ps-ref, azure-ad-ref-level-one-done
ms.topic: conceptual
ms.date: 11/27/2024

ms.author: justinha
author: justinha
manager: amycolannino
ms.reviewer: tilarso
---
# Combined password policy and check for weak passwords in Microsoft Entra ID

Beginning in October 2021, Microsoft Entra validation for compliance with password policies also includes a check for [known weak passwords](concept-password-ban-bad.md) and their variants. 
This topic explains details about the password policy criteria checked by Microsoft Entra ID. 

<a name='azure-ad-password-policies'></a>

## Microsoft Entra password policies

A password policy is applied to all user and admin accounts that are created and managed directly in Microsoft Entra ID. You can [ban weak passwords](concept-password-ban-bad.md) and define parameters to [lock out an account](howto-password-smart-lockout.md) after repeated bad password attempts. Other password policy settings can't be modified.

The Microsoft Entra password policy doesn't apply to user accounts synchronized from an on-premises AD DS environment using Microsoft Entra Connect unless you enable EnforceCloudPasswordPolicyForPasswordSyncedUsers. If EnforceCloudPasswordPolicyForPasswordSyncedUsers and password writeback are enabled, Microsoft Entra password expiration policy applies, but the on-premises password policy takes precedence for length, complexity, and so on.

The following Microsoft Entra password policy requirements apply for all passwords that are created, changed, or reset in Microsoft Entra ID. Requirements are applied during user provisioning, password change, and password reset flows. You can't change these settings except as noted.

| Property | Requirements |
| --- | --- |
| Characters allowed |Uppercase characters (A - Z)<br>Lowercase characters (a - z)<br>Numbers (0 - 9)<br>Symbols:<br>- @ # $ % ^ & * - _ ! + = [ ] { } &#124; \ : ' , . ? / \` ~ " ( ) ; < ><br>- blank space |
| Characters not allowed | Unicode characters |
| Password length |Passwords require<br>- A minimum of eight characters<br>- A maximum of 256 characters</li> |
| Password complexity |Passwords require three out of four of the following categories:<br>- Uppercase characters<br>- Lowercase characters<br>- Numbers <br>- Symbols<br> Note: Password complexity check isn't required for Education tenants. |
| Password not recently used | When a user changes their password, the new password should not be the same as the current password. |
| Password isn't banned by [Microsoft Entra Password Protection](concept-password-ban-bad.md) | The password can't be on the global list of banned passwords for Microsoft Entra Password Protection, or on the customizable list of banned passwords specific to your organization. |

## Password expiration policies

Password expiration policies are unchanged but they're included in this topic for completeness. Those assigned at least the [User Administrator](../role-based-access-control/permissions-reference.md#user-administrator) role can use the [Microsoft Graph PowerShell cmdlets](/powershell/microsoftgraph/) to set user passwords not to expire.

> [!NOTE]
> By default, only passwords for user accounts that aren't synchronized through Microsoft Entra Connect can be configured to not expire. For more information about directory synchronization, see [Connect AD with Microsoft Entra ID](~/identity/hybrid/connect/how-to-connect-password-hash-synchronization.md#password-expiration-policy).

You can also use PowerShell to remove the never-expires configuration, or to see user passwords that are set to never expire.

The following expiration requirements apply to other providers that use Microsoft Entra ID for identity and directory services, such as Microsoft Intune and Microsoft 365. 

| Property | Requirements |
| --- | --- |
| Password expiry duration (Maximum password age) |Default value: **90** days.<br>The value is configurable by using the [Update-MgDomain](/powershell/module/microsoft.graph.identity.directorymanagement/update-mgdomain) cmdlet from the Microsoft Graph PowerShell module. |
| Password expiry (Let passwords never expire) |Default value: **false** (indicates that password's have an expiration date).<br>The value can be configured for individual user accounts by using the [Update-MgUser](/powershell/module/microsoft.graph.users/update-mguser) cmdlet.|

## Next steps

- [Password policies and account restrictions in Microsoft Entra ID](concept-sspr-policy.md)
- [Eliminate bad passwords using Microsoft Entra Password Protection](concept-password-ban-bad.md)
