---
title: Microsoft Security Copilot scenarios in Microsoft Entra Internet and Private Access
description: Learn how to use Microsoft Security Copilot with Microsoft Entra Internet Access and Private Access
author: cilwerner
ms.author: cwerner
manager: pmwongera
ms.reviewer: ptyagi
ms.date: 09/23/2025
ms.update-cycle: 180-days
ms.topic: concept-article
ms.service: entra
ms.custom: security-copilot
ms.collection: msec-ai-copilot
# Customer intent: As an identity administrator, I want to learn how to use Microsoft Security Copilot for Microsoft Entra ID Protection scenarios so I can investigate and remediate identity risks.
---

# Microsoft Security Copilot scenarios in Microsoft Entra Internet and Private Access

[Microsoft Security Copilot](/security-copilot/microsoft-security-copilot) gets insights from your Microsoft Entra data through Global Secure Access network traffic analysis skills, enabling administrators to investigate and monitor network traffic usage and behavior using natural language queries. Network traffic analysis skills allow network administrators and security teams to analyze user, device, and branch network usage, identify network issues, and detect threats or policy violations in real time without the need to write complex queries.

## Microsoft Entra Internet Access and Private Access scenarios supported by Microsoft Security Copilot

Security Copilot is integrated into the Microsoft Entra admin center and works seamlessly with Microsoft Entra ID Protection features. The following table provides an overview of the scenarios supported by Security Copilot:

| Scenario | Role(s) | License | Tenant |
|----------|---------|---------|--------|
| [Global Secure Access](#global-secure-access) | [Security Administrator](/entra/identity/role-based-access-control/permissions-reference#security-administrator)<br>[Global Reader](/entra/identity/role-based-access-control/permissions-reference#global-reader)<br>[Global Secure Access Administrator](/entra/identity/role-based-access-control/permissions-reference#global-secure-access-administrator)<br>[Global Secure Access Log Reader](/entra/identity/role-based-access-control/permissions-reference#global-secure-access-log-reader) | [Microsoft Entra ID P1 or P2 license](/entra/id-protection/overview-identity-protection#license-requirements)<br>Entra Private Access License (for private access traffic)<br>Entra Internet Access License (for general internet traffic outside Microsoft services) | Global Secure Access configured |

Using Security Copilot, you can apply its capabilities with Global Secure Access in the following use cases:

- [Monitor data consumption and bandwidth usage](#monitor-data-consumption-and-bandwidth-usage)
- [Investigate blocked traffic and security threats](#investigate-blocked-traffic-and-security-threats)
- [Analyze user application access patterns](#analyze-user-application-access-patterns)
- [Monitor cross-tenant access and external connections](#monitor-cross-tenant-access-and-external-connections)

## Global Secure Access

For example, as a security analyst or network administrator, you can use Security Copilot to investigate and monitor network traffic usage and behavior using natural language queries. You can analyze user, device, and branch network usage, identify network issues, and detect threats or policy violations in real time. As a result, your investigation process is streamlined and more effective. 

>[!NOTE]
> If an action is blocked by insufficient permissions, a recommended role is displayed. You can use the following prompt in the Security Copilot chat to activate the required role. This is dependent on having an eligible role assignment that provides the necessary access.
>
> - *Activate the {required role} so that I can perform {the desired task}.*

### Monitor data consumption and bandwidth usage

You can begin your investigation by analyzing overall network traffic patterns and identifying users with high data consumption. Understanding bandwidth usage and traffic distribution are crucial for capacity planning, identifying potential security issues, and detecting unusual usage patterns that might indicate compromised accounts or policy violations. Use the following example prompts to get the information you need:

- *Show the top 5 users with the highest data consumption in the last day.*
- *List the top 10 accessed applications names in the last week based on network traffic logs.*

### Investigate blocked traffic and security threats

Next, you should investigate blocked traffic and security threats to identify potential security incidents and ensure that your organization's security policies are effectively enforced. Analyzing blocked traffic can help you detect malicious activities, misconfigurations, or policy violations that could compromise your network's security. Use the following example prompts to get the information you need:

- *Show all blocked traffic for user david.analyst@woodgrovebank.com in the last 24 hours.*
- *List all applications with high-risk scores accessed in the last 24 hours based on network traffic logs.*

### Analyze user application access patterns

You can analyze specific user access patterns to understand application usage, identify unusual behavior, and ensure compliance with corporate access policies. This analysis helps identify potential insider threats, compromised accounts, or unauthorized application usage that could pose security risks. Use the following example prompt to get the information you need:

- *List all applications names that user sarah.manager@woodgrovebank.com has accessed in the last 24 hours based on network traffic logs.*

### Monitor cross-tenant access and external connections

Finally, you should monitor cross-tenant traffic to identify any unauthorized external connections, to prevent unauthorized data access and movement. Use the following example prompt to get the information you need:

- *Show all cross-tenant traffic to tenant aaaabbbb-0000-cccc-1111-dddd2222eeee in the last 7 days based on network traffic logs.*

## Related content

- Learn more about [Global Secure Access](/entra/global-secure-access/overview-what-is-global-secure-access)
- [How to use the Global Secure Access traffic logs (preview)](/entra/global-secure-access/how-to-view-traffic-logs)