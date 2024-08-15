---
title: MAU billing model for Microsoft Entra External ID
description: Learn about Microsoft Entra External ID monthly active users (MAU) billing model for guest user collaboration (B2B) in Microsoft Entra External ID. Learn how to link your Microsoft Entra tenant to an Azure subscription.

 
ms.service: entra-external-id
ms.topic: concept-article
ms.date: 08/14/2024

ms.author: mimart
author: msmimart
manager: celestedg
 
ms.collection: M365-identity-device-management
#customer intent: As a Microsoft Entra tenant administrator, I want to link my tenant to an Azure subscription, so that I can take advantage of the monthly active users (MAU) billing model and activate MAU billing for guest user collaboration.
---

# Billing model for Microsoft Entra External ID

[!INCLUDE [applies-to-workforce-external](./includes/applies-to-workforce-external.md)]

## External ID pricing and licensing

Microsoft Entra External ID pricing is based on monthly active users (MAU), which is the count of unique external users with authentication activity within a calendar month. This billing model applies to all External ID scenarios, including B2B collaboration in workforce tenants and identity and access management in external tenants. It also applies to [Azure AD B2C tenants](/azure/active-directory-b2c/billing).

To determine the total number of MAUs, we combine MAUs from all your tenants (both External ID and Azure AD B2C) that are linked to the same subscription. MAU billing helps you reduce costs by offering a free tier and flexible, predictable pricing. You can get started for free and only pay for what you use as your business grows.

> [!IMPORTANT]
> This article does not contain pricing details. For the latest information about usage billing and pricing, see [External ID pricing](https://aka.ms/ExternalIDPricing) and our [Microsoft Entra External ID frequently asked questions](customers/faq-customers.md).

<a name='link-your-azure-ad-tenant-to-a-subscription'></a>

## Link your Microsoft Entra tenant to a subscription

Microsoft Entra tenants, both workforce and external, must be linked to a resource group within an Azure subscription for proper billing and access to features. To link your tenant to a subscription, follow these steps.

### To link a workforce tenant to a subscription

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com/) with an account that's assigned at least the Contributor role within the subscription or a resource group within the subscription.

2. Select the directory you want to link: In the Microsoft Entra admin center toolbar, select the **Settings** icon in the portal toolbar. Then on the **Portal settings | Directories + subscriptions** page, find your directory in the **Directory name** list, and then select **Switch**.

3. Browse to **Identity** > **External identities** > **Overview**.

5. Under **Subscriptions**, select **Linked subscriptions**.

6. In the tenant list, select the checkbox next to the tenant, and then select **Link subscription**.

    :::image type="content" source="media/external-identities-pricing/linked-subscriptions.png" alt-text="Screenshot of the link a subscription option.":::

7. In the **Link a subscription** pane, select a **Subscription** and a **Resource group**. Then select **Apply**. (If there are no subscriptions listed, see [What if I can't find a subscription?](#what-if-i-cant-find-a-subscription).)

    :::image type="content" source="media/external-identities-pricing/link-subscription-resource.png" alt-text="Screenshot of how to link a workforce tenant to a subscription.":::

After you complete these steps, your Azure subscription is billed based on your Azure Direct or Enterprise Agreement details, if applicable.

### To link an external tenant to a subscription

Depending on how you created your external tenant, it might already be linked to a subscription. To find out, follow these steps:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com/).

1. Make sure your external tenant is selected: In the Microsoft Entra admin center toolbar, select the **Settings** icon in the portal toolbar. On the **Portal settings | Directories + subscriptions** page, find your external tenant in the **Directory name** list, and then select **Switch**.

1. Select **Home** and find the **Billing** section:

   - If your tenant is linked to a subscription, the subscription ID will appear in this section. You can select the ID to view subscription details.
   
       :::image type="content" source="media/external-identities-pricing/billing-section-subscription.png" alt-text="Screenshot of how to link an external tenant to a subscription.":::

   - If your tenant is not yet linked to a subscription, in the **Billing** section, select the **Click here to upgrade** link, and then select the **Add Subscription** button. Follow the steps in [Upgrade your free trial by adding an Azure subscription](customers/quickstart-trial-setup.md#upgrade-your-free-trial-by-adding-an-azure-subscription).

       :::image type="content" source="media/external-identities-pricing/billing-section-no-subscription.png" alt-text="Screenshot of how to upgrade and link a subscription.":::

## What if I can't find a subscription?

If no subscriptions are available in the **Link a subscription** pane, here are some possible reasons:

- You don't have the appropriate permissions. Be sure to sign in with an Azure account that's assigned at least the Contributor role within the subscription or a resource group within the subscription.

- A subscription exists, but it isn't associated with your directory yet. You can [associate an existing subscription to your tenant](~/fundamentals/how-subscriptions-associated-directory.yml) and then repeat the steps for [linking it to your tenant](#link-your-azure-ad-tenant-to-a-subscription).

- No subscription exists. In the **Link a subscription** pane, you can create a subscription by selecting the link **if you don't already have a subscription you may create one here**. After you create a new subscription, you'll need to [create a resource group](/azure/azure-resource-manager/management/manage-resource-groups-portal) in the new subscription, and then repeat the steps for [linking it to your tenant](#link-your-azure-ad-tenant-to-a-subscription).

## Next steps

For the latest pricing information, see [Microsoft Entra pricing](https://www.microsoft.com/security/business/identity-access-management/azure-ad-pricing).
