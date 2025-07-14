---
author: SHERMANOUKO
ms.author: shermanouko
ms.date: 03/14/2025
ms.topic: include
ms.service: entra-id
ms.subservice: managed-identities
ms.custom:
  - devx-track-azurecli
---

## View the service principal of a managed identity using Azure CLI

[!INCLUDE [azure-cli-prepare-your-environment-no-header.md](~/../docs/reusable-content/azure-cli/azure-cli-prepare-your-environment-no-header.md)]

The following command demonstrates how to view the service principal of a virtual machine (VM) or application with managed identity enabled. Replace `<Azure resource name>` with your own values.

```azurecli-interactive
az ad sp list --display-name <Azure resource name>
```

## Next steps

For more information on managing Microsoft Entra service principals, see [Azure CLI ad sp](/cli/azure/ad/sp).
