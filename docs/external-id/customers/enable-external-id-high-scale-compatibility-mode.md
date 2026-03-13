---
title: Enable External ID High Scale Compatibility (HSC) mode
description: Enable HSC mode on your Azure AD B2C tenant to adopt Microsoft Entra External ID endpoints while keeping existing users and credentials in place.
author: garrodonnell
ms.author: godonnell
ms.topic: how-to
ms.date: 03/13/2026
ai-usage: ai-assisted
---

# Enable External ID High Scale Compatibility (HSC) mode

[!INCLUDE [applies-to-external-only](../includes/applies-to-external-only.md)]

Enable High Scale Compatibility (HSC) mode to transition applications from Azure AD B2C to Microsoft Entra External ID with minimal disruption while keeping existing users and credentials in place.

New customers evaluating Microsoft Entra External ID at scale should refer to [Planning your solution](concept-planning-your-solution.md).

If you're an Azure AD B2C customer and haven't yet reviewed the available options for migration, refer to [Plan your migration from Azure AD B2C to External ID](plan-your-migration-from-b2c-to-external-id.md).

In this article, you’ll learn how to:
- Confirm prerequisites and enable HSC mode by using Microsoft Graph
- Prepare identity schema for coexistence
- Onboard and validate your first applications on External ID endpoints
- Roll out additional applications and prepare for Azure AD B2C retirement

> [!IMPORTANT]
> Don't proceed unless your tenant is eligible for HSC and you have reviewed and accepted the HSC limitations. For decision guidance, see [Plan your migration from Azure AD B2C to External ID](plan-your-migration-from-b2c-to-external-id.md) (in particular, **High Scale Compatibility (HSC) migration approach**).

## Stage 1: Request allowlisting and enable HSC mode

If you meet the eligibility criteria and have reviewed the limitations, contact your Microsoft account team or raise a support ticket to request allowlisting for HSC mode. This process can take a few days to complete.

Once your tenant is allow-listed for HSC mode, you can turn on HSC mode by calling the following Microsoft Graph API. The calling account needs the [`Policy.ReadWrite.AuthenticationFlows`](/graph/permissions-reference#policyreadwriteauthenticationflows) permission:

**POST**: `https://graph.microsoft.com/beta/policies/authenticationFlowsPolicy/externalIdHybridModeConfiguration`  
**Body**: `{}`

Then verify with:

**GET**: `https://graph.microsoft.com/beta/policies/authenticationFlowsPolicy/externalIdHybridModeConfiguration`

**Response:**

```json
{
    "@odata.context": "https://graph.microsoft.com/beta/$metadata#policies/authenticationFlowsPolicy/externalIdHybridModeConfiguration/$entity",
    "id": "externalIdHybridModeConfiguration",
    "externalIdHybridMode": "enabled",
    "status": "succeeded",
    "statusDetail": "External Id Hybrid Mode migration is complete.",
    "createdDateTime": "2025-01-01T00:00:00Z",
    "lastActionDateTime": "2025-01-01T00:00:00Z",
    "error": null
}
```

> [!NOTE]
> If you need to disable HSC mode, contact Microsoft support.

## Stage 2: Review identity schema for coexistence

During coexistence, applications might authenticate users through different identity endpoints (B2C or External ID). Preparing identity data ensures that existing users can continue to sign in without disruption and that applications receive the claims they expect.

When you enable External ID in HSC mode, your Azure AD B2C user directory remains unchanged. Most tenants don’t need to make any identity data changes.

You only need to complete this step before migrating applications if your tenant uses one or more of the following:
- Federated identities (social or enterprise IdPs)
- Existing MFA enrollments
- Applications that rely on specific token claims

If you don't use any of these features, continue to Stage 3.

### Federated identities (social or enterprise IdPs)

Federated users might fail to sign in after applications move to External ID if required user properties aren't correctly populated.

Review attributes for any users who sign in with Google or Facebook and verify that the `accountEnabled` property on user objects is set to `true`.

This ensures federated users can authenticate successfully once applications move to External ID endpoints.

### Users with existing MFA enrollment

Review MFA enrollment data if users previously enrolled in MFA through Azure AD B2C. Without schema alignment, these users might be prompted to re-register or fail MFA challenges in External ID.

Review users with existing MFA methods like phone or SMS OTP and verify that strong authentication is enabled and a preferred MFA method is selected.

This allows External ID applications to honor existing MFA enrollment and prevents users from being unexpectedly prompted to re‑register MFA.

### Applications that depend on specific token claims

If your applications rely on specific claims, most commonly `email` or `sub` claim, review how those attributes are populated and emitted. Applications might break if expected claims are missing or emitted under different claim names.

**Common scenarios**
- Applications rely on `email` or `sub`
- Local accounts where `mail` isn’t populated
- Claims populated only via sign-in names or custom policies

Before migrating applications:
- Validate how attributes map to token claims used by your applications.

You can configure optional claims to be returned in `IdToken` using [JWT claims customization](/entra/identity-platform/jwt-claims-customization).

You can use [custom extensions](/entra/identity-platform/custom-extension-overview) to add external user data to the security token before the token is issued.

This helps avoid differences in token contents between B2C‑based and External ID‑based applications during coexistence.

## Stage 3: Build your first External ID application (with existing B2C users)

Use the following steps to create and configure an application that uses External ID endpoints while continuing to use the existing Azure AD B2C user base. Native authentication is optional and applies only to apps that use the native auth APIs.

### Register your application

Follow the instructions in [Register an application](/entra/identity-platform/quickstart-register-app) to register your application.

When registering an application in your External ID tenant, choose _Accounts in this organizational directory only_. When registering an application in your B2C tenant, choose _Accounts in any organizational directory_.

> [!NOTE]
> Existing Azure AD B2C app registrations can't be reused for External ID endpoints due to differences in application properties, single‑tenant requirements, and Native Authentication support, which requires dedicated app registrations.

### (Optional) Native authentication

If you're using native authentication, enable it by following the guidance in [Native authentication](/entra/identity-platform/concept-native-authentication).

### Configure user flows

Next, create an External ID user flow and associate it with your application. You can use the Microsoft Graph API to do this. For more information, see [Create authentication event flows](/graph/api/identitycontainer-post-authenticationeventsflows?view=graph-rest-beta&tabs=http&preserve-view=true).

### (Optional) Configure a custom URL domain and Azure Front Door

External ID supports custom authentication domains (for example, `login.contoso.com`) to maintain branding and consistency. [Custom URL domains](/entra/external-id/customers/concept-custom-url-domain) are implemented using a reverse proxy such as Azure Front Door, which routes traffic from the custom domain to the underlying External ID endpoints.

**Important routing considerations**

When using Azure Front Door, routing rules must be clearly defined to ensure authentication traffic is sent to the correct identity platform. Azure Front Door routes requests based on hostnames and paths, and each custom domain is associated with a specific backend origin.

If an application needs to support authentication traffic for both Azure AD B2C and Microsoft Entra External ID at the same time, sharing the same custom authentication domain isn't recommended. Because [Azure Front Door routing methods](/azure/frontdoor/routing-methods) can route a custom domain to only one origin at a time, this scenario typically requires a separate custom domain for External ID endpoints (for example, `login.contoso.com` for B2C and `login-ext.contoso.com` for External ID) to avoid routing conflicts and unintended traffic mixing.

### (Optional) Add custom authentication extensions

Some applications require lightweight logic during authentication, such as attribute validation or token enrichment. Custom authentication extensions let you invoke an external REST API at specific points in the authentication flow without building full custom policies. For more information, see [Custom authentication extensions](/entra/external-id/customers/concept-custom-extensions) and [Custom extensions overview](/entra/identity-platform/custom-extension-overview).

## Stage 4: Validate end-to-end scenarios

Before you roll out broadly, validate the External ID–enabled application across critical authentication scenarios.

**Recommended validation**
- Sign in to the new app using existing B2C credentials.
- Inspect the issued token and verify:
  - `oid` remains the same as B2C.
  - `issuer` and `sub` differ from B2C.
- Sign up a new user in the new app using External ID auth endpoints (web or native authentication APIs).
- Sign in with the same user on a legacy B2C app and confirm the same `oid`.
- After validation, use the new app with hosted web flows and External ID features.

**What to verify**
- Existing users and newly created users.
- MFA behavior.
- Social sign‑in continuity.
- Token claims consumed by backend APIs.
- Sign‑in logs and error handling.

## Stage 5: Expand application adoption incrementally and prepare for retirement

After the initial application is validated:
- Onboard additional applications to External ID one at a time.
- Keep remaining applications on Azure AD B2C until they're ready.
- Maintain coexistence between B2C and External ID applications as needed.
- Ensure all Azure AD B2C applications are migrated to Microsoft Entra External ID on or before Azure AD B2C service retirement.
- Once all applications are running on External ID endpoints, no further action is required.

## Related content

- [Plan your migration from Azure AD B2C to External ID](plan-your-migration-from-b2c-to-external-id.md) – Decide whether HSC or the standard approach is right for your tenant.
- [Migrate from Azure AD B2C to Microsoft Entra External ID](migrate-from-b2c-to-external-id.md) – Follow the standard approach implementation steps (for tenants that aren't using HSC).
- [B2C HSC native auth configuration sample](https://github.com/alvesfabi/b2c-hsc-native-auth-configuration) – Sample configuration for native authentication in HSC mode.
