---
title: Grant application permissions to an autonomous agent
description: Learn how to grant application permissions to agent identities through Microsoft Entra ID administrator consent and app role assignments for Microsoft Graph and other web services.
titleSuffix: Microsoft Entra Agent ID

author: omondiatieno
ms.author: jomondi
ms.service: entra-id
ms.topic: how-to
ms.date: 11/04/2025
ms.custom: agent-id-ignite
ms.reviewer: dastrock
#customer-intent: As a Microsoft Microsoft Entra ID administrator or developer, I want to grant application permissions to my agent identities, so that my autonomous agents can access Microsoft Graph and other web services with the necessary permissions for their operations.
---

# Grant application permissions to an autonomous agent

Agents often need to take actions in Microsoft Graph and other web services that require a Microsoft Entra ID application permission (represented as app roles). Autonomous agents need to request these permissions from a Microsoft Entra ID administrator. This article walks through the process of requesting application permissions from an admin using the agent identity created in previous steps.

There are two ways to grant application permissions to an autonomous agent:

- An admin can create an *appRoleAssignment* by using Microsoft Graph APIs or PowerShell.
- The agent can direct the admin to a consent page using an admin consent URL.

## Prerequisites

Before granting permissions to agent identities, ensure you have:

- A created agent identity (see [Create and delete agent identities](create-delete-agent-identities.md))
- Administrator privileges in your Microsoft Entra ID tenant
- Understanding of the specific permissions your agent requires

## Create an app role assignment via APIs

Use the following steps to get an app role assignment.

1. [Obtain an access token](./autonomous-agent-request-tokens.md) with the delegated permissions `Application.Read.All` and `AppRoleAssignment.ReadWrite.All`.

1. Get the object ID of the resource service principal that you're trying to access. For example, to find the Microsoft Graph service principal object ID:
    1. Go to the [Microsoft Entra admin center](https://entra.microsoft.com/).
    1. Navigate to **Entra ID** --> **Enterprise Applications**
    1. Filter by Application type == Microsoft Applications
    1. Search for **Microsoft Graph**.

1. Get the unique ID of the [app role you want to assign](/graph/permissions-reference).

1. Create the app role assignment:

    ## [Microsoft Graph API](#tab/microsoft-graph-api)
    
    ```http
    POST https://graph.microsoft.com/v1.0/servicePrincipals/<agent-identity-id>/appRoleAssignments
    Authorization: Bearer <token>
    Content-Type: application/json
    
    {
      "principalId": "<agent-identity-id>",
      "resourceId": "<microsoft-graph-sp-object-id>",
      "appRoleId": "<app-role-id>"
    }
    ```
    
    ## [Microsoft Graph PowerShell](#tab/microsoft-graph-powershell)
    
    ```powershell
    Connect-MgGraph -Scopes "Application.Read.All AppRoleAssignment.ReadWrite.All" -TenantId <your-test-tenant>
    
    # Get the service principal for Microsoft Graph (well-known app ID)
    $graphSp = Get-MgServicePrincipal -Filter "appId eq '00000003-0000-0000-c000-000000000000'"
    
    # Get your application's service principal (replace with your app's client ID)
    $agentId = "<agent-identity-id>"
    
    # Find the App Role ID for "User.ReadBasic.All"
    $userReadBasicRole = $graphSp.AppRoles | Where-Object {
        $_.Value -eq "User.ReadBasic.All" -and $_.AllowedMemberTypes -contains "Application"
    }
    
    # Assign the app role
    New-MgServicePrincipalAppRoleAssignment -ServicePrincipalId $agentId `
        -PrincipalId $agentId `
        -ResourceId $graphSp.Id `
        -AppRoleId $userReadBasicRole.Id
    ```

---

## Request authorization from a tenant administrator

To grant delegated permissions, construct the authorization URL that is used to prompt the administrator. The role parameter is used to specify the requested application permissions.

Be sure to use the agent identity client ID in the following request.

```bash
https://login.microsoftonline.com/contoso.onmicrosoft.com/v2.0/adminconsent
?client_id=<agent-identity-client-id>
&role=User.Read.All
&redirect_uri=https://entra.microsoft.com/TokenAuthorize
&state=xyz123
```

Agent implementations might redirect the admin to this URL in various ways, such as including it in a message sent to the admin in a chat window. When the admin is redirected to this URL, they're asked to sign in and grant consent to the permissions specified in the scope parameter. At the moment you must use the redirect URI listed, which directs the admin to a blank page after granting consent.

After you grant your application the required permissions, request a new agent access token for the permissions to take effect.

## Related content

- [Microsoft Graph permissions reference](/graph/permissions-reference)
- [Permissions and consent in the Microsoft identity platform](/entra/identity-platform/permissions-consent-overview)
