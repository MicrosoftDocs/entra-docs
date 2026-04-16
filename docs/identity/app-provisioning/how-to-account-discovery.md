---
title: Discover identities in target applications with Account Discovery (preview)
description: Learn how to use Account Discovery to find and categorize existing user accounts in target applications, match them to Microsoft Entra ID users, and prepare for provisioning governance.
ms.topic: how-to
ms.date: 04/16/2026
ms.author: jfields
author: jenniferf-skc
ms.reviewer: arvinh
ms.service: entra-id
ms.subservice: app-provisioning
ai-usage: ai-assisted

#Customer intent: As an IT administrator, I want to discover existing user accounts in target applications and match them to Microsoft Entra ID identities so I can identify unmanaged accounts and bring them under governance.

---

# Discover identities in target applications with Account Discovery (preview)

When organizations adopt Microsoft Entra ID for application provisioning, target applications often already contain user accounts that were created before provisioning was configured. Account Discovery helps you find these existing accounts, match them to Microsoft Entra ID users, and categorize them so you can bring unmanaged identities under governance. After onboarding to provisioning, application administrators can manually create accounts in the application. This report allows organizations to identify local or orphan accounts both during initial onboarding and after they have operationalized provisioning.

Account Discovery retrieves all user accounts from a target application and classifies them into three categories:

- **Local accounts** — Accounts in the target application that have no matching user in Microsoft Entra ID. These accounts might belong to former employees, service accounts, users who were provisioned through a different process, or accounts that didn't match due to data quality issues (for example, mismatched or outdated attribute values).
- **Unassigned users** — Accounts that match a Microsoft Entra ID user but the user isn't assigned to the enterprise application. These users exist in your directory but don't have the required application assignment for provisioning to manage them.
- **Assigned users** — Accounts that match a Microsoft Entra ID user who is assigned to the enterprise application. These accounts are fully managed by the provisioning service.

This classification gives you visibility into who has access to your applications and helps you identify accounts that should be governed, reassigned, or removed.

> [!IMPORTANT]
> The Account Discovery feature is currently in PREVIEW.
> This information relates to a prerelease product that might be substantially modified before release. Microsoft makes no warranties, expressed or implied, with respect to the information provided here.

## Prerequisites

Before you can use Account Discovery, the following must be in place:

- The [Microsoft Entra ID Governance](https://www.microsoft.com/security/business/identity-access/microsoft-entra-id-governance) add-on license or [Microsoft Entra Suite](https://www.microsoft.com/security/business/microsoft-entra-pricing). For details on feature availability by license, see [Microsoft Entra ID Governance licensing fundamentals](/entra/id-governance/licensing-fundamentals#features-by-license).
- An enterprise application configured for provisioning with valid credentials and a successful test connection.
- A **direct matching attribute mapping** configured between Microsoft Entra ID and the target application. Account Discovery uses the first matching attribute to correlate users between the two systems.
- One of the following roles: [Application Administrator](../../identity/role-based-access-control/permissions-reference.md#application-administrator), [Cloud Application Administrator](../../identity/role-based-access-control/permissions-reference.md#cloud-application-administrator), or [Hybrid Identity Administrator](../../identity/role-based-access-control/permissions-reference.md#hybrid-identity-administrator).

## Known limitations

- Account Discovery requires a **direct matching attribute** for user correlation. Expression-based transformations aren't supported for matching.
- If multiple matching attributes are configured, only the **first** matching attribute is used.
- See [Supported applications](#supported-applications) for applications that support Account Discovery. 

## Application support
For SCIM based connectors, account discovery requires that the application support [RFC 7644, Section 3.4.2.4](https://datatracker.ietf.org/doc/html/rfc7644#section-3.4.2.4).

### Connectors with established discovery behavior

Customers using account discovery with the following applications consistently receive complete discovery results:

- Atlassian Cloud  
- Salesforce  
- SAP Cloud Identity Services  

### Connectors that do not support discovery
Account Discovery is currently unsupported for the following applications:

- HR provisioning (Workday, SAP SuccessFactors, API-driven provisioning)
- ServiceNow  
- Amazon Web Services (AWS)
- Snowflake

### All other connectors

Account Discovery can be enabled for all other supported connectors. Discovery outcomes may vary depending on whether the target application supports listing users and pagination through its SCIM API. If you discovery report has 0 results, verify that you have configured a single direct matching attribute (no expressions) in your attribute mappings. Next, verify with the application vendor that the application supports pagination in accordance with section [3.4.2.4](https://datatracker.ietf.org/doc/html/rfc7644#section-3.4.2.4) of the SCIM standard. 

## Discover identities in a target application

To discover existing user accounts in a target application:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Application Administrator](../../identity/role-based-access-control/permissions-reference.md#application-administrator).
1. Browse to **Identity** > **Applications** > **Enterprise applications**.
1. Select the application you want to discover identities for.
1. In the left navigation, select **Provisioning**.
1. Verify that the provisioning configuration has valid credentials and a successful test connection.
1. Select **Discover identities**.

The provisioning service retrieves all user accounts from the target application and displays them organized by category. The discovery takes at least 30 minutes to generate a report. Note that the more accounts that are included in the target app, the longer the report takes. For example, an application with 250K accounts might take 12 hours or more to generate a discovery report.

## Review discovered accounts

After the discovery process completes, review the results in each category:

### Local accounts

Local accounts exist in the target application but have no matching user in Microsoft Entra ID. These accounts might represent:

- Former employees whose directory accounts were removed but whose application accounts weren't deprovisioned.
- Service accounts or shared accounts created directly in the application.
- Users provisioned through a separate process that didn't use Microsoft Entra ID.
- A scenario where there is a data quality issue preventing the match.

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

- Assign existing users to your access packages to govern access going forward, run reviews on the access packages to certify access, and configure lifecycle workflows to automate lifecycle management.
- Configure [entitlement management](/entra/id-governance/entitlement-management-overview) to govern who can request access to the application.
- Set up [lifecycle workflows](/entra/id-governance/what-are-lifecycle-workflows) to automate provisioning and deprovisioning based on user lifecycle events.

For more information about governing application access, see [Govern access for applications in your environment](/entra/id-governance/identity-governance-applications-prepare).

## Related content

- [Configure automatic user provisioning for an enterprise application](configure-automatic-user-provisioning-portal.md)
- [How application provisioning works in Microsoft Entra ID](how-provisioning-works.md)
- [Manage application unmatched users](application-provisioning-application-unmatched-users.md)
- [Customize application attribute mappings](customize-application-attributes.md)
- [What is provisioning with Microsoft Entra ID?](/entra/id-governance/what-is-provisioning)

## For application developers

For Account Discovery to work with a target application, the application must support SCIM pagination as described in [RFC 7644, Section 3.4.2.4](https://datatracker.ietf.org/doc/html/rfc7644#section-3.4.2.4). The provisioning service uses pagination to retrieve all user accounts from the target application during the discovery process.
