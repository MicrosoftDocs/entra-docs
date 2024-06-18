---
author: barclayn 
ms.author: barclayn
ms.date: 06/06/2024 
ms.topic: include
ms.service: entra-id
ms.subservice: managed-identities
---

## Use a Windows VM system-assigned managed identity to access Azure Key Vault 

This tutorial shows you how a Windows virtual machine (VM) can use a system-assigned managed identity to access [Azure Key Vault](/azure/key-vault/general/overview). Key Vault makes it possible for your client application to use a secret to access resources not secured by Microsoft Entra ID. Managed identities are automatically managed by Azure. They enable you to authenticate to services that support Microsoft Entra authentication, without including authentication information in your code.

You'll learn how to:

> [!div class="checklist"]
> * Grant your VM access to a secret stored in a Key Vault
> * Get an access token using the VM identity and use it to retrieve the secret from Key Vault 

## Create a Key Vault  

[!INCLUDE [portal updates](~/includes/portal-update.md)]

This section shows how to grant your VM access to a secret stored in a Key Vault. When you use managed identities for Azure resources, your code can get access tokens to authenticate to resources that support Microsoft Entra authentication. 

However, not all Azure services support Microsoft Entra authentication. To use managed identities for Azure resources with those services, store the service credentials in Azure Key Vault, and use the VM's managed identity to access Key Vault to retrieve the credentials.

First, you need to create a Key Vault and grant your VM’s system-assigned managed identity access to the Key Vault.

1. Sign in to the [Azure portal](https://portal.azure.com/).
1. At the top of the left navigation bar, select **Create a resource**.
1. In the **Search the Marketplace** box type in **Key Vault** and press **Enter**.
1. Select **Key Vault** from the results, then select **Create**.
1. Provide a **Name** for the new key vault.

    :::image type="content" source="../media/msi-tutorial-windows-vm-access-nonaad/create-key-vault.png" alt-text="Screenshot of the Create a Key vault screen.":::

1. Fill out all required information. Make sure that you choose the subscription and resource group that you're using for this tutorial.
1. Select **Review+ create**.
1. Select **Create**.

## Create a secret

Next, you need to add a secret to the Key Vault, so you can retrieve it later using code running in your VM. In this section you use PowerShell, but the same concepts apply to any code that you execute in your VM.

1. Navigate to your newly created Key Vault.
1. Select **Secrets**, then select **Add**.
1. Select **Generate/Import**.
1. From the **Create a secret** screen, in the **Upload options** leave **Manual** selected.
1. Enter a name and value for the secret. The value can be anything you want. 
1. Leave the activation date and expiration date clear, and leave **Enabled** as **Yes**. 
1. Select **Create** to create the secret.

   :::image type="content" source="../media/msi-tutorial-windows-vm-access-nonaad/create-secret.png" alt-text="Screenshot showing how to create a secret.":::

## Grant access

The managed identity used by the VM needs to be granted access to read the secret that the Key Vault stores.

1. Navigate to your newly created Key Vault.
1. Select **Access Policy** from the menu on the left side.
1. Select **Add Access Policy**.

   :::image type="content" source="../media/msi-tutorial-windows-vm-access-nonaad/key-vault-access-policy.png" alt-text="Screenshot showing the Key vault  access policy screen.":::

1. In the **Add access policy** section, under **Configure from template (optional)**, choose **Secret Management** from the drop-down menu.
1. Choose **Select Principal**, then in the search field enter the name of the VM you created earlier. 
1. Select the VM in the result list, then choose **Select**.
1. Select **Add**.
1. Select **Save**.

## Access data

This section shows you how to get an access token using the VM identity and use it to retrieve the secret from Key Vault. If you don’t have PowerShell 4.3.1 or greater installed, you'll need to [download and install the latest version](/powershell/azure/).

> [!NOTE]
> The method of using PowerShell to authenticate and retrieve the secret is preferred in scenarios where managed identities are specifically required, or when embedding the process within an application's code.

First, use the VM’s system-assigned managed identity to get an access token to authenticate to Key Vault:
 
1. In the portal, navigate to **Virtual Machines** and go to your Windows VM, then in the **Overview**, select **Connect**.
1. Enter in your **Username** and **Password** that you added when you created the **Windows VM**.
1. Now that you've created a **Remote Desktop Connection** with the VM, open PowerShell in a remote session.
1. In PowerShell, invoke the web request on the tenant to get the token for the local host in the specific port for the VM.

> [!NOTE]
> If using a sovereign cloud, such as GCC-H, use the endpoint `vault.usgovcloudapi.net` instead of `vault.azure.net` in the PowerShell cmdlet.

Example PowerShell request:

```powershell
$Response = Invoke-RestMethod -Uri 'http://169.254.169.254/metadata/identity/oauth2/token?api-version=2018-02-01&resource=https%3A%2F%2Fvault.azure.net' -Method GET -Headers @{Metadata="true"} 
```

> [!NOTE]
> When working with sovereign clouds, you need to make adjustments to the endpoint specified at the end of the cmdlet. 

For example, `vault.usgovcloudapi.net` should be used when working with Azure Government Cloud, with this being the end result: 

`$Response = Invoke-RestMethod -Uri 'http://169.254.169.254/metadata/identity/oauth2/token?api-version=2018-02-01&resource=https%3A%2F%2Fvault.usgovcloudapi.net' -Method GET -Headers @{Metadata="true"`

To confirm that the suffix matches your environment, review the article [Azure Key vault security overview](/azure/key-vault/general/security-features#privileged-access).

The response should look like:

:::image type="content" source="../media/msi-tutorial-windows-vm-access-nonaad/token.png" alt-text="Screenshot showing a request with token response.":::

Next, extract the access token from the response.

```powershell
   $KeyVaultToken = $Response.access_token
```

Finally, use the PowerShell `Invoke-WebRequest` cmdlet to retrieve the secret you created earlier in the Key Vault, passing the access token in the Authorization header. You’ll need the URL of your Key Vault, which is in the **Essentials** section of the **Overview** page of the Key Vault.

```powershell
Invoke-RestMethod -Uri https://<your-key-vault-URL>/secrets/<secret-name>?api-version=2016-10-01 -Method GET -Headers @{Authorization="Bearer $KeyVaultToken"}
```

The response should look like this: 

```powershell
  value       id                                                                                    attributes
  -----       --                                                                                    ----------
  'My Secret' https://mi-lab-vault.vault.azure.net/secrets/mi-test/50644e90b13249b584c44b9f712f2e51 @{enabled=True; created=16…
```

Once you’ve retrieved the secret from the Key Vault, you can use it to authenticate to a service that requires a name and password.

## Clean up resources

Finally, when you want to clean up resources, sign in to the [Azure portal](https://portal.azure.com), select **Resource groups**, then locate and select the resource group that was created in the process of this tutorial (such as `mi-test`). Then use the **Delete resource group** command.

Or, you can also clean up resources using [PowerShell or the CLI](/azure/azure-resource-manager/management/delete-resource-group).

