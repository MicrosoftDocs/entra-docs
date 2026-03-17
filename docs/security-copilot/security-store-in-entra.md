---
title: Discover and deploy agents and solutions in Microsoft Entra
description: Learn how to use Security Store in Microsoft Entra to discover, purchase, and deploy AI agents and security solutions for identity and access management.
author: shlipsey3
ms.author: sarahlipsey
ms.date: 03/17/2026
ms.update-cycle: 180-days
ms.topic: how-to
ms.service: entra
ms.custom: security-copilot
ms.collection: msec-ai-copilot
ai-usage: ai-assisted
#Customer intent: As an IT administrator or security professional, I want to discover and deploy AI agents and security solutions from the Security Store in the Microsoft Entra admin center so that I can enhance identity and access management in my organization.
---

# Discover and deploy agents and solutions in Microsoft Entra

[Security Store](/security/store/what-is-security-store) in the Microsoft Entra admin center offers agents and integrated solutions that can help you perform identity and access management tasks efficiently. These offerings include [Microsoft Security Copilot agents](/copilot/security/agents-overview) published by Microsoft and approved partners. Security Store also provides non-agentic solutions that integrate with Microsoft Entra products and can deliver capabilities such as advanced fraud prevention directly into your identity workflows.

This article explains how to discover and deploy AI agents and solutions in Microsoft Entra.

> [!NOTE]
> To learn more about publishing agents to Security Store, see [Publish agents to Microsoft Security Store](/security/store/publish-a-security-copilot-agent-or-analytics-solution-in-security-store).

## Prerequisites

To purchase and deploy agents and solutions from Security Store, you need:

- [Access to a Security Copilot workspace provisioned with SCU capacity](/copilot/security/get-started-security-copilot).
- For partner-published agents and solutions, you need the [Azure subscription contributor or owner role](/marketplace/roles-permissions).

## Discover and deploy agents and solutions in the Microsoft Entra admin center

Security Store is embedded in the Microsoft Entra admin center, so you can discover and deploy agents and solutions without leaving your identity management workflow.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a []().
1. Browse to **Security Store**.
1. Browse or search for the agent or solution you want to deploy.
    - Use the **All** and **Agent** tabs to filter results.
1. Select the agent or solution to view its details, including capabilities, requirements, and setup instructions.
1. To purchase and deploy the agent or solution:
    - Select **Get agent** or **Get solution** to begin the deployment process if you have sufficient permissions.
    - Select **Copy link** to copy the details page URL and share it with a security administrator, if you don't have permissions to deploy agents or solutions.
    - For partner-published agents, complete the purchase and deploy on the [Security Store website](https://securitystore.microsoft.com/), as described in the [Microsoft Security Store documentation](/security/store/get-agents-in-security-store).

    > [!TIP]
    > You can manage centralized purchases for partner-published agents through public offers, or through private offers, as described in [How to purchase SaaS solutions (private offers)](/security/store/how-to-purchase-saas-solutions-private-offers).

1. After purchasing an agent, select **Security Copilot** > **Agents**, find your agent in the **Ready for setup** section, and then select **Set up** to begin agent setup.

    For more information on setting up, managing, and running partner-published agents, see [Manage Security Copilot agents](/copilot/security/agents-manage#set-up-for-partner-built-agents).

    For more information on Microsoft Entra agents, see [Microsoft Entra agents](entra-agents.md).

    After setup, the agent appears in the **Agents in use** section.

## Available solutions in the Security Store

The following solutions are available through Security Store in the Microsoft Entra admin center.

### Verified ID solutions

[Microsoft Entra Verified ID](/entra/verified-id/) solutions available in the Security Store provide advanced fraud prevention capabilities. These solutions integrate directly into your identity verification workflows, enabling enhanced trust and security for credential issuance and verification scenarios.

### External ID solutions

[Microsoft Entra External ID](/entra/external-id/) solutions available in the Security Store deliver WAF and bot defense to strengthen your organization's edge protection. These solutions help secure customer-facing applications and protect against automated threats targeting your external identity infrastructure.

## Available agents in the Security Store

Security Store includes Microsoft Entra agents that automate identity and access management tasks. For a complete list of available agents, their capabilities, required permissions, and setup instructions, see [Microsoft Entra agents](entra-agents.md).

## Manage and remove agents

Agents deployed from Security Store are managed through [Microsoft Security Copilot](/copilot/security/microsoft-security-copilot). To manage or remove an agent:

- To manage agent settings, go to **Security Copilot** > **Agents** and select the agent you want to configure.
- To remove an agent, perform the removal in Security Copilot. Removing the agent in Security Copilot stops entitlement checks and billing.
- For partner-published agents, review billing and entitlement details in **Security Store** > **Management** > **My Solutions**.

For more information, see [Manage Security Copilot agents](/copilot/security/agents-manage).

## Related content

- [What is Microsoft Security Store?](/security/store/what-is-security-store)
- [Get agents in Microsoft Security Store](/security/store/get-agents-in-security-store)
- [Microsoft Entra agents](entra-agents.md)
- [Security Copilot in Microsoft Entra](security-copilot-in-entra.md)
- [Deploy AI agents in Microsoft Defender](/defender-xdr/security-copilot-agents-defender)
