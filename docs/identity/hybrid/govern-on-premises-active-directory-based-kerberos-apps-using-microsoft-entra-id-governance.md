**Govern on-premises Active Directory based apps (Kerberos) using
Microsoft Entra ID Governance**

| ***Intro text: The content in this article will be appended to the existing article at <https://learn.microsoft.com/entra/identity/hybrid/cloud-sync/govern-on-premises-groups>*** |
|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|

# Overview

This article outlines the scenarios around governance of on-prem AD
based applications using Entra ID Governance capabilities.

**Scenario(s) covered:** Manage on-premises applications with Active
Directory groups that are provisioned from and managed in the cloud.
Microsoft Entra Cloud Sync allows you to fully govern application
assignments in AD while taking advantage of Microsoft Entra ID
Governance features to control and remediate any access related
requests.

For applications that are non-AD based and governance of such apps,
refer to this article
[here](https://learn.microsoft.com/en-us/entra/id-governance/identity-governance-applications-prepare)

# Supported Scenarios

If you want to control whether a user is able to connect to an Active
Directory application that uses Windows authentication, you can use the
application proxy and a Microsoft Entra security group. If an
application checks a user's AD group memberships, via Kerberos or LDAP,
then you can use cloud sync group provisioning to ensure an AD user has
those group memberships before the user accesses the applications.

The following sections discuss three options that are supported with
cloud sync group provisioning. The scenario options are meant to ensure
users assigned to the application have group memberships when they
authenticate to the application.

- Use [Group Source of Authority to transfer the source of
  authority](https://microsoft.sharepoint.com/teams/APEXIdentityContent/Shared%20Documents/General/Source%20of%20Authority/Private%20Preview%202/Group_SOA_Guidance.docx)
  of groups in Active Directory, that are synchronized using Microsoft
  Entra Connect Sync or Microsoft Entra Cloud Sync, to Microsoft Entra
  ID.

- Create a new group and update the application, if it already exists,
  to check for the new group

- Create a new group and update the existing groups, the application was
  checked for, to include the new group as a member

Before you begin, ensure that you're a domain administrator in the
domain where the application is installed. Ensure you can sign into a
domain controller, or have the [<u>Remote Server Administration
tools</u>](https://review.learn.microsoft.com/en-us/troubleshoot/windows-server/system-management-components/remote-server-administration-tools) for
Active Directory Domain Services (AD DS) administration installed on
your Windows PC.

Microsoft Entra ID has an application proxy service that enables users
to access on-premises applications by signing in with their Microsoft
Entra account. For information on configuring app proxy, see [Add an
on-premises application for remote access through application proxy in
Microsoft Entra ID. - Microsoft Entra ID \| Microsoft
Learn.](https://learn.microsoft.com/en-us/entra/identity/app-proxy/application-proxy-add-on-premises-application)

**Prerequisites**

The following prerequisites are required to implement this scenario.

- Microsoft Entra account with at least a [<u>Hybrid Identity
  Administrator</u>](https://review.learn.microsoft.com/en-us/entra/identity/role-based-access-control/permissions-reference#hybrid-identity-administrator) role.

- On-premises Active Directory Domain Services environment with Windows
  Server 2016 operating system or later.

  - Required for AD Schema attribute - msDS-ExternalDirectoryObjectId.

- Provisioning agent with build
  version [<u>1.1.1367.0</u>](https://review.learn.microsoft.com/en-us/entra/identity/hybrid/cloud-sync/reference-version-history#1113700) or
  later.

- Groups that are larger than 50,000 members aren't supported.

- Tenants that have more than 150,000 objects aren't supported. Meaning,
  if a tenant has any combination of users and groups that exceeds 150K
  objects, the tenant isn't supported

<table>
<colgroup>
<col style="width: 100%" />
</colgroup>
<thead>
<tr class="header">
<th><p><strong> Note:</strong></p>
<p>The permissions to the service account are assigned during clean
install only. In case you're upgrading from the previous version then
permissions need to be assigned manually using PowerShell cmdlet:</p>
<p>Copy</p>
<p>$credential = Get-Credential</p>
<p>Set-AADCloudSyncPermissions -PermissionType UserGroupCreateDelete
-TargetDomain "FQDN of domain" -TargetDomainCredential $credential</p>
<p>If the permissions are set manually, you need to ensure that Read,
Write, Create, and Delete all properties for all descendent Groups and
User objects.</p>
<p>These permissions aren't applied to AdminSDHolder objects by
default</p></th>
</tr>
</thead>
<tbody>
</tbody>
</table>

[<u>Microsoft Entra provisioning agent gMSA PowerShell
cmdlets</u>](https://review.learn.microsoft.com/en-us/entra/identity/hybrid/cloud-sync/how-to-gmsa-cmdlets#grant-permissions-to-a-specific-domain)

- The provisioning agent must be able to communicate with one or more
  domain controllers on ports TCP/389 (LDAP) and TCP/3268 (Global
  Catalog).

  - Required for global catalog lookup to filter out invalid membership
    references.

- Microsoft Entra Connect with build
  version [<u>2.2.8.0</u>](https://review.learn.microsoft.com/en-us/entra/identity/hybrid/connect/reference-connect-version-history#2280) or
  later.

  - Required to support on-premises user membership synchronized using
    Microsoft Entra Connect.

  - Required to synchronize AD:user:objectGUID to Microsoft Entra
    ID:user:onPremisesObjectIdentifier.

For more information, see [cloud sync supported groups and scale
limits](https://learn.microsoft.com/entra/identity/hybrid/cloud-sync/how-to-prerequisites?tabs=public-cloud#supported-groups-and-scale-limits).

# Supported groups

For this scenario, only the following groups are supported:

- Only cloud created [<u>Security
  groups</u>](https://review.learn.microsoft.com/en-us/entra/fundamentals/concept-learn-about-groups#group-types) are
  supported

- Assigned or dynamic membership groups

- Contain only on-premises synchronized users and / or cloud created
  security groups

- On-premises user accounts that are synchronized and are members of
  this cloud-created security group, can be from the same domain or
  cross-domain, but they all must be from the same forest

- Written back with the AD groups scope
  of [<u>universal</u>](https://review.learn.microsoft.com/en-us/windows-server/identity/ad-ds/manage/understand-security-groups#group-scope).
  Your on-premises environment must support the universal group scope

- Not larger than 50,000 members

- Each direct child nested group counts as one member in the referencing
  group

**Considerations when provisioning groups back to AD**

When you make the SOA switch, if you are going to provision groups back
to Active Directory (AD), it's important to provision those groups back
to the same Organizational Unit (OU) in AD where they were originally
located. This ensures that Microsoft Entra Cloud Sync recognizes the
transferred group as the same one already in AD.

This recognition is possible because both groups share the same security
identifier (SID). If the group is provisioned to a different OU, it will
maintain the same SID, and Microsoft Entra Cloud Sync will update the
existing group, but you may experience Access Control List (ACL) issues.
The reason for this, is because AD permissions don't always travel
cleanly across containers and only explicit permissions will follow the
group. Inherited permissions from the old OU or Group Policy Object
permissions applied to the OU will not.

Before making the SOA switch, consider the following recommended steps:

1\. Move all the groups you plan to change the SOA for to a specific OU
or OUs.  
2. Make the SOA change.  
3. Provision the groups to Active Directory using Group provisioning,
ensuring they are placed in the same OU or OUs as the original groups

For more information on configuring the target location for group that
are provisioned to Active Directory, see [Scope filter target
container](https://learn.microsoft.com/en-us/entra/identity/hybrid/cloud-sync/how-to-attribute-mapping-entra-to-active-directory#scoping-filter-target-container).

## Govern on-prem AD based apps using Group SOA

In this scenario option, when you have a group already present in AD
used by the application, you can use the new capability **Group Source
of Authority (SOA) switch** to change the Source of Authority of the
group to Microsoft Entra. The, you can configure to provision the
membership changes to the group made in Microsoft Entra, such as through
entitlement management or access reviews, back to AD using Group
Provision to AD. In this model, you don’t need to change the app or
create new groups.

<img src="./e2bd822e029aa83306f1fc76eaca2f3fded0d1ab.png"
style="width:6.5in;height:3.78125in" />

Use the following steps for applications to use the Group Source of
Authority option.

## Create application and transfer source of authority

1.  Using the Microsoft Entra admin center, create an application in
    Microsoft Entra ID representing the AD-based application, and
    configure the application to require user assignment.

2.  Ensure that the AD group you plan to convert is already synchronized
    to Microsoft Entra, and that the membership of the AD group is only
    users and optionally other groups which are themselves also
    synchronized to Microsoft Entra. If the group or any members of the
    group are not represented in Microsoft Entra, you will not be able
    to transfer the source of authority of the group.

3.  Transfer the source of authority to your existing synchronized cloud
    group.

4.  Once the source of authority has been transferred, use [<u>Group
    Provisioning to
    AD</u>](https://review.learn.microsoft.com/en-us/entra/identity/hybrid/cloud-sync/how-to-configure-entra-to-active-directory) to
    provision subsequent changes to this group back to AD. Once group
    provisioning is enabled, Microsoft Entra Cloud Sync will recognize
    that a transferred group is the same group as the one already in AD,
    because both groups have the same security identifier (SID).
    Provisioning the transferred cloud group to AD will then update the
    existing AD group instead of creating a new one.

### Configure Microsoft Entra features to manage the membership of the transferred group

1.  Create an [<u>access
    package</u>](https://review.learn.microsoft.com/en-us/entra/id-governance/entitlement-management-access-package-create).
    Add the application from \#1 above, the security group from \#3, as
    resources in the Access Package. Configure a direct assignment
    policy in the access package.

2.  In [<u>Entitlement
    Management</u>](https://review.learn.microsoft.com/en-us/entra/id-governance/entitlement-management-overview),
    assign the synced users who need access to the AD based app to the
    access package.

3.  Wait for the Microsoft Entra Cloud Sync to complete its next
    synchronization. Using Active Directory Users and Computers, confirm
    that the correct users are present as members of the group.

4.  In your AD domain monitoring, allow only the [<u>gMSA
    account</u>](https://review.learn.microsoft.com/en-us/entra/identity/hybrid/cloud-sync/how-to-prerequisites#group-managed-service-accounts) that
    runs the provisioning agent, [<u>authorization to change the
    membership</u>](https://review.learn.microsoft.com/en-us/windows/security/threat-protection/auditing/audit-security-group-management) in
    the new AD group.

For more information, see [Embracing Cloud-first posture: Transitioning
AD Group Source of Authority to the
Cloud](https://microsoft.sharepoint.com/:w:/t/APEXIdentityContent/EQ_Ki1k05l5LqgetVmzYRJYB8E2jU6pewJGIsh4CueBI0Q?e=xQw6OF)

**Govern on-prem AD with new cloud security groups provisioned to AD**

In this scenario option, you update the application to check for the
SID, name or distinguished name of new groups created by cloud sync
group provisioning. This scenario is applicable to:

- Deployments for new applications being connected to AD DS for the
  first time.

- New cohorts of users accessing the application.

- For application modernization, to reduce the dependency on existing AD
  DS groups. Applications, which currently check for membership of
  the Domain Admins group, need to be updated to also check for a newly
  created AD group also.

Use the following steps for applications to use new groups.

### Create application and group

1.  Using the Microsoft Entra admin center, create an application in
    Microsoft Entra ID representing the AD-based application, and
    configure the application to require user assignment.

2.  Create a new security group in Microsoft Entra ID.

3.  Use [<u>Group Provisioning to
    AD</u>](https://review.learn.microsoft.com/en-us/entra/identity/hybrid/cloud-sync/how-to-configure-entra-to-active-directory) to
    provision this group to AD.

4.  Launch Active Directory Users and Computers and wait for the
    resulting new AD group to be created in the AD domain. When it's
    present, record the distinguished name, domain, account name and SID
    of the new AD group.

### Configure application to use new group

1.  If the application uses AD via LDAP, configure the application with
    the distinguished name of the new AD group. If the application uses
    AD via Kerberos, configure the application with the SID, or the
    domain and account name, of the new AD group.

2.  Create an [<u>access
    package</u>](https://review.learn.microsoft.com/en-us/entra/id-governance/entitlement-management-access-package-create).
    Add the application from \#1, the security group from \#3, as
    resources in the Access Package. Configure a direct assignment
    policy in the access package.

3.  In [<u>Entitlement
    Management</u>](https://review.learn.microsoft.com/en-us/entra/id-governance/entitlement-management-overview),
    assign the synced users who need access to the AD based app to the
    access package.

4.  Wait for the new AD group to be updated with the new members. Using
    Active Directory Users and Computers, confirm that the correct users
    are present as members of the group.

5.  In your AD domain monitoring, allow only the [<u>gMSA
    account</u>](https://review.learn.microsoft.com/en-us/entra/identity/hybrid/cloud-sync/how-to-prerequisites#group-managed-service-accounts) that
    runs the provisioning agent, [<u>authorization to change the
    membership</u>](https://review.learn.microsoft.com/en-us/windows/security/threat-protection/auditing/audit-security-group-management) in
    the new AD group.

You can now govern access to the AD application through this new access
package.

## Configuring the existing groups option

In this scenario option, you add a new AD security group as a nested
group member of an existing group. This scenario is applicable to
deployments for applications that have a hardcoded dependency on a
particular group account name, SID, or distinguished name.

Nesting that group into the applications existing AD group will allow:

- Microsoft Entra users, who are assigned by a governance feature, and
  then access the app, to have the appropriate Kerberos ticket. This
  ticket contains the existing groups SID. Nesting is allowed by AD
  group nesting rules.

If the app uses LDAP and follows nested group membership, the app will
see the Microsoft Entra users as having the existing group as one of
their memberships.

### Determine eligibility of existing group

1.  Launch Active Directory Users and Computers, and record the
    distinguished name, type and scope of the existing AD group used by
    the application.

2.  If the existing group is Domain Admins, Domain Guests, Domain
    Users, Enterprise Admins, Enterprise Key Admins, Group Policy
    Creation Owners, Key Admins, Protected Users, or Schema Admins, then
    you'll need to change the application to use a new group, as
    described above, as these groups can't be used by cloud sync.

3.  If the group has Global scope, change the group to have Universal
    scope. A global group can't have universal groups as members.

### Create application and group

1.  In the Microsoft Entra admin center, create an application in
    Microsoft Entra ID representing the AD-based application, and
    configure the application to require user assignment.

2.  Create a new security group in Microsoft Entra ID.

3.  Use [<u>Group Provisioning to
    AD</u>](https://review.learn.microsoft.com/en-us/entra/identity/hybrid/cloud-sync/how-to-configure-entra-to-active-directory) to
    provision this group to AD.

4.  Launch Active Directory Users and Computers and wait for the
    resulting new AD group to be created in the AD domain, when it's
    present, record the distinguished name, domain, account name and SID
    of the new AD group.

### Configure application to use new group

1.  Using Active Directory Users and Computers, add the new AD group as
    a member of the existing AD group.

2.  Create an [<u>access
    package</u>](https://review.learn.microsoft.com/en-us/entra/id-governance/entitlement-management-access-package-create).
    Add the application from \#1, the security group from \#3, as
    resources in the Access Package. Configure a direct assignment
    policy in the access package.

3.  In [<u>Entitlement
    Management</u>](https://review.learn.microsoft.com/en-us/entra/id-governance/entitlement-management-overview),
    assign the synced users who need access to the AD based app to the
    access package, including any user members of the existing AD group
    who still need access.

4.  Wait for the new AD group to be updated with the new members. Using
    Active Directory Users and Computers, confirm that the correct users
    are present as members of the group.

5.  Using Active Directory Users and Computers, remove the existing
    members, apart from the new AD group, of the existing AD group.

6.  In your AD domain monitoring, allow only the [<u>gMSA
    account</u>](https://review.learn.microsoft.com/en-us/entra/identity/hybrid/cloud-sync/how-to-prerequisites#group-managed-service-accounts) that
    runs the provisioning agent, [<u>authorization to change the
    membership</u>](https://review.learn.microsoft.com/en-us/windows/security/threat-protection/auditing/audit-security-group-management) in
    the new AD group.

You'll then be able to govern access to the AD application through this
new access package.

<img src="./d91a2e6445c0212ead093494a73378dddff58842.png"
style="width:6.5in;height:4.40625in" />

# Troubleshooting

A user who is a member of the new AD group and is on a Windows PC
already logged into an AD domain, might have an existing ticket issued
by an AD domain controller that doesn't include the new AD group
membership. This is because the ticket might have been issued prior to
the cloud sync group provisioning adding them to the new AD group. The
user won't be able to present the ticket for access to the application
and so must wait for the ticket to expire and a new ticket is issued, or
purge their tickets, log out and log back into the domain. See
the [<u>klist</u>](https://review.learn.microsoft.com/en-us/windows-server/administration/windows-commands/klist) command
for more details.

# Existing Microsoft Entra Connect group writeback v2 customers

If you're using Microsoft Entra Connect group writeback v2, you'll need
to move to cloud sync provisioning to AD before you can take advantage
of cloud sync group provisioning. See [<u>Migrate Microsoft Entra
Connect Sync group writeback V2 to Microsoft Entra Cloud
Sync</u>](https://review.learn.microsoft.com/en-us/entra/identity/hybrid/cloud-sync/migrate-group-writeback)
