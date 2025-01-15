---
author: rwike77
ms.author: ryanwi
ms.date: 06/06/2024
ms.topic: include
ms.service: entra-id
ms.subservice: managed-identities
ms.custom:
  - devx-track-arm-template
---

## Use a Windows VM system-assigned managed identity to access Azure Storage via a SAS credential

This tutorial shows you how to use a system-assigned identity for a Windows virtual machine (VM) to obtain a storage [Shared Access Signature (SAS)](/azure/storage/common/storage-sas-overview) credential.

A service SAS provides the ability to grant limited access to objects in a storage account for limited time and for a specific service (in this case, a blob service). SAS does this without exposing an account access key. You can use a SAS credential as usual for storage operations; for example, when using a storage SDK. This tutorial demonstrates uploading and downloading a blob using Azure Storage PowerShell. 

You'll learn how to:

> [!div class="checklist"]
> * Create a storage account
> * Grant your VM access to a storage account SAS in Resource Manager 
> * Get an access token using your VM's identity, and use it to retrieve the SAS from Resource Manager 

[!INCLUDE [updated-for-az.md](~/includes/azure-docs-pr/updated-for-az.md)]

## Create a storage account 

If you don't already have one, you need to create a storage account. Otherwise, follow these steps to grant your VM's system-assigned managed identity access to the SAS credential of an existing storage account. 

1. Select **Storage**, then **Storage Account**. 
1. In the **Create storage account** panel, enter a name for the storage account.  
1. Be sure that **Deployment model** and **Account kind** are set to **Resource Manager** and **General purpose**. 
1. Check to ensure that the **Subscription** and **Resource Group** match the items you specified when you created your VM in the previous step.
1. Select **Create** to create your storage account.

    :::image type="content" source="../media/msi-tutorial-linux-vm-access-storage/msi-storage-create.png" alt-text="Screenshot showing how to create new storage account.":::

## Create a blob container in the storage account

Later in the tutorial, you'll upload and download a file to the new storage account. Because files require blob storage, you need to create a blob container to store the file in.

1. Navigate to your newly created storage account.
1. Select the **Containers** link in the left panel, under **Blob service**.
1. Select **+ Container** at the top of the page, then a **New container** panel should appear.
1. Give the container a name, determine the access level, then Select **OK**. The name you specify here is used later in the tutorial. 

    :::image type="content" source="../media/msi-tutorial-linux-vm-access-storage/create-blob-container.png" alt-text="Screenshot showing how to create a storage container.":::

## Grant your VM's system-assigned managed identity access to use a storage SAS 

Azure Storage doesn't natively support Microsoft Entra authentication.  However, you can use a managed identity to retrieve a storage SAS from Resource Manager, then use the SAS to access storage.  In this step, you grant your VM's system-assigned managed identity access to your storage account SAS.

1. Navigate back to your newly created storage account.
1. Select **Access control (IAM)**.
1. Select **Add** > **Add role assignment** to open the **Add role** assignment page.
1. Assign the following role. For detailed steps, see [Assign Azure roles using the Azure portal](/azure/role-based-access-control/role-assignments-portal).
    
    | Setting | Value |
    | --- | --- |
    | Role | Storage account contributor |
    | Assign access to | Managed identity |
    | System-assigned | Virtual machine |
    | Select | &lt;your Windows virtual machine&gt; |

    :::image type="content" source="../../../media/common/add-role-assignment-page.png" alt-text="Screenshot that shows the page for adding a role assignment.":::

## Get an access token using the VM's identity and use it to call Azure Resource Manager 

For the remainder of this tutorial, you work from your VM. You need to use the Azure Resource Manager PowerShell cmdlets in this portion. If you don’t have PowerShell installed, [download the latest version](/powershell/azure/) before continuing.

1. In the Azure portal, navigate to **Virtual Machines**, go to your Windows virtual machine, then from the **Overview** page Select **Connect** at the top.
1. Enter your **Username** and **Password** that you added when you created your Windows VM. 
1. Establish a **Remote Desktop Connection** with the virtual machine.
1. Open PowerShell in the remote session, then use the PowerShell `Invoke-WebRequest` cmdlet to get an Azure Resource Manager token from the local managed identity for Azure resources endpoint.

    ```powershell
       $response = Invoke-WebRequest -Uri 'http://169.254.169.254/metadata/identity/oauth2/token?api-version=2018-02-01&resource=https%3A%2F%2Fmanagement.azure.com%2F' -Method GET -Headers @{Metadata="true"}
    ```
    
    > [!NOTE]
    > The value of the `resource` parameter must be an exact match for what is expected by Microsoft Entra ID. When using the Azure Resource Manager resource ID, you must include the trailing slash on the URI.
    
    Next, extract the `content` element, which is stored as a JavaScript Object Notation (JSON) formatted string in the `$response` object. 
    
    ```powershell
    $content = $response.Content | ConvertFrom-Json
    ```
    Next, extract the access token from the response.
    
    ```powershell
    $ArmToken = $content.access_token
    ```

## Get a SAS credential from Azure Resource Manager to make storage calls 

Lastly, use PowerShell to call Resource Manager using the access token that you retrieved in the previous section. You use this token to create a storage SAS credential. Once you have the SAS credential, you can call other storage operations.

For this request, use the following HTTP request parameters to create the SAS credential:

```JSON
{
    "canonicalizedResource":"/blob/<STORAGE ACCOUNT NAME>/<CONTAINER NAME>",
    "signedResource":"c",              // The kind of resource accessible with the SAS, in this case a container (c).
    "signedPermission":"rcw",          // Permissions for this SAS, in this case (r)ead, (c)reate, and (w)rite. Order is important.
    "signedProtocol":"https",          // Require the SAS be used on https protocol.
    "signedExpiry":"<EXPIRATION TIME>" // UTC expiration time for SAS in ISO 8601 format, for example 2017-09-22T00:06:00Z.
}
```

The parameters here are included in the POST body of the request for the SAS credential. For more information on parameters for creating a SAS credential, see the [List Service SAS REST reference](/rest/api/storagerp/storage-accounts/list-service-sas).

1. Convert the parameters to JSON, then call the storage `listServiceSas` endpoint to create the SAS credential:

   ```powershell
   $params = @{canonicalizedResource="/blob/<STORAGE-ACCOUNT-NAME>/<CONTAINER-NAME>";signedResource="c";signedPermission="rcw";signedProtocol="https";signedExpiry="2017-09-23T00:00:00Z"}
   $jsonParams = $params | ConvertTo-Json
   ```

   ```powershell
   $sasResponse = Invoke-WebRequest -Uri https://management.azure.com/subscriptions/<SUBSCRIPTION-ID>/resourceGroups/<RESOURCE-GROUP>/providers/Microsoft.Storage/storageAccounts/<STORAGE-ACCOUNT-NAME>/listServiceSas/?api-version=2017-06-01 -Method POST -Body $jsonParams -Headers @{Authorization="Bearer $ArmToken"}
   ```

   > [!NOTE] 
   > The URL is case-sensitive, so ensure that you use the exact same case used when you named the resource group, including the uppercase "G" in `resourceGroups`. 

1. Next, extract the SAS credential from the response:

   ```powershell
   $sasContent = $sasResponse.Content | ConvertFrom-Json
   $sasCred = $sasContent.serviceSasToken
   ```

1. If you inspect the SAS credential, you should see something like this:

   ```powershell
   PS C:\> $sasCred
   sv=2015-04-05&sr=c&spr=https&se=2017-09-23T00%3A00%3A00Z&sp=rcw&sig=JVhIWG48nmxqhTIuN0uiFBppdzhwHdehdYan1W%2F4O0E%3D
   ```

1. Create a file called *test.txt*. Then use the SAS credential to authenticate with the `New-AzStorageContent` cmdlet, upload the file to the blob container, then download the file.

   ```bash
   echo "This is a test text file." > test.txt
   ```

1. Be sure to install the Azure Storage cmdlets first, using `Install-Module Azure.Storage`. Then upload the blob you just created, using the PowerShell `Set-AzStorageBlobContent` cmdlet:

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

1. You can also download the blob you uploaded, using the `Get-AzStorageBlobContent` PowerShell cmdlet:

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
