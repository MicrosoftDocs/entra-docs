---
title: MAU billing model for Microsoft Entra External ID
description: Learn about Microsoft Entra External ID monthly active users (MAU) billing model for guest user collaboration (B2B) in Microsoft Entra External ID. Learn how to link your Microsoft Entra tenant to an Azure subscription.

 
ms.service: entra-external-id
ms.topic: concept-article
ms.date: 07/24/2024

ms.author: mimart
author: msmimart
manager: celestedg
 
ms.collection: M365-identity-device-management
#customer intent: As a Microsoft Entra tenant administrator, I want to link my tenant to an Azure subscription, so that I can take advantage of the monthly active users (MAU) billing model and activate MAU billing for guest user collaboration.
---

# Billing model for Microsoft Entra External ID

[!INCLUDE [applies-to-workforce-external](./includes/applies-to-workforce-external.md)]

## External ID pricing

Microsoft Entra External ID pricing is based on monthly active users (MAU), which is the count of unique users with authentication activity within a calendar month. This billing model applies to Microsoft Entra External ID in both workforce and external tenants, as well as [Azure AD B2C tenants](/azure/active-directory-b2c/billing). MAU billing helps you reduce costs by offering a free tier and flexible, predictable pricing. In this article, learn about MAU billing and linking your Microsoft Entra tenants to a subscription.

> [!IMPORTANT]
> For the latest information about usage billing and pricing, see [Microsoft Entra pricing](https://www.microsoft.com/security/business/identity-access-management/azure-ad-pricing).
>
> In Azure Government, the External ID billing model doesn't apply because the service is available through Preview only.

### How is External ID licensed?

Microsoft Entra External ID pricing is based on monthly active users (MAU), which is the count of unique users with authentication activity within a calendar month. External ID consists of a core offer and premium add-ons. We're currently offering an extended free trial for all features in the core offer. We won't start enforcing External ID core offer pricing until July 1, 2024.*  

After July 1, you can still get started for free and only pay for what you use as your business grows. The Microsoft Entra External ID core offering is free for the first 50,000 MAU, and additional active users are priced at $0.03 USD per MAU (with a launch discounted price of $0.01625 USD per MAU until May 2025).

> [!NOTE]
> Existing subscriptions to Azure Active Directory B2C (Azure AD B2C) B2C or B2B collaboration under an Azure AD External Identities P1/P2 SKU remain valid and no migration is necessary. We'll communicate upgrade options once they're available. For multitenant organizations, identities whose UserType is external member aren't counted as part of the External ID MAU. Only internal and external guests count as External ID MAU.

|MAU  | Core offer pricing        |
|------------|---------|
|1-50 K MAU   |Free        |
|50 K+ MAU    |Discounted rate: $0.01625 USD per MAU until May 2025<br/>Standard rate: $0.03 USD per MAU |

External ID premium features are available as add-ons. These premium features don't have a free tier.

|Premium add-on feature  | Add-on pricing          |
|---------------------|------------------|
|ID Governance        |Free while the ID Governance feature is in preview for External ID<br/>Standard rate: $0.75 USD per MAU

### Does the 50,000 MAU free tier apply to add-ons?

No, External ID add-ons don't have a free tier. However, while the ID Governance premium feature for External ID is in preview, there is no charge for the add-on.

### Does External ID have phone authentication via SMS?

Yes, this feature is currently available in workforce configurations. Once it is supported in external configurations, it will be offered as an add-on for External ID. We will release pricing details soon.

## MAU billing and B2B collaboration

In a Microsoft Entra workforce tenant, B2B collaboration usage is billed based on the count of unique guest users with authentication activity within a calendar month. This model replaces the 1:5 ratio billing model, which allowed up to five guest users for each Microsoft Entra ID P1 or P2 license in your tenant. When your tenant is linked to a subscription and you use External ID features to collaborate with guest users, you're automatically billed using the MAU-based billing model.

Your first 50,000 MAUs per month are free for both Premium P1 and Premium P2 features. To determine the total number of MAUs, we combine MAUs from all your tenants (both External ID and Azure AD B2C) that are linked to the same subscription.

The pricing tier that applies to your guest users is based on the highest pricing tier assigned to your Microsoft Entra tenant. For more information, see [Microsoft Entra External ID Pricing](https://azure.microsoft.com/pricing/details/active-directory/external-identities/).

<a name='link-your-azure-ad-tenant-to-a-subscription'></a>

## Link your Microsoft Entra tenant to a subscription

A Microsoft Entra tenant must be linked to a resource group within an Azure subscription for proper billing and access to features.

|If your tenant is:  |You need to:  |
|---------|---------|
| A Microsoft Entra tenant already linked to a subscription     | Do nothing. When you use External ID features to collaborate with guest users, you're automatically billed using the MAU model.        |
| A Microsoft Entra workforce tenant not yet linked to a subscription     | [Link your Microsoft Entra tenant to a subscription](#link-your-azure-ad-tenant-to-a-subscription) to activate MAU billing.        |

### To link your tenant to an Azure subscription

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com/) with an account that's assigned at least the Contributor role within the subscription or a resource group within the subscription.

2. Select the directory you want to link: In the Microsoft Entra admin center toolbar, select the **Settings** icon in the portal toolbar. Then on the **Portal settings | Directories + subscriptions** page, find your directory in the **Directory name** list, and then select **Switch**.

3. Browse to **Identity** > **External identities** > **Overview**.

5. Under **Subscriptions**, select **Linked subscriptions**.

6. In the tenant list, select the checkbox next to the tenant, and then select **Link subscription**.

    :::image type="content" source="media/external-identities-pricing/linked-subscriptions.png" alt-text="Screenshot of the link a subscription option.":::

7. In the **Link a subscription** pane, select a **Subscription** and a **Resource group**. Then select **Apply**. (If there are no subscriptions listed, see [What if I can't find a subscription?](#what-if-i-cant-find-a-subscription).)

    :::image type="content" source="media/external-identities-pricing/link-subscription-resource.png" alt-text="Screenshot of how to link a subscription.":::

After you complete these steps, your Azure subscription is billed based on your Azure Direct or Enterprise Agreement details, if applicable.

### What if I can't find a subscription?

If no subscriptions are available in the **Link a subscription** pane, here are some possible reasons:

- You don't have the appropriate permissions. Be sure to sign in with an Azure account that's assigned at least the Contributor role within the subscription or a resource group within the subscription.

- A subscription exists, but it isn't associated with your directory yet. You can [associate an existing subscription to your tenant](~/fundamentals/how-subscriptions-associated-directory.yml) and then repeat the steps for [linking it to your tenant](#link-your-azure-ad-tenant-to-a-subscription).

- No subscription exists. In the **Link a subscription** pane, you can create a subscription by selecting the link **if you don't already have a subscription you may create one here**. After you create a new subscription, you'll need to [create a resource group](/azure/azure-resource-manager/management/manage-resource-groups-portal) in the new subscription, and then repeat the steps for [linking it to your tenant](#link-your-azure-ad-tenant-to-a-subscription).

## Next steps

For the latest pricing information, see [Microsoft Entra pricing](https://www.microsoft.com/security/business/identity-access-management/azure-ad-pricing).
