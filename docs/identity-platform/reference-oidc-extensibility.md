---
title: Microsoft identity platform OIDC extensibility reference
description: Map each Microsoft identity platform OpenID Connect (OIDC) extensibility surface to the configuration article and the Microsoft Graph API resource that programs it.
author: jenniferf-skc
manager: pmwongera
ms.service: identity-platform
ms.topic: reference
ms.date: 06/23/2026
ms.author: jfields
ms.reviewer: jmprieur, ludwignick
ai-usage: ai-assisted

#customer intent: As a developer or analyst evaluating the Microsoft identity platform, I want one page that lists every OIDC extensibility surface and the Microsoft Graph API resource that configures it so that I can compare integration depth without searching across articles.
---

# Microsoft identity platform OIDC extensibility reference

Use this reference to find every supported way to extend Microsoft identity platform OpenID Connect (OIDC) behavior. Each row links to the concept or how-to article in this repo and to the Microsoft Graph API resource that programs the surface.

Extensibility refers to changing how Microsoft Entra issues OIDC tokens or processes OIDC requests for apps you own — for example, adding claims from an external store, customizing token contents per app, or trusting tokens from external workload identities. Configuring an existing OIDC app (such as GitHub, Salesforce, or another SaaS app) to use Microsoft Entra for sign-in is *integration*, not extensibility. For app integration guidance, see [Microsoft Entra application gallery](~/identity/enterprise-apps/overview-application-gallery.md).

For the underlying endpoint contracts, see [OpenID Connect on the Microsoft identity platform](v2-protocols-oidc.md).

## Extensibility surfaces at a glance

| Capability | What it lets you do | Concept and how-to | Microsoft Graph API |
|---|---|---|---|
| Custom claims provider | Call an external REST API during token issuance to enrich tokens with claims from a remote store. | [Custom claims provider overview](custom-claims-provider-overview.md), [Reference](custom-claims-provider-reference.md) | [customAuthenticationExtension](/graph/api/resources/customauthenticationextension), [onTokenIssuanceStartListener](/graph/api/resources/ontokenissuancestartlistener) |
| Token issuance start event | Configure the event listener that triggers your custom claims provider during token issuance. | [Set up token issuance start event](custom-extension-tokenissuancestart-setup.md), [Configure](custom-extension-tokenissuancestart-configuration.md) | [onTokenIssuanceStartCustomExtension](/graph/api/resources/ontokenissuancestartcustomextension), [onTokenIssuanceStartHandler](/graph/api/resources/ontokenissuancestarthandler), [onTokenIssuanceStartReturnClaim](/graph/api/resources/ontokenissuancestartreturnclaim) |
| Optional claims | Add Microsoft Entra-sourced claims (such as `groups`, `idtyp`, `login_hint`) to ID, access, and SAML tokens. | [Provide optional claims to your app](optional-claims.md), [Reference](optional-claims-reference.md) | [optionalClaim](/graph/api/resources/optionalclaim), [optionalClaims](/graph/api/resources/optionalclaims) on [application](/graph/api/resources/application) |
| Custom claims policy (per-app) | Map directory attributes to claims in tokens issued for a specific app, including transformations. | [JWT claims customization](jwt-claims-customization.md), [SAML claims customization](saml-claims-customization.md), [Custom claims policy](claims-customization-custom-claims-policy.md) | [customClaimsPolicy](/graph/api/resources/customclaimspolicy), [claimsMappingPolicy](/graph/api/resources/claimsmappingpolicy) |
| Token lifetime policy | Configure access, refresh, and ID token lifetimes for an app or tenant. | [Configurable token lifetimes](configurable-token-lifetimes.md), [Configure](configure-token-lifetimes.yml) | [tokenLifetimePolicy](/graph/api/resources/tokenlifetimepolicy) |
| Token issuance policy | Configure SAML token signing and encryption behavior at issuance. | [SAML claims customization](saml-claims-customization.md) | [tokenIssuancePolicy](/graph/api/resources/tokenissuancepolicy) |
| Federated identity credentials | Trust tokens from external issuers (GitHub, Kubernetes, other clouds) instead of using a client secret or certificate. | [Workload identity federation](~/workload-id/workload-identity-federation.md) | [federatedIdentityCredential](/graph/api/resources/federatedidentitycredential), [Federated identity credentials overview](/graph/api/resources/federatedidentitycredentials-overview) |
| Application manifest | Declaratively configure redirect URIs, audiences, allowed grant types, and token settings. | [Application manifest reference](reference-app-manifest.md) | [application](/graph/api/resources/application), [servicePrincipal](/graph/api/resources/serviceprincipal) |
| Delegated permission grants | Authorize delegated scopes for a user or tenant. | [Permissions and consent overview](permissions-consent-overview.md) | [oAuth2PermissionGrant](/graph/api/resources/oauth2permissiongrant) |
| App role assignments | Assign app roles to users, groups, or service principals for token-based authorization. | [App roles overview](howto-add-app-roles-in-apps.md) | [appRoleAssignment](/graph/api/resources/approleassignment) |
| Continuous access evaluation (CAE) | Enable token revocation in near real time for events such as user sign-out, password change, and risk detection. | [Continuous access evaluation](~/identity/conditional-access/concept-continuous-access-evaluation.md) | [conditionalAccessPolicy](/graph/api/resources/conditionalaccesspolicy) |
| Claims challenge (step-up) | Request stronger authentication or fresher claims mid-session. | [Claims challenges](claims-challenge.md), [Claims validation](claims-validation.md) | N/A (protocol-level; signaled in the `claims` request parameter) |

## Choosing an extensibility surface

Use the following guidance to decide which surface fits your scenario:

- To add claims **sourced from Microsoft Entra ID**, use [optional claims](optional-claims.md) or a [custom claims policy](claims-customization-custom-claims-policy.md).
- To add claims **sourced from an external system**, use a [custom claims provider](custom-claims-provider-overview.md) backed by an Azure Functions endpoint or other REST API.
- To **trust an external workload identity** instead of using a client secret or certificate, configure a [federated identity credential](~/workload-id/workload-identity-federation.md).
- To **react to security events** (revoked sessions, risk changes, password resets) on existing tokens, enable [continuous access evaluation](~/identity/conditional-access/concept-continuous-access-evaluation.md).
- To **request fresher authentication** during a session, issue a [claims challenge](claims-challenge.md).

## Programming model

Most surfaces in the table are configured through the [Microsoft Graph application](/graph/api/resources/application) and [servicePrincipal](/graph/api/resources/serviceprincipal) resources or through the `policies` endpoint. Authentication libraries don't configure these surfaces; use Microsoft Graph SDKs, the [Microsoft Graph PowerShell SDK](/powershell/microsoftgraph/overview), or direct REST calls.

For an end-to-end example that combines a custom authentication extension with a token issuance start event, see [Configure a custom claim provider with a token issuance start event](custom-extension-tokenissuancestart-configuration.md).

## Related content

- [OpenID Connect on the Microsoft identity platform](v2-protocols-oidc.md)
- [Application manifest reference](reference-app-manifest.md)
- [Microsoft Graph application resource](/graph/api/resources/application)
