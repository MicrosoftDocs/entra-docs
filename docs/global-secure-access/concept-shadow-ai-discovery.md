---
title: Shadow AI discovery in Global Secure Access
description: Learn how Shadow AI discovery in Global Secure Access provides network-based visibility into unsanctioned AI applications and tools used in your organization.
author: HULKsmashGithub
ms.author: jayrusso
ms.topic: concept-article
ms.date: 03/30/2026
ms.reviewer: kerenSemel
ai-usage: ai-assisted

#customer intent: As an IT admin, I want to discover and manage unsanctioned generative AI applications and tools in my organization so I can reduce security and compliance risks.
---

# Shadow AI discovery in Global Secure Access

Shadow AI discovery in Microsoft Entra Global Secure Access is a network-based feature that provides visibility into unsanctioned AI applications and tools used in your organization. It identifies traffic to AI services like ChatGPT, Claude, SaaS MCP servers, and AI Model Provider frameworks (for example, DeepSeek, Anthropic Claude API) by analyzing network traffic. Shadow AI discovery lets administrators see which generative AI apps or tools employees are using without IT approval.

> [!IMPORTANT]
> Shadow AI discovery is currently in PREVIEW.
> This information relates to a prerelease product that might be substantially modified before its release. Microsoft makes no warranties, expressed or implied, with respect to the information provided here.

## Why shadow AI discovery matters

Unmanaged AI usage can introduce serious risks, including:

- **Data leakage** — Sensitive data might be sent to external AI services.
- **Compliance violations** — Unsanctioned tools could violate regulatory requirements.
- **Uncontrolled AI tools activity** — Self-directed AI tools might lead to unintended actions without oversight.

Shadow AI discovery helps mitigate these risks by revealing unsanctioned AI usage so that security teams can take action, such as educating users or enforcing policies. It ensures you're not left guessing which AI applications are in use — you can clearly see them.

## How shadow AI discovery works

Global Secure Access analyzes network traffic to identify generative AI applications and tools that users in your organization access. The discovery process works by:

- **Analyzing network traffic** — Global Secure Access inspects internet and Microsoft 365 traffic to detect connections to known generative AI applications, SaaS MCP servers, and AI Model Provider frameworks.
- **Cataloging applications** — Discovered applications are matched against the Microsoft Defender for Cloud Apps cloud app catalog, which categorizes applications and assigns risk scores based on general, security, compliance, and legal factors.
- **Surfacing insights** — IT admins can view all discovered generative AI applications, the users who access them, usage statistics, and risk scores through the Application Usage Analytics dashboard.

## Key capabilities

With shadow AI discovery, you can:

- **Discover generative AI applications and tools** — Identify all generative AI applications that users access across internet and Microsoft 365 traffic, including AI chatbots, AI Model Provider APIs, and SaaS MCP servers.
- **Assess risk** — Review risk scores and detailed risk factors for each discovered AI application, including security, compliance, and legal assessments.
- **Analyze usage patterns** — Understand which users access AI applications, how often, and how much data is transferred.
- **Monitor data exposure** — Track bytes sent and received to generative AI applications to identify potential data leakage.
- **Take action** — Use insights to educate users, create policies that block or monitor specific AI applications, and enforce compliance with your organization's security requirements.

## Access shadow AI discovery

Shadow AI discovery insights are surfaced in the Application Usage Analytics of Global Secure Access.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as a [Global Secure Access Log Reader](/azure/active-directory/roles/permissions-reference#global-secure-access-log-reader).
1. Browse to **Global Secure Access** > **Applications** > **Insights and Analytics**.
1. Use the **Generative AI apps and tools** filter or toggle to highlight detected AI applications and view details like usage statistics and risk scores.

The Global Secure Access dashboard also features widgets that summarize shadow AI usage at a glance, such as the number of AI apps accessed and usage trends over time.

## Shadow AI vs. shadow IT

| Aspect | Shadow IT | Shadow AI |
|---|---|---|
| Definition | Unauthorized use of any IT applications or services | Unauthorized use of generative AI applications and tools specifically |
| Primary risk | Data sprawl, security gaps, compliance violations | Data leakage to AI models, compliance violations, uncontrolled AI tools activity |
| Examples | Personal cloud storage, unauthorized SaaS tools | AI chatbots, AI Model Provider APIs, SaaS MCP servers, AI code generators |
| Detection | Application discovery and cloud app analytics | Generative AI apps and tools filtering in application usage analytics |

## Related content

- [What is application usage analytics?](overview-application-usage-analytics.md)
- [Application discovery for Global Secure Access](how-to-application-discovery.md)
