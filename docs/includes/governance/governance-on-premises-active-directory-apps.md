---
author: justinha
ms.service: entra-id-governance
ms.topic: include
ms.date: 07/30/2025
ms.author: justinha
# Used by articles entra governance
---

## Prerequisites

The following prerequisites are required to implement this scenario.

- Microsoft Entra account with at least a [Hybrid Identity Administrator](~/identity/role-based-access-control/permissions-reference.md#hybrid-identity-administrator) role.

- On-premises Active Directory Domain Services (AD DS DS) environment with Windows Server 2016 operating system or later.
  - Required for AD DS DS schema attribute - *msDS-ExternalDirectoryObjectId*.

- Provisioning agent with build version [1.1.1367.0](~/identity/hybrid/cloud-sync/reference-version-history.md#1113700) or later.


  > [!NOTE]
  > The permissions to the service account are assigned only during a clean install. If you upgrade from a previous version, assign permissions manually by using PowerShell:
  >
  > ```powershell
  > $credential = Get-Credential
  >
  > Set-AAD DSCloudSyncPermissions -PermissionType UserGroupCreateDelete -TargetDomain "FQDN of domain" -TargetDomainCredential $credential
  > ```
  > Make sure you allow Read, Write, Create, and Delete all properties for all descendant groups and users.
  >
  > These permissions aren't applied to AdminSDHolder objects by default by the [Microsoft Entra provisioning agent gMSA PowerShell cmdlets](~/identity/hybrid/cloud-sync/how-to-gmsa-cmdlets.md#grant-permissions-to-a-specific-domain).


- The provisioning agent must be able to communicate with one or more domain controllers on the port TCP/389 for Lightweight Directory Access Protocol (LDAP) and TCP/3268 for global catalog.
  - Required for global catalog lookup to filter out invalid membership references.

- Microsoft Entra Connect with build version [2.2.8.0](~/identity/hybrid/connect/reference-connect-version-history.md#2280) or later.
  - Required to support on-premises user membership synchronized using Microsoft Entra Connect.
  - Required to synchronize `AD DS:user:objectGUID` to `Microsoft Entra ID:user:onPremisesObjectIdentifier`.

For more information, see [cloud sync supported groups and scale limits](/entra/identity/hybrid/cloud-sync/how-to-prerequisites?tabs=public-cloud#supported-groups-and-scale-limits).

## Supported groups

For this scenario, only the following groups are supported:

- Only cloud-created or Source of Authority (SOA) converted security groups are supported.
- Assigned or dynamic membership groups.
- Contain on-premises synchronized users or cloud-created security groups.
- On-premises synchronized users that are members of the cloud-created security group can be from the same domain or other domains from the same forest
- The forest must support Universal groups because the cloud-created security group is written back to AD DS DS with [Universal group scope ](/windows-server/identity/ad-ds/manage/understand-security-groups#group-scope)
- No more than 50,000 members
- Each direct child nested group counts as one member in the referencing group

## Considerations when provisioning groups back to AD DS DS

If you provision a group back to AD DS DS after you convert Group SOA, provision it back to its original organizational unit (OU). This practice ensures that Microsoft Entra Cloud Sync recognizes the converted group as the same one already in AD DS DS.

Cloud Sync recognizes the converted group because both groups share the same security identifier (SID). If you provision the group to a different OU, it maintains the same SID, and Microsoft Entra Cloud Sync updates the existing group, but you might experience problems with access control lists. Permissions don't always transfer cleanly across containers and only explicit permissions are provisioned with the group. Inherited permissions from the original OU or Group Policy Object permissions applied to the OU don't get provisioned with the group.

Before you convert the SOA, consider the following recommended steps:

1. Move the groups you plan to convert the SOA for to specific organizational units if possible. If you can't move the groups, set the OU path for each group to the original OU path before you convert SOA of the groups. For more information about how to set the original OU path, see [Preserve and use the original OU for group provisioning](../../identity/hybrid/cloud-sync/how-to-preserve-original-organizational-unit.md).
1. Make the SOA change.
1. When provisioning the groups to AD DS DS, set the attribute mapping as explained in [Preserve and use the original OU for group provisioning](../../identity/hybrid/cloud-sync/how-to-preserve-original-organizational-unit.md).
1. Perform an on-demand provisioning first before enabling provisioning for rest of the groups. 

For more information about how to configure the target location for groups that are provisioned to AD DS, see [Scope filter target container](/entra/identity/hybrid/cloud-sync/how-to-attribute-mapping-entra-to-active-directory#scoping-filter-target-container).

## Govern on-premises AD DS DS based apps using Group SOA

In this scenario, when a group in the AD DS domain is used by an application, you can convert the SOA of the group to Microsoft Entra. Then you can provision the membership changes to the group made in Microsoft Entra, such as through entitlement management or access reviews, back to AD DS DS by using Microsoft Entra Cloud Sync. In this model, you don’t need to change the app or create new groups.

:::image type="content" source="media/governance-on-premises-active-directory-apps/source-of-authority-switch.png" alt-text="Screenshot of a conceptual diagram of the switch to Group Source of Authority.":::

Use the following steps for applications to use the Group SOA option.

### Create an application and convert SOA

1. Using the Microsoft Entra admin center, create an application in Microsoft Entra ID that represents the AD DS based application, and configure the application to require user assignment.
1. Ensure that the AD DS group you plan to convert is already synchronized to Microsoft Entra, and that the membership of the AD DS group is only users and optionally other groups that are also synchronized to Microsoft Entra. If the group or any members of the group aren't represented in Microsoft Entra, you can't convert the SOA of the group.
1. Convert the SOA to your existing synchronized cloud group.
1. After you convert the SOA, use [Group Provisioning to AD DS](/entra/identity/hybrid/cloud-sync/how-to-configure-entra-to-active-directory) to provision subsequent changes to this group back to AD DS. Once group provisioning is enabled, Microsoft Entra Cloud Sync recognizes that a converted group is the same group as the one already in AD DS, because both groups have the same security identifier (SID). Provisioning the converted cloud group to AD DS then updates the existing AD DS group instead of creating a new one.

### Configure Microsoft Entra features to manage the membership of the SOA converted group

1. Create an [access package](/entra/id-governance/entitlement-management-access-package-create). Add the application and the security group from the previous steps as resources in the access package. Configure a direct assignment policy in the access package.
1. In [Entitlement Management](/entra/id-governance/entitlement-management-overview), assign the synced users who need access to the AD DS based app to the access package.
1. Wait for the Microsoft Entra Cloud Sync to complete its next synchronization. Using Active Directory Users and Computers, confirm that the correct users are present as members of the group.
1. In your AD DS domain monitoring, allow only the [gMSA account](/entra/identity/hybrid/cloud-sync/how-to-prerequisites#group-managed-service-accounts) that runs the provisioning agent, [authorization to change the membership](/windows/security/threat-protection/auditing/audit-security-group-management) in the new AD DS group.

For more information, see [Embracing cloud-first posture: Convert Group Source of Authority to the cloud (Preview)](../../identity/hybrid/concept-source-of-authority-overview.md).

## Govern on-premises AD DS with newly provisioned cloud security groups 

In this scenario, you update the application to check for the SID, name, or distinguished name of a new groups created by Cloud Sync group provisioning. This scenario applies to:

- Deployments for new applications being connected to an AD DS domain for the first time.
- New cohorts of users accessing the application.
- For application modernization, to reduce the dependency on existing AD DS groups.

Applications that currently check for membership of the `Domain Admins` group need to be updated to also check for a newly created AD DS group.

Follow the steps in the next sections to configure applications to use new groups.

### Create an application and group

1. Using the Microsoft Entra admin center, create an application in Microsoft Entra ID representing the AD DS-based application and configure the application to require user assignment.
1. Create a new security group in Microsoft Entra ID.
1. Use [Group Provisioning to AD DS](~/identity/hybrid/cloud-sync/how-to-configure-entra-to-active-directory.md) to provision this group to AD DS.
1. Launch Active Directory Users and Computers and wait for the resulting new AD DS group to be created in the AD DS domain. When it's present, record the distinguished name, domain, account name, and SID of the new AD DS group.

### Configure application to use new group

1. If the application uses AD DS via LDAP, configure the application with the distinguished name of the new AD DS group. If the application uses AD DS via Kerberos, configure the application with the SID or the domain and account name of the new AD DS group.
1. Create an [access package](~/id-governance/entitlement-management-access-package-create.md). Add the application and the security group from the previous steps as resources in the access package. Configure a direct assignment policy in the access package.
1. In [Entitlement Management](~/id-governance/entitlement-management-overview.md), assign the synced users who need access to the AD DS based app to the access package.
1. Wait for the new AD DS group to be updated with the new members. Using Active Directory Users and Computers, confirm that the correct users are present as members of the group.
1. In your AD DS domain monitoring, allow only the [gMSA account](~/identity/hybrid/cloud-sync/how-to-prerequisites.md#group-managed-service-accounts) that runs the provisioning agent [authorization to change the membership](/windows/security/threat-protection/auditing/audit-security-group-management) in the new AD DS group.

You can now govern access to the AD DS application through this new access package.

## Configure the existing groups option

In this scenario option, you add a new AD DS security group as a nested group member of an existing group. This scenario is applicable to deployments for applications that have a hardcoded dependency on a particular group account name, SID, or distinguished name.

Nesting that group into the application's existing AD DS group allows:

- Microsoft Entra users who are assigned by a governance feature and who then access the app to have the appropriate Kerberos ticket. This ticket contains the existing group's SID. The nesting is allowed by AD DS group nesting rules.

If the app uses LDAP and follows nested group membership, the app sees that the Microsoft Entra users have the existing group as one of their memberships.

### Determine eligibility of existing group

1. Launch Active Directory Users and Computers and record the distinguished name, type, and scope of the existing AD DS group used by the application.
1. If the existing group is `Domain Admins`, `Domain Guests`, `Domain Users`, `Enterprise Admins`, `Enterprise Key Admins`, `Group Policy Creation Owners`, `Key Admins`, `Protected Users`, or `Schema Admins`, then you need to change the application to use a new group as described above, as these groups can't be used by cloud sync.
1. If the group has Global scope, change the group to have Universal scope. A global group can't have universal groups as members.

### Create application and group

1. In the Microsoft Entra admin center, create an application in Microsoft Entra ID representing the AD DS-based application and configure the application to require user assignment.
1. Create a new security group in Microsoft Entra ID.
1. Use [Group Provisioning to AD DS](~/identity/hybrid/cloud-sync/how-to-configure-entra-to-active-directory.md) to provision this group to AD DS.
1. Launch Active Directory Users and Computers and wait for the resulting new AD DS group to be created in the AD DS domain. When it's present, record the distinguished name, domain, account name, and SID of the new AD DS group.

### Configure application to use new group

1. Using Active Directory Users and Computers, add the new AD DS group as a member of the existing AD DS group.
1. Create an [access package](~/id-governance/entitlement-management-access-package-create.md). Add the application from step #1 and the security group from step #3 as described in the **Create application and group** section above as resources in the Access Package. Configure a direct assignment policy in the access package.
1. In [Entitlement Management](~/id-governance/entitlement-management-overview.md), assign the synced users who need access to the AD DS based app to the access package including any user members of the existing AD DS group who still need access.
1. Wait for the new AD DS group to be updated with the new members. Using Active Directory Users and Computers, confirm that the correct users are present as members of the group.
1. Using Active Directory Users and Computers, remove the existing members, apart from the new AD DS group, from the existing AD DS group.
1. In your AD DS domain monitoring, allow only the [gMSA account](~/identity/hybrid/cloud-sync/how-to-prerequisites.md#group-managed-service-accounts) that runs the provisioning agent [authorization to change the membership](/windows/security/threat-protection/auditing/audit-security-group-management) in the new AD DS group.

Then you can govern access to the AD DS application by using the new access package.

## Troubleshoot app access

A user in the new AD DS group who signs in to a domain-joined device might have a ticket from a domain controller that doesn't include the new AD DS group membership. The ticket might be issued before Cloud Sync provisioned the user to the new AD DS group. The user can't use the ticket for access to the application. They must wait for the ticket to expire, and for a new ticket to be issued. Or they must purge their tickets, sign out, and then sign back into the domain. For more information, see [klist](/windows-server/administration/windows-commands/klist).

<a name='existing-azure-ad-connect-group-writeback-v2-customers'></a>

## Existing Microsoft Entra Connect group writeback v2 customers

If you use Microsoft Entra Connect group writeback v2, you need to move to Cloud Sync provisioning to AD DS before you can take advantage of Cloud Sync group provisioning. For more information, see [Migrate Microsoft Entra Connect Sync group writeback V2 to Microsoft Entra Cloud Sync](~/identity/hybrid/cloud-sync/migrate-group-writeback.md).

