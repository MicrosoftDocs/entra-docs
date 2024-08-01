---
title: Continuous access evaluation for workload identities in Microsoft Entra ID
description: Respond to changes to applications with continuous access evaluation for workload identities in Microsoft Entra ID.

ms.service: entra-workload-id
ms.topic: conceptual
ms.date: 02/26/2024

ms.author: joflore
author: MicrosoftGuyJFlo
manager: amycolannino
ms.reviewer: joroja
---
# Continuous access evaluation for workload identities

Continuous access evaluation (CAE) for [workload identities](~/workload-id/workload-identities-overview.md) provides security benefits to your organization. It enables real-time enforcement of Conditional Access location and risk policies along with instant enforcement of token revocation events for workload identities. 

Continuous access evaluation doesn't currently support managed identities.

## Scope of support

Continuous access evaluation for workload identities is supported only on access requests sent to Microsoft Graph as a resource provider. More resource providers will be added over time.

Service principals for line of business (LOB) applications are supported.

We support the following revocation events:

- Service principal disable
- Service principal delete
- High service principal risk as detected by Microsoft Entra ID Protection

Continuous access evaluation for workload identities supports [Conditional Access policies that target location and risk](workload-identity.md#implementation).

## Enable your application

Developers can opt in to Continuous access evaluation for workload identities when their API requests `xms_cc` as an optional claim. The `xms_cc` claim with a value of `cp1` in the access token is the authoritative way to identify a client application is capable of handling a claims challenge. For more information about how to make this work in your application, see the article, [Claims challenges, claims requests, and client capabilities](~/identity-platform/claims-challenge.md).

### Disable 

In order to opt out, don't send the `xms_cc` claim with a value of `cp1`. 

Organizations who have Microsoft Entra ID P1 or P2 can create a [Conditional Access policy to disable continuous access evaluation](concept-conditional-access-session.md#customize-continuous-access-evaluation) applied to specific workload identities as an immediate stop-gap measure.

## Troubleshooting

When a client’s access to a resource is blocked due to CAE being triggered, the client’s session is revoked, and the client needs to reauthenticate. This behavior can be verified in the sign-in logs. 

The following steps detail how an admin can verify sign in activity in the sign-in logs: 

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Security Reader](../role-based-access-control/permissions-reference.md#security-reader).
1. Browse to **Identity** > **Monitoring & health** > **Sign-in logs** > **Service Principal Sign-ins**. You can use filters to ease the debugging process. 
1. To see activity details, select an entry. The **Continuous access evaluation** field indicates whether a CAE token was issued in a particular sign-in attempt. 

## Related content

- [Register an application with Microsoft Entra ID and create a service principal](~/identity-platform/howto-create-service-principal-portal.md#register-an-application-with-microsoft-entra-id-and-create-a-service-principal)
- [How to use Continuous Access Evaluation enabled APIs in your applications](~/identity-platform/app-resilience-continuous-access-evaluation.md)
- [Sample application using continuous access evaluation](https://github.com/Azure-Samples/ms-identity-dotnetcore-daemon-graph-cae)
- [Securing workload identities with Microsoft Entra ID Protection](~/id-protection/concept-workload-identity-risk.md)
- [What is continuous access evaluation?](~/identity/conditional-access/concept-continuous-access-evaluation.md)
