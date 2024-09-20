---
title: Azure Monitor in external tenants
description: Learn how to set up Azure Monitor in external tenants to collect and analyze data in your tenant.

author: csmulligan
manager: celestedg
ms.service: entra-external-id 
ms.subservice: customers
ms.topic: how-to 
ms.date:  09/16/2024
ms.author: cmulligan

#Customer intent: As an it admin, I want to learn how to set up Azure Monitor in external tenants to collect and analyze data in this tenant.

---
# Set up Azure Monitor in external tenants (preview)

[!INCLUDE [applies-to-external-only](../includes/applies-to-external-only.md)]

[Azure Monitor](/azure/azure-monitor/overview) is a comprehensive solution for collecting, analyzing, and responding to monitoring data from your cloud and on-premises environments. The diagnostic settings on the monitored resource specify what data to send and where to send it. For Microsoft Entra, the destination options include Log Analytics, Azure Storage, and Azure Event Hubs.

<!-- Is there a graph / image I can use here?  -->
<!-- I can add a deployment overview: https://learn.microsoft.com/en-us/azure/active-directory-b2c/azure-monitor#deployment-overview  Do we have a graph / image? -->

To set up Azure Monitor in a workforce tenant, you need the subscription of the workforce tenant for all the setup steps. However, the external tenant doesn't have its own separate subscription. [Azure Lighthouse](/azure/lighthouse/overview) addresses this issue by projecting the workforce tenant's subscription and all its resources to the external tenant. This solution is called resource projection. Resource projection allows the external tenant (service provider) to manage the Log Analytics workspace owned by the workforce tenant (customer).

In this article, you'll learn how to send sign-in and audit logs from a Microsoft Entra External ID tenant to a Log Analytics workspace for long-term storage, querying, visualization, and alerting within Azure Monitor.

## Prerequisites

<!-- Check the least privileged role options here! -->

- An Azure subscription. If you don't have one, create a <a href="https://azure.microsoft.com/free/?WT.mc_id=A261C142F" target="_blank">free account</a> before you begin.
- A Microsoft Entra account with the [Owner](/azure/role-based-access-control/built-in-roles#owner) role in the Microsoft Entra subscription.
- An account in the external tenant that's been assigned at least the [Reports Reader](/entra/identity/role-based-access-control/permissions-reference#reports-reader) role. <!-- Source: https://learn.microsoft.com/en-us/entra/identity/role-based-access-control/delegate-by-task -->

## Configuration overview

To follow the configuration steps in this article, we recommend opening two separate browser windows or tabs: one for the workforce tenant and one for the external tenant. This setup will help you switch between the two tenants as needed.

## Step 1: Workforce tenant configuration - create resource group and logs workspace

### Create a resource group

First, create, or choose a resource group that contains the destination Log Analytics workspace that will receive data from external tenant. You'll specify the resource group name when you deploy the Azure Resource Manager template.

1. Sign in to the [Azure portal](https://portal.azure.com).
1. If you have access to multiple tenants, select the **Settings** icon in the top menu to switch to your Microsoft Entra ID tenant from the **Directories + subscriptions** menu.
1. [Create a resource group](../azure-resource-manager/management/manage-resource-groups-portal.md#create-resource-groups) or choose an existing one. This example uses a resource group named _ExtIDMonitor_.

### Create a Log Analytics workspace

A **Log Analytics workspace** is a unique environment for Azure Monitor log data. You'll use this Log Analytics workspace to collect data from external tenant, and then visualize it with queries.

1. Sign in to the [Azure portal](https://portal.azure.com).
1. If you have access to multiple tenants, select the **Settings** icon in the top menu to switch to your Microsoft Entra ID tenant from the **Directories + subscriptions** menu.
1. [Create a Log Analytics workspace](/azure/azure-monitor/logs/quick-create-workspace). This example uses a Log Analytics workspace named _ExtIDLogAnalytics_, in a resource group named _ExtIDMonitor_.

### Add Microsoft.Insights as a resource provider

Add Microsoft.Insights as a resource provider in the subscription. This can be done in the subscription’s settings menu on the left. 
In this step, you choose your external tenant as a **service provider**. You also define the authorizations you need to assign the appropriate Azure built-in roles to groups in your Microsoft Entra tenant.
To see all resource providers, and the registration status for your subscription:

1. Sign in to the [Azure portal](https://portal.azure.com).
1. On the Azure portal menu, search for **Subscriptions**. Select it from the available options.
1. Select the subscription you want to view.
1. On the left menu, under **Settings**, select **Resource providers**.
1. Find the resource provider you want to register.
1. Select the **Microsoft.Insights** resource provider, and select **Register**. 

## Step 2: External tenant configuration - get external tenant ID and create a group for external ID monitoring

### Get your external tenant ID

First, get the **Tenant ID** of your external tenant. You'll need this ID to configure the external tenant to send logs to the Log Analytics workspace in the workforce tenant.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com).
1. If you have access to multiple tenants, use the **Settings** icon :::image type="icon" source="media/common/admin-center-settings-icon.png" border="false"::: in the top menu and switch to your external tenant from the **Directories + subscriptions** menu.
1. Select **Tenant overview** and select **Overview**.
1. Record the **Tenant ID**.

### Create a group for external ID monitoring

Now create a group or user to which you want to give permission to the resource group you created earlier in the directory containing your subscription.

To make management easier, we recommend using Microsoft Entra user _groups_ for each role, allowing you to add or remove individual users to the group rather than assigning permissions directly to that user. In this walkthrough, we'll add a security group.

1. With **Microsoft Entra ID** still selected in your external tenant, select **Groups**, and then select a group. If you don't have an existing group, create a **Security** group, then add members. For more information, follow the procedure [Create a basic group and add members using Microsoft Entra ID](../active-directory/fundamentals/how-to-manage-groups.md).
1. Select **Overview**, and record the group's **Object ID**.

## Step 3: Workforce tenant configuration - configure Azure Lighthouse

### Create an Azure Resource Manager template

To create the custom authorization and delegation in Azure Lighthouse, we use an Azure Resource Manager template. This template grants the external tenant access to the Microsoft Entra resource group, which you created earlier, for example, _ExtIDMonitor_. Deploy the template from the GitHub sample by using the **Deploy to Azure** button, which opens the Azure portal and lets you configure and deploy the template directly in the portal. For these steps, make sure you're signed in to your Microsoft Entra workforce tenant (not the external tenant).

1. Sign in to the [Azure portal](https://portal.azure.com).
1. If you have access to multiple tenants, select the **Settings** icon in the top menu to switch to your Microsoft Entra ID tenant from the **Directories + subscriptions** menu. 
1. Use the **Deploy to Azure** button to open the Azure portal and deploy the template directly in the portal. For more information, see [create an Azure Resource Manager template](/azure/lighthouse/how-to/onboard-customer#create-an-azure-resource-manager-template).

   [![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fazure-ad-b2c%2Fsiem%2Fmaster%2Ftemplates%2FrgDelegatedResourceManagement.json)

1. On the **Custom deployment** page, enter the following information:

   | Field                 | Definition                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
   | --------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
   | Subscription          | Select the directory that contains the Azure subscription where the _ExtIDMonitor_ resource group was created.                                                                                                                                                                                                                                                                                                                                                                                                       |
   | Region                | Select the region where the resource will be deployed.                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
   | Msp Offer Name        | A name describing this definition. For example, _ExtIDMonitor_. It's the name that will be displayed in Azure Lighthouse.  The **MSP Offer Name** must be unique in your Microsoft Entra ID. To monitor multiple external tenants, use different names. |
   | Msp Offer Description | A brief description of your offer. For example, _Enables Azure Monitor in the external tenant_.                                                                                                                                                                                                                                                                                                                                                                                                                                     |
   | Managed By Tenant ID  | The **Tenant ID** of your external tenant (also known as the directory ID).                                                                                                                                                                                                                                                                                                                                                                                                                                              |
   | Authorizations        | Specify a JSON array of objects that include the Microsoft Entra ID `principalId`, `principalIdDisplayName`, and Azure `roleDefinitionId`. The `principalId` is the **Object ID** of the group or user that will have access to resources in this Azure subscription. For this walkthrough, specify the group's Object ID that you recorded earlier in the external tenant. For the `roleDefinitionId`, use the [built-in role](../role-based-access-control/built-in-roles.md) value for the _Contributor role_, `b24988ac-6180-42a0-ab88-20f7382dd24c`. |
   | Rg Name               | The name of the resource group you create earlier in your Microsoft Entra tenant. For example, _ExtIDMonitor_.                                                                                                                                                                                                                                                                                                                                                                                                |

   The following example demonstrates an Authorizations array with one security group.

   ```json
   [
     {
       "principalId": "<Replace with group's OBJECT ID>",
       "principalIdDisplayName": "external tenant administrators",
       "roleDefinitionId": "b24988ac-6180-42a0-ab88-20f7382dd24c"
     }
   ]
   ```

After you deploy the template, it can take a few minutes (typically no more than five) for the resource projection to complete. You can verify the deployment in your Microsoft Entra workforce tenant and get the details of the resource projection. For more information, see [View and manage service providers](/azure/lighthouse/how-to/view-manage-service-providers).

Itt tartok -----------------------------

## Step 4: External tenant configuration - – make workforce tenant subscription and resources visible

### Select your subscription
### Configure diagnostic settings


## Step 5: Workforce tenant configuration – query external tenant logs

### Visualize your data






## Next step -or- Related content

> [!div class="nextstepaction"]
> [Next sequential article title](link.md)

-or-

* [Related article title](link.md)
* [Related article title](link.md)
* [Related article title](link.md)

<!-- Optional: Next step or Related content - H2

Consider adding one of these H2 sections (not both):

A "Next step" section that uses 1 link in a blue box 
to point to a next, consecutive article in a sequence.

-or- 

A "Related content" section that lists links to 
1 to 3 articles the user might find helpful.

-->

<!--

Remove all comments except the customer intent
before you sign off or merge to the main branch.

-->