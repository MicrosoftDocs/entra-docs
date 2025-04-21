---
title: Restrictions on identifier URIs of Microsoft Entra applications
description: Understand why an app management policy may block the addition of an identifier URI, and learn more about the policy and the restrictions it enforces on identifier URIs
ms.date: 1/29/2025
author: arcrowe
ms.author: arcrowe
editor: 
ms.reviewer: arcrowe
ms.service: identity-platform

ms.topic: concept-article
#Customer intent: As a developer integrating with the Microsoft identity platform, I want to understand why an app management policy blocked the addition of an identifier URI I tried to add, and learn more about the policy and the restrictions it enforces on identifier URIs.
---

# Restrictions on identifier URIs of Microsoft Entra applications

The [`identifierUri`](#what-are-identifier-uris) - also referred to as `Application ID URI` - property of an Entra application is a required configuration for resource (API) applications.  Ensuring the property is configured securely is critical to the application's security.

## Secure patterns

[!INCLUDE [active-directory-identifierUri](~/includes/entra-identifier-uri-patterns.md)]

## Enforcing secure patterns with policy

Microsoft has introduced a security setting that protects against insecure configuration of identifier URIs (also called 'App ID URIs') on Microsoft Entra applications.   This security setting ensures that newly added URIs on v1 applications comply with the [secure patterns](#secure-patterns) outlined above. 

### Policy behavior

When this setting is enabled, the secure patterns are strictly enforced. Todo - insert error message

Doesn't apply to v2 or SAML apps

Existing identifier URIs already configured on the Entra app won't be affected, and all apps will continue to function as normal. This will only affect new updates to Entra app configurations.

When it is not enabled, some insecure patterns can still be used.  For example, URIs of the format `api://{string}` can still be added.

### Enabling and managing the policy

Microsoft may have already enabled this policy in your organization to improve its security.  You can check by running [this script](https://aka.ms/check-identifier-uri-protection-state).  

Even if Microsoft enabled the policy in your organization, a tenant administrator still has full control over it.  They can [grant exemptions](https://aka.ms/identifier-uri-protection-grant-exemptions) to a specific Microsoft Entra application, to themsevles, to another user in the organization, or to any service or process the organization uses.   Or, an administrator can [disable the policy](https://aka.ms/disable-identifier-uri-protection) (**not recommended**).

Microsoft won't enable the policy in your organization if it has processes that might be disrupted by the change.  Instead, an administrator in your organization can [identify and fix impacted process](todo), and then [enable it themselves](https://aka.ms/enable-identifier-uri-protection).

## Additional security settings

Microsoft also offers a more restrictive security policy on the `identifierUris` property. 

When this protection is enabled, new custom identifier URIs can't be added to any application in that organization, except for in known secure scenarios. Specifically, if any of the following conditions are met, an identifier URI can still be added:

- The identifier URI being added to the app is one of the 'default' URIs, meaning it is in the format of `api://{appId}` or `api://{tenantId}/{appId}`
- The app accepts `v2.0` Entra tokens. This is true if the app's `api.requestedAccessTokenVersion` property is set to `2`.
- The app uses the SAML protocol for single sign-on (SSO). This is true if the service principal for the app has its `preferredSingleSignOnMode` property set to `SAML`.
- An [exemption](#guidance-for-administrators) has been granted to the app the URI is being added to, or to the user or service performing the addition.

If this policy is enabled, then when creating or updating a Microsoft Entra application, if you attempt to add an `identifier URI` (also referred to as `App ID URI`) that doesn't comply with the default formats of `api://{appId}` or `api://{tenantId}/{appId}`, you may receive an error like:

**The newly added URI {URI} must comply with the format 'api://{appId}' or 'api://{tenantId}/{appId}' as per the default app management policy of your organization. If the requestedAccessTokenVersion is set to 2, this restriction may not apply.  See https://aka.ms/identifier-uri-addition-error for more information on this error.**

### Security benefit

Todo

### Guidance for developers

Read this section if you're a developer, and you're trying to add a custom identifier URI (also known as app ID URI) to a Microsoft Entra API that you own, but you received this error.

There are three possible ways that you can add an identifier URI to your app. We recommend them in the following order:

1.  Instead of using a custom string value for the URI, consider using one of the default URIs of `api://{appId}` or `api://{tenantId}/{appId}`
1. If you encountered this error, it means your API currently uses v1.0 tokens. You can unblock yourself by updating your service to accept v2.0 tokens. V2.0 tokens are similar to v1.0, but there are some [differences](https://learn.microsoft.com/entra/identity-platform/access-token-claims-reference). Once your service is able to handle v2.0 tokens, you can update your app configuration so that Microsoft Entra sends them v2.0 tokens. An easy way to do this is through the manifest editor in the [Microsoft Entra admin center App registrations experience](https://aka.ms/ra/prod):

    :::image type="content" source="media/identifier-uri-restrictions/update-access-token-version-cropped.png" alt-text="Screenshot of update token version experience." lightbox="media/identifier-uri-restrictions/update-access-token-version.png":::

    However, you should **proceed with caution when making this change**. This is because once the app has been updated to the v2.0 token format, it won't be able to switch back to v1.0 tokens if it has custom identifier URIs configured, unless it's been granted an exemption (see option 3).
1. If you need to add a custom identifier URI to your app before you're able to update to the v2.0 token format, you can request your administrator to grant your app an exemption. Direct your administrator to the [guidance for administrators](#guidance-for-administrators) section.

## FAQ

## What are identifier URIs?

Identifier URIs (also called 'App ID URIs') allow a resource (API) developer to specify a string value for their application as its identifier. Clients who acquire a token for the API can use this string value during an OAuth request. For example, if an API had configured an identifier URI of `https://api.contoso.com`, then clients of the API could specify that value in OAuth requests to Microsoft Entra. This identifier URI is used as the audience claim in v1.0 access tokens.

Identifier URIs are configured using the 'Expose an API' page in [App registrations](https://aka.ms/ra/prod).  In App registrations, the identifier URI is referred to as an application ID URI; this is synonymous with identifier URI.

:::image type="content" source="media/identifier-uri-restrictions/screenshot-of-app-id-uri-configuration-experience-cropped.png" alt-text="Screenshot of identifier URI configuration experience." lightbox="media/identifier-uri-restrictions/screenshot-of-app-id-uri-configuration-experience.png":::

### How do these policies work?

The enforcements are turned on by configuring an organization's [app management policies](https://learn.microsoft.com/graph/api/resources/applicationauthenticationmethodpolicy?view=graph-rest-beta). A tenant administrator can turn it on or off. 

Because this setting is an important security protection, Microsoft is enabling it in customer tenants during the months of February and March 2025.

[Learn how to check if the protection has been enabled in your organization](https://aka.ms/check-identifier-uri-protection-state)

Even though Microsoft is enabling this setting by default, tenant administrators retain control over it. They can turn it on, off, or grant exceptions to it.
