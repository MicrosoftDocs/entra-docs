---
title: 'Govern on-premises Active Directory(Kerberos) application access with groups from the cloud'
description: This article provides an overview of how to use cloud sync to govern on-premises application access using groups.
documentationcenter: ''
author: billmath
manager: amycolannino
ms.service: active-directory
ms.topic: conceptual
ms.workload: identity
ms.date: 10/24/2023
ms.subservice: hybrid
ms.author: billmath
---

# Govern on-premises Active Directory based apps (Kerberos) using Microsoft Entra ID Governance

**Scenario:**  Manage on-premises applications with Active Directory groups that are provisioned from and managed in the cloud.  Microsoft Entra cloud sync, allows you to fully govern application assignments in AD while taking advantage of Microsoft Entra ID Governance features to control and remediate any access related requests.

With the release of provisioning agent [1.1.1367.0](reference-version-history.md#1113670), cloud sync now has the ability to provision groups directly to your on-premises Active Directory environment. 

 :::image type="content" source="media/govern-on-premises-groups/on-premises-group-writeback.png" alt-text="Conceptual drawing of Microsoft Entra Cloud Sync's Group Provision to AD." lightbox="media/govern-on-premises-groups/on-premises-group-writeback.png":::

## Prerequisites
The following prerequisites are required to implement this scenario.

 - Azure AD account with at least a [Hybrid Administrator](../../roles/permissions-reference.md#hybrid-identity-administrator) role.
 - On-premises Active Directory Domain Services environment with Windows Server 2016 operating system or later. 
     - Required for AD Schema attribute  - msDS-ExternalDirectoryObjectId 
 - Provisioning agent with build version [1.1.1367.0](reference-version-history.md#1113670) or later.

 > [!NOTE]
 > The permissions to the service account are assigned during clean install only. In case you're upgrading from the previous version then permissions need to be assigned manually using PowerShell cmdlet: 
 > 
 > ```
 > $credential = Get-Credential  
 >
 >   Set-AADCloudSyncPermissions -PermissionType UserGroupCreateDelete -TargetDomain "FQDN of domain" -TargetDomainCredential $credential
 >```
 >If the permissions are set manually, you need to ensure that Read, Write, Create, and Delete all properties for all descendent Groups and User objects. 
 >
 >These permissions aren't applied to AdminSDHolder objects by default

 [Microsoft Entra Provisioning Agent gMSA PowerShell cmdlets](how-to-gmsa-cmdlets.md#grant-permissions-to-a-specific-domain) 

 - The provisioning agent must be able to communicate with the domain controller(s) on ports TCP/389 (LDAP) and TCP/3268 (Global Catalog).
     - Required for global catalog lookup to filter out invalid membership references
 - Mircorosft Entra Connect with build version [2.2.8.0](../connect/reference-connect-version-history.md#2280) or later
     - Required to support on-premises user membership synchronized using Microsoft Entra Connect 
     - Required to synchronize AD:user:objectGUID to AAD:user:onPremisesObjectIdentifier

## Supported groups
For this scenario, only the following is supported:
  - only cloud created [Security groups](../../fundamentals/concept-learn-about-groups.md#group-types) are supported
  - these groups can have assigned or dynamic membership.
  - these groups can only contain on-premises synchronized users and / or additional cloud created security groups.
  - the on-premises user accounts, that are synchronized and are members of this cloud created security group, can be from the same domain or cross-domain, but they all must be from the same forest.
  - these groups are written back with the AD groups scope of [universal](/windows-server/identity/ad-ds/manage/understand-security-groups#group-scope).  Your on-premises environment must support the universal group scope.
  - groups that are larger than 50,000 members aren't supported.
  - each direct child nested group counts as one member in the referencing group


## Supported scenarios
The following sections discuss the scenarios that are supported with cloud sync group provisioning.

## Configuring supported scenarios

If you wish to control whether a user is able to connect to an AD application that users Windows authentication, then this is possible using the application proxy and an Entra ID security group.

If in addition, an application itself checks a user's AD group memberships, via Kerberos or LDAP, to determine whether the user is authorized in the application, then you can use cloud sync group provisioning to ensure an AD user has those group memberships prior to the user accessing the applications.  

The following sections discuss two scenario options that are supported with cloud sync group provisioning, to ensure users assigned to the application have group memberships when they authenticate to the application.
 - Creating new groups, and updating the application, if it already exists, to check for the new group, or
 - Creating new groups, and updating the existing groups the application was checking for to include the new group as a member

Before you begin, ensure that you're a domain administrator in the domain where the application is installed, and can sign into a domain controller, or have the [Remote Server Administration tools](/troubleshoot/windows-server/system-management-components/remote-server-administration-tools) for Active Directory Domain Services (AD DS) administration installed on your Windows PC.


### Configuring the new groups option

In this scenario option, you'll update the application to check for the SID, name or distinguished name of new groups created by cloud sync group provisioning.  This scenario is applicable to deployments for new applications being connected to AD DS for the first time, new cohorts of users accessing the application, or for application modernization, to reduce the dependency on existing AD DS groups.  Applications which currently check for membership of the `Domain Admins` group will need to be updated to also check for a newly-created AD group as well.

Use the following steps for applications to use new groups.

### Create application and group
 1.  Using the Entra Portal, create an application in Entra ID representing the AD-based application, and configure the application to require user assignment.
 2.  If application proxy will be used to enable users to connect to the application, then configure the application proxy.
 3.	Create a new security group in Entra ID.
 4.	Use [Group Provisioning to AD](how-to-configure-entra-to-ad.md) to provision this group to AD.  
 5.  Launch Active Directory Users and Computers, and wait for the resulting new AD group to be created in the AD domain.  When it's present, record the distinguished name, domain, account name and SID of the new AD group.

 ### Configure application to use new group
 1.  If the application uses AD via LDAP, configure the application with the distinguished name of the new AD group.  If the application users AD via Kerberos, configure the application with the SID, or the domain and account name, of the new AD group.
 2.	Create an [access package](../../governance/entitlement-management-access-package-create.md).  Add the application from #1, the security group from #3, as resources in the Access Package.  Configure a direct assignment policy in the access package.
 3.	In [Entitlement Management](../../governance/entitlement-management-overview.md), assign the synced users who need access to the AD based app to the access package.
 4.  Wait for the new AD group to be updated with thew new members.  Using Active Directory Users and Computers, confirm that the correct users are present as members of the group.
 5.  In your AD domain monitoring, allow only the [gMSA account](\how-to-prerequisites.md#group-managed-service-accounts) that runs the provisioning agent, [authorization to change the membership](/windows/security/threat-protection/auditing/audit-security-group-management) in the new AD group.

You'll then be able to govern access to the AD application through this new access package.

### Configuring the existing groups option

In this scenario option, you'll add a new AD security group as a nested group member of an existing group.  This scenario is applicable to deployments for applications that have a hardcoded dependency on a particular group account name, SID, or distinguished name.

Nesting that group into the applications’ existing AD group will allow Entra ID users who are assigned by a governance feature and subsequently  access the app to have an appropriate Kerberos ticket containing the existing group’s SID, as allowed by AD group nesting rules.  If the app uses LDAP and follows nested group membership, the app will see the Entra ID users as having the existing group as one of their memberships.

### Determine eligibility of existing group
 1.  Launch Active Directory Users and Computers, and record the distinguished name, type and scope of the existing AD group used by the application.  
 2.  If the existing group is `Domain Admins`, `Domain Guests`, `Domain Users`, `Enterprise Admins`, `Enterprise Key Admins`, `Group Policy Creation Owners`, `Key Admins`, `Protected Users` or `Schema Admins`, then you'll need to change the application to use a new group, as described above, as these groups can't be used by cloud sync.
 3.  If the group has Global scope, change the group to have Universal scope.  A global group can't have universal groups as members.

### Create application and group
 1.  Using the Entra Portal, create an application in Entra ID representing the AD-based application, and configure the application to require user assignment.
 2.  If application proxy will be used to enable users to connect to the application, then configure the application proxy.
 3.	Create a new security group in Entra ID.
 4.	Use [Group Provisioning to AD](how-to-configure-entra-to-ad.md) to provision this group to AD.  
 5.  Launch Active Directory Users and Computers, and wait for the resulting new AD group to be created in the AD domain, When it's present, record the distinguished name, domain, account name and SID of the new AD group.

### Configure application to use new group
 1.  Using Active Directory Users and Computers, add the new AD group as a member of the existing AD group.
 2.	Create an [access package](../../governance/entitlement-management-access-package-create.md).  Add the application from #1, the security group from #3, as resources in the Access Package.  Configure a direct assignment policy in the access package.
 3.	In [Entitlement Management](../../governance/entitlement-management-overview.md), assign the synced users who need access to the AD based app to the access package.  This includes any user members of the existing AD group who will continue to need access.
 4. Wait for the new AD group to be updated with thew new members.  Using Active Directory Users and Computers, confirm that the correct users are present as members of the group.
 5. Using Active Directory Users and Computers, remove the existing members, apart from the new AD group, of the existing AD group.
 6. In your AD domain monitoring, allow only the [gMSA account](\how-to-prerequisites.md#group-managed-service-accounts) that runs the provisioning agent, [authorization to change the membership](/windows/security/threat-protection/auditing/audit-security-group-management) in the new AD group.


You'll then be able to govern access to the AD application through this new access package.


## Troubleshooting

A user who is a member of the new AD group, and is on a Windows PC already logged into an AD domain, may have an existing ticket issued by an AD domain controller that doesn't include the new AD group membership.  This is because the ticket may have been issued prior to the cloud sync group provisioning adding them to the new AD group.  The user won't be able to present the ticket for access to the application, and so must wait for the ticket to expire and a new ticket issued, or purge their tickets, log out and log back into the domain.  See the [klist](/windows-server/administration/windows-commands/klist) command for more details.

## Existing Azure AD Connect group writeback v2 customers
If you're using Azure AD Connect group writeback v2, you'll need to move to cloud sync provisioning to AD before you can take advantage of cloud sync group provisioning.


## Next Steps
- [What is Entra ID Governance?](../../governance/identity-governance-overview.md)
- [What is provisioning?](../what-is-provisioning.md)
- [What is Microsoft Entra Cloud Sync?](what-is-cloud-sync.md)