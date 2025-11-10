---
author: SHERMANOUKO
ms.author: shermanouko
ms.date: 11/04/2025
ms.custom: agent-id-ignite
ms.service: entra-id

ms.topic: include
# Purpose:
# To guide users on how to call APIs using agent identities in .NET.
---

To call an API from an agent, you need to obtain an access token that the agent can use to authenticate itself to the API. We recommend using the *Microsoft.Identity.Web* SDK for .NET to call your web APIs. This SDK simplifies the process of acquiring and validating tokens. For other languages, use the [Microsoft Entra agent SDK for agent ID](/entra/msidweb/agent-id-sdk/overview).

## Prerequisites

- An agent identity with appropriate permissions to call the target API. You need a user for the on-behalf-of flow.
- An agent user with appropriate permissions to call the target API.
