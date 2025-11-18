---
author: SHERMANOUKO
ms.author: shermanouko
ms.date: 11/04/2025
ms.custom: agent-id-ignite
ms.service: entra-id

ms.topic: include
# Purpose:
# To provide information about managed identities support for agent identities.
---

## Managed identities integration

Managed identities are the preferred credential type. In this configuration, the managed identity token serves as the credential for the parent agent identity blueprint, while standard MSI protocols apply for credential acquisition. This integration allows the agent ID to receive the full benefits of MSI security and management, including automatic credential rotation and secure storage.
