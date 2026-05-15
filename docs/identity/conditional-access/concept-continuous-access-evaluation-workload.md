---
title: Continuous access evaluation for workload identities in Microsoft Entra ID
description: Learn how continuous access evaluation for workload identities enforces Conditional Access policies in real time, instantly revokes tokens, and improves security for service principals.
ai-usage: ai-assisted
ms.topic: concept-article
ms.date: 04/22/2026
ms.reviewer: sreyanthmora
ms.custom:
  - ai-gen-docs-bap
  - ai-gen-title
  - ai-seo-date:08/28/2025
  - ai-gen-description
---
# Continuous access evaluation for workload identities

Continuous access evaluation (CAE) for [workload identities](~/workload-id/workload-identities-overview.md) improves your organization's security by enforcing Conditional Access location and risk policies in real time. CAE instantly enforces token revocation events for workload identities, helping to prevent compromised service principals from accessing resources.

## Prerequisites

- [Workload Identities Premium](https://www.microsoft.com/security/business/identity-access/microsoft-entra-workload-identities#office-StandaloneSKU-k3hubfz) licenses are required to create or modify Conditional Access policies scoped to service principals. For more information, see [Conditional Access for workload identities](workload-identity.md).
- To create or modify Conditional Access policies, sign in as at least a [Conditional Access Administrator](../role-based-access-control/permissions-reference.md#conditional-access-administrator).
- CAE for workload identities supports single-tenant service principals registered in your tenant. Third-party SaaS and multitenant apps are out of scope.
- Managed identities aren't currently supported by CAE for workload identities.

## How CAE works for workload identities

CAE for workload identities extends the continuous access evaluation model to service principals. When a service principal opts in to CAE, the following flow applies:

1. A service principal requests an access token from Microsoft Entra ID for a supported resource provider, declaring the `cp1` client capability in the claims parameter of the token request.
1. Microsoft Entra ID evaluates applicable Conditional Access policies and issues a CAE-enabled access token. CAE-enabled tokens for workload identities are long-lived tokens (LLTs) with a lifetime of up to 24 hours.
1. The service principal presents the token to the resource provider (Microsoft Graph).
1. The resource provider evaluates the token against revocation events and Conditional Access policy changes synced from Microsoft Entra ID.
1. If a revocation event occurs (such as service principal disable or high risk detection), the resource provider rejects the token and returns a `401` response with a claims challenge.
1. The CAE-capable client handles the claims challenge by requesting a new token from Microsoft Entra ID, which reevaluates all conditions before issuing a new token.

Because CAE tokens for workload identities are long-lived (up to 24 hours), they reduce the need for frequent token requests while maintaining security through continuous evaluation.

> [!NOTE]
> The preceding flow follows the general CAE model described in [Continuous access evaluation](concept-continuous-access-evaluation.md#example-flow-diagrams). Workload identity behavior aligns with this model, though specific implementation details may vary.

For more information about how claims challenges work, see [Claims challenges, claims requests, and client capabilities](~/identity-platform/claims-challenge.md).

## Supported scenarios

The following sections describe the resource providers, identities, events, and policies that CAE supports for workload identities.

### Resource providers

CAE for workload identities is supported only on access requests sent to Microsoft Graph as a resource provider.

### Supported identities

Service principals for line-of-business (LOB) applications are supported. The following constraints apply:

- Only single-tenant service principals registered in your tenant are supported.
- Third-party SaaS and multitenant apps are out of scope.
- Managed identities aren't supported.

### Revocation events

The following revocation events are supported:

- **Service principal disable** — An administrator disables the service principal in the tenant.
- **Service principal delete** — An administrator deletes the service principal from the tenant.
- **High service principal risk** — Microsoft Entra ID Protection detects high risk for the service principal. For more information, see [Securing workload identities with Microsoft Entra ID Protection](~/id-protection/concept-workload-identity-risk.md).

### Conditional Access policies

CAE for workload identities supports Conditional Access policies that target location and risk. To create these policies, see the step-by-step walkthroughs in [Conditional Access for workload identities](workload-identity.md#implementation).

## Enable your application

Developers can opt in to CAE for workload identities by declaring the `cp1` client capability when requesting tokens. Declaring `cp1` signals to Microsoft Entra ID that the client application can handle claims challenges. Microsoft Graph (the only supported resource provider for workload identity CAE) only sends claims challenges to clients that declare this capability.

To declare CAE capability, include the following claims parameter in your token request:

```json
Claims: {"access_token":{"xms_cc":{"values":["cp1"]}}}
```

The method for declaring the `cp1` capability depends on the authentication library you use. For detailed code examples in .NET, Python, JavaScript, and other languages, see:

- [Claims challenges, claims requests, and client capabilities](~/identity-platform/claims-challenge.md#client-capabilities)
- [Use Continuous Access Evaluation enabled APIs in your applications](~/identity-platform/app-resilience-continuous-access-evaluation.md)

> [!IMPORTANT]
> An application won't receive claims challenges and won't receive CAE tokens unless it explicitly declares the `cp1` capability. For more information, see [Client capabilities](~/identity-platform/claims-challenge.md#client-capabilities).

> [!NOTE]
> Declaring `cp1` is a client-side action. Separately, API implementers (resource apps) can request `xms_cc` as an [optional claim](~/identity-platform/optional-claims.md) in their application manifest to detect whether calling clients support claims challenges. For more information, see [Receiving xms_cc claim in an access token](~/identity-platform/claims-challenge.md#receiving-xms_cc-claim-in-an-access-token).

### Disable

To opt out of CAE at the application level, don't send the `cp1` capability in the claims parameter of token requests.

## Known limitations

Review the following limitations before you implement CAE for workload identities:

- **Microsoft Graph only.** CAE for workload identities is supported only on access requests to Microsoft Graph. Other resource providers aren't currently supported.
- **Managed identities aren't supported.** CAE doesn't support managed identities at this time.
- **Single-tenant service principals only.** Only single-tenant service principals registered in your tenant are supported. Third-party SaaS and multitenant apps are out of scope.
- **CAE enforces location and risk policies.** CAE for workload identities enforces Conditional Access policies that target location and risk in real time. For the full list of Conditional Access conditions supported for workload identities (including [authentication contexts](concept-conditional-access-cloud-apps.md#authentication-context)), see [Conditional Access for workload identities](workload-identity.md).
- **Group-based policy assignment not enforced.** Conditional Access policies assigned to a group that contains a service principal aren't enforced for that service principal. The policy must be assigned directly to the service principal as a workload identity. For more information, see [Conditional Access for workload identities](workload-identity.md).

## Monitor CAE for workload identities

Administrators can monitor CAE activity for workload identities using the Microsoft Entra sign-in logs.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Security Reader](../role-based-access-control/permissions-reference.md#security-reader).
1. Browse to **Entra ID** > **Monitoring & health** > **Sign-in logs** > **Service principal sign-ins**. Use filters to simplify the process.
1. Select an entry to view activity details. The **Continuous access evaluation** field shows whether a CAE token was issued for a specific sign-in attempt.

For general CAE monitoring tools, including the **Continuous access evaluation insights** workbook and IP mismatch analysis, see [Monitor and troubleshoot continuous access evaluation](howto-continuous-access-evaluation-troubleshoot.md).

## Troubleshooting

When a CAE-enabled resource rejects a workload identity token, the application should handle the `401` claims challenge and request a new token from Microsoft Entra ID. Microsoft Entra ID then reevaluates conditions before deciding whether to issue a new token. Use the following steps to investigate.

**Service principal access is unexpectedly blocked:**

1. Check the [sign-in logs](../monitoring-health/concept-sign-ins.md) under **Service principal sign-ins**. Look for entries where the **Continuous access evaluation** field indicates a CAE token was involved.
1. Verify whether a revocation event occurred: check if the service principal was disabled, deleted, or flagged as high risk by [Microsoft Entra ID Protection](~/id-protection/concept-workload-identity-risk.md).
1. Review applicable Conditional Access policies to confirm the service principal's source IP is included in an allowed [named location](concept-assignment-network.md).

**Service principal isn't receiving CAE tokens:**

- Verify the application declares the `cp1` capability in the claims parameter of token requests.
- Confirm the application targets Microsoft Graph as the resource provider. Other resource providers aren't currently supported for CAE.
- Check that the service principal is a single-tenant LOB application registered in your tenant.

**IP address mismatch between Microsoft Entra ID and resource provider:**

- This situation can occur with split-tunnel networks or proxy configurations. When IP addresses don't match, Microsoft Entra ID issues a one-hour CAE token and doesn't enforce client location change during that period. For more information, see [Monitor and troubleshoot continuous access evaluation](howto-continuous-access-evaluation-troubleshoot.md#ip-address-configuration).

For more information about troubleshooting CAE, see [Monitor and troubleshoot continuous access evaluation](howto-continuous-access-evaluation-troubleshoot.md).

## Related content

- [Conditional Access for workload identities](workload-identity.md)
- [Continuous access evaluation](concept-continuous-access-evaluation.md)
- [Monitor and troubleshoot continuous access evaluation](howto-continuous-access-evaluation-troubleshoot.md)
- [Claims challenges, claims requests, and client capabilities](~/identity-platform/claims-challenge.md)
- [Use Continuous Access Evaluation enabled APIs in your applications](~/identity-platform/app-resilience-continuous-access-evaluation.md)
- [Securing workload identities with Microsoft Entra ID Protection](~/id-protection/concept-workload-identity-risk.md)
- [Register an application with Microsoft Entra ID and create a service principal](~/identity-platform/howto-create-service-principal-portal.md#register-an-application-with-microsoft-entra-id-and-create-a-service-principal)
- [Sample application using continuous access evaluation](https://github.com/Azure-Samples/ms-identity-dotnetcore-daemon-graph-cae)
