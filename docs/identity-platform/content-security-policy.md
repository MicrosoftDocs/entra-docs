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

Content Security Policy (CSP) is a browser security header that allows only trusted scripts and resources to load. Microsoft Entra ID enforces CSP on sign-in pages to block unapproved non-Microsoft scripts and reduce Cross-Site Scripting (XSS) risks.

## Risk of script or code injection

Script or code injection occurs when malicious scripts run in a user’s browser without authorization. This vulnerability can lead to:

- **Data theft**: Attackers can steal sensitive information such as credentials or tokens.
- **Session hijacking**: Injected scripts can take control of active sessions.
- **Malware delivery**: Malicious code can install harmful software on user devices.
- **Loss of trust**: Compromised sign-in pages damage user confidence and brand reputation.

XSS is one of the most common injection attacks. It enables attackers to run malicious scripts in a user’s browser, which can steal credentials, hijack sessions, and compromise sensitive data.

CSP helps prevent these attacks by restricting which scripts can execute in the browser. By enforcing CSP, Microsoft Entra ID ensures only trusted Microsoft code runs during sign-in.

## CSP enforcement scope and key details

CSP protects sign-in experiences by allowing only trusted Microsoft code. Our report-only mode analysis showed no first-party issues. Violations came from external browser extensions or injected scripts, often linked to non-Microsoft tools.

Here’s what you need to know about the scope and key details of CSP enforcement:

- **Header enforcement scope**: CSP enforcement applies only to browser-based sign-in experiences at `login.microsoftonline.com`. Other domains and nonbrowser authentication flows aren't affected.
- **Microsoft Authentication Library (MSAL) and API authentication**: MSAL-based authentication flows that interact with Microsoft Entra security token service (STS) APIs remain unaffected because enforcement is limited to the browser sign-in URL.
- **Microsoft Entra External ID and custom domains**: External ID customers using custom domains or CIAM/B2C domains for sign-in aren't impacted. Enforcement is restricted to the Microsoft online login domain.

## Non-Microsoft tools with CSP violations

Several tools inject scripts into sign-in pages, causing CSP violations. These violations typically come from monitoring or workforce management extensions rather than Microsoft code.

The most common tools include:

- **UKG Pro Mobile App** – HR/workforce management plugin.
- **Datadog Synthetics** – Monitoring and synthetic testing.
- **Kronos WFD Mobile App** – Workforce management extension.
- **Site24x7** – Website and application monitoring.

Blocking these scripts can disrupt sign-in or monitoring workflows. Customers using these tools should coordinate with vendors for fixes.

## Rollout strategy

To minimize disruption, Microsoft Entra ID enforces CSP in phases. Each phase reduces risk and builds confidence before moving to the next stage. The rollout consists of three phases, each with specific goals and actions. Microsoft communicates timelines and details through targeted emails and broad notifications before each phase:

- **Phase 1 – Pilot (December 2025)**: To validate thresholds, enable CSP for selected tenants with low violation rates and monitor the effect.
- **Phase 2 – Broad rollout (April 2026)**: To expand coverage, enable CSP for most tenants except for tenants with critical dependencies. Maintain report-only mode for exceptions.
- **Phase 3 – Final enforcement (October 2026)**: To achieve full enforcement, enable CSP for all tenants, including the common endpoint, and remove remaining exceptions after migration.

## Exception criteria

To avoid disruption in critical scenarios, customers can request temporary exclusion. Requests must include:

- Impacted tools and breaking scenarios.
- Number of affected users.
- Migration timeline.

Customers can extend enforcement by up to 6–8 months beyond Phase 3.

## Customer guidance

Follow these steps to prepare for CSP enforcement and minimize disruption:

- **Test flight**: Validate CSP behavior in your environment before enforcement. Use the query parameter `enablecsp=true` on the sign-in URL to simulate enforcement and identify potential issues.
- **Review violation logs**: Check tenant-specific CSP violation reports to understand which scripts or tools might be blocked. This helps prioritize remediation.
- **Coordinate with vendors**: If violations involve non-Microsoft tools, contact vendors early to ensure compatibility with CSP enforcement.
- **Internal documentation**: Customer Acceleration Team (CAT) managed customers can request detailed internal documentation and tenant-specific CSP logs for deeper analysis.
- **Support channels**: If you encounter issues or need an exclusion, raise a support ticket through CSS. Include details about impacted tools, number of affected users, and migration timelines.

## Success and mitigation

To measure success, track full CSP enforcement, reduced violation reports, and minimal authentication issues, while monitoring support tickets to ensure minimal disruption. If unexpected problems occur, CSP enforcement can be mitigated through the `ContentSecurityPolicyEnforcement` feature flag, which can be disabled globally or per tenant.
