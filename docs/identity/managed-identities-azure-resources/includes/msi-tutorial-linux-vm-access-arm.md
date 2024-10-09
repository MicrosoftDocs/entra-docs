---
author: rwike77
ms.author: ryanwi
ms.date: 06/10/2024
ms.topic: include
ms.service: entra-id
ms.subservice: managed-identities
ms.custom:
  - devx-track-arm-template
  - linux-related-content
---

## Use a Linux VM user-assigned managed identity to access a resource group in Resource Manager

[!INCLUDE [portal updates](~/includes/portal-update.md)]

This tutorial explains how to create a user-assigned identity, assign it to a Linux Virtual Machine (VM), and then use that identity to access the [Azure Resource Manager](/azure/azure-resource-manager/management/overview) API. Managed Service Identities are automatically managed by Azure. They enable authentication to services that support Microsoft Entra authentication, without needing to embed credentials into your code.

You'll learn how to:

> [!div class="checklist"]
> * Grant your VM access to Azure Resource Manager.
> * Get an access token by using the VM's system-assigned managed identity to access Resource Manager.

Create a user-assigned managed identity using [az identity create](/cli/azure/identity#az-identity-create). The `-g` parameter specifies the resource group where the user-assigned managed identity is created, and the `-n` parameter specifies its name. Be sure to replace the `<RESOURCE GROUP>` and `<UAMI NAME>` parameter values with your own values:
    
[!INCLUDE [ua-character-limit](~/includes/managed-identity-ua-character-limits.md)]

```azurecli-interactive
az identity create -g <RESOURCE GROUP> -n <UAMI NAME>
```

The response contains details for the user-assigned managed identity created, similar to the following example. Note the `id` value for your user-assigned managed identity, as it will be used in the next step:

```json
{
"clientId": "00001111-aaaa-2222-bbbb-3333cccc4444",
"clientSecretUrl": "https://control-westcentralus.identity.azure.net/subscriptions/<SUBSCRIPTON ID>/resourcegroups/<RESOURCE GROUP>/providers/Microsoft.ManagedIdentity/userAssignedIdentities/<UAMI NAME>/credentials?tid=5678&oid=9012&aid=aaaaaaaa-0b0b-1c1c-2d2d-333333333333",
"id": "/subscriptions/<SUBSCRIPTON ID>/resourcegroups/<RESOURCE GROUP>/providers/Microsoft.ManagedIdentity/userAssignedIdentities/<UAMI NAME>",
"location": "westcentralus",
"name": "<UAMI NAME>",
"principalId": "9012",
"resourceGroup": "<RESOURCE GROUP>",
"tags": {},
"tenantId": "aaaabbbb-0000-cccc-1111-dddd2222eeee",
"type": "Microsoft.ManagedIdentity/userAssignedIdentities"
}
```

## Assign an identity to your Linux VM

A user-assigned managed identity can be used by clients on multiple Azure resources. Use the following commands to assign the user-assigned managed identity to a single VM. Use the `Id` property returned in the previous step for the `-IdentityID` parameter.

Assign the user-assigned managed identity to your Linux VM using [az vm identity assign](/cli/azure/vm). Be sure to replace the `<RESOURCE GROUP>` and `<VM NAME>` parameter values with your own values. Use the `id` property returned in the previous step for the `--identities` parameter value.

```azurecli-interactive
az vm identity assign -g <RESOURCE GROUP> -n <VM NAME> --identities "/subscriptions/<SUBSCRIPTION ID>/resourcegroups/<RESOURCE GROUP>/providers/Microsoft.ManagedIdentity/userAssignedIdentities/<UAMI NAME>"
```

## Grant access to a resource group in Azure Resource Manager

Managed identities are identities that your code can use to request access tokens to authenticate to resource APIs that support Microsoft Entra authentication. In this tutorial, your code will access the Azure Resource Manager API.  

Before your code can access the API, you need to grant the identity access to a resource in Azure Resource Manager. In this case, the resource group in which the VM is contained. Update the value for `<SUBSCRIPTION ID>` and `<RESOURCE GROUP>` as appropriate for your environment. Additionally, replace `<UAMI PRINCIPALID>` with the `principalId` property returned by the `az identity create` command in [Create a user-assigned managed identity](/cli/azure/identity#az-identity-create):

```azurecli-interactive
az role assignment create --assignee <UAMI PRINCIPALID> --role 'Reader' --scope "/subscriptions/<SUBSCRIPTION ID>/resourcegroups/<RESOURCE GROUP> "
```

The response contains details for the role assignment created, similar to the following example:

```json
{
  "id": "/subscriptions/<SUBSCRIPTION ID>/resourceGroups/<RESOURCE GROUP>/providers/Microsoft.Authorization/roleAssignments/00000000-0000-0000-0000-000000000000",
  "name": "00000000-0000-0000-0000-000000000000",
  "properties": {
    "principalId": "aaaaaaaa-bbbb-cccc-1111-222222222222",
    "roleDefinitionId": "/subscriptions/<SUBSCRIPTION ID>/providers/Microsoft.Authorization/roleDefinitions/00000000-0000-0000-0000-000000000000",
    "scope": "/subscriptions/<SUBSCRIPTION ID>/resourceGroups/<RESOURCE GROUP>"
  },
  "resourceGroup": "<RESOURCE GROUP>",
  "type": "Microsoft.Authorization/roleAssignments"
}

```

## Get an access token using the VM's identity and use it to call Resource Manager 

[!INCLUDE [portal updates](~/includes/portal-update.md)]

For the remainder of the tutorial, you work from the VM you created earlier.

To complete these steps, you need an SSH client. If you are using Windows, you can use the SSH client in the [Windows Subsystem for Linux](/windows/wsl/about). 

1. Sign in to the [Azure portal](https://portal.azure.com).
1. In the portal, navigate to **Virtual Machines** and go to the Linux virtual machine and in the **Overview**, click **Connect**. Copy the string to connect to your VM.
1. Connect to the VM with the SSH client of your choice. If you are using Windows, you can use the SSH client in the [Windows Subsystem for Linux](/windows/wsl/about). If you need assistance configuring your SSH client's keys, see [How to Use SSH keys with Windows on Azure](/azure/virtual-machines/linux/ssh-from-windows), or [How to create and use an SSH public and private key pair for Linux VMs in Azure](/azure/virtual-machines/linux/mac-create-ssh-keys).
1. In the terminal window, use CURL to make a request to the Azure Instance Metadata Service (IMDS) identity endpoint to get an access token for Azure Resource Manager.

   The CURL request to acquire an access token is shown in the following example. Be sure to replace `<CLIENT ID>` with the `clientId` property returned by the `az identity create` command in [Create a user-assigned managed identity](/cli/azure/identity#az-identity-create): 
    
   ```bash
   curl -H Metadata:true "http://169.254.169.254/metadata/identity/oauth2/token?api-version=2018-02-01&resource=https%3A%2F%2Fmanagement.azure.com/&client_id=<UAMI CLIENT ID>"
   ```
    
    > [!NOTE]
    > The value of the `resource` parameter must be an exact match for what is expected by Microsoft Entra ID. When using the Resource Manager resource ID, you must include the trailing slash on the URI. 
    
    The response includes the access token you need to access Azure Resource Manager. 
    
    Response example:

    ```bash
    {
    "access_token":"eyJ0eXAiOi...",
    "refresh_token":"",
    "expires_in":"3599",
    "expires_on":"1504130527",
    "not_before":"1504126627",
    "resource":"https://management.azure.com",
    "token_type":"Bearer"
    } 
    ```

1. Use the access token to access Azure Resource Manager, and read the properties of the resource group to which you previously granted your user-assigned managed identity access. Be sure to replace `<SUBSCRIPTION ID>`, `<RESOURCE GROUP>` with the values you specified earlier, and `<ACCESS TOKEN>` with the token returned in the previous step.

    > [!NOTE]
    > The URL is case-sensitive, so be sure to use the exact same case you used earlier when you named the resource group, and the uppercase "G" in `resourceGroups`.

    ```bash 
    curl https://management.azure.com/subscriptions/<SUBSCRIPTION ID>/resourceGroups/<RESOURCE GROUP>?api-version=2016-09-01 -H "Authorization: Bearer <ACCESS TOKEN>" 
    ```

    The response contains the specific resource group information, similar to the following example: 

    ```bash
    {
    "id":"/subscriptions/<SUBSCRIPTION ID>/resourceGroups/DevTest",
    "name":"DevTest",
    "location":"westus",
    "properties":{"provisioningState":"Succeeded"}
    } 
    ```
