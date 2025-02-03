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

When creating or updating a Microsoft Entra application, if you attempt to add an `identifier URI` (also referred to as `App ID URI`) that doesn't comply with the default formats of `api://{appId}` or `api://{tenantId}/{appId}`, you may receive an error like:

**The newly added URI {URI} must comply with the format 'api://{appId}' or 'api://{tenantId}/{appId}' as per the default app management policy of your organization. If the requestedAccessTokenVersion is set to 2, this restriction may not apply.  See https://aka.ms/identifier-uri-addition-error for more information on this error.**

You're receiving this error because your organization has an [app management policy](https://learn.microsoft.com/graph/api/resources/applicationauthenticationmethodpolicy?view=graph-rest-beta) that blocks the addition of insecure identifier URIs. Microsoft may have enabled this policy in your organization to improve its security.  

The next sections will provide guidance depending on your role in your organization. You can also jump to [learn more about this policy](#more-details-on-this-policy).

## Guidance for administrators

Read this section if you're an administrator and you or someone else in your organization received this error.

You're likely receiving this error because Microsoft enabled this policy on your behalf to improve the security of your organization. Microsoft has provided a script you can use to disable the policy, or to grant exemptions to it. Microsoft doesn't recommend disabling the policy, since it improves your organization’s security. Instead, we recommend enabling the change, and using exemptions to exempt any disrupted processes in your organization. You can grant exemptions to a specific Microsoft Entra application, to yourself, to another user in your organization, or to any service or process your organization uses.

- [Learn how to grant exemptions](https://aka.ms/identifier-uri-protection-grant-exemptions)
- [Learn how to disable the change](https://aka.ms/disable-identifier-uri-protection) (**Not Recommended**)

## Guidance for developers

Read this section if you're a developer, and you're trying to add a custom identifier URI (also known as app ID URI) to a Microsoft Entra API that you own.

There are three possible ways that you can add an identifier URI to your app. We recommend them in the following order:

1.  Instead of using a custom string value for the URI, consider using one of the default URIs of `api://{appId}` or `api://{tenantId}/{appId}`
1. If you encountered this error, it means your API currently uses v1.0 tokens. You can unblock yourself by updating your service to accept v2.0 tokens. V2.0 tokens are similar to v1.0, but there are some [differences](https://learn.microsoft.com/entra/identity-platform/access-token-claims-reference). Once your service is able to handle v2.0 tokens, you can update your app configuration so that Microsoft Entra sends them v2.0 tokens. An easy way to do this is through the manifest editor in the [Microsoft Entra admin center App registrations experience](https://aka.ms/ra/prod):

    :::image type="content" source="media/identifier-uri-restrictions/update-access-token-version-cropped.png" alt-text="Screenshot of update token version experience." lightbox="media/identifier-uri-restrictions/update-access-token-version.png":::

    However, you should **proceed with caution when making this change**. This is because once the app has been updated to the v2.0 token format, it won't be able to switch back to v1.0 tokens if it has custom identifier URIs configured, unless it's been granted an exemption (see option 3).
1. If you need to add a custom identifier URI to your app before you're able to update to the v2.0 token format, you can request your administrator to grant your app an exemption. Direct your administrator to the [guidance for administrators](#guidance-for-administrators) section.

## More details on this policy

Microsoft has introduced a security setting that protects against insecure usage of identifier URIs (also called 'App ID URIs') on Microsoft Entra applications.

### What are identifier URIs?

Identifier URIs (also called 'App ID URIs') allow a resource (API) developer to specify a string value for their application as its identifier. Clients who acquire a token for the API can use this string value during an OAuth request. For example, if an API had configured an identifier URI of `https://api.contoso.com`, then clients of the API could specify that value in OAuth requests to Microsoft Entra. This identifier URI is used as the audience claim in v1.0 access tokens.

Identifier URIs are configured using the 'Expose an API' page in [App registrations](https://aka.ms/ra/prod).  In App registrations, the identifier URI is referred to as an application ID URI; this is synonymous with identifier URI.

:::image type="content" source="media/identifier-uri-restrictions/screenshot-of-app-id-uri-configuration-experience-cropped.png" alt-text="Screenshot of identifier URI configuration experience." lightbox="media/identifier-uri-restrictions/screenshot-of-app-id-uri-configuration-experience.png":::

### What are the new restrictions on identifier URIs?

When this protection is enabled, new identifier URIs can't be added to any application in that organization, except for in known secure scenarios. Specifically, if any of the following conditions are met, an identifier URI can still be added:

- The identifier URI being added to the app is one of the 'default' URIs, meaning it is in the format of `api://{appId}` or `api://{tenantId}/{appId}`
- The app accepts `v2.0` Entra tokens. This is true if the app's `api.requestedAccessTokenVersion` property is set to `2`.
- The app uses the SAML protocol for single sign-on (SSO). This is true if the service principal for the app has its `preferredSingleSignOnMode` property set to `SAML`.
- An [exemption](#guidance-for-administrators) has been granted to the app the URI is being added to, or to the user or service performing the addition.

Existing identifier URIs already configured on the Entra app won't be affected, and all apps will continue to function as normal. This will only affect new updates to Entra app configurations.

### How is the protection enabled?

This protection is turned on by configuring an organization's [app management policies](https://learn.microsoft.com/graph/api/resources/applicationauthenticationmethodpolicy?view=graph-rest-beta). A tenant administrator can turn it on or off. 

Because this setting is an important security protection, Microsoft is enabling it in customer tenants during the months of February and March 2025.

[Learn how to check if the protection has been enabled in your organization](https://aka.ms/check-identifier-uri-protection-state)

Even though Microsoft is enabling this setting by default, tenant administrators retain control over it. They can turn it on, off, or grant exceptions to it.
