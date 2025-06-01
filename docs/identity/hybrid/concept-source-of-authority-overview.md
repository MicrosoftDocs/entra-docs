---
title: Source of Authority (SOA) Migration Best Practices for Microsoft Entra ID
description: Learn best practices for migrating Source of Authority (SOA) from Active Directory to Microsoft Entra ID, including prerequisites, supported scenarios, and step-by-step guidance for IT Architects and Administrators.
author: Justinha
ms.topic: concept-article
ms.date: 05/27/2025
ms.author: justinha
ms.reviewer: justinha
---
<!--
This article helps IT Architects understand the dependencies and tasks involved in prepping their current environment before you apply Source of Authority (SOA). You learn what happens when you switch SOA of users, groups, and contacts from Active Directory to the cloud. You can get answers to address these concerns:

- Is SOA the right solution for you and are you in the right place to use SOA? For example, do you have all the necessary prerequisites in place before you apply SOA?



- Should you switch the SOA of groups first or can you do it in any sequence? What does Microsoft recommend?



- Are there any applications tied to AD to which you can migrate? If so, how does that affect your SOA switch?



- After you switch the SOA, how can you decrease end user impact?

*For this article, Dhanyah has suggested that we use the Best Practices article template. The following template guidance is pasted from the* **<u>Content pattern template: Best practices article</u>** *section of the* **<u>Appendices</u>***.

-->
# Source of Authority (SOA) Overview

The Source of Authority (SOA) (at an object level) is a feature that enables IT Administrators to transition the management of a specific object from Active Directory Domain Services (AD DS) to Microsoft Entra ID, thereby converting it into a cloud object that can be edited and deleted in Microsoft Entra ID.

:::image type="content" source="media/concept-source-of-authority-overview/image1.png" alt-text="Screenshot of the Source of Authority overview.":::

By granting administrators the ability to selectively migrate objects to the cloud, a phased approach can be facilitated for your migration process. Instead of switching the entire directory to the cloud and discontinuing AD DS in one step —an action that necessitates substantial redesign and re-platforming of applications, with coordination across multiple functional teams with huge impact to application owners and end users —this feature allows for a gradual reduction of AD DS dependencies. This phased approach ensures seamless operations with minimal impact on end users as well as helping organizations secure their identities using the cloud capabilities.

## Why use SOA?

SOA helps these enterprise roles: 

**IT architects** determine how to architect their identity & access management infrastructure setting them up for a cloud first environment with minimal to no AD DS dependencies in the future.

**IT administrators** develop a project plan to transition user and group workloads to the cloud while identifying AD DS dependencies that can’t be migrated. This approach ensures a smooth transition to the cloud and allows them to present progress to their leadership in a clear and measurable way. Additionally, this process provides an opportunity to systematically reduce AD DS dependencies and paves a path for all apps, including on-premises AD DS based apps to be governed from the cloud.

**Security operations center (SOC) analysts** shift focus from on-premises security to enhancing cloud security. AD DS is crucial, often called the "keys to the kingdom." Breaching AD DS can give attackers access to all domain-joined machines for recon, lateral movement, and malware deployment. Reducing dependencies on AD DS improves organizational security.

## What is Group SOA?

Group SOA helps organizations shift their access governance for applications from on-premises to the cloud. They can transfer the source of authority of groups in Active Directory that synchronize with Microsoft Entra ID. They can synchronize the groups with Microsoft Entra Connect Sync or Microsoft Entra Cloud Sync.

Group SOA converts the group to a cloud object. After it converts, you can edit, delete, and change the cloud group membership directly in the cloud. Microsoft Entra Connect Sync (and soon Microsoft Entra Cloud Sync) respects the conversion and stops synchronizing the object from AD DS. With Group SOA, you can migrate multiple groups or select specific groups. After transfer, you can perform all operations available for a cloud group. If necessary, you can reverse these changes.

## Scenarios supported with Group SOA

The following table outlines the scenarios that are supported using Group SOA.

| Scenario | Description | Solution |
| --- | --- | --- |
| Govern access with Microsoft Entra ID Governance | There are applications in your portfolio that you can’t modernize or that connect to AD DS. These applications use Kerberos or LDAP to query non-mail-enabled security groups in AD DS to determine access permissions. Your goal is to regulate access to these applications with Microsoft Entra ID and Microsoft Entra ID Governance. This goal necessitates that the group membership information that Microsoft Entra manages be accessible to the applications. | You can achieve your goal in one of two ways: <br> 1. Use the Groups SOA Preview instructions document from the Private Preview channel to change the source of authority of the existing AD DS. Provision the groups back to AD DS with Group Provision to AD DS. In this model, you don’t need to change the app or create new groups. For more information, see Govern on-premises Active Directory based apps (Kerberos) using Microsoft Entra ID Governance. <br> 2. To replicate the groups in AD DS, create them from scratch in Microsoft Entra ID as new cloud security groups. Provision them to AD DS as Universal groups with Group Provision to AD DS. In this model, you can change the app to use the new group security identifiers (SID). If you use the account, global, domain local, permission model, nest the newly provisioned group under the existing group. For more information, see Govern on-premises Active Directory (Kerberos) application access with groups from the cloud - Microsoft Entra ID | Microsoft Learn. |
| AD DS Minimization | You modernized some or all your applications and removed the need to use AD DS groups for access. For example, these applications now use group claims with Security Assertion Markup Language (SAML) or OpenID Connect from Microsoft Entra ID instead of federation systems such as AD FS. However, these apps still rely on the existing synched security group to manage access. Using Group SOA, you can make the security group membership editable in the cloud, remove the AD DS security group completely, and govern the cloud security group through Microsoft Entra ID Governance capabilities if desired. | You can use Group SOA to make these groups cloud managed groups and remove them from AD DS. You can continue to create new groups directly in the cloud. For more information, see Best practices for managing groups in the cloud. |
| Remove on-premises Exchange dependencies | You migrated all user exchange mailboxes to the cloud. You updated applications that rely on mail routing features to use modern authentication methods like SAML and OpenID Connect. You no longer need to manage Distribution Lists (DL) and Mail-Enabled Security Groups (MESG) in AD DS. Your goal is to migrate existing DLs and MESGs to the cloud. Then you either update these groups to Microsoft 365 groups or manage them through Exchange Online. | You can achieve this goal with Group SOA to make these groups cloud managed groups and remove them from AD DS. You can continue to edit these groups directly in EXO or via Exchange PowerShell modules . These mail objects cannot be managed directly in Microsoft Entra ID or using the MS Graph APIs. |

## Benefits of using Group SOA

Minimizing AD DS entails streamlining its structure by reducing size, complexity, or extraneous features to improve efficiency, security, and manageability. Group Source of Authority (SOA) allows AD DS minimization and can have significant benefits to your organization. Here are some of the key benefits for leveraging Group Source of Authority.

| Benefit | Description |
| --- | --- |
| Improve Security posture | **Reduced Attack Surface**: SOA enables the removal of unused or unnecessary groups from AD DS by shifting them to the cloud, thereby reducing the number of objects that need |
| Cloud Governance | **Modernize Group Management**: With [<u>Microsoft Entra ID Governance</u>](/entra/id-governance), Group Source of Authority, and [<u>Group Provisioning to Active Directory</u>](/entra/id-governance/scenarios/provision-entra-to-active-directory-groups), the entire lifecycle of ***non-mail enabled security groups*** can now be managed from the cloud and access governance of on-premises apps becomes easier. |
| Simplified Management in AD DS | **Easier Administration and Monitoring**: Because SOA allows you to remove unused or unnecessary groups, it allows for fewer groups in AD DS. Fewer groups mean AD DS is easier to manage and monitor  |

## Is SOA the right solution for you?

SOA allows organizations to advance their [journey to the cloud](/entra/architecture/road-to-the-cloud-introduction) by enabling the following [cloud first](/entra/architecture/road-to-the-cloud-posture#state-3-cloud-first) approach for existing objects that were originated from Active Directory Domain Services, after SOA is applied to them. It enables the following:

- Manage users object properties with Entra cloud-native capabilities such as Microsoft Graph and Microsoft Entra admin center.

<!-- -->

- Manage access lifecycle based on group membership for the migrated groups, using cloud-native capabilities such as Entitlement Management, Lifecycle Workflows, and Access Reviews

<!-- -->

- Cloud-native authentication for on-premises AD Kerberos Applications, which in turn enables controls such as Conditional Access policies

This allows consistent administrative operational procedures for both migrated and cloud-native objects.

The following diagram and table below outlines the [cloud first](https://learn.microsoft.com/entra/architecture/road-to-the-cloud-posture#state-3-cloud-first)/[AD minimization](https://learn.microsoft.com/entra/architecture/road-to-the-cloud-posture#state-4-active-directory-minimized) approach.

:::image type="content" source="media/concept-source-of-authority-overview/image2.png" alt-text="Screenshot of the cloud first and AD minimization approach.":::

| *State* | *Description* |
| --- | --- |
| [Cloud attached](https://learn.microsoft.com/entra/architecture/road-to-the-cloud-posture#state-1-cloud-attached) | In the cloud-attached state, organizations have created a Microsoft Entra tenant to enable user productivity and collaboration tools. The tenant is fully operational. |
| [Hybrid](https://learn.microsoft.com/entra/architecture/road-to-the-cloud-posture#state-2-hybrid) | In the hybrid state, organizations start to enhance their on-premises environment through cloud capabilities. |
| [Cloud first](https://learn.microsoft.com/entra/architecture/road-to-the-cloud-posture#state-3-cloud-first) | In the cloud-first state, the teams across the organization build a track record of success and start planning to move more challenging workloads to Microsoft Entra ID. Organizations typically spend the most time in this state of transformation. As complexity, the number of workloads, and the use of Active Directory grow over time, an organization needs to increase its effort and its number of initiatives to shift to the cloud. |
| [AD minimized](https://learn.microsoft.com/entra/architecture/road-to-the-cloud-posture#state-4-active-directory-minimized) | Microsoft Entra ID provides most IAM capability, whereas edge cases and exceptions continue to use on-premises Active Directory. A state of minimizing Active Directory is more difficult to achieve, especially for larger organizations that have significant on-premises technical debt. |

## Implications of SOA changes

The change of SOA from AD DS to Microsoft Entra has implications on how organizations are managing the lifecycle of those AD objects. The following sections outline these implications.

### Microsoft Entra HR inbound from an HR source such as Workday or SuccessFactors

:::image type="content" source="media/concept-source-of-authority-overview/image3.png" alt-text="Screenshot of Microsoft Entra HR inbound configuration.":::

If your organization is using Microsoft Entra HR inbound from an HR source such as Workday or SuccessFactors to populate users in AD, and you wish to change the source of authority for one or more of those users, then you’ll need to update your Microsoft Entra HR inbound configuration to send any subsequent changes for those users to Microsoft Entra ID. For more information, see <u>Shift your HR integration to the cloud</u>.

### Active Directory Users and Computers or the Active Directory module for PowerShell

If your organization is using AD management tools such as Active Directory Users and Computers or the Active Directory module for PowerShell, then changes made using those tools to AD objects whose SOA has been changed will cause an inconsistency with the Microsoft Entra representation. Prior to performing a SOA change, your organization should move those objects to a designated AD OU that signals those objects should no longer be managed via AD tools.

### Microsoft Identity Manager with the AD MA

:::image type="content" source="media/concept-source-of-authority-overview/image4.png" alt-text="Screenshot of Microsoft Identity Manager with the AD MA.":::

If your organization is using Microsoft Identity Manager with the AD MA to manage AD users and groups, then prior to a SOA change, the organization must configure their sync logic to no longer export changes to those objects from MIM via AD MA. Instead of using the AD MA, you can have MIM update the objects in Microsoft Entra using the [MIM connector for Microsoft Graph](https://learn.microsoft.com/microsoft-identity-manager/microsoft-identity-manager-2016-connector-graph) so that the changes made by MIM are sent to Microsoft Entra and then to Active Directory where needed. For more information, see <u>Prep your MIM setup</u>.

### Applications (User SOA only)

Your application must be modernized and should leverage [cloud authentication](https://learn.microsoft.com/entra/architecture/authenticate-applications-and-users) in order for your source of authority to change user objects to work. If you need to access on-premises resources, you can leverage Microsoft Entra Kerberos and [Entra Private Access](https://learn.microsoft.com/entra/global-secure-access/concept-private-access) to access Kerberos based AD apps. For LDAP based applications, we recommend customers use Microsoft Entra Domain Services.

### Devices (User SOA Only)

We recommend that customers migrate their devices to the cloud and use Entra Joined Device setup in order to fully leverage SOA capabilities for users. For groups, there’s no pre-requisites around devices.

### Microsoft Exchange

All Customers who have migrated all their mailboxes to EXO and have a strategy around managing DLs and mail enabled security groups from the cloud can switch the corresponding users and groups from AD to Entra ID.

Security groups with no mail enabled features don’t have any pre-requisites related to Exchange and can be switched.

### Credentials (User SOA only)

## Prepare your IT Environment for SOA

The following outlines what you need to do to get ready for the SOA change.

:::image type="content" source="media/concept-source-of-authority-overview/image5.png" alt-text="Screenshot of the IT environment preparation for SOA.":::

### Confirm your AD objects are ready to have their SOA changed

Prior to changing the SOA on a user or group object, retrieve the objects from your AD domain and confirm that they’re ready to be converted.

- Confirm that the objects are already synchronized to Microsoft Entra.
  Administrative objects or those excluded from synchronization can’t
  have their SOA changed.

<!-- -->

- Confirm that all attributes which you have or plan to modify on those
  users or groups are being synched to Microsoft Entra and are visible
  as \[directory schema extensions\]
  /graph/api/resources/extensionproperty in Microsoft Graph.

<!-- -->

- Confirm there are no reference-valued attributes populated on those
  objects in AD, other than the user’s manager or the group’s members.

<!-- -->

- Confirm that the value of the manager and member attributes, if set,
  must be references to users and groups in the same AD domain and that
  are synchronized to Microsoft Entra; they can’t refer to other object
  types or to objects which aren’t synchronized from this domain to
  Microsoft Entra.

<!-- -->

- Confirm that there are no attributes on the objects which are updated
  by another Microsoft on-premises technology, other than Active
  Directory Domain Services itself. For example, don’t change the SOA of
  a user whose userCertificate attribute is maintained by AD CS.

### Update your AD

If you’re planning to only change the SOA for some AD users, groups or
contacts in a domain, we recommend that you create a new AD DS OU for
these objects, to avoid inadvertently changing them in Active Directory.
Users, groups, or contacts whose SOA has isn’t changing, can continue to
be managed using Active Directory Users and Computers, Active Directory
Module for PowerShell, or other AD management tools. After creating an
OU, move the objects to that OU. For more information, see
[Move-ADObject](https://learn.microsoft.com/powershell/module/activedirectory/move-adobject?view=windowsserver2025-ps).

### Shift your HR integration to the cloud (only for User SOA)

The first step in setting up SOA is to determine your provisioning
strategy for your HR system. Ideally, you’re already provisioning new
employees from your cloud HR system into Entra ID directly and have
identified all the users that are no longer needed in Active Directory.
If not, our recommendation is to determine your HR strategy first before
planning your source of authority change project.

:::image type="content" source="media/concept-source-of-authority-overview/image6.png" alt-text="Screenshot of the HR integration setup.":::

This section assumes you have Microsoft Entra cloud integrations with
your HR sources, such as Workday or SuccessFactors. If you’re using MIM
and have your HR systems connected through MIM,  follow the steps called
out in the [Section “Prep for MIM”](bookmark://_Prep_your_MIM).

:::image type="content" source="media/concept-source-of-authority-overview/image7.png" alt-text="Screenshot of the steps for shifting HR integration to the cloud.":::

### Steps for shifting your HR integration to the cloud

1.  Make sure you have your cloud HR system is ready and in place to
    initiate provisioning to Entra ID.

<!-- -->

2.  Go to your HR Provisioning to AD configuration and remove the users
    no longer needed in AD from the App-\> AD provisioning configuration
    (e.g., Workday to AD) so they no longer sync into AD. Apply phased
    approach to provision identities from HR system into directory by
    starting with a few users and then using your selection criteria to
    scope users.

<!-- -->

3.  Switch the Source of Authority of the selected users from AD to
    Entra ID.

<!-- -->

4.  In your HR Provisioning configuration, manually Migrate/transfer
    attribute mappings from to ensure the mappings/transformation
    happens from HR to Entra ID. This would require you setting up a new
    provisioning configuration with target as Entra ID and setting up
    the mappings in that configuration.

<!-- -->

5.  If you have switched AD group management to the cloud, ensure these
    users are provisioned into that group moving forward.

### Prep your sync client

\<\<need a visual diagram to help Admins understand this prep\>\>

\[Duplicate the above title for each best practice. Describe the best
practice. Use H2s to define best practices, even if you include best
practices section H2s. You can provide steps to show how to implement a
recommendation.\] 

### Prepare your MIM setup

:::image type="content" source="media/concept-source-of-authority-overview/image8.png" alt-text="Screenshot of the MIM setup preparation.":::

For customers using MIM, you can update the sync rules in MIM to
determine which objects will continue to be provisioned into Active
Directory vs. which ones will be provisioned into Entra ID.

1.  Select the attributes which will be the unique identifiers for users
    and groups that are the same in both AD and Microsoft Entra.

<!-- -->

2.  Add to MIM sync the [Microsoft Identity Manager connector for
    Microsoft Graph \| Microsoft
    Learn,](https://learn.microsoft.com/en-us/microsoft-identity-manager/microsoft-identity-manager-2016-connector-graph)
    configure a join of the existing AD users and groups with those
    brought in from this connector.

<!-- -->

3.  Check the precedence settings on the user, group and contact
    objects.

<!-- -->

4.  Perform a full import from Microsoft Entra using the Microsoft Graph
    connector.

<!-- -->

5.  Confirm that all the users and groups which are planned for SOA
    conversion have been joined between the metaverse and the Microsoft
    Graph connector.

<!-- -->

6.  Update the management system for those users and groups (e.g., MIM
    Portal and Service) to add a label to user and group objects for
    which the SOA is changing to Entra ID.

<!-- -->

7.  Update the sync rules so that you’re no longer syncing those labeled
    user and group objects from MIM to AD, and instead synching to
    Microsoft Graph connector.

<!-- -->

8.  Keep the sync rules de-activated until SOA transfer is complete.

<!-- -->

9.  After the SOA transfer, re-sync users and groups. Confirm there are
    no exports pending for those users and groups to the AD MA, only to
    the Microsoft Graph connector.

<!-- -->

10. Add to your run profile schedules a run of exporting changes from
    MIM to Entra ID using the Microsoft Graph connector.

<!-- -->

11. If you’re no longer exporting any changes to other users and groups
    in AD, then remove the export to AD run profile from your run
    profile schedules.

:::image type="content" source="media/concept-source-of-authority-overview/image9.png" alt-text="Screenshot of the MIM setup preparation steps.":::

### Prepare your Microsoft Exchange Setup

In case you have Exchange Hybrid setup with your MICROSOFT 365 Exchange
Online, please prepare your Exchange Server and Exchange Online as per
below guidance, before you switch the SOA of your user accounts and
groups.

If you have been running an Exchange hybrid configuration, please ensure
all your mailboxes have migrated to Exchange Online before you switch
SOA for any users/groups to cloud. After mailbox migration of all users,
these users and related groups can be managed in Microsoft 365 you can
safely switch SOA of users and groups to cloud. Additionally disable
Exchange Hybrid by completing following steps:

1.  Point the MX and Autodiscover DNS records to Exchange Online,
    instead of Exchange Server.

<!-- -->

2.  Remove the Service Connection Point (SCP) values on Exchange
    servers. This step ensures that no SCPs are returned, and the
    Outlook clients will instead use the DNS method for Autodiscover.

<!-- -->

3.  Optionally, to secure your environment, remove the inbound and
    outbound connectors created by the Hybrid Configuration Wizard used
    for mail flow between Exchange Server and Exchange online.

<!-- -->

4.  Optionally, to secure your environment, remove the organization
    relationship, Fed Trust and oauth trust set up between Exchange
    Server and Exchange Online by HCW.

<!-- -->

5.  Stop writing to on-premises Exchange for the object and sync the
    object to cloud to ensure EXO has the latest changes from
    on-premises.

 For more information on disabling [Exchange Hybrid see Manage
recipients in Exchange Hybrid environments using Management
tools](https://learn.microsoft.com/Exchange/manage-hybrid-exchange-recipients-with-management-tools).

## Sequence of Steps for using SOA

:::image type="content" source="media/concept-source-of-authority-overview/image10.png" alt-text="Screenshot of the sequence of steps for using SOA.":::

1.  Identify the users and/or groups for whom you’re going to Switch the
    source of authority (SOA) to Entra ID. Ensure these users and groups
    are currently being synced using Microsoft Entra Connect Sync or
    Microsoft Entra Cloud Sync.

<!-- -->

1.  **Note:** **If you’re moving groups first, we recommend you first
    Switch the source of authority of the groups’ first before doing it
    for users**

<!-- -->

2.  Remove these users from the App-\> AD provisioning configuration
    (e.g., Workday to AD or MIM to AD etc.) so they no longer sync into
    AD.

<!-- -->

1.  **Note: How you remove the users and/or groups from scope depends on
    the management tool**

<!-- -->

3.  Wait for the sync cycle to complete and make sure the object data is
    the same between AD and Entra ID. You can use tools like Provision
    on-demand to do this.

<!-- -->

4.  Stop making any changes to the users and/or groups in Step \#2 in AD
    directly.

<!-- -->

5.  Switch the SOA of the users and/or groups identified in Step \#2 by
    running the . You can also customize this script to enable bulk
    operations.

<!-- -->

6.  Confirm that the users and/or groups can now be managed from the
    cloud by following these steps.

<!-- -->

1.  Go to the Micrsoft Entra admin center and find the user/group you
    switched SOA of and see if they’re a cloud object and can be edited
    (or)

<!-- -->

2.  Run this script to check if the “DirSync” and “isCloudManaged”
    attribute it set to cloud

<!-- -->

3.  Check the events listed here in Audit logs to see whether the SOA
    status has changed

<!-- -->

7.  Continue to keep the users and/or groups in scope for Connect/Cloud
    Sync. This is needed if these objects have references to groups,
    devices and contacts managed in AD.

<!-- -->

8.  Change the direction of provisioning for users in \#2 in order to
    ensure these user changes are provisioned directly into Entra ID
    from the corresponding HR systems.

<!-- -->

1.  Create a new provisioning configuration to provision the users in
    \#2 from equivalent cloud app system to Entra ID using Provisioning
    API

- Start provisioning the same users (from \#2) from cloud system (HR or
  other apps) into Entra directly.

<!-- -->

- At this point, SOA transfer is complete, and the identities have
  started flowing from Cloud system -\> Entra ID or Entra ID has become
  the source of authority.

## Validate your SOA change end to end

Once you have switched the source of authority of the object, you can
either go to the Micrsoft Entra admin center or use MS Graph API to
check if the switched object is a cloud object. In the Micrsoft Entra
admin center, you can click on the switched object and see that it’s now
editable. In MS Graph API for user/group resources, you can validate if
the “isDirSyncEnabled” field is set to “false” and “isCloudManaged”
field is set to “true”.

You can also look at the following events in the Audit logs:

- Change Source of Authority from AD to cloud” - for an object that
  switched SOA to the cloud

<!-- -->

- Undo changes to source of authority from AD to cloud” – for rollback
  of SOA change.

=== Appendix / Reference material ===

| Object Type | Attributes | Attribute status in AD DS | Attribute status in Microsoft Entra |
| --- | --- | --- | --- |
|  |  | Can’t be read or updated | Can be read and updated |
|  |  | Can be read and updated | Can’t be read or updated |
|  |  | Can be read but must not be updated as this will lead to inconsistency | Can be read and updated |
|  |  | Can be read and can’t be updated | Can be read and updated |
|  |  |  |  |
|  |  |  |  |
