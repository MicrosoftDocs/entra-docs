---
title: External ID Pricing
description: Learn about the pricing and billing structure for Microsoft Entra External ID, along with steps for linking an external tenant to an Azure subscription.
ms.topic: concept-article
ms.date: 06/22/2026
ai-usage: ai-assisted
ms.collection: M365-identity-device-management
ms.custom: sfi-image-nochange
#customer intent: As a Microsoft Entra tenant administrator, I want to link my tenant to an Azure subscription so that I can take advantage of the monthly active users (MAU) billing model and activate MAU billing for guest user collaboration.
---

# Microsoft Entra External ID pricing and billing overview

[!INCLUDE [applies-to-workforce-external](./includes/applies-to-workforce-external.md)]

This article outlines the pricing and billing structure for Microsoft Entra External ID. External ID uses a basic monthly active users (MAU) billing model with optional premium add-ons for advanced scenarios. It also describes how to link your tenant to an Azure subscription to ensure correct billing and feature access.

For the latest pricing details, see [External ID pricing](https://aka.ms/ExternalIDPricing).

## External ID billing model

The basic External ID billing model is based on monthly active users (MAU), which is the count of unique external users who authenticate to your tenants within a calendar month. To determine the total number of MAUs, we combine MAUs from all workforce and external tenants that are linked to a subscription.

MAU billing helps reduce your costs by offering a free tier and flexible, predictable pricing. You can get started for free and pay for only what you use as your business grows.

The MAU billing model for External ID applies to all guest users. Guest users include:

- External guests for B2B collaboration in Microsoft Entra [workforce tenants](tenant-configurations.md#workforce-tenants). These users sign in with *external* credentials. Their `UserType` property is set to `Guest`.

   > [!NOTE]
   > If you own and operate multiple tenants, your member users can authenticate across your tenants without being counted in the MAU total. For B2B collaboration, the MAU billing model applies only to external users who have a `UserType` value of `Guest`. It doesn't apply to users who originate from within the organization and have a `UserType` value of `Member`.

- Internal guests in Microsoft Entra. These users sign in with `internal` credentials. Their `UserType` property is set to `Guest`.

- External users in Microsoft Entra [external tenants](tenant-configurations.md#external-tenants):

  - Consumers and business guests (users without directory roles)
  - Admins (users with directory roles)
  
  MAU billing applies to all users in an external tenant regardless of their `UserType` setting.

For more info about the differences between internal and external guests, see [Understand and manage the properties of B2B guest users](user-properties.md).

## Premium add-ons

In addition to the basic MAU billing, External ID provides premium add-ons that extend functionality for advanced scenarios. Each add-on has its own billing model. The following table summarizes the available add-ons.

| Add-on | Tenant configuration | Billing model | Description |
|---|---|---|---|
| **M2M Authentication** | External | Transaction-based | Authentication using OAuth 2.0 client credentials flows for machine-to-machine (M2M) authentication scenarios without user interaction. Charges are based on the number of authentication transactions. |
| **SMS Phone Authentication** | Workforce, External | Transaction-based | Additional charges for each SMS-based authentication event (text only; voice isn't supported). For more information, see [Features and licenses for Microsoft Entra multifactor authentication](~/identity/authentication/concept-mfa-licensing.md). |
| **Go-Local** | External | MAU-based | Store external identity data in a specific geographic region to meet data residency requirements. Currently available only in Australia and Japan. |
| **ID Governance** | Workforce | MAU-based | Govern guest users with premium features in Microsoft Entra ID Governance. For more information, see [Microsoft Entra ID Governance licensing for guest users](~/id-governance/microsoft-entra-id-governance-licensing-for-guest-users.md). |
| **GSA for Guests** | Workforce | MAU-based | Global Secure Access (GSA) coverage for guest users in workforce tenants. |

> [!NOTE]
> Premium add-on charges are in addition to the basic MAU billing. For the latest information about add-on pricing, see [External ID pricing](https://aka.ms/ExternalIDPricing).

## Billing scenarios

The following examples illustrate how basic MAU billing and premium add-ons work together. Each scenario indicates the tenant configurations it applies to (workforce or external). For more information, see [Tenant configurations](tenant-configurations.md). These scenarios are conceptual and don't include specific prices. For current pricing, see [External ID pricing](https://aka.ms/ExternalIDPricing).

### Scenario 1: Consumer app with basic sign-in (external tenant)

A consumer-facing app registered in an external tenant has 10,000 users who sign in using email and password or social identity providers. No premium add-ons are enabled.

- **Tenant configuration**: External
- **Applicable add-on SKU**: None
- **Meter type**: MAU
- **MAU count**: 10,000
- **Result**: No cost if MAU usage is within free limits.

### Scenario 2: M2M Authentication (external tenant)

A background service, such as a console app, runs continuously and authenticates with Microsoft Entra External ID using client credentials. The app calls an API on its own behalf without any user interaction and refreshes its access token hourly.

- **Tenant configuration**: External
- **Applicable add-on SKU**: M2M Authentication
- **Meter type**: Transaction (M2M Authentication)
- **MAU count**: 0 (M2M authentication doesn't involve user sign-ins, so no MAU charges apply)
- **Description**: Transaction charges based on the number of client credential authentication requests; for example, one token refresh per hour produces approximately 720 transactions per month.
- **Result**: Only M2M Authentication add-on charges apply. For current transaction pricing, see [External ID pricing](https://aka.ms/ExternalIDPricing).

### Scenario 3: Consumer app with interactive users and M2M calls (external tenant)

A consumer app in an external tenant has 5,000 users who sign in interactively. The app also uses M2M Authentication (client credentials) for background processing tasks, such as syncing data and sending notifications.

- **Tenant configuration**: External
- **Applicable add-on SKU**: M2M Authentication
- **Meter type**: MAU and transaction (M2M Authentication)
- **MAU count**: 5,000 (interactive users only; M2M Authentication calls don't count toward MAU)
- **Description**: Transaction charges based on the number of client credential authentication requests.
- **Result**: Microsoft Entra External ID Basic MAU charges for interactive users, plus M2M Authentication add-on charges for background processing.

### Scenario 4: B2B collaboration with ID Governance (workforce tenant)

An organization invites 2,000 external business partners as B2B collaboration guests in their workforce tenant. The organization uses ID Governance to manage machine learning assisted access reviews for guest users.

- **Tenant configuration**: Workforce
- **Applicable add-on SKU**: ID Governance
- **Meter type**: MAU
- **MAU count**: 2,000
- **Description**: Charges for guests who trigger governance actions during the month, such as machine learning assisted access reviews; for more information, see [Microsoft Entra ID Governance licensing for guest users](~/id-governance/microsoft-entra-id-governance-licensing-for-guest-users.md).
- **Result**: Microsoft Entra External ID Basic MAU charges plus ID Governance add-on charges.

### Scenario 5: Consumer app with data residency (external tenant)

A consumer app in an external tenant has 8,000 users who sign in interactively. The organization enables the Go-Local add-on to store external identity data in a specific geographic region to meet data residency requirements. The Go-Local add-on is currently available only in Australia and Japan.

- **Tenant configuration**: External
- **Applicable add-on SKU**: Go-Local
- **Meter type**: MAU
- **MAU count**: 8,000
- **Description**: MAU-based charges for storing external identity data in the selected region, in addition to the basic MAU charges.
- **Result**: Microsoft Entra External ID Basic MAU charges plus Go-Local add-on charges.

## Subscription requirements

External ID requires an Azure subscription for billing. The following sections describe how to link a workforce or external tenant to a subscription. For pricing details, see [External ID pricing](https://aka.ms/ExternalIDPricing).

> [!NOTE]
> If you previously subscribed to B2B collaboration under an Azure AD External Identities P1/P2 SKU, see the [External ID pricing](https://aka.ms/ExternalIDPricing) page for information about current pricing options and any available upgrade paths.

<a name='link-your-azure-ad-tenant-to-a-subscription'></a>

## Link a workforce tenant to a subscription

Microsoft Entra workforce tenants must be linked to an Azure subscription for proper billing and access to features. To link your tenant to a subscription:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com/). Use an account that has at least the Contributor role within the subscription or a resource group within the subscription.

1. Select the directory that you want to link:

   1. On the toolbar, select the **Settings** icon.
   1. On the **Directories + subscriptions** pane, find your workforce tenant in the **Directory name** list. Then select **Switch**.

1. Go to **Entra ID** > **External Identities** > **Overview**.

1. Under **Subscriptions**, select **Linked subscriptions**.

1. In the tenant list, select the checkbox next to the tenant, and then select **Link subscription**.

    :::image type="content" source="media/external-identities-pricing/linked-subscriptions.png" alt-text="Screenshot of actions for linking a subscription.":::

1. On the **Link a subscription** pane, select a subscription and a resource group. Then select **Apply**. (If no subscriptions are listed, see [What if I can't find a subscription?](#what-if-i-cant-find-a-subscription) later in this article.)

    :::image type="content" source="media/external-identities-pricing/link-subscription-resource.png" alt-text="Screenshot of boxes for selecting a subscription and a resource group.":::

After you complete these steps, your Azure subscription is billed based on your Azure direct or Enterprise Agreement details, if applicable.

### What if I can't find a subscription?

If no subscriptions are available on the **Link a subscription** pane, here are some possible reasons:

- You're trying link a workforce tenant to a subscription, but you're currently signed in to an external tenant. Switch to the workforce tenant:

  1. On the Microsoft Entra admin center toolbar, select **Settings**.
  1. On the **Directories + subscriptions** pane, find your workforce tenant in the list. Then select **Switch**.

- You don't have the appropriate permissions. Be sure to sign in by using an Azure account that has at least the Contributor role within the subscription or a resource group within the subscription.

- A subscription exists, but it isn't associated with your directory yet. You can [associate an existing subscription with your tenant](~/fundamentals/how-subscriptions-associated-directory.md) and then repeat the steps for [linking it to your tenant](#link-your-azure-ad-tenant-to-a-subscription).

- No subscription exists. On the **Link a subscription** pane, you can create a subscription by selecting the link **If you don't already have a subscription you may create one here**.

  After you create a new subscription, you need to [create a resource group](/azure/azure-resource-manager/management/manage-resource-groups-portal) in the new subscription. Then, repeat the steps for [linking it to your tenant](#link-your-azure-ad-tenant-to-a-subscription).

<a name='link-an-external-tenant-to-a-subscription'></a>

## Link an external tenant to a subscription

Depending on how you created your external tenant, it might already be linked to a subscription. To find out, follow these steps:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com/).

1. Make sure your external tenant is selected:

   1. On the toolbar, select the **Settings** icon.
   1. On the **Directories + subscriptions** pane, find your external tenant in the **Directory name** list. Then select **Switch**.

1. Select **Home** and find the **Billing** section. Then take one of these actions:

   - If your tenant is linked to a subscription, the subscription ID appears in this section. You can select the ID to view subscription details.

       :::image type="content" source="media/external-identities-pricing/billing-section-subscription.png" alt-text="Screenshot that shows an example external tenant linked to a subscription.":::

   - If your tenant isn't yet linked to a subscription, in the **Billing** section, select the **Click here to upgrade** link. Then select the **Add Subscription** button.

       :::image type="content" source="media/external-identities-pricing/billing-section-no-subscription.png" alt-text="Screenshot that shows an example external tenant that has no subscriptions.":::

## Change the subscription that your external tenant is linked to

You can move an external tenant to another subscription, as long as the subscription that you want to use is in the same Microsoft Entra workforce tenant as the current subscription. Moving to a subscription in a *different* Microsoft Entra workforce tenant isn't currently supported.

To move your external tenant resources to the new subscription, use Azure Resource Manager as described in [Move Azure resources to a new resource group or subscription](/azure/azure-resource-manager/management/move-resource-group-and-subscription). Before you start, read the article to fully understand the limitations and requirements. The article also contains other critical information, such as a pre-move checklist and steps for validating the move operation.

## Can I change the ownership of a subscription?

You can't change the ownership of a subscription to a Microsoft Entra external tenant. External tenants don't have subscription management capabilities. External tenants must be linked to subscriptions that Microsoft Entra workforce tenants own.

## Related content

- See the [frequently asked questions](customers/faq-customers.md) about external tenants.
- For the latest pricing information, see [Microsoft Entra External ID pricing](https://aka.ms/ExternalIDPricing).
