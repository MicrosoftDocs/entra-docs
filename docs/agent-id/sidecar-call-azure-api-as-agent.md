---
title: Call Azure services as an agent with the Auth SDK sidecar
description: Use an app-only Agent ID token from the Auth SDK sidecar to call an Azure service.
titleSuffix: Microsoft Entra Agent ID
ms.topic: how-to
ms.date: 11/06/2026
ai-usage: ai-assisted
ms.reviewer: dastrock
---

# Call Azure services as an agent with the Auth SDK sidecar

Use this pattern when an autonomous agent needs access to an Azure service that accepts Microsoft Entra application tokens.

## Prerequisites

- Completion of [Configure the Auth SDK sidecar](microsoft-entra-sdk-for-agent-identities.md), including the agent's registration and client ID.
- A resource group and subscription where an administrator can assign the Agent ID an Azure role.

## Configure access

1. Assign the Azure built-in **Reader** role to the Agent ID at the target resource group scope.
1. Configure the Azure service in the sidecar with its resource scope. For Azure Resource Manager, use `https://management.azure.com/.default`.
1. Record the sidecar API configuration name.

For this example, Azure Resource Manager uses Azure RBAC: the Agent ID's **Reader** assignment authorizes the read. The `/.default` scope requests an app-only token for Azure Resource Manager; it isn't an Azure role or an additional OAuth permission grant.

## Configure the sidecar

The following profile requests app-only tokens for Azure Resource Manager with the configured client ID:

```json
{
  "DownstreamApis": {
    "azure-management": {
      "BaseUrl": "https://management.azure.com/",
      "Scopes": [
        "https://management.azure.com/.default"
      ],
      "RequestAppToken": true
    }
  }
}
```

For another Azure service, replace the base URL and scope with the values documented by that service. For the blueprint identity, credential, and container configuration, see [Configure the Auth SDK sidecar](microsoft-entra-sdk-for-agent-identities.md).

## Read a resource group

This example uses Node.js 18 or later and the built-in Fetch API. Run it in the agent container, which shares the sidecar's loopback network namespace. Set `subscriptionId` and `resourceGroupName` to the target resource group.

The sidecar request uses the configured app-only profile:

```http
GET /AuthorizationHeaderUnauthenticated/azure-management
```

```javascript
async function getResourceGroupAsAgent(subscriptionId, resourceGroupName) {
  const tokenResponse = await fetch("http://localhost:5000/AuthorizationHeaderUnauthenticated/azure-management");
  if (!tokenResponse.ok) {
    throw new Error(`Sidecar token request failed (HTTP ${tokenResponse.status}); check the profile and blueprint credential.`);
  }
  const { authorizationHeader } = await tokenResponse.json();

  const url = `https://management.azure.com/subscriptions/${encodeURIComponent(subscriptionId)}/resourceGroups/${encodeURIComponent(resourceGroupName)}?api-version=2021-04-01`;
  const response = await fetch(url, { headers: { Authorization: authorizationHeader } });
  if (!response.ok) {
    throw new Error(`Azure Resource Manager returned HTTP ${response.status}; verify the Agent ID's Reader role at this resource group.`);
  }
  return response.json();
}
```

Call `getResourceGroupAsAgent(subscriptionId, resourceGroupName)` from the agent. A successful request returns `200 OK` with the resource group's name, ID, and location. A `403` from Azure Resource Manager means the Agent ID lacks access at that scope; assign **Reader** to the Agent ID on this resource group and retry after the role assignment takes effect. If the sidecar returns `401`, check the credential and `azure-management` profile. Don't pass an identity override. Request a separate token for each different API audience.

The [Resource Groups - Get API](/rest/api/resources/resource-groups/get?view=rest-resources-2021-04-01&preserve-view=true) documents this request and its `200 OK` response. The Azure built-in [Reader role](/azure/role-based-access-control/built-in-roles/general#reader) grants read-only access at the scope where you assign it.

## Next step

[Authenticate users to the agent](sidecar-authenticate-users.md)

## Related content

- [Azure role-based access control](/azure/role-based-access-control/overview)
- [Auth SDK sidecar endpoint reference](/entra/msidweb/agent-id-sdk/endpoints)
