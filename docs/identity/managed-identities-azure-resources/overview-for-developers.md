---
title: Developer introduction and guidelines
description: An overview how developers can use managed identities for Azure resources.

author: barclayn
manager: amycolannino
ms.assetid: 0232041d-b8f5-4bd2-8d11-27999ad69370
ms.service: entra-id
ms.subservice: managed-identities
ms.topic: overview

ms.date: 09/26/2024
ms.author: barclayn
ai-usage: ai-assisted


#Customer intent: As a developer, I'd like to securely manage the credentials that my application uses for authenticating to cloud services without having the credentials in my code or checked into source control. 
---

# Connecting from your application to resources without handling credentials

Azure resources with managed identities support **always** provide an option to specify a managed identity to connect to Azure resources that support Microsoft Entra authentication. Managed identities support makes it unnecessary for developers to manage credentials in code. Managed identities are the recommended authentication option when working with Azure resources that support them. [Read an overview of managed identities](overview.md).

This page demonstrates how to configure an App Service so it can connect to Azure Key Vault, Azure Storage, and Microsoft SQL Server. The same principles can be used for any Azure resource that supports managed identities and that will connect to resources that support Microsoft Entra authentication. 

The code samples use the Azure Identity client library, which is the recommended method as it automatically handles many of the steps for you, including acquiring an access token used in the connection.

## What resources can managed identities connect to?

A managed identity can connect to any resource that supports Microsoft Entra authentication. In general, there's no special support required for the resource to allow managed identities to connect to it.

Some resources don't support Microsoft Entra authentication, or their client library doesn't support authenticating with a token. Keep reading to see our guidance on how to use a Managed identity to securely access the credentials without needing to store them in your code or application configuration.

## Creating a managed identity

There are [two types of managed identities](overview.md#managed-identity-types): system-assigned and user-assigned. System-assigned identities are directly linked to a single Azure resource. When the Azure resource is deleted, so is the identity. A user-assigned managed identity can be associated with multiple Azure resources, and its lifecycle is independent of those resources. 

We recommend that you use a user-assigned managed identity, [for most scenarios](managed-identity-best-practice-recommendations.md). If the source resource you're using doesn't support user-assigned managed identities, then you should refer to that resource provider's documentation to learn how to configure it to have a system-assigned managed identity.


> [!IMPORTANT]
> The account used to create managed identities needs a role such as "Managed Identity Contributor" to create a new user-assigned managed identity.

Create a user-assigned managed identity using your preferred option:

- [Azure portal](how-manage-user-assigned-managed-identities.md?pivots=identity-mi-methods-azp)
- [Azure CLI](how-manage-user-assigned-managed-identities.md?pivots=identity-mi-methods-azcli)
- [Azure PowerShell](how-manage-user-assigned-managed-identities.md?pivots=identity-mi-methods-powershell)
- [Resource Manager](how-manage-user-assigned-managed-identities.md?pivots=identity-mi-methods-arm)
- [REST](how-manage-user-assigned-managed-identities.md?pivots=identity-mi-methods-rest)

After you create a user-assigned managed identity, take note of the `clientId` and the `principalId` values that are returned when the managed identity is created. You use `principalId` while adding permissions, and `clientId` in your application's code.

## Configure App Service with a user-assigned managed identity

Before you can use the managed identity in your code, we have to assign it to the App Service that will use it. The process of configuring an App Service to use a user-assigned managed identity requires that you [specify the managed identity's resource identifier in your app config](/azure/app-service/overview-managed-identity?tabs=portal%2Chttp#add-a-user-assigned-identity).

### Adding permissions to the identity

Once you've configured your App Service to use a user-assigned managed identity, grant the necessary permissions to the identity. In this scenario, we're using this identity to interact with Azure Storage, so you need to use the [Azure Role Based Access Control (RBAC) system](/azure/role-based-access-control/overview) to grant the user-assigned managed identity permissions to the resource.

> [!IMPORTANT]
> You'll need a role such as "User Access Administrator" or "Owner" for the target resource to add Role assignments. Ensure you're granting the least privilege required for the application to run.

Any resources you want to access requires that you grant the identity permissions. For example, if you request a token to access Key Vault, you must also add an access policy that includes the managed identity of your app or function. Otherwise, your calls to Key Vault will be rejected, even if you use a valid token. The same is true for Azure SQL Database. To learn more about which resources support Microsoft Entra tokens, see Azure services that support Microsoft Entra authentication.


## Using managed identities in your code

After you complete the steps outlined above, your App Service has a managed identity with permissions to an Azure resource. You can use the managed identity to obtain an access token that your code can use to interact with Azure resources, instead of storing credentials in your code.

We recommended that you use the Azure Identity library for your preferred programming language. The library acquires access tokens for you, making it simple to connect to target resources. 

Read more about the Azure Identity libraries below:

* [Azure Identity library for .NET](/dotnet/api/overview/azure/identity-readme)
* [Azure Identity library for Java](/java/api/overview/azure/identity-readme?view=azure-java-stable&preserve-view=true)
* [Azure Identity library for JavaScript](/javascript/api/overview/azure/identity-readme?view=azure-node-latest&preserve-view=true)
* [Azure Identity library for Python](/python/api/overview/azure/identity-readme?view=azure-python&preserve-view=true)
* [Azure Identity module for Go](/azure/developer/go/azure-sdk-authentication)
* [Azure Identity library for C++](https://github.com/Azure/azure-sdk-for-cpp/blob/main/sdk/identity/azure-identity/README.md)

### Using the Azure Identity library in your development environment

The Azure Identity libraries support a `DefaultAzureCredential` type. `DefaultAzureCredential` automatically attempts to authenticate via multiple mechanisms, including environment variables or an interactive sign-in. The credential type can be used in your development environment using your own credentials. It can also be used in your production Azure environment using a managed identity. No code changes are required when you deploy your application.

If you're using user-assigned managed identities, you should also explicitly specify the user-assigned managed identity you wish to authenticate with by passing in the identity's client ID as a parameter. You can retrieve the client ID by browsing to the identity in the Azure portal.

### Accessing a Blob in Azure Storage

#### [.NET](#tab/dotnet)

```csharp
using Azure.Identity;
using Azure.Storage.Blobs;

// code omitted for brevity

// Specify the Client ID if using user-assigned managed identities
var clientID = Environment.GetEnvironmentVariable("Managed_Identity_Client_ID");
var credentialOptions = new DefaultAzureCredentialOptions
{
    ManagedIdentityClientId = clientID
};
var credential = new DefaultAzureCredential(credentialOptions);                        

var blobServiceClient1 = new BlobServiceClient(new Uri("<URI of Storage account>"), credential);
BlobContainerClient containerClient1 = blobServiceClient1.GetBlobContainerClient("<name of blob>");
BlobClient blobClient1 = containerClient1.GetBlobClient("<name of file>");

if (blobClient1.Exists())
{
    var downloadedBlob = blobClient1.Download();
    string blobContents = downloadedBlob.Value.Content.ToString();                
}
```

#### [Java](#tab/java)

```java
import com.azure.identity.DefaultAzureCredential;
import com.azure.identity.DefaultAzureCredentialBuilder;
import com.azure.storage.blob.BlobClient;
import com.azure.storage.blob.BlobContainerClient;
import com.azure.storage.blob.BlobServiceClient;
import com.azure.storage.blob.BlobServiceClientBuilder;

// read the Client ID from your environment variables
String clientID = System.getProperty("Client_ID");
DefaultAzureCredential credential = new DefaultAzureCredentialBuilder()
        .managedIdentityClientId(clientID)
        .build();

BlobServiceClient blobStorageClient = new BlobServiceClientBuilder()
        .endpoint("<URI of Storage account>")
        .credential(credential)
        .buildClient();

BlobContainerClient blobContainerClient = blobStorageClient.getBlobContainerClient("<name of blob container>");
BlobClient blobClient = blobContainerClient.getBlobClient("<name of blob/file>");
if (blobClient.exists()) {
    String blobContent = blobClient.downloadContent().toString();
}
```    

#### [Node.js](#tab/nodejs)

```nodejs
import { DefaultAzureCredential } from "@azure/identity";
import { BlobServiceClient } from "@azure/storage-blob";

// Specify the Client ID if using user-assigned managed identities
const clientID = process.env.Managed_Identity_Client_ID;
const credential = new DefaultAzureCredential({
  managedIdentityClientId: clientID
});

const blobServiceClient = new BlobServiceClient("<URI of Storage account>", credential);
const containerClient = blobServiceClient.getContainerClient("<name of blob>");
const blobClient = containerClient.getBlobClient("<name of file>");

async function downloadBlob() {
  if (await blobClient.exists()) {
    const downloadBlockBlobResponse = await blobClient.download();
    const downloadedBlob = await streamToString(downloadBlockBlobResponse.readableStreamBody);
    console.log("Downloaded blob content:", downloadedBlob);
  }
}

async function streamToString(readableStream) {
  return new Promise((resolve, reject) => {
    const chunks = [];
    readableStream.on("data", (data) => {
      chunks.push(data.toString());
    });
    readableStream.on("end", () => {
      resolve(chunks.join(""));
    });
    readableStream.on("error", reject);
  });
}

downloadBlob().catch(console.error);
```

#### [Python](#tab/python)

```python
from azure.identity import DefaultAzureCredential
from azure.storage.blob import BlobServiceClient
import os

# Specify the Client ID if using user-assigned managed identities
client_id = os.getenv("Managed_Identity_Client_ID")
credential = DefaultAzureCredential(managed_identity_client_id=client_id)

blob_service_client = BlobServiceClient(account_url="<URI of Storage account>", credential=credential)
container_client = blob_service_client.get_container_client("<name of blob>")
blob_client = container_client.get_blob_client("<name of file>")

def download_blob():
    if blob_client.exists():
        download_stream = blob_client.download_blob()
        blob_contents = download_stream.readall().decode('utf-8')
        print("Downloaded blob content:", blob_contents)

download_blob()
```

#### [Go](#tab/Go)

```go
package main

import (
    "context"
    "fmt"
    "io"
    "os"
    "strings"

    "github.com/Azure/azure-sdk-for-go/sdk/azidentity"
    "github.com/Azure/azure-sdk-for-go/sdk/storage/azblob"
)

func main() {
    // Specify the Client ID if using user-assigned managed identities
    clientID := os.Getenv("Managed_Identity_Client_ID")
    if clientID == "" {
        fmt.Println("Managed_Identity_Client_ID environment variable is not set")
        return
    }

    cred, err := azidentity.NewDefaultAzureCredential(nil)
    if err != nil {
        fmt.Printf("failed to obtain a credential: %v\n", err)
        return
    }

    accountURL := "<URI of Storage account>"
    containerName := "<name of blob>"
    blobName := "<name of file>"

    serviceClient, err := azblob.NewServiceClient(accountURL, cred, nil)
    if err != nil {
        fmt.Printf("failed to create service client: %v\n", err)
        return
    }

    containerClient := serviceClient.NewContainerClient(containerName)
    blobClient := containerClient.NewBlobClient(blobName)

    // Check if the blob exists
    _, err = blobClient.GetProperties(context.Background(), nil)
    if err != nil {
        fmt.Printf("failed to get blob properties: %v\n", err)
        return
    }

    // Download the blob
    downloadResponse, err := blobClient.Download(context.Background(), nil)
    if err != nil {
        fmt.Printf("failed to download blob: %v\n", err)
        return
    }

    // Read the blob content
    blobData := downloadResponse.Body(nil)
    defer blobData.Close()

    blobContents := new(strings.Builder)
    _, err = io.Copy(blobContents, blobData)
    if err != nil {
        fmt.Printf("failed to read blob data: %v\n", err)
        return
    }

    fmt.Println("Downloaded blob content:", blobContents.String())
}
```

---

### Accessing a secret stored in Azure Key Vault

#### [.NET](#tab/dotnet)

```csharp
using Azure.Identity;
using Azure.Security.KeyVault.Secrets;
using Azure.Core;

// code omitted for brevity

// Specify the Client ID if using user-assigned managed identities
var clientID = Environment.GetEnvironmentVariable("Managed_Identity_Client_ID");
var credentialOptions = new DefaultAzureCredentialOptions
{
    ManagedIdentityClientId = clientID
};
var credential = new DefaultAzureCredential(credentialOptions);        

var client = new SecretClient(
    new Uri("https://<your-unique-key-vault-name>.vault.azure.net/"),
    credential);
    
KeyVaultSecret secret = client.GetSecret("<my secret>");
string secretValue = secret.Value;
```

#### [Java](#tab/java)

```java
import com.azure.core.util.polling.SyncPoller;
import com.azure.identity.DefaultAzureCredentialBuilder;

import com.azure.security.keyvault.secrets.SecretClient;
import com.azure.security.keyvault.secrets.SecretClientBuilder;
import com.azure.security.keyvault.secrets.models.DeletedSecret;
import com.azure.security.keyvault.secrets.models.KeyVaultSecret;

String keyVaultName = "mykeyvault";
String keyVaultUri = "https://" + keyVaultName + ".vault.azure.net";
String secretName = "mysecret";

// read the user-assigned managed identity Client ID from your environment variables
String clientID = System.getProperty("Managed_Identity_Client_ID");
DefaultAzureCredential credential = new DefaultAzureCredentialBuilder()
        .managedIdentityClientId(clientID)
        .build();

SecretClient secretClient = new SecretClientBuilder()
    .vaultUrl(keyVaultUri)
    .credential(credential)
    .buildClient();
    
KeyVaultSecret retrievedSecret = secretClient.getSecret(secretName);
```

#### [Node.js](#tab/nodejs)

```javascript
import { DefaultAzureCredential } from "@azure/identity";
import { SecretClient } from "@azure/keyvault-secrets";

// Specify the Client ID if using user-assigned managed identities
const clientID = process.env.Managed_Identity_Client_ID;
const credential = new DefaultAzureCredential({
    managedIdentityClientId: clientID
});

const client = new SecretClient("https://<your-key-vault-name>.vault.azure.net/", credential);

async function getSecret() {
    const secret = await client.getSecret("<your-secret-name>");
    const secretValue = secret.value;
    console.log(secretValue);
}

getSecret().catch(err => console.error("Error retrieving secret:", err));
```

#### [Python](#tab/python)


```Python
from azure.identity import DefaultAzureCredential
from azure.keyvault.secrets import SecretClient
import os

# Specify the Client ID if using user-assigned managed identities
client_id = os.getenv("Managed_Identity_Client_ID")
credential = DefaultAzureCredential(managed_identity_client_id=client_id)

client = SecretClient(vault_url="https://<your-key-vault-name>.vault.azure.net/", credential=credential)

def get_secret():
    secret = client.get_secret("<your-secret-name>")
    secret_value = secret.value
    print(secret_value)

if __name__ == "__main__":
    try:
        get_secret()
    except Exception as e:
        print(f"Error retrieving secret: {e}")
```

#### [Go](#tab/Go)

```go
package main

import (
    "context"
    "fmt"
    "os"

    "github.com/Azure/azure-sdk-for-go/sdk/azidentity"
    "github.com/Azure/azure-sdk-for-go/sdk/keyvault/azsecrets"
)

func main() {
    // Specify the Client ID if using user-assigned managed identities
    clientID := os.Getenv("Managed_Identity_Client_ID")
    if clientID == "" {
        fmt.Println("Managed_Identity_Client_ID environment variable is not set")
        return
    }

    credential, err := azidentity.NewDefaultAzureCredential(&azidentity.DefaultAzureCredentialOptions{
        ManagedIdentityClientID: clientID,
    })
    if err != nil {
        fmt.Printf("Failed to obtain a credential: %v\n", err)
        return
    }

    client, err := azsecrets.NewClient("https://<your-key-vault-name>.vault.azure.net/", credential, nil)
    if err != nil {
        fmt.Printf("Failed to create secret client: %v\n", err)
        return
    }

    secretResp, err := client.GetSecret(context.TODO(), "<your-secret-name>", nil)
    if err != nil {
        fmt.Printf("Failed to get secret: %v\n", err)
        return
    }

    secretValue := *secretResp.Value
    fmt.Println(secretValue)
}
```

---

### Accessing Azure SQL Database

#### [.NET](#tab/dotnet)

```csharp
using Azure.Identity;
using Microsoft.Data.SqlClient;

// code omitted for brevity

// Specify the Client ID if using user-assigned managed identities
var clientID = Environment.GetEnvironmentVariable("Managed_Identity_Client_ID");
var credentialOptions = new DefaultAzureCredentialOptions
{
    ManagedIdentityClientId = clientID
};

AccessToken accessToken = await new DefaultAzureCredential(credentialOptions).GetTokenAsync(
    new TokenRequestContext(new string[] { "https://database.windows.net//.default" }));                        

using var connection = new SqlConnection("Server=<DB Server>; Database=<DB Name>;")
{
    AccessToken = accessToken.Token
};
var cmd = new SqlCommand("select top 1 ColumnName from TableName", connection);
await connection.OpenAsync();
SqlDataReader dr = cmd.ExecuteReader();
while(dr.Read())
{
    Console.WriteLine(dr.GetValue(0).ToString());
}
dr.Close();	
```

#### [Java](#tab/java)

If you use [Azure Spring Apps](/azure/spring-apps/), you can connect to Azure SQL Databases using a managed identity without making any changes to your code.

Open the `src/main/resources/application.properties` file, and add `Authentication=ActiveDirectoryMSI;` at the end of the following line. Be sure to use the correct value for `$AZ_DATABASE_NAME` variable.

```properties
spring.datasource.url=jdbc:sqlserver://$AZ_DATABASE_NAME.database.windows.net:1433;database=demo;encrypt=true;trustServerCertificate=false;hostNameInCertificate=*.database.windows.net;loginTimeout=30;Authentication=ActiveDirectoryMSI;
```

Read more about how to [use a managed identity to connect Azure SQL Database to an Azure Spring Apps app](/azure/spring-apps/connect-managed-identity-to-azure-sql).

#### [Node.js](#tab/nodejs)

```javascript

import { DefaultAzureCredential } from "@azure/identity";
import { Connection, Request } from "tedious";

// Specify the Client ID if using a user-assigned managed identity
const clientID = process.env.Managed_Identity_Client_ID;
const credential = new DefaultAzureCredential({
    managedIdentityClientId: clientID
});

async function getAccessToken() {
    const tokenResponse = await credential.getToken("https://database.windows.net//.default");
    return tokenResponse.token;
}

async function queryDatabase() {
    const accessToken = await getAccessToken();

    const config = {
        server: "<your-server-name>",
        authentication: {
            type: "azure-active-directory-access-token",
            options: {
                token: accessToken
            }
        },
        options: {
            database: "<your-database-name>",
            encrypt: true
        }
    };

    const connection = new Connection(config);

    connection.on("connect", err => {
        if (err) {
            console.error("Connection failed:", err);
            return;
        }

        const request = new Request("SELECT TOP 1 ColumnName FROM TableName", (err, rowCount, rows) => {
            if (err) {
                console.error("Query failed:", err);
                return;
            }

            rows.forEach(row => {
                console.log(row.value);
            });

            connection.close();
        });

        connection.execSql(request);
    });

    connection.connect();
}

queryDatabase().catch(err => console.error("Error:", err));
```

#### [Python](#tab/python)

```python
import os
from azure.identity import DefaultAzureCredential
from azure.core.credentials import AccessToken
import pyodbc

# Specify the Client ID if using user-assigned managed identities
client_id = os.getenv("Managed_Identity_Client_ID")
credential = DefaultAzureCredential(managed_identity_client_id=client_id)

# Get the access token
token = credential.get_token("https://database.windows.net//.default")
access_token = token.token

# Set up the connection string
connection_string = "Driver={ODBC Driver 18 for SQL Server};Server=<your-server-name>;Database=<your-database-name>;"

# Connect to the database
connection = pyodbc.connect(connection_string, attrs_before={"AccessToken": access_token})

# Execute the query
cursor = connection.cursor()
cursor.execute("SELECT TOP 1 ColumnName FROM TableName")

# Fetch and print the result
row = cursor.fetchone()
while row:
    print(row)
    row = cursor.fetchone()

# Close the connection
cursor.close()
connection.close()
```

#### [Go](#tab/Go)

```go
package main

import (
    "context"
    "database/sql"
    "fmt"
    "os"

    "github.com/Azure/azure-sdk-for-go/sdk/azidentity"
    _ "github.com/denisenkom/go-mssqldb"
)

func main() {
    // Specify the Client ID if using user-assigned managed identities
    clientID := os.Getenv("Managed_Identity_Client_ID")
    if clientID == "" {
        fmt.Println("Managed_Identity_Client_ID environment variable is not set")
        return
    }

    credential, err := azidentity.NewDefaultAzureCredential(&azidentity.DefaultAzureCredentialOptions{
        ManagedIdentityClientID: clientID,
    })
    if err != nil {
        fmt.Printf("Failed to obtain a credential: %v\n", err)
        return
    }

    // Get the access token
    token, err := credential.GetToken(context.TODO(), azidentity.TokenRequestOptions{
        Scopes: []string{"https://database.windows.net//.default"},
    })
    if err != nil {
        fmt.Printf("Failed to get token: %v\n", err)
        return
    }

    // Set up the connection string
    connString := fmt.Sprintf("sqlserver://<your-server-name>?database=<your-database-name>&access_token=%s", token.Token)

    // Connect to the database
    db, err := sql.Open("sqlserver", connString)
    if err != nil {
        fmt.Printf("Failed to connect to the database: %v\n", err)
        return
    }
    defer db.Close()

    // Execute the query
    rows, err := db.QueryContext(context.TODO(), "SELECT TOP 1 ColumnName FROM TableName")
    if err != nil {
        fmt.Printf("Failed to execute query: %v\n", err)
        return
    }
    defer rows.Close()

    // Fetch and print the result
    for rows.Next() {
        var columnValue string
        if err := rows.Scan(&columnValue); err != nil {
            fmt.Printf("Failed to scan row: %v\n", err)
            return
        }
        fmt.Println(columnValue)
    }
}
```


---

<a name='connecting-to-resources-that-dont-support-azure-active-directory-or-token-based-authentication-in-libraries'></a>

## Connecting to resources that don't support Microsoft Entra ID or token based authentication in libraries

Some Azure resources either don't yet support Microsoft Entra authentication, or their client libraries don't support authenticating with a token. Typically these resources are open-source technologies that expect a username and password or an access key in a connection string.

To avoid storing credentials in your code or your application configuration, you can store the credentials as a secret in Azure Key Vault. Using the example displayed above, you can retrieve the secret from Azure KeyVault using a managed identity, and pass the credentials into your connection string. This approach means that no credentials need to be handled directly in your code or environment.

## Guidelines if you're handling tokens directly

In some scenarios, you may want to acquire tokens for managed identities manually instead of using a built-in method to connect to the target resource. These scenarios include no client library for the programming language that you're using or the target resource you're connecting to, or connecting to resources that aren't running on Azure. When acquiring tokens manually, we provide the following guidelines:

### Cache the tokens you acquire
For performance and reliability, we recommend that your application caches tokens in local memory, or encrypted if you want to save them to disk. As Managed identity tokens are valid for 24 hours, there's no benefit in requesting new tokens regularly, as a cached one will be returned from the token issuing endpoint. If you exceed the request limits, you'll be rate limited and receive an HTTP 429 error. 

When you acquire a token, you can set your token cache to expire 5 minutes before the `expires_on` (or equivalent property) that will be returned when the token is generated.

### Token inspection
Your application shouldn't rely on the contents of a token. The token's content is intended only for the audience (target resource) that is being accessed, not the client that's requesting the token. The token content may change or be encrypted in the future.

### Don't expose or move tokens
Tokens should be treated like credentials. Don't expose them to users or other services; for example, logging/monitoring solutions. They shouldn't be moved from the source resource that's using them, other than to authenticate against the target resource.

## Next steps

* [How to use managed identities for App Service and Azure Functions](/azure/app-service/overview-managed-identity)
* [How to use managed identities with Azure Container Instances](/azure/container-instances/container-instances-managed-identity)
* [Implementing managed identities for Microsoft Azure Resources](https://www.pluralsight.com/courses/microsoft-azure-resources-managed-identities-implementing)
* Use [workload identity federation for managed identities](~/workload-id/workload-identity-federation.md) to access Microsoft Entra protected resources without managing secrets
