---
title: Configure admin authorization for interactive agents
description: Learn how to configure interactive agents to request application permissions that require administrator consent through the admin consent flow.
titleSuffix: Microsoft Entra Agent ID
author: omondiatieno
ms.author: jomondi
ms.service: entra-id
ms.topic: how-to
ms.date: 11/04/2025
ms.custom: agent-id-ignite
ms.reviewer: dastrock

#customer-intent: As a developer, I want to configure my interactive agent to request application permissions that require admin consent, so that my agent can access resources with elevated privileges when approved by an administrator.
---

# Configure admin authorization for interactive agents

Agents often need to take actions on behalf of users that use the agent. To do so, interactive agents need to request delegated authorization from the user using the OAuth protocol. Agents can also request authorization from a Microsoft Entra ID administrator, who can grant authorization to the agent for all users in their tenant.

This article walks through the process of requesting consent from an administrator using the agent identity.

## Prerequisites

Before requesting admin authorization, ensure you have:

- [An agent identity](create-delete-agent-identities.md)
- An agent application configured for your agent identity
- Access token with `Application.ReadWrite.OwnedBy` delegated permission. Understand the difference between [delegated and application permissions](/entra/identity-platform/permissions-consent-overview)
- [Administrator access to grant consent](../identity-professional/grant-agent-access-microsoft-365.md) for application permissions

## Construct the authorization request URL

To grant delegated permissions, construct the authorization URL that is used to prompt the administrator. Be sure to use the agent identity ID in the following request.

```http
https://login.microsoftonline.com/contoso.onmicrosoft.com/v2.0/adminconsent
?client_id=<agent-identity-id>
&scope=User.Read
&redirect_uri=https://entra.microsoft.com/TokenAuthorize
&state=xyz123
```
## Related content

- [Request agent tokens](autonomous-agent-request-tokens.md) for implementing client credentials flow after consent
- [Configure user authorization](interactive-agent-request-user-authorization.md) for requesting delegated permissions
