---
title: Discover identities in target applications with Account Discovery (preview)
description: Learn how to use Account Discovery to find and categorize existing user accounts in target applications, match them to Microsoft Entra ID users, and prepare for provisioning governance.
ms.topic: how-to
ms.date: 03/18/2026
ms.author: jfields
author: jenniferf-skc
ms.reviewer: arvinh
ms.service: entra-id
ms.subservice: app-provisioning
ai-usage: ai-assisted

#Customer intent: As an IT administrator, I want to discover existing user accounts in target applications and match them to Microsoft Entra ID identities so I can identify unmanaged accounts and bring them under governance.

---

# Discover identities in target applications with Account Discovery (preview)

When organizations adopt Microsoft Entra ID for application provisioning, target applications often already contain user accounts that were created before provisioning was configured. Account Discovery helps you find these existing accounts, match them to Microsoft Entra ID users, and categorize them so you can bring unmanaged identities under governance.

Account Discovery retrieves all user accounts from a target application and classifies them into three categories:

- **Local accounts** — Accounts in the target application that have no matching user in Microsoft Entra ID. These accounts might belong to former employees, service accounts, or users who were provisioned through a different process.
- **Unassigned users** — Accounts that match a Microsoft Entra ID user but the user isn't assigned to the enterprise application. These users exist in your directory but don't have the required application assignment for provisioning to manage them.
- **Assigned users** — Accounts that match a Microsoft Entra ID user who is assigned to the enterprise application. These accounts are fully managed by the provisioning service.

This classification gives you visibility into who has access to your applications and helps you identify accounts that should be governed, reassigned, or removed.

> [!IMPORTANT]
> The Account Discovery feature is currently in PREVIEW.
> This information relates to a prerelease product that might be substantially modified before release. Microsoft makes no warranties, expressed or implied, with respect to the information provided here.

## Prerequisites

Before you can use Account Discovery, the following must be in place:

- A Microsoft Entra ID P1 or P2 license. For details, see [Microsoft Entra plans and pricing](https://www.microsoft.com/security/business/microsoft-entra-pricing).
- An enterprise application configured for provisioning with valid credentials and a successful test connection.
- A **direct matching attribute mapping** configured between Microsoft Entra ID and the target application. Account Discovery uses the first matching attribute to correlate users between the two systems.
- One of the following roles: [Application Administrator](../../identity/role-based-access-control/permissions-reference.md#application-administrator) or [Cloud Application Administrator](../../identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).

## Known limitations

- Account Discovery requires a **direct matching attribute** for user correlation. Expression-based transformations aren't supported for matching.
- If multiple matching attributes are configured, only the **first** matching attribute is used.
- Account Discovery isn't supported for the following application types:
  - Workday
  - SAP SuccessFactors
  - API-driven provisioning apps
  - ServiceNow
  - Exchange Web Services (EWS)

## Supported applications

Account Discovery is validated for the following applications:

- SAP Cloud Identity Services
- Salesforce

Other SCIM-based and gallery applications that support provisioning are enabled for Account Discovery but aren't formally certified. You can test Account Discovery with these applications at your discretion.

## Discover identities in a target application

To discover existing user accounts in a target application:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Application Administrator](../../identity/role-based-access-control/permissions-reference.md#application-administrator).
1. Browse to **Identity** > **Applications** > **Enterprise applications**.
1. Select the application you want to discover identities for.
1. In the left navigation, select **Provisioning**.
1. Verify that the provisioning configuration has valid credentials and a successful test connection.
1. Select **Discover identities**.

The provisioning service retrieves all user accounts from the target application and displays them organized by category.

## Review discovered accounts

After the discovery process completes, review the results in each category:

### Local accounts

Local accounts exist in the target application but have no matching user in Microsoft Entra ID. These accounts might represent:

- Former employees whose directory accounts were removed but whose application accounts weren't deprovisioned.
- Service accounts or shared accounts created directly in the application.
- Users provisioned through a separate process that didn't use Microsoft Entra ID.

Review these accounts to determine whether they should be removed from the target application, matched to an existing Microsoft Entra ID user, or kept as-is.

### Unassigned users

Unassigned users match a Microsoft Entra ID user based on the matching attribute but aren't assigned to the enterprise application. To bring these accounts under provisioning management:

1. Navigate to the enterprise application's **Users and groups** page.
1. Assign the appropriate users or groups to the application.
1. After assignment, the provisioning service manages these accounts on subsequent provisioning cycles.

### Assigned users

Assigned users match a Microsoft Entra ID user who is already assigned to the application. These accounts are fully managed by the provisioning service. No action is needed unless you want to review or update their attribute mappings.

## Filter and search results

Use the search and filter capabilities to find specific accounts:

- Search for accounts by name or attribute values.
- Filter results by category (local, unassigned, or assigned).
- Manage columns to view the imported attributes from the target application and the correlation status.

## Integrate with Identity Governance

Account Discovery works alongside [Microsoft Entra ID Governance](/entra/id-governance/identity-governance-overview) to help you manage the full identity lifecycle. After you discover identities in your target applications, you can:

- Use [access reviews](/entra/id-governance/access-reviews-overview) to determine whether local accounts should retain access.
- Configure [entitlement management](/entra/id-governance/entitlement-management-overview) to govern who can request access to the application.
- Set up [lifecycle workflows](/entra/id-governance/what-are-lifecycle-workflows) to automate provisioning and deprovisioning based on user lifecycle events.

For more information about governing application access, see [Govern access for applications in your environment](/entra/id-governance/identity-governance-applications-prepare).

## Related content

- [Configure automatic user provisioning for an enterprise application](configure-automatic-user-provisioning-portal.md)
- [How application provisioning works in Microsoft Entra ID](how-provisioning-works.md)
- [Manage application unmatched users](application-provisioning-application-unmatched-users.md)
- [Customize application attribute mappings](customize-application-attributes.md)
- [What is provisioning with Microsoft Entra ID?](/entra/id-governance/what-is-provisioning)
