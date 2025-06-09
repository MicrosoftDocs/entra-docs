---
author: SHERMANOUKO
ms.author: shermanouko
ms.date: 06/06/2024
ms.topic: include
ms.service: entra-id
ms.subservice: managed-identities
ms.custom:
  - devx-track-arm-template
  - devx-track-azurepowershell
---

## Use a user-assigned managed identity on a Windows VM to access Azure Resource Manager

This tutorial explains how to create a user-assigned identity, assign it to a Windows Virtual Machine (VM), and then use that identity to access the [Azure Resource Manager](/azure/azure-resource-manager/management/overview) API. Managed Service Identities are automatically managed by Azure. They enable authentication to services that support Microsoft Entra authentication, without needing to embed credentials into your code.

You'll learn how to:

> [!div class="checklist"]
> * Create a user-assigned managed identity
> * Assign your user-assigned identity to your Windows VM
> * Grant the user-assigned identity access to a Resource Group in Azure Resource Manager
> * Get an access token using the user-assigned identity and use it to call Azure Resource Manager
> * Read the properties of a Resource Group

[!INCLUDE [az-powershell-update](~/includes/azure-docs-pr/updated-for-az.md)]

### Configure Azure PowerShell locally

To run scripts in this example, you have two options:
   - Use the [Azure Cloud Shell](/azure/cloud-shell/overview), which you can open using the **Try It** button on the top-right corner of code blocks.
   - Run scripts locally with Azure PowerShell, as described in the next section.

To use Azure PowerShell locally for this tutorial (rather than using Cloud Shell), complete the following steps:

1. Install [the latest version of Azure PowerShell](/powershell/azure/install-azure-powershell), if you haven't already.

1. Sign in to Azure:

    ```azurepowershell
    Connect-AzAccount
    ```

1. Install the [latest version of PowerShellGet](/powershell/gallery/powershellget/install-powershellget).

    ```azurepowershell
    Install-Module -Name PowerShellGet -AllowPrerelease
    ```

    You may need to `Exit` out of the current PowerShell session after you run this command for the next step.

1. Install the released version of the `Az.ManagedServiceIdentity` module. You need this to perform the user-assigned managed identity operations in this tutorial:

    ```azurepowershell
    Install-Module -Name Az.ManagedServiceIdentity -AllowPrerelease
    ```

## Enable

For scenarios based on a user-assigned identity, you need to perform the following steps in this section:

1. Create an identity.
2. Assign the newly created identity.

### Create identity

This section shows you how to create a user-assigned identity, which is created as a standalone Azure resource. Using the [New-AzUserAssignedIdentity](/powershell/module/az.managedserviceidentity/get-azuserassignedidentity) cmdlet, Azure creates an identity in your Microsoft Entra tenant that you can assign to one or more Azure service instances.

[!INCLUDE [ua-character-limit](~/includes/managed-identity-ua-character-limits.md)]

```azurepowershell-interactive
New-AzUserAssignedIdentity -ResourceGroupName myResourceGroupVM -Name ID1
```

The response contains details for the created user-assigned identity, similar to the following example. Define the `Id` and `ClientId` values for your user-assigned identity, as they are used in subsequent steps:

```azurepowershell
{
Id: /subscriptions/<SUBSCRIPTIONID>/resourcegroups/myResourceGroupVM/providers/Microsoft.ManagedIdentity/userAssignedIdentities/ID1
ResourceGroupName : myResourceGroupVM
Name: ID1
Location: westus
TenantId: aaaabbbb-0000-cccc-1111-dddd2222eeee
PrincipalId: aaaaaaaa-bbbb-cccc-1111-222222222222
ClientId: 00001111-aaaa-2222-bbbb-3333cccc4444
ClientSecretUrl: https://control-westus.identity.azure.net/subscriptions/<SUBSCRIPTIONID>/resourcegroups/myResourceGroupVM/providers/Microsoft.ManagedIdentity/userAssignedIdentities/ID1/credentials?tid=aaaabbbb-0000-cccc-1111-dddd2222eeee&oid=aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb&aid=00001111-aaaa-2222-bbbb-3333cccc4444
Type: Microsoft.ManagedIdentity/userAssignedIdentities
}
```

### Assign identity

This section shows you how to Assign the user-assigned identity to a Windows VM. A user-assigned identity can be used by clients on multiple Azure resources. Use the following commands to assign the user-assigned identity to a single VM. Use the `Id` property returned in the previous step for the `-IdentityID` parameter.

```azurepowershell-interactive
$vm = Get-AzVM -ResourceGroupName myResourceGroup -Name myVM
Update-AzVM -ResourceGroupName TestRG -VM $vm -IdentityType "UserAssigned" -IdentityID "/subscriptions/<SUBSCRIPTIONID>/resourcegroups/myResourceGroupVM/providers/Microsoft.ManagedIdentity/userAssignedIdentities/ID1"
```

## Grant access

This section shows you how to grant your user-assigned identity access to a resource group in [Azure Resource Manager](/azure/azure-resource-manager/management/overview). Managed identities for Azure resources provide identities that your code can use to request access tokens to authenticate to resource APIs that support Microsoft Entra authentication. In this tutorial, your code will access the Azure Resource Manager API.

Before your code can access the API, you need to grant the identity access to a resource in Azure Resource Manager. In this case, you access the resource group for which the VM is contained. Update the value for `<SUBSCRIPTIONID>` as appropriate for your environment.

```azurepowershell-interactive
$spID = (Get-AzUserAssignedIdentity -ResourceGroupName myResourceGroupVM -Name ID1).principalid
New-AzRoleAssignment -ObjectId $spID -RoleDefinitionName "Reader" -Scope "/subscriptions/<SUBSCRIPTIONID>/resourcegroups/myResourceGroupVM/"
```

The response contains details for the role assignment created, similar to the following example:

```azurepowershell
RoleAssignmentId: /subscriptions/<SUBSCRIPTIONID>/resourcegroups/myResourceGroupVM/providers/Microsoft.Authorization/roleAssignments/00000000-0000-0000-0000-000000000000
Scope: /subscriptions/<SUBSCRIPTIONID>/resourcegroups/myResourceGroupVM
DisplayName: ID1
SignInName:
RoleDefinitionName: Reader
RoleDefinitionId: 00000000-0000-0000-0000-000000000000
ObjectId: aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb
ObjectType: ServicePrincipal
CanDelegate: False
```

## Access data


### Get an access token

For the remainder of the tutorial, you work from the VM that you created earlier.

1. Sign in to the [Azure portal](https://portal.azure.com).

1. In the portal, navigate to **Virtual Machines** and go to the Windows VM. In the **Overview**, select **Connect**.

1. Enter the **Username** and **Password** that you used when you created the Windows VM.

1. Now that you have created a **Remote Desktop Connection** with your VM, open **PowerShell** in a remote session.

1. Using the PowerShell `Invoke-WebRequest` cmdlet, make a request to the local managed identities for Azure resources endpoint to get an access token for Azure Resource Manager. The `client_id` value is the value returned when you created the user-assigned managed identity.

    ```azurepowershell
    $response = Invoke-WebRequest -Uri 'http://169.254.169.254/metadata/identity/oauth2/token?api-version=2018-02-01&client_id=00001111-aaaa-2222-bbbb-3333cccc4444&resource=https://management.azure.com/' -Method GET -Headers @{Metadata="true"}
    $content = $response.Content | ConvertFrom-Json
    $ArmToken = $content.access_token
    ```

### Read properties

Finally, use the access token retrieved in the previous step to access Azure Resource Manager, then read the properties of the resource group you granted your user-assigned identity access. Replace `<SUBSCRIPTION ID>` with the subscription ID of your environment.

```azurepowershell
(Invoke-WebRequest -Uri https://management.azure.com/subscriptions/aaaa0a0a-bb1b-cc2c-dd3d-eeeeee4e4e4e/resourceGroups/myResourceGroupVM?api-version=2016-06-01 -Method GET -ContentType "application/json" -Headers @{Authorization ="Bearer $ArmToken"}).content
```
The response contains the specific Resource Group information, similar to the following example:

```json
{"id":"/subscriptions/<SUBSCRIPTIONID>/resourceGroups/myResourceGroupVM","name":"myResourceGroupVM","location":"eastus","properties":{"provisioningState":"Succeeded"}}
```
