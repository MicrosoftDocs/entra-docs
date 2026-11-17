---
title: Create and delete an agent's user account
description: Learn how to create and delete an agent's user account using the Microsoft Graph API.
titleSuffix: Microsoft Entra Agent ID
ms.topic: how-to
ms.date: 10/29/2026
ms.reviewer: dastrock

#customer-intent: As a developer or IT administrator, I want to create an agent's user account so that my agent can act as a digital worker in Microsoft Entra.
---

# Create and delete an agent's user account

An agent's user account is a specialized identity that lets an agent act as a digital worker—appearing to other systems as a user identity rather than a service principal. Agent user accounts aren't created automatically. You must explicitly create one and associate it with a specific agent identity.

For background on what an agent's user account is and when to use one, see [The agent's user account in Microsoft Entra Agent ID](agent-users.md).

> [!NOTE]
> Creating an agent's user account through the Microsoft Graph API establishes the identity in Microsoft Entra but doesn't provision Microsoft 365 capabilities such as a mailbox or Teams presence. To provision a full digital worker with Microsoft 365 capabilities, create the agent through Microsoft Teams using the Agent 365 SDK.

## Prerequisites

- An [agent identity blueprint](create-blueprint.md) and at least one [agent identity](create-delete-agent-identities.md) created from it. Record the agent identity's object ID.
- The blueprint app registration must have the `AgentIdUser.ReadWrite.IdentityParentedBy` application permission granted with admin consent. See [Grant the blueprint permission to create agent user accounts](#grant-the-blueprint-permission-to-create-agent-user-accounts).
- An access token for the blueprint app registration with `https://graph.microsoft.com/.default` scope. The blueprint authenticates to Microsoft Graph to create and delete agent user accounts on behalf of the agent identity it parents.

The `identityParentId` value is the agent identity's object ID. The agent user's separate `id` is used to delete the user account. For identifier meanings, see [Record the identifiers for your scenario](key-concepts.md#record-the-identifiers-for-your-scenario).

## Grant the blueprint permission to create agent user accounts

The blueprint app registration doesn't have permission to create agent user accounts by default. Add the `AgentIdUser.ReadWrite.IdentityParentedBy` application permission and grant admin consent before calling the creation API.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com).
1. Browse to **Entra ID** > **App registrations** and open the blueprint app registration.
1. Select **API permissions** > **Add a permission** > **Microsoft Graph** > **Application permissions**.
1. Search for and select `AgentIdUser.ReadWrite.IdentityParentedBy`.
1. Select **Add permissions**, then select **Grant admin consent**.

## Create an agent's user account

Create the agent's user account and associate it with an agent identity in a single call. The `identityParentId` property establishes the immutable 1:1 relationship between the user account and its parent agent identity.

```http
POST https://graph.microsoft.com/v1.0/users/microsoft.graph.agentUser
Content-Type: application/json
Authorization: Bearer <blueprint-access-token>

{
  "accountEnabled": true,
  "displayName": "Sales Agent",
  "mailNickname": "SalesAgent",
  "userPrincipalName": "salesagent@contoso.com",
  "identityParentId": "<agent-identity-object-id>"
}
```

| Property | Description |
| --- | --- |
| `accountEnabled` | Set to `true` to enable the account immediately. |
| `displayName` | Display name shown in the directory. |
| `mailNickname` | Alias used when provisioning a mailbox. Must be unique in the tenant. |
| `userPrincipalName` | Sign-in name in `user@domain` format. Must use a verified domain in the tenant. |
| `identityParentId` | Object ID of the agent identity that owns this user account. This value is immutable after creation. |

A successful request returns `201 Created` with the new agent user object:

```json
{
  "@odata.type": "#microsoft.graph.agentUser",
  "id": "87d349ed-44d7-43e1-9a83-5f2406dee5bd",
  "displayName": "Sales Agent",
  "mailNickname": "SalesAgent",
  "userPrincipalName": "salesagent@contoso.com",
  "identityParentId": "<agent-identity-object-id>"
}
```

Record the `id` value. You need it to configure the agent's user account flow in your agent and to delete the account later.

## Delete an agent's user account

When the agent is decommissioned, delete the user account to remove it from the directory.

```http
DELETE https://graph.microsoft.com/v1.0/users/microsoft.graph.agentUser/<agent-user-id>
Authorization: Bearer <blueprint-access-token>
```

A successful request returns `204 No Content`. The agent identity itself is not deleted by this call. To also remove the agent identity, see [Create and delete agent identities](create-delete-agent-identities.md).

## Related content

- [The agent's user account in Microsoft Entra Agent ID](agent-users.md)
- [Use an agent's user account with Microsoft 365 (ASP.NET Core)](agent-user-oauth-flow.md)
- [Use an agent's user account with Microsoft 365 (Auth SDK sidecar)](sidecar-call-microsoft-365-as-agent-user.md)
- [Create and delete agent identities](create-delete-agent-identities.md)
