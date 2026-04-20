---
ms.topic: include
ms.date: 04/20/2026
ms.custom: include file
# Purpose:
# To define the difference between interactive and autonomous agents in the context of agent identities.
---
### Interactive agents

Interactive agents perform specific tasks on demand on behalf of a signed-in user often through a chat interface. Tasks include analyzing customer data for sales recommendations or answering support questions with escalation to human representatives. Interactive agents are granted Microsoft Entra delegated permissions that allow them to act on behalf of users.

### Autonomous agents

Autonomous agents operate independently using their own identity, not a human user's identity. These agents run in the background, making decisions and taking actions without human intervention, such as monitoring network logs for security operations or managing infrastructure deployments with autoscaling.

### Agent's user account

An agent's user account is an optional account that pairs 1:1 with an agent identity. It functions with human user characteristics, including persistent identities and access to organizational resources such as mailboxes, calendars, Teams channels, and documents. Use an agent's user account only when the agent must access systems that require a user object. An agent's user account doesn't replace the agent identity — both must exist. For more information, see [Agent's user accounts](agent-users.md).