---
title: Call Azure services as a user with the Auth SDK sidecar
description: Use the Auth SDK sidecar and On-Behalf-Of flow to call an Azure service for the signed-in user.
titleSuffix: Microsoft Entra Agent ID
ms.topic: how-to
ms.date: 11/06/2026
ai-usage: ai-assisted
ms.reviewer: dastrock
---

# Call Azure services as a user with the Auth SDK sidecar

Use this pattern when an Azure service supports delegated access and should evaluate the signed-in user's permissions.

## Prerequisites

- Completion of [Authenticate users with the Auth SDK sidecar](sidecar-authenticate-users.md), including consent for the upstream client to call the agent.
- A target Azure resource group, and an administrator who can assign the signed-in user an Azure role on it.

## Configure access

1. Assign the signed-in user the Azure built-in **Reader** role at the target resource group scope.
1. Declare the Azure Resource Manager delegated permission `user_impersonation` on the blueprint and [grant consent to the agent identity](grant-agent-access-microsoft-365.md).
1. Configure the Azure Resource Manager audience and `user_impersonation` scope in the sidecar.

This example uses both authorization systems: `user_impersonation` lets the agent request an Azure Resource Manager token on behalf of the user, and the user's **Reader** role allows the read at the resource group scope. Some Azure services accept only application tokens; use [app-only access](sidecar-call-azure-api-as-agent.md) for those services.

## Configure the sidecar

The following profile requests delegated tokens for Azure Resource Manager:

```json
{
  "DownstreamApis": {
    "azure-management": {
      "BaseUrl": "https://management.azure.com/",
      "Scopes": [
        "https://management.azure.com/user_impersonation"
      ]
    }
  }
}
```

For another Azure service, replace the base URL and scope with the values documented by that service. Use the shared client ID and keep identity overrides disabled as described in [Configure the Auth SDK sidecar](microsoft-entra-sdk-for-agent-identities.md).

## Read a resource group as the signed-in user

This example uses Node.js 18 or later and the built-in Fetch API. Pass the access token issued to the signed-in user for your agent API to the function. Don't pass an ID token or an app-only token.

The sidecar request uses the configured delegated profile and the inbound user token:

```http
GET /AuthorizationHeader/azure-management
Authorization: Bearer <agent-api-access-token>
```

```javascript
async function getResourceGroupAsUser(agentApiAccessToken, subscriptionId, resourceGroupName) {
  const tokenResponse = await fetch("http://localhost:5000/AuthorizationHeader/azure-management", {
    headers: { Authorization: `Bearer ${agentApiAccessToken}` }
  });
  if (!tokenResponse.ok) {
    throw new Error(`Sidecar token request failed (HTTP ${tokenResponse.status}); check the inbound user token and delegated consent.`);
  }
  const { authorizationHeader } = await tokenResponse.json();

  const url = `https://management.azure.com/subscriptions/${encodeURIComponent(subscriptionId)}/resourceGroups/${encodeURIComponent(resourceGroupName)}?api-version=2021-04-01`;
  const response = await fetch(url, { headers: { Authorization: authorizationHeader } });
  if (!response.ok) {
    throw new Error(`Azure Resource Manager returned HTTP ${response.status}; verify the signed-in user's Reader role at this resource group.`);
  }
  return response.json();
}
```

Call `getResourceGroupAsUser(agentApiAccessToken, subscriptionId, resourceGroupName)` while handling that user's request. A successful request returns `200 OK` with the resource group's name, ID, and location. A `403` from Azure Resource Manager means the signed-in user lacks access at that scope; assign **Reader** to that user on this resource group and retry after the role assignment takes effect. If the sidecar returns `401`, verify that the inbound token is for the agent API and that `user_impersonation` consent is in place. After changing consent, retry with a newly issued agent API access token. Don't switch to the unauthenticated endpoint: it would call as the Agent ID, not as the user.

The [Resource Groups - Get API](/rest/api/resources/resource-groups/get?view=rest-resources-2021-04-01&preserve-view=true) documents this request and its `200 OK` response. The Azure built-in [Reader role](/azure/role-based-access-control/built-in-roles/general#reader) grants read-only access at the scope where you assign it.

## Related content

- [Microsoft identity platform On-Behalf-Of flow](/entra/identity-platform/v2-oauth2-on-behalf-of-flow)
- [Azure role-based access control](/azure/role-based-access-control/overview)
