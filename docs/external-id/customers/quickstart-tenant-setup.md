---
title: External Tenant Quickstart
description: In this quickstart, learn how to create an external tenant for customer identity and access management (CIAM). Customize a sign-in experience and try it out with a sample app.
 
author: csmulligan
manager: CelesteDG
ms.service: entra-external-id
 
ms.subservice: customers
ms.topic: quickstart
ms.date: 08/13/2024
ms.author: cmulligan
ms.custom: it-pro, seo-july-2024

#Customer intent: As a dev, devops, or IT admin, I want to create a tenant with external configurations.
---
# Quickstart: Use your Azure subscription to create an external tenant

[!INCLUDE [applies-to-external-only](../includes/applies-to-external-only.md)]

Microsoft Entra External ID offers a customer identity access management (CIAM) solution that lets you create secure, customized sign-in experiences for your apps and services. You'll need to create a tenant with external configurations in the Microsoft Entra admin center to get started. Once the tenant with external configurations is created, you can access it in both the Microsoft Entra admin center and the Azure portal.

In this quickstart, you'll learn how to create a tenant with external configurations if you already have an Azure subscription.

## Prerequisites

- An Azure subscription. 
- An Azure account that's been assigned at least the [Contributor](/azure/role-based-access-control/built-in-roles#contributor) role scoped to the subscription or to a resource group within the subscription.

## Create a new tenant with external configurations 

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com). 
1. Browse to **Identity** > **Overview** > **Manage tenants**.
1. Select **Create**.

    :::image type="content" source="media/how-to-create-external-tenant-portal/create-tenant.png" alt-text="Screenshot of the create tenant option.":::

1. Select **External**, and then select **Continue**. 

    :::image type="content" source="media/how-to-create-external-tenant-portal/select-tenant-type.png" alt-text="Screenshot of the select tenant type screen.":::

1. On the **Basics** tab, in the **Create a tenant** page, enter the following information:

    :::image type="content" source="media/how-to-create-external-tenant-portal/add-basics-to-external-tenant.png" alt-text="Screenshot of the Basics tab.":::

    - Type your desired **Tenant Name** (for example *Contoso Customers*).

    - Type your desired **Domain Name** (for example *Contosocustomers*).

    - Select your desired **Location**. This selection can't be changed later.

1. Select **Next: Add a subscription**.  

1. On the **Add a subscription** tab, enter the following information:

   - Next to **Subscription**, select your subscription from the menu.

   - Next to **Resource group**, select a resource group from the menu. If there are no available resource groups, select **Create new**, add a name, and then select **OK**.

   - If **Resource group location** appears, select the geographic location of the resource group from the menu.

    :::image type="content" source="media/how-to-create-external-tenant-portal/add-subscription.png" alt-text="Screenshot that shows the subscription settings.":::

1. Select **Next: Review + create**. If the information that you entered is correct, select **Create**. The tenant creation process can take up to 30 minutes. You can monitor the progress of the tenant creation process in the **Notifications** pane. Once the tenant is created, you can access it in both the Microsoft Entra admin center and the Azure portal.

    :::image type="content" source="media/how-to-create-external-tenant-portal/tenant-successfully-created.png" alt-text="Screenshot that shows the link to the new tenant.":::

## Customize your tenant with a guide

Our guide will walk you through the process of setting up a user and configuring a sample app in just a few minutes. This means that you can quickly and easily test out different sign-in and sign-up options and set up a sample app to see what works best for you. This guide is available in any external tenant.

> [!NOTE]
> The guide won’t run automatically in external tenants that you created with the steps above. If you want to run the guide, follow the steps below.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com). 
1. If you have access to multiple tenants, use the **Settings** icon :::image type="icon" source="media/common/admin-center-settings-icon.png" border="false"::: in the top menu to switch to your external tenant from the **Directories + subscriptions** menu.
1. Browse to **Home** > **Tenant overview**. 
1. On the Get started tab, select **Start the guide**.

    :::image type="content" source="media/how-to-create-external-tenant-portal/guide-link.png" alt-text="Screenshot that shows how to start the guide.":::

This link will take you to the [guide](quickstart-get-started-guide.md), where you can customize your tenant in three easy steps.

## Related content
- To learn more about the set-up guide and how to customize your tenant, see the [Get started guide](quickstart-get-started-guide.md) article.
- To learn how to delete your tenant, see the [Delete an external tenant](how-to-delete-external-tenant-portal.md) article. 
