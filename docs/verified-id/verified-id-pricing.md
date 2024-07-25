---
title: Face Check (Preview) with Microsoft Entra Verified ID pricing
description: Learn about Face Check with Microsoft Entra Verified ID billing model. Learn how to enable the Face Check add-on in your tenant by linking your Microsoft Azure subscription.
ms.service: entra-verified-id

author: barclayn
manager: amycolannino
ms.author: barclayn
ms.topic: concept-article
ms.date: 06/19/2024
# Customer intent: As a Microsoft Entra tenant administrator, I want to enable the Face Check add-on in my tenant, so that I can enable the developers in my organization to use Face Check with Entra Verified ID.

---

# Billing model for Face Check (Preview) with Microsoft Entra Verified ID

> [!IMPORTANT]
> Face Check with Microsoft Verified ID is free to use during the preview period. Billing enforcement will start when the preview period ends.

Face Check with Microsoft Entra Verified ID pricing is based on unique Face Check verifications performed by the verifying authority during the billing cycle. There are two options to enable Face Check add-on on a workforce tenant:

- Enable as an Entra Suite trial or paid subscriber. The Entra Suite license includes eight Face Check verifications per license per month.

- Or enable in pay-as-you-go where your Azure subscription received charges per each individual Face Check verification performed from your tenant.

In this article, learn about the Face Check billing model and linking your Verified ID authority to an Azure subscription.

> [!IMPORTANT]
> This article does not contain pricing details. For the latest information about usage billing and pricing, see [Microsoft Entra pricing](https://www.microsoft.com/security/business/identity-access-management/azure-ad-pricing).

## What do I need to do?

To take advantage of the consumptive billing, your Verified ID authority must be linked to an Azure subscription.

|If your Verified ID authority is:  |You need to:  |
|---------|---------|
| A Verified ID authority not yet linked to a subscription     | [Link your Verified ID authority to an Azure subscription](#link-your-verified-id-authority-to-a-subscription) to activate consumptive billing.        |
| A Verified ID authority linked to a subscription     | Do nothing. You're automatically billed monthly for Face Check verifications.        |

## About monthly Face Check verifications billing

In your Microsoft Verified ID, you can verify credentials from issuer authorities that you trust. In addition with Face Check, your organization can perform high-assurance verifications securely, simply, and at scale by performing facial matching between a user’s real-time selfie and a photo. Verified ID generates individual billing events for each unique verification performed by the platform. Whether that verification succeeds or fails.

## Link your Verified ID authority to a subscription

1. Go to the Verified ID overview page. Scroll down to the new Add-ons section and `Enable` the Face Check add-on
:::image type="content" source="media/using-facecheck/face-check-add-on.png" alt-text="Screenshot of the Face Check add-on.":::

1. In the Link a subscription section, select a Subscription, a Resource group, and the Resource location. Then select `Validate`. If there are no subscriptions listed, see [What if I can't find a subscription?](using-facecheck.md#what-if-i-cant-find-a-subscription)
:::image type="content" source="media/using-facecheck/face-check-subscription-linking.png" alt-text="Screenshot subscription linking for Face Check.":::

1. `Enable` the add-on once the information is validated
:::image type="content" source="media/using-facecheck/face-check-add-on-enabled.png" alt-text="Screenshot of using Face Check."::: 

## What if I can't find a subscription?
If no subscriptions are available in the Link a subscription pane, here are some possible reasons:

You don't have the appropriate permissions. Be sure to sign in with an Azure account that is assigned at least the Contributor role within the subscription or a resource group within the subscription.

A subscription exists, but it isn't associated with your directory yet. You can [associate an existing subscription to your tenant](/entra/fundamentals/how-subscriptions-associated-directory) and then repeat the steps for linking it to your tenant.

No subscription exists. In the Link a subscription pane, you can create a subscription by selecting the link if you don't already have a subscription you might create one here. After you create a new subscription, you'll need to [create a resource group](/azure/azure-resource-manager/management/manage-resource-groups-portal) in the new subscription, and then repeat the steps for linking it to your tenant.

## Next steps

For the latest pricing information, see [Microsoft Entra pricing](https://www.microsoft.com/security/business/identity-access-management/azure-ad-pricing).