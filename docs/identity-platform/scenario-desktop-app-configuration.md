---
title: Configure desktop apps that call web APIs
description: Learn how to configure the code of a desktop app that calls web APIs
author: OwenRichards1
manager: CelesteDG
ms.author: owenrichards
ms.custom: 
ms.date: 04/09/2024
ms.reviewer: jmprieur
ms.service: identity-platform

ms.topic: concept-article
#Customer intent: As an application developer, I want to know how to write a desktop app that calls web APIs by using the Microsoft identity platform.
---

# Desktop app that calls web APIs: Code configuration

Now that you've created your application, you'll learn how to configure the code with the application's coordinates.

## Microsoft libraries supporting desktop apps

The following Microsoft libraries support desktop apps:

[!INCLUDE [active-directory-develop-libraries-desktop](./includes/libraries/libraries-desktop.md)]

## Public client application

From a code point of view, desktop applications are public client applications. The configuration will be a bit different based on whether you use interactive authentication or not.

# [.NET](#tab/dotnet)

You'll need to build and manipulate MSAL.NET `IPublicClientApplication`.

![IPublicClientApplication](media/scenarios/public-client-application.png)

### Exclusively by code

The following code instantiates a public client application and signs in users in the Microsoft Azure public cloud with a work or school account or a personal Microsoft account.

```csharp
IPublicClientApplication app = PublicClientApplicationBuilder.Create(clientId)
    .Build();
```

If you intend to use interactive authentication or device code flow, as seen previously, use the `.WithRedirectUri` modifier.

```csharp
IPublicClientApplication app;
app = PublicClientApplicationBuilder.Create(clientId)
        .WithDefaultRedirectUri()
        .Build();
```

### Use configuration files

The following code instantiates a public client application from a configuration object, which could be filled in programmatically or read from a configuration file.

```csharp
PublicClientApplicationOptions options = GetOptions(); // your own method
IPublicClientApplication app = PublicClientApplicationBuilder.CreateWithApplicationOptions(options)
        .WithDefaultRedirectUri()
        .Build();
```

### More elaborated configuration

You can elaborate the application building by adding a number of modifiers. For instance, if you want your application to be a multitenant application in a national cloud, such as US Government shown here, you could write:

```csharp
IPublicClientApplication app;
app = PublicClientApplicationBuilder.Create(clientId)
        .WithDefaultRedirectUri()
        .WithAadAuthority(AzureCloudInstance.AzureUsGovernment,
                         AadAuthorityAudience.AzureAdMultipleOrgs)
        .Build();
```

MSAL.NET also contains a modifier for Active Directory Federation Services 2019:

```csharp
IPublicClientApplication app;
app = PublicClientApplicationBuilder.Create(clientId)
        .WithAdfsAuthority("https://consoso.com/adfs")
        .Build();
```

Finally, if you want to acquire tokens for an Azure Active Directory (Azure AD) B2C tenant, specify your tenant as shown in the following code snippet:

```csharp
IPublicClientApplication app;
app = PublicClientApplicationBuilder.Create(clientId)
        .WithB2CAuthority("https://fabrikamb2c.b2clogin.com/tfp/{tenant}/{PolicySignInSignUp}")
        .Build();
```

### Learn more

To learn more about how to configure an MSAL.NET desktop application:

- For a list of all modifiers available on `PublicClientApplicationBuilder`, see the reference documentation [PublicClientApplicationBuilder](/dotnet/api/microsoft.identity.client.publicclientapplicationbuilder#methods).
- For a description of all the options exposed in `PublicClientApplicationOptions`, see [PublicClientApplicationOptions](/dotnet/api/microsoft.identity.client.publicclientapplicationoptions) in the reference documentation.

### Complete example with configuration options

Imagine a .NET console application that has the following `appsettings.json` configuration file:

```json
{
  "Authentication": {
    "AzureCloudInstance": "AzurePublic",
    "AadAuthorityAudience": "AzureAdMultipleOrgs",
    "ClientId": "00001111-aaaa-2222-bbbb-3333cccc4444"
  },

  "WebAPI": {
    "MicrosoftGraphBaseEndpoint": "https://graph.microsoft.com"
  }
}
```

You have little code to read in this file by using the .NET-provided configuration framework:

```csharp
public class SampleConfiguration
{
 /// <summary>
 /// Authentication options
 /// </summary>
 public PublicClientApplicationOptions PublicClientApplicationOptions { get; set; }

 /// <summary>
 /// Base URL for Microsoft Graph (it varies depending on whether the application runs
 /// in Microsoft Azure public clouds or national or sovereign clouds)
 /// </summary>
 public string MicrosoftGraphBaseEndpoint { get; set; }

 /// <summary>
 /// Reads the configuration from a JSON file
 /// </summary>
 /// <param name="path">Path to the configuration json file</param>
 /// <returns>SampleConfiguration as read from the json file</returns>
 public static SampleConfiguration ReadFromJsonFile(string path)
 {
  // .NET configuration
  IConfigurationRoot Configuration;
  var builder = new ConfigurationBuilder()
                    .SetBasePath(Directory.GetCurrentDirectory())
                    .AddJsonFile(path);
  Configuration = builder.Build();

  // Read the auth and graph endpoint configuration
  SampleConfiguration config = new SampleConfiguration()
  {
   PublicClientApplicationOptions = new PublicClientApplicationOptions()
  };
  Configuration.Bind("Authentication", config.PublicClientApplicationOptions);
  config.MicrosoftGraphBaseEndpoint =
  Configuration.GetValue<string>("WebAPI:MicrosoftGraphBaseEndpoint");
  return config;
 }
}
```

Now, to create your application, write the following code:

```csharp
SampleConfiguration config = SampleConfiguration.ReadFromJsonFile("appsettings.json");
var app = PublicClientApplicationBuilder.CreateWithApplicationOptions(config.PublicClientApplicationOptions)
           .WithDefaultRedirectUri()
           .Build();
```

Before the call to the `.Build()` method, you can override your configuration with calls to `.WithXXX` methods, as seen previously.

# [Java](#tab/java)

Here's the class used in MSAL Java development samples to configure the samples: [TestData](https://github.com/AzureAD/microsoft-authentication-library-for-java/tree/dev/msal4j-sdk/src/samples/public-client/).

```Java
PublicClientApplication pca = PublicClientApplication.builder(CLIENT_ID)
        .authority(AUTHORITY)
        .build();
```

# [MacOS](#tab/macOS)

The following code instantiates a public client application and signs in users in the Microsoft Azure public cloud with a work or school account or a personal Microsoft account.

### Quick configuration

Objective-C:

```objc
NSError *msalError = nil;

MSALPublicClientApplicationConfig *config = [[MSALPublicClientApplicationConfig alloc] initWithClientId:@"<your-client-id-here>"];
MSALPublicClientApplication *application = [[MSALPublicClientApplication alloc] initWithConfiguration:config error:&msalError];
```

Swift:
```swift
let config = MSALPublicClientApplicationConfig(clientId: "<your-client-id-here>")
if let application = try? MSALPublicClientApplication(configuration: config){ /* Use application */}
```

### More elaborated configuration

You can elaborate the application building by adding a number of modifiers. For instance, if you want your application to be a multitenant application in a national cloud, such as US Government shown here, you could write:

Objective-C:

```objc
MSALAADAuthority *aadAuthority =
                [[MSALAADAuthority alloc] initWithCloudInstance:MSALAzureUsGovernmentCloudInstance
                                                   audienceType:MSALAzureADMultipleOrgsAudience
                                                      rawTenant:nil
                                                          error:nil];

MSALPublicClientApplicationConfig *config =
                [[MSALPublicClientApplicationConfig alloc] initWithClientId:@"<your-client-id-here>"
                                                                redirectUri:@"<your-redirect-uri-here>"
                                                                  authority:aadAuthority];

NSError *applicationError = nil;
MSALPublicClientApplication *application =
                [[MSALPublicClientApplication alloc] initWithConfiguration:config error:&applicationError];
```

Swift:

```swift
let authority = try? MSALAADAuthority(cloudInstance: .usGovernmentCloudInstance, audienceType: .azureADMultipleOrgsAudience, rawTenant: nil)

let config = MSALPublicClientApplicationConfig(clientId: "<your-client-id-here>", redirectUri: "<your-redirect-uri-here>", authority: authority)
if let application = try? MSALPublicClientApplication(configuration: config) { /* Use application */}
```

# [Node.js](#tab/nodejs)

Configuration parameters can be loaded from many sources, like a JavaScript file or from environment variables. Below, an *authConfig.js* file is used. 

:::code language="js" source="~/../ms-identity-JavaScript-nodejs-desktop/App/authConfig.js":::

Import the configuration object from *authConfig.js* file. MSAL Node can be initialized minimally as below. See the available [configuration options](https://github.com/AzureAD/microsoft-authentication-library-for-js/blob/dev/lib/msal-node/docs/configuration.md).  

```JavaScript
const { PublicClientApplication } = require('@azure/msal-node');
const { msalConfig } = require('./authConfig')

/**
* Initialize a public client application. For more information, visit:
* https://github.com/AzureAD/microsoft-authentication-library-for-js/blob/dev/lib/msal-node/docs/initialize-public-client-application.md
*/
clientApplication = new PublicClientApplication(msalConfig);
```

# [Python](#tab/python)

```Python
config = json.load(open(sys.argv[1]))

app = msal.PublicClientApplication(
    config["client_id"], authority=config["authority"],
    # token_cache=...  # Default cache is in memory only.
                       # You can learn how to use SerializableTokenCache from
                       # https://msal-python.rtfd.io/en/latest/#msal.SerializableTokenCache
    )
```

---

## Next steps

Move on to the next article in this scenario, 
[Acquire a token for the desktop app](scenario-desktop-acquire-token.md).
