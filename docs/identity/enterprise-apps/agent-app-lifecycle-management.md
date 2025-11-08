---
title: Get started with the Microsoft Entra App lifecycle management agent
description: Learn how the Microsoft Entra App lifecycle management agent with Microsoft Security Copilot helps streamline application discovery, onboarding, and risk remediation.
ms.author: jomondi
author: omondiatieno
manager: mwongerapk
ms.date: 11/04/2025
ms.custom: agent-id-ignite
ms.service: entra-id
ms.subservice: enterprise-apps
ms.topic: how-to
ms.reviewer: ariels
#customer intent: As an IT administrator, I want to implement automated application lifecycle management so that I can reduce security risks and streamline governance across my entire application portfolio.
---

# Get started with the Microsoft Entra App lifecycle management agent

The App lifecycle management agent helps identity and network administrators manage the entire lifecycle of applications within Microsoft Entra, from discovery to onboarding, ongoing monitoring, and risk remediation. The agent automates detection of unmanaged applications, assists with onboarding them into Microsoft Entra for centralized management, and continuously monitors app health and usage to proactively identify risks such as excessive privileges or unused high-risk applications.

By unifying application discovery and risk management capabilities into one intelligent agent embedded in the Microsoft Entra admin center, it delivers a seamless, end-to-end experience that saves time, reduces risk, and adapts to diverse organizational needs.

## Prerequisites

Before using the App lifecycle management agent, ensure you meet the following requirements:

- You must have at least the [Microsoft Entra ID P2 or Workload Identity Premium P2](/entra/fundamentals/licensing) for **App Risk Monitoring & Remediation** suggestions and/or Microsoft Entra Suite or [Microsoft Entra Private Access](../../global-secure-access/overview-what-is-global-secure-access.md#licensing-overview) licenses for **Application Discovery & Onboarding** suggestions.

- You must have available [security compute units (SCU)](/copilot/security/manage-usage).
   - On average, each agent run consumes less than one SCU.
- You must have one of the following Microsoft Entra roles:
- [Cloud Application Administrator](../role-based-access-control/permissions-reference.md#cloud-application-administrator), [Application Administrator](../role-based-access-control/permissions-reference.md#application-administrator), or [Security Administrator](../role-based-access-control/permissions-reference.md#security-administrator)
- [Reports Reader](../role-based-access-control/permissions-reference.md#reports-reader), [Global Secure Access Administrator](../role-based-access-control/permissions-reference.md#global-secure-access-administrator), [Security Reader](../role-based-access-control/permissions-reference.md#security-reader), and [Global Reader](../role-based-access-control/permissions-reference.md#global-reader) roles can *view the agent and any suggestions, but can't take any actions*.
- [Security Copilot Contributor](/copilot/security/authentication#assign-security-copilot-access) role in Security Copilot.
- For app owners to use the Microsoft Teams bot to respond to notifications from the App Lifecycle Management Agent, they must have access to Microsoft Teams and must have an active access review assigned to them. They must also have at least the [Security Copilot Contributor](/copilot/security/authentication#assign-security-copilot-access) role assigned to them.
- **Application Discovery & Onboarding suggestions only:** Microsoft Entra Internet Access and Microsoft Entra Private Access configured with Quick Access: [How to Configure Quick Access for Global Secure Access](/entra/global-secure-access/how-to-configure-quick-access)

### Limitations

- We recommend running the agent from the Microsoft Entra admin center instead of Microsoft Security Copilot.
- Scanning is only triggered on 24-hour period and isn't customizable.
- Suggestions from the agent can't all be customized or overridden. The [Review disablement plan for unused apps](agent-app-lifecycle-remediation-plans.md) feature allows for customization with AI.
- Avoid using an account that requires role activation with Privileged Identity Management (PIM). Using an account that doesn't have standing permissions might cause authentication failures for the agent.
- Once agents are started, they can't be stopped or paused. It might take a few minutes to run.
- Agent doesn't support private app discovery or onboarding suggestions for tenants in Africa and Australia.
- Due to scale constraints, the agent currently limits unused application recommendations to 10,000, displaying up to all unused app recommendations that meet filtering criteria.
- Only the user who runs the agent can see the agent session in **My Sessions** in Security Copilot.

- We recommend running the agent from the Microsoft Entra admin center instead of Microsoft Security Copilot.
-  Scanning is only triggered on 24-hour period and isn't customizable.
-  Suggestions from the agent can't all be customized or overridden. The [Review disablement plan for unused apps](agent-app-lifecycle-remediation-plans.md) feature allows for customization with AI.
- Avoid using an account that requires role activation with Privileged Identity Management (PIM). Using an account that doesn't have standing permissions might cause authentication failures for the agent.
- Once agents are started, they can't be stopped or paused. It might take a few minutes to run.
- Agent doesn't support private app discovery or onboarding suggestions for tenants in Africa and Australia.
- Due to scale constraints, the agent currently limits unused application recommendations to 10,000, displaying up to all unused app recommendations that meet filtering criteria.
- Only the user who runs the agent can see the agent session in **My Sessions** in Security Copilot.

## How it works

The App lifecycle management agent scans your tenant for unmanaged applications and application risks from the last 24 hours and determines appropriate recommendations. The agent provides intelligent suggestions for application discovery, onboarding, and risk remediation based on Microsoft's security best practices and your organizational patterns.

Each time the agent runs, it takes the following steps. **The initial scanning steps do not consume any SCUs.**

1. The agent scans all applications and service principals in your tenant using Global Secure Access telemetry for private applications and Microsoft Entra recommendations for application risk analysis.

1. The agent identifies unmanaged private applications accessed by users and detects unused applications with high-privilege permissions or missing ownership.

1. The agent reviews previous suggestions to avoid recommending the same actions repeatedly.

If the agent identifies something that wasn't previously suggested, it takes the following steps. Actions like AI-generated names for onboarded apps and customizing the batches for disablement consume SCUs. Other suggestions don't consume SCUs.

**App risk remediation**: The agent detects unused applications with high-privilege permissions, identifies applications without assigned owners, suggests owners for unowned apps, and facilitates communication with application owners for remediation decisions. It provides recommendations for safely disabling unnecessary applications in batches to reduce your organization's attack surface.

- The agent creates detailed recommendations with context and suggested actions.

- The agent provides onboarding suggestions with appropriate user scoping or risk remediation plans including communication with application owners.

The agent provides two main categories of suggestions to help you maintain a secure and well-managed application environment:

**Application discovery & onboarding**: The agent identifies unmanaged private applications accessed through Microsoft Entra Internet Access and Microsoft Entra Private Access and provides onboarding recommendations with least-privilege user assignments. This helps bring shadow IT applications under centralized management with proper security controls.

**App risk remediation**: The agent detects unused applications with high-privilege permissions, identifies applications without assigned owners, suggests owners for unowned apps, and facilitates communication with application owners for remediation decisions. It provides recommendations for safely disabling unnecessary applications in batches to reduce your organization's attack surface.

> [!IMPORTANT]
> The agent doesn't make any changes to existing applications or policies unless an administrator explicitly approves the suggestion.
>
> All *new* applications suggested for onboarding by the agent are created with appropriate security configurations.
Apps are *disabled*, not deleted, by the agent after administrator approval. You can revert changes later by re-enabling the apps. Monitor for impact from app owners and business use.

## Getting started

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](../role-based-access-control/permissions-reference.md#cloud-application-administrator).

1. From the home page, select **Go to agents** from the agent notification card.

   - You can also select **Agents** from the left navigation menu.

1. Select **View details** on the App lifecycle management agent tile.

1. Select **Start agent** to begin your first run. 

   - Avoid using an account with a role activated through PIM.

   - A message that says "The agent is starting its first run" appears in the upper-right corner.

   - The first run might take a few minutes to complete.

When the agent overview page loads, any suggestions appear in the **Recent suggestions** box. The agent provides comprehensive information about discovered applications and identified risks, allowing you to make informed decisions about onboarding new applications or remediating existing security concerns.

The agent operates automatically on a daily schedule (triggers every 24 hours), continuously monitoring your environment for new unmanaged applications and emerging risks. Each suggestion includes detailed context about why the recommendation was made and what actions you can take. For application discovery suggestions, you see information about user access patterns, application usage, and recommended security configurations. For risk remediation suggestions, you receive prioritized lists of unused applications with context about their permissions and ownership status.

### Working with discovery suggestions

When the agent identifies unmanaged applications, it provides onboarding suggestions that include recommended application names, user scoping based on access patterns, and security configurations aligned with your organizational policies. You can review these suggestions and use the one-click onboarding feature to bring applications under Microsoft Entra management with appropriate security controls. For more information, see [Discovery and onboard apps with the App lifecycle management agent](agent-app-lifecycle-discovery-onboard.md).

### Working with risk suggestions

For risk remediation, the agent provides detailed reports of unused applications prioritized by their privilege levels and potential security impact. The agent can facilitate communication with application owners through email notifications, helping you gather information about whether applications should be retained or safely disabled. This collaborative approach ensures that business-critical applications aren't inadvertently affected while reducing your organization's attack surface. Check out the following articles for more information:

- [Identity and prioritize risky apps](agent-identify-prioritize-risky-apps.md)
- [Contact applications owners and suggested owners and contacts of unused apps](agent-contact-app-owners.md)
- [Create remediation plan for risky apps](agent-app-lifecycle-remediation-plans.md)

## Settings

Once the agent is enabled, you can adjust settings to customize its behavior and operation. You can access the settings from the Microsoft Entra admin center by navigating to **Agents** > **App lifecycle management agent** > **Settings**.

### Trigger

The agent is configured to run automatically every 24 hours based on when it's initially activated. You can also manually trigger runs at any time by selecting **Run Agent** from the agent dashboard. The automatic scheduling ensures continuous monitoring of your application environment without requiring manual intervention.

### Identity and permissions

There are several key points to consider regarding the identity and permissions of the agent:

- The agent runs under the identity and permissions of the "agent identity created at setup". However, any write action operations are under the identity of the user of the agent.
- Avoid using an account that requires elevation through PIM for just-in-time elevation. If that user hasn't elevated to the appropriate role when the agent runs, the run fails.
- The Security Administrator and Global Administrator roles have access to Security Copilot by default. You can assign other roles such as Application Administrators with Security Copilot access, which gives them the ability to use the agent as well.
- The user who approves a suggestion becomes responsible for the resulting application configuration changes.
- The audit logs for actions taken by the agent are associated with the user who enabled the agent. You can find the name of the account that started the agent in the **Identity and permissions** section of the settings.

## Remove agent

If you no longer wish to use the App lifecycle management agent, select **Remove agent** from the top of the agent window. The existing data (agent activity, suggestions, and metrics) is removed but any applications onboarded or policies created based on the agent suggestions remain intact. Previously applied suggestions remain unchanged so you can continue to use the applications and configurations created or modified by the agent.

### Providing feedback

Use the **Give Microsoft feedback** button at the top of the agent window to provide feedback to Microsoft about the agent.

## Related content

- [Discovery and onboard apps with the App lifecycle management agent](agent-app-lifecycle-discovery-onboard.md)
- [Create remediation plan for risky apps](agent-app-lifecycle-remediation-plans.md)
- [Learn more about Microsoft Security Copilot](/copilot/security/microsoft-security-copilot)
