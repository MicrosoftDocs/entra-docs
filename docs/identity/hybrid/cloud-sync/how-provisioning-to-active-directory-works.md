---
layout: Conceptual
title: Microsoft Entra provisioning behavior (Preview)
author: dhanyahk
ms.author: dhanyahk
manager: mwongerapk
ms.reviewer: marshmacy
ms.service: entra-id
ms.subservice: hybrid-cloud-sync
ms.topic: concept-article
ms.date: 08/19/2026
description: Learn how Microsoft Entra Cloud Sync matches, creates, updates, disables, and deletes users, groups, and memberships in Active Directory.
ai-usage: ai-assisted
ms.custom: msecd-doc-authoring-1023
#customer intent: As a hybrid identity administrator, I want to understand provisioning behavior so that I can predict object changes and troubleshoot results.
---

# How provisioning from Microsoft Entra ID to Active Directory works (preview)

This article explains how the Microsoft Entra Cloud Sync provisioning engine processes objects when it provisions **users, groups, and memberships** from Microsoft Entra ID to on-premises Active Directory Domain Services (AD DS). Understanding this behavior helps you plan a deployment, predict what happens on create, update, or delete, and troubleshoot unexpected results.

For an introduction to the feature and the scenarios it supports, see [Overview of provisioning from Microsoft Entra ID to Active Directory](overview-provision-entra-id-to-active-directory.md).

## The provisioning pipeline

Microsoft Entra ID is the source of authority. Each sync cycle, the provisioning service:

1. **Reads scope.** It determines which users and groups are in scope, based on your [scoping filters](how-to-configure-entra-to-active-directory.md#configure-scoping-filters).
1. **Matches.** For each in-scope object, it looks for an existing AD object to update. For more information, see [How matching works](#how-matching-works).
1. **Applies attribute mappings.** It transforms Microsoft Entra ID attributes to AD attributes by using the configured [attribute mappings](how-to-configure-entra-to-active-directory.md#configure-attribute-mapping).
1. **Writes.** It creates, updates, or deletes the AD object through the Cloud Sync provisioning agent, which translates the request to a Lightweight Directory Access Protocol (LDAP) operation.

The provisioning service processes changes incrementally. Only objects that changed since the last cycle are evaluated, which keeps delta cycles fast.

## How matching works

The engine uses a durable anchor rather than a name or distinguished name so objects can be renamed or moved without breaking the link.

- The provisioning service stamps **`msDS-ExternalDirectoryObjectId`** on every object it provisions (`User_<objectId>` for users and `Group_<objectId>` for groups). This attribute is the join anchor between the Microsoft Entra ID object and its AD counterpart.
- On each cycle, the engine searches the target domain for an AD object whose `msDS-ExternalDirectoryObjectId` matches the source object.
  - **Match found** → the existing AD object is **updated** in place.
  - **No match found** → a **new** AD object is **created** in the target container.

This match-then-create behavior means provisioning is idempotent. Rerunning a cycle doesn't create duplicate objects for the same Microsoft Entra ID identity.

> [!NOTE]
> `msDS-ExternalDirectoryObjectId` and related anchor attributes are managed by the service and aren't editable in the Microsoft Entra admin center.

## How users are provisioned

- **Cloud-native users** are created as new AD user objects in the target container.
- **Users whose Source of Authority (SOA) is converted to the cloud** are matched to their existing AD object and updated in place. Their **original organizational unit (OU) is preserved** by the default target-container expression, so cloud updates flow back to the user's original location. For more information, see [Configure the target container](how-to-configure-entra-to-active-directory.md#configure-the-target-container).
- **Business-to-business (B2B) guest users** can be provisioned into AD where required.
- **Identity continuity** is maintained by preserving key attributes such as the security identifier (SID) on SOA-converted users.

Because a user's on-premises location is derived from their `onPremisesDistinguishedName` attribute when that attribute is populated, the target container you configure applies only to users who don't already have one. To move an already-provisioned user, see [Move a provisioned user to a different organizational unit](how-to-configure-entra-to-active-directory.md#move-a-provisioned-user-to-a-different-organizational-unit).

### User SOA scenarios

The following table describes how a user is provisioned based on the user's source of authority, for both provisioning directions.

| Use case | User SOA | Sync direction | How sync works |
| --- | --- | --- | --- |
| Cloud-native user with no AD account | Cloud | Microsoft Entra ID to AD | Creates a new AD user in the target container you configured. |
| SOA-converted user | Cloud | Microsoft Entra ID to AD | Matches the existing AD user and updates it in place. The original OU and SID are preserved. |
| B2B guest user | Cloud | Microsoft Entra ID to AD | Creates the AD user when the guest is in scope. |
| Synchronized user | On-premises | Microsoft Entra ID to AD | Does **not** provision the user. Active Directory remains authoritative. |
| Synchronized user | On-premises | AD to Microsoft Entra ID | Provisions the user to Microsoft Entra ID. |
| SOA-converted user | Cloud | AD to Microsoft Entra ID | Does **not** provision the user. Changes made directly in AD are skipped because the cloud is authoritative. |

### On-premises attributes written back to Microsoft Entra ID

When Cloud Sync provisions a user to Active Directory, it writes the resulting on-premises values back to the user's object in Microsoft Entra ID:

| Attribute | Value written back |
| --- | --- |
| `onPremisesDistinguishedName` | The distinguished name (DN) of the AD user object, which includes its OU path. |
| `onPremisesSamAccountName` | The SAM account name assigned to the AD user object. |
| `onPremisesSecurityIdentifier` | The security identifier (SID) of the AD user object. |
| `onPremisesUserPrincipalName` | The user principal name (UPN) of the AD user object. |
| `onPremisesDomainName` | The AD domain that the user is provisioned into. |

This writeback is why a cloud-native user has an `onPremisesDistinguishedName` value after the first provisioning cycle.

### Attribute updates

Attribute changes made in Microsoft Entra ID flow to AD on the next cycle. Because **the cloud is the source of truth**, a change made directly in AD to an attribute that's under management might be overwritten during the next sync cycle.

## How groups and memberships are provisioned

- Only **security groups** are provisioned. Mail-enabled groups and distribution groups aren't supported.
- Groups are provisioned as **Universal** security groups and matched by the same `msDS-ExternalDirectoryObjectId` anchor.
- **Membership** is resolved per member. A member reference is written only when that member has an AD account. A cloud-managed member gets one when the configuration also provisions users and that member is in scope. Whether the parent group itself is provisioned depends on its source of authority.
- **Provisioning membership to on-premises users** is off by default and must be explicitly enabled in the scoping wizard. See [Group membership to on-premises users](how-to-configure-entra-to-active-directory.md#group-membership-to-on-premises-users).
- An in-scope group with no eligible members is provisioned with **empty membership**.

### Group membership SOA scenarios

An object must be in scope before it's provisioned, and that applies to users and groups alike. A member reference is written only when the member has an AD account for it to point to. On-premises synchronized members already have one. A cloud-managed member gets one only when the configuration also provisions users and that member is in scope. So in a configuration that provisions both, select a group whose members are the users you want to provision. In a groups-only configuration, cloud-managed members have no AD account, so their membership references can't be written.

The following table describes how group membership is provisioned when the source is Microsoft Entra ID.

| Configuration | Parent group SOA | Member user SOA | How sync works |
| --- | --- | --- | --- |
| **Groups only** | Cloud | On-premises | Provisions the group with all member references. The members already have AD accounts from directory synchronization. |
| **Groups only** | Cloud | Cloud | Provisions the group with no member references. |
| **Groups only** | Cloud | Mixed | Provisions the group, and includes member references only for the on-premises members. |
| **Users and groups** | Cloud | On-premises | Provisions the group with all member references. |
| **Users and groups** | Cloud | Cloud | Provisions the group, creates an AD account for each in-scope member, and writes all member references. |
| **Users and groups** | Cloud | Mixed | Provisions the group with all member references. On-premises members already have AD accounts, and in-scope cloud-managed members get one from user provisioning. |

> [!IMPORTANT]
> The rows that write references for on-premises members apply only when membership provisioning to on-premises users is turned on. This setting is off by default. Enable it in the **Configure group membership** step of the scoping wizard, as described in [Group membership to on-premises users](how-to-configure-entra-to-active-directory.md#group-membership-to-on-premises-users).

The following table describes how group membership is provisioned when the source is Active Directory.

| Parent group SOA | Member user SOA | How sync works |
| --- | --- | --- |
| On-premises | On-premises | Provisions the group with all member references. |
| On-premises | Cloud | Provisions the group with all member references, including members whose SOA converted to cloud. |
| On-premises | Mixed | Provisions the group with all member references, including members whose SOA converted to cloud. |
| On-premises | None | Provisions the group with empty membership. |
| Cloud | Any | Does **not** provision the group. |

### Nested group membership behavior

The `AAD2ADGroupProvisioning` job handles nested-group membership references as described in the following table.

| Use case | Parent group type | Member group type | How sync works |
| --- | --- | --- | --- |
| A Microsoft Entra parent security group has only Microsoft Entra security-group members. | Microsoft Entra security group | Microsoft Entra security group | Provisions the parent group with all member-group references. |
| A Microsoft Entra parent security group has synchronized-group members. | Microsoft Entra security group | Synchronized AD DS security group | Provisions the parent group, but none of the AD DS group references are provisioned. |
| A Microsoft Entra parent security group has synchronized-group members whose SOA is converted to the cloud. | Microsoft Entra security group | SOA-converted AD DS security group | Provisions the parent group with all member-group references. |
| You convert the SOA of a synchronized parent group that has cloud-owned groups as members. | SOA-converted AD DS security group | Microsoft Entra security group | Provisions the parent group with all member-group references. |
| You convert the SOA of a synchronized parent group that has other synchronized groups as members. | SOA-converted AD DS security group | Synchronized AD DS security group | Provisions the parent group, but none of the AD DS group references are provisioned. |
| You convert the SOA of a synchronized parent group whose members are other SOA-converted groups. | SOA-converted AD DS security group | SOA-converted AD DS security group | Provisions the parent group with all member-group references. |

## How deletes work

Delete behavior depends on the object type and lifecycle event. AD user accounts can be disabled, but AD groups don't have a disabled state.

| Trigger in Microsoft Entra ID | Effect in Active Directory |
| --- | --- |
| A user is soft deleted | The matched AD user account is disabled. |
| A user is hard deleted | The matched AD user account is deleted. |
| A user goes out of scope | The matched AD user account is disabled. |
| A group is hard deleted | The matched AD group is deleted. |
| A member is removed from a group in Microsoft Entra ID | The corresponding member reference is removed from the AD group. |

> [!WARNING]
> Validate scope changes in a test configuration before you apply them in production. When an object leaves scope, review the provisioning logs to confirm the resulting action. AD groups can't be disabled, so don't apply user deprovisioning behavior to groups.

## Password writeback

Password writeback, which synchronizes password changes in Microsoft Entra ID to the matched AD account, isn't available. Users access Kerberos-based applications through passwordless authentication using the AD account that provisioning creates.

## Sync frequency

The provisioning service runs on a recurring schedule. Changes are picked up incrementally each cycle.

## Common tasks

The following tasks are covered step by step in [Configure provisioning to Active Directory](how-to-configure-entra-to-active-directory.md).

| Task | Description |
|---|---|
| [Move a provisioned user to a different organizational unit](how-to-configure-entra-to-active-directory.md#move-a-provisioned-user-to-a-different-organizational-unit) | Change the OU of a user who's already provisioned. |
| [Preserve a group's original organizational unit](how-to-configure-entra-to-active-directory.md#preserve-a-groups-original-organizational-unit) | Keep a SOA-converted group in the OU it already occupies. |
| [Preserve a group's original common name](how-to-configure-entra-to-active-directory.md#preserve-a-groups-original-common-name) | Keep a SOA-converted group's existing name. |
| [Roll back a SOA-converted user or group](how-to-configure-entra-to-active-directory.md#roll-back-a-soa-converted-user-or-group) | Return an object to on-premises control. |

## Next step

> [!div class="nextstepaction"]
> [Review the prerequisites](how-to-prerequisites-provision-entra-to-active-directory.md)

## Related content

- [Overview of provisioning from Microsoft Entra ID to Active Directory](overview-provision-entra-id-to-active-directory.md)
- [Deployment options for provisioning to Active Directory](concept-deployment-options-provision-to-active-directory.md)
- [Configure provisioning to Active Directory](how-to-configure-entra-to-active-directory.md)
- [Test and enable provisioning to Active Directory](how-to-test-and-enable-provisioning-entra-to-active-directory.md)
- [Transfer user Source of Authority (SOA) to the cloud](/entra/identity/hybrid/user-source-of-authority-overview)
- [Convert group Source of Authority (SOA) to the cloud](/entra/identity/hybrid/concept-source-of-authority-overview)
- [What is Microsoft Entra Cloud Sync?](what-is-cloud-sync.md)
- [What is Microsoft Entra ID Governance?](/entra/id-governance/identity-governance-overview)
