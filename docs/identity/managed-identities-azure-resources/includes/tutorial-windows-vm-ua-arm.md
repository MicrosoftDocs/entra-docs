---
author: barclayn
ms.author: barclayn
ms.date: 05/28/2024
ms.topic: include
---

Follow the steps in this quickstart to:

- Create a user-assigned managed identity
- Assign your user-assigned identity to your Windows virtual machine (VM)
- Grant the user-assigned identity access to a resource group in Azure Resource Manager
- Get an access token using the user-assigned identity and use it to call Azure Resource Manager
- Read the properties of a resource group

[!INCLUDE [az-powershell-update](~/includes/azure-docs-pr/updated-for-az.md)]

## Prerequisites

[!INCLUDE [msi-qs-configure-prereqs](~/includes/entra-msi-qs-configure-prereqs.md)]

- Sign in to the [Azure portal](https://portal.azure.com).

- [Create a Windows virtual machine](/azure/virtual-machines/windows/quick-create-portal).

- To perform the required resource creation and role management steps in this tutorial, your account needs **Owner** permissions at the appropriate scope (your subscription or resource group). If you need assistance with role assignment, see [Assign Azure roles to manage access to your Azure subscription resources](/azure/role-based-access-control/role-assignments-portal).

- To run the example scripts in this tutorial, you have two options:
    - Use the [Azure Cloud Shell](/azure/cloud-shell/overview), which you can open using the **Try It** button on the top-right corner of the code blocks.
    - Run scripts locally with Azure PowerShell, as described in the next section.

## Configure Azure PowerShell locally

To use Azure PowerShell locally for this article (rather than using Cloud Shell), complete the following steps:

1. Install [the latest version of Azure PowerShell](/powershell/azure/install-azure-powershell) if you haven't already.

1. Sign in to Azure:

    ```azurepowershell
    Connect-AzAccount
    ```

1. Install the [latest version of PowerShellGet](/powershell/gallery/powershellget/install-powershellget).

    ```azurepowershell
    Install-Module -Name PowerShellGet -AllowPrerelease
    ```

    You may need to `Exit` out of the current PowerShell session after you run this command for the next step.

1. Install the prerelease version of the `Az.ManagedServiceIdentity` module to perform the user-assigned managed identity operations in this article:

    ```azurepowershell
    Install-Module -Name Az.ManagedServiceIdentity -AllowPrerelease
    ```

## Enable a user-assigned managed identity

For a scenario that is based on a user-assigned identity, you need to perform the following steps:

- [Create an identity](#create-identity)
- [Assign the newly created identity](#assign-identity)

### Create identity

This section shows you how to create a user-assigned identity as a standalone Azure resource. Use the module [New-AzUserAssignedIdentity](/powershell/module/az.managedserviceidentity/get-azuserassignedidentity) when using Azure to create an identity in your Microsoft Entra tenant. You can then assign this identity to one or more Azure service instances.

[!INCLUDE [ua-character-limit](~/includes/managed-identity-ua-character-limits.md)]

```azurepowershell-interactive
New-AzUserAssignedIdentity -ResourceGroupName myResourceGroupVM -Name ID1
```

The response contains details for the user-assigned identity created, similar to the following example. Note the `Id` and `ClientId` values for your user-assigned identity, because they are used in subsequent steps:

```azurepowershell
{
Id: /subscriptions/<SUBSCRIPTIONID>/resourcegroups/myResourceGroupVM/providers/Microsoft.ManagedIdentity/userAssignedIdentities/ID1
ResourceGroupName : myResourceGroupVM
Name: ID1
Location: westus
TenantId: aaaabbbb-0000-cccc-1111-dddd2222eeee
PrincipalId: aaaaaaaa-bbbb-cccc-1111-222222222222
ClientId: 00001111-aaaa-2222-bbbb-3333cccc4444
ClientSecretUrl: https://control-westus.identity.azure.net/subscriptions/<SUBSCRIPTIONID>/resourcegroups/myResourceGroupVM/providers/Microsoft.ManagedIdentity/userAssignedIdentities/ID1/credentials?tid=aaaabbbb-0000-cccc-1111-dddd2222eeee&oid=aaaaaaaa-bbbb-cccc-1111-222222222222&aid=00001111-aaaa-2222-bbbb-3333cccc4444
Type: Microsoft.ManagedIdentity/userAssignedIdentities
}
```

### Assign identity

This section shows you how to assign the user-assigned identity to a Windows VM. A user-assigned identity is used by clients on multiple Azure resources. Use the following commands to assign the user-assigned identity to a single VM. Use the `Id` property returned in the previous step for the `-IdentityID` parameter.

```azurepowershell-interactive
$vm = Get-AzVM -ResourceGroupName myResourceGroup -Name myVM
Update-AzVM -ResourceGroupName TestRG -VM $vm -IdentityType "UserAssigned" -IdentityID "/subscriptions/<SUBSCRIPTIONID>/resourcegroups/myResourceGroupVM/providers/Microsoft.ManagedIdentity/userAssignedIdentities/ID1"
```

## Grant access

This section shows you how to grant your user-assigned identity access to a resource group in Azure Resource Manager. Managed identities for Azure resources provide identities that your code can use to request access tokens to authenticate to resource APIs that support Microsoft Entra authentication. 

In this tutorial, the code accesses the Azure Resource Manager API.

Before your code can access the API, you need to grant the identity access to a resource in Azure Resource Manager. In this case, the identity access is for a resource group that the VM is contained. Update the value for `<SUBSCRIPTIONID>` as appropriate for your environment.

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

### Get an access token

[!INCLUDE [portal updates](~/includes/portal-update.md)]

For the remainder of this tutorial, you work from the VM that you created earlier.

1. Sign in to the [Azure portal](https://portal.azure.com).

2. In the portal, navigate to **Virtual Machines** and go to the Windows VM, and in the **Overview** section click **Connect**.

3. Enter the **Username** and **Password** you used when you created the Windows VM.

4. Now that you've created a **Remote Desktop Connection** with the VM, open **PowerShell** in the remote session.

5. Using PowerShell's `Invoke-WebRequest`, make a request to the local managed identities for Azure resources endpoint to get an access token for Azure Resource Manager.  The `client_id` value is the value returned when you created the user-assigned managed identity.

    ```azurepowershell
    $response = Invoke-WebRequest -Uri 'http://169.254.169.254/metadata/identity/oauth2/token?api-version=2018-02-01&client_id=00001111-aaaa-2222-bbbb-3333cccc4444&resource=https://management.azure.com/' -Method GET -Headers @{Metadata="true"}
    $content = $response.Content | ConvertFrom-Json
    $ArmToken = $content.access_token
    ```

### Read properties

Use the access token retrieved in the previous step to access Azure Resource Manager. Then, read the properties of the resource group that you granted for the user-assigned identity access. Replace `<SUBSCRIPTION ID>` with the subscription ID of your environment.

```azurepowershell
(Invoke-WebRequest -Uri https://management.azure.com/subscriptions/80c696ff-5efa-4909-a64d-f1b616f423ca/resourceGroups/myResourceGroupVM?api-version=2016-06-01 -Method GET -ContentType "application/json" -Headers @{Authorization ="Bearer $ArmToken"}).content
```
The response contains the specific Resource Group information, similar to the following example:

```json
{"id":"/subscriptions/<SUBSCRIPTIONID>/resourceGroups/myResourceGroupVM","name":"myResourceGroupVM","location":"eastus","properties":{"provisioningState":"Succeeded"}}
```
