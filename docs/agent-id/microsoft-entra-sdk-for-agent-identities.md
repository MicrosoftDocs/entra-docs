---
title: Configure the Microsoft Entra ID Auth SDK sidecar
description: Set up the Microsoft Entra ID Auth SDK sidecar to get tokens and call APIs.
titleSuffix: Microsoft Entra Agent ID
ms.topic: how-to
ms.date: 11/06/2026
ai-usage: ai-assisted
ms.reviewer: dastrock

#customer-intent: As an agent developer, I want to configure the Auth SDK sidecar so that my agent can securely acquire tokens for downstream APIs.
---

# Configure the Microsoft Entra ID Auth SDK sidecar

The Microsoft Entra ID Auth SDK sidecar is a companion service that handles authentication and token acquisition for your agent. It lets your cloud agent call APIs as itself or on behalf of signed-in users.

In this article, you configure the sidecar container, its blueprint credential, and downstream API access.

## Prerequisites

- Completion of [Create an identity for your agent](create-single-instance-agent.md), including tenant enablement, administrator approvals, and the recorded client and object IDs.
- A credential configured on the blueprint.
- Permissions granted to the Agent ID for each downstream API.
- A shared network namespace for the agent and sidecar, such as containers in the same pod.

## Add the sidecar container

Run the agent and sidecar in the same network namespace and call the sidecar through `localhost`. Production sidecar builds restrict callers to loopback; a private Docker bridge and a `sidecar` DNS name aren't sufficient. Containers in the same Kubernetes pod or Azure Container Apps app share this boundary. In Docker Compose, use `network_mode: "service:sidecar"` on the agent. Don't publish the sidecar port.

Use the credential configuration for where you run the container:

- **Local workstation:** Follow [Run the sidecar for local development](sidecar-local-development.md) for the sample container startup and development credential. Apply the network boundary above and the API profiles and override settings below.
- **Azure host:** Use the following configuration after assigning the managed identity to the host and configuring its federated credential on the blueprint. It doesn't provide a workstation credential.

The Docker Compose fragment illustrates the shared network layout and uses a user-assigned managed identity as the credential:

Set `AzureAd:ClientCredentials:0:SourceType` to `SignedAssertionFromManagedIdentity` and `AzureAd:ClientCredentials:0:ManagedIdentityClientId` to the user-assigned managed identity's client ID. This is a different value from the shared agent client ID in `AzureAd:ClientId`. Container environment variables use `__` in place of `:` in these configuration paths.

Record the tenant, blueprint, Agent ID, and API identifiers for your scenario in the [scenario identifier worksheet](key-concepts.md#record-the-identifiers-for-your-scenario) before configuring these values.

```yml
services:
  sidecar:
    image: mcr.microsoft.com/entra-sdk/auth-sidecar:1.1.3-azurelinux3.0-distroless
    environment:
      AzureAd__Instance: https://login.microsoftonline.com/
      AzureAd__TenantId: <tenant-id>
      AzureAd__ClientId: <agent-client-id>
      AzureAd__ClientCredentials__0__SourceType: SignedAssertionFromManagedIdentity
      AzureAd__ClientCredentials__0__ManagedIdentityClientId: <managed-identity-client-id>
      ASPNETCORE_URLS: http://localhost:5000

  agent:
    image: <agent-image>
    network_mode: "service:sidecar"
    environment:
      SIDECAR_URL: http://localhost:5000
```

Replace `<agent-image>` with your agent's image. This example pins the Linux sidecar to `1.1.3-azurelinux3.0-distroless`. For Windows, use the matching Windows tag from [Auth SDK sidecar container image tags](https://mcr.microsoft.com/v2/entra-sdk/auth-sidecar/tags/list).

Use `SignedAssertionFilePath` instead when the container receives a workload identity token from its orchestrator. Use `ClientSecret` only for local development. Don't place the blueprint credential in the agent container.

For other credential sources, see [Microsoft.Identity.Web credential descriptions](https://aka.ms/ms-id-web/credential-description).

## Configure a downstream API

Give each downstream API a short name. Configure its base URL, scopes, and token type. For example, this profile requests app-only tokens for Microsoft Graph:

```json
{
  "DownstreamApis": {
    "graph-app": {
      "BaseUrl": "https://graph.microsoft.com/v1.0/",
      "Scopes": [
        "https://graph.microsoft.com/.default"
      ],
      "RequestAppToken": true
    }
  }
}
```

The name becomes the `{apiName}` route value. This example uses `graph-app`, so the agent requests `/AuthorizationHeaderUnauthenticated/graph-app`.

The resource-specific articles provide the configuration for each API. To configure the container with environment variables, replace each `:` in the JSON path with `__`. For example:

```yml
environment:
  DownstreamApis__graph-app__BaseUrl: https://graph.microsoft.com/v1.0/
  DownstreamApis__graph-app__Scopes__0: https://graph.microsoft.com/.default
  DownstreamApis__graph-app__RequestAppToken: "true"
```

## Keep identity overrides disabled

Use the client ID recorded during setup directly. Don't pass `AgentIdentity`, `AgentUserId`, or `AgentUsername`: these select a different identity flow, not the cloud-agent setup in this article.

Keep overrides disabled on the endpoints used by the agent:

```json
{
  "Sidecar": {
    "AllowOverrides": {
      "GetAuthorizationHeader": false,
      "GetAuthorizationHeaderUnauthenticated": false,
      "CallDownstreamApi": false,
      "CallDownstreamApiUnauthenticated": false
    }
  }
}
```

Keep the sidecar accessible only through the shared loopback boundary even when overrides are disabled. The unauthenticated endpoints can acquire app-only tokens with the configured credential.

## Verify the sidecar

From the agent container in the shared network namespace, request `http://localhost:5000/healthz`:

```http
GET /healthz
```

The endpoint reports whether the sidecar is accepting requests. It doesn't verify the credential, consent, or downstream API access. Test token acquisition and a downstream call separately. Don't expose it as a public health endpoint.

## Choose an endpoint

| Operation | Endpoint |
| --- | --- |
| Validate an inbound access token and return its claims | `GET /Validate` |
| Get an authorization header using an inbound user token | `GET /AuthorizationHeader/{apiName}` |
| Get an authorization header without an inbound user token | `GET /AuthorizationHeaderUnauthenticated/{apiName}` |
| Have the sidecar call a configured downstream API | `POST /DownstreamApi/{apiName}` |
| Have the sidecar call a configured downstream API without an inbound user token | `POST /DownstreamApiUnauthenticated/{apiName}` |

Use the named downstream API profile without identity query parameters. For example, request `/AuthorizationHeaderUnauthenticated/graph-app` for app-only access or `/AuthorizationHeader/graph` with an inbound user token for OBO.

The authorization-header endpoints return an `authorizationHeader` value. Treat it as a credential and don't log it.

The profile name in the endpoint must match a name under `DownstreamApis`. The configuration above defines `graph-app`, so `/AuthorizationHeaderUnauthenticated/graph-app` is valid. It doesn't define a `graph` profile. To use `/AuthorizationHeader/graph` for OBO, configure a separate delegated `graph` profile as shown in [Call Microsoft Graph as a user](sidecar-call-graph-as-user.md). The endpoint path selects which identity supplies the token; the profile name selects the API configuration.

For complete request and response details, see the [Auth SDK sidecar endpoint reference](/entra/msidweb/agent-id-sdk/endpoints).
An unconfigured profile name returns `400 Bad Request`; correct the route name or add the matching `DownstreamApis` entry.

## Next steps

- [Run the sidecar for local development](sidecar-local-development.md).
- [Call a custom API as the agent](sidecar-call-custom-api-as-agent.md).
- [Authenticate users](sidecar-authenticate-users.md).
- [Review the sidecar source code](https://github.com/AzureAD/microsoft-identity-web/tree/master/src/Microsoft.Identity.Web.Sidecar).
- [Explore the official sidecar samples](https://github.com/microsoft/entra-agentid-samples/tree/dev/sidecar).
- [Build a platform that hosts an agent fleet](sidecar-fleet-provision-agent-identities.md).
