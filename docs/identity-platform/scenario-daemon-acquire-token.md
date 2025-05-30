---
title: Acquire tokens to call a web API using a daemon application
description: Learn how to build a daemon app that calls web APIs (acquiring tokens)
author: Dickson-Mwendia
manager: CelesteDG
ms.author: dmwendia
ms.date: 03/25/2025
ms.reviewer: jmprieur
ms.service: identity-platform

ms.topic: how-to
#Customer intent: As an application developer, I want to know how to write a daemon app that can call web APIs by using the Microsoft identity platform.
---

# Acquire tokens to call a web API using a daemon application

[!INCLUDE [applies-to-workforce-only](../external-id/includes/applies-to-workforce-only.md)]

After you've constructed a confidential client application, you can acquire a token for the app by calling `AcquireTokenForClient`, passing the scope, and optionally forcing a refresh of the token.

## Scopes to request

The scope to request for a client credential flow is the name of the resource followed by `/.default`. This notation tells Microsoft Entra ID to use the *application-level permissions* declared statically during application registration. Also, these API permissions must be granted by a tenant administrator.

# [.NET](#tab/idweb)

Here's an example of defining the scopes for the web API as part of the configuration in an [*appsettings.json*](https://github.com/Azure-Samples/active-directory-dotnetcore-daemon-v2/blob/master/2-Call-OwnApi/daemon-console/appsettings.json) file. This example is taken from the [.NET console daemon](https://github.com/Azure-Samples/active-directory-dotnetcore-daemon-v2) code sample on GitHub.

```json
{
    "AzureAd": {
        // Same AzureAd section as before.
    },

    "MyWebApi": {
        "BaseUrl": "https://localhost:44372/",
        "RelativePath": "api/TodoList",
        "RequestAppToken": true,
        "Scopes": [ "[Enter here the scopes for your web API]" ]
    }
}
```

# [Java](#tab/java)

```Java
final static String GRAPH_DEFAULT_SCOPE = "https://graph.microsoft.com/.default";
```

# [Node.js](#tab/nodejs)

```JavaScript
const tokenRequest = {
    scopes: [process.env.GRAPH_ENDPOINT + '.default'], // e.g. 'https://graph.microsoft.com/.default'
};
```

# [Python](#tab/python)

In MSAL Python, the configuration file looks like this code snippet:

```Json
{
    "scope": ["https://graph.microsoft.com/.default"],
}
```

# [.NET (low level)](#tab/dotnet)

```csharp
ResourceId = "someAppIDURI";
var scopes = new [] {  ResourceId+"/.default"};
```

---

<a name='azure-ad-v10-resources'></a>

### Azure AD (v1.0) resources

The scope used for client credentials should always be the resource ID followed by `/.default`.

> [!IMPORTANT]
> When MSAL requests an access token for a resource that accepts a version 1.0 access token, Microsoft Entra ID parses the desired audience from the requested scope by taking everything before the last slash and using it as the resource identifier.
> So if, like Azure SQL Database (`https://database.windows.net`), the resource expects an audience that ends with a slash (for Azure SQL Database, `https://database.windows.net/`), you need to request a scope of `https://database.windows.net//.default`. (Note the double slash.) See also MSAL.NET issue [#747: `Resource url's trailing slash is omitted, which caused sql auth failure`](https://github.com/AzureAD/microsoft-authentication-library-for-dotnet/issues/747).

## AcquireTokenForClient API

To acquire a token for the app, use `AcquireTokenForClient` or its equivalent, depending on the platform.

# [.NET](#tab/idweb)

With Microsoft.Identity.Web, you don't need to acquire a token. You can use higher level APIs, as you see in [Calling a web API from a daemon application](scenario-daemon-call-api.md). If however you're using an SDK that requires a token, the following code snippet shows how to get this token.

```csharp
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Identity.Abstractions;
using Microsoft.Identity.Web;

// In the Program.cs, acquire a token for your downstream API

var tokenAcquirerFactory = TokenAcquirerFactory.GetDefaultInstance();
ITokenAcquirer acquirer = tokenAcquirerFactory.GetTokenAcquirer();
AcquireTokenResult tokenResult = await acquirer.GetTokenForUserAsync(new[] { "https://graph.microsoft.com/.default" });
string accessToken = tokenResult.AccessToken;
```

# [Java](#tab/java)

This code is extracted from the [MSAL Java dev samples](https://github.com/AzureAD/microsoft-authentication-library-for-java/tree/dev/msal4j-sdk/src/samples/confidential-client/).

```Java
private static IAuthenticationResult acquireToken() throws Exception {

     // Load token cache from file and initialize token cache aspect. The token cache will have
     // dummy data, so the acquireTokenSilently call will fail.
     TokenCacheAspect tokenCacheAspect = new TokenCacheAspect("sample_cache.json");

     IClientCredential credential = ClientCredentialFactory.createFromSecret(CLIENT_SECRET);
     ConfidentialClientApplication cca =
             ConfidentialClientApplication
                     .builder(CLIENT_ID, credential)
                     .authority(AUTHORITY)
                     .setTokenCacheAccessAspect(tokenCacheAspect)
                     .build();

     IAuthenticationResult result;
     try {
         SilentParameters silentParameters =
                 SilentParameters
                         .builder(SCOPE)
                         .build();

         // try to acquire token silently. This call will fail since the token cache does not
         // have a token for the application you are requesting an access token for
         result = cca.acquireTokenSilently(silentParameters).join();
     } catch (Exception ex) {
         if (ex.getCause() instanceof MsalException) {

             ClientCredentialParameters parameters =
                     ClientCredentialParameters
                             .builder(SCOPE)
                             .build();

             // Try to acquire a token. If successful, you should see
             // the token information printed out to console
             result = cca.acquireToken(parameters).join();
         } else {
             // Handle other exceptions accordingly
             throw ex;
         }
     }
     return result;
 }
```

# [Node.js](#tab/nodejs)

The following code snippet illustrates token acquisition in an MSAL Node confidential client application:

```JavaScript
try {
    const authResponse = await cca.acquireTokenByClientCredential(tokenRequest);
    console.log(authResponse.accessToken) // display access token
} catch (error) {
    console.log(error);
}
```

# [Python](#tab/python)

```Python
# The pattern to acquire a token looks like this.
result = None

# First, the code looks up a token from the cache.
# Because we're looking for a token for the current app, not for a user,
# use None for the account parameter.
result = app.acquire_token_silent(config["scope"], account=None)

if not result:
    logging.info("No suitable token exists in cache. Let's get a new one from Azure AD.")
    result = app.acquire_token_for_client(scopes=config["scope"])

if "access_token" in result:
    # Call a protected API with the access token.
    print(result["token_type"])
else:
    print(result.get("error"))
    print(result.get("error_description"))
    print(result.get("correlation_id"))  # You might need this when reporting a bug.
```

# [.NET (low level)](#tab/dotnet)

```csharp
using Microsoft.Identity.Client;

// With client credentials flows, the scope is always of the shape "resource/.default" because the
// application permissions need to be set statically (in the portal or by PowerShell), and then granted by
// a tenant administrator.
string[] scopes = new string[] { "https://graph.microsoft.com/.default" };

AuthenticationResult result = null;
try
{
 result = await app.AcquireTokenForClient(scopes)
                  .ExecuteAsync();
}
catch (MsalUiRequiredException ex)
{
    // The application doesn't have sufficient permissions.
    // - Did you declare enough app permissions during app creation?
    // - Did the tenant admin grant permissions to the application?
}
catch (MsalServiceException ex) when (ex.Message.Contains("AADSTS70011"))
{
    // Invalid scope. The scope has to be in the form "https://resourceurl/.default"
    // Mitigation: Change the scope to be as expected.
}
```

### AcquireTokenForClient uses the application token cache

In MSAL.NET, `AcquireTokenForClient` uses the application token cache. (All the other AcquireToken*XX* methods use the user token cache.) Don't call `AcquireTokenSilent` before you call `AcquireTokenForClient`, because `AcquireTokenSilent` uses the *user* token cache. `AcquireTokenForClient` checks the *application* token cache itself and updates it.

---

### Protocol

If you don't yet have a library for your chosen language, you might want to use the protocol directly:

#### First case: Access the token request by using a shared secret

```HTTP
POST /{tenant}/oauth2/v2.0/token HTTP/1.1           //Line breaks for clarity.
Host: login.microsoftonline.com
Content-Type: application/x-www-form-urlencoded

client_id=00001111-aaaa-2222-bbbb-3333cccc4444
&scope=https%3A%2F%2Fgraph.microsoft.com%2F.default
&client_secret=A1b-C2d_E3f.H4i,J5k?L6m!N7o-P8q_R9s.T0u
&grant_type=client_credentials
```

#### Second case: Access the token request by using a certificate

```HTTP
POST /{tenant}/oauth2/v2.0/token HTTP/1.1               // Line breaks for clarity.
Host: login.microsoftonline.com
Content-Type: application/x-www-form-urlencoded

scope=https%3A%2F%2Fgraph.microsoft.com%2F.default
&client_id=11112222-bbbb-3333-cccc-4444dddd5555
&client_assertion_type=urn%3Aietf%3Aparams%3Aoauth%3Aclient-assertion-type%3Ajwt-bearer
&client_assertion=aaaaaaaa-0b0b-...
&grant_type=client_credentials
```

For more information, see the protocol documentation: [Microsoft identity platform and the OAuth 2.0 client credentials flow](v2-oauth2-client-creds-grant-flow.md).

## Troubleshooting

### Did you use the resource/.default scope?

If you get an error message telling you that you used an invalid scope, you probably didn't use the `resource/.default` scope.

### Did you forget to provide admin consent? Daemon apps need it!

If you get an **Insufficient privileges to complete the operation** error when you call the API, the tenant administrator needs to grant permissions to the application.

If you don't grant admin consent to your application, you run into the following error:

```json
Failed to call the web API: Forbidden
Content: {
  "error": {
    "code": "Authorization_RequestDenied",
    "message": "Insufficient privileges to complete the operation.",
    "innerError": {
      "request-id": "<guid>",
      "date": "<date>"
    }
  }
}
```

Select one of the following options, depending on the role.

##### Cloud Application Administrator

For a Cloud Application Administrator, go to **Enterprise applications** in the Microsoft Entra admin center. Select the app registration, and select **Permissions** from the **Security** section of the left pane. Then select the large button labeled **Grant admin consent for {Tenant Name}** (where **{Tenant Name}** is the name of the directory).

##### Standard user

For a standard user of your tenant, ask a Cloud Application Administrator to grant admin consent to the application. To do this, provide the following URL to the administrator:

```url
https://login.microsoftonline.com/Enter_the_Tenant_Id_Here/adminconsent?client_id=Enter_the_Application_Id_Here
```

In the URL:

- Replace `Enter_the_Tenant_Id_Here` with the tenant ID or tenant name (for example, `contoso.microsoft.com`).
- `Enter_the_Application_Id_Here` is the application (client) ID for the registered application.

The error `AADSTS50011: No reply address is registered for the application` may be displayed after you grant consent to the app by using the preceding URL. This error occurs because the application and the URL don't have a redirect URI. This can be ignored.

### Are you calling your own API?

If your daemon app calls your own web API and you weren't able to add an app permission to the daemon's app registration, you need to [Add app roles to the web API's app registration](./howto-add-app-roles-in-apps.md).

## Next steps

# [.NET](#tab/idweb)

Move on to the next article in this scenario,
[Calling a web API](./scenario-daemon-call-api.md?tabs=idweb).

# [Java](#tab/java)

Move on to the next article in this scenario,
[Calling a web API](./scenario-daemon-call-api.md?tabs=java).

# [Node.js](#tab/nodejs)

Move on to the next article in this scenario,
[Calling a web API](./scenario-daemon-call-api.md?tabs=nodejs).

# [Python](#tab/python)

Move on to the next article in this scenario,
[Calling a web API](./scenario-daemon-call-api.md?tabs=python).

# [.NET low level](#tab/dotnet)

Move on to the next article in this scenario,
[Calling a web API](./scenario-daemon-call-api.md?tabs=dotnet).
---
