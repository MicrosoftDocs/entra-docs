---
title: 'Use a group managed service account with Microsoft Entra Cloud Sync '
description: This document details using a gMSA account with cloud sync
author: billmath
manager: amycolannino
ms.service: entra-id
ms.topic: how-to
ms.date: 05/28/2024
ms.subservice: hybrid-connect
ms.author: billmath
---




# Group Managed Service Accounts

A group Managed Service Account is a managed domain account that provides automatic password management, simplified service principal name (SPN) management, the ability to delegate the management to other administrators, and also extends this functionality over multiple servers. Microsoft Entra Cloud Sync supports and uses a gMSA for running the agent. You can choose to allow the installer to create a new account or specify a custom account.  You'll be prompted for administrative credentials during setup, in order to create this account or set permissions if using a custom account. If the installer creates the account, the account appears as `domain\provAgentgMSA$`. For more information on a gMSA, see [group Managed Service Accounts](/windows-server/security/group-managed-service-accounts/group-managed-service-accounts-overview).

## Prerequisites for gMSA

- The Active Directory schema in the gMSA domain's forest needs to be updated to Windows Server 2012 or later.
- [PowerShell RSAT modules](/windows-server/remote/remote-server-administration-tools) on a domain controller.
- At least one domain controller in the domain must be running Windows Server 2012 or later.
- A domain joined server where the agent is being installed needs to be either Windows Server 2016 or later.


## Permissions set on a gMSA account (ALL permissions)
When the installer creates the gMSA account, it sets **ALL** of the permissions on the account.  The following tables detail these permissions


### MS-DS-Consistency-Guid

|Type |Name |Access |Applies To|
|-----|-----|-----|-----| 
|Allow|&lt;gmsa account&gt;|Write property mS-DS-ConsistencyGuid|Descendant user objects|
|Allow|&lt;gmsa account&gt;|Write property mS-DS-ConsistencyGuid|Descendant group objects|

If the associated forest is hosted in a Windows Server 2016 environment, it includes the following permissions for NGC keys and STK keys.

|Type |Name |Access |Applies To|
|-----|-----|-----|-----| 
|Allow|&lt;gmsa account&gt;|Write property msDS-KeyCredentialLink|Descendant user objects|
|Allow|&lt;gmsa account&gt;|Write property msDS-KeyCredentialLink|Descendant device objects|

### Password Hash Sync

|Type |Name |Access |Applies To|
|-----|-----|-----|-----| 
|Allow |&lt;gmsa account&gt;|Replicating Directory Changes |This object only (Domain root)| 
|Allow |&lt;gmsa account&gt;|Replicating Directory Changes All |This object only (Domain root)| 
  
### Password Writeback 

|Type |Name |Access |Applies To|
|-----|-----|-----|-----| 
|Allow |&lt;gmsa account&gt;|Reset Password |Descendant User objects| 
|Allow |&lt;gmsa account&gt;|Write property lockoutTime |Descendant User objects| 
|Allow |&lt;gmsa account&gt;|Write property pwdLastSet |Descendant User objects| 
|Allow |&lt;gmsa account&gt;|Unexpire Password|This object only (Domain root)| 

### Group Writeback 

|Type |Name |Access |Applies To|
|-----|-----|-----|-----| 
|Allow |&lt;gmsa account&gt;|Generic Read/Write |All attributes of object type group and subobjects| 
|Allow |&lt;gmsa account&gt;|Create/Delete child object |All attributes of object type group and subobjects| 
|Allow |&lt;gmsa account&gt;|Delete/Delete tree objects|All attributes of object type group and subobjects|

### Exchange Hybrid Deployment 

|Type |Name |Access |Applies To|
|-----|-----|-----|-----| 
|Allow |&lt;gmsa account&gt;|Read/Write all properties |Descendant User objects| 
|Allow |&lt;gmsa account&gt;|Read/Write all properties |Descendant InetOrgPerson objects| 
|Allow |&lt;gmsa account&gt;|Read/Write all properties |Descendant Group objects| 
|Allow |&lt;gmsa account&gt;|Read/Write all properties |Descendant Contact objects| 

### Exchange Mail Public Folders

|Type |Name |Access |Applies To|
|-----|-----|-----|-----| 
|Allow |&lt;gmsa account&gt;|Read all properties |Descendant PublicFolder objects| 

### UserGroupCreateDelete (CloudHR)

|Type |Name |Access |Applies To|
|-----|-----|-----|-----| 
|Allow |&lt;gmsa account&gt;|Generic write |All attributes of object type group and subobjects| 
|Allow |&lt;gmsa account&gt;|Create/Delete child object|All attributes of object type group and subobjects| 
|Allow |&lt;gmsa account&gt;|Generic write |All attributes of object type user and subobjects| 
|Allow |&lt;gmsa account&gt;|Create/Delete child object|All attributes of object type user and subobjects| 

## Using a custom gMSA account

If you're creating a custom gMSA account, the installer will set the **ALL** permissions on the custom account.

For steps on how to upgrade an existing agent to use a gMSA account see [group Managed Service Accounts](how-to-install.md#group-managed-service-accounts).

For more information on how to prepare your Active Directory for group Managed Service Account, see [group Managed Service Accounts Overview](/windows-server/security/group-managed-service-accounts/group-managed-service-accounts-overview).

## Troubleshooting

If you encounter the problem
```Error while creating group managed service account (gMSA). Error: Unable to install service account pGMSA_<hex-string>$ after 6 retries.'```
this might be related to a mismatch of the encryption types of the gMSA and the computer account.

Open the attribute editor of your computer account and the newly created gMSA and check that the attribute `msDS-SupportedEncryptionTypes` matches.
If they don't match, replace the value of `msDS-SupportedEncryptionTypes` for the gMSA with the value from the server computer account. 


## Next steps

- [Understand group Managed Service Accounts](/windows-server/security/group-managed-service-accounts/group-managed-service-accounts-overview)
- [How to configure gMSA with PowerShell](how-to-gmsa-cmdlets.md)