---
title: Shadow AI discovery in Global Secure Access
description: Learn how Global Secure Access helps you discover and manage shadow AI applications in your organization.
author: HULKsmashGithub
ms.author: jayrusso
ms.topic: concept-article
ms.date: 03/30/2026
ms.reviewer: kerenSemel
ai-usage: ai-assisted

#customer intent: As an IT admin, I want to discover and manage unsanctioned generative AI applications in my organization so I can reduce security and compliance risks.
---

# Shadow AI discovery in Global Secure Access

Shadow AI refers to the use of generative AI applications and services by employees without the knowledge, approval, or oversight of the IT department. As AI tools become more accessible, users might adopt them for productivity without considering the security, compliance, or data privacy implications. Global Secure Access helps you discover, monitor, and manage shadow AI in your organization.

> [!IMPORTANT]
> Shadow AI discovery is currently in PREVIEW.
> This information relates to a prerelease product that might be substantially modified before its release. Microsoft makes no warranties, expressed or implied, with respect to the information provided here.

## What is shadow AI?

Shadow AI is similar to shadow IT, but specifically involves the unauthorized or unmanaged use of generative AI applications. Examples include:

- Employees using third-party AI chatbots or writing assistants to process sensitive company data.
- Teams adopting AI-powered tools for code generation, summarization, or data analysis without IT approval.
- Users accessing generative AI applications through web browsers, bypassing organizational security controls.

Shadow AI introduces unique risks because generative AI applications often process, store, or learn from the data that users provide. This can lead to unintentional data exposure, compliance violations, or intellectual property leakage.

## How shadow AI discovery works

Global Secure Access analyzes network traffic to identify generative AI applications that users in your organization access. The discovery process works by:

- **Monitoring traffic** — Global Secure Access inspects internet and Microsoft 365 traffic to detect connections to known generative AI applications.
- **Cataloging applications** — Discovered applications are matched against the Microsoft Defender for Cloud Apps cloud app catalog, which categorizes applications and assigns risk scores based on general, security, compliance, and legal factors.
- **Providing visibility** — IT admins can view all discovered generative AI applications, the users who access them, transaction volumes, and data transfer amounts through the Insights and Analytics dashboard.

## Key capabilities

With shadow AI discovery, you can:

- **Discover generative AI applications** — Identify all generative AI applications that users access across internet and Microsoft 365 traffic.
- **Assess risk** — Review risk scores and detailed risk factors for each discovered AI application, including security, compliance, and legal assessments.
- **Analyze usage patterns** — Understand which users access AI applications, how often, and how much data is transferred.
- **Monitor data exposure** — Track bytes sent and received to generative AI applications to identify potential data leakage.
- **Take action** — Use insights to create policies that block, monitor, or allow specific AI applications based on your organization's security and compliance requirements.

## Access shadow AI discovery

To access shadow AI discovery features:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as a [Global Secure Access Log Reader](/azure/active-directory/roles/permissions-reference#global-secure-access-log-reader).
1. Browse to **Global Secure Access** > **Applications** > **Insights and Analytics**.
1. On the **Application discovery** page, enable the **Generative AI apps only** toggle to filter the view to show only generative AI applications.

## Shadow AI vs. shadow IT

| Aspect | Shadow IT | Shadow AI |
|---|---|---|
| Definition | Unauthorized use of any IT applications or services | Unauthorized use of generative AI applications specifically |
| Primary risk | Data sprawl, security gaps, compliance violations | Data exposure to AI models, intellectual property leakage, compliance violations |
| Examples | Personal cloud storage, unauthorized SaaS tools | AI chatbots, AI writing assistants, AI code generators |
| Detection | Application discovery and cloud app analytics | Generative AI app filtering in application usage analytics |

## Related content

- [What is application usage analytics?](overview-application-usage-analytics.md)
- [Application discovery for Global Secure Access](how-to-application-discovery.md)
