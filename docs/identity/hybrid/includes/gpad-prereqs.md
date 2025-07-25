---
title: Include file
description: Include file
author: omondiatieno
ms.service: entra-id
ms.topic: Include
ms.date: 09/20/2024
ms.author: jomondi
ms.custom: Include file
---


## Provision Microsoft Entra ID to Active Directory - Prerequisites
The following prerequisites are required to implement provisioning groups to Active Directory.

## License requirements
[!INCLUDE [entra-p1-license.md](~/includes/entra-p1-license.md)]

## General requirements

 - Microsoft Entra account with at least a [Hybrid Identity Administrator](../../role-based-access-control/permissions-reference.md#hybrid-identity-administrator) role.
 - On-premises Active Directory Domain Services environment with Windows Server 2016 operating system or later. 
     - Required for AD Schema attribute  - msDS-ExternalDirectoryObjectId 
 - Provisioning agent with build version [1.1.1586.0](../cloud-sync/reference-version-history#1115860).

 > [!NOTE]
 > The permissions to the service account are assigned during clean install only. In case you're upgrading from the previous version then permissions need to be assigned manually using PowerShell cmdlet: 
 > 
 > ```
 > $credential = Get-Credential  
 >
 >   Set-AADCloudSyncPermissions -PermissionType UserGroupCreateDelete -TargetDomain "FQDN of domain" -EACredential $credential
 >```
 >If the permissions are set manually, you need to ensure that Read, Write, Create, and Delete all properties for all descendent Groups and User objects. 
 >
 >These permissions aren't applied to AdminSDHolder objects by default
 [Microsoft Entra provisioning agent gMSA PowerShell cmdlets](../cloud-sync/how-to-gmsa-cmdlets.md#grant-permissions-to-a-specific-domain) 

 - The provisioning agent must be able to communicate with one or more domain controllers on ports TCP/389 (LDAP) and TCP/3268 (Global Catalog).
     - Required for global catalog lookup to filter out invalid membership references
 - Microsoft Entra Connect Sync with build version [2.22.8.0](../connect/reference-connect-version-history#2280)
     - Required to support on-premises user membership synchronized using Microsoft Entra Connect Sync
     - Required to synchronize AD:user:objectGUID to AAD:user:onPremisesObjectIdentifier

### Supported groups and scale limits
The following is supported:
  - Only cloud created [Security groups](../../../fundamentals/concept-learn-about-groups.md#group-types) are supported
  - These groups can have assigned or dynamic membership groups.
  - These groups can only contain on-premises synchronized users and / or additional cloud created security groups.
  - The on-premises user accounts that are synchronized and are members of this cloud created security group, can be from the same domain or cross-domain, but they all must be from the same forest.
  - These groups are written back with the AD groups scope of [universal](/windows-server/identity/ad-ds/manage/understand-security-groups#group-scope). Your on-premises environment must support the universal group scope.
  - Groups that are larger than 50,000 members aren't supported.
  - Tenants that have more than 150,000 objects aren't supported. Meaning, if a tenant has any combination of users and groups that exceeds 150K objects, the tenant isn't supported.
  - Each direct child nested group counts as one member in the referencing group
  - Reconciliation of groups between Microsoft Entra ID and Active Directory isn't supported if the group is manually updated in Active Directory.

### Additional information
  The following is additional information on provisioning groups to Active Directory.

- Groups provisioned to AD using cloud sync can only contain on-premises synchronized users and / or additional cloud created security groups.
- These users must have the onPremisesObjectIdentifier attribute set on their account.
- The onPremisesObjectIdentifier must match a corresponding objectGUID in the target AD environment.
- An on-premises users objectGUID attribute to a cloud users onPremisesObjectIdentifier attribute can be synchronized using either Microsoft Entra Cloud Sync ([1.1.1370.0](../cloud-sync/reference-version-history.md#1113700)) or Microsoft Entra Connect Sync ([2.2.8.0](../connect/reference-connect-version-history.md#2280))
- If you're using Microsoft Entra Connect Sync ([2.2.8.0](../connect/reference-connect-version-history.md#2280)) to synchronize users, instead of Microsoft Entra Cloud Sync, and want to use Provisioning to AD, it must be [2.2.8.0](../connect/reference-connect-version-history.md#2280) or later.
- Only regular Microsoft Entra ID tenants are supported for provisioning from Microsoft Entra ID to Active Directory.  Tenants such as B2C aren't supported.
- The group provisioning job is scheduled to run every 20 minutes.

