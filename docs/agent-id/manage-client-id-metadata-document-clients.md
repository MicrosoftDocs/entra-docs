---
title: Manage CIMD clients in Microsoft Entra ID
titleSuffix: Microsoft Entra Agent ID
description: Add, approve, find, monitor, and remove Client ID Metadata Document clients in Microsoft Entra ID.
ms.topic: how-to
ms.date: 09/21/2026
ai-usage: ai-assisted

#customer-intent: As an Entra administrator, I want to control and monitor CIMD clients in my tenant so that users can connect approved MCP clients without bypassing organizational consent and security policies.
---

# Manage CIMD clients in Microsoft Entra ID (preview)

Microsoft Entra ID represents a client discovered through a Client ID Metadata Document (CIMD) as an agent identity in your tenant. You can add a trusted CIMD client in advance, grant delegated permissions, monitor its activity, and disable or delete it by using the same management surfaces used for other agent identities.

> [!IMPORTANT]
> Client ID Metadata Document support in Microsoft Entra ID is in public preview. This preview is provided without a service-level agreement and isn't recommended for production workloads. Some features might be unsupported or have constrained capabilities. For more information, see [Universal License Terms for Online Services](https://www.microsoft.com/licensing/terms/product/ForOnlineServices/all).

Before enabling CIMD scenarios, review [Client ID Metadata Documents in Microsoft Entra ID](client-id-metadata-documents.md), including the limitations and governance considerations.

## Prerequisites

To manage CIMD clients, you need:

- A Microsoft Entra tenant in which CIMD support is available.
- The CIMD URL supplied by the client owner.
- An account with a role that can create agent identities, such as **Global Administrator**, **Agent ID Administrator**, **AI Administrator**, or **Agent ID Developer**.
- Administrator consent for the Microsoft Graph permissions used by any automation:
  - `AgentIdentity.Create.All` to create a CIMD-backed agent identity.
  - `AgentIdentity.Read.All` to read and list agent identities.
- To change consent policy programmatically:
  - The **Privileged Role Administrator** role.
  - `Policy.ReadWrite.PermissionGrant` to create or update a permission grant policy.
  - `Policy.ReadWrite.Authorization` to assign a permission grant policy to the default user role.

Use the least-privileged role and permissions that meet your requirements.

## Choose a tenant posture

Before you configure CIMD, decide who can add a new CIMD client to your tenant.

| Approach | Behavior | Consider when |
| --- | --- | --- |
| Administrator-curated | Disable user-initiated CIMD use. An administrator reviews each client, creates its agent identity, and grants the required permissions. | Your organization requires a security or application-onboarding review before creating an identity. |
| Policy-controlled user consent | Let users add CIMD clients when the client and requested delegated permissions satisfy consent policy. Permissions outside the policy still require an administrator. | Your organization permits low-risk self-service integrations and monitors newly created identities. |

Both postures use consent policy to control user-initiated creation. Neither posture automatically grants a CIMD client access to every resource. Consent grants and tenant policy continue to determine which delegated permissions the client can use.

### Disable user-initiated CIMD use

To prevent users from adding CIMD clients:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as a **Global Administrator**.
1. Browse to **Entra ID** > **Enterprise apps** > **Consent and permissions** > **User consent settings**.
1. Disable **Allow user consent for unregistered apps and agents using Client ID Metadata Documents**.
1. Select **Save**.

When user consent for CIMD clients is disabled, users can't approve a new CIMD client themselves. During preview, the admin consent request workflow is disabled for Agent ID, including CIMD clients. Arrange a manual handoff: the user or client owner supplies the CIMD URL, target resource, and requested delegated scopes to an administrator, who adds the client and grants the required permissions before the user retries.

Disabling user consent doesn't delete existing CIMD-backed agent identities or revoke existing consent grants. Review and revoke those grants separately if you want to stop use of clients that are already approved.

### Enable user-initiated CIMD use with a custom consent policy

Use a custom permission grant policy when you want users to add CIMD clients and consent to a controlled set of permissions. The following Microsoft Graph PowerShell example:

1. Creates a CIMD-specific permission grant policy.
1. Adds an include condition that allows delegated permissions classified as low impact.
1. Assigns the policy to the default user role without removing existing policy assignments.

The CIMD condition is available on the Microsoft Graph beta endpoint.

```powershell
Connect-MgGraph -Scopes @(
    "Policy.ReadWrite.PermissionGrant",
    "Policy.ReadWrite.Authorization"
)

$policyId = "contoso-user-consent-cimd-low"

# Create a custom permission grant policy for CIMD clients.
$policy = @{
    id = $policyId
    displayName = "Allow low-impact user consent for CIMD clients"
    description = "Users can consent to delegated permissions classified as low impact for CIMD clients."
}

Invoke-MgGraphRequest `
    -Method POST `
    -Uri "https://graph.microsoft.com/beta/policies/permissionGrantPolicies" `
    -Body ($policy | ConvertTo-Json)

# Add an include condition that matches only CIMD clients.
$condition = @{
    permissionType = "delegated"
    permissionClassification = "low"
    resourceApplication = "any"
    permissions = @("all")
    clientApplicationIds = @("all")
    clientApplicationTenantIds = @("all")
    clientApplicationPublisherIds = @("all")
    clientApplicationsFromVerifiedPublisherOnly = $false
    cimdClientApplications = @{
        "@odata.type" = "#microsoft.graph.allCimdClientApplications"
    }
}

Invoke-MgGraphRequest `
    -Method POST `
    -Uri "https://graph.microsoft.com/beta/policies/permissionGrantPolicies/$policyId/includes" `
    -Body ($condition | ConvertTo-Json -Depth 4)

# Preserve existing assignments and add the CIMD-specific policy.
$authorizationPolicy = Invoke-MgGraphRequest `
    -Method GET `
    -Uri "https://graph.microsoft.com/v1.0/policies/authorizationPolicy"

$assignments = @(
    $authorizationPolicy.defaultUserRolePermissions.permissionGrantPoliciesAssigned
)
$assignmentId = "managePermissionGrantsForSelf.$policyId"

if ($assignments -notcontains $assignmentId) {
    $assignments += $assignmentId
}

$update = @{
    defaultUserRolePermissions = @{
        permissionGrantPoliciesAssigned = $assignments
    }
}

Invoke-MgGraphRequest `
    -Method PATCH `
    -Uri "https://graph.microsoft.com/v1.0/policies/authorizationPolicy" `
    -Body ($update | ConvertTo-Json -Depth 4)
```

If you already have a custom policy for user consent, add the CIMD include condition to that policy instead of creating another policy. Don't edit a Microsoft-managed policy; built-in policies can't be changed.

The example uses `permissionClassification = "low"`. Only permissions classified as low impact can be granted under this condition. Review your tenant's [permission classifications](/entra/identity/enterprise-apps/configure-permission-classifications) before assigning the policy.

To verify the update, list the policy's include conditions and confirm that the authorization policy contains the assignment:

```http
GET https://graph.microsoft.com/beta/policies/permissionGrantPolicies/contoso-user-consent-cimd-low/includes

GET https://graph.microsoft.com/v1.0/policies/authorizationPolicy
```

To disable this custom CIMD policy later, remove `managePermissionGrantsForSelf.contoso-user-consent-cimd-low` from `permissionGrantPoliciesAssigned` and update the authorization policy again. Preserve every unrelated assignment in the collection.

For more information about how include and exclude condition sets are evaluated, see [Manage app consent policies](/entra/identity/enterprise-apps/manage-app-consent-policies).

## Add a CIMD client in the admin center

In the administrator-curated posture, review a client and create its agent identity before users connect.

> [!IMPORTANT]
> CIMD verifies control of a URL. It doesn't establish that the client is trustworthy. Review the client owner, document URL, redirect URIs, requested permissions, and business purpose before approval.

To add a trusted client before a user connects:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com).
1. Browse to **Entra ID** > **Agents** > **Agent identities**.
1. Select **Add CIMD client (Preview)**.
1. Enter the client's CIMD URL and continue.
1. Review the metadata retrieved from the document.
1. Complete the creation process.
1. [Grant only the delegated permissions required by the protected resource](grant-agent-access-microsoft-365.md). During preview, use the sign-in and consent endpoints or Microsoft Graph, not the portal permissions experience.

Creating the identity doesn't by itself authorize access to every resource. Consent grants and tenant policy continue to determine which delegated permissions the client can use.

## Add a CIMD client with Microsoft Graph

You can create the tenant-local agent identity by using the Microsoft Graph beta endpoint.

```http
POST https://graph.microsoft.com/beta/servicePrincipals/microsoft.graph.agentIdentity
Authorization: Bearer {token}
Content-Type: application/json

{
  "displayName": "Contoso Agent",
  "clientIdMetadataDocumentUrl": "https://client.contoso.com/oauth/client-metadata.json"
}
```

Microsoft Entra ID retrieves and validates the document before creating the identity. A successful response resembles:

```json
{
  "@odata.type": "#microsoft.graph.agentIdentity",
  "id": "11111111-2222-3333-4444-555555555555",
  "agentIdentityBlueprintId": "aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee",
  "displayName": "Contoso Agent",
  "clientIdMetadataDocumentUrl": "https://client.contoso.com/oauth/client-metadata.json",
  "isClientIdMetadataDocument": true
}
```

The `agentIdentityBlueprintId` value is derived for identity and correlation purposes. Creating a CIMD client doesn't create a separately manageable agent identity blueprint.

The request fails if the URL isn't HTTPS, the document can't be retrieved or validated, its `client_id` doesn't exactly match the URL, or the canonical URL already identifies another agent identity in the tenant.

## Find CIMD clients with Microsoft Graph

To list all CIMD-backed agent identities, use an advanced query:

```http
GET https://graph.microsoft.com/beta/servicePrincipals/microsoft.graph.agentIdentity?$filter=isClientIdMetadataDocument eq true&$count=true
Authorization: Bearer {token}
ConsistencyLevel: eventual
```

To find an identity by its canonical CIMD URL:

```http
GET https://graph.microsoft.com/beta/servicePrincipals/microsoft.graph.agentIdentity?$filter=clientIdMetadataDocumentUrl eq 'https://client.contoso.com/oauth/client-metadata.json'&$count=true
Authorization: Bearer {token}
ConsistencyLevel: eventual
```

Both filters require `$count=true` and the `ConsistencyLevel: eventual` request header.

## Monitor a CIMD client

CIMD-backed identities appear in Microsoft Entra sign-in and audit logs as agent identities.

Monitor:

- Successful and failed sign-ins.
- Users who authorize or use the client.
- Resources and delegated scopes the client accesses.
- Creation, update, disablement, deletion, and consent-grant events.
- Unexpected changes in client behavior or redirect destinations.

The app ID shown in logs is derived from the CIMD URL. The client has no home application tenant. For more information, see [Microsoft Entra Agent ID logs](sign-in-audit-logs-agents.md).

## Respond to a compromised or untrusted client

If a CIMD client, its signing material, or its domain might be compromised:

1. Disable the agent identity to stop new token issuance.
1. Revoke its delegated permission grants.
1. Revoke affected user sessions when required by your incident-response process.
1. Review sign-in and audit logs for unexpected activity.
1. Delete the agent identity when you no longer need investigation data or a disabled record.
1. Contact the client owner through a trusted channel.

If the publisher loses control of the CIMD URL or moves the document, don't update the existing identity to a new URL. The URL is immutable. Review and onboard the new URL as a new client, then grant permissions again.

## Understand governance gaps

The external CIMD document remains the source of truth for OAuth client configuration. Microsoft Entra ID doesn't copy the complete configuration to an application object.

Consider the following governance gaps:

- App management policy doesn't evaluate configuration that exists only in the CIMD document.
- Inventory and recommendations that inspect stored application credentials or redirect URIs might not include CIMD metadata.
- CIMD clients can't be publisher verified or Microsoft 365 certified.
- There is no tenant-managed domain allowlist or blocklist for CIMD URLs.
- CIMD clients can't be used for app-only authentication or as protected resources.

Maintain an independent inventory of approved CIMD URLs and review it regularly.

## Related content

- [Client ID Metadata Documents in Microsoft Entra ID](client-id-metadata-documents.md)
- [Configure a client to use a Client ID Metadata Document](configure-client-id-metadata-document.md)
- [Manage agent identities in your organization](manage-agent-identities-admin.md)
- [Microsoft Entra Agent ID logs](sign-in-audit-logs-agents.md)
