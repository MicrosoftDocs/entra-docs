---
title: "Configure Secure Web and AI Gateway for Microsoft Copilot Studio agents"
description: "Learn how to configure Secure Web and AI Gateway for Microsoft Copilot Studio agents using Global Secure Access."
author: garrodonnell
ms.author: godonnell
ms.service: global-secure-access
ms.topic: how-to
ms.date: 11/03/2025
ai-usage: ai-assisted
# Customer intent: As an IT administrator, I want to configure network security controls for Microsoft Copilot Studio agents so that I can apply security policies and monitor agent traffic.
---

# Configure Secure Web and AI Gateway for Microsoft Copilot Studio agents (preview)

Global Secure Access network controls enable you to implement granular access controls for Microsoft Copilot Studio agents. You can apply network security policies including web content filtering, threat intelligence filtering and network file filtering to agent traffic. This capability provides similar security controls for agents that you use for other traffic types in your organization.

Microsoft Entra integrates with Microsoft Copilot Studio to provide network security controls for agent interactions. This integration allows organizations to apply security policies, monitor agent traffic with the Global Secure Access visibility platform, and ensure secure communication between agents and external resources. 

## Prerequisites

To configure network security for Copilot Studio agents, you must have:

- A [Global Secure Access Administrator](../identity/role-based-access-control/permissions-reference.md#global-secure-access-administrator) role in Microsoft Entra ID to manage Global Secure Access features.
- A [Power Platform Administrator](/power-platform/admin/use-service-admin-role-manage-tenant) role to manage Copilot Studio environments.
- A Power Platform environment with Dataverse added to the environment. For more information, see [Create and manage environments in the Power Platform admin center](/power-platform/admin/create-environment).

## Enable network controls for Copilot Studio agents

To enable network controls for Copilot Studio agents, you must first enable traffic forwarding from these agents in the Power Platform Admin Center.

1. Sign in to the [Power Platform Admin Center](https://admin.powerplatform.microsoft.com) as a [Power Platform Administrator](/power-platform/admin/use-service-admin-role-manage-tenant).
1. Browse to **Security** > **Identity & access** > **Global Secure Access for Agents**.
1. Select the appropriate environment or environment group and select **Set up**.
1. Enable **Global Secure Access for Agents** for the selection.

:::image type="content" source="media/how-to-secure-web-ai-gateway-agents/screenshot-power-platform-gsa-agents-ui.png" alt-text="Screenshot of Power Platform Admin Center showing Global Secure Access for Agents setup page with environment selection and toggle enabled." lightbox="media/how-to-secure-web-ai-gateway-agents/screenshot-power-platform-gsa-agents-ui.png":::


> [!NOTE]
> After enabling GSA for Agents in a given environment or environment group, you need to create or update any existing custom connectors for them to route traffic through Global Secure Access.

## Create security policies for Copilot Studio agents

After enabling network controls, you can enforce Global Secure Access security policies on agent traffic. You can apply web content filtering, threat intelligence filtering, and other security policies. The following example shows how to configure a web content filtering policy:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as a [Global Secure Access Administrator](../identity/role-based-access-control/permissions-reference.md#global-secure-access-administrator).
1. Browse to **Global Secure Access** > **Secure** > **Web content filtering policies**.
1. Select **Create policy**.
1. Enter a descriptive name and a description for the policy, then select **Next**.
1. Select **Add rule**.
1. Configure rules based on your security to Copilot Studio agent requirements. For example, block access to `Web respositories`, `Illegal software`, not safe for work (NSFW) sites, and more.
1. Select **Next** to review the policy.
1. Select **Create policy**.

Next, you can create policies like [threat intelligence](how-to-configure-threat-intelligence.md) to protect agents against malicious destinations or [file policy](how-to-network-content-filtering.md) to safeguard against unintended data exposure and prevent inline data leaks.

## Link policies to the baseline profile

Group your security policies by linking them to the baseline profile to apply them to Copilot Studio agent traffic. Security profiles linked to Conditional Access policies aren't currently supported for Copilot Studio agents.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as a [Global Secure Access Administrator](../identity/role-based-access-control/permissions-reference.md#global-secure-access-administrator).
1. Browse to **Global Secure Access** > **Secure** > **Security profiles**.
1. Select the **Baseline profile** tab.
1. Select **Edit** to edit the baseline profile rules.
1. Select **Link a policy** and then select **Existing policy**.
1. Select the Copilot Studio agent web repositories policy created earlier and select **Add**.
1. Select **Save** to save the profile changes.

## Monitor and maintain

Regular monitoring and maintenance ensure your security configuration remains effective:

1. **Review traffic logs** regularly for unusual patterns or blocked legitimate traffic. For more information, see [Global Secure Access network traffic logs](how-to-view-traffic-logs.md).
1. **Update filtering policies** as new services or requirements emerge.
1. **Test policy changes** in a development environment before applying to production.

> [!NOTE]
> Configuration changes in the Global Secure Access experience related to web content filtering typically take effect in less than five minutes.

## Known limitations

- The enforcement feature supports only the baseline profile. Network security policies apply per tenant.
- Global Secure Access partner ecosystem integrations, such as third-party Data Loss Prevention (DLP), aren't supported.
- Copilot Studio Bing search network transactions (including knowledge from _public websites_ and _Wikipedia_) aren't supported.
- Network requests to Dataverse and Azure SQL knowledge sources aren't supported. 
- Network requests to the following custom tools aren't supported: prompt, agent flow, Computer Use, and child agents.
- Network requests to Large Language Model (LLM), either for orchestration or results enhancement, aren't supported.
- Only specific Copilot Studio connectors are supported with network security controls. Refer to the [Copilot Studio documentation](/power-platform/admin/security/secure-web-ai-gateway-agents) for the list of supported connectors.
- Currently the Agent Name returned in the Global Secure Access traffic logs is the agent's unique *schema name*.


## Next steps

- [Learn about Secure Web and AI Gateway for Microsoft Copilot Studio agents](concept-secure-web-ai-gateway-agents.md)
- [Configure web content filtering](how-to-configure-web-content-filtering.md)