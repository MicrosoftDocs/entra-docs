--- 
author: barclayn 
ms.author: barclayn
ms.date: 06/03/2024 
ms.topic: include
ms.service: entra-id
ms.subservice: managed-identities
---

## Use Azure RBAC to assign a managed identity access to another resource using CLI

[!INCLUDE [azure-cli-prepare-your-environment-no-header.md](~/../docs/reusable-content/azure-cli/azure-cli-prepare-your-environment-no-header.md)]

1. In this example, you give an Azure virtual machine (VM) managed access to a storage account. First use [az resource list](/cli/azure/resource#az-resource-list) to get the service principal for a VM named myVM:

   ```azurecli-interactive
   spID=$(az resource list -n myVM --query [*].identity.principalId --out tsv)
   ```
   For an Azure Virtual Machine (VM) scale set, the command is the same except here you get the service principal for the VM set named "DevTestVMSS":
   
   ```azurecli-interactive
   spID=$(az resource list -n DevTestVMSS --query [*].identity.principalId --out tsv)
   ```

1. Once you have the service principal ID, use [az role assignment create](/cli/azure/role/assignment#az-role-assignment-create) to give the virtual machine or virtual machine scale set **Reader** access to a storage account called "myStorageAcct":

   ```azurecli-interactive
   az role assignment create --assignee $spID --role 'Reader' --scope /subscriptions/<mySubscriptionID>/resourceGroups/<myResourceGroup>/providers/Microsoft.Storage/storageAccounts/myStorageAcct
   ```
