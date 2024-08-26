---
title: Quickstart - Set up an external tenant free trial
description: Use our quickstart to set up the external tenant free trial.
 
author: csmulligan
manager: CelesteDG
ms.service: entra-external-id
 
ms.subservice: customers
ms.topic: quickstart
ms.date: 08/15/2024
ms.author: cmulligan
ms.custom: it-pro

#Customer intent: As a dev, devops, or IT admin, I want to set up the external tenant free trial.
---
# Quickstart: Get started with Microsoft Entra External ID free trial

[!INCLUDE [applies-to-external-only](../includes/applies-to-external-only.md)]

Get started with Microsoft External ID for consumer and business customer apps, which lets you create secure, customized sign-in experiences for your apps and services. With these built-in external configuration features, Microsoft Entra External ID can serve as the identity provider and access management service for your customers.

In this quickstart, you'll learn how to set up an external tenant free trial. If you're a developer using Visual Studio Code, you can also set up a free trial through the Microsoft Entra External ID extension ([learn more](visual-studio-code-extension.md)). 
If you already have an Azure subscription, you can create a tenant with external configurations in the Microsoft Entra admin center. For more information about how to create a tenant, see [Set up a tenant](quickstart-tenant-setup.md).

Your free trial of a tenant with external configurations provides you with the opportunity to try new features and build applications and processes during the free trial period. Organization (tenant) admins can invite other users. Each user account can only have one active free trial tenant at a time. 

The free trial is intended only for evaluation purposes and should not be used for scale testing or production workloads. It is currently in preview mode.

Trial tenant will support up to 10K resources, learn more about Microsoft Entra service limits [here](~/identity/users/directory-service-limits-restrictions.md). During your free trial, you'll have the option to unlock the full set of features by upgrading to [Azure free account](https://azure.microsoft.com/free/).

   > [!NOTE]
   > At the end of the free trial period, your free trial tenant will be disabled and deleted. You can always come back and register for another trial using this link: https://aka.ms/ciam-free-trial. 
    
During the free trial period, you'll have access to all product features with few exceptions. See the following table for comparison: 

|  Features | Microsoft Entra External ID Trial (without credit card) | Microsoft Entra account includes Partners (needs credit card)  | 
|----------|:-----------:|:------------:|
| **Self-service account experiences** (Sign-up, sign-in, and password recovery.)   | :heavy_check_mark: |  :heavy_check_mark:  | 
| **MFA** (With email OTP.)  | :x: |  :heavy_check_mark:  |  
| **Custom token augmentation** (From external sources.) |  :heavy_check_mark: |  :heavy_check_mark:  |
| **Social identity providers**   |  :heavy_check_mark: |  :heavy_check_mark:  |
| **Identity Protection** (Conditional Access for adaptive risk-based policies.)  | :x: |  :heavy_check_mark:  |
| Default, least-access privileges for CIAM end-users. |  :heavy_check_mark: |  :heavy_check_mark:  |
| **Rich authorization** (Including group and role management.)  |  :heavy_check_mark: |  :heavy_check_mark:  | 
| **Customizable** (Sign-in/sign-up experiences - background, logo, strings.) |  :heavy_check_mark: |  :heavy_check_mark:  |
| Group and User management. |  :heavy_check_mark: |  :heavy_check_mark:  |
| **Cloud-agnostic solution** with multi-language auth SDK support.  |  :heavy_check_mark: |  :heavy_check_mark:  | 

## Get started with trying out External ID

1. Open your browser and visit <a href="https://aka.ms/ciam-free-trial?wt.mc_id=ciamcustomertenantfreetrial_linkclick_content_cnl" target="_blank">https://aka.ms/ciam-free-trial</a>.
1. You can sign in to the external trial tenant using your personal account, and your Microsoft account (MSA) or GitHub account.  
1. You'll notice that a domain name and location have been set for you. The domain name and the data location can't be changed later in the free trial. Select **Change settings** if you would like to adjust them.
1. Select **Continue** and hang on while we set up your trial. It will take a few minutes for the trial to become ready for the next step.

    :::image type="content" source="media/quickstart-trial-setup/setting-up-free-trial.png" alt-text="Screenshot of the loading page while setting up the external tenant free trial."::: 

## Get started guide

Once your external tenant free trial is ready, the next step is to personalize your customer's sign-in and sign-up experience, set up a user in your tenant, and configure a sample app. The [get started guide](https://aka.ms/ciam/free-trial-hero) will walk you through all of these steps in just a few minutes. For more information about the next steps, see the [get started guide](quickstart-get-started-guide.md) article. 

## Upgrade your free trial by adding an Azure subscription

You can upgrade your 30 days free trial of a tenant with external configurations to unlock the full set of features. 

### Upgrade your free trial with a new Azure subscription

If you don't have any Azure subscriptions, follow the steps below.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com). 
1. Browse to **Home** > **Tenant overview**. 
1. Select **Upgrade**.

    :::image type="content" source="media/quickstart-trial-setup/upgrade-trial-button.jpg" alt-text="Screenshot of the upgrade trial button." lightbox="media/quickstart-trial-setup/upgrade-trial-button.jpg"::: 

1. On the https://signup.azure.com/ page fill in the required information to complete your Azure account setup and select **Sign up** and **Submit**. You'll be redirected to the Azure portal.
1. To link your new Azure subscription to your tenant, select **Add subscription**.

    :::image type="content" source="media/quickstart-trial-setup/add-subsription.png" alt-text="Screenshot of adding a subscription to the tenant" lightbox="media/quickstart-trial-setup/add-subsription.png"::: 

1. Enter the following values:

   - **Subscription**: Select your Azure subscription.
   - **Resource group**: Create a new resource group. It can take a few seconds.
   - **Resource group location**: Select an Azure location.

    :::image type="content" source="media/quickstart-trial-setup/create-resource-group.png" alt-text="Screenshot of creating a resource group." lightbox="media/quickstart-trial-setup/create-resource-group.png"::: 

1. Select **Add**. 
1. After a few seconds, you'll see a notification that you successfully linked your subscription to the tenant. From here you can switch to your upgraded tenant. 

    :::image type="content" source="media/quickstart-trial-setup/switch-to-tenant.png" alt-text="Screenshot of the switch to tenant link." lightbox="media/quickstart-trial-setup/switch-to-tenant.png":::


### Upgrade your free trial with an existing tenant subscription

If your free trial belongs to an account with an existing Azure subscription, you can upgrade your free trial with the existing subscription. To associate your free trial with an existing tenant to unlock the full set of features follow the steps below.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com). 
1. Browse to **Home** > **Tenant overview**. 
1. Select **Add Subscription**.
1. Select a tenant from the menu and select **Switch**.

    :::image type="content" source="media/quickstart-trial-setup/add-existing-subscription.png" alt-text="Screenshot of the existing subscription screen." lightbox="media/quickstart-trial-setup/add-existing-subscription.png"::: 

1. Select the subscription and resource group you want to associate with your tenant and select **Add**. Upgrading the trial tenant can take a few seconds.
1. After a few seconds, you'll see a notification that you successfully linked your subscription to the tenant. From here you can switch to your upgraded tenant. 

    :::image type="content" source="media/quickstart-trial-setup/switch-to-tenant.png" alt-text="Screenshot of the switch to tenant link." lightbox="media/quickstart-trial-setup/switch-to-tenant.png" :::

