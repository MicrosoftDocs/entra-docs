---
author: barclayn
ms.author: barclayn
ms.date: 05/28/2024
ms.topic: include
---

## Use a Windows VM system-assigned managed identity to access Azure Storage

This tutorial shows you how to use a system-assigned managed identity for a Windows virtual machine (VM) to access Azure Storage. You learn how to:

> [!div class="checklist"]
> * Create a blob container in a storage account
> * Grant your Windows VM's system-assigned managed identity access to a storage account
> * Get an access and use it to call Azure Storage

## Enable

[!INCLUDE [msi-tut-enable](~/includes/entra-msi-tut-enable.md)]

### Create storage account

In this section, you create a storage account.

1. Select the **+ Create a resource** button found on the upper-left corner of the Azure portal.
1. Select **Storage**, then **Storage account - blob, file, table, queue**.
1. In the **Name** field, enter a name for the storage account.
1. **Deployment model** and **Account kind** should be set to **Resource manager** and **Storage (general purpose v1)**.
1. Ensure the **Subscription** and **Resource Group** match the ones you specified when you created your VM in the previous step.
1. Select **Create**.

    :::image type="content" source="../media/msi-tutorial-linux-vm-access-storage/msi-storage-create.png" alt-text="Screenshot showing how to create new storage account.":::

### Create a blob container and upload a file to the storage account

Files require blob storage so you need to create a blob container in which to store the file. You then upload a file to the blob container in the new storage account.

1. Navigate to your newly created storage account.
1. In the **Blob Service** section, select **Containers**.
1. Select **+ Container** on the top of the page.
1. In the **New container** field, enter a name for the container, then in the **Public access level** option, keep the default value.

    :::image type="content" source="../media/msi-tutorial-linux-vm-access-storage/create-blob-container.png" alt-text="Screenshot showing how to create storage container.":::

1. Using an editor of your choice, create a file titled *hello world.txt* on your local machine. Open the file and add the text *Hello world!*, then save it.
1. Select the container name to upload the file to the newly created container, then select **Upload**.
1. In the **Upload blob** pane, in the **Files** section, select the folder icon and browse to the file **hello_world.txt** on your local machine. Then select the file and **Upload**.
    :::image type="content" source="../media/msi-tutorial-linux-vm-access-storage/upload-text-file.png" alt-text="Screenshot showing the text file upload screen.":::

### Grant access

This section shows how to grant your VM access to an Azure Storage container. You can use the VM's system-assigned managed identity to retrieve the data in the Azure storage blob.

1. Navigate to your newly created storage account.
1. Select **Access control (IAM)**.
1. Select **Add** > **Add role assignment** to open the **Add role assignment** page.
1. Assign the following role. For detailed steps, see [Assign Azure roles using the Azure portal](/azure/role-based-access-control/role-assignments-portal).
    
    | Setting | Value |
    | --- | --- |
    | Role | Storage Blob Data Reader |
    | Assign access to | Managed identity |
    | System-assigned | Virtual Machine |
    | Select | &lt;your virtual machine&gt; |

    :::image type="content" source="../media/msi-tutorial-linux-vm-access-storage/add-role-assignment-page.png" alt-text="Screenshot that shows the page for adding a role assignment.":::

## Access data 

Azure Storage natively supports Microsoft Entra authentication, so it can directly accept access tokens obtained using a managed identity. This approach uses Azure Storage's integration with Microsoft Entra ID, and is different from supplying credentials on the connection string.

Here's a .NET code example of opening a connection to Azure Storage. The example uses an access token and then reads the contents of the file you created earlier. This code must run on the VM to be able to access the VM's managed identity endpoint. .NET Framework 4.6 or higher is required to use the access token method. Replace the value of `<URI to blob file>` accordingly. You can obtain this value by navigating to file you created and uploaded to blob storage and copying the **URL** under **Properties** the **Overview** page.

```csharp
using System;
using System.Threading.Tasks;
using System.IO;
using Azure.Identity;
using Azure.Storage.Blobs;

namespace StorageOAuthToken
{
    class Program
    {
        static async Task Main(string[] args)
        {
            string blobUrl = "https://<your-storage-account>.blob.core.windows.net/<your-container>/<your-blob>";

            var blobUriBuilder = new BlobUriBuilder(new Uri(blobUrl));
            var serviceUri = new Uri($"https://{blobUriBuilder.Host}");
            var containerName = blobUriBuilder.BlobContainerName;
            var blobName = blobUriBuilder.BlobName;

            // create token credential
            var tokenCredential = new DefaultAzureCredential();

            //get blob client
            var blobServiceClient = new BlobServiceClient(serviceUri, tokenCredential);

            // Read blob contents
            var blobContainerClient = blobServiceClient.GetBlobContainerClient(containerName);
            var blobClient = blobContainerClient.GetBlobClient(blobName);

            using (var stream = await blobClient.OpenReadAsync())
            {
                using (var reader = new StreamReader(stream))
                {
                    Console.WriteLine(await reader.ReadToEndAsync());
                }
            }
            Console.ReadLine();
        }
    }
}
```

The response contains the contents of the file:

`Hello world! :)`


## Disable

[!INCLUDE [msi-tut-disable](~/includes/entra-msi-tut-disable.md)]
