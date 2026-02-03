---
title: Call custom APIs from an agent using .NET
titleSuffix: Microsoft Entra Agent ID
description: Learn how to call custom protected APIs from an agent using different approaches including IDownstreamApi, MicrosoftIdentityMessageHandler, and IAuthorizationHeaderProvider.
author: SHERMANOUKO
ms.service: entra-id
ms.topic: how-to
ms.date: 11/04/2025
ms.custom: agent-id-ignite
ms.author: shermanouko
ms.reviewer: jmprieur
#Customer intent: As a developer building AI agents, I want to call custom protected APIs from my agent using agent identities so that the agent can securely access organization-specific services and resources.
---

# Call custom APIs from an agent using .NET

There are multiple ways to call custom APIs from an agent. Depending on your scenario, you can use either `IDownstreamApi`, `MicrosoftIdentityMessageHandler`, or `IAuthorizationHeaderProvider`. This guide explains the different approaches for calling your own protected APIs all the three ways.

[!INCLUDE [Common call API content](./includes/call-api-common-dotnet.md)]

## Decide which approach to use based on your scenario

The following table helps you decide which approach to use. For most scenarios, we recommend using `IDownstreamApi`. 

| Approach | Complexity | Flexibility | Use Case |
|----------|------------|-------------|----------|
| `IDownstreamApi` | Low | Medium | Standard REST APIs with configuration |
| `MicrosoftIdentityMessageHandler` | Medium | High | HttpClient with Direct Injection (DI) and composable pipeline |
| `IAuthorizationHeaderProvider` | High | Very High | Complete control over HTTP requests |

## [Use IDownstreamApi](#tab/idownstream)

`IDownstreamApi` is the preferred way to call a protected API among the three options. It's highly configurable and requires minimal code changes. It also offers automatic token acquisition.

Use `IDownstreamApi` when you need the following listed items:

- You're calling standard REST APIs
- You want a configuration-driven approach
- You need automatic serialization/deserialization
- You want to write minimal code

## [Use MicrosoftIdentityMessageHandler](#tab/messagehandler)

`MicrosoftIdentityMessageHandler` from the *Microsoft.Identity.Web.TokenAcquisition* package is a delegating handler that adds authentication to HttpClient requests. Use this when you need full HttpClient functionality with automatic token acquisition.

The *Microsoft.Identity.Web.TokenAcquisition* package is already referenced by *Microsoft.Identity.Web.AgentIdentities*.

Use `MicrosoftIdentityMessageHandler` when you need the following listed items:

- You need fine-grained control over HTTP requests
- You want to compose multiple message handlers
- You're integrating with existing HttpClient-based code
- You need access to raw HttpResponseMessage

## [Use IAuthorizationHeaderProvider](#tab/authheaderprovider)

`IAuthorizationHeaderProvider` from *Microsoft.Identity.Web* gives you direct access to authorization headers for complete control over HTTP requests. This means you can customize the authentication process to fit your needs, including adding or modifying headers as necessary. This method also allows you to use custom HTTP libraries to make API calls.

Use `IAuthorizationHeaderProvider` when you need the following listed items:

- You need complete control over HTTP request construction
- You're integrating with nonstandard HTTP APIs
- You need to use HttpClient without DI
- You're building custom HTTP abstractions

---

## Call your API

After determining what works for you, proceed to call your custom web API.

[!INCLUDE [Dont use secrets](./includes/do-not-use-secrets.md)]

## [Use IDownstreamApi](#tab/idownstream)

1. Install the required NuGet package:

    ```bash
    dotnet add package Microsoft.Identity.Web.DownstreamApi
    dotnet add package Microsoft.Identity.Web.AgentIdentities
    ```

1. Configure token credential options and your APIs in *appsettings.json*.

    ```json
    {
      "AzureAd": {
        "Instance": "https://login.microsoftonline.com/",
        "TenantId": "your-tenant-id",
        "ClientId": "your-blueprint-id",
        "ClientCredentials": [
          {
            "SourceType": "ClientSecret",
            "ClientSecret": "your-client-secret"
          }
        ]
      },
      "DownstreamApis": {
        "MyApi": {
          "BaseUrl": "https://api.example.com",
          "Scopes": ["api://my-api-client-id/read", "api://my-api-client-id/write"],
          "RelativePath": "/api/v1",
          "RequestAppToken": false
        }
      }
    }
    ```

1. Configure your services to add downstream API support:

    ```csharp
    using Microsoft.Identity.Web;
    
    var builder = WebApplication.CreateBuilder(args);
    
    // Add authentication
    builder.Services.AddAuthentication(OpenIdConnectDefaults.AuthenticationScheme)
        .AddMicrosoftIdentityWebApp(builder.Configuration.GetSection("AzureAd"))
        .EnableTokenAcquisitionToCallDownstreamApi()
        .AddInMemoryTokenCaches();
    
    // Register downstream APIs
    builder.Services.AddDownstreamApis(
        builder.Configuration.GetSection("DownstreamApis"));

    // Add Agent Identities support
    builder.Services.AddAgentIdentities();
    
    builder.Services.AddControllersWithViews();
    
    var app = builder.Build();
    app.UseAuthentication();
    app.UseAuthorization();
    app.MapControllers();
    app.Run();
    ```

1. Call your protected API using `IDownstreamApi`. When calling the API, you can specify the agent identity or agent user identity using the `WithAgentIdentity` or `WithAgentUserIdentity` methods. `IDownstreamApi` automatically handles token acquisition and attaches the access token to the request.

    - For `WithAgentIdentity`, you either call the API using an app only token (autonomous agent) or on-behalf of a user (interactive agent).
        
        ```csharp
        using Microsoft.Identity.Abstractions;
        using Microsoft.AspNetCore.Authorization;
        using Microsoft.AspNetCore.Mvc;
        
        [Authorize]
        public class ProductsController : Controller
        {
            private readonly IDownstreamApi _api;
            
            public ProductsController(IDownstreamApi api)
            {
                _api = api;
            }
            
            // GET request for app only token scenario for agent identity
            public async Task<IActionResult> Index()
            {
        
                string agentIdentity = "<your-agent-identity>";
                var products = await _api.GetForAppAsync<List<Product>>(
                    "MyApi",
                    "products",
                    options => options.WithAgentIdentity(agentIdentity));
                
                return View(products);
            }
        
            // GET request for on-behalf of user token scenario for agent identity
            public async Task<IActionResult> UserProducts()
            {
        
                string agentIdentity = "<your-agent-identity>";
                var products = await _api.GetForUserAsync<List<Product>>(
                    "MyApi",
                    "products",
                    options => options.WithAgentIdentity(agentIdentity));
                
                return View(products);
            }
        }
        ```

    - For `WithAgentUserIdentity`, you can specify either User Principal Name (UPN) or Object Identity (OID) to identify the agent user.

        ```csharp
        using Microsoft.Identity.Abstractions;
        using Microsoft.AspNetCore.Authorization;
        using Microsoft.AspNetCore.Mvc;
        
        [Authorize]
        public class ProductsController : Controller
        {
            private readonly IDownstreamApi _api;
        
            public ProductsController(IDownstreamApi api)
            {
                _api = api;
            }
        
            // GET request for agent user identity using UPN
            public async Task<IActionResult> Index()
            {
        
                string agentIdentity = "<your-agent-identity>";
                string userUpn = "user@contoso.com";
                
                var products = await _api.GetForUserAsync<List<Product>>(
                    "MyApi",
                    "products",
                    options => options.WithAgentUserIdentity(agentIdentity, userUpn));
                return View(products);
            }
            
            // GET request for agent user identity using OID
            public async Task<IActionResult> UserProducts()
            {
        
                string agentIdentity = "<your-agent-identity>";
                string userOid = "user-object-id";
        
                var products = await _api.GetForUserAsync<List<Product>>(
                    "MyApi",
                    "products",
                    options => options.WithAgentUserIdentity(agentIdentity, userOid));
        
                return View(products);
            }
        
        }
        ```

## [Use MicrosoftIdentityMessageHandler](#tab/messagehandler)

1. Install the required NuGet package:

    ```bash
    dotnet add package Microsoft.Identity.Web.AgentIdentities
    ```

1. Configure your services to add authentication with agent identities and register HttpClient with `MicrosoftIdentityMessageHandler`:

    ```csharp
    using Microsoft.Identity.Web;
    using Microsoft.Identity.Abstractions;
    
    var builder = WebApplication.CreateBuilder(args);
    
    builder.Services.AddAuthentication(OpenIdConnectDefaults.AuthenticationScheme)
        .AddMicrosoftIdentityWebApp(builder.Configuration.GetSection("AzureAd"))
        .EnableTokenAcquisitionToCallDownstreamApi()
        .AddInMemoryTokenCaches();
    
    // Configure named HttpClient with authentication
    builder.Services.AddHttpClient("MyApiClient", client =>
    {
        client.BaseAddress = new Uri("https://api.example.com");
        client.DefaultRequestHeaders.Add("Accept", "application/json");
        client.Timeout = TimeSpan.FromSeconds(30);
    })
    .AddHttpMessageHandler(sp =>
    {
        var authProvider = sp.GetRequiredService<IAuthorizationHeaderProvider>();
        return new MicrosoftIdentityMessageHandler(
            authProvider,
            new MicrosoftIdentityMessageHandlerOptions
            {
                Scopes = new[] { "api://my-api-client-id/read" },
            });
    });
    
    builder.Services.AddControllersWithViews();
    
    // Add Agent Identities support
    builder.Services.AddAgentIdentities();
    
    
    var app = builder.Build();
    app.UseAuthentication();
    app.UseAuthorization();
    app.MapControllers();
    app.Run();
    ```

1. Acquire token and call your protected API using the configured HttpClient. You can specify the agent identity or agent user using the `WithAgentIdentity` or `WithAgentUserIdentity` methods.

    - For `WithAgentIdentity`, you either call the API using an app only token (autonomous agent) or on-behalf of a user (interactive agent).

        To call the API using an app only token for the agent identity, set `RequestAppToken` to `true`.
    
        ```csharp
        public class MyService
        {
            private readonly HttpClient _httpClient;
        
            public MyService(IHttpClientFactory httpClientFactory)
            {
                _httpClient = httpClientFactory.CreateClient("MyApiClient");
            }
        
            public async Task<string> CallApiWithAgentIdentity(string agentIdentity)
            {
                // Create request with agent identity authentication
                string agentIdentity = "<your-agent-identity>";
                var request = new HttpRequestMessage(HttpMethod.Get, "/api/data")
                    .WithAuthenticationOptions(options => 
                    {
                        options.WithAgentIdentity(agentIdentity);
                        options.RequestAppToken = true;
                    });
        
                var response = await _httpClient.SendAsync(request);
                response.EnsureSuccessStatusCode();
                return await response.Content.ReadAsStringAsync();
            }
        }
        ```

        To call the API on-behalf of a user for the agent identity, don't set `RequestAppToken` or explicitly set it to `false`.

        ```csharp
        public class MyService
        {
            private readonly HttpClient _httpClient;
        
            public MyService(IHttpClientFactory httpClientFactory)
            {
                _httpClient = httpClientFactory.CreateClient("MyApiClient");
            }
        
            public async Task<string> CallApiWithAgentIdentity(string agentIdentity)
            {
                // Create request with agent identity authentication
                string agentIdentity = "<your-agent-identity>";
                var request = new HttpRequestMessage(HttpMethod.Get, "/api/data")
                    .WithAuthenticationOptions(options =>
                    {
                        options.WithAgentIdentity(agentIdentity);
                        options.RequestAppToken = false;
                    });
        
                var response = await _httpClient.SendAsync(request);
                response.EnsureSuccessStatusCode();
                return await response.Content.ReadAsStringAsync();
            }
        }
        ```

    - To use `WithAgentUserIdentity`, you can specify either UPN or OID to identify the agent user.
    
        ```csharp
        // Create request with agent user identity authentication with UPN
        public async Task<string> CallApiWithAgentUserIdentity(string agentIdentity, string userUpn)
        {
            string agentIdentity = "<your-agent-identity>";
            string userUpn = "<your-user-upn>";
        
            var request = new HttpRequestMessage(HttpMethod.Get, "/api/userdata")
                .WithAuthenticationOptions(options => 
                {
                    options.WithAgentUserIdentity(agentIdentity, userUpn);
                    options.Scopes.Add("https://myapi.domain.com/user.read");
                });
        
            var response = await _httpClient.SendAsync(request);
            response.EnsureSuccessStatusCode();
            return await response.Content.ReadAsStringAsync();
        }
        
        // Create request with agent user identity authentication with OID
        public async Task<string> CallApiWithAgentUserIdentity(string agentIdentity, string userUpn)
        {
            string agentIdentity = "<your-agent-identity>";
            string userOid = "<your-user-oid>";
        
            var request = new HttpRequestMessage(HttpMethod.Get, "/api/userdata")
                .WithAuthenticationOptions(options => 
                {
                    options.WithAgentUserIdentity(agentIdentity, userOid);
                    options.Scopes.Add("https://myapi.domain.com/user.read");
                });
        
            var response = await _httpClient.SendAsync(request);
            response.EnsureSuccessStatusCode();
            return await response.Content.ReadAsStringAsync();
        }
        ```

## [Use IAuthorizationHeaderProvider](#tab/authheaderprovider)

1. Install the required NuGet package:

    ```bash
    dotnet add package Microsoft.Identity.Web.AgentIdentities
    ```

1. Configure your services to add authentication with agent identities:

    ```csharp
    using Microsoft.AspNetCore.Authorization;
    using Microsoft.Identity.Abstractions;
    using Microsoft.Identity.Web;
    
    var builder = WebApplication.CreateBuilder(args);
    
    // With Microsoft.Identity.Web
    builder.Services.AddMicrosoftIdentityWebApiAuthentication(builder.Configuration)
        .EnableTokenAcquisitionToCallDownstreamApi();
    
    builder.Services.AddAgentIdentities();
    
    var app = builder.Build();
    
    app.UseAuthentication();
    app.UseAuthorization();
    
    app.Run();
    ```
    
    - Configure auth credentials in *appsettings.json*
    
    ```json
    {
      "AzureAd": {
        "Instance": "https://login.microsoftonline.com/",
        "TenantId": "your-tenant-id",
        "ClientId": "your-blueprint-id",
        "ClientCredentials": [
          {
            "SourceType": "ClientSecret",
            "ClientSecret": "your-client-secret"
          }
        ]
      }
    }
    ```

1. Acquire and extract access token then call the web API.

    - For `WithAgentIdentity`, you either call the API using an app only token (autonomous agent) or on-behalf of a user (interactive agent).
    
        - For app only token scenario, use `CreateAuthorizationHeaderForAppAsync` method.
        - For OBO token scenario, use `CreateAuthorizationHeaderForUserAsync` method 
    
        ```csharp
        using Microsoft.Identity.Abstractions;

        [Authorize]
        public class CustomApiController : Controller
        {
            private readonly IAuthorizationHeaderProvider _headerProvider;
            
            public CustomApiController(
                IAuthorizationHeaderProvider headerProvider,
            {
                _headerProvider = headerProvider;
            }
            
            // App only token scenario for agent identity
            public async Task<IActionResult> GetBackgroundData()
            {
                // Configure options for the agent identity
                string agentIdentity = "agent-identity-guid";
                var options = new AuthorizationHeaderProviderOptions()
                    .WithAgentIdentity(agentIdentity);
        
                // Acquire an access token for the agent identity
                var authHeader = await _headerProvider.CreateAuthorizationHeaderForAppAsync(
                    scopes: new[] { "api://my-api/.default" }, options: options);
                
                // Call the protected API
                using var client = new HttpClient();
                client.DefaultRequestHeaders.Add("Authorization", authHeader);
                
                var response = await client.GetAsync("https://api.example.com/background");
                var data = await response.Content.ReadFromJsonAsync<BackgroundData>();
                
                return Ok(data);
            }
        
            // On-behalf of user token scenario for agent identity
            public async Task<IActionResult> GetBackgroundData()
            {
                // Configure options for the agent identity
                string agentIdentity = "agent-identity-guid";
                var options = new AuthorizationHeaderProviderOptions()
                    .WithAgentIdentity(agentIdentity);
        
                // Acquire an access token for the agent identity
                var authHeader = await _headerProvider.CreateAuthorizationHeaderForUserAsync(
                    scopes: new[] { "api://my-api/.default" }, options: options);
                
                // Call the protected API
                using var client = new HttpClient();
                client.DefaultRequestHeaders.Add("Authorization", authHeader);
                
                var response = await client.GetAsync("https://api.example.com/background");
                var data = await response.Content.ReadFromJsonAsync<BackgroundData>();
                
                return Ok(data);
            }
        }
        ```

    - For `WithAgentUserIdentity`, you call the API on behalf of a user using their UPN or OID.

        ```csharp
        using Microsoft.Identity.Abstractions;

        [Authorize]
        public class CustomApiController : Controller
        {
            private readonly IAuthorizationHeaderProvider _headerProvider;
            
            public CustomApiController(IAuthorizationHeaderProvider headerProvider)
            {
                _headerProvider = headerProvider;
            }
            
            // App only token scenario for agent identity
            public async Task<IActionResult> GetBackgroundData()
            {
                // Configure options for the agent identity
                string agentIdentity = "agent-identity-guid";
                string userUpn = "user@contoso.com";
        
                var options = new AuthorizationHeaderProviderOptions()
                    .WithAgentUserIdentity(agentIdentity, userUpn);
        
                // Create a ClaimsPrincipal to enable token caching
                ClaimsPrincipal user = new ClaimsPrincipal();
        
                // Acquire an access token for the agent identity
                var authHeader = await _headerProvider.CreateAuthorizationHeaderForAppAsync(
                    scopes: new[] { "api://my-api/.default" }, options: options, user: user);
                
                // Call the protected API
                using var client = new HttpClient();
                client.DefaultRequestHeaders.Add("Authorization", authHeader);
                
                var response = await client.GetAsync("https://api.example.com/background");
                var data = await response.Content.ReadFromJsonAsync<BackgroundData>();
                
                return Ok(data);
            }
        
            // On-behalf of user token scenario for agent identity
            public async Task<IActionResult> GetBackgroundData()
            {
                // Configure options for the agent identity
                string agentIdentity = "agent-identity-guid";
                string userUpn = "user@contoso.com";
        
                var options = new AuthorizationHeaderProviderOptions()
                    .WithAgentUserIdentity(agentIdentity, userUpn);
        
                // Create a ClaimsPrincipal to enable token caching
                ClaimsPrincipal user = new ClaimsPrincipal();
        
                // Acquire an access token for the agent identity
                var authHeader = await _headerProvider.CreateAuthorizationHeaderForAppAsync(
                    scopes: new[] { "api://my-api/.default" }, options: options, user: user);
                
                // Call the protected API
                using var client = new HttpClient();
                client.DefaultRequestHeaders.Add("Authorization", authHeader);
            
                var response = await client.GetAsync("https://api.example.com/background");
                var data = await response.Content.ReadFromJsonAsync<BackgroundData>();
            
                return Ok(data);
            }
        }       
        ```

---

## Related content

- [Microsoft identity web](/entra/msal/dotnet/microsoft-identity-web/)
- [Call Microsoft Graph APIs](./call-api-custom.md)
- [Call Azure SDKs](./call-api-azure-services.md)
