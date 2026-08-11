---
title: Discover identities in target applications with account discovery
description: Learn how to use account discovery to find and categorize existing user accounts in target applications, match them to Microsoft Entra ID users, and prepare for provisioning governance.
ms.topic: how-to
ms.date: 08/11/2026
ms.reviewer: arvinh
ms.service: entra-id
ms.subservice: app-provisioning
ai-usage: ai-assisted

#Customer intent: As an IT administrator, I want to discover existing user accounts in target applications and match them to Microsoft Entra ID identities so I can identify unmanaged accounts and bring them under governance.

---

# Discover identities in target applications with account discovery 

When organizations adopt Microsoft Entra ID for application provisioning, target applications often already contain user accounts that were created before provisioning was configured. Account discovery helps you find these existing accounts, match them to Microsoft Entra ID users, and categorize them so you can bring unmanaged identities under governance. After onboarding to provisioning, application administrators can manually create accounts in the application. This report allows organizations to identify local or orphan accounts both during initial onboarding and after they have operationalized provisioning.

Account discovery retrieves all user accounts from a target application and classifies them into three categories:

- **Local accounts** — Accounts in the target application that have no matching user in Microsoft Entra ID. These accounts might belong to former employees, service accounts, users who were provisioned through a different process, or accounts that didn't match due to data quality issues (for example, mismatched or outdated attribute values).
- **Unassigned users** — Accounts that match a Microsoft Entra ID user but the user isn't assigned to the enterprise application. These users exist in your directory but don't have the required application assignment for provisioning to manage them.
- **Assigned users** — Accounts that match a Microsoft Entra ID user who is assigned to the enterprise application. These accounts are fully managed by the provisioning service.

This classification gives you visibility into who has access to your applications and helps you identify accounts that should be governed, reassigned, or removed.

## Prerequisites

Before you can use account discovery, the following must be in place:

- The [Microsoft Entra ID Governance](https://www.microsoft.com/security/business/identity-access/microsoft-entra-id-governance) add-on license or [Microsoft Entra Suite](https://www.microsoft.com/security/business/microsoft-entra-pricing). For details on feature availability by license, see [Microsoft Entra ID Governance licensing fundamentals](/entra/id-governance/licensing-fundamentals#features-by-license).
- An enterprise application configured for provisioning with valid credentials and a successful test connection.
- A **direct matching attribute mapping** configured between Microsoft Entra ID and the target application. Account discovery uses the first matching attribute to correlate users between the two systems.
- One of the following roles: [Application Administrator](../../identity/role-based-access-control/permissions-reference.md#application-administrator), [Cloud Application Administrator](../../identity/role-based-access-control/permissions-reference.md#cloud-application-administrator), or [Hybrid Identity Administrator](../../identity/role-based-access-control/permissions-reference.md#hybrid-identity-administrator).

## Known limitations

- Account discovery requires a **direct matching attribute** for user correlation. Expression-based transformations aren't supported for matching.
- If multiple matching attributes are configured, only the **first** matching attribute is used.

## Application support

For SCIM-based connectors, account discovery requires that the application support [RFC 7644, Section 3.4.2.4](https://datatracker.ietf.org/doc/html/rfc7644#section-3.4.2.4).

### Connectors with established discovery behavior

Customers using account discovery with the following applications consistently receive complete discovery results:

- Atlassian Cloud
- SCIM
- Salesforce
- SAP Cloud Identity Services
- ECMA (enables support for on-premises applications through SQL, LDAP, web services, and PowerShell connectors)
- GitHub Enterprise Cloud (see [List SCIM provisioned identities](https://docs.github.com/enterprise-cloud@latest/rest/scim/scim?apiVersion=2026-03-10#list-scim-provisioned-identities) for limitations)

### Connectors that do not support discovery

Account discovery is currently unsupported for the following applications:

- HR provisioning (Workday, SAP SuccessFactors, API-driven provisioning)
- ServiceNow
- Amazon Web Services (AWS)
- Snowflake
- Cross-tenant synchronization
- Cloud sync
- Group provisioning to Active Directory

### All other connectors

Account discovery can be enabled for all other supported connectors. Discovery outcomes might vary depending on whether the target application supports listing users and pagination through its SCIM API. If your discovery report has zero results, verify that you configured a single direct matching attribute (no expressions) in your attribute mappings. Next, verify with the application vendor that the application supports pagination in accordance with [RFC 7644, Section 3.4.2.4](https://datatracker.ietf.org/doc/html/rfc7644#section-3.4.2.4).

## Discover identities in a target application

To discover existing user accounts in a target application:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Application Administrator](../../identity/role-based-access-control/permissions-reference.md#application-administrator).
1. Browse to **Identity** > **Applications** > **Enterprise applications**.
1. Select the application you want to discover identities for.
1. In the left navigation, select **Provisioning**.
1. Verify that the provisioning configuration has valid credentials and a successful test connection.
1. Select **Discover identities**.

The provisioning service retrieves all user accounts from the target application and displays them organized by category. The discovery takes at least 30 minutes to generate a report. The more accounts that are included in the target application, the longer the report takes. For example, an application with 250,000 accounts might take 12 hours or more to generate a discovery report.

## Review discovered accounts

After the discovery process completes, review the results in each category.

### Local accounts

Local accounts exist in the target application but have no matching user in Microsoft Entra ID. These accounts might represent:

- Former employees whose directory accounts were removed but whose application accounts weren't deprovisioned.
- Service accounts or shared accounts created directly in the application.
- Users provisioned through a separate process that didn't use Microsoft Entra ID.
- A data quality issue that prevents a match.

Review these accounts to determine whether they should be removed from the target application, matched to an existing Microsoft Entra ID user, or kept as-is.

### Unassigned users

Unassigned users match a Microsoft Entra ID user based on the matching attribute but aren't assigned to the enterprise application. To bring these accounts under provisioning management:

1. Navigate to the enterprise application's **Users and groups** page.
1. Assign the appropriate users or groups to the application.
1. After assignment, the provisioning service manages these accounts on subsequent provisioning cycles.

### Assigned users

Assigned users match a Microsoft Entra ID user who is already assigned to the application. These accounts are fully managed by the provisioning service. No action is needed unless you want to review or update their attribute mappings.

## Assign correlated users to your enterprise application and/or access packages

After [discovering](~/identity/app-provisioning/how-to-account-discovery.md) users in your application, you can assign those users to the enterprise application or an access package. [Download](https://aka.ms/AssignCorrelatedUsersPowerShell) the `Assign-CorrelatedUsers.ps1` file and run it in PowerShell 7.x to assign users.

### Optional parameters

| Parameter | Description |
|---|---|
| **`-DryRun`** | Shows what *would* happen without making any changes. |
| **`-SkipAppRoleAssignment`** | Only manages access packages and skips assigning app roles. |
| **Duplicate detection** | Checks for existing assignments before creating new ones. |
| **Client-side status filter** | Verifies that API results match the expected status to guard against API quirks. |
| **`-OutputFile`** | Creates a full audit trail as a CSV file with timestamps, actions, and error details. |
| **Strict mode** | Runs with `Set-StrictMode -Version Latest` and `$ErrorActionPreference = "Stop"` to fail fast on unexpected issues. |

### Example scenarios

Assign all correlated users to the enterprise application:

```powershell
pwsh -File '.\Assign-CorrelatedUsers.ps1' -ServicePrincipalId "7A22..."
```

Assign all correlated users to a specific access package by using an example [rules](https://aka.ms/AssignCorrelatedUsersCSV) file:

```powershell
pwsh -File '.\Assign-CorrelatedUsers.ps1' -ServicePrincipalId '7A22...' -RulesFile '.\access-package-rules-internal.csv' -DryRun -OutputFile '.\results-dryrun.csv'
```

Assign users to packages based on rules that you define:

```powershell
pwsh -ExecutionPolicy Bypass -File '.\Assign-CorrelatedUsers.ps1' -ServicePrincipalId "7A22..." -RulesFile ".\access-package-rules.csv"
```

Assign users to access packages with a fallback package for users who don't meet any of the defined rules:

```powershell
pwsh -ExecutionPolicy Bypass -File '.\Assign-CorrelatedUsers.ps1' -ServicePrincipalId "7A22..." -RulesFile ".\access-package-rules.csv" -AccessPackageId "fallback-pkg-id" -PolicyId "fallback-policy-id" -FallbackBehavior UseFallback
```

Assign users to access packages and skip application role assignments:

```powershell
pwsh -ExecutionPolicy Bypass -File '.\Assign-CorrelatedUsers.ps1' -ServicePrincipalId "7A22..." -RulesFile ".\access-package-rules.csv" -SkipAppRoleAssignment
```

### Rules file description

The rules file is a standard [CSV](https://aka.ms/AssignCorrelatedUsersCSV) with these columns:

| Column | Purpose |
|---|---|
| `RuleGroup` | Rows that share the same group number are ANDed together. Different groups are evaluated independently. |
| `PropertyName` | Key in the target SCIM property bag, such as `userType` or `urn:ietf:params:scim:schemas:extension:enterprise:2.0:User:department`. You can find property names in the discovery experience by selecting **View attributes** for an individual user or by reviewing your provisioning attribute mappings. |
| `Operator` | `eq`, `ne`, `contains`, `startswith`, `endswith`, or `regex`. |
| `Value` | The value to compare against. The comparison is case-insensitive. |
| `AccessPackageId` | The access package to assign when the group matches. You can find this value in the URL when you navigate to the access package in the Microsoft Entra admin center. |
| `PolicyId` | The assignment policy for the access package. You can find this value in the URL when you navigate to the access package in the Microsoft Entra admin center. |

## Integrate with Identity Governance

Account discovery works alongside [Microsoft Entra ID Governance](/entra/id-governance/identity-governance-overview) to help you manage the full identity lifecycle. After you discover identities in your target applications, you can:

- Assign existing users to your access packages to govern access going forward, run reviews on the access packages to certify access, and configure lifecycle workflows to automate lifecycle management.
- Configure [entitlement management](/entra/id-governance/entitlement-management-overview) to govern who can request access to the application.
- Set up [lifecycle workflows](/entra/id-governance/what-are-lifecycle-workflows) to automate provisioning and deprovisioning based on user lifecycle events.

For more information about governing application access, see [Govern access for applications in your environment](/entra/id-governance/identity-governance-applications-prepare).

## Retrieve results with Microsoft Graph

In addition to reviewing discovered accounts in the Microsoft Entra admin center, you can use Microsoft Graph to programmatically retrieve Account discovery results.

Use the Microsoft Graph beta API to:

- List identity correlation reports in the tenant.
- Retrieve a specific identity correlation report.
- List the identities included in a report.
- Filter identities by correlation status.

For API details, see the following resources:

- [identityCorrelation resource type](/graph/api/resources/identitycorrelation?view=graph-rest-beta)
- [List identity correlation reports](/graph/api/reportroot-list-correlations?view=graph-rest-beta)
- [List correlated identities](/graph/api/identitycorrelation-list-identities?view=graph-rest-beta)

> [!IMPORTANT]
> The identity correlation APIs are available on the Microsoft Graph beta endpoint. APIs under the beta endpoint are subject to change and aren't supported for use in production applications.

## Investigate account discovery with the Microsoft MCP Server for Enterprise (preview)

You can use the [Microsoft MCP Server for Enterprise](/graph/mcp-server/overview) to investigate account discovery reports by asking questions in natural language. The MCP server translates the question into a read-only Microsoft Graph request, enforces the signed-in user's privileges and the permissions granted to the MCP client, and returns a natural-language summary of the results.

This option is useful for administrators who want to explore account discovery results without constructing Microsoft Graph requests manually. The MCP client also displays the underlying request so that you can review and audit the operation.

### MCP prerequisites

Before using the MCP server with account discovery:

- [Provision Microsoft MCP Server for Enterprise and connect an MCP client](/graph/mcp-server/get-started).
- Grant the MCP client the `MCP.ProvisioningLog.Read.All` delegated permission.
- Sign in with a work or school account that has a supported Microsoft Entra role. Supported roles include Application Administrator, Cloud Application Administrator, Hybrid Identity Administrator, Global Reader, Reports Reader, Security Administrator, Security Operator, and Security Reader.
- Use the global Microsoft cloud. Microsoft MCP Server for Enterprise and the identity correlation APIs aren't currently available in sovereign clouds.

The MCP server supports delegated, user-interactive access only. It doesn't support app-only access.

### Example questions

After you connect your MCP client, you can ask questions such as:

- "Show me the most recent account discovery reports."
- "List account discovery reports for service principal `<service-principal-id>`."
- "Did the latest account discovery report complete without errors?"
- "Are any account discovery reports still in progress?"
- "Get identity correlation report `<report-id>`."
- "List the identities in identity correlation report `<report-id>`."
- "Which identities in report `<report-id>` are local accounts?"
- "Which identities in report `<report-id>` match Microsoft Entra users but don't have an application assignment?"
- "Which identities in report `<report-id>` failed to correlate?"

Depending on the question, the MCP server can execute requests such as:

```http
GET /beta/reports/correlations
GET /beta/reports/correlations/{identityCorrelationId}
GET /beta/reports/correlations/{identityCorrelationId}/identities
GET /beta/reports/correlations/{identityCorrelationId}/identities?$filter=status eq 'uncorrelated'
```

### Understand correlation statuses

The Microsoft Graph API represents the account discovery categories with the following correlation status values:

| Correlation category | Microsoft Graph status | Description |
|---|---|---|
| Assigned users | `correlatedAssigned` | The target identity matches an Entra user which is assigned to the enterprise application. |
| Unassigned users | `correlatedNotAssigned` |  The target identity matches an Entra user, but the Entra user is not assigned to the enterprise application. |
| Local accounts | `uncorrelated` | No corresponding Microsoft Entra ID user was found for the target identity. |
| Correlation failure | `failToCorrelate` | The correlation process couldn't evaluate the identity successfully. Review the error information returned for the identity. |

### Example investigation

The following conversation illustrates how an administrator might investigate a report:

1. Ask, "Show me the latest completed account discovery report for service principal `<service-principal-id>`."
1. Copy the report ID returned by the MCP client.
1. Ask, "List the identities in identity correlation report `<report-id>`."
1. Ask another question that includes the report ID, such as, "Which identities in report `<report-id>` are local accounts?" or "Which identities in report `<report-id>` failed to correlate?"

Review the Microsoft Graph request displayed by the MCP client before relying on the result. For large reports, the client might need to follow `@odata.nextLink` to retrieve additional pages.

### MCP troubleshooting

If the MCP client can't retrieve account discovery results:

- Confirm that the MCP client has the `MCP.ProvisioningLog.Read.All` delegated permission.
- Confirm that the signed-in user has a supported Microsoft Entra role.
- Confirm that the account is signed in to the tenant that contains the account discovery report.
- Review the request and response displayed by the MCP client.
- Check Microsoft Graph activity logs for requests made by Microsoft MCP Server for Enterprise. Filter the logs by MCP server app ID `e8c77dc2-69b3-43f4-bc51-3213c9d915b4`.

The MCP server forwards supported requests to Microsoft Graph. Microsoft Graph API behavior and beta limitations also apply to requests made through the MCP server.

## Filter and search results

Use the search and filter capabilities to find specific accounts:

- Search for accounts by name or attribute values.
- Filter results by category (local, unassigned, or assigned).
- Manage columns to view the imported attributes from the target application and the correlation status.

## Related content

- [Configure automatic user provisioning for an enterprise application](configure-automatic-user-provisioning-portal.md)
- [How application provisioning works in Microsoft Entra ID](how-provisioning-works.md)
- [Manage application unmatched users](application-provisioning-application-unmatched-users.md)
- [Customize application attribute mappings](customize-application-attributes.md)
- [What is provisioning with Microsoft Entra ID?](/entra/id-governance/what-is-provisioning)
- [Overview of Microsoft MCP Server for Enterprise](/graph/mcp-server/overview)
- [Get started with Microsoft MCP Server for Enterprise](/graph/mcp-server/get-started)

## For application developers

For account discovery to work with a target application, the application must support SCIM pagination as described in [RFC 7644, Section 3.4.2.4](https://datatracker.ietf.org/doc/html/rfc7644#section-3.4.2.4). The provisioning service uses pagination to retrieve all user accounts from the target application during the discovery process.
