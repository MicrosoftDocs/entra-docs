---
author: barclayn 
ms.author: barclayn
ms.date: 06/06/2024 
ms.topic: include
ms.service: entra-id
ms.subservice: managed-identities
---

## Use a Windows VM system-assigned managed identity to access Azure SQL Database

This tutorial shows you how to use a system-assigned identity for a Windows virtual machine (VM) to access Azure SQL Database. Managed Service Identities are automatically managed by Azure and enable you to authenticate to services that support Microsoft Entra authentication, without needing to insert credentials into your code. 

You'll learn how to:

> [!div class="checklist"]
>
> * Grant your VM access to Azure SQL Database
> * Enable Microsoft Entra authentication
> * Create a contained user in the database that represents the VM's system assigned identity
> * Get an access token using the VM identity and use it to query Azure SQL Database

## Enable

[!INCLUDE [msi-tut-enable](~/includes/entra-msi-tut-enable.md)]

## Grant access

To grant your VM access to a database in Azure SQL Database, use an existing [logical SQL server](/azure/azure-sql/database/logical-servers) or create a new one. To create a new server and database using the Azure portal, follow the [Azure SQL quickstart](/azure/azure-sql/database/single-database-create-quickstart). There are also quickstarts that use the Azure CLI and Azure PowerShell in the [Azure SQL documentation](/azure/azure-sql/).

Follow these steps to grant your VM access to a database:

1. Enable Microsoft Entra authentication for the server.
1. Create a *contained user* in the database that represents the VM's system-assigned identity.

<a name='enable-azure-ad-authentication'></a>

## Enable Microsoft Entra authentication

To [configure Microsoft Entra authentication](/azure/azure-sql/database/authentication-aad-configure):

1. In the Azure portal, select **SQL server** from the left-hand navigation.
1. Select the SQL server you want to enable for Microsoft Entra authentication.
1. In the **Settings** section of the blade, select **Active Directory admin**.
1. In the command bar, select **Set admin**.
1. Select a Microsoft Entra user account to be made an administrator for the server, and select **Select**.
1. In the command bar, select **Save.**

## Create contained user

This section shows you how to create a contained user in the database that represents the VM's system assigned identity. For this step, you need [Microsoft SQL Server Management Studio (SSMS)](/sql/ssms/download-sql-server-management-studio-ssms) installed. Before starting, it may be helpful to review the following articles for background on Microsoft Entra integration:

- [Universal Authentication with SQL Database and Azure Synapse Analytics (SSMS support for MFA)](/azure/azure-sql/database/authentication-mfa-ssms-overview)
- [Configure and manage Microsoft Entra authentication with SQL Database or Azure Synapse Analytics](/azure/azure-sql/database/authentication-aad-configure)

SQL databases require unique Microsoft Entra ID display names. With this, Microsoft Entra accounts, such as users, groups and service principals (applications), and VM names enabled for managed identity must be uniquely defined in Microsoft Entra ID specific to their corresponding display names. SQL checks the Microsoft Entra ID display names during T-SQL creation of such users. If the display names aren't unique, the command fails and prompts you to provide a unique Microsoft Entra ID display name for each given account.

### To create a contained user

1. Open SQL Server Management Studio.
1. In the **Connect to Server** dialog, enter your server name in the **Server name** field.
1. In the **Authentication** field, select **Active Directory - Universal with MFA support**.
1. In the **User name** field, enter the name of the Microsoft Entra account that you set as the server administrator; for example, *cjensen@fabrikam.com*.
1. Select **Options**.
1. In the **Connect to database** field, enter the name of the non-system database you want to configure.
1. Select **Connect**, then complete the sign-in process.
1. In the **Object Explorer**, expand the **Databases** folder.
1. Right-click on a user database, then select **New query**.
1. In the query window, enter the following line, and select **Execute** in the toolbar:

    > [!NOTE]
    > `VMName` in the following command is the name of the VM that you enabled system assigned identity on in the prerequsites section.

    ```sql
    CREATE USER [VMName] FROM EXTERNAL PROVIDER
    ```

    The command should complete successfully by creating the contained user for the VM's system-assigned identity.

1. Clear the query window, enter the following line, and select **Execute** in the toolbar:

    > [!NOTE]
    > `VMName` in the following command is the name of the VM that you enabled system assigned identity on in the prerequisites section.
    > 
    > If you encounter the error "Principal `VMName` has a duplicate display name", append the CREATE USER statement with WITH OBJECT_ID='xxx'.

    ```sql
    ALTER ROLE db_datareader ADD MEMBER [VMName]
    ```

    The command should complete successfully by granting the contained user the ability to read the entire database.

Code running in the VM can now get a token using its system-assigned managed identity and use the token to authenticate to the server.

## Access data

This section shows you how to get an access token using the VM's system-assigned managed identity and use it to call Azure SQL. Azure SQL natively supports Microsoft Entra authentication, so it can directly accept access tokens obtained using managed identities for Azure resources. This method doesn't require supplying credentials on the connection string.

Here's a .NET code example of opening a connection to SQL using Active Directory Managed Identity authentication. The code must run on the VM to be able to access the VM's system-assigned managed identity's endpoint. 

**.NET Framework 4.6.2** or higher or **.NET Core 3.1** or higher is required to use this method. Replace the values of AZURE-SQL-SERVERNAME and DATABASE accordingly and add a NuGet reference to the Microsoft.Data.SqlClient library.

```csharp
using Microsoft.Data.SqlClient;

try
{
//
// Open a connection to the server using Active Directory Managed Identity authentication.
//
string connectionString = "Data Source=<AZURE-SQL-SERVERNAME>; Initial Catalog=<DATABASE>; Authentication=Active Directory Managed Identity; Encrypt=True";
SqlConnection conn = new SqlConnection(connectionString);
conn.Open();
```

> [!NOTE]
> You can use managed identities while working with other programming options using our [SDKs](~/identity/managed-identities-azure-resources/how-to-configure-managed-identities.md).

Or, use PowerShell to test the end-to-end setup without having to write and deploy an app on the VM.

1. In the portal, navigate to **Virtual Machines**, go to your Windows VM, then in the **Overview**, select **Connect**.
1. Enter your **VM admin credential** that you added when you created the Windows VM.
1. Now that you have created a **Remote Desktop Connection** with the VM, open **PowerShell** in a remote session.
1. Using the PowerShell `Invoke-WebRequest` cmdlet, make a request to the local managed identity's endpoint to get an access token for Azure SQL.

    ```powershell
        $response = Invoke-WebRequest -Uri 'http://169.254.169.254/metadata/identity/oauth2/token?api-version=2018-02-01&resource=https%3A%2F%2Fdatabase.windows.net%2F' -Method GET -Headers @{Metadata="true"}
    ```

    Convert the response from a JSON object to a PowerShell object.

    ```powershell
    $content = $response.Content | ConvertFrom-Json
    ```

    Extract the access token from the response.

    ```powershell
    $AccessToken = $content.access_token
    ```

1. Open a connection to the server. Remember to replace the values for AZURE-SQL-SERVERNAME and DATABASE.

    ```powershell
    $SqlConnection = New-Object System.Data.SqlClient.SqlConnection
    $SqlConnection.ConnectionString = "Data Source = <AZURE-SQL-SERVERNAME>; Initial Catalog = <DATABASE>; Encrypt=True;"
    $SqlConnection.AccessToken = $AccessToken
    $SqlConnection.Open()
    ```

    Next, create and send a query to the server. Remember to replace the value for TABLE.

    ```powershell
    $SqlCmd = New-Object System.Data.SqlClient.SqlCommand
    $SqlCmd.CommandText = "SELECT * from <TABLE>;"
    $SqlCmd.Connection = $SqlConnection
    $SqlAdapter = New-Object System.Data.SqlClient.SqlDataAdapter
    $SqlAdapter.SelectCommand = $SqlCmd
    $DataSet = New-Object System.Data.DataSet
    $SqlAdapter.Fill($DataSet)
    ```

Finally, examine the value of `$DataSet.Tables[0]` to view the results of the query.

## Disable

[!INCLUDE [msi-tut-disable](~/includes/entra-msi-tut-disable.md)]
