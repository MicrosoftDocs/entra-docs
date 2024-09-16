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
1. [Create a resource group](../azure-resource-manager/management/manage-resource-groups-portal.md#create-resource-groups) or choose an existing one. This example uses a resource group named *ExtIDMonitoring*.

### Create a Log Analytics workspace

A **Log Analytics workspace** is a unique environment for Azure Monitor log data. You'll use this Log Analytics workspace to collect data from external tenant, and then visualize it with queries.

1. Sign in to the [Azure portal](https://portal.azure.com).
1. If you have access to multiple tenants, select the **Settings** icon in the top menu to switch to your Microsoft Entra ID tenant from the **Directories + subscriptions** menu.
1. [Create a Log Analytics workspace](/azure/azure-monitor/logs/quick-create-workspace). This example uses a Log Analytics workspace named *ExtIDLogAnalytics*, in a resource group named *ExtIDMonitoring*.

### Add Microsoft.Insights as a resource provider

Itt tartok ------------------------------



## Step 2: External tenant configuration - get external tenant ID and create a group for external ID monitoring

### Get your external tenant ID
### Create a group for external ID monitoring


## Step 3: Workforce tenant configuration – configure Lighthouse (create Service Provider) with ARM

### Create an Azure Resource Manager template

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