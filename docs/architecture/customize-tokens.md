---
title: Customize tokens
description: How to build security into applications with ID tokens, access tokens, and security tokens from the Microsoft identity platform.
customer-intent: As an independent software developer, I want to learn how to build secure applications with Microsoft identity platform ID tokens, access tokens, and security tokens.
author: jricketts
manager: martinco
ms.service: entra
ms.topic: article
ms.date: 03/14/2024
ms.author: jricketts
ms.custom: sfi-ropc-nochange
---
# Customize tokens

This article helps you to build security into applications with ID tokens, access tokens, and security tokens from the Microsoft identity platform. It describes the information that you can receive in Microsoft Entra tokens and how you can customize them. It's the fifth in a series of articles on how independent software developers (ISVs) can build and optimize their applications for Microsoft Entra ID. In this series, you can learn more about these topics:

- [Microsoft Entra ID for Independent Software Developers](guide-for-independent-software-developers.md) describes how to use this cloud-based identity and access management service to enable employees to access resources with your application.
- [Establish applications in the Microsoft Entra ID ecosystem](establish-applications.md) describes how to use the [Microsoft Entra admin center](https://entra.microsoft.com/) or the Microsoft Graph Application Programming Interface (API) to register apps in a Microsoft Entra ID tenant.
- [Authenticate applications and users](authenticate-applications-and-users.md) describes how applications use Microsoft Entra ID to authenticate users and applications.
- [Authorize applications, resources, and workloads](authorize-applications-resources-workloads.md) discusses authorization when individual humans interact with and direct an application In this scenario, APIs act for a user, and when applications or services work independently.

The primary operation for applications connecting to Microsoft Entra ID is requesting and processing tokens. As a developer, you can customize the token that Microsoft Entra ID sends to your delegated permission app or API. You can't customize workload tokens.

If your application implements [OpenID Connect (OIDC)](auth-oidc.md) and requests ID tokens, you can customize the ID token for your app. If you implement an API, you can customize the access tokens that apps calling your API receive. It isn't possible for an application to customize the access tokens it receives that authorize an app to access an API.

The primary token customization method for ISVs is to add [optional claims](~/identity-platform/optional-claims.md) to tokens in the app registration. The [optional claims reference](~/identity-platform/optional-claims-reference.md) lists available optional claims.

For multitenant apps, optional claims are available to every tenant. You can configure your API access tokens to include the optional `onprem_sid` claim to include the user's on-premises security identity claim. While you can configure an optional claim, your app must always handle when the token doesn't include the optional claim you configured. For example, the user could be a Microsoft Entra ID-only user who doesn't have an on-premises security identifier. In this case, Microsoft Entra ID doesn't include the optional claim in the token. Microsoft Entra ID doesn't return a claim with an empty ("") value.

The [groups claim](~/identity-platform/optional-claims.md) is an optional claim that requires special handling. An app or API can include users' security groups and nested groups in the token or include the security groups and nested groups with distributions lists with the groups claim. Applications can include a user's directory roles in the token with the `wids` (tenant-wide roles) claim. Including all users' groups and/or distribution lists can result in no groups or distribution lists in the token.

Token size limits total entries in the groups claim to [200 for OAuth 2.0 apps, 150 for SAML apps](~/identity-platform/id-token-claims-reference.md), and six for apps that use implicit grant as part of a hybrid flow. When there are too many groups, the token has a group overage claim. If your token contains a group overage claim, fall back to [call Microsoft Graph](/graph/api/user-list-transitivememberof?view=graph-rest-1.0&tabs=http&preserve-view=true) to get the user's groups. Because you have no way of knowing when the user is a member of too many groups, always include the ability to call Microsoft Graph for the user's group memberships in your app. We recommend using Microsoft Graph instead of using the groups claim due to Microsoft Graph code requirements.

To avoid group overage, configure the groups claim to only include groups to which an application has assignment. With this approach, the groups claim includes only groups assigned to an app or API when the user is a member of the group (with no support for nested groups). The user must be a direct member of the group to which an app has assignment.

Another way to avoid group overage is to use roles instead of groups. You can [configure roles for your application](~/identity-platform/howto-add-app-roles-in-apps.md) or API that you receive in your token. IT admins can assign groups to the roles you define in a Microsoft Entra ID tenant with P1 or higher licensing. After assignment, your token includes a roles claim with app of the user's assigned roles, or roles based on the user's group membership.

Evaluate the [trade-offs for using groups or roles](~/identity-platform/howto-add-app-roles-in-apps.md). For ISVs, we recommend using roles instead of groups.

## Next steps

- [Microsoft Entra ID for Independent Software Developers](guide-for-independent-software-developers.md) describes how to use this cloud-based identity and access management service to enable employees to access resources with your application.
- [Establish applications in the Microsoft Entra ID ecosystem](establish-applications.md) describes how to use the [Microsoft Entra admin center](https://entra.microsoft.com/) or the Microsoft Graph API to register apps in a Microsoft Entra ID tenant.
- [Authenticate applications and users](authenticate-applications-and-users.md) describes how applications use Microsoft Entra ID to authenticate users and applications.
- [Authorize applications, resources, and workloads](authorize-applications-resources-workloads.md) discusses authorization when an individual human interacts with and directs an application, when APIs act on behalf of a user, and when applications or services work independently.
