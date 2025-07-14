---
title: Enable Microsoft Entra Permissions Management in your organization
description: How to enable Microsoft Entra Permissions Management in your organization.
author: jenniferf-skc
manager: pmwongera
ms.service: entra-permissions-management
ms.topic: how-to
ms.date: 05/02/2025
ms.author: jfields
ms.custom: sfi-ga-nochange
---

# Enable Microsoft Entra Permissions Management in your organization

> [!NOTE]
> Effective April 1, 2025, Microsoft Entra Permissions Management will no longer be available for purchase, and on October 1, 2025, we'll retire and discontinue support of this product. More information can be found [here](https://aka.ms/MEPMretire).

This article describes how to enable Microsoft Entra Permissions Management in your organization. Once you've enabled Permissions Management, you can connect it to your Amazon Web Services (AWS), Microsoft Azure, or Google Cloud Platform (GCP) platforms.

> [!NOTE]
> To complete this task, you must have at least [*Billing Administrator*](https://go.microsoft.com/fwlink/?linkid=2248574) permissions. You can't enable Permissions Management as a user from another tenant who has signed in via B2B or via Azure Lighthouse.

:::image type="content" source="media/onboard-enable-tenant/dashboard.png" alt-text="Screenshot of the Microsoft Entra Permissions Management dashboard." lightbox="media/onboard-enable-tenant/dashboard.png":::

## Prerequisites

To enable Permissions Management in your organization:

- You must have a Microsoft Entra tenant. If you don't already have one, [create a free account](https://azure.microsoft.com/free/).
- You must be eligible for or have an active assignment to the *Permissions Management Administrator* role as a user in that tenant.

<a name='how-to-enable-permissions-management-on-your-azure-ad-tenant'></a>

## How to enable Permissions Management on your Microsoft Entra tenant

1. In your browser:
    1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com/#home) as at least a [Billing Administrator](https://go.microsoft.com/fwlink/?linkid=2254515).
    1. If needed, activate the *Permissions Management Administrator* role in your Microsoft Entra tenant.
    1. Browse to **Entra ID**, then select **Go to Microsoft Entra ID**.
    1. In the Entra ID portal, select **Microsoft Entra Permissions Management**, then select the link to purchase a license or begin a trial.


## Activate a free trial or paid license 
There are two ways to activate a trial or a full product license. 
- The first way is to go to the [Microsoft 365 admin center](https://admin.microsoft.com).
    - Sign in as a *Global Administrator* for your tenant.
    - Go to Setup and sign up for a Microsoft Entra Permissions Management trial. 
    - For self-service, Go to the [Microsoft 365 portal](https://aka.ms/TryPermissionsManagement) to sign up for a 45-day free trial or to purchase licenses. 
- The second way is through Volume Licensing or Enterprise agreements. 
    - If your organization falls under a volume license or enterprise agreement scenario, contact your Microsoft representative.

Permissions Management launches with the **Data Collectors** dashboard.

## Configure data collection settings

Use the **Data Collectors** dashboard in Permissions Management to configure data collection settings for your authorization system.

1. If the **Data Collectors** dashboard isn't displayed when Permissions Management launches:

    - In the Permissions Management home page, select **Settings** (the gear icon), then select the **Data Collectors** subtab.

1. Select the authorization system you want: **AWS**, **Azure**, or **GCP**.

1. For information on how to onboard an AWS account, Azure subscription, or GCP project into Permissions Management, select one of the following articles and follow the instructions:

    - [Onboard an AWS account](onboard-aws.md)
    - [Onboard an Azure subscription](onboard-azure.md)
    - [Onboard a GCP project](onboard-gcp.md)

## Next steps

- For an overview of Permissions Management, see [What's Microsoft Entra Permissions Management?](overview.md)
