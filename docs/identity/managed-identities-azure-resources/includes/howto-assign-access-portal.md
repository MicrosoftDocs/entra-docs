--- 
author: barclayn 
ms.author: barclayn
ms.date: 06/03/2024 
ms.topic: include
ms.service: entra-id
ms.subservice: managed-identities
---

## Use Azure RBAC to assign a managed identity access to another resource using the Azure portal

[!INCLUDE [portal updates](~/includes/portal-update.md)]

>[!IMPORTANT]
> The steps outlined below show is how you grant access to a service using Azure RBAC. Check specific service documentation on how to grant access; for example, check [Azure Data Explorer](/azure/data-explorer/data-explorer-overview) for instructions. Some Azure services are in the process of adopting Azure RBAC on the data plane.

1. Sign in to the [Azure portal](https://portal.azure.com) using an account associated with the Azure subscription for which you've configured the managed identity.

2. Navigate to the desired resource that you want to modify access control. In this example, you'll give an Azure virtual machine (VM) access to a storage account, then you can navigate to the storage account.

1. Select **Access control (IAM)**.

1. Select **Add** > **Add role assignment** to open the **Add role assignment** page.

1. Select the role and managed identity. For detailed steps, see [Assign Azure roles using the Azure portal](/azure/role-based-access-control/role-assignments-portal).

    :::image type="content" source="../../../media/common/add-role-assignment-page.png" alt-text="Screenshot that shows the page for adding a role assignment.":::
