---
 
ms.service: entra
 
ms.topic: include
ms.date: 11/05/2026
ai-usage: ai-assisted
ms.custom: include file
# Purpose:
# To define the difference between interactive and autonomous agents in the context of agent identities.
---
### Interactive agents

Interactive agents perform tasks on behalf of a signed-in user, often through a chat interface. Examples include analyzing customer data or answering support questions. Delegated permissions limit access to the permissions granted to the client and the user's own access. A local public client uses authorization code flow with PKCE. A hosted agent API receiving a user token uses the on-behalf-of (OBO) flow to call a downstream API as that user.

### Autonomous agents

Autonomous agents operate independently using their own identity, not a human user's identity. These agents run in the background, making decisions and taking actions without human intervention, such as monitoring network logs for security operations, managing infrastructure deployments with autoscaling, or processing scheduled maintenance tasks. Autonomous agents authenticate directly with the Microsoft Entra ID platform using their agent identity and the client credentials flow.

### Agent's user account

An agent's user account is an optional account that pairs 1:1 with an agent identity. It functions with human user characteristics, including persistent identities and access to organizational resources such as mailboxes, calendars, Teams channels, and documents. Use an agent's user account only when the agent must access systems that require a user object. An agent's user account doesn't replace the agent identity — both must exist. For more information, see [Agent's user accounts](../agent-users.md).