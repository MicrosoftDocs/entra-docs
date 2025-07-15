---
author: justinha
ms.service: entra-id-governance
ms.topic: include
ms.date: 06/09/2025
ms.author: justinha
# Used by articles entra governance
---

## Prerequisites

The following prerequisites are required to implement this scenario.

- Microsoft Entra account with at least a [Hybrid Identity Administrator](~/identity/role-based-access-control/permissions-reference.md#hybrid-identity-administrator) role.

- On-premises Active Directory Domain Services environment with Windows Server 2016 operating system or later.
  - Required for AD Schema attribute - msDS-ExternalDirectoryObjectId.

- Provisioning agent with build version [1.1.1367.0](~/identity/hybrid/cloud-sync/reference-version-history.md#1113700) or later.

  > [!NOTE]
  > The permissions to the service account are assigned during clean install only. If you're upgrading from a previous version, then you need to assign permissions manually by using PowerShell:
  >
  > ```powershell
  > $credential = Get-Credential
  >
  > Set-AADCloudSyncPermissions -PermissionType UserGroupCreateDelete -TargetDomain "FQDN of domain" -TargetDomainCredential $credential
  > ```
  > Make you sure you allow Read, Write, Create, and Delete all properties for all descendent Groups and User objects.
  >
  > These permissions aren't applied to AdminSDHolder objects by default by the [Microsoft Entra provisioning agent gMSA PowerShell cmdlets](~/identity/hybrid/cloud-sync/how-to-gmsa-cmdlets.md#grant-permissions-to-a-specific-domain).

- The provisioning agent must be able to communicate with one or more domain controllers on ports TCP/389 (LDAP) and TCP/3268 (Global Catalog).
  - Required for global catalog lookup to filter out invalid membership references.

- Microsoft Entra Connect with build version [2.2.8.0](~/identity/hybrid/connect/reference-connect-version-history.md#2280) or later.
  - Required to support on-premises user membership synchronized using Microsoft Entra Connect.
  - Required to synchronize AD:user:objectGUID to Microsoft Entra ID:user:onPremisesObjectIdentifier.

For more information, see [cloud sync supported groups and scale limits](/entra/identity/hybrid/cloud-sync/how-to-prerequisites?tabs=public-cloud#supported-groups-and-scale-limits).

## Supported groups

For this scenario, only the following groups are supported:

- Only cloud-created [Security groups](~/fundamentals/concept-learn-about-groups.md#group-types) are supported.
- Assigned or dynamic membership groups.
- Contain on-premises synchronized users or cloud-created security groups.
- On-premises synchronized users that are members of the cloud-created security group can be from the same domain or other domains from the same forest
- The forest must support universal groups because the cloud-created security group is written back to AD with [universal group scope ](/windows-server/identity/ad-ds/manage/understand-security-groups#group-scope)
- No more than 50,000 members
- Each direct child nested group counts as one member in the referencing group

## Considerations when provisioning groups back to AD

When you make the SOA switch, if you are going to provision groups back to Active Directory (AD), it's important to provision those groups back to the same Organizational Unit (OU) in AD where they were originally located. This ensures that Microsoft Entra Cloud Sync recognizes the transferred group as the same one already in AD.

This recognition is possible because both groups share the same security identifier (SID). If the group is provisioned to a different OU, it will maintain the same SID, and Microsoft Entra Cloud Sync will update the existing group, but you may experience Access Control List (ACL) issues. The reason for this, is because AD permissions don't always travel cleanly across containers and only explicit permissions will follow the group. Inherited permissions from the old OU or Group Policy Object permissions applied to the OU will not.

Before making the SOA switch, consider the following recommended steps:

1. Move all the groups you plan to change the SOA for to a specific OU or OUs if possible. If this isn't possible, set the OU path for each group to the original OU path before you switch SOA of the groups. For more information about how to set the original OU path, see Preserve and use the original OU for group provisioning.
1. Make the SOA change.
1. When provisioning the groups to AD, set the attribute mapping as explained in Preserve and use the original OU for group provisioning.
1. Perform an on-demand provisioning first before enabling provisioning for rest of the groups. 

For more information on configuring the target location for group that are provisioned to Active Directory, see [Scope filter target container](/entra/identity/hybrid/cloud-sync/how-to-attribute-mapping-entra-to-active-directory#scoping-filter-target-container).


## Govern on-prem AD based apps using Group SOA

In this scenario option, when you have a group already present in AD used by the application, you can use the new capability **Group Source of Authority (SOA) switch** to change the Source of Authority of the group to Microsoft Entra. The, you can configure to provision the membership changes to the group made in Microsoft Entra, such as through entitlement management or access reviews, back to AD using Group Provision to AD. In this model, you don’t need to change the app or create new groups.

:::image type="content" source="media/governance-on-premises-active-directory-apps/source-of-authority-switch.png" alt-text="Screenshot of a conceptual diagram of the switch to Group Source of Authority.":::

Use the following steps for applications to use the Group Source of Authority option.

### Create an application and transfer source of authority

1. Using the Microsoft Entra admin center, create an application in Microsoft Entra ID representing the AD-based application, and configure the application to require user assignment.
1. Ensure that the AD group you plan to convert is already synchronized to Microsoft Entra, and that the membership of the AD group is only users and optionally other groups which are themselves also synchronized to Microsoft Entra. If the group or any members of the group are not represented in Microsoft Entra, you will not be able to transfer the source of authority of the group.
1. Transfer the source of authority to your existing synchronized cloud group.
1. Once the source of authority has been transferred, use [Group Provisioning to AD](/entra/identity/hybrid/cloud-sync/how-to-configure-entra-to-active-directory) to provision subsequent changes to this group back to AD. Once group provisioning is enabled, Microsoft Entra Cloud Sync will recognize that a transferred group is the same group as the one already in AD, because both groups have the same security identifier (SID). Provisioning the transferred cloud group to AD will then update the existing AD group instead of creating a new one.

### Configure Microsoft Entra features to manage the membership of the transferred group

1. Create an [access package](/entra/id-governance/entitlement-management-access-package-create). Add the application and the security group from the previous steps as resources in the access package. Configure a direct assignment policy in the access package.
1. In [Entitlement Management](/entra/id-governance/entitlement-management-overview), assign the synced users who need access to the AD based app to the access package.
1. Wait for the Microsoft Entra Cloud Sync to complete its next synchronization. Using Active Directory Users and Computers, confirm that the correct users are present as members of the group.
1. In your AD domain monitoring, allow only the [gMSA account](/entra/identity/hybrid/cloud-sync/how-to-prerequisites#group-managed-service-accounts) that runs the provisioning agent, [authorization to change the membership](/windows/security/threat-protection/auditing/audit-security-group-management) in the new AD group.

For more information, see Embracing cloud-first posture: Transitioning AD Group Source of Authority to the cloud.

## Govern on-prem AD with new cloud security groups provisioned to AD

In this scenario option, you update the application to check for the SID, name, or distinguished name of new groups created by cloud sync group provisioning. This scenario is applicable to:

- Deployments for new applications being connected to AD DS for the first time.
- New cohorts of users accessing the application.
- For application modernization, to reduce the dependency on existing AD DS groups.

Applications which currently check for membership of the `Domain Admins` group need to be updated to also check for a newly created AD group.

Use the following steps for applications to use new groups.

### Create an application and group

1. Using the Microsoft Entra admin center, create an application in Microsoft Entra ID representing the AD-based application and configure the application to require user assignment.
1. Create a new security group in Microsoft Entra ID.
1. Use [Group Provisioning to AD](~/identity/hybrid/cloud-sync/how-to-configure-entra-to-active-directory.md) to provision this group to AD.
1. Launch Active Directory Users and Computers and wait for the resulting new AD group to be created in the AD domain. When it's present, record the distinguished name, domain, account name, and SID of the new AD group.

### Configure application to use new group

1. If the application uses AD via LDAP, configure the application with the distinguished name of the new AD group. If the application uses AD via Kerberos, configure the application with the SID or the domain and account name of the new AD group.
1. Create an [access package](~/id-governance/entitlement-management-access-package-create.md). Add the application and the security group from the previous steps as resources in the access package. Configure a direct assignment policy in the access package.
1. In [Entitlement Management](~/id-governance/entitlement-management-overview.md), assign the synced users who need access to the AD based app to the access package.
1. Wait for the new AD group to be updated with the new members. Using Active Directory Users and Computers, confirm that the correct users are present as members of the group.
1. In your AD domain monitoring, allow only the [gMSA account](~/identity/hybrid/cloud-sync/how-to-prerequisites.md#group-managed-service-accounts) that runs the provisioning agent [authorization to change the membership](/windows/security/threat-protection/auditing/audit-security-group-management) in the new AD group.

You can now govern access to the AD application through this new access package.

## Configuring the existing groups option

In this scenario option, you add a new AD security group as a nested group member of an existing group. This scenario is applicable to deployments for applications that have a hardcoded dependency on a particular group account name, SID, or distinguished name.

Nesting that group into the application's existing AD group will allow:

- Microsoft Entra users who are assigned by a governance feature and who then access the app to have the appropriate Kerberos ticket. This ticket contains the existing group's SID. The nesting is allowed by AD group nesting rules.

If the app uses LDAP and follows nested group membership, the app will see the Microsoft Entra users as having the existing group as one of their memberships.

### Determine eligibility of existing group

1. Launch Active Directory Users and Computers and record the distinguished name, type, and scope of the existing AD group used by the application.
1. If the existing group is `Domain Admins`, `Domain Guests`, `Domain Users`, `Enterprise Admins`, `Enterprise Key Admins`, `Group Policy Creation Owners`, `Key Admins`, `Protected Users`, or `Schema Admins`, then you'll need to change the application to use a new group as described above, as these groups can't be used by cloud sync.
1. If the group has Global scope, change the group to have Universal scope. A global group can't have universal groups as members.

### Create application and group

1. In the Microsoft Entra admin center, create an application in Microsoft Entra ID representing the AD-based application and configure the application to require user assignment.
1. Create a new security group in Microsoft Entra ID.
1. Use [Group Provisioning to AD](~/identity/hybrid/cloud-sync/how-to-configure-entra-to-active-directory.md) to provision this group to AD.
1. Launch Active Directory Users and Computers and wait for the resulting new AD group to be created in the AD domain. When it's present, record the distinguished name, domain, account name, and SID of the new AD group.

### Configure application to use new group

1. Using Active Directory Users and Computers, add the new AD group as a member of the existing AD group.
1. Create an [access package](~/id-governance/entitlement-management-access-package-create.md). Add the application from step #1 and the security group from step #3 as described in the **Create application and group** section above as resources in the Access Package. Configure a direct assignment policy in the access package.
1. In [Entitlement Management](~/id-governance/entitlement-management-overview.md), assign the synced users who need access to the AD based app to the access package including any user members of the existing AD group who still need access.
1. Wait for the new AD group to be updated with the new members. Using Active Directory Users and Computers, confirm that the correct users are present as members of the group.
1. Using Active Directory Users and Computers, remove the existing members, apart from the new AD group, from the existing AD group.
1. In your AD domain monitoring, allow only the [gMSA account](~/identity/hybrid/cloud-sync/how-to-prerequisites.md#group-managed-service-accounts) that runs the provisioning agent [authorization to change the membership](/windows/security/threat-protection/auditing/audit-security-group-management) in the new AD group.

You'll then be able to govern access to the AD application through this new access package.

## Troubleshooting

A user who is a member of the new AD group and is on a Windows PC already logged into an AD domain might have an existing ticket issued by an AD domain controller that doesn't include the new AD group membership. This is because the ticket might have been issued prior to the cloud sync group provisioning adding them to the new AD group. The user won't be able to present the ticket for access to the application, and so must wait for the ticket to expire and for a new ticket to be issued, or must purge their tickets, log out and then log back into the domain. See the [klist](/windows-server/administration/windows-commands/klist) command for more details.

<a name='existing-azure-ad-connect-group-writeback-v2-customers'></a>

## Existing Microsoft Entra Connect group writeback v2 customers

If you're using Microsoft Entra Connect group writeback v2, you'll need to move to cloud sync provisioning to AD before you can take advantage of cloud sync group provisioning. See [Migrate Microsoft Entra Connect Sync group writeback V2 to Microsoft Entra Cloud Sync](~/identity/hybrid/cloud-sync/migrate-group-writeback.md)

