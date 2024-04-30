---
title: Build resilience in external user authentication with Microsoft Entra ID
description: A guide for IT admins and architects to building resilient authentication for external users
author: janicericketts
ms.service: entra
ms.subservice: architecture
ms.topic: conceptual
ms.date: 11/16/2022
ms.author: jricketts
---
# Build resilience in external user authentication

[Microsoft Entra B2B collaboration](~/external-id/what-is-b2b.md) (Microsoft Entra B2B) is a feature of [External Identities](~/external-id/external-collaboration-settings-configure.md) that enables collaboration with other organizations and individuals. It enables the secure onboarding of guest users into your Microsoft Entra tenant without having to manage their credentials. External users bring their identity and credentials with them from an external identity provider (IdP) so they don't have to remember a new credential. 

## Ways to authenticate external users

You can choose the methods of external user authentication to your directory. You can use Microsoft IdPs or other IdPs.

With every external IdP, you take a dependency on the availability of that IdP. With some methods of connecting to IdPs, there are things you can do to increase your resilience.

> [!NOTE] 
> Microsoft Entra B2B has the built-in ability to authenticate any user from any [Microsoft Entra ID](../index.yml) tenant or with a personal [Microsoft Account](https://account.microsoft.com/account). You do not have to do any configuration with these built-in options.

### Considerations for resilience with other IdPs

When you use external IdPs for guest user authentication, there are configurations that you must maintain to prevent disruptions.

| Authentication Method| Resilience considerations |
| - | - |
| Federation with social IDPs like [Facebook](~/external-id/facebook-federation.md) or [Google](~/external-id/google-federation.md).| You must maintain your account with the IdP and configure your Client ID and Client Secret. |
| [SAML/WS-Fed identity provider (IdP) federation](~/external-id/direct-federation.md)| You must collaborate with the IdP owner for access to their endpoints upon which you're dependent. You must maintain the metadata that contain the certificates and endpoints. |
| [Email one-time passcode](~/external-id/one-time-passcode.md)| You're dependent on Microsoft's email system, the user's email system, and the user's email client. |

## Self-service sign-up

As an alternative to sending invitations or links, you can enable [Self-service sign-up](~/external-id/self-service-sign-up-overview.md).  This method allows external users to request access to an application. You must create an [API connector](~/external-id/self-service-sign-up-add-api-connector.md) and associate it with a user flow. You associate user flows that define the user experience with one or more applications. 

It's possible to use [API connectors](~/external-id/api-connectors-overview.md) to integrate your self-service sign-up user flow with external systems' APIs. This API integration can be used for [custom approval workflows](~/external-id/self-service-sign-up-add-approvals.md), [performing identity verification](~/external-id/code-samples-self-service-sign-up.md), and other tasks such as overwriting user attributes. Using APIs requires that you manage the following dependencies.

* **API Connector Authentication**: Setting up a connector requires an endpoint URL, a username, and a password. Set up a process by which these credentials are maintained, and work with the API owner to ensure you know any expiration schedule.
* **API Connector Response**: Design API Connectors in the sign-up flow to fail gracefully if the API isn't available. Examine and provide to your API developers these [example API responses](~/external-id/self-service-sign-up-add-api-connector.md) and the [best practices for troubleshooting](~/external-id/self-service-sign-up-add-api-connector.md). Work with the API development team to test all possible response scenarios, including continuation, validation-error, and blocking responses. 

## Next steps

### Resilience resources for administrators and architects
 
* [Build resilience with credential management](resilience-in-credentials.md)
* [Build resilience with device states](resilience-with-device-states.md)
* [Build resilience by using Continuous Access Evaluation (CAE)](resilience-with-continuous-access-evaluation.md)
* [Build resilience in your hybrid authentication](resilience-in-hybrid.md)
* [Build resilience in application access with Application Proxy](resilience-on-premises-access.md)

### Resilience resources for developers

* [Build IAM resilience in your applications](resilience-app-development-overview.md)
* [Build resilience in your CIAM systems](resilience-b2c.md)
