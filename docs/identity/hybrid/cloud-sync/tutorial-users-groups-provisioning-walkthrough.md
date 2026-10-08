---
layout: Conceptual
title: "Tutorial: Govern access to an on-premises app (Preview)"
canonicalUrl: https://learn.microsoft.com/en-us/entra/identity/hybrid/cloud-sync/tutorial-users-groups-provisioning-walkthrough
uhfHeaderId: MSDocsHeader-Entra
breadcrumb_path: /entra/breadcrumb/toc.json
author: dhanyahk
ms.author: dhanyahk
ms.reviewer: marshmacy
ms.service: entra-id
manager: pmwongera
description: Provision cloud-managed users and a security group to Active Directory with Microsoft Entra Cloud Sync, so cloud group members can sign in to a Kerberos app.
ms.topic: tutorial
ms.date: 08/20/2026
ms.subservice: hybrid-cloud-sync
ms.custom: no-azure-ad-ps-ref, msecd-doc-authoring-1023
ai-usage: ai-assisted
#customer intent: As a hybrid identity administrator, I want to provision cloud-managed users and their group membership to Active Directory so that I can govern access to an on-premises Kerberos application from Microsoft Entra ID.
---

# Tutorial: Govern access to an on-premises app from Microsoft Entra ID (preview)

Contoso runs an expense application on-premises. The application uses Windows Integrated Authentication, so it authenticates users with Kerberos and authorizes them by checking their membership in an Active Directory Domain Services (AD DS) security group.

The identity team manages people in Microsoft Entra ID and wants to govern access to that application from the cloud: add someone to a cloud group, and they can use the expense app. The **Expense approvers** group in Microsoft Entra ID already holds the right people, but its membership is mixed. Some members synchronize from AD DS, and some were created in the cloud and never had an AD DS account.

That mix is the problem. A member reference can be written to an AD DS group only when the member has an AD DS account to point to. The synchronized members have one. The cloud-managed members don't, so the application never sees them and they can't approve expenses.

In this tutorial you provision the cloud-managed users into AD DS along with the group and its membership. The application keeps authorizing the way it always has, while Microsoft Entra ID becomes the place you decide who gets access.

In this tutorial, you:

> [!div class="checklist"]
> * Review the objects involved and why cloud-managed members lack access today.
> * Create a provisioning configuration and bring the group into scope.
> * Validate the result with on-demand provisioning before you enable anything.
> * Verify in AD DS that the accounts and the group membership were created.
> * Understand how cloud-managed users sign in to the application without an AD DS password.
> * Lock the provisioned objects so they can be changed only from Microsoft Entra ID.
> * Return a user or group to on-premises management.

> [!IMPORTANT]
> Provisioning **users** to Active Directory is currently in preview.

## Prerequisites

Complete the [prerequisites and license requirements](how-to-prerequisites-provision-entra-to-active-directory.md).

## The objects in this scenario

This tutorial uses the following objects. Substitute equivalents from your own tenant.

| Object | Type | Starting state |
| --- | --- | --- |
| Britta Simon | User, synchronized from AD DS | Has an AD DS account. Already reaches the expense app. |
| Lola Jacobson | User, synchronized from AD DS | Has an AD DS account. Already reaches the expense app. |
| Ada Whitfield | User, cloud-managed, `department` is `Finance` | No AD DS account. Can't reach the expense app. |
| Marco Trevisan | User, cloud-managed, `department` is `Finance` | No AD DS account. Can't reach the expense app. |
| Expense approvers | Security group in Microsoft Entra ID | Contains all four users. Not present in AD DS. |

The following organizational units (OUs) exist in AD DS:

| Display name | Distinguished name |
| --- | --- |
| Finance | OU=Finance,DC=contoso,DC=com |
| Groups | OU=Groups,DC=contoso,DC=com |

## Understand what's missing today

Before you change anything, confirm the gap you're closing.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Hybrid Identity Administrator](../../role-based-access-control/permissions-reference.md#hybrid-identity-administrator).
1. Browse to **Entra ID** > **Groups** > **All groups** and select **Expense approvers**.
1. Select **Members** and note which members synchronize from AD DS and which are cloud-managed. The **On-premises sync enabled** column distinguishes them.
1. Sign in to your on-premises environment and open **Active Directory Users and Computers**. Confirm that Ada Whitfield and Marco Trevisan have no account, and that no **Expense approvers** group exists.

At this point the cloud group is the system of record for who should approve expenses, but AD DS can't act on it.

## Create the provisioning configuration

A domain supports a single configuration, so you bring both object types into one configuration rather than creating a separate configuration for each.

1. Browse to **Entra ID** > **Entra Connect** > **Cloud sync**.
1. Select **New configuration** > **Microsoft Entra ID to AD sync**.
1. Select your domain, and then select **Create**.

The **Get started** screen opens.

## Bring the group and its members into scope

Scoping determines which objects are provisioned, and you have two ways to define it. The choice also determines whether attribute value filtering is available.

| Scope | Choose it when |
| --- | --- |
| **Selected users and groups** | You want the best performance and the fastest sync cycles. The service evaluates only the objects you pick, so each cycle does less work. Don't add attribute value filters in this mode — your selection already determines the scope. |
| **All users and groups** | You need to scope at scale, or the set of objects changes over time. Attribute value filtering keeps the scope current as people join, move, and leave, without maintaining a hand-picked list. Always add at least one attribute filter in this mode. |

For tenant-size thresholds and the object counts each mode supports, see [Performance and scale limits](concept-deployment-options-provision-to-active-directory.md#performance-and-scale-limits).

Select **Add scoping filters**, or select **Scoping filters** on the left under **Manage**, and then select **Edit**. Then follow the tab that matches your choice.

# [Selected users and groups](#tab/selected)

Selecting the group brings the group into scope, and its members are provisioned along with it.

1. On the **Scope by assignment** tab, set the scope to **Selected users and groups**.
1. Select the **Expense approvers** group.

This is the fastest option to sync, because only the objects you select are evaluated each cycle. To add someone later, add them to the group in Microsoft Entra ID.

# [All users and groups](#tab/all)

Attribute value filtering scopes by attribute value, so the scope keeps up with membership changes on its own.

1. On the **Scope by assignment** tab, set the scope to **All users and groups**, and then select **Next** to open the **Scope by attribute** tab.
1. Under the **Users** object type, select **Add Attribute scoping filter** and configure:

    - **Name**: `Finance users`
    - **Attribute**: `department`
    - **Operator**: `EQUALS`
    - **Value**: `Finance`

    Ada Whitfield and Marco Trevisan match the filter and are provisioned, because they're cloud-managed. Britta Simon and Lola Jacobson aren't provisioned even if they also match, because their Source of Authority (SOA) is on-premises and Active Directory remains authoritative for them. They already have the AD DS accounts that the group references.

1. Under the **Groups** object type, add a filter that selects the group, for example **displayName** `EQUALS` `Expense approvers`.
1. Select **Save**.

Clauses within one filter combine with `AND`, and multiple filters combine with `OR`. For the operator list and regular-expression filtering, see [Attribute value filtering](how-to-configure-entra-to-active-directory.md#attribute-value-filtering).

---

Whichever scope you chose, finish the wizard:

1. In the **Configure group membership** step, turn on provisioning membership to on-premises users.

    > [!IMPORTANT]
    > This setting is off by default. Without it, the member references for Britta Simon and Lola Jacobson aren't written to the AD DS group. For more information, see [Group membership to on-premises users](how-to-configure-entra-to-active-directory.md#group-membership-to-on-premises-users).

1. Set the target containers:

    - **Users** — a cloud-managed user has no `onPremisesDistinguishedName`, so they're created in the default container `CN=Users,DC=contoso,DC=com`. Override it with `OU=Finance,DC=contoso,DC=com` to place them with the rest of Finance.
    - **Groups** — set a constant `parentDistinguishedName` of `OU=Groups,DC=contoso,DC=com`.

    > [!NOTE]
    > These defaults differ by object type on purpose. A user whose Source of Authority is converted to the cloud returns to their original OU automatically, because the default mapping reads `onPremisesDistinguishedName`. Groups have no equivalent, so to keep a converted group in the OU it already occupies, see [Preserve a group's organizational unit and name](how-to-preserve-group-organizational-unit-entra-to-active-directory.md).

1. Select **Save**.

## Validate with on-demand provisioning

Test before you enable. On-demand provisioning applies your configuration to a small set of objects and shows each step the engine took, without turning the job on.

1. Open your configuration and select **Provision on demand**.
1. Select **Ada Whitfield**, and then select **Provision**.
1. Review the step results. The import, scope determination, matching, and export steps should all succeed, and the export step should show a create action.
1. Repeat for the **Expense approvers** group.

If an object is skipped, the scope-determination step explains why. For the full procedure, see [Test and enable provisioning](how-to-test-and-enable-provisioning-entra-to-active-directory.md).

## Enable the configuration

When the on-demand results look correct, select **Overview** > **Review and enable** > **Enable configuration**. Provisioning then runs on its recurring schedule.

## Verify the result in AD DS

Confirm that both halves of the scenario landed.

1. In **Active Directory Users and Computers**, open `OU=Finance,DC=contoso,DC=com`. Ada Whitfield and Marco Trevisan now have AD DS accounts.
1. Open `OU=Groups,DC=contoso,DC=com`. The **Expense approvers** group exists.
1. Open the group's **Members** tab. All four users appear:

    - Britta Simon and Lola Jacobson, because they already had AD DS accounts.
    - Ada Whitfield and Marco Trevisan, because provisioning created their accounts, which made their member references writable.

**Result:** the cloud group now drives authorization in AD DS. Adding someone to **Expense approvers** in Microsoft Entra ID provisions them and grants access on the next cycle. Removing them reverses it.

## How cloud-managed users sign in to the application

The provisioned AD DS account exists so that Kerberos works. It isn't a second identity that users manage separately, and they don't need an AD DS password.

Ada Whitfield signs in to Microsoft Entra ID with a passwordless method such as Windows Hello for Business or a FIDO2 security key. With [Cloud Kerberos Trust](/windows/security/identity-protection/hello-for-business/deploy/hybrid-cloud-kerberos-trust) configured, Microsoft Entra ID issues a Kerberos ticket for the on-premises domain, and the expense application accepts it and authorizes her through her membership in the AD DS group that provisioning maintains.

Because authentication happens in the cloud, on-premises access also picks up multifactor authentication and Conditional Access policies.

> [!IMPORTANT]
> This works for applications that use Kerberos. Applications that require a password directly, such as LDAP bind or Kerberos with a password, aren't supported for cloud-managed users, because there's no AD DS password to present.

## Lock the objects so changes come only from Microsoft Entra ID

Provisioning makes Microsoft Entra ID the place you decide access, but an on-premises administrator can still edit the provisioned account or group directly in AD DS. AD object enforcement closes that gap, so a marked object accepts changes only from the provisioning service.

1. Prepare your domain controllers and install the enforcement policy. This is a one-time setup per domain, and every writable domain controller must be enabled before you rely on it. See [Configure AD user and group enforcement](how-to-active-directory-object-enforcement.md).
1. Mark the provisioned users and the **Expense approvers** group for enforcement.
1. Try renaming the group in **Active Directory Users and Computers**. The change is blocked, and the attempt is recorded in the event log.

> [!TIP]
> Install the policy in **Audit** mode first. Audit mode records what would have been blocked without blocking anything, so you can find scripts and scheduled tasks that still write to these objects before you switch to **Enforced**.

With enforcement on, Microsoft Entra ID is the sole source of authority for the object in practice, not just by convention.

## Manage the user lifecycle from the cloud

This tutorial starts with users who already exist in Microsoft Entra ID. In a full deployment the lifecycle starts earlier, and provisioning to AD DS becomes the last step in a chain that begins with your HR system:

1. **Joiner.** Your HR system provisions the user into Microsoft Entra ID, so the HR record is the source of truth for who exists. See [HR-driven provisioning](../../app-provisioning/what-is-hr-driven-provisioning.md).
1. **Access assignment.** [Entitlement management](/entra/id-governance/entitlement-management-overview) grants the person an access package, or a dynamic group rule adds them, which puts them in **Expense approvers**.
1. **Provisioning to AD DS.** The user is created in AD DS and the member reference is written, so the expense application authorizes them.
1. **Mover.** An attribute change in HR flows to Microsoft Entra ID and on to AD DS on the next cycle. If the change removes them from the group, their application access is removed too.
1. **Leaver.** HR marks the termination, [lifecycle workflows](/entra/id-governance/what-are-lifecycle-workflows) run the offboarding tasks, and the AD DS account is disabled. For the full delete and disable behavior, see [How deletes work](how-provisioning-to-active-directory-works.md#how-deletes-work).

Two governance controls are worth adding once this runs:

- [Access reviews](/entra/id-governance/access-reviews-overview) re-justify membership on a schedule, and removals reach the application automatically.
- Publishing the group in an access package lets people request expense-approver access instead of emailing an administrator.

The result is that no part of this lifecycle requires an administrator to touch Active Directory. For more detail on this pattern, see [Govern on-premises Active Directory based apps (Kerberos) using Microsoft Entra ID Governance](govern-on-premises-groups.md).

## Return a user or group to on-premises management

If you converted an object's Source of Authority to the cloud and want AD DS to own it again, roll the conversion back. Provisioning stops syncing the object and removes it from scope. The on-premises object **isn't deleted**, and on-premises control resumes on the next sync cycle.

1. Roll back the object's Source of Authority so AD DS owns it again.
1. In **Audit logs**, confirm that sync no longer runs for the object because it's managed on-premises.
1. In **Active Directory Users and Computers**, confirm the object is still present and wasn't deleted.

The object is removed from the configuration scope automatically. No manual scope change is needed.

To stop provisioning an object without a Source of Authority change, remove it from the configuration's scope instead.

## What provisioning produces

- Objects are created, or matched and updated, in the target OU based on your scope and attribute mappings.
- Changes in Microsoft Entra ID flow to AD DS on the recurring schedule. For a Source of Authority converted object, changing a managed attribute directly in AD DS causes Cloud Sync to skip the object. For more information, see [Cloud skips changes made in AD after SOA conversion](how-to-configure-entra-to-active-directory.md#cloud-skips-changes-made-in-ad-after-soa-conversion).
- For the full matching, update, and delete behavior, see [How provisioning to Active Directory works](how-provisioning-to-active-directory-works.md).

## Next step

> [!div class="nextstepaction"]
> [Configure AD user and group enforcement](how-to-active-directory-object-enforcement.md)

## Related content

- [Overview of provisioning from Microsoft Entra ID to Active Directory](overview-provision-entra-id-to-active-directory.md)
- [Deployment options for provisioning to Active Directory](concept-deployment-options-provision-to-active-directory.md)
- [Configure provisioning to Active Directory](how-to-configure-entra-to-active-directory.md)
- [Test and enable provisioning](how-to-test-and-enable-provisioning-entra-to-active-directory.md)
- [How provisioning to Active Directory works](how-provisioning-to-active-directory-works.md)
- [Govern on-premises Active Directory based apps (Kerberos) using Microsoft Entra ID Governance](govern-on-premises-groups.md)
- [Transfer user Source of Authority (SOA) to the cloud](/entra/identity/hybrid/user-source-of-authority-overview)
