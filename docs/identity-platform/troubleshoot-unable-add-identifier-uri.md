---
title: Unable to add an identifier URI due to policy
description: Understand why an app management policy may block the addition of an identifier URI
ms.date: 12/16/2024
author: arcrowe
ms.author: arcrowe
editor: 
ms.reviewer: 
ms.service: entra-id
---

# Unable to add an identifier URI due to policy

When creating or updating an Entra application, if you attempt to add an `identifier URI` (also referred to as `App ID URI`) that doesn't comply with the default formats of `api://{appId}` or `api://{tenantId}/{appId}`, you may receive an error like:

**The newly added URI {URI} must comply with the format 'api://{appId}' or 'api://{tenantId}/{appId}' as per the default app management policy of your organization.  Please ensure that the identifier host matches the correct app ID. If the requestedAccessTokenVersion is set to 2, this restriction may not apply.  See https://aka.ms/identifier-uri-addition-error for more information on this error.**

You're receiving this error because your organization has an [app management policy](https://learn.microsoft.com/en-us/graph/api/resources/applicationauthenticationmethodpolicy?view=graph-rest-1.0) that blocks the addition of insecure identifier URIs.  Microsoft may have enabled this policy in your organization to improve its security.  

The next sections will provide troubleshooting guidance depending on your role in your organization.  You can also jump to [learn more about this policy](#more-details-on-this-policy).

## Guidance for administrators

Read this section if you're an administrator and you or someone else in your organization received this error.

You're likely receiving this error because Microsoft enabled this policy on your behalf to improve the security of your organization.  Microsoft has provided a script you can use to disable the policy, or to grant exemptions to it.  Microsoft doesn't recommend disabling the policy, since it will improve your organization’s security.  Instead, we recommend enabling the change, and using exemptions to exempt disrupted processes in your organization.  You can grant exemptions to a specific Entra application, to yourself, to another user in your organization, or to any service or process your organization uses.

- [Click here to learn how to grant exemptions](https://aka.ms/identifier-uri-protection-grant-exemptions)
- [Click here to learn how to disable the change](https://aka.ms/disable-identifier-uri-protection) (**Not Recommended**)

## Guidance for developers

Read this section if you're a developer, and you're trying to add a custom identifier URI (a.k.a. app ID URI) to an Entra API that you own.

There are three possible ways that you can add an identifier URI to your app. We recommend them in the following order:

1.  Instead of using a custom string value for the URI, consider using one of the default URIs of `api://{appId}` or `api://{tenantId}/{appId}`

1. If you encountered this error, it means your API currently uses v1.0 tokens. You can unblock yourself by updating your service to accept v2.0 tokens. V2.0 tokens are similar to v1.0, but there are some [differences](https://learn.microsoft.com/en-us/entra/identity-platform/access-token-claims-reference).  Once your service is able to handle v2.0 tokens, you can update your app configuration so that Entra sends them v2.0 tokens.  An easy way to do this is through the manifest editor in the [Entra portal App registrations experience](https://aka.ms/ra/prod):

    ![Screenshot of update token version experience](media/update-access-token-version.png)

    However, you should **proceed with caution when making this change**. This is because once the app has been updated to the v2.0 token format, it won't be able to switch back to v1.0 tokens if it has custom identifier URIs configured, unless it's been granted an exemption (see option 3).

1. If you need to add a new identifier URI to your app before you're able to update to the v2.0 token format, you can request your administrator to grant your app an exemption.  Direct your administrator to the [guidance for administrators](#guidance-for-administrators) section.

## Guidance for others, or I don't know why I encountered this error

Todo

## More details on this policy

Todo

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]