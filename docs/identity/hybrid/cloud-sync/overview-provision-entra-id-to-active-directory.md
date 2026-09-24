---
title: Provision Microsoft Entra ID objects to AD
description: Learn how Microsoft Entra Cloud Sync provisions users, groups, and memberships from Microsoft Entra ID to Active Directory and review supported scenarios.
author: dhanyahk
ms.author: dhanyahk
manager: teeearls
ms.reviewer: marshmacy
ms.service: entra-id
ms.subservice: hybrid-cloud-sync
ms.topic: concept-article
ms.date: 08/10/2026
ai-usage: ai-assisted
ms.custom: msecd-doc-authoring-1023
#customer intent: As a hybrid identity administrator, I want to understand provisioning from Microsoft Entra ID to Active Directory so that I can plan the right deployment.
---

# Overview of Microsoft Entra ID to Active Directory provisioning

Microsoft Entra Cloud Sync can provision **users, groups, and group memberships** from Microsoft Entra ID to on-premises Active Directory Domain Services (AD DS). This lets you manage the identity lifecycle from the cloud, using [Microsoft Entra ID Governance](/entra/id-governance/identity-governance-overview), while maintaining uninterrupted access to applications that still depend on Active Directory (AD). It builds on [Microsoft Entra Cloud Sync](what-is-cloud-sync.md) and complements the [user](/entra/identity/hybrid/user-source-of-authority-overview) and [group](/entra/identity/hybrid/concept-source-of-authority-overview) Source of Authority (SOA) capabilities.

Many organizations are adopting a cloud-first identity model but still rely on AD for application access. Provisioning from Microsoft Entra ID to AD bridges this gap by allowing administrators to:

- Manage identities directly in Microsoft Entra ID as the **source of authority**.
- Provision **cloud-native users, SOA-converted users, and guest business-to-business (B2B) users** into AD.
- Provision **security groups** and their memberships into AD.
- Maintain identity continuity by preserving key attributes such as the **security identifier (SID)**.
- Keep identity attributes and group memberships aligned between Microsoft Entra ID and AD.
- Ensure continued access to on-premises applications without disruption.

> [!NOTE]
> Provisioning **users** to Active Directory is currently in **preview**. Provisioning **groups** to Active Directory is generally available. For preview terms, see [Supplemental Terms of Use for Microsoft Azure Previews](https://azure.microsoft.com/support/legal/preview-supplemental-terms/).

## How it works

Microsoft Entra ID is the source of authority. The Microsoft Entra provisioning service detects changes and sends them, through the Cloud Sync provisioning agent, into the target AD domain.

:::image type="content" source="media/overview-provision-entra-id-to-active-directory/entra-id-to-active-directory-provisioning-flow.png" alt-text="Diagram showing the provisioning flow from Microsoft Entra ID through the provisioning service and Cloud Sync agent into Active Directory." lightbox="media/overview-provision-entra-id-to-active-directory/entra-id-to-active-directory-provisioning-flow.png":::

1. An administrator configures a provisioning configuration in the Microsoft Entra admin center.
1. The Microsoft Entra provisioning service detects object changes (creates, updates, deletes).
1. Changes are sent to the on-premises Cloud Sync provisioning agent.
1. The agent provisions user and group objects into the target Active Directory domain.

> [!NOTE]
> **Password writeback** (synchronizing password changes from Microsoft Entra ID to AD) isn't available.

For a detailed explanation of how the sync engine matches, provisions, and deletes objects, see [How provisioning to Active Directory works](how-provisioning-to-active-directory-works.md). To choose between provisioning groups only, users only, or both, see [Deployment options](concept-deployment-options-provision-to-active-directory.md).

## What you can provision

| Capability | Description |
| --- | --- |
| Combined users + groups configuration | A single configuration provisions both users and groups into the same AD domain. |
| Standalone user-only configuration | A dedicated configuration provisions only users. |
| Standalone group-only configuration | A dedicated configuration provisions only groups. |
| Cloud-native user provisioning | Users created in Microsoft Entra ID are provisioned into AD. |
| SOA-converted user provisioning | Users whose source of authority is converted to the cloud can still be provisioned to AD with continuity. |
| Guest (B2B) user provisioning | External users can be provisioned into AD. |
| Security group provisioning | Security groups from Microsoft Entra ID are provisioned into AD. |
| Group membership (cloud + synced users) | Groups support both cloud-only and synced user members. |
| Attribute updates (Entra ID → AD) | Attribute changes in Microsoft Entra ID flow to AD. |
| Directory extension attributes | Directory extensions tied to user and group accounts flow through to AD. See [Use directory extensions](tutorial-directory-extension-group-provisioning.md). |
| Provisioning logs and auditing | Logs are available for validation and troubleshooting. |

## Key behaviors

- **Cloud is the source of truth.** Changes made directly in AD might be overwritten by Microsoft Entra ID during the next sync cycle. To protect provisioned objects from on-premises changes, see [Configure AD user and group enforcement](how-to-active-directory-object-enforcement.md).
- **SOA-converted objects remain cloud-managed.** These users and groups can still be provisioned back into AD after conversion.
- **Match then create.** Existing objects are matched and updated; new objects are created only when no match is found.
- **Target OU behavior.** A default organizational unit (OU) is used unless overridden. A user whose SOA is converted to the cloud is returned to their original OU automatically. Groups aren't — to keep a converted group in its original OU, use a directory extension. See [Preserve the OU path](how-to-configure-entra-to-active-directory.md#preserve-the-ou-path).
- **Groups.** Only security groups are supported. On-premises user membership must be explicitly enabled.

## When to use provisioning to Active Directory

Provisioning to AD is the mechanism that supports several Source of Authority (SOA) scenarios. Rather than repeat those scenarios here, use the table to jump to the scenario that matches your goal:

| Goal | Scenario | Learn more |
| --- | --- | --- |
| Move group management to the cloud but keep AD access | Govern access with Microsoft Entra ID Governance; AD DS minimization | [Convert Group SOA to the cloud](../concept-source-of-authority-overview.md) |
| Move user management to the cloud but keep AD access | Minimize AD users and govern the user lifecycle | [Transfer user SOA to the cloud](../user-source-of-authority-overview.md) |
| Keep Kerberos app access after transferring user SOA | Provision users to AD; use passwordless (Windows Hello for Business / Cloud Kerberos Trust) | [Transfer user SOA to the cloud](../user-source-of-authority-overview.md) |
| Lock down provisioned groups so only the cloud can change them | AD group enforcement | [Configure AD user and group enforcement](how-to-active-directory-object-enforcement.md#mark-groups-for-enforcement) |
| Lock down provisioned users so only the cloud can change them | AD user enforcement | [Configure AD user and group enforcement](how-to-active-directory-object-enforcement.md#mark-users-for-enforcement) |

## What isn't supported

The following scenarios aren't supported:

- Provisioning the **same user to multiple AD domains**. A single target domain per user is enforced to ensure authentication consistency.
- Provisioning identities to **multiple forests that share the same domain name**.
- **Cross-forest** provisioning of user relationships (for example, manager or membership across forests).
- Provisioning **custom security attributes (CSA)** to AD.
- Provisioning **Exchange attributes** to AD. Because user SOA is in the cloud, Exchange-related information isn't needed in AD. For managing Exchange recipients without an on-premises Exchange Server, see [Decommission the last Exchange Server after transferring SOA to cloud](/exchange/hybrid-deployment/decommission-last-exchange-server) and [Manage recipients in Exchange hybrid environments using management tools](/exchange/manage-hybrid-exchange-recipients-with-management-tools).
- **Mail-enabled groups and distribution groups.** Only security groups are supported.
- **Password writeback**, which LDAP and password-based apps need. Cloud-managed users have no AD DS password to present, so use passwordless authentication for Kerberos-based applications instead.
- Complex **multi-domain hybrid identity architectures**. Provisioning to AD is designed for single-domain identity continuity.

## License requirements

Provisioning to Active Directory follows a configuration-based licensing model.

| Configuration | License required |
| --- | --- |
| **Existing configurations** (created before general availability) | No license change is required. These configurations continue to run under their existing Microsoft Entra ID P1 licensing. |
| First **2** new configurations per tenant | Microsoft Entra ID P1. |
| **More than 2** new configurations per tenant (3–20) | Microsoft Entra ID Governance. |

> [!NOTE]
> A maximum of **20** configurations (domains) can be configured per tenant.

## Next step

> [!div class="nextstepaction"]
> [Choose a deployment option](concept-deployment-options-provision-to-active-directory.md)

## Related content

- [How provisioning to Active Directory works](how-provisioning-to-active-directory-works.md)
- [Prerequisites](how-to-prerequisites-provision-entra-to-active-directory.md)
- [Configure provisioning to Active Directory](how-to-configure-entra-to-active-directory.md)
- [Test and enable provisioning](how-to-test-and-enable-provisioning-entra-to-active-directory.md)
- [What is Microsoft Entra Cloud Sync?](what-is-cloud-sync.md)
- [Transfer user Source of Authority (SOA) to the cloud](/entra/identity/hybrid/user-source-of-authority-overview)
- [Convert group Source of Authority (SOA) to the cloud](/entra/identity/hybrid/concept-source-of-authority-overview)
- [What is Microsoft Entra ID Governance?](/entra/id-governance/identity-governance-overview)
- [Road to the cloud: five states of transformation](/entra/architecture/road-to-the-cloud-posture)
