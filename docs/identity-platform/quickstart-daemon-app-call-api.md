---
title: Quickstart - Call a web API in a sample daemon app
description: A daemon app code sample quickstart that shows how to acquire an access token to call a protected web API by using Microsoft identity platform
author: kengaderdus
manager: dougeby
ms.service: identity-platform
ms.topic: quickstart
ms.date: 11/20/2024
ms.author: kengaderdus
zone_pivot_groups: entra-tenants

#Customer intent: As a developer, I want to configure a sample daemon to acquire an access token so thar it can call a web API by using Microsoft identity platform.
---

# Quickstart: Call a web API in a sample daemon app

[!INCLUDE [applies-to-workforce-external](../external-id/includes/applies-to-workforce-external.md)]

In this quickstart, you use a sample daemon application to acquire an access token and call a protected web API by using the [Microsoft Authentication Library (MSAL)](msal-overview.md).

[!INCLUDE [select-tenant-type-statement](./includes/select-tenant-type-statement.md)]

::: zone pivot="workforce" 

The sample app you use in this quickstart acquires an access token to call Microsoft Graph API.

## Prerequisites

* An Azure account with an active subscription. If you don't already have one, [Create an account for free](https://azure.microsoft.com/free/?WT.mc_id=A261C142F).
* This Azure account must have permissions to manage applications. Any of the following Microsoft Entra roles include the required permissions:
  * Application Administrator
  * Application Developer
  * Cloud Application Administrator
* A workforce tenant. You can use your Default Directory or [set up a new tenant](./quickstart-create-new-tenant.md).
* Register a new app in the [Microsoft Entra admin center](https://entra.microsoft.com), configured for *Accounts in this organizational directory only*. Refer to [Register an application](quickstart-register-app.md) for more details. Record the following values from the application **Overview** page for later use:
  * Application (client) ID 
  * Directory (tenant) ID
* Add a client secret to your app registration. **Do not** use client secrets in production apps. Use certificates or federated credentials instead. For more information, see [add credentials to your application](./how-to-add-credentials.md?tabs=client-secret).

#### [.NET](#tab/asp-dot-net-core-workforce)

* A minimum requirement of [.NET 6.0 SDK](https://dotnet.microsoft.com/download/dotnet).
* [Visual Studio 2022](https://visualstudio.microsoft.com/vs/) or [Visual Studio Code](https://code.visualstudio.com/).

#### [Node](#tab/node-workforce)

* [Node.js](https://nodejs.org/en/download/package-manager).
* [Visual Studio Code](https://code.visualstudio.com/download) or another code editor.

#### [Python](#tab/python-workforce)

* [Python 3+](https://www.python.org/downloads/release/python-364/).
* [Visual Studio Code](https://code.visualstudio.com/download) or another code editor.

#### [Java](#tab/java-workforce)

* [Java Development Kit (JDK)](https://openjdk.java.net/) 8 or later.
* [Maven](https://maven.apache.org/).
* A suitable code editor.

--- 

## Grant API permissions to the daemon app

For daemon app to access data in Microsoft Graph API, you grant it the permissions it needs. The daemon app needs application type permissions. Users can't interact with a daemon application, so the tenant administrator must consent to these permissions. Use the following steps to grant and consent to the permissions:

#### [.NET](#tab/asp-dot-net-core-workforce)

For the .NET daemon app, you don't need to grant and consent to any permission. This daemon app reads its own app registration information, so it can do so without being granted any application permissions.

#### [Node](#tab/node-workforce)

[!INCLUDE [grant-permissions-to-daemon-app](./includes/register-app/grant-permissions-to-daemon-app.md)]

#### [Python](#tab/python-workforce)

[!INCLUDE [grant-permissions-to-daemon-app](./includes/register-app/grant-permissions-to-daemon-app.md)]

#### [Java](#tab/java-workforce)

[!INCLUDE [grant-permissions-to-daemon-app](./includes/register-app/grant-permissions-to-daemon-app.md)]

---

## Clone or download the sample application

To obtain the sample application, you can either clone it from GitHub or download it as a *.zip* file.

* To clone the sample, open a command prompt and navigate to where you wish to create the project, and enter the following command:

#### [.NET](#tab/asp-dot-net-core-workforce)

```console
git clone https://github.com/Azure-Samples/ms-identity-docs-code-dotnet.git
```

* [Download the .zip file](https://github.com/Azure-Samples/ms-identity-docs-code-dotnet/archive/refs/heads/main.zip). Extract it to a file path where the length of the name is fewer than 260 characters.

#### [Node](#tab/node-workforce)

```console
git clone https://github.com/azure-samples/ms-identity-javascript-nodejs-console.git 
```

* [Download the .zip file](https://github.com/azure-samples/ms-identity-javascript-nodejs-console/archive/main.zip). Extract it to a file path where the length of the name is fewer than 260 characters.


#### [Python](#tab/python-workforce)

```console
git clone https://github.com/Azure-Samples/ms-identity-python-daemon.git 
```

* [Download the .zip file](https://github.com/Azure-Samples/ms-identity-python-daemon/archive/master.zip). Extract it to a file path where the length of the name is fewer than 260 characters.


#### [Java](#tab/java-workforce)

```console
git clone https://github.com/Azure-Samples/ms-identity-java-daemon.git
```

* [Download the .zip file](https://github.com/Azure-Samples/ms-identity-java-daemon/archive/master.zip). Extract it to a file path where the length of the name is fewer than 260 characters.

---

## Configure the project

To use your app registration details in the client daemon app sample, use the following steps:

#### [.NET](#tab/asp-dot-net-core-workforce)

1. Open a console window then navigate to the *ms-identity-docs-code-dotnet/console-daemon* directory:

    ```console
    cd ms-identity-docs-code-dotnet/console-daemon
    ```

1. Open *Program.cs* and replace the file contents with the following snippet;

   ```csharp
    // Full directory URL, in the form of https://login.microsoftonline.com/<tenant_id>
    Authority = " https://login.microsoftonline.com/Enter_the_tenant_ID_obtained_from_the_Microsoft_Entra_admin_center",
    // 'Enter the client ID obtained from the Microsoft Entra admin center
    ClientId = "Enter the client ID obtained from the Microsoft Entra admin center",
    // Client secret 'Value' (not its ID) from 'Client secrets' in the Microsoft Entra admin center
    ClientSecret = "Enter the client secret value obtained from the Microsoft Entra admin center",
    // Client 'Object ID' of app registration in Microsoft Entra admin center - this value is a GUID
    ClientObjectId = "Enter the client Object ID obtained from the Microsoft Entra admin center"
   ```

    * `Authority` - The authority is a URL that indicates a directory that MSAL can request tokens from. Replace *Enter_the_tenant_ID_obtained_from_the_Microsoft_Entra_admin_center* with the **Directory (tenant) ID** value that was recorded earlier.
    * `ClientId` - The identifier of the application, also referred to as the client. Replace the text in quotes with the `Application (client) ID` value that was recorded earlier from the overview page of the registered application.
    * `ClientSecret` - The client secret created for the application in the Microsoft Entra admin center. Enter the **value** of the client secret.
    * `ClientObjectId` - The object ID of the client application. Replace the text in quotes with the `Object ID` value that you recorded earlier from the overview page of the registered application.

#### [Node](#tab/node-workforce)

In your editor, open the *.env* file, then replace the placeholders:

- `Enter_the_Application_Id_Here` with the application (client) ID of the application you registered earlier.
- `Enter_the_Tenant_Id_Here` with the Tenant ID of your workforce tenant.
- `Enter_the_Client_Secret_Here` with the client secret you created earlier.
- `Enter_the_Cloud_Instance_Id_Here` with `https://login.microsoftonline.com`.
- `Enter_the_Graph_Endpoint_Here` with `https://graph.microsoft.com/`.

#### [Python](#tab/python-workforce)

1. Navigate to the *1-Call-MsGraph-WithSecret* directory.

1. In your editor, open the **parameters.json** file and replace the placeholders:

   - `Enter_the_Application_Id_Here` with the application (client) ID of the application you registered earlier.
   - `Enter_the_Tenant_Id_Here` with the Tenant ID of your workforce tenant.
   - `Enter_the_Client_Secret_Here` with the client secret you created earlier.

#### [Java](#tab/java-workforce)

1. Navigate to the `msal-client-credential-secret` directory.

1. In your editor, open the `src\main\resources\application.properties` file and replace the placeholders:

   - `Enter_the_Application_Id_Here` with the application (client) ID of the application you registered earlier.
   - `Enter_the_Tenant_Id_Here` with the Tenant ID of your workforce tenant.
   - `Enter_the_Client_Secret_Here` with the client secret you created earlier.

---


## Run and test the application

You've configured your sample app. You can proceed to run and test it.

#### [.NET](#tab/asp-dot-net-core-workforce)

From your console window, run the following command to build and run the application:

```console
dotnet run
```

Once the application runs successfully, it displays a response similar to the following snippet (shortened for brevity):

```console
{
"@odata.context": "https://graph.microsoft.com/v1.0/$metadata#applications/$entity",
"id": "00001111-aaaa-2222-bbbb-3333cccc4444",
"deletedDateTime": null,
"appId": "00001111-aaaa-2222-bbbb-3333cccc4444",
"applicationTemplateId": null,
"disabledByMicrosoftStatus": null,
"createdDateTime": "2021-01-17T15:30:55Z",
"displayName": "identity-dotnet-console-app",
"description": null,
"groupMembershipClaims": null,
...
}
```

### How it works

A daemon application acquires a token on behalf of itself (not on behalf of a user). Users can't interact with a daemon application because it requires its own identity. This type of application requests an access token by using its application identity by presenting its application ID, credential (secret or certificate), and an application ID URI. The daemon application uses the standard [OAuth 2.0 client credentials grant flow](v2-oauth2-client-creds-grant-flow.md) to acquire an access token.

The app acquires an access token from Microsoft identity platform. The access token is scoped for the Microsoft Graph API. The app then uses the access token to request its own application registration details from Microsoft Graph API. The app can request any resource from Microsoft Graph API as long as the access token has the right permissions.

The sample demonstrates how an unattended job or Windows service can run with an application identity, instead of a user's identity.

#### [Node](#tab/node-workforce)

1. To install dependencies, run the following command:

    ```console
    npm install
    ```

1. Use the following command to run the application:

    ```console
    node . --op getUsers
    ```

[!INCLUDE [sample-daemon-app-output](./includes/sample-daemon-app-output.md)]

### How it works

[!INCLUDE [how-it-works-daemon-app](./includes/how-it-works-daemon-app.md)]

#### [Python](#tab/python-workforce)


1. To install dependencies, run the following command:

    ```console
    pip install -r requirements.txt
    ```

1. To run the application, use the following command:

    ```console
    python confidential_client_secret_sample.py parameters.json
    ```

[!INCLUDE [sample-daemon-app-output](./includes/sample-daemon-app-output.md)]

### How it works

[!INCLUDE [how-it-works-daemon-app](./includes/how-it-works-daemon-app.md)]

#### [Java](#tab/java-workforce)

You can test the sample app by running the main method of *ClientCredentialGrant.java* from your IDE or

1. From your console, run the following command:

    ```
    $ mvn clean compile assembly:single
    ```

    This command generates a *msal-client-credential-secret-1.0.0.jar* file in your */targets* directory. 
 
1. Navigate to the */targets* directory, then run your Java executable file using the following command:

    ```
    $ java -jar msal-client-credential-secret-1.0.0.jar
    ```

[!INCLUDE [sample-daemon-app-output](./includes/sample-daemon-app-output.md)]

### How it works

[!INCLUDE [how-it-works-daemon-app](./includes/how-it-works-daemon-app.md)]
---

## Related content

#### [.NET](#tab/asp-dot-net-core-workforce)

* Learn by building this ASP.NET web app with the series [Tutorial: Register an application with the Microsoft identity platform](./tutorial-web-app-dotnet-sign-in-users.md).

* [Quickstart: Deploy an ASP.NET web app to Azure App Service](/azure/app-service/quickstart-dotnetcore?tabs=net70&pivots=development-environment-vs)

#### [Node](#tab/node-workforce)

* Learn how [build your Node.js daemon application that calls web API](tutorial-v2-nodejs-console.md).

#### [Python](#tab/python-workforce)

* Learn how to [build a Python daemon application that calls web APIs](scenario-daemon-app-configuration.md)

#### [Java](#tab/java-workforce)

* Learn how to [build a Java daemon application that calls web APIs](scenario-daemon-app-configuration.md)
---


::: zone-end 


::: zone pivot="external"

## Prerequisites

* An Azure account with an active subscription. If you don't already have one, [Create an account for free](https://azure.microsoft.com/free/?WT.mc_id=A261C142F).
* This Azure account must have permissions to manage applications. Any of the following Microsoft Entra roles include the required permissions:
  * Application Administrator
  * Application Developer
  * Cloud Application Administrator
* An external tenant. To create one, choose from the following methods:
  - (Recommended) Use the [Microsoft Entra External ID extension](https://aka.ms/ciamvscode/samples/marketplace) to set up an external tenant directly in Visual Studio Code.
  - [Create a new external tenant](../external-id/customers/how-to-create-external-tenant-portal.md) in the Microsoft Entra admin center.
* Register a new app in the [Microsoft Entra admin center](https://entra.microsoft.com) with the following configuration. For more information, see [Register an application](quickstart-register-app.md).
  * **Name**: *ciam-daemon-app*
  * **Supported account types**: *Accounts in this organizational directory only (Single tenant)*
* [Visual Studio Code](https://code.visualstudio.com/download) or another code editor.
* [.NET 7.0](https://dotnet.microsoft.com/learn/dotnet/hello-world-tutorial/install) or later. 
* [Node.js](https://nodejs.org) (for Node implementation only)

## Create a client secret

[!INCLUDE [add-app-client-secret](../external-id/customers/includes/register-app/add-app-client-secret.md)]

[!INCLUDE [client-credential-advice](./includes/register-app/client-credential-advice.md)]

## Grant API permissions to the daemon app

[!INCLUDE [grant-api-permissions-app-permissions](../external-id/customers/includes/register-app/grant-api-permissions-app-permissions.md)]

## Configure app roles

[!INCLUDE [add-app-role](../external-id/customers/includes/register-app/add-app-role.md)]

## Configure optional claims

[!INCLUDE [add-optional-claims-access](../external-id/customers/includes/register-app/add-optional-claims-access.md)]

## Clone or download sample daemon application and web API

To obtain the sample application, you can either clone it from GitHub or download it as a .zip file.

#### [Node](#tab/node-external)

- To clone the sample, open a command prompt and navigate to where you wish to create the project, and enter the following command:

    ```console
    git clone https://github.com/Azure-Samples/ms-identity-ciam-javascript-tutorial.git
    ```

- Alternatively, [download the samples .zip file](https://github.com/Azure-Samples/ms-identity-ciam-javascript-tutorial/archive/refs/heads/main.zip), then extract it to a file path where the length of the name is fewer than 260 characters.

### Install project dependencies

1. Open a console window, and change to the directory that contains the Node.js sample app:

    ```console
    cd 2-Authorization\3-call-api-node-daemon\App
    ```
1. Run the following commands to install app dependencies:

    ```console
    npm install && npm update
    ```


#### [.NET](#tab/asp-dot-net-core-external)

- To clone the sample, open a command prompt and navigate to where you wish to create the project, and enter the following command:

    ```console
    git clone https://github.com/Azure-Samples/ms-identity-ciam-dotnet-tutorial.git
    ```

- [Download the .zip file](https://github.com/Azure-Samples/ms-identity-ciam-dotnet-tutorial/archive/refs/heads/main.zip). Extract it to a file path where the length of the name is fewer than 260 characters.
---


## Configure the sample daemon app and API

To use your app registration details in the client web app sample, use the following steps:

#### [Node](#tab/node-external)

1. In your code editor, open `App\authConfig.js` file.

1. Find the placeholder:

    - `Enter_the_Application_Id_Here` and replace it with the Application (client) ID of the daemon app you registered earlier.
     
    - `Enter_the_Tenant_Subdomain_Here` and replace it with the Directory (tenant) subdomain. For example, if your tenant primary domain is `contoso.onmicrosoft.com`, use `contoso`. If you don't have your tenant name, learn how to [read your tenant details](../external-id/customers/how-to-create-external-tenant-portal.md#get-the-external-tenant-details). 
    
    - `Enter_the_Client_Secret_Here` and replace it with the daemon app secret value you copied earlier.
    
    - `Enter_the_Web_Api_Application_Id_Here` and replace it with the Application (client) ID of the web API you copied earlier.

To use your app registration in the web API sample: 

1. In your code editor, open `API\ToDoListAPI\appsettings.json` file.

1. Find the placeholder:
    
    - `Enter_the_Application_Id_Here` and replace it with the Application (client) ID of the web API you copied. 
    
    - `Enter_the_Tenant_Id_Here` and replace it with the Directory (tenant) ID you copied earlier.
    
    - `Enter_the_Tenant_Subdomain_Here` and replace it with the Directory (tenant) subdomain. For example, if your tenant primary domain is `contoso.onmicrosoft.com`, use `contoso`. If you don't have your tenant name, learn how to [read your tenant details](../external-id/customers/how-to-create-external-tenant-portal.md#get-the-external-tenant-details).

#### [.NET](#tab/asp-dot-net-core-external)

1. In your code editor, open *ms-identity-ciam-dotnet-tutorial/2-Authorization/3-call-own-api-dotnet-core-daemon/ToDoListClient/appsettings.json* file.

1. Find the placeholder:

    - `Enter_the_Application_Id_Here` and replace it with the Application (client) ID of the daemon application you registered earlier.
    - `Enter_the_Tenant_Subdomain_Here` and replace it with the Directory (tenant) subdomain. For example, if your tenant primary domain is `contoso.onmicrosoft.com`, use `contoso`. If you don't have your tenant name, learn how to [read your tenant details](../external-id/customers/how-to-create-external-tenant-portal.md#get-the-external-tenant-details). 
    - `Enter_the_Client_Secret_Here` and replace it with the daemon application secret value you copied earlier.
    - `Enter_the_Web_Api_Application_Id_Here` and replace it with the Application (client) ID of the web API you copied earlier.

To use your app registration in the web API sample: 

1. In your code editor, open *ms-identity-ciam-dotnet-tutorial/2-Authorization/3-call-own-api-dotnet-core-daemon/ToDoListAPI/appsettings.json* file.

1. Find the placeholder:
    
    - `Enter_the_Application_Id_Here` and replace it with the Application (client) ID of the web API you copied. 
    - `Enter_the_Tenant_Id_Here` and replace it with the Directory (tenant) ID you copied earlier.
    - `Enter_the_Tenant_Subdomain_Here` and replace it with the Directory (tenant) subdomain. For example, if your tenant primary domain is `contoso.onmicrosoft.com`, use `contoso`. If you don't have your tenant name, learn how to [read your tenant details](../external-id/customers/how-to-create-external-tenant-portal.md#get-the-external-tenant-details).
    
---

##  Run and test sample daemon app and API 

You've configured your sample app. You can proceed to run and test it.

#### [Node](#tab/node-external)

1. Open a console window, then run the web API by using the following commands:

    ```console
    cd 2-Authorization\3-call-api-node-daemon\API\ToDoListAPI
    dotnet run
    ``` 
1. Run the web app client by using the following commands:

    ```console
    2-Authorization\3-call-api-node-daemon\App
    node . --op getToDos
    ```

If your daemon app and web API successfully run, you should see something similar to the following JSON array in your console window

```json
{
    "id": 1,
    "owner": "3e8....-db63-43a2-a767-5d7db...",
    "description": "Pick up grocery"
},
{
    "id": 2,
    "owner": "c3cc....-c4ec-4531-a197-cb919ed.....",
    "description": "Finish invoice report"
},
{
    "id": 3,
    "owner": "a35e....-3b8a-4632-8c4f-ffb840d.....",
    "description": "Water plants"
}
```

### How it works

The Node.js app uses the [OAuth 2.0 client credentials grant flow](v2-oauth2-client-creds-grant-flow.md) to acquire an access token for itself and not for the user. The access token that the app requests contains the permissions represented as roles. The client credential flow uses this set of permissions in place of user scopes for application tokens. You [exposed these application permissions](#configure-app-roles) in the web API earlier, then [granted them to the daemon app](#grant-api-permissions-to-the-daemon-app).

On the API side, a sample .NET web API, the API must verify that the access token has the required permissions (application permissions). The web API can't accept an access token that doesn't have the required permissions. 

### Access to data

A Web API endpoint should be prepared to accept calls from both users and applications. Therefore, it should have a way to respond to each request accordingly. For example, a call from a user via delegated permissions/scopes receives the user's data to-do list. On the other hand, a call from an application via application permissions/roles may receive the entire to-do list. However, in this article, we're only making an application call, so we didn't need to configure delegated permissions/scopes.


#### [.NET](#tab/asp-dot-net-core-external)

1. Open a console window, then run the web API by using the following commands:

    ```console
    cd 2-Authorization\3-call-own-api-dotnet-core-daemon\ToDoListAPI
    dotnet run
    ``` 
1. Run the daemon client by using the following commands:

    ```console
    cd 2-Authorization\3-call-own-api-dotnet-core-daemon\ToDoListClient
    dotnet run
    ```

    If your daemon application and web API successfully run, you should see something similar to the following JSON array in your console window:
    
    ```bash
    Posting a to-do...
    Retrieving to-do's from server...
    To-do data:
    ID: 1
    User ID: 00aa00aa-bb11-cc22-dd33-44ee44ee44ee
    Message: Bake bread
    Posting a second to-do...
    Retrieving to-do's from server...
    To-do data:
    ID: 1
    User ID: 00aa00aa-bb11-cc22-dd33-44ee44ee44ee
    Message: Bake bread
    ID: 2
    User ID: 00aa00aa-bb11-cc22-dd33-44ee44ee44ee
    Message: Butter bread
    Deleting a to-do...
    Retrieving to-do's from server...
    To-do data:
    ID: 2
    User ID: 00aa00aa-bb11-cc22-dd33-44ee44ee44ee
    Message: Butter bread
    Editing a to-do...
    Retrieving to-do's from server...
    To-do data:
    ID: 2
    User ID: 00aa00aa-bb11-cc22-dd33-44ee44ee44ee
    Message: Eat bread
    Deleting remaining to-do...
    Retrieving to-do's from server...
    There are no to-do's in server
    ```

## How it works

The daemon application uses the [OAuth 2.0 client credentials grant flow](v2-oauth2-client-creds-grant-flow.md) to acquire an access token for itself and not for the user. The access token that the app requests contains the permissions represented as roles. The client credential flow uses this set of permissions in place of user scopes for application tokens. You [exposed these application permissions](#configure-app-roles) in the web API earlier, then [granted them to the daemon app](#grant-api-permissions-to-the-daemon-app). The daemon app in this article uses [Microsoft Authentication Library for .NET](/entra/msal/dotnet/) to simplify the process of acquiring a token.

On the API side, a sample .NET web API, the API must verify that the access token has the required permissions (application permissions). The web API rejects access tokens that don't have the required permissions. 

---

## Related content

#### [Node](#tab/node-external)

- [Acquire an access token, then call a web API in your own Node.js daemon app](/entra/external-id/customers/tutorial-daemon-node-call-api-prepare-tenant).
- [Use a client certificate instead of a secret for authentication in your Node.js confidential app](/entra/external-id/customers/how-to-web-app-node-use-certificate).

#### [.NET](#tab/asp-dot-net-core-external)

- [Use our multi-part tutorial series to build this .NET daemon app from scratch](/entra/external-id/customers/tutorial-daemon-dotnet-call-api-prepare-tenant)

---

::: zone-end 