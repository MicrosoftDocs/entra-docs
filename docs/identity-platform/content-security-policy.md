---
title: Content Security Policy (CSP) rollout in Microsoft Entra ID
description: Learn how Microsoft Entra ID enforces CSP headers to protect sign-in pages from Cross-Site Scripting (XSS) attacks and how to prepare for phased rollout.
author: henrymbuguakiarie
manager: pmwongera
ms.author: henrymbugua
ms.service: identity-platform
ms.topic: concept-article
ms.date: 10/15/2025

#customer intent: As a security administrator, I want to understand CSP enforcement in Entra ID so that I can prepare my organization for rollout and mitigate impact.
---

# Content Security Policy overview for Microsoft Entra ID

Content Security Policy (CSP) is a browser security header that allows only trusted scripts and resources to load. Microsoft Entra ID enforces CSP on sign-in pages to block unauthorized scripts from external sources and reduce the risk of Cross-Site Scripting (XSS) attacks.

## Risk of script or code injection

Script or code injection occurs when malicious scripts run in a user’s browser without authorization. This vulnerability can lead to:

- **Data theft**: Attackers can steal sensitive information such as credentials or tokens.
- **Session hijacking**: Injected scripts can take control of active sessions.
- **Malware delivery**: Malicious code can install harmful software on user devices.
- **Loss of trust**: Compromised sign-in pages damage user confidence and brand reputation.

XSS is one of the most common injection attacks. It enables attackers to run malicious scripts in a user’s browser, which can steal credentials, hijack sessions, and compromise sensitive data.

CSP helps prevent these attacks by restricting which scripts can execute in the browser. By enforcing CSP, Microsoft Entra ID ensures only trusted Microsoft code runs during sign-in.

## CSP enforcement scope and key details

CSP protects sign-in experiences by allowing only trusted Microsoft code. Our analysis showed that violations mostly came from external browser extensions or injected scripts, often linked to non-Microsoft tools.

Here’s what you need to know about the scope and key details of CSP enforcement:

- **Header enforcement scope**: CSP enforcement applies only to browser-based sign-in experiences at `login.microsoftonline.com`. Other domains and nonbrowser authentication flows aren't affected.
- **Microsoft Authentication Library (MSAL) and API authentication**: MSAL-based authentication flows that interact with Microsoft Entra security token service (STS) APIs remain unaffected because enforcement is limited to the browser sign-in URL.
- **Microsoft Entra External ID and custom domains**: External ID customers using custom domains or CIAM/B2C domains for sign-in aren't impacted.

## Non-Microsoft tools with CSP violations

Several tools inject scripts into sign-in pages, causing CSP violations. The most common tools include:

- **UKG Pro Mobile App** – HR/workforce management plugin.
- **Datadog Synthetics** – Monitoring and synthetic testing.
- **Kronos WFD Mobile App** – Workforce management extension.
- **Site24x7** – Website and application monitoring.

When CSP is enforced on `login.microsoftonline.com`, these tools will be blocked from executing, which can disrupt sign-in or monitoring workflows. Customers using these tools should coordinate with vendors for fixes. 

## When will you see CSP enforcement?

To minimize disruption, Microsoft Entra ID will enforce CSP in phases. The rollout consists of two phases, each with specific goals and actions. Microsoft will communicate timelines and details through targeted emails and broad notifications before each phase:

- Phase 1 begins in mid-to-late April 2026 for tenants identified as having minimal effect.
- Phase 2 begins in mid-to-late October 2026 for all remaining tenants.

## Customer guidance

Follow these steps to prepare for CSP enforcement and minimize disruption:

- **Review violation logs**: Check tenant-specific CSP violation reports to understand which scripts or tools might be blocked. This helps prioritize remediation.
- **Coordinate with vendors**: If violations involve non-Microsoft tools, contact vendors early to ensure compatibility with CSP enforcement.

Use the instructions below to identify the exact effect in your tenant.

1. Go through a sign-in flow with the dev console open to identify any violations.
1. Review the information about the violation displayed in red. If a specific team or person caused the violation, it appears only in their flows. To ensure accuracy, thoroughly assess different sign-in scenarios within your organization. Here's an example of a violation:

   ![Screenshot showing CSP violation example](./media/content-security-policy/csp-violation-example.png)

The CSP update helps keep your organization safe by blocking unauthorized scripts and protecting your organization against modern threats. To ensure a smooth rollout, test your sign-in flows thoroughly ahead of time. This helps you catch and address any issues early, so your users stay protected, and your sign-in experience remains seamless. 