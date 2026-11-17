---
title: Run the Microsoft Entra ID Auth SDK sidecar locally
description: Run the Auth SDK sidecar and sample agent locally before deploying them to a hosted environment.
titleSuffix: Microsoft Entra Agent ID
ms.topic: how-to
ms.date: 11/06/2026
ai-usage: ai-assisted
ms.reviewer: dastrock

#customer-intent: As an agent developer, I want to run the Auth SDK sidecar locally so that I can test app-only and user-delegated Agent ID flows.
---

# Run the Auth SDK sidecar for local development

Use the official sidecar sample to test Agent ID authentication without placing Microsoft Entra credentials in the agent process. The sample includes an agent, the Auth SDK sidecar, and a protected weather API.

## Prerequisites

- Docker Desktop or another Docker Compose environment.
- A Microsoft Entra tenant.
- Completion of [Create an identity for your agent](create-single-instance-agent.md), including tenant enablement, administrator approvals, and the recorded client and object IDs.
- A development credential on the blueprint.

Use a client secret only for local testing. Use managed identity federation for hosted deployments.

## Get the sample

Clone the [Microsoft Entra Agent ID samples](https://github.com/microsoft/entra-agentid-samples) repository and open the `sidecar/dev` directory.

Use the sample's container layout with the [cloud-agent sidecar configuration](microsoft-entra-sdk-for-agent-identities.md). Set the client ID recorded during setup and the blueprint credential, and keep identity overrides disabled. Don't use sample flows with `AgentIdentity` or `AgentUserId` overrides. Don't commit the environment file or client secret.

## Start the sample

Start the containers by following the [`sidecar/dev` sample instructions](https://github.com/microsoft/entra-agentid-samples/tree/dev/sidecar/dev).

The agent must call the sidecar through `localhost` in a shared network namespace. Use the [Docker Compose configuration](microsoft-entra-sdk-for-agent-identities.md#add-the-sidecar-container), not separate containers communicating through a `sidecar` DNS name. Don't expose the sidecar port publicly.

Before testing, verify the sidecar with the [health check](microsoft-entra-sdk-for-agent-identities.md#verify-the-sidecar). It confirms the sidecar is accepting requests, not that credentials, consent, or API access are configured correctly.

## Understand the token flow

For app-only calls, the sidecar uses the configured Agent ID and API profile to acquire a token for the downstream resource. For delegated calls, the agent sends the signed-in user's access token to the sidecar, which exchanges it for a downstream token by using the OAuth on-behalf-of flow. The agent can request an authorization header or have the sidecar proxy the downstream API call.

## Test API access

Test these operations separately:

- **App-only:** The agent calls `AuthorizationHeaderUnauthenticated` for a named API without an `AgentIdentity` query parameter.
- **User-delegated:** The sample client signs in a user and passes the access token to the agent. The agent forwards it to the authenticated sidecar endpoint for OBO.
- **Token validation:** The protected API validates the access token's signature, issuer, audience, expiry, and Agent ID claims.

Verify that app-only tokens have application permissions and delegated tokens contain the expected user and scope claims.

## Move to a hosted environment

Before deployment:

- Replace the development secret with a managed identity federated credential.
- Keep sidecar traffic on loopback in the shared network namespace.
- Configure production redirect URIs and API audiences.
- Remove development-only ports and sample credentials.

## Next step

[Call a custom API as the agent](sidecar-call-custom-api-as-agent.md).

## Related content

- [Official sidecar samples](https://github.com/microsoft/entra-agentid-samples/tree/dev/sidecar)
- [Configure the Auth SDK sidecar](microsoft-entra-sdk-for-agent-identities.md)
- [Build a platform that hosts an agent fleet](sidecar-fleet-provision-agent-identities.md)
