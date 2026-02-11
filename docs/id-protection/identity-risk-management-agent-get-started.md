---
title: Identity Risk Management Agent
description: Learn about the Identity Risk Management Agent and its role in identifying and mitigating risks within Microsoft Entra ID Protection.

ms.topic: concept-article
ms.date: 12/01/2025
ms.reviewer: chuqiaoshi
---
# Identity Risk Management Agent (Preview)

IT administrators and security analysts face mounting pressure to identify and respond to threats quickly while managing increasingly complex environments. They're often overwhelmed by the sheer volume of alerts, struggle to prioritize which risks need immediate attention, and find it difficult to connect scattered data points across their organization's systems. The Identity Risk Management Agent with Security Copilot in Microsoft Entra helps these professionals investigate potential risks, understand their effect, and take decisive action to protect their organization's critical assets. 

> [!NOTE]
> The Identity Risk Management Agent is currently being deployed and in preview. This information relates to a prerelease product that might be substantially modified before it's released. Microsoft makes no warranties, expressed or implied, with respect to the information provided here.

## Prerequisites

- You must have at least the [Microsoft Entra ID P2](overview-identity-protection.md#license-requirements) license.
- You must have available [security compute units (SCU)](/copilot/security/manage-usage).
   - On average, each agent run consumes less than one SCU.
- You must have the appropriate Microsoft Entra role.
   - [Security Administrator](../identity/role-based-access-control/permissions-reference.md#security-administrator) is required to *activate the agent the first time* and *view the agent and take action on the suggestions*.
   - [Security Reader](../identity/role-based-access-control/permissions-reference.md#security-reader) and [Global Reader](../identity/role-based-access-control/permissions-reference.md#global-reader) roles can *view the agent and any suggestions, but can't take any actions*.
   - For more information, see [Assign Security Copilot access](/copilot/security/authentication#assign-security-copilot-access).
- Review [Privacy and data security in Microsoft Security Copilot](/copilot/security/privacy-data-security).

[!INCLUDE [entra-agent-id-license-note](../includes/entra-agent-id-license-note.md)]

### Known limitations

- Each agent run currently investigates up to 100 risky users. To customize the scope within this limitation, use the Agent Scope Setting. 
- Once an agent run starts, it can't be stopped or paused. It can take 10-15 minutes to finish the run on 100 users.  
- The agent currently analyzes user identity only. At this time, agent analysis on Workload Identities isn't supported. 
- Agent suggestions require manual admin approval. At this time, automatic remediation isn't supported.
- The agent reasons over Microsoft Entra data, such as sign-in logs, risk detections, risky users, and audit logs.
- Investigation summaries and recommendations are AI-generated and might be incomplete or incorrect. Review before enforcement and use human judgment when applying changes. 

## How it works

If the agent identifies new risky identities that weren't previously identified, it takes the following steps. **The initial scanning steps do not consume any SCUs.**

1. The agent checks for new risky users in your tenant who currently have a risk state of "At risk".
1. The agent identifies risky users that are within your defined [scope settings](identity-risk-management-agent-settings.md#scope).

If the agent identifies something that wasn't previously suggested, it takes the following steps. **These agent action steps consume SCUs.**

1. **Investigate the risky user**: The agent checks the user's risky sign-ins and risk detections to analyze what's risky about this user.
1. **Generate findings and a risk summary:** The agent generates findings based on the investigation, which includes a thorough risk summary explaining the suggestion and defining the key risk factors.
1. **Generate a recommended remediation action**: The agent suggests a remediation action, using the information gathered during the investigation.
1. **Answer questions through chat**: IT administrators ask the agent questions related to the risky users and the risk summary.
1. **Store custom instructions in agent memory**: Customers can give the agent custom instructions through agent chat, which the agent stores in its memory and applies for future runs. Currently, agent memory can store preferred remediation actions.

## Getting started

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Security Administrator](../identity/role-based-access-control/permissions-reference.md#security-administrator).

1. Browse to **ID Protection** > **Risky users**.
1. From the banner message at the top of the report, select **Start agent** to begin your first run. 
   - Avoid using an account with a role activated through PIM.
   - A message that says "The agent is starting its first run" appears in the upper-right corner.
   - The first run might take a few minutes to complete.