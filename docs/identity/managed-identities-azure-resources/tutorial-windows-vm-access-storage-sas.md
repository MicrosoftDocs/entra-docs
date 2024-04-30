---
title: Tutorial`:` Use managed identity to access Azure Storage using SAS credential
description: A tutorial that shows you how to use a Windows VM system-assigned managed identity to access Azure Storage, using a SAS credential instead of a storage account access key.

author: barclayn
manager: amycolannino
editor: daveba

ms.service: entra-id
ms.subservice: managed-identities
ms.topic: tutorial
ms.tgt_pltfrm: na
ms.date: 01/05/2024
ms.author: barclayn

ms.custom: devx-track-azurepowershell, subject-rbac-steps, devx-track-arm-template
---

# Tutorial: Use a Windows VM system-assigned managed identity to access Azure Storage via a SAS credential

[!INCLUDE [preview-notice](~/includes/entra-msi-preview-notice.md)]

This tutorial shows you how to use a system-assigned identity for a Windows virtual machine (VM) to obtain a storage Shared Access Signature (SAS) credential. Specifically, a [Service SAS credential](/azure/storage/common/storage-sas-overview?toc=/azure/storage/blobs/toc.json#types-of-shared-access-signatures). 

A Service SAS provides the ability to grant limited access to objects in a storage account, for limited time and a specific service (in our case, the blob service), without exposing an account access key. You can use a SAS credential as usual when doing storage operations, for example when using the Storage SDK. For this tutorial, we demonstrate uploading and downloading a blob using Azure Storage PowerShell. You will learn how to:

> [!div class="checklist"]
> * Create a storage account
> * Grant your VM access to a storage account SAS in Resource Manager 
> * Get an access token using your VM's identity, and use it to retrieve the SAS from Resource Manager 

## Prerequisites

- An understanding of Managed identities. If you're not familiar with the managed identities for Azure resources feature, see this [overview](overview.md). 
- An Azure account, [sign up for a free account](https://azure.microsoft.com/free/).
- "Owner" permissions at the appropriate scope (your subscription or resource group) to perform required resource creation and role management steps. If you need assistance with role assignment, see [Assign Azure roles to manage access to your Azure subscription resources](/azure/role-based-access-control/role-assignments-portal).
- You also need a Windows Virtual machine that has system assigned managed identities enabled.
  - If you need to create  a virtual machine for this tutorial, you can follow the article titled [Create a virtual machine with system-assigned identity enabled](./qs-configure-portal-windows-vm.md#system-assigned-managed-identity)

[!INCLUDE [updated-for-az.md](~/includes/azure-docs-pr/updated-for-az.md)]

## Create a storage account 

If you don't already have one, you will now create a storage account. You can also skip this step and grant your VM's system-assigned managed identity access to the SAS credential of an existing storage account. 

1. Select the **+/Create new service** button found on the upper left-hand corner of the Azure portal.
2. Select **Storage**, then **Storage Account**, and a new "Create storage account" panel will display.
3. Enter a name for the storage account, which you are using for this tutorial.  
4. **Deployment model** and **Account kind** should be set to "Resource Manager" and "General purpose", respectively. 
5. Ensure the **Subscription** and **Resource Group** match the ones you specified when you created your VM in the previous step.
6. Select **Create**.

    :::image type="content" source="./media/msi-tutorial-linux-vm-access-storage/msi-storage-create.png" alt-text="Screenshot showing how to create new storage account.":::

## Create a blob container in the storage account

Later we will upload and download a file to the new storage account. Because files require blob storage, we need to create a blob container in which to store the file.

1. Navigate back to your newly created storage account.
2. Select the **Containers** link in the left panel, under "Blob service."
3. Select **+ Container** on the top of the page, and a "New container" panel slides out.
4. Give the container a name, select an access level, then Select **OK**. The name you specified will be used later in the tutorial. 

    :::image type="content" source="./media/msi-tutorial-linux-vm-access-storage/create-blob-container.png" alt-text="Screenshot showing how to create a storage container.":::

## Grant your VM's system-assigned managed identity access to use a storage SAS 

Azure Storage doesn't natively support Microsoft Entra authentication.  However, you can use a managed identity to retrieve a storage SAS from Resource Manager, then use the SAS to access storage.  In this step, you grant your VM's system-assigned managed identity access to your storage account SAS.   

1. Navigate back to your newly created storage account.   
1. Select **Access control (IAM)**.
1. Select **Add** > **Add role assignment** to open the Add role assignment page.
1. Assign the following role. For detailed steps, see [Assign Azure roles using the Azure portal](/azure/role-based-access-control/role-assignments-portal).
    
    | Setting | Value |
    | --- | --- |
    | Role | Storage Account Contributor |
    | Assign access to | Managed identity |
    | System-assigned | Virtual Machine |
    | Select | &lt;your Windows virtual machine&gt; |

    :::image type="content" source="../../media/common/add-role-assignment-page.png" alt-text="Screenshot that shows the page for adding a role assignment.":::

## Get an access token using the VM's identity and use it to call Azure Resource Manager 

For the remainder of the tutorial, we'll work from your VM.

You'll need to use the Azure Resource Manager PowerShell cmdlets in this portion.  If you don’t have it installed, [download the latest version](/powershell/azure/) before continuing.

1. In the Azure portal, navigate to **Virtual Machines**, go to your Windows virtual machine, then from the **Overview** page Select **Connect** at the top.
2. Enter in your **Username** and **Password** for which you added when you created the Windows VM. 
3. Now that you have created a **Remote Desktop Connection** with the virtual machine.
4. Open PowerShell in the remote session and use Invoke-WebRequest to get an Azure Resource Manager token from the local managed identity for Azure resources endpoint.

    ```powershell
       $response = Invoke-WebRequest -Uri 'http://169.254.169.254/metadata/identity/oauth2/token?api-version=2018-02-01&resource=https%3A%2F%2Fmanagement.azure.com%2F' -Method GET -Headers @{Metadata="true"}
    ```
    
    > [!NOTE]
    > The value of the "resource" parameter must be an exact match for what is expected by Microsoft Entra ID. When using the Azure Resource Manager resource ID, you must include the trailing slash on the URI.
    
    Next, extract the "Content" element, which is stored as a JavaScript Object Notation (JSON) formatted string in the $response object. 
    
    ```powershell
    $content = $response.Content | ConvertFrom-Json
    ```
    Next, extract the access token from the response.
    
    ```powershell
    $ArmToken = $content.access_token
    ```

## Get a SAS credential from Azure Resource Manager to make storage calls 

Now use PowerShell to call Resource Manager using the access token we retrieved in the previous section, to create a storage SAS credential. Once we have the SAS credential, we can call storage operations.

For this request we use the following HTTP request parameters to create the SAS credential:

```JSON
{
    "canonicalizedResource":"/blob/<STORAGE ACCOUNT NAME>/<CONTAINER NAME>",
    "signedResource":"c",              // The kind of resource accessible with the SAS, in this case a container (c).
    "signedPermission":"rcw",          // Permissions for this SAS, in this case (r)ead, (c)reate, and (w)rite. Order is important.
    "signedProtocol":"https",          // Require the SAS be used on https protocol.
    "signedExpiry":"<EXPIRATION TIME>" // UTC expiration time for SAS in ISO 8601 format, for example 2017-09-22T00:06:00Z.
}
```

These parameters are included in the POST body of the request for the SAS credential. For more information on the parameters for creating a SAS credential, see the [List Service SAS REST reference](/rest/api/storagerp/storage-accounts/list-service-sas).

First, convert the parameters to JSON, then call the storage `listServiceSas` endpoint to create the SAS credential:

```powershell
$params = @{canonicalizedResource="/blob/<STORAGE-ACCOUNT-NAME>/<CONTAINER-NAME>";signedResource="c";signedPermission="rcw";signedProtocol="https";signedExpiry="2017-09-23T00:00:00Z"}
$jsonParams = $params | ConvertTo-Json
```

```powershell
$sasResponse = Invoke-WebRequest -Uri https://management.azure.com/subscriptions/<SUBSCRIPTION-ID>/resourceGroups/<RESOURCE-GROUP>/providers/Microsoft.Storage/storageAccounts/<STORAGE-ACCOUNT-NAME>/listServiceSas/?api-version=2017-06-01 -Method POST -Body $jsonParams -Headers @{Authorization="Bearer $ArmToken"}
```
> [!NOTE] 
> The URL is case-sensitive, so ensure you use the exact same case used earlier, when you named the Resource Group, including the uppercase "G" in "resourceGroups." 

Now we can extract the SAS credential from the response:

```powershell
$sasContent = $sasResponse.Content | ConvertFrom-Json
$sasCred = $sasContent.serviceSasToken
```

If you inspect the SAS cred you see something like this:

```powershell
PS C:\> $sasCred
sv=2015-04-05&sr=c&spr=https&se=2017-09-23T00%3A00%3A00Z&sp=rcw&sig=JVhIWG48nmxqhTIuN0uiFBppdzhwHdehdYan1W%2F4O0E%3D
```

Next we create a file called "test.txt". Then use the SAS credential to authenticate with the `New-AzStorageContent` cmdlet, upload the file to our blob container, then download the file.

```bash
echo "This is a test text file." > test.txt
```

Be sure to install the Azure Storage cmdlets first, using `Install-Module Azure.Storage`. Then upload the blob you just created, using the `Set-AzStorageBlobContent` PowerShell cmdlet:

```powershell
$ctx = New-AzStorageContext -StorageAccountName <STORAGE-ACCOUNT-NAME> -SasToken $sasCred
Set-AzStorageBlobContent -File test.txt -Container <CONTAINER-NAME> -Blob testblob -Context $ctx
```

Response:

```powershell
ICloudBlob        : Microsoft.WindowsAzure.Storage.Blob.CloudBlockBlob
BlobType          : BlockBlob
Length            : 56
ContentType       : application/octet-stream
LastModified      : 9/21/2017 6:14:25 PM +00:00
SnapshotTime      :
ContinuationToken :
Context           : Microsoft.WindowsAzure.Commands.Storage.AzureStorageContext
Name              : testblob
```

You can also download the blob you uploaded, using the `Get-AzStorageBlobContent` PowerShell cmdlet:

```powershell
Get-AzStorageBlobContent -Blob testblob -Container <CONTAINER-NAME> -Destination test2.txt -Context $ctx
```

Response:

```powershell
ICloudBlob        : Microsoft.WindowsAzure.Storage.Blob.CloudBlockBlob
BlobType          : BlockBlob
Length            : 56
ContentType       : application/octet-stream
LastModified      : 9/21/2017 6:14:25 PM +00:00
SnapshotTime      :
ContinuationToken :
Context           : Microsoft.WindowsAzure.Commands.Storage.AzureStorageContext
Name              : testblob
```

## Next steps

In this tutorial, you learned how to use a Windows VM's system-assigned managed identity to access Azure Storage using a SAS credential.  To learn more about Azure Storage SAS see:

> [!div class="nextstepaction"]
>[Using shared access signatures (SAS)](/azure/storage/common/storage-sas-overview)
