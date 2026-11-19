---
title: Use an agent's user account with Microsoft 365
description: Learn when an autonomous agent needs an agent's user account for Teams, Exchange, SharePoint, and user-based Microsoft 365 services.
titleSuffix: Microsoft Entra Agent ID
ms.topic: how-to
ms.date: 11/05/2026
ai-usage: ai-assisted
ms.reviewer: jmprieur
#Customer intent: As a developer or administrator, I want to know when an agent needs a user object so that I can provision only the Microsoft 365 resources the agent requires.
---

# Use an agent's user account with Microsoft 365

Most autonomous agents should call APIs with their agent identity and application permissions. Create an [agent's user account](agent-users.md) only when a Microsoft 365 workload requires a user object.

An agent's user account is a dedicated user identity for the agent. It isn't the signed-in user of an interactive agent. Each account has a one-to-one relationship with an agent identity.

## Determine whether the agent needs a user object

| Scenario | Is an agent's user account required? | Guidance |
| --- | --- | --- |
| Call an API that supports application permissions | No | Use the agent identity and app-only access. |
| Add the agent as a member of a Microsoft Teams team | Yes | Team membership is assigned to directory users. See [add members to a team](/graph/api/team-post-members). |
| Give the agent its own Exchange Online mailbox | Yes | A mailbox is provisioned for a user object. See [create user mailboxes in Exchange Online](/exchange/recipients-in-exchange-online/create-user-mailboxes). |
| Share a SharePoint or OneDrive item directly with the agent as a person | Yes | Use the agent's user account as the sharing recipient. See [sharing files and folders](/sharepoint/modern-experience-sharing-permissions). |
| Use a Microsoft 365 service that is licensed per user | Yes | Assign only the licenses required by the service. See [assign licenses to users](/microsoft-365/admin/manage/assign-licenses-to-users). |

Don't create an agent's user account only because the agent runs without a person present. If the target service supports application permissions or workload-specific application access controls, use the agent identity instead.

## Provision access

1. [Create an agent's user account](create-delete-agent-user-account.md) and associate it with the agent identity.
1. Assign the account only the Microsoft 365 licenses it needs.
1. Add the account to the required team, provision its mailbox, or share the required SharePoint resources by following the service documentation in the preceding table.
1. [Grant the agent identity delegated permissions](grant-agent-access-microsoft-365.md) for the Microsoft 365 scopes the workload requires, such as `Mail.ReadWrite` or `Files.ReadWrite`. The agent identity uses these delegated permissions when it authenticates as the agent's user account.

Creating the user object doesn't grant access to a team, mailbox, site, file, or API. Complete the workload-specific assignment separately.

## Authenticate as the agent's user account

The agent's user account flow doesn't involve a signed-in user. Use `WithAgentUserIdentity` to identify the dedicated user account. *Microsoft.Identity.Web.AgentIdentities* performs the Agent ID token exchange.

This example uses blueprint-to-child token exchange. Reuse the [package installation and runtime configuration](aspnet-core-fleet-call-apis-as-agent.md#install-the-packages), including `Microsoft.Identity.Web.AgentIdentities`, `AddAgentIdentities()`, token acquisition, an HTTP client, and a token cache. Configure the blueprint's client ID and credential in the runtime; pass the child agent identity's client ID and its associated user account to `WithAgentUserIdentity`. Don't substitute the single-instance app-only setup, which omits this Agent ID exchange registration.

The following code is an endpoint fragment, not a complete host. Merge its `using` directives at the top of `Program.cs` and place its mapping before `app.Run()`. Configure the [inbound `AgentUser` authorization policy](control-user-access-agents.md#enforce-app-roles-in-the-agent-api) before exposing the mailbox endpoint. Resolve the agent and account from trusted application configuration, not caller-supplied values.

Identify the agent's user account by UPN:

```csharp
using System.Net.Http.Headers;
using System.Security.Claims;
using Microsoft.Identity.Abstractions;
using Microsoft.Identity.Web;

app.MapGet("/mailbox", async (
    IAuthorizationHeaderProvider authorizationHeaderProvider,
    IHttpClientFactory httpClientFactory) =>
{
    var options = new AuthorizationHeaderProviderOptions()
        .WithAgentUserIdentity("<agent-identity-client-id>", "<agent-user-upn>");

    string authorizationHeader = await authorizationHeaderProvider
        .CreateAuthorizationHeaderForUserAsync(
            ["https://graph.microsoft.com/.default"],
            options,
            new ClaimsPrincipal());

    HttpClient client = httpClientFactory.CreateClient();
    client.DefaultRequestHeaders.Authorization =
        AuthenticationHeaderValue.Parse(authorizationHeader);

    using HttpResponseMessage response =
        await client.GetAsync("https://graph.microsoft.com/v1.0/me/messages");
    response.EnsureSuccessStatusCode();

    return Results.Content(
        await response.Content.ReadAsStringAsync(),
        "application/json");
})
.RequireAuthorization("AgentUser");
```

Or identify the account by object ID:

```csharp
var options = new AuthorizationHeaderProviderOptions()
    .WithAgentUserIdentity("<agent-identity-client-id>", Guid.Parse("<agent-user-object-id>"));
```

Pass `new ClaimsPrincipal()` because no user is signed in. The user identity comes from `WithAgentUserIdentity`, not from the request context. Grant the agent's user account only the delegated permissions the workload requires. Don't implement the token exchange directly.

For the protocol model and security constraints, see [OAuth protocols in Microsoft Entra Agent ID](agent-oauth-protocols.md#autonomous-agent-that-acts-as-a-dedicated-user). For the full API reference, see [Microsoft.Identity.Web on GitHub](https://github.com/AzureAD/microsoft-identity-web).

For an authorized inbound caller, a successful `/mailbox` call returns the configured **agent user's** messages, not the caller's mailbox. An empty message collection can be valid. If the call fails, check the identity-to-account association, delegated grant, and Exchange mailbox provisioning separately. The sample throws on a downstream non-success status rather than forwarding that status to the inbound caller.

For test-only resources, follow [Delete an agent's user account](create-delete-agent-user-account.md) after removing any workload-specific access you created. Don't delete a shared mailbox or account.

## Next step

[Manage the agent's user account](create-delete-agent-user-account.md)

## Related content

- [Agent's user accounts](agent-users.md)
- [Call a custom API as an agent](call-api-custom.md)
- [Request consent for delegated permissions](grant-agent-access-microsoft-365.md)
