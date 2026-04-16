---
title: Troubleshoot High Scale Compatibility (HSC) mode
description: Diagnose and resolve common errors when using the High Scale Compatibility (HSC) API for migrating from Azure AD B2C to Microsoft Entra External ID.
author: garrodonnell
ms.author: godonnell
ms.topic: troubleshooting
ms.date: 04/08/2026
ms.custom: it-pro
ai-usage: ai-assisted
#Customer intent: As an IT admin or developer migrating from Azure AD B2C to Microsoft Entra External ID using HSC mode, I want to troubleshoot common errors so that I can complete migration successfully.
---

# Troubleshoot High Scale Compatibility (HSC) mode

[!INCLUDE [applies-to-external-only](../includes/applies-to-external-only.md)]

This article helps you diagnose and resolve common errors when using the [High Scale Compatibility (HSC) mode](enable-external-id-high-scale-compatibility-mode.md) API for Microsoft Entra External ID and Azure AD B2C tenants.

> [!IMPORTANT]
> Access to the HSC API depends on both the correct **permissions** and **admin consent**. Most HSC operations require Global Administrator access. If you're using delegated permissions, ensure an admin has granted consent for the required scopes.

## Quick reference

| Error message | HTTP status |
|---|---|
| [Unauthorized](#caller-lacks-required-role) | 403 Unauthorized |
| [Unauthorized (missing Graph permission)](#caller-lacks-microsoft-graph-permission) | 403 Unauthorized |
| ['{tenantId}' is not an Azure AD B2C directory](#wrong-tenant-type-context) | 400 BadRequest |
| [Entra External Id Hybrid Upgrade is not allowed for this tenant](#parent-tenant-not-enabled) | 400 BadRequest |
| ['{tenantId}' is not an Azure AD B2C directory with External Id Hybrid mode enabled](#delete-on-non-hybrid-tenant) | 403 Forbidden |
| [Stale GET response after POST (cache behavior)](#stale-get-response-after-post) | 200 OK |
| [Failed to sync custom attributes from B2C to the hybrid tenant's external ID context](#custom-attribute-sync-fails) | 400 BadRequest |
| [Your tenant '{tenantId}' is not linked to a valid subscription](#no-subscription-linked) | 400 BadRequest |

## Caller lacks required role

**HTTP status:** 403 Unauthorized\
**Affected endpoints:** All HSC endpoints

The calling identity (user or service principal) doesn't have one of the required directory roles:

- Global Administrator
- External ID User Flow Administrator
- `TenantAdmin`, `CpimServiceAdminReaderWriter`, or `AppOnlyCaller` (for app-only flows)

**How to fix:**

1. In the Azure portal, go to **Microsoft Entra ID** > **Roles and administrators**.
1. Assign the **Global Administrator** or **External ID User Flow Administrator** role to the calling account or service principal.
1. Wait a few minutes for role propagation, then retry the request.

> [!TIP]
> For automated pipelines, use a service principal and assign the least-privileged role that satisfies your scenario.

## Caller lacks Microsoft Graph permission

**HTTP status:** 403 Unauthorized\
**Affected endpoints:** All HSC endpoints

The application registration is missing the required Microsoft Graph permission `Policy.ReadWrite.AuthenticationFlows`.

**How to fix:**

1. In the Azure portal, go to **Microsoft Entra ID** > **App registrations** > your app.
1. Select **API permissions** > **Add a permission** > **Microsoft Graph** > **Application permissions**.
1. Search for and add `Policy.ReadWrite.AuthenticationFlows`.
1. Select **Grant admin consent for *your tenant*** and confirm.
1. Retry the request.

## Wrong tenant type context

**HTTP status:** 400 BadRequest\
**Error code:** `AccessDenied_NonB2CTenantNotAllowed`\
**Error message:** `'{tenantId}' is not an Azure AD B2C directory. Access to this Api can only be made for an Azure AD B2C directory.`\
**Affected endpoints:** All HSC endpoints

You issued the request against a CIAM or Microsoft Entra ID (workforce) tenant context. The HSC API must be called against your B2C tenant directly.

**How to fix:**

1. Ensure your request URL and token audience reference the B2C tenant ID (for example, `https://graph.microsoft.com/v1.0/` with the B2C tenant set as the active directory context).
1. When acquiring a token, set the authority to `https://login.microsoftonline.com/<b2c-tenant-id>`, not the workforce tenant.
1. Verify the tenant ID in the Azure portal: **Microsoft Entra ID** > **Overview** > **Tenant ID**.

## Parent tenant not enabled

**HTTP status:** 400 BadRequest\
**Error code:** `HybridUpgradeNotAllowed`\
**Error message:** `Entra External Id Hybrid Upgrade is not allowed for this tenant`\
**Affected endpoints:** POST (enable hybrid mode)

The parent workforce tenant doesn't have the `EnableHybridUpgradeApi` feature flag set. Only Microsoft can toggle this back-end enablement.

**How to fix:**

Contact Microsoft Support and request that the `EnableHybridUpgradeApi` flag be enabled on your parent workforce tenant. Include your parent tenant ID in the support request.

## DELETE on non-hybrid tenant

**HTTP status:** 403 Forbidden\
**Error code:** `AccessDenied_NonHybridTenantNotAllowed`\
**Error message:** `'{tenantId}' is not an Azure AD B2C directory with External Id Hybrid mode enabled. Access to this Api can only be made for an Azure AD B2C directory with Hybrid mode enabled.`\
**Affected endpoints:** DELETE (disable hybrid mode)

You sent a DELETE request to disable hybrid mode, but the tenant hasn't been successfully enabled yet (the POST to enable hybrid mode hasn't completed).

**How to fix:**

1. Complete the POST request to enable hybrid mode and confirm a `201 Created` response.
1. After the tenant is in hybrid state, retry the DELETE request.

## Stale GET response after POST

**HTTP status:** 200 OK (but data might be outdated)\
**Error code:** None (expected cache behavior)\
**Affected endpoints:** GET (read hybrid status)

Tenant metadata is cached for up to 1 hour. If you issue a GET request immediately after a successful POST, the response might still reflect the premigration state.

**How to fix:**

1. The `201 Created` response from the POST itself is authoritative confirmation that the operation succeeded. Rely on that response, not a subsequent GET.
1. If you need to poll for status, wait up to 1 hour and retry the GET request.

## Custom attribute sync fails

**HTTP status:** 400 BadRequest\
**Error code:** `AADB2C99089`\
**Error message:** `Failed to sync custom attributes from B2C to the hybrid tenant's external ID context. The following attributes couldn't be transferred: {failedAttributeList}. Please retry the operation or contact support.`\
**Affected endpoints:** POST (enable hybrid mode — attribute sync phase)

During the POST to enable hybrid mode, the service attempts to sync all B2C custom attributes to the External ID tenant. If any custom attribute has a null or empty description (sourced from the `AdminHelpText` field), that attribute is added to the failed list and the error `HybridTenantMigrationFailedAttributes` is returned.

Many B2C custom attributes are created without a description, so this issue can affect a large number of attributes silently.

Custom attributes that require a nonempty `description` field include any attribute where `AdminHelpText` is null or empty. Common examples include attributes created programmatically or through older B2C portal experiences.

**How to fix:**

1. List all custom attributes:

   ```http
   GET https://graph.microsoft.com/v1.0/identity/userFlowAttributes
   ```

1. For each attribute where `description` is null or empty, patch it with a nonempty description:

   ```http
   PATCH https://graph.microsoft.com/v1.0/identity/userFlowAttributes/{id}
   Content-Type: application/json

   {
     "description": "<a meaningful, non-empty description>"
   }
   ```

1. After all attributes are updated, retry the POST to enable hybrid mode.

> [!TIP]
> Use Microsoft Graph PowerShell or Graph Explorer to bulk-patch attributes efficiently before initiating the migration.

## No subscription linked

**HTTP status:** 400 BadRequest\
**Error code:** `NoResourceProviderDataFound`\
**Error message:** `Your tenant '{tenantId}' is not linked to a valid subscription.`\
**Affected endpoints:** POST (enable hybrid mode)

The resource provider data lookup returned null or has no `SubscriptionTenantId`. The B2C tenant isn't linked to any Azure subscription.

**How to fix:**

Ensure the B2C tenant is linked to a valid Azure subscription via the Azure portal.

## Related content

- [Enable External ID High Scale Compatibility (HSC) mode](enable-external-id-high-scale-compatibility-mode.md)
- [Plan your migration from Azure AD B2C to External ID](plan-your-migration-from-b2c-to-external-id.md)
- [Migrate from Azure AD B2C to Microsoft Entra External ID](migrate-from-b2c-to-external-id.md)
- [Known issues with Microsoft Entra External ID](troubleshooting-known-issues.md)
