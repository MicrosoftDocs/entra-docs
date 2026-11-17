---
ms.date: 11/05/2026
ai-usage: ai-assisted
ms.topic: include
# Purpose:
# To provide information about managed identities support for agent identities.
---

## Managed identities integration

For Azure-hosted agents, prefer a managed identity when the hosting service provides one. Its token authenticates the parent blueprint through a configured federated identity credential; configuring the managed identity alone doesn't grant API access to the agent. A local developer's Azure CLI sign-in isn't a managed identity. For hosting requirements and local credential alternatives, see [Configure blueprint credentials](../create-blueprint.md#configure-credentials-for-the-agent-identity-blueprint).
