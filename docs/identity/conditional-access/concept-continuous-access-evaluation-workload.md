---
title: Continuous Access Evaluation for Workload Identities in Entra ID
description: Learn how to enable continuous access evaluation for workload identities to enforce Conditional Access policies and instantly revoke tokens.
ms.service: entra-workload-id
ms.topic: article
ms.date: 08/28/2025
ms.author: joflore
author: MicrosoftGuyJFlo
manager: dougeby
ms.reviewer: joroja
ms.custom:
  - ai-gen-docs-bap
  - ai-gen-title
  - ai-seo-date:08/28/2025
  - ai-gen-description
---
# Continuous access evaluation for workload identities

Continuous access evaluation (CAE) for [workload identities](~/workload-id/workload-identities-overview.md) improves your organization's security. It enforces Conditional Access location and risk policies in real time and instantly enforces token revocation events for workload identities. 

Continuous access evaluation doesn't currently support managed identities.

## Scope of support

Continuous access evaluation for workload identities is supported only on access requests sent to Microsoft Graph as a resource provider. More resource providers will be added over time.

Service principals for line-of-business (LOB) applications are supported.

The following revocation events are supported:

- Service principal disable
- Service principal delete
- High service principal risk as detected by Microsoft Entra ID Protection

Continuous access evaluation for workload identities supports [Conditional Access policies that target location and risk](workload-identity.md#implementation).

## Enable your application

Developers can opt in to continuous access evaluation for workload identities when their API requests `xms_cc` as an optional claim. The `xms_cc` claim with a value of `cp1` in the access token is the authoritative way to identify that a client application is capable of handling a claims challenge. For more information about how to make this work in your application, see [Claims challenges, claims requests, and client capabilities](~/identity-platform/claims-challenge.md).

### Disable 

To opt out, don't send the `xms_cc` claim with a value of `cp1`. 

Organizations that have Microsoft Entra ID P1 or P2 can create a [Conditional Access policy to disable continuous access evaluation](concept-conditional-access-session.md#customize-continuous-access-evaluation) applied to specific workload identities as an immediate stopgap measure.

## Troubleshooting

When a client's access to a resource is blocked because CAE is triggered, the client's session is revoked, and the client needs to reauthenticate. You can verify this behavior in the sign-in logs. 

Follow these steps to verify sign-in activity in the sign-in logs: 

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Security Reader](../role-based-access-control/permissions-reference.md#security-reader).
1. Browse to **Entra ID** > **Monitoring & health** > **Sign-in logs** > **Service Principal Sign-ins**. Use filters to simplify the debugging process. 
1. Select an entry to view activity details. The **Continuous access evaluation** field shows whether a CAE token is issued for a specific sign-in attempt.

## Related content

- Learn how to [register an application with Microsoft Entra ID and create a service principal](~/identity-platform/howto-create-service-principal-portal.md#register-an-application-with-microsoft-entra-id-and-create-a-service-principal).
- Learn how to [use Continuous Access Evaluation enabled APIs in your applications](~/identity-platform/app-resilience-continuous-access-evaluation.md).
- Explore a [sample application using continuous access evaluation](https://github.com/Azure-Samples/ms-identity-dotnetcore-daemon-graph-cae).
- Learn about [securing workload identities with Microsoft Entra ID Protection](~/id-protection/concept-workload-identity-risk.md).
- Understand [what continuous access evaluation is](~/identity/conditional-access/concept-continuous-access-evaluation.md).
