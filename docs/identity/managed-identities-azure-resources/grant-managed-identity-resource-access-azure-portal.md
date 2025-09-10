---
title: Use Azure portal to grant a managed identity access to a resource
description: Step-by-step instructions on using Azure portal to assign a managed identity access to an Azure resource or another resource.
author: SHERMANOUKO
manager: CelesteDG

ms.service: entra-id
ms.subservice: managed-identities
ms.topic: how-to
ms.date: 09/09/2025
ms.author: shermanouko
---

# Use Azure portal to grant a managed identity access to a resource

This article shows you how to use the Azure portal to give a managed identity access to an Azure resource. In this article, we use the example of an Azure virtual machine (Azure VM) managed identity accessing an Azure storage account. Once you've configured an Azure resource with a managed identity, you can then give the managed identity access to another resource, similar to any security principal.

## Prerequisites

- Be sure you've enabled managed identity on an Azure resource, such as an [Azure virtual machine](how-to-configure-managed-identities.md). 
- If you don't already have an Azure account, [sign up for a free account](https://azure.microsoft.com/free/) before continuing.

## Use Azure RBAC to assign a managed identity access to another resource using the Azure portal

The steps outlined below show how you grant access to a service using Azure RBAC. Check specific service documentation on how to grant access; for example, check [Azure Data Explorer](/azure/data-explorer/data-explorer-overview) for instructions. Some Azure services are in the process of adopting Azure RBAC on the data plane.

1. Sign in to the [Azure portal](https://portal.azure.com) using an account associated with the Azure subscription for which you've configured the managed identity.

1. Navigate to the desired resource that you want to modify access control. In this example, you'll give an Azure virtual machine (VM) access to a storage account, then you can navigate to the storage account.

1. Select **Access control (IAM)**.

1. Select **Add** > **Add role assignment** to open the **Add role assignment** page.

1. Select the role and managed identity. For detailed steps, see [Assign Azure roles using the Azure portal](/azure/role-based-access-control/role-assignments-portal).

    :::image type="content" source="../../media/common/add-role-assignment-page.png" alt-text="Screenshot that shows the page for adding a role assignment.":::

## Related content

- [Configure an application to trust a managed identity](/entra/workload-id/workload-identity-federation-config-app-trust-managed-identity?toc=/entra/identity/managed-identities-azure-resources/toc.json)
- [Use Azure Resources Extension in Visual Studio (VS) Code for Managed Identities](./azure-resources-extension-managed-identities.md)
