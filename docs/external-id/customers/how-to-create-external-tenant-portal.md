---
title: Create an External Tenant
description: Create an external tenant to get started with Microsoft Entra External ID as your customer identity and access management (CIAM) service. 
 
author: csmulligan
manager: celestedg
ms.service: entra-external-id
 
ms.subservice: customers
ms.topic: how-to
ms.date: 02/02/2024
ms.author: cmulligan
ms.custom: it-pro, seo-july-2024

#Customer intent: As an it admin, I want to learn how to create an external tenant in the  Microsoft Entra admin center. 
---

# Create an external tenant

[!INCLUDE [applies-to-external-only](../includes/applies-to-external-only.md)]

Microsoft Entra External ID offers a customer identity access management (CIAM) solution that lets you create secure, customized sign-in experiences for your apps and services. With these built-in CIAM features, Microsoft Entra External ID can serve as the identity provider and access management service for your customer scenarios. You'll need to create an external tenant in the Microsoft Entra admin center to get started. Once the external tenant is created, you can access it in both the Microsoft Entra admin center and the Azure portal.

In this article, you learn how to:

- Create an external tenant
- Switch to the directory containing your external tenant
- Find your external tenant name and ID in the Microsoft Entra admin center

## Prerequisites

- An Azure subscription. If you don't have one, create a <a href="https://azure.microsoft.com/free/?WT.mc_id=A261C142F" target="_blank">free account</a> before you begin.
- An Azure account that's been assigned at least the [Tenant Creator](/entra/identity/role-based-access-control/permissions-reference#tenant-creator) role scoped to the subscription or to a resource group within the subscription.



## Create a new external tenant  

1. Sign in to your organization's [Microsoft Entra admin center](https://entra.microsoft.com/) as at least a [Tenant Creator](/entra/identity/role-based-access-control/permissions-reference#tenant-creator). 
1. Browse to **Identity** > **Overview** > **Manage tenants**.
1. Select **Create**.

    :::image type="content" source="media/how-to-create-external-tenant-portal/create-tenant.png" alt-text="Screenshot of the create tenant option.":::

1. Select **Customer**, and then **Continue**. 

    :::image type="content" source="media/how-to-create-external-tenant-portal/select-tenant-type.png" alt-text="Screenshot of the select tenant type screen.":::

1. If you're creating an external tenant for the first time, you have the option to create a trial tenant that doesn't require an Azure subscription. Otherwise, use the Azure Subscription option to continue to the next step.
1. If you choose the 30-day free trial, an Azure subscription isn't required.
1. If you choose **Use Azure Subscription** option, then the admin center displays the tenant creation page. On the **Basics** tab, in the **Create a tenant for customers** page, enter the following information:

    :::image type="content" source="media/how-to-create-external-tenant-portal/add-basics-to-external-tenant.png" alt-text="Screenshot of the Basics tab.":::

    - Type your desired **Tenant Name** (for example *Contoso Customers*).

    - Type your desired **Domain Name** (for example *Contosocustomers*).

    - Select your desired **Location**. This selection can't be changed later.

1. Select **Next: Add a subscription**.  

1. On the **Add a subscription** tab, enter the following information:

   - Next to **Subscription**, select your subscription from the menu.

   - Next to **Resource group**, select a resource group from the menu. If there are no available resource groups, select **Create new**, type a **Name**, and then select **OK**.

   - If **Resource group location** appears, select the geographic location of the resource group from the menu.

    :::image type="content" source="media/how-to-create-external-tenant-portal/add-subscription.png" alt-text="Screenshot that shows the subscription settings.":::

1. Select **Next: Review + Create**. If the information that you entered is correct, select **Create**. The tenant creation process can take up to 30 minutes. You can monitor the progress of the tenant creation process in the **Notifications** pane. Once the external tenant is created, you can access it in both the Microsoft Entra admin center and the Azure portal.

    :::image type="content" source="media/how-to-create-external-tenant-portal/tenant-successfully-created.png" alt-text="Screenshot that shows the link to the new external tenant.":::

## Get the external tenant details

If you're not sure which directory contains your external tenant, you can find the tenant name and ID both in the Microsoft Entra admin center and in the Azure portal.

1. If you have access to multiple tenants, select the **Settings** icon :::image type="icon" source="media/common/admin-center-settings-icon.png" border="false"::: in the top menu to switch to the external tenant from the **Directories + subscriptions** menu.

    :::image type="content" source="media/how-to-create-external-tenant-portal/directories-subscription.png" alt-text="Screenshot of the Directories + subscriptions icon.":::

1. On the **Portal settings | Directories + subscriptions** page, find your external tenant in the **Directory name** list, and then select **Switch**. This step will bring you to the tenant's home page.
1. Select **Tenant overview** under **Quick navigation**. You can find the tenant **Name**, **Tenant ID** and **Primary domain** under the **Overview** tab.

    :::image type="content" source="media/how-to-create-external-tenant-portal/tenant-overview.png" alt-text="Screenshot of the tenant details.":::

You can find the same details if you go to **Microsoft Entra ID** in the Azure portal. On the **Microsoft Entra ID** page, you can find the tenant **Name**, **Tenant ID** and **Primary domain** under **Overview** > **Basic information**.

## Related content
- [Register an app](how-to-register-ciam-app.md)
- [Create user flows](how-to-user-flow-sign-up-sign-in-customers.md)
- [Delete an external tenant](how-to-delete-external-tenant-portal.md)
