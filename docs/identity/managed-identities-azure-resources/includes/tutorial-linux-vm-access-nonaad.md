---
author: barclayn
ms.author: barclayn
ms.date: 06/10/2024
ms.topic: include
ms.service: entra-id
ms.subservice: managed-identities
ms.custom:
  - linux-related-content
---

## Use a Linux VM system-assigned managed identity to access Azure Key Vault 

This tutorial shows you how a Linux virtual machine (VM) can use a system-assigned managed identity to access [Azure Key Vault](/azure/key-vault/general/overview). Key Vault makes it possible for your client application to then use a secret to access resources not secured by Microsoft Entra ID. Managed Service Identities are automatically managed by Azure and enable you to authenticate to services that support Microsoft Entra authentication, without including authentication information in your code.

You'll learn how to:

> [!div class="checklist"]
> * Grant your VM access to a secret stored in a Key Vault 
> * Get an access token using the VM's identity and use it to retrieve the secret from the Key Vault 
 
## Create a Key Vault  

You also need a Linux Virtual machine that has system assigned managed identities enabled.
  - If you need to create  a virtual machine for this tutorial, you can follow the article titled [Create a Linux virtual machine with the Azure portal](/azure/virtual-machines/linux/quick-create-portal#create-virtual-machine)


[!INCLUDE [portal updates](~/includes/portal-update.md)]

This section shows how to grant your VM access to a secret stored in a Key Vault. Using managed identities for Azure resources, your code can get access tokens to authenticate to resources that support Microsoft Entra authentication.

However, not all Azure services support Microsoft Entra authentication. To use managed identities for Azure resources with those services, store the service credentials in Azure Key Vault, and use the VM's managed identity to access Key Vault to retrieve the credentials.

First, you need to create a Key Vault and grant your VM's system-assigned managed identity access to the Key Vault.

1. Sign in to the [Azure portal](https://portal.azure.com/).
1. At the top of the left navigation bar, select **Create a resource**.
1. In the **Search the Marketplace** box type in **Key Vault** and hit **Enter**.
1. Select **Key Vault** from the results.
1. Select **Create**.
1. Provide a **Name** for the new key vault.

    :::image type="content" source="../media/tutorial-linux-vm-access-nonaad/create-key-vault.png" alt-text="Screenshot showing the Azure Key vault creation screen.":::

1. Fill out all required information making sure that you choose the subscription and resource group where you created the virtual machine that you are using for this tutorial.
1. Select **Review+ create**, then  select **Create**.

## Create a secret

Next, you need to add a secret to the Key Vault, so you can retrieve it later using code running in your VM. In this section, you'll use PowerShell. But the same concepts apply to any code executing in this virtual machine.

1. Navigate to your newly created Key Vault.
1. Select **Secrets**, then select **Add**.
1. Select **Generate/Import**.
1. In the **Create a secret** section, go to **Upload options** and make sure that **Manual** is selected.
1. Enter a name and value for the secret.  The value can be anything you want. 
1. Leave the activation date and expiration date clear, and make sure that **Enabled** is set to **Yes**. 
1. Select **Create** to create the secret.

   :::image type="content" source="../media/tutorial-linux-vm-access-nonaad/create-secret.png" alt-text="Screenshot showing secret creation.":::

## Grant access

The managed identity used by the virtual machine needs access to read the secret stored in Key Vault.

1. Navigate to your newly created Key Vault.
1. Select **Access Policy** from the left navigation.
1. Select **Add Access Policy**.

   :::image type="content" source="../media/tutorial-linux-vm-access-nonaad/key-vault-access-policy.png" alt-text="Screenshot of the key vault create access policy screen.":::

1. In the **Add access policy** section under **Configure from template (optional)**, choose **Secret Management** from the drop-down menu.
1. Choose **Select Principal**, then in the search field enter the name of the VM you created earlier.  Select the VM in the result list, then **Select**.
1. Select **Add**.
1. Select **Save**.

## Access data

To complete these steps, you need an SSH client.  If you are using Windows, you can use the SSH client in the [Windows Subsystem for Linux](/windows/wsl/about). If you need assistance configuring your SSH client's keys, see [How to Use SSH keys with Windows on Azure](/azure/virtual-machines/linux/ssh-from-windows), or [How to create and use an SSH public and private key pair for Linux VMs in Azure](/azure/virtual-machines/linux/mac-create-ssh-keys).

>[!IMPORTANT]
> All Azure SDKs support the Azure.Identity library that makes it easy to acquire Microsoft Entra tokens to access target services. Learn more about [Azure SDKs](https://azure.microsoft.com/downloads/) and accessing the Azure.Identity library.
> - [.NET](/dotnet/api/overview/azure/identity-readme)
> - [Java](/java/api/overview/azure/identity-readme)
> - [JavaScript](/javascript/api/overview/azure/identity-readme)
> - [Python](/python/api/overview/azure/identity-readme)


1. In the portal, navigate to your Linux VM and in the **Overview**, select **Connect**. 
1. **Connect** to the VM with the SSH client of your choice. 
1. In the terminal window, use cURL to make a request to the local managed identities for Azure resources endpoint to get an access token for Azure Key Vault.
 
  The CURL request for the access token is below.
    
  ```bash
  curl 'http://169.254.169.254/metadata/identity/oauth2/token?api-version=2018-02-01&resource=https%3A%2F%2Fvault.azure.net' -H Metadata:true
    ```
  The response includes the access token you need to access Resource Manager. 
    
  Response:
    
  ```bash
  {"access_token":"eyJ0eXAi...",
  "refresh_token":"",
  "expires_in":"3599",
  "expires_on":"1504130527",
  "not_before":"1504126627",
  "resource":"https://vault.azure.net",
  "token_type":"Bearer"} 
  ```
    
  You can use this access token to authenticate to Azure Key Vault.  The next CURL request shows how to read a secret from Key Vault using CURL and the Key Vault REST API.  You need the URL of your Key Vault, which is in the **Essentials** section of the **Overview** page of the Key Vault.  You also need the access token you obtained on the previous call. 
        
  ```bash
  curl 'https://<YOUR-KEY-VAULT-URL>/secrets/<secret-name>?api-version=2016-10-01' -H "Authorization: Bearer <ACCESS TOKEN>" 
  ```
    
  The response looks like this: 
    
  ```bash
  {"value":"p@ssw0rd!","id":"https://mytestkeyvault.vault.azure.net/secrets/MyTestSecret/7c2204c6093c4d859bc5b9eff8f29050","attributes":{"enabled":true,"created":1505088747,"updated":1505088747,"recoveryLevel":"Purgeable"}} 
  ```
    
Once you retrieved the secret from the Key Vault, you can use it to authenticate to a service that requires a name and password.

## Clean up resources

When you're ready to clean up the resources, sign in to the [Azure portal](https://portal.azure.com), select **Resource groups**, then locate and select the resource group that was created in the process of this tutorial, such as `mi-test`. You can use the **Delete resource group** command or via [PowerShell or CLI.](/azure/azure-resource-manager/management/delete-resource-group)
