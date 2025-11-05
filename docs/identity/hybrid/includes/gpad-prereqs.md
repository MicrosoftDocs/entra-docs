---
title: Include file
description: Include file
author: omondiatieno
ms.service: entra-id
ms.topic: Include
ms.date: 10/09/2025
ms.author: jomondi
ms.custom: Include file
---


## Provision Microsoft Entra ID to Active Directory Domain Services - Prerequisites
The following prerequisites are required to implement provisioning groups to Active Directory Domain Services (AD DS).

## License requirements
[!INCLUDE [entra-p1-license.md](~/includes/entra-p1-license.md)]

## General requirements

 - Microsoft Entra account with at least a [Hybrid Identity Administrator](../../role-based-access-control/permissions-reference.md#hybrid-identity-administrator) role.
 - On-premises AD DS schema with the *msDS-ExternalDirectoryObjectId* attribute, which is available in Windows Server 2016 and later.  
 - Provisioning agent with build version [1.1.3730.0](../cloud-sync/reference-version-history.md#1113730) or later.

 > [!NOTE]
 > The permissions to the service account are assigned during clean install only. If you're upgrading from the previous version, then permissions need to be assigned manually by using PowerShell: 
 > 
 > ```powershell
 > $credential = Get-Credential  
 >
 > Set-AAD DSCloudSyncPermissions -PermissionType UserGroupCreateDelete -TargetDomain "FQDN of domain" -EACredential $credential
 > ```
 >If the permissions are set manually, you need to assign Read, Write, Create, and Delete all properties for all descendant Groups and User objects. 
 >
 >These permissions aren't applied to AdminSDHolder objects by default. For more information, see [Microsoft Entra provisioning agent gMSA PowerShell cmdlets](../cloud-sync/how-to-gmsa-cmdlets.md#grant-permissions-to-a-specific-domain). 

 - The provisioning agent must be installed on a server that runs Windows Server 2022, Windows Server 2019, or Windows Server 2016.
 - The provisioning agent must be able to communicate with one or more domain controllers on ports TCP/389 (LDAP) and TCP/3268 (Global Catalog).
     - Required for Global Catalog lookup to filter out invalid membership references
 - Microsoft Entra Connect Sync with build version [2.22.8.0](../connect/reference-connect-version-history.md#2280)
     - Required to support on-premises user membership synchronized using Microsoft Entra Connect Sync
     - Required to synchronize `AD DS:user:objectGUID` to `AAD DS:user:onPremisesObjectIdentifier`

### Supported groups and scale limits
The following actions are supported:
  - If you want to provision a converted SOA group to AD DS, make sure you preserve the OU path and set it in the **Group Provision to AD** configuration with the right mapping. For more information, see [Provision groups to Active Directory Domain Services by using Microsoft Entra Cloud Sync](../cloud-sync/tutorial-group-provisioning.md).
  - Only cloud-native or SOA converted (from AD DS to Microsoft Entra ID) [security groups](../../../fundamentals/concept-learn-about-groups.md#group-types) are supported.
  - These groups can have assigned or dynamic membership groups.
  - These groups can only contain on-premises synchronized users or other cloud-created security groups.
  - Synced users can be from any domain in the same forest.
  - These groups are written back with the group scope of [Universal](/windows-server/identity/ad-ds/manage/understand-security-groups#group-scope). Your on-premises environment must support the Universal group scope.
  - Groups that are larger than 50,000 members aren't supported.
  - Tenants that have more than 150,000 objects aren't supported. If any combination of users and groups exceeds 150,000 objects, the tenant isn't supported.
  - Each direct child nested group counts as one member in the referencing group.
  - Reconciliation of groups between Microsoft Entra ID and AD DS isn't supported if the group is manually updated in AD DS.

### More information
Here's more points to consider when you provision groups to AD DS.

- Groups provisioned to AD DS using Cloud Sync can only contain on-premises synchronized users or other cloud-created security groups.
- These users must have the *onPremisesObjectIdentifier* attribute set on their account.
- The *onPremisesObjectIdentifier* must match a corresponding *objectGUID* in the target AD DS environment. 
- An on-premises user *objectGUID* attribute can be synchronized to a cloud user *onPremisesObjectIdentifier* attribute by using either sync client.
- Only global Microsoft Entra ID tenants can provision from Microsoft Entra ID to AD DS. Tenants such as B2C aren't supported.
- The group provisioning job is scheduled to run every 20 minutes.

