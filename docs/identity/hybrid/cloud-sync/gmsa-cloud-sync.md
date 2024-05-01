---
title: 'Using a group managed service account with Microsoft Entra Cloud Sync '
description: This document details using a gMSA account with cloud sync

author: billmath
manager: amycolannino
ms.service: entra-id
ms.topic: how-to
ms.date: 11/06/2023
ms.subservice: hybrid-connect
ms.author: billmath


ms.custom:
---




# Group Managed Service Accounts

A group Managed Service Account is a managed domain account that provides automatic password management, simplified service principal name (SPN) management, the ability to delegate the management to other administrators, and also extends this functionality over multiple servers. Microsoft Entra Cloud Sync supports and uses a gMSA for running the agent. You'll be prompted for administrative credentials during setup, in order to create this account. The account appears as `domain\provAgentgMSA$`. For more information on a gMSA, see [group Managed Service Accounts](/windows-server/security/group-managed-service-accounts/group-managed-service-accounts-overview).

### Prerequisites for gMSA

1. The Active Directory schema in the gMSA domain's forest needs to be updated to Windows Server 2012 or later.
2. [PowerShell RSAT modules](/windows-server/remote/remote-server-administration-tools) on a domain controller.
3. At least one domain controller in the domain must be running Windows Server 2012 or later.
4. A domain joined server where the agent is being installed needs to be either Windows Server 2016 or later.


### Permissions set on a gMSA account (ALL permissions)
When the installer creates the gMSA account, it sets **ALL** of the permissions on the account.  The following tables detail these permissions

#### Basic Read

|Type |Name |Access |Applies To| 
|-----|-----|-----|-----|
|Allow |&lt;gmsa account&gt;|Read all properties |Descendant device objects| 
|Allow |&lt;gmsa account&gt;|Read all properties |Descendant InetOrgPerson objects| 
|Allow |&lt;gmsa account&gt;|Read all properties |Descendant Computer objects| 
|Allow |&lt;gmsa account&gt;|Read all properties |Descendant foreignSecurityPrincipal objects| 
|Allow |&lt;gmsa account&gt;|Read all properties |Descendant Group objects| 
|Allow |&lt;gmsa account&gt;|Read all properties |Descendant User objects| 
|Allow |&lt;gmsa account&gt;|Read all properties |Descendant Contact objects| 
|Allow|&lt;gmsa account&gt;|Replicating Directory Changes|This object only (Domain root)|

#### MS-DS-Consistency-Guid

|Type |Name |Access |Applies To|
|-----|-----|-----|-----| 
|Allow|&lt;gmsa account&gt;|Write property mS-DS-ConsistencyGuid|Descendant user objects|
|Allow|&lt;gmsa account&gt;|Write property mS-DS-ConsistencyGuid|Descendant group objects|

If the associated forest is hosted in a Windows Server 2016 environment, it includes the following permissions for NGC keys and STK keys.

|Type |Name |Access |Applies To|
|-----|-----|-----|-----| 
|Allow|&lt;gmsa account&gt;|Write property msDS-KeyCredentialLink|Descendant user objects|
|Allow|&lt;gmsa account&gt;|Write property msDS-KeyCredentialLink|Descendant device objects|

#### Password Hash Sync

|Type |Name |Access |Applies To|
|-----|-----|-----|-----| 
|Allow |&lt;gmsa account&gt;|Replicating Directory Changes |This object only (Domain root)| 
|Allow |&lt;gmsa account&gt;|Replicating Directory Changes All |This object only (Domain root)| 
  
#### Password Writeback 

|Type |Name |Access |Applies To|
|-----|-----|-----|-----| 
|Allow |&lt;gmsa account&gt;|Reset Password |Descendant User objects| 
|Allow |&lt;gmsa account&gt;|Write property lockoutTime |Descendant User objects| 
|Allow |&lt;gmsa account&gt;|Write property pwdLastSet |Descendant User objects| 
|Allow |&lt;gmsa account&gt;|Unexpire Password|This object only (Domain root)| 

#### Group Writeback 

|Type |Name |Access |Applies To|
|-----|-----|-----|-----| 
|Allow |&lt;gmsa account&gt;|Generic Read/Write |All attributes of object type group and subobjects| 
|Allow |&lt;gmsa account&gt;|Create/Delete child object |All attributes of object type group and subobjects| 
|Allow |&lt;gmsa account&gt;|Delete/Delete tree objects|All attributes of object type group and subobjects|

#### Exchange Hybrid Deployment 

|Type |Name |Access |Applies To|
|-----|-----|-----|-----| 
|Allow |&lt;gmsa account&gt;|Read/Write all properties |Descendant User objects| 
|Allow |&lt;gmsa account&gt;|Read/Write all properties |Descendant InetOrgPerson objects| 
|Allow |&lt;gmsa account&gt;|Read/Write all properties |Descendant Group objects| 
|Allow |&lt;gmsa account&gt;|Read/Write all properties |Descendant Contact objects| 

#### Exchange Mail Public Folders

|Type |Name |Access |Applies To|
|-----|-----|-----|-----| 
|Allow |&lt;gmsa account&gt;|Read all properties |Descendant PublicFolder objects| 

#### UserGroupCreateDelete (CloudHR)

|Type |Name |Access |Applies To|
|-----|-----|-----|-----| 
|Allow |&lt;gmsa account&gt;|Generic write |All attributes of object type group and subobjects| 
|Allow |&lt;gmsa account&gt;|Create/Delete child object|All attributes of object type group and subobjects| 
|Allow |&lt;gmsa account&gt;|Generic write |All attributes of object type user and subobjects| 
|Allow |&lt;gmsa account&gt;|Create/Delete child object|All attributes of object type user and subobjects| 

### Using a custom gMSA account

If you're creating a custom gMSA account, you need to ensure that the account has the following permissions.  The installer **doesn't** set the permissions if a custom gMSA account is specified.  These permissions reflect the **ALL** permissions set by the installer. 

|Type |Name |Access |Applies To|
|-----|-----|-----|-----|
|Allow |&lt;gmsa account&gt;|Read all properties |Descendant device objects|
|Allow |&lt;gmsa account&gt;|Read all properties |Descendant InetOrgPerson objects|
|Allow |&lt;gmsa account&gt;|Read all properties |Descendant Computer objects|
|Allow |&lt;gmsa account&gt;|Read all properties |Descendant foreignSecurityPrincipal objects|
|Allow |&lt;gmsa account&gt;|Full control |Descendant Group objects|
|Allow |&lt;gmsa account&gt;|Read all properties |Descendant User objects|
|Allow |&lt;gmsa account&gt;|Read all properties |Descendant Contact objects|
|Allow |&lt;gmsa account&gt;|Create/delete User objects|This object and all descendant objects|

For steps on how to upgrade an existing agent to use a gMSA account see [group Managed Service Accounts](how-to-install.md#group-managed-service-accounts).

For more information on how to prepare your Active Directory for group Managed Service Account, see [group Managed Service Accounts Overview](/windows-server/security/group-managed-service-accounts/group-managed-service-accounts-overview).

### Apply a subset of permissions
You can apply only a subset of the permissions using the Set-AADCloudSyncPermission cmdlet.

 See [Using Set-AADCloudSyncPermission](how-to-gmsa-cmdlets.md#using-set-aadcloudsyncpermissions) below for examples on setting specific permissions.


#### Supported permission types
The Set-AADCloudSyncPermission cmdlet supports the following permission types.

|Permission type|Description|
|-----|-----|
|BasicRead| See [BasicRead](#basic-read) permissions.|
|PasswordHashSync|See [PasswordHashSync](#password-hash-sync) permissions.|
|PasswordWriteBack|See [PasswordWriteBack](#password-writeback) permissions.|
|HybridExchangePermissions|See [HybridExchangePermissions](#exchange-hybrid-deployment) permissions.|
|ExchangeMailPublicFolderPermissions| See [ExchangeMailPublicFolderPermissions](#exchange-mail-public-folders) permissions.|
|UserGroupCreateDelete|See [UserGroupCreateDelete](#usergroupcreatedelete-cloudhr) permissions.|
|All| Applies all the above permissions|


## Next Steps

- [Understand group Managed Service Accounts](/windows-server/security/group-managed-service-accounts/group-managed-service-accounts-overview)
- [How to configure gMSA with PowerShell](how-to-gmsa-cmdlets.md)