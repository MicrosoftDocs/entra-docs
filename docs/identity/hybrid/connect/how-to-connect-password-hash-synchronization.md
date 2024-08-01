---
title: Implement password hash synchronization with Microsoft Entra Connect Sync
description: Provides information about how password hash synchronization works and how to set up.

author: billmath
manager: amycolannino
ms.assetid: 05f16c3e-9d23-45dc-afca-3d0fa9dbf501
ms.service: entra-id
ms.custom: has-azure-ad-ps-ref, azure-ad-ref-level-one-done
ms.topic: how-to
ms.date: 11/06/2023
ms.subservice: hybrid-connect
ms.author: billmath
search.appverid:
- MET150


---
# Implement password hash synchronization with Microsoft Entra Connect Sync
This article provides information that you need to synchronize your user passwords from an on-premises Active Directory instance to a cloud-based Microsoft Entra instance.

## How password hash synchronization works
The Active Directory domain service stores passwords in the form of a hash value representation, of the actual user password. A hash value is a result of a one-way mathematical function (the *hashing algorithm*). There's no method to revert the result of a one-way function to the plain text version of a password. 

To synchronize your password, Microsoft Entra Connect Sync extracts your password hash from the on-premises Active Directory instance. Extra security processing is applied to the password hash before it's synchronized to the Microsoft Entra authentication service. Passwords are synchronized on a per-user basis and in chronological order.

The actual data flow of the password hash synchronization process is similar to the synchronization of user data. However, passwords are synchronized more frequently than the standard directory synchronization window for other attributes. The password hash synchronization process runs every 2 minutes. You can't modify the frequency of this process. When you synchronize a password, it overwrites the existing cloud password.

The first time you enable the password hash synchronization feature, it performs an initial synchronization of the passwords of all in-scope users. [Staged Rollout](how-to-connect-staged-rollout.md) allows you to selectively test groups of users with cloud authentication capabilities like Microsoft Entra multifactor authentication, Conditional Access, Identity Protection for leaked credentials, Identity Governance, and others, before cutting over your domains. You can't explicitly define a subset of user passwords that you want to synchronize. However, if there are multiple connectors, it's possible to disable password hash sync for some connectors but not others using the [Set-ADSyncAADPasswordSyncConfiguration](/entra/identity/domain-services/tutorial-configure-password-hash-sync) cmdlet.

When you change an on-premises password, the updated password is synchronized, most often in a matter of minutes.
The password hash synchronization feature automatically retries failed synchronization attempts. If an error occurs during an attempt to synchronize a password, an error is logged in your event viewer.

The synchronization of a password has no impact on the user  who is currently signed in.
Your current cloud service session isn't immediately affected by a synchronized password change that occurs, while you're signed in, to a cloud service. However, when the cloud service requires you to authenticate again, you need to provide your new password.

A user must enter their corporate credentials a second time to authenticate to Microsoft Entra ID, regardless of whether they're signed in to their corporate network. This pattern can be minimized, however, if the user selects the Keep me signed in (KMSI) check box at sign-in. This selection sets a session cookie that bypasses authentication for 180 days. KMSI behavior can be enabled or disabled by the Microsoft Entra administrator. In addition, you can reduce password prompts by configuring [Microsoft Entra join](~/identity/devices/concept-directory-join.md) or [Microsoft Entra hybrid join](~/identity/devices/concept-hybrid-join.md), which automatically signs users in when they are on their corporate devices connected to your corporate network.

### More advantages

- Generally, password hash synchronization is simpler to implement than a federation service. It doesn't require any more servers, and eliminates dependence on a highly available federation service to authenticate users.
- Password hash synchronization can also be enabled in addition to federation. It may be used as a fallback if your federation service experiences an outage.

> [!NOTE]
> Password sync is only supported for the object type user in Active Directory. It isn't supported for the iNetOrgPerson object type.

### Detailed description of how password hash synchronization works

The following section describes, in-depth, how password hash synchronization works between Active Directory and Microsoft Entra ID.

[![Detailed password flow](./media/how-to-connect-password-hash-synchronization/arch3d.png)](./media/how-to-connect-password-hash-synchronization/arch3d.png#lightbox)

1. Every two minutes, the password hash synchronization agent on the AD Connect server requests stored password hashes (the unicodePwd attribute) from a DC. This request is via the standard [MS-DRSR](/openspecs/windows_protocols/ms-drsr/f977faaa-673e-4f66-b9bf-48c640241d47) replication protocol used to synchronize data between DCs. The AD DS Connector account must have Replicate Directory Changes and Replicate Directory Changes All AD permissions (granted by default on installation) to obtain the password hashes.

2. Before sending, the DC encrypts the MD4 password hash by using a key that is a [MD5](https://www.rfc-editor.org/rfc/rfc1321.txt) hash of the RPC session key and a salt. It then sends the result to the password hash synchronization agent over RPC. The DC also passes the salt to the synchronization agent by using the DC replication protocol, so the agent is able to decrypt the envelope.
3. After the password hash synchronization agent has the encrypted envelope, it uses [MD5CryptoServiceProvider](/dotnet/api/system.security.cryptography.md5cryptoserviceprovider) and the salt to generate a key to decrypt the received data back to its original MD4 format. The password hash synchronization agent never has access to the clear text password. The password hash synchronization agent’s use of MD5 is strictly for replication protocol compatibility with the DC, and it's only used on-premises between the DC and the password hash synchronization agent.
4. The password hash synchronization agent expands the 16-byte binary password hash to 64 bytes by first converting the hash to a 32-byte hexadecimal string, then converting this string back into binary with UTF-16 encoding.
5. The password hash synchronization agent adds a per user salt, consisting of a 10-byte length salt, to the 64-byte binary to further protect the original hash.
6. The password hash synchronization agent then combines the MD4 hash plus the per user salt, and inputs it into the [PBKDF2](https://www.ietf.org/rfc/rfc2898.txt) function. 1,000 iterations of the [HMAC-SHA256](/dotnet/api/system.security.cryptography.hmacsha256) keyed hashing algorithm are used. For more details, refer to the [Microsoft Entra Whitepaper](https://aka.ms/aaddatawhitepaper).
7. The password hash synchronization agent takes the resulting 32-byte hash, concatenates both the per user salt and the number of SHA256 iterations to it (for use by Microsoft Entra ID), then transmits the string from Microsoft Entra Connect to Microsoft Entra ID over TLS.</br> 
8. When a user attempts to sign in to Microsoft Entra ID and enters their password, the password is run through the same MD4+salt+PBKDF2+HMAC-SHA256 process. If the resulting hash matches the hash stored in Microsoft Entra ID, it means the user entered the correct password and is authenticated.

> [!NOTE]
> The original MD4 hash isn't transmitted to Microsoft Entra ID. Instead, the SHA256 hash of the original MD4 hash is transmitted. As a result, if the hash stored in Microsoft Entra ID is obtained, it can't be used in an on-premises pass-the-hash attack.

> [!NOTE]
> The password hash value is **NEVER** stored in SQL. These values are only processed in memory prior to being sent to Microsoft Entra ID.


### Security considerations

When synchronizing passwords, the plain-text version of your password isn't exposed to the password hash synchronization feature, to Microsoft Entra ID, or any of the associated services.

User authentication takes place against Microsoft Entra rather than against the organization's own Active Directory instance. The SHA256 password data stored in Microsoft Entra ID (a hash of the original MD4 hash) is more secure than what is stored in Active Directory. Further, because this SHA256 hash can't be decrypted, it can't be brought back to the organization's Active Directory environment and presented as a valid user password in a pass-the-hash attack.

### Password policy considerations

There are two types of password policies that are affected by enabling password hash synchronization:

* Password complexity policy
* Password expiration policy

#### Password complexity policy

When password hash synchronization is enabled, the password complexity policies in your on-premises Active Directory instance override complexity policies in the cloud for synchronized users. You can use all of the valid passwords from your on-premises Active Directory instance to access Microsoft Entra services.

> [!NOTE]
> Passwords for users that are created directly in the cloud are still subject to password policies as defined in the cloud.

#### Password expiration policy

If a user is in the scope of password hash synchronization, by default the cloud account password is set to *Never Expire*.

You can continue to sign in to your cloud services by using a synchronized password that is expired in your on-premises environment. Your cloud password is updated the next time you change the password in the on-premises environment.

##### CloudPasswordPolicyForPasswordSyncedUsersEnabled

If there are synchronized users that only interact with Microsoft Entra integrated services and must also comply with a password expiration policy, you can force them to comply with your Microsoft Entra password expiration policy by enabling the *CloudPasswordPolicyForPasswordSyncedUsersEnabled* feature (in the deprecated MSOnline PowerShell module it was called *EnforceCloudPasswordPolicyForPasswordSyncedUsers*).

When *CloudPasswordPolicyForPasswordSyncedUsersEnabled* is disabled (which is the default setting), Microsoft Entra Connect updates the PasswordPolicies attribute of synchronized users to "DisablePasswordExpiration". This update is done every time a user's password is synchronized and instructs Microsoft Entra ID to ignore the cloud password expiration policy for that user. You can check the value of the attribute using the [Microsoft Graph PowerShell](/powershell/microsoftgraph/overview) module with the following command:

`(Get-MgUser -UserId <User Object ID> -Property PasswordPolicies).PasswordPolicies`

To enable the CloudPasswordPolicyForPasswordSyncedUsersEnabled feature, run the following commands using the Graph PowerShell module:

```powershell
$OnPremSync = Get-MgDirectoryOnPremiseSynchronization
$OnPremSync.Features.CloudPasswordPolicyForPasswordSyncedUsersEnabled = $true

Update-MgDirectoryOnPremiseSynchronization `
  -OnPremisesDirectorySynchronizationId $OnPremSync.Id `
  -Features $OnPremSync.Features 
```

> [!NOTE]
> You need to install the MSGraph PowerShell module for the preceding script to work. If you get any errors related to insufficient privileges, make sure that you have consented the API scope correctly by using the following command when connecting `Connect-MgGraph -Scopes "OnPremDirectorySynchronization.ReadWrite.All"`


Once enabled, Microsoft Entra ID doesn't go to each synchronized user to remove the `DisablePasswordExpiration` value from the PasswordPolicies attribute. Instead, the `DisablePasswordExpiration` value is removed from PasswordPolicies during the next password hash sync for each user, upon their next password change in on-premises AD.

After the *CloudPasswordPolicyForPasswordSyncedUsersEnabled* feature is enabled, new users are provisioned without a PasswordPolicies value.

>[!TIP]
>It's recommended to enable *CloudPasswordPolicyForPasswordSyncedUsersEnabled* prior to enabling password hash sync, so that the initial sync of password hashes doesn't add the `DisablePasswordExpiration` value to the PasswordPolicies attribute for the users.

The default Microsoft Entra password policy requires users to change their passwords every 90 days. If your policy in AD is also 90 days, the two policies should match. However, if the AD policy isn't 90 days, you can update the Microsoft Entra password policy to match by using the Update-MgDomain PowerShell command.

Microsoft Entra ID supports a separate password expiration policy per registered domain.

Caveat: If there are synchronized accounts that need to have nonexpiring passwords in Microsoft Entra ID, you must explicitly add the `DisablePasswordExpiration` value to the PasswordPolicies attribute of the user object in Microsoft Entra ID. You can add this value by running the following command:

```powershell
Update-MgUser -UserID <User Object ID> -PasswordPolicies "DisablePasswordExpiration"`
```

> [!NOTE]
> For hybrid users that have a PasswordPolicies value set to `DisablePasswordExpiration`, this value switches to `None` after a password change is executed on-premises.

> [!NOTE]
> The [Update-MgDomain](/powershell/module/microsoft.graph.identity.directorymanagement/update-mgdomain) PowerShell command doesn't work on federated domains.

> [!NOTE]
> The [Update-MgUser](/powershell/module/microsoft.graph.users/update-mguser) PowerShell command doesn't work on federated domains.

#### Synchronizing temporary passwords and "Force Password Change on Next Logon"

It's typical to force a user to change their password during their first logon, especially after an admin password reset occurs. It's commonly known as setting a "temporary" password and is completed by checking the "User must change password at next logon" flag on a user object in Active Directory (AD).
  
The temporary password functionality helps to ensure that the transfer of ownership of the credential is completed on first use, to minimize the duration of time in which more than one individual has knowledge of that credential.

To support temporary passwords in Microsoft Entra ID for synchronized users, you can enable the *ForcePasswordChangeOnLogOn* feature, by running the following commands using the Graph PowerShell module:

```powershell
$OnPremSync = Get-MgDirectoryOnPremiseSynchronization
$OnPremSync.Features.UserForcePasswordChangeOnLogonEnabled = $true

Update-MgDirectoryOnPremiseSynchronization `
  -OnPremisesDirectorySynchronizationId $OnPremSync.Id `
  -Features $OnPremSync.Features 
```

> [!NOTE]
> A new user created in Active Directory with "User must change password at next logon" flag will always be provisioned in Microsoft Entra ID with a password policy to "Force change password on next sign-in", irrespective of the *ForcePasswordChangeOnLogOn* feature being true or false. This is a Microsoft Entra internal logic since the new user is provisioned without a password, whereas *ForcePasswordChangeOnLogOn* feature only affects admin password reset scenarios.
>
> If a user was created in Active Directory with "User must change password at next logon" before the feature was enabled, the user will receive an error while signing in. To remediate this issue, un-check and re-check the field "User must change password at next logon" in Active Directory Users and Computers. After synchronizing the user object changes, the user will receive the expected prompt in Microsoft Entra ID to update their password. 

> [!CAUTION]
> You should only use this feature when SSPR and Password Writeback are enabled on the tenant.  This is so that if a user changes their password via SSPR, it will be synchronized to Active Directory.

#### Account expiration

If your organization uses the accountExpires attribute as part of user account management, this attribute isn't synchronized to Microsoft Entra ID. As a result, an expired Active Directory account in an environment configured for password hash synchronization will still be active in Microsoft Entra ID. We recommend using a scheduled PowerShell script that disables users' AD accounts, once they expire (use the [Set-ADUser](/powershell/module/activedirectory/set-aduser) cmdlet). Conversely, during the process of removing the expiration from an AD account, the account should be re-enabled.

### Overwrite synchronized passwords

An administrator can manually reset your password directly in Microsoft Entra ID by using PowerShell (unless the user is in a federated domain).

In this case, the new password overrides your synchronized password, and all password policies defined in the cloud are applied to the new password.

If you change your on-premises password again, the new password is synchronized to the cloud, and it overrides the manually updated password.

The synchronization of a password has no impact on the Azure user who is signed in. Your current cloud service session isn't immediately affected by a synchronized password change that occurs while you're signed in to a cloud service. KMSI extends the duration of this difference. When the cloud service requires you to authenticate again, you need to provide your new password.

<a name='password-hash-sync-process-for-azure-ad-domain-services'></a>

## Password hash sync process for Microsoft Entra Domain Services

If you use Microsoft Entra Domain Services to provide legacy authentication for applications and services that need to use Kerberos, LDAP, or NTLM, some extra processes are part of the password hash synchronization flow. Microsoft Entra Connect uses the following process to synchronize password hashes to Microsoft Entra ID for use in Microsoft Entra Domain Services:

> [!IMPORTANT]
> Microsoft Entra Connect should only be installed and configured for synchronization with on-premises AD DS environments. It's not supported to install Microsoft Entra Connect in a Microsoft Entra Domain Services managed domain to synchronize objects back to Microsoft Entra ID.
>
> Microsoft Entra Connect only synchronizes legacy password hashes when you enable Microsoft Entra Domain Services for your Microsoft Entra tenant. The following steps aren't used if you only use Microsoft Entra Connect to synchronize an on-premises AD DS environment with Microsoft Entra ID.
>
> If your legacy applications don't use NTLM authentication or LDAP simple binds, we recommend that you disable NTLM password hash synchronization for Microsoft Entra Domain Services. For more information, see [Disable weak cipher suites and NTLM credential hash synchronization](/entra/identity/domain-services/secure-your-domain).

1. Microsoft Entra Connect retrieves the public key for the tenant's instance of Microsoft Entra Domain Services.
1. When a user changes their password, the on-premises domain controller stores the result of the password change (hashes) in two attributes:
    * *unicodePwd* for the NTLM password hash.
    * *supplementalCredentials* for the Kerberos password hash.
1. Microsoft Entra Connect detects password changes through the directory replication channel (attribute changes needing to replicate to other domain controllers).
1. For each user whose password changed, Microsoft Entra Connect performs the following steps:
    * Generates a random AES 256-bit symmetric key.
    * Generates a random initialization vector needed for the first round of encryption.
    * Extracts Kerberos password hashes from the *supplementalCredentials* attributes.
    * Checks the Microsoft Entra Domain Services security configuration *SyncNtlmPasswords* setting.
        * If this setting is disabled, generates a random, high-entropy NTLM hash (different from the user's password). This hash is then combined with the exacted Kerberos password hashes from the *supplementalCrendetials* attribute into one data structure.
        * If enabled, combines the value of the *unicodePwd* attribute with the extracted Kerberos password hashes from the *supplementalCredentials* attribute into one data structure.
    * Encrypts the single data structure using the AES symmetric key.
    * Encrypts the AES symmetric key using the tenant's Microsoft Entra Domain Services public key.
1. Microsoft Entra Connect transmits the encrypted AES symmetric key, the encrypted data structure containing the password hashes, and the initialization vector to Microsoft Entra ID.
1. Microsoft Entra ID stores the encrypted AES symmetric key, the encrypted data structure, and the initialization vector for the user.
1. Microsoft Entra ID pushes the encrypted AES symmetric key, the encrypted data structure, and the initialization vector using an internal synchronization mechanism over an encrypted HTTP session to Microsoft Entra Domain Services.
1. Microsoft Entra Domain Services retrieves the private key for the tenant's instance from Azure Key vault.
1. For each encrypted set of data (representing a single user's password change), Microsoft Entra Domain Services then performs the following steps:
    * Uses its private key to decrypt the AES symmetric key.
    * Uses the AES symmetric key with the initialization vector to decrypt the encrypted data structure that contains the password hashes.
    * Writes the Kerberos password hashes it receives to the Microsoft Entra Domain Services domain controller. The hashes are saved into the user object's *supplementalCredentials* attribute that is encrypted to the Microsoft Entra Domain Services domain controller's public key.
    * Microsoft Entra Domain Services writes the NTLM password hash it received to the Microsoft Entra Domain Services domain controller. The hash is saved into the user object's *unicodePwd* attribute that is encrypted to the Microsoft Entra Domain Services domain controller's public key.

## Enable password hash synchronization

>[!IMPORTANT]
>If you're migrating from AD FS (or other federation technologies) to Password Hash Synchronization, view [Resources for migrating applications to Microsoft Entra ID](~/identity/enterprise-apps/migration-resources.md).

When you install Microsoft Entra Connect by using the **Express Settings** option, password hash synchronization is automatically enabled. For more information, see [Getting started with Microsoft Entra Connect using express settings](how-to-connect-install-express.md).

If you use custom settings when you install Microsoft Entra Connect, password hash synchronization is available on the user sign-in page. For more information, see [Custom installation of Microsoft Entra Connect](how-to-connect-install-custom.md).

![Enabling password hash synchronization](./media/how-to-connect-password-hash-synchronization/usersignin2.png)

### Password hash synchronization and FIPS
If your server is locked down according to Federal Information Processing Standard (FIPS), then MD5 is disabled.

**To enable MD5 for password hash synchronization, perform the following steps:**

1. Go to %programfiles%\Microsoft Azure AD Sync\Bin.
2. Open miiserver.exe.config.
3. Go to the configuration/runtime node at the end of the file.
4. Add the following node: `<enforceFIPSPolicy enabled="false" />`
5. Save your changes.
6. Reboot for the changes to take effect.

For reference, this snippet is what it should look like:

```
    <configuration>
        <runtime>
            <enforceFIPSPolicy enabled="false" />
        </runtime>
    </configuration>
```

For information about security and FIPS, see [Microsoft Entra password hash sync, encryption, and FIPS compliance](https://techcommunity.microsoft.com/t5/microsoft-entra-azure-ad-blog/aad-password-sync-encryption-and-fips-compliance/ba-p/243709).

## Troubleshoot password hash synchronization
If you have problems with password hash synchronization, see [Troubleshoot password hash synchronization](tshoot-connect-password-hash-synchronization.md).

## Next steps
* [Microsoft Entra Connect Sync: Customizing synchronization options](how-to-connect-sync-whatis.md)
* [Integrating your on-premises identities with Microsoft Entra ID](../whatis-hybrid-identity.md)
* [Resources for migrating applications to Microsoft Entra ID](~/identity/enterprise-apps/migration-resources.md)
