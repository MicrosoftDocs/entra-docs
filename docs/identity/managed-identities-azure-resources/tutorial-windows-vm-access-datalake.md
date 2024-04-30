---
title: Tutorial`:` Use a managed identity to access Azure Data Lake Store - Windows
description: A tutorial that shows you how to use a Windows VM system-assigned managed identity to access Azure Data Lake Store.

author: barclayn
manager: amycolannino

ms.service: entra-id
ms.subservice: managed-identities
ms.topic: tutorial
ms.tgt_pltfrm: na
ms.date: 02/18/2022
ms.author: barclayn

---

# Tutorial: Use a Windows VM system-assigned managed identity to access Azure Data Lake Store

[!INCLUDE [preview-notice](~/includes/entra-msi-preview-notice.md)]

This tutorial shows you how to use a system-assigned managed identity for a Windows virtual machine (VM) to access an Azure Data Lake Store. Managed identities are automatically managed by Azure. They enable your application to authenticate to services that support Microsoft Entra authentication, without needing to insert credentials into your code.

In this article you learn how to:

> [!div class="checklist"]
> * Grant your VM access to an Azure Data Lake Store
> * Get an access token using the VM identity and use it to access an Azure Data Lake Store

## Prerequisites

- An understanding of Managed identities. If you're not familiar with the managed identities for Azure resources feature, see this [overview](overview.md). 
- An Azure account, [sign up for a free account](https://azure.microsoft.com/free/).
- "Owner" permissions at the appropriate scope (your subscription or resource group) to perform required resource creation and role management steps. If you need assistance with role assignment, see [Assign Azure roles to manage access to your Azure subscription resources](/azure/role-based-access-control/role-assignments-portal).
- You also need a Windows Virtual machine that has system assigned managed identities enabled.
  - If you need to create  a virtual machine for this tutorial, you can follow the article titled [Create a virtual machine with system-assigned identity enabled](./qs-configure-portal-windows-vm.md#system-assigned-managed-identity)




## Enable

[!INCLUDE [msi-tut-enable](~/includes/entra-msi-tut-enable.md)]



## Grant access

Now you can grant your VM access to files and folders in an Azure Data Lake Store.  For this step, you can use an existing Data Lake Store or create a new one.  To create a new Data Lake Store using the Azure portal, follow this [Azure Data Lake Store quickstart](/azure/data-lake-store/data-lake-store-get-started-portal). There are also quickstarts that use the Azure CLI and Azure PowerShell in the [Azure Data Lake Store documentation](/azure/data-lake-store/data-lake-store-overview).

In your Data Lake Store, create a new folder and grant your VM's system-assigned identity permission. The identity needs rights to read, write, and execute files in that folder:

1. In the Azure portal, select **Data Lake Store** in the left-hand navigation.
2. Select the Data Lake Store you want to use for this tutorial.
3. Select **Data Explorer** in the command bar.
4. The root folder of the Data Lake Store is selected.  Select **Access** in the command bar.
5. Select **Add**.  In the **Select** field, enter the name of your VM, for example **DevTestVM**.  Select to select your VM from the search results, then select **Select**.
6. Select **Select Permissions**.  Select **Read** and **Execute**, add to **This folder**, and add as **An access permission only**.  Select **Ok**.  The permission should be added successfully.
7. Close the **Access** blade.
8. For this tutorial, create a new folder.  Select **New Folder** in the command bar, and give the new folder a name, for example **TestFolder**.  Select **Ok**.
9. Select on the folder you created, then select **Access** in the command bar.
10. Similar to step 5, select **Add**, in the **Select** field enter the name of your VM, select it and select **Select**.
11. Similar to step 6, select **Select Permissions**, select **Read**, **Write**, and **Execute**, add to **This folder**, and add as **An access permission entry and a default permission entry**.  Select **Ok**.  The permission should be added successfully.

Your VM's system-assigned managed identity can now perform all operations on files in the folder you created.  For more information on managing access to Data Lake Store, read this article on [Access Control in Data Lake Store](/azure/data-lake-store/data-lake-store-access-control).

## Access data

Azure Data Lake Store natively supports Microsoft Entra authentication, so it can directly accept access tokens obtained using managed identities for Azure resources.  To authenticate to the Data Lake Store filesystem, you send an access token issued by Microsoft Entra ID to your Data Lake Store filesystem endpoint in an Authorization header. The header has the format "Bearer <ACCESS_TOKEN_VALUE>".  To learn more about Data Lake Store support for Microsoft Entra authentication, read [Authentication with Data Lake Store using Microsoft Entra ID](/azure/data-lake-store/data-lakes-store-authentication-using-azure-active-directory)

> [!NOTE]
> The Data Lake Store filesystem client SDKs do not yet support managed identities for Azure resources.  This tutorial will be updated when support is added to the SDK.

In this tutorial, you authenticate to the Data Lake Store filesystem REST API using PowerShell to make REST requests. To use the VM's system-assigned managed identity for authentication, you need to make the requests from the VM.

1. In the portal, navigate to **Virtual Machines**, go to your Windows VM, and in the **Overview** select **Connect**.
2. Enter in your **Username** and **Password** for which you added when you created the Windows VM. 
3. Now that you've created a **Remote Desktop Connection** with the virtual machine, open **PowerShell** in the remote session. 
4. Using PowerShell’s `Invoke-WebRequest`, make a request to the local managed identities for Azure resources endpoint to get an access token for Azure Data Lake Store.  The resource identifier for Data Lake Store is `https://datalake.azure.net/`.  Data Lake does an exact match on the resource identifier and the trailing slash is important.

   ```powershell
   $response = Invoke-WebRequest -Uri 'http://169.254.169.254/metadata/identity/oauth2/token?api-version=2018-02-01&resource=https%3A%2F%2Fdatalake.azure.net%2F' -Method GET -Headers @{Metadata="true"}
   ```
    
   Convert the response from a JSON object to a PowerShell object. 
    
   ```powershell
   $content = $response.Content | ConvertFrom-Json
   ```

   Extract the access token from the response.
    
   ```powershell
   $AccessToken = $content.access_token
   ```

5. Check that everything is configured correctly. Using PowerShell's `Invoke-WebRequest', make a request to your Data Lake Store's REST endpoint to list the folders in the root folder. It's important the string "Bearer" in the Authorization header has a capital "B".  You can find the name of your Data Lake Store in the **Overview** section of your Data Lake Store.

   ```powershell
   Invoke-WebRequest -Uri https://<YOUR_ADLS_NAME>.azuredatalakestore.net/webhdfs/v1/?op=LISTSTATUS -Headers @{Authorization="Bearer $AccessToken"}
   ```

   A successful response looks like:

   ```powershell
   StatusCode        : 200
   StatusDescription : OK
   Content           : {"FileStatuses":{"FileStatus":[{"length":0,"pathSuffix":"TestFolder","type":"DIRECTORY", "blockSize":0,"accessTime":1507934941392, "modificationTime":1507944835699,"replication":0, "permission":"770","ow..."
   RawContent        : HTTP/1.1 200 OK
                       Pragma: no-cache
                       x-ms-request-id: b4b31e16-e968-46a1-879a-3474aa7d4528
                       x-ms-webhdfs-version: 17.04.22.00
                       Status: 0x0
                       X-Content-Type-Options: nosniff
                       Strict-Transport-Security: ma...
   Forms             : {}
   Headers           : {[Pragma, no-cache], [x-ms-request-id, b4b31e16-e968-46a1-879a-3474aa7d4528],
                       [x-ms-webhdfs-version, 17.04.22.00], [Status, 0x0]...}
   Images            : {}
   InputFields       : {}
   Links             : {}
   ParsedHtml        : System.__ComObject
   RawContentLength  : 556
   ```

6. Now you can try uploading a file to your Data Lake Store.  First, create a file to upload.

   ```powershell
   echo "Test file." > Test1.txt
   ```

7. Using PowerShell's `Invoke-WebRequest`, make a request to your Data Lake Store's REST endpoint to upload the file to the folder you created earlier.  This request takes two steps.  In the first step, you make a request and get a redirection to where the file should be uploaded.  In the second step, you actually upload the file.  Remember to set the name of the folder and file appropriately if you used different values than in this tutorial. 

   ```powershell
   $HdfsRedirectResponse = Invoke-WebRequest -Uri https://<YOUR_ADLS_NAME>.azuredatalakestore.net/webhdfs/v1/TestFolder/Test1.txt?op=CREATE -Method PUT -Headers @{Authorization="Bearer $AccessToken"} -Infile Test1.txt -MaximumRedirection 0
   ```

   If you inspect the value of `$HdfsRedirectResponse`, it should look like the following response:

   ```powershell
   PS C:\> $HdfsRedirectResponse

   StatusCode        : 307
   StatusDescription : Temporary Redirect
   Content           : {}
   RawContent        : HTTP/1.1 307 Temporary Redirect
                       Pragma: no-cache
                       x-ms-request-id: b7ab492f-b514-4483-aada-4aa0611d12b3
                       ContentLength: 0
                       x-ms-webhdfs-version: 17.04.22.00
                       Status: 0x0
                       X-Content-Type-Options: nosn...
   Headers           : {[Pragma, no-cache], [x-ms-request-id, b7ab492f-b514-4483-aada-4aa0611d12b3], 
                       [ContentLength, 0], [x-ms-webhdfs-version, 17.04.22.00]...}
   RawContentLength  : 0
   ```

   Complete the upload by sending a request to the redirect endpoint:

   ```powershell
   Invoke-WebRequest -Uri $HdfsRedirectResponse.Headers.Location -Method PUT -Headers @{Authorization="Bearer $AccessToken"} -Infile Test1.txt -MaximumRedirection 0
   ```

   A successful response look like:

   ```powershell
   StatusCode        : 201
   StatusDescription : Created
   Content           : {}
   RawContent        : HTTP/1.1 201 Created
                       Pragma: no-cache
                       x-ms-request-id: 1e70f36f-ead1-4566-acfa-d0c3ec1e2307
                       ContentLength: 0
                       x-ms-webhdfs-version: 17.04.22.00
                       Status: 0x0
                       X-Content-Type-Options: nosniff
                       Strict...
   Headers           : {[Pragma, no-cache], [x-ms-request-id, 1e70f36f-ead1-4566-acfa-d0c3ec1e2307],
                       [ContentLength, 0], [x-ms-webhdfs-version, 17.04.22.00]...}
   RawContentLength  : 0
   ```

Using other Data Lake Store filesystem APIs you can append to files, download files, and more.


## Disable

[!INCLUDE [msi-tut-disable](~/includes/entra-msi-tut-disable.md)]


## Next steps

In this tutorial, you learned how to use a system-assigned managed identity for a Windows virtual machine to access an Azure Data Lake Store. To learn more about Azure Data Lake Store, see:

> [!div class="nextstepaction"]
>[Azure Data Lake Store](/azure/data-lake-store/data-lake-store-overview)
