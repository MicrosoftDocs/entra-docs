---
author: barclayn
ms.author: barclayn
ms.date: 05/28/2024
ms.topic: include
---

## Prerequisites

- A basic understanding of managed identities. If you're not familiar with the managed identities for Azure resources feature, review this [overview](overview.md).
- An Azure account, [sign up for a free account](https://azure.microsoft.com/free/).
- **Owner** permissions at the appropriate scope (your subscription or resource group) to perform required resource creation and role management steps. If you need assistance with role assignments, see [Assign Azure roles to manage access to your Azure subscription resources](/azure/role-based-access-control/role-assignments-portal).
- A Windows VM that has system assigned managed identities enabled.
  - If you need to create a Windows VM for this tutorial, see [Create a virtual machine with system-assigned identity enabled](./qs-configure-portal-windows-vm.md#system-assigned-managed-identity).

## Enable a system-assigned managed identity

[!INCLUDE [msi-tut-enable](~/includes/entra-msi-tut-enable.md)]

## Grant your VM access to a resource group in Resource Manager

[!INCLUDE [portal updates](~/includes/portal-update.md)]

Using managed identities for Azure resources, your application can access tokens to authenticate to resources that support Microsoft Entra authentication. The Azure Resource Manager API supports Microsoft Entra authentication, which grants the VM's identity access to a resource in Azure Resource Manager; in this case, access to a resource group that the VM is contained. Assign the [Reader](/azure/role-based-access-control/built-in-roles#reader) role to the managed identity at the scope of the resource group. 

1. Use an administrator account to sign in to the [Azure portal](https://portal.azure.com).
1. Navigate to the tab for **Resource Groups**.
1. Select the **Resource Group** you want to grant the VM's managed identity access.
1. In the left panel, select **Access control (IAM)**.
1. Select **Add**, then select **Add role assignment**.
1. In the **Role** tab, select **Reader**. This role allows view all resources, but doesn't allow you to make any changes.
1. In the **Members** tab, for the **Assign access to**, select **Managed identity**, then select **+ Select members**.
1. Ensure the proper subscription is listed in the **Subscription** dropdown. And for **Resource Group**, select **All resource groups**.
1. For the **Manage identity** dropdown, select **Virtual Machine**.
1. In **Select** choose your Windows VM in the dropdown, then select **Save**.

## Get an access token

Use the VM's system-assigned managed identity and use it to call Azure Resource Manager to get an access token. 

You'll need to access **PowerShell** to complete these steps. If you don’t have **PowerShell** installed, download it [here](/powershell/azure/). 

1. In the portal, navigate to **Virtual Machines** and go to your Windows VM. 
1. In the **Overview** section, select **Connect**. 
1. Enter in your **Username** and **Password** for which you added when you created the Windows VM. This creates a **Remote Desktop Connection** with the VM.
1. Open **PowerShell** in the remote session. 
1. Using the `Invoke-WebRequest` cmdlet, make a request to the local managed identity for the Azure resources endpoint. 

This code generates an access token for Azure Resource Manager.

    ```powershell
       $response = Invoke-WebRequest -Uri 'http://169.254.169.254/metadata/identity/oauth2/token?api-version=2018-02-01&resource=https://management.azure.com/' -Method GET -Headers @{Metadata="true"}
    ```
    
    > [!NOTE]
    > The value of the *resource* parameter must be an exact match for what is expected by Microsoft Entra ID. When using the Azure Resource Manager resource ID, you must include the trailing slash in the URI.
    
    Next, extract the full response, which is stored as a JavaScript Object Notation (JSON) formatted string in the `$response` object. 
    
    ```powershell
    $content = $response.Content | ConvertFrom-Json
    ```
    Next, extract the access token from the response.
    
    ```powershell
    $ArmToken = $content.access_token
    ```
    
    Finally, call Azure Resource Manager using the access token. This example shows using the `Invoke-WebRequest` cmdlet to make the call to Azure Resource Manager and includes the access token in the Authorization header.
    
    ```powershell
    (Invoke-WebRequest -Uri https://management.azure.com/subscriptions/<SUBSCRIPTION ID>/resourceGroups/<RESOURCE GROUP>?api-version=2016-06-01 -Method GET -ContentType "application/json" -Headers @{ Authorization ="Bearer $ArmToken"}).content
    ```
    > [!NOTE] 
    > The URL is case-sensitive, so ensure you use the exact case as you used earlier when you named the Resource Group. Also use the uppercase "G" in *resourceGroups*.
        
    The following command returns the details of the resource group:

    ```powershell
    {"id":"/subscriptions/aaaa0a0a-bb1b-cc2c-dd3d-eeeeee4e4e4e/resourceGroups/DevTest","name":"DevTest","location":"westus","properties":{"provisioningState":"Succeeded"}}
    ```
