--- 
author: barclayn 
ms.author: barclayn
ms.date: 06/03/2024 
ms.topic: include
---

[!INCLUDE [azure-cli-prepare-your-environment-no-header.md](~/../docs/reusable-content/azure-cli/azure-cli-prepare-your-environment-no-header.md)]

## Use Azure RBAC to assign a managed identity access to another resource

After you've enabled managed identity on an Azure resource, such as an [Azure virtual machine](how-to-configure-managed-identities.md) or [Azure virtual machine scale set](how-to-configure-managed-identities-scale-sets.md):

1. In this example, you'll give an Azure virtual machine (VM) access to a storage account. First use [az resource list](/cli/azure/resource#az-resource-list) to get the service principal for the VM named myVM:

   ```azurecli-interactive
   spID=$(az resource list -n myVM --query [*].identity.principalId --out tsv)
   ```
   For an Azure VM scale set, the command is the same except here you get the service principal for the VM set named "DevTestVMSS":
   
   ```azurecli-interactive
   spID=$(az resource list -n DevTestVMSS --query [*].identity.principalId --out tsv)
   ```

1. Once you have the service principal ID, use [az role assignment create](/cli/azure/role/assignment#az-role-assignment-create) to give the VM or VM scale set **Reader** access to a storage account called "myStorageAcct":

   ```azurecli-interactive
   az role assignment create --assignee $spID --role 'Reader' --scope /subscriptions/<mySubscriptionID>/resourceGroups/<myResourceGroup>/providers/Microsoft.Storage/storageAccounts/myStorageAcct
   ```
