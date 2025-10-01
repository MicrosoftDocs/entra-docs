---
title: Considerations for scrambling user passwords in a phishing-resistant passwordless authentication deployment in Microsoft Entra ID
description: Password scrambling guidance to deploy passwordless and phishing-resistant authentication for organizations that use Microsoft Entra ID.

ms.service: entra-id 
ms.subservice: authentication
ms.topic: how-to
ms.date: 10/01/2025

ms.author: justinha
author: mepples21
manager: dougeby
ms.reviewer: miepping

ms.collection: M365-identity-device-management
# Customer intent: As an identity administrator, I want to understand how to plan phishing-resistant and passwordless authentication deployment in Microsoft Entra ID

---

# Plan to scramble passwords in a phishing-resistant passwordless authentication deployment in Microsoft Entra ID

User accounts in Microsoft Entra ID and on-premises Active Directory Domain Service (AD DS) have their passwords managed through different processes, depending on whether the account is synced from on-premises to the cloud, or if the user is a cloud-only object. Organizations should follow the guidance for each type of user, depending on how the organization's objects are managed.

## Prerequisites

- Microsoft Entra Connect sync [version 2.4.18.0 or later](~/identity/hybrid/connect/how-to-connect-password-hash-synchronization.md#password-hash-synchronization-and-smart-card-authentication)

## Scrambling passwords for hybrid user accounts synced from on-premises AD DS

Organizations with users synced from on-premises AD DS to Microsoft Entra ID should scramble user passwords in the on-premises environment, as on-premises is the source of authority for synced user accounts and their passwords. If your organization uses [cloud authentication](~/identity/hybrid/connect/choose-ad-authn.md) and syncs password hashes to Microsoft Entra ID, then these scrambled passwords are also synced to the cloud. The sync process ensures that users aren't aware of their passwords in either on-premises or the cloud, preventing their use and driving users towards using more secure phishing-resistant passwordless credentials.

### Option 1: Scrambling on-premises user passwords with Smart Card Required for Interactive Logon (SCRIL)

Scrambling user passwords with the Smart Card Required for Interactive Logon (SCRIL) setting is the recommended method for scrambling user passwords on-premises because it's a natively available option in AD DS. When SCRIL is enabled on a user object, the user’s AD DS password is randomized by the domain controller to a value no one knows. The user has to enroll and then must authenticate to the AD DS domain by using a smart card or Windows Hello for Business. With password hash synchronization enabled, this AD DS password hash is also synced with Microsoft Entra ID.

The Smart Card Required for Interactive Logon setting can be configured using the Active Directory Users and Computers tool. The following sample PowerShell script can be used to enable the setting programatically, including for many users at once. Modify the **samAccountName** variable of the script to match your environment, and then run it in a PowerShell session. Use the credentials of an admin account with appropriate permissions in on-premises AD.

```PowerShell
$samAccountName = <sAMAccountName of the user>

Import-Module ActiveDirectory
Set-ADUser -Identity $samAccountName -SmartcardLogonRequired $true
```

### Option 2: Scrambling on-premises user passwords with a scripted random value

If your organization would prefer not to use Smart Card Required for Interactive Logon (SCRIL), then an alternative approach can be to scramble the password with a script. Organizations should choose this approach if they need users to recover their passwords to access legacy apps. If your organization chooses this approach, it's recommended that you periodically rerun the script to scramble any passwords that users reset back to a known state.

The following sample PowerShell script generates a random password of 64 characters and sets it for the user specified in the variable name **$samAccountName** against on-premises Active Directory. Modify the **samAccountName** variable of the script to match your environment, and then run it in a PowerShell session. Use the credentials of an admin account with appropriate permissions in on-premises AD.

```PowerShell
$samAccountName = <sAMAccountName of the user>

Import-Module ActiveDirectory

function Generate-RandomPassword{
    [CmdletBinding()]
    param (
      [int]$Length = 64
    )
  $chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*()-_=+[]{};:,.<>/?\|`~"
  $random = New-Object System.Random
  $password = ""
  for ($i = 0; $i -lt $Length; $i++) {
    $index = $random.Next(0, $chars.Length)
    $password += $chars[$index]
  }
  return $password
}

Import-Module ActiveDirectory

$NewPassword = ConvertTo-SecureString -String (Generate-RandomPassword) -AsPlainText -Force

Set-ADAccountPassword -Identity $samAccountName -NewPassword $NewPassword -Reset
```

> [!CAUTION]
> Execute the script only from a secure and trusted environment, and ensure that the script isn't logged. Treat the host where the script is executed as a privileged host, with the same level of security as a domain controller.

## Scrambling passwords for cloud user accounts in Microsoft Entra ID

Cloud-based passwordless users should have their password set to a random value. Randomizing the password prevents the user from knowing the password and using it to authenticate. Optionally, organizations  choose allow end users to reset their password if they encounter an application where they need the password. It's recommended that you periodically rerun the script to scramble any passwords that users have reset back to a known state.

The following sample PowerShell script generates a random password of 64 characters and sets it for the user specified in the variable name **$userId** against Microsoft Entra ID. Modify the **userId** variable of the script to match your environment, and then run it in a PowerShell session. When prompted to authenticate to Microsoft Entra ID, use the credentials of an account with a role capable of resetting passwords.

```PowerShell
$userId = "<UPN of the user>"

function Generate-RandomPassword{
    [CmdletBinding()]
    param (
      [int]$Length = 64
    )
  $chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*()-_=+[]{};:,.<>/?\|`~"
  $random = New-Object System.Random
  $password = ""
  for ($i = 0; $i -lt $Length; $i++) {
    $index = $random.Next(0, $chars.Length)
    $password += $chars[$index]
  }
  return $password
}

Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
Install-Module Microsoft.Graph -Scope CurrentUser
Import-Module Microsoft.Graph.Users.Actions
Connect-MgGraph -Scopes "UserAuthenticationMethod.ReadWrite.All" -NoWelcome

$passwordParams = @{
 UserId = $userId
 AuthenticationMethodId = "28c10230-6103-485e-b985-444c60001490"
 NewPassword = Generate-RandomPassword
}

Reset-MgUserAuthenticationMethodPassword @passwordParams
```

> [!CAUTION]
> Execute the script only from a secure and trusted environment, and ensure that the script isn't logged. Treat the host where the script is executed as a privileged host, with the same level of security as a domain controller.

## Additional considerations for organizations at 100% phishing-resistant passwordless enforcement

If your organization no longer needs passwords whatsoever, because all applications and scenarios are compatible with passwordless credentials, then you may no longer need to provide users with self-service password recovery options. Consider disabling tools that let users override the scrambled passwords and gain access to their password again.

1. Disable self-service password reset (SSPR) tools, including [Microsoft Entra self-service password reset](~/identity/authentication/tutorial-enable-sspr-writeback.md#clean-up-resources)
1. Disable password writeback from [Microsoft Entra to on-premises Active Directory](~/identity/authentication/tutorial-enable-sspr-writeback.md#clean-up-resources)
1. Set your Microsoft Entra password policy to have [no expiry](~/identity/authentication/concept-sspr-policy.md)

## Relate content

[Deploy a phishing-resistant passwordless authentication deployment in Microsoft Entra ID](how-to-deploy-phishing-resistant-passwordless-authentication.md)
