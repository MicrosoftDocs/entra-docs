---
title: Call Azure services from an agent using .NET Azure SDK
titleSuffix: Microsoft Entra Agent ID
description: Call Azure services as an agent by using MicrosoftIdentityTokenCredential and the .NET Azure SDK.
ms.topic: how-to
ms.date: 11/05/2026
ai-usage: ai-assisted
ms.reviewer: jmprieur
#Customer intent: As a developer building a cloud agent, I want to call Azure services as the agent so that Azure RBAC controls its unattended access.
---

# Call Azure services from your agent using .NET Azure SDK

Read blob data with the agent's own identity, without a signed-in user's delegated access. Azure services authorize the Agent ID through Azure role-based access control (Azure RBAC).

In this article, you adapt an ASP.NET Core agent's token acquisition to Azure SDK clients. Assign the minimum role at the narrowest resource scope.

## Prerequisites

- The [blueprint credential and ASP.NET Core services](call-api-custom.md#configure-the-blueprint-credential), including token acquisition. Reuse the local certificate configuration when running on a workstation. This example doesn't require the custom API's app role or consent grant.
- An existing storage account and an `agent-data` blob container. Replace `<storage-account>` in the example with the account name.
- An Azure data-plane role assignment for the **agent identity's object ID** on that container or account, not for the blueprint or its managed identity credential.

Install the integration package and Blob Storage SDK from the agent project's directory:

```dotnetcli
dotnet add package Microsoft.Identity.Web.Azure
dotnet add package Azure.Storage.Blobs
```

## Configure the token credential

Register `MicrosoftIdentityTokenCredential` with dependency injection:

Add the following registration before `builder.Build()` in `Program.cs`, and merge the `using` directive with those at the top of the file.

```csharp
using Microsoft.Identity.Web;

builder.Services.AddMicrosoftIdentityAzureTokenCredential();
```

The credential uses the Microsoft.Identity.Web configuration established in the parent journey. Use a managed identity federated credential in hosted environments.

[!INCLUDE [Dont use secrets](./includes/do-not-use-secrets.md)]

## Call Azure Blob Storage as the agent

Inject `MicrosoftIdentityTokenCredential` and request an app-only token with the shared client ID configured in the parent journey:

The following is a service component, not a complete `Program.cs`. Put the class in `AgentStorageService.cs`, register it with `builder.Services.AddScoped<AgentStorageService>()` before `builder.Build()`, and invoke `ListBlobsAsync()` from an authorized application operation. Preserve the parent journey's `AgentUser` policy on any endpoint that triggers this app-only operation.

```csharp
using Azure.Storage.Blobs;
using Microsoft.Identity.Web;

public sealed class AgentStorageService
{
    private readonly MicrosoftIdentityTokenCredential _credential;

    public AgentStorageService(MicrosoftIdentityTokenCredential credential)
    {
        _credential = credential;
    }

    public async Task<IReadOnlyList<string>> ListBlobsAsync()
    {
        _credential.Options.RequestAppToken = true;

        var serviceClient = new BlobServiceClient(
            new Uri("https://<storage-account>.blob.core.windows.net"),
            _credential);
        var container = serviceClient.GetBlobContainerClient("agent-data");
        var names = new List<string>();

        await foreach (var blob in container.GetBlobsAsync())
        {
            names.Add(blob.Name);
        }

        return names;
    }
}
```

`RequestAppToken = true` selects autonomous, app-only access. For a user-delegated Azure call, use [Call an Azure service as a user](aspnet-core-call-azure-api-as-user.md).

The Agent ID needs an appropriate data-plane role, such as **Storage Blob Data Reader**. A management-plane role such as **Reader** doesn't grant access to blob data.

Use the same credential with other Azure SDK clients, including Azure Key Vault clients. Replace the endpoint and role with the values required by the target service.

For a container containing test blobs, `ListBlobsAsync()` should return their names; an empty container returns an empty list. A storage `403` requires checking the agent's data-plane role and target resource separately from successful token acquisition. Don't grant a management-plane role to fix missing blob data access.

## Next step

[Authenticate users to the agent API](aspnet-core-authenticate-users.md)

## Related content

- [Call a custom API as an agent](call-api-custom.md)
- [Azure built-in roles](/azure/role-based-access-control/built-in-roles)
- [Authorize access to blobs using Microsoft Entra ID](/azure/storage/blobs/authorize-access-azure-active-directory)
- [Call an Azure service as a user](aspnet-core-call-azure-api-as-user.md)
