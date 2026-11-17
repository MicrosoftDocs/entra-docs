---
ms.date: 11/05/2026
ai-usage: ai-assisted
ms.topic: include
# Purpose:
# To guide users on how to call APIs using agent identities in .NET.
---

To call an API from an agent, you need to obtain an access token that the agent can use to authenticate itself to the API. We recommend using the *Microsoft.Identity.Web* SDK for .NET to call your web APIs. This SDK simplifies the process of acquiring and validating tokens. For other languages, use the [Microsoft Entra ID Auth SDK (sidecar)](/entra/msidweb/agent-id-sdk/overview).

## Prerequisites

- An agent identity with the permissions required by the target API.
- For human-user OBO calls, a signed-in user's access token issued for the agent API, plus the required downstream delegated grant.
- Only for dedicated-agent-user calls, an agent's user account with the required resource access. App-only and human-user OBO calls don't require this account.
