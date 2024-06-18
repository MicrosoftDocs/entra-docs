---
title: Verified ID Face Check pricing
description: Learn about Microsoft Entra Verified ID consumptive billing model for Face Check transactions. Learn how to link your Microsoft Entra tenant to an Azure subscription.
ms.service: entra-verified-id

author: barclayn
manager: amycolannino
ms.author: barclayn
ms.topic: concept-article
ms.date: 10/06/2023
# Customer intent: As a Microsoft Entra tenant administrator, I want to link my tenant to an Azure subscription, so that I can take advantage of Verified ID Face Check.

---

# Billing model for Microsoft Entra Verified ID Face Check

[!INCLUDE [applies-to-workforce-only](https://learn.microsoft.com/en-us/entra/external-id/tenant-configurations)

Microsoft Entra Verified ID pricing is based on the count of unique Face Check verification activity within a calendar month that are performed by a Tenant acting as the verifier for the credential. Consumption based billing helps you manage costs by only paying for what the Face Check transactions used. In this article, learn about consumptive billing and linking your Microsoft Entra tenants to a subscription.

> [!IMPORTANT]
> This article does not contain pricing details. For the latest information about usage billing and pricing, see [Microsoft Entra pricing](https://www.microsoft.com/security/business/identity-access-management/azure-ad-pricing).

## What do I need to do?

To take advantage of the consumptive billing, your Microsoft Entra tenant must be linked to an Azure subscription.

|If your tenant is:  |You need to:  |
|---------|---------|
| A Microsoft Entra tenant already linked to a subscription     | Do nothing. When you use Face Check, you're automatically billed monthly for Face Check verifications.        |
| A Microsoft Entra tenant not yet linked to a subscription     | [Link your Microsoft Entra tenant to a subscription](#link-your-azure-ad-tenant-to-a-subscription) to activate consumptive billing.        |

## About monthly Face Check verifications billing

In your Microsoft Entra tenant, you can verify credentials from any issuer that you trust. In addition with Face Check, your organization can perform high-assurance verifications securely, simply, and at scale by performing facial matching between a user’s real-time selfie and a photo. Verified ID generates individual billing events for each unique verification that is performed by the platform.Whether that verification succeeded or failed.

<a name='link-your-azure-ad-tenant-to-a-subscription'></a>

## Link your Microsoft Entra tenant to a subscription

1. Go to the Verified ID overview page, scroll down to the new Addons section and `Enable` the Face Check addon
:::image type="content" source="media/using-facecheck/face-check-addon.png" alt-text="Screenshot of the Face Check Addon.":::

1. In the Link a subscription section, select a Subscription, a Resource group and the Resouce location. Then select `Validate`. If there are no subscriptions listed, see [What if I can't find a subscription?](using-facecheck.md#what-if-i-cant-find-a-subscription)
:::image type="content" source="media/using-facecheck/face-check-subscription-linking.png" alt-text="Screenshot subscription linking for Face Check.":::

1. Once validated you can `Enable` the Addon
:::image type="content" source="media/using-facecheck/face-check-addon-enabled.png" alt-text="Screenshot of using Face Check."::: 

## What if I can't find a subscription?
If no subscriptions are available in the Link a subscription pane, here are some possible reasons:

You don't have the appropriate permissions. Be sure to sign in with an Azure account that's assigned at least the Contributor role within the subscription or a resource group within the subscription.

A subscription exists, but it isn't associated with your directory yet. You can [associate an existing subscription to your tenant](https://learn.microsoft.com/en-us/entra/fundamentals/how-subscriptions-associated-directory) and then repeat the steps for linking it to your tenant.

No subscription exists. In the Link a subscription pane, you can create a subscription by selecting the link if you don't already have a subscription you may create one here. After you create a new subscription, you'll need to [create a resource group](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/manage-resource-groups-portal]) in the new subscription, and then repeat the steps for linking it to your tenant..

## Next steps

For the latest pricing information, see [Microsoft Entra pricing](https://www.microsoft.com/security/business/identity-access-management/azure-ad-pricing).