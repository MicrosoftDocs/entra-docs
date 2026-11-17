---
title: Create an identity for your agent (preview)
description: Set up your agent's identity with Microsoft Graph, including its registration, redirect URIs, credential, and API permission declarations.
ms.topic: how-to
ms.date: 11/06/2026
ai-usage: ai-assisted
# Customer intent: As an agent developer, I want to register my agent so that it can authenticate and request access to APIs.
---

# Create an identity for your agent with Microsoft Graph (preview)

Register your agent so it can authenticate with Microsoft Entra ID and request access to APIs. This setup creates one identity for your agent, shared by its installations or replicas.

This procedure uses Microsoft Graph beta. For a cloud agent, configure a credential for its runtime. For an agent installed on an end-user device, use the public-client redirect configuration without a credential. Your calling tutorial identifies the sections you need.

> [!IMPORTANT]
> Single-instance agent identities are in preview. This preview is provided without a service-level agreement and isn't recommended for production workloads. Some features might be unsupported or have constrained capabilities. For more information, see [Universal License Terms for Online Services](https://www.microsoft.com/licensing/terms/product/ForOnlineServices/all).

## Prerequisites

- A Microsoft Entra tenant enabled for single-instance provisioning in Microsoft Graph. Confirm preview availability and tenant enablement with your Microsoft representative before you begin. To request tokens after setup, also confirm that single-instance authentication is enabled; provisioning and authentication are enabled separately.
- An account authorized to create and update agent identity blueprints and agent identities, such as an [Agent ID Administrator](~/identity/role-based-access-control/permissions-reference.md#agent-id-administrator).
- A separate, single-tenant public management app with administrator consent for the delegated Microsoft Graph permissions `AgentIdentityBlueprint.ReadWrite.All` and `AgentIdentity.ReadWrite.All`, or permission to [set up the management client](#set-up-the-management-client).
- An administrator who can grant consent to the management app's Graph permissions.
- The object ID of a user who can be assigned as the blueprint's sponsor. The examples also assign that user as an owner.
- For interactive sign-in, a redirect URI appropriate for the client type. For browser-based administrator consent, a `web` redirect URI, even if the agent only uses client credentials at runtime.
- For local confidential-client testing, an X.509 certificate and secure storage for its private key. An Azure-hosted agent can use a managed identity federated credential instead. A public-only client doesn't need a credential.
- For API access, the resource application's client ID and the IDs of the delegated permissions or app roles the agent needs.

Run the HTTP examples through Microsoft Graph PowerShell as described below, or use a REST client that can send JSON request bodies and headers. In a REST client, send the management token as a bearer token in the `Authorization` header of each Graph request. Never use the agent's runtime access token for management requests.

### Confirm the administrator handoff

Before creating objects, agree on the following handoff. Management consent and the agent's runtime API consent are separate approvals.

| Who | Action | Ready when |
| --- | --- | --- |
| Tenant administrator and Microsoft representative. | Confirm that both preview provisioning and authentication are enabled. | The tenant supports registration and token requests for this setup. |
| Authorized administrator. | Approve the management client's two Graph permissions listed above. | The operator can sign in to that client with both consented scopes. |
| Developer or authorized operator. | Complete the registration steps below. | The blueprint object ID, agent identity object ID, and shared client ID are recorded. |
| API owner and consent administrator. | Supply the API identifiers and approve the permissions required by the calling tutorial. | The required runtime grants are verified before the first API call. |

Send the administrator your tenant ID, management client ID, and requested API permissions. Keep the [identifier worksheet](key-concepts.md#record-the-identifiers-for-your-scenario) alongside the setup steps.

If you're following a local HTTPS tutorial, also confirm that the development HTTPS certificate is trusted on your machine before browser sign-in. Follow your organization's trust process rather than disabling TLS validation.

## Set up the management client

The management client signs in an administrator or authorized operator to create the agent's registration. It's separate from the agent's runtime identity. An existing Azure CLI sign-in doesn't establish this management context.

1. [Register an application](~/identity-platform/quickstart-register-app.md) in the same tenant. Select **Accounts in this organizational directory only**. Under **Authentication**, add the **Mobile and desktop applications** platform with the redirect URI `http://localhost`.
1. Under **API permissions**, add these **Microsoft Graph > Delegated permissions**:

    - `AgentIdentityBlueprint.ReadWrite.All`.
    - `AgentIdentity.ReadWrite.All`.

1. Have an authorized administrator grant consent to these permissions. For information about admin consent, see [Permissions and consent in the Microsoft identity platform](~/identity-platform/permissions-consent-overview.md).
1. Install the Microsoft Graph PowerShell authentication module and sign in with the management app. `Connect-MgGraph` opens a browser for the signed-in user:

    ```powershell
    Install-Module Microsoft.Graph.Authentication -Scope CurrentUser

    Connect-MgGraph `
      -ClientId "<management-app-client-id>" `
      -TenantId "<tenant-id>" `
      -Scopes "AgentIdentityBlueprint.ReadWrite.All", "AgentIdentity.ReadWrite.All" `
      -ContextScope Process

    $context = Get-MgContext
    if (-not $context -or -not $context.Account) {
        throw "Microsoft Graph sign-in didn't establish a delegated management context. Stop before creating objects."
    }
    $context | Select-Object Account, TenantId, ClientId, Scopes
    ```

    Confirm that `Account`, `TenantId`, and `ClientId` identify the intended operator, tenant, and management app, and that `Scopes` includes both permissions. If a scope is missing or consent is requested again, stop and have an authorized administrator verify the app registration and consent before continuing.

On Windows, if `Connect-MgGraph` fails before sign-in with **A window handle must be configured**, use the [documented browser sign-in option](/powershell/module/microsoft.graph.authentication/set-mggraphoption) for your custom management client:

```powershell
Set-MgGraphOption -DisableLoginByWAM $true
```

Run the same `Connect-MgGraph` command again. This changes the authentication UI, not the tenant's access requirements; complete sign-in as the authorized operator and don't bypass a compliance denial. The setting persists across PowerShell sessions. If WAM was enabled before this change, restore it with `Set-MgGraphOption -DisableLoginByWAM $false` when you're done.

Use `Invoke-MgGraphRequest` to run the HTTP examples without copying or displaying an access token. For example, copy the JSON body from **Create the blueprint** into `$body`, replacing the sponsor placeholder:

```powershell
$body = @'
<JSON-request-body>
'@

$blueprint = Invoke-MgGraphRequest -Method POST `
    -Uri "https://graph.microsoft.com/beta/applications" `
    -Headers @{ "OData-Version" = "4.0" } `
    -ContentType "application/json" -Body $body

$blueprintObjectId = $blueprint.id
$agentClientId = $blueprint.appId
```

For later requests, use the method, full URI, headers, and JSON body shown in each HTTP example. Omit `-Body` for a GET request. The module supplies the authorization header. For command syntax, see [Invoke-MgGraphRequest](/powershell/module/microsoft.graph.authentication/invoke-mggraphrequest).

If registration or consent is denied, ask your tenant administrator to complete this setup. Don't grant these management permissions to the agent to work around an authorization error.

## Create the blueprint

The blueprint is the registration that holds your agent's authentication settings and credentials.

1. Create the blueprint with `isSingleInstance` set to `true`. Replace `<sponsor-user-object-id>` with the sponsor's object ID. A sponsor is required; the owner assignment is optional.

    Keep `isSingleInstance: true` for this tutorial: it creates one identity for the agent, including its installations or replicas. This property can't be changed after creation.

    ```http
    POST https://graph.microsoft.com/beta/applications
    OData-Version: 4.0
    Content-Type: application/json

    {
      "@odata.type": "Microsoft.Graph.AgentIdentityBlueprint",
      "displayName": "Contoso Operations Agent",
      "signInAudience": "AzureADMyOrg",
      "isSingleInstance": true,
      "sponsors@odata.bind": [
        "https://graph.microsoft.com/v1.0/users/<sponsor-user-object-id>"
      ],
      "owners@odata.bind": [
        "https://graph.microsoft.com/v1.0/users/<sponsor-user-object-id>"
      ]
    }
    ```

1. From the `201 Created` response, save the following values:

    - `id`: The blueprint's object ID, used to address it in Microsoft Graph.
    - `appId`: The application (client) ID, used in OAuth requests.

The example creates a single-tenant blueprint with `signInAudience` set to `AzureADMyOrg`.

## Provision the agent identity

Create the identity separately from its blueprint registration. Follow the request below directly; this setup doesn't require a blueprint principal.

1. Create the Agent ID. Set `agentIdentityBlueprintId` to the blueprint's **object ID**, not its `appId`.

    ```http
    POST https://graph.microsoft.com/beta/servicePrincipals/microsoft.graph.agentIdentity
    OData-Version: 4.0
    Content-Type: application/json

    {
      "displayName": "Contoso Operations Agent",
      "agentIdentityBlueprintId": "<blueprint-object-id>",
      "sponsors@odata.bind": [
        "https://graph.microsoft.com/v1.0/users/<sponsor-user-object-id>"
      ]
    }
    ```

1. Save the identity's `id` from the `201 Created` response. This is the agent identity's object ID, not the blueprint object ID or OAuth client ID.
1. Read the identity to verify the result:

    ```http
    GET https://graph.microsoft.com/beta/servicePrincipals/<agent-identity-object-id>?$select=id,appId,displayName,agentIdentityBlueprintId,instanceMode
    ```

    Check the returned values:

    | Property | Expected value |
    | --- | --- |
    | `@odata.type` | `#microsoft.graph.agentIdentity`. |
    | `appId` | The blueprint's `appId`. |
    | `agentIdentityBlueprintId` | The blueprint's object ID. |
    | `instanceMode` | `singleInstance`. |

Don't provision a new identity for each installation, process, or user session. They use the same client ID.

## Configure redirect URIs

For authorization code flow, register the redirect URI under the platform that matches the client. A confidential client uses `web`; a public client uses `publicClient`.

The [browser-based administrator consent procedure](authenticate-single-instance-agent.md#grant-application-permissions) also requires a `web` redirect URI, even for an agent that only uses client credentials at runtime. The redirect handles the consent callback, not the client credentials token request. Skip this section only if neither authorization code flow nor browser-based administrator consent is needed.

1. Read the current redirect configuration:

    ```http
    GET https://graph.microsoft.com/beta/applications/<blueprint-object-id>?$select=id,appId,web,publicClient
    ```

1. Update the appropriate redirect collection. The following example shows both client types; include only the platforms your agent uses. Keep all existing redirect URIs that are still needed.

    ```http
    PATCH https://graph.microsoft.com/beta/applications/<blueprint-object-id>
    OData-Version: 4.0
    Content-Type: application/json

    {
      "@odata.type": "#microsoft.graph.agentIdentityBlueprint",
      "web": {
        "redirectUris": [
          "https://agent.contoso.com/signin"
        ]
      },
      "publicClient": {
        "redirectUris": [
          "http://localhost"
        ]
      }
    }
    ```

    A successful update returns `204 No Content`. Redirect URI collections are replaced, not appended. Don't copy this example over an existing configuration without preserving its URIs.

The same blueprint can register both platforms. Each authorization request uses the redirect URI for its client type. A public client doesn't send a credential, even if a confidential component uses a certificate on the same blueprint. Don't change `isFallbackPublicClient` to switch between these authorization-code scenarios.

## Add a certificate for confidential clients

For local confidential-client testing, register only the public certificate on the blueprint. The runtime keeps the private key for authentication.

Skip this section for a public-only client. For an Azure-hosted agent using managed identity federation, [configure the federated credential](create-blueprint.md#configure-credentials-for-the-agent-identity-blueprint) instead, then continue with **Declare the API permissions**.

For a Windows development machine, you can [create a self-signed certificate](~/identity-platform/howto-create-self-signed-certificate.md) and export its public certificate and password-protected PFX. Keep the PFX outside your source tree. Use the Base64-encoded DER public certificate for `key` below, not the PFX or a PEM file's header and footer. For example:

```powershell
$publicCertificate = Get-PfxCertificate -FilePath "<absolute-path-to-public-cer>"
$publicCertificateBase64 = [Convert]::ToBase64String($publicCertificate.RawData)
```

Paste `$publicCertificateBase64` into the registration request. The public value isn't a credential; the PFX and its password are. For non-Windows development or production, use your organization's certificate issuance and private-key storage process.

1. Read the current certificate collection:

    ```http
    GET https://graph.microsoft.com/beta/applications/<blueprint-object-id>?$select=id,appId,keyCredentials
    ```

1. Add your public certificate while retaining any existing key credentials that are still needed. The following request shows an initial registration with no existing certificates:

    ```http
    PATCH https://graph.microsoft.com/beta/applications/<blueprint-object-id>
    OData-Version: 4.0
    Content-Type: application/json

    {
      "@odata.type": "#microsoft.graph.agentIdentityBlueprint",
      "keyCredentials": [
        {
          "type": "AsymmetricX509Cert",
          "usage": "Verify",
          "key": "<base64-encoded-DER-certificate>",
          "displayName": "Contoso Operations Agent certificate"
        }
      ]
    }
    ```

    A successful update returns `204 No Content`. Never upload the private key or distribute it with a public client.

For certificate format and client assertion guidance, see [Microsoft identity platform certificate credentials](~/identity-platform/certificate-credentials.md).

## Declare the API permissions

Declare only the permissions the agent needs. Use `Scope` for a delegated permission and `Role` for an application permission. The values in `resourceAccess` are permission IDs exposed by the resource application, not permission names.

1. Read the current declarations:

    ```http
    GET https://graph.microsoft.com/beta/applications/<blueprint-object-id>?$select=id,appId,requiredResourceAccess
    ```

1. Add the resource and permission entries, preserving existing declarations that are still needed. The example shows one delegated permission and one application permission; remove either entry if your agent doesn't need it.

    ```http
    PATCH https://graph.microsoft.com/beta/applications/<blueprint-object-id>
    OData-Version: 4.0
    Content-Type: application/json

    {
      "@odata.type": "#microsoft.graph.agentIdentityBlueprint",
      "requiredResourceAccess": [
        {
          "resourceAppId": "<resource-app-id>",
          "resourceAccess": [
            {
              "id": "<delegated-permission-id>",
              "type": "Scope"
            },
            {
              "id": "<app-role-id>",
              "type": "Role"
            }
          ]
        }
      ]
    }
    ```

    A successful update returns `204 No Content`.

These declarations don't grant access. User or administrator consent grants delegated permissions, and an administrator grants application permissions. Grants belong to the Agent ID directly.

If the agent also receives calls from a front-end application, [expose an identifier URI and delegated scope on the blueprint](create-blueprint.md#configure-identifier-uri-and-scope). Preserve any existing API scopes and set `requestedAccessTokenVersion` to `2`. The front end requests that scope to obtain a token whose audience is the shared client ID.

## Troubleshoot Graph requests

If a request fails, inspect the HTTP status and the Graph error response before changing permissions or retrying the operation.

| Response | Check |
| --- | --- |
| `400 Bad Request` | Read `error.code` and `error.message`. Check the endpoint's request schema, required sponsor references, object IDs, and property values. |
| `401 Unauthorized` | Acquire a valid access token for Microsoft Graph and send it in the `Authorization` header. |
| `403 Forbidden` | Confirm the management app has the required delegated permissions and admin consent, the signed-in user is authorized for the operation, and the tenant is enabled for the preview. |

For details, see [Microsoft Graph error responses](/graph/errors). When you contact an administrator or Microsoft support, include the HTTP status, error code, and `request-id` response header. Don't include access tokens or other credentials.

## Next step

Return to the tutorial that brought you here:

- [Authenticate users to an ASP.NET Core agent API](aspnet-core-authenticate-users.md).
- [Call a custom API as an agent with ASP.NET Core](call-api-custom.md).
- [Configure the Auth SDK sidecar](microsoft-entra-sdk-for-agent-identities.md).
- [Sign in users from an agent on an end-user device](authenticate-local-agent.md).

For direct OAuth requests and the identity model behind this setup, see [Authenticate the agent identity](authenticate-single-instance-agent.md) and [Agent identity blueprint instance modes](agent-blueprint.md#instance-modes-preview).
