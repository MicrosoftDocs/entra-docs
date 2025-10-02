---
title: Understand monitoring with Microsoft Security Copilot
description: Use Microsoft Security Copilot in the Microsoft Entra admin center to monitor sign-in activities, audit logs, health alerts, and service level agreements.
author: cilwerner
ms.author: cwerner
manager: pmwongera
ms.reviewer: ptyagi
ms.date: 09/23/2025
ms.update-cycle: 180-days
ms.topic: how-to
ms.service: entra
ms.custom: security-copilot
ms.collection: msec-ai-copilot
# Customer intent: As an IT administrator, I want to learn how to use Microsoft Security Copilot for monitoring and operations so I can maintain operational awareness and quickly identify and respond to issues.
---

# Understand health monitoring with Microsoft Security Copilot

Microsoft Security Copilot streamlines operational monitoring in Microsoft Entra by enabling administrators to quickly analyze sign-in activities, investigate audit logs, monitor system health, and track service performance using natural language queries. This capability helps maintain operational awareness and quickly identify and respond to issues before they impact your organization.

This article describes how an IT administrator could use Microsoft Security Copilot monitoring and operations skills to conduct an operational health review of their Microsoft Entra environment by covering the following use cases:

- [Analyze sign-in activities](#analyze-sign-in-activities)
- [Investigate audit logs for administrative and user changes](#investigate-audit-logs-for-administrative-and-user-changes)
- [Improve security posture through recommendations](#improve-security-posture-through-recommendations)
- [Monitor system health and proactively address alerts](#monitor-system-health)
- [Track service level agreement (SLA) performance](#track-service-level-agreement-performance)

Use the prompts and examples in this article to compile your findings into actionable insights and reports for operational reviews and incident response by your team or management.

## Prerequisites

The following roles and licenses are required for different monitoring and operations use cases:

| Use case | Role | License | Tenant |
|---|---|---|---|
| **Sign-in logs** | [Reports Reader](/entra/identity/role-based-access-control/permissions-reference#reports-reader), [Security Reader](/entra/identity/role-based-access-control/permissions-reference#security-reader), [Security Administrator](/entra/identity/role-based-access-control/permissions-reference#security-administrator), or [Global Reader](/entra/identity/role-based-access-control/permissions-reference#global-reader) | [Microsoft Entra ID P1 or P2 license](/entra/id-protection/overview-identity-protection#license-requirements) | Any public cloud tenant with sign-in data |
| **Audit logs** | [Reports Reader](/entra/identity/role-based-access-control/permissions-reference#reports-reader), [Security Reader](/entra/identity/role-based-access-control/permissions-reference#security-reader), [Security Administrator](/entra/identity/role-based-access-control/permissions-reference#security-administrator), or [Global Administrator](/entra/identity/role-based-access-control/permissions-reference#global-administrator) | Free license required | Any public cloud tenant with audit activity |
| **Recommendations** | [Application Administrator](/entra/identity/role-based-access-control/permissions-reference#application-administrator), [Identity Governance Administrator](/entra/identity/role-based-access-control/permissions-reference#identity-governance-administrator), [Privileged Role Administrator](/entra/identity/role-based-access-control/permissions-reference#privileged-role-administrator), [Conditional Access Administrator](/entra/identity/role-based-access-control/permissions-reference#conditional-access-administrator), [Security Administrator](/entra/identity/role-based-access-control/permissions-reference#security-administrator), [Hybrid Identity Administrator](/entra/identity/role-based-access-control/permissions-reference#hybrid-identity-administrator), [Authentication Policy Administrator](/entra/identity/role-based-access-control/permissions-reference#authentication-policy-administrator), [Authentication Administrator](/entra/identity/role-based-access-control/permissions-reference#authentication-administrator) | Free Microsoft Entra ID or [P1/P2](/entra/id-protection/overview-identity-protection#license-requirements) | Any tenant, also available in Workload ID |
| **Health monitoring alerts** | [Reports Reader](/entra/identity/role-based-access-control/permissions-reference#reports-reader), [Helpdesk Administrator](/entra/identity/role-based-access-control/permissions-reference#helpdesk-administrator), [Security Reader](/entra/identity/role-based-access-control/permissions-reference#security-reader), [Security Operator](/entra/identity/role-based-access-control/permissions-reference#security-operator), [Security Administrator](/entra/identity/role-based-access-control/permissions-reference#security-administrator), or [Global Reader](/entra/identity/role-based-access-control/permissions-reference#global-reader) | [Microsoft Entra ID P2 licenses](/entra/id-protection/overview-identity-protection#license-requirements) | Public cloud tenant |
| **Service Level Agreement** | [Reports Reader](/entra/identity/role-based-access-control/permissions-reference#reports-reader) | Any Microsoft Entra ID license | Any tenant |

## Launch Security Copilot in Microsoft Entra

[!INCLUDE [Launch Security Copilot in Microsoft Entra](./includes/access-entra-copilot.md)]

## Analyze sign-in activities

You can begin your assessment by analyzing sign-in activities across your organization. Understanding authentication patterns and identifying potential issues is crucial for maintaining security and user experience in your organization.

### Application and authentication analysis

Start by investigating sign-in patterns related to specific applications and authentication methods to ensure security policies are being followed and to identify any anomalies or issues. Use the following prompts to get the information you need:

- *Show sign-ins to a specific application.*
- *Show sign-ins without multifactor authentication.*
- *Show sign-in failures due to a specific Conditional Access policy.*
- *Show sign-ins with unsatisfied Conditional Access Policies.*

### Device and location analysis

You can further analyze sign-in activities based on device compliance, operating systems, browsers, and geographic locations to monitor for unusual patterns or potential security threats, and ensure corporate devices are being used appropriately. Use the following prompts to get the information you need:

- *Show sign-ins from non-compliant devices.*
- *Show logins from specific web browsers.*
- *Show logins from specific operating systems.*
- *Show sign-ins from specific locations.*

### User activity and security monitoring

You can hone in on individual user activities to monitor for suspicious behavior, or risky sign-ins that may indicate compromised accounts or security threats that require immediate attention. Use the following prompts to get the information you need:

- *Show sign-in activities since a specific time period.*
- *Show sign-in activity for the user Casey Jensen.*
- *Show suspicious login activities.*
- *Display risky sign-ins.*

## Investigate audit logs for administrative and user changes

Next, investigate audit logs to track changes made by administrators and users in your Microsoft Entra environment. This analysis helps identify potential security issues, ensure compliance, and ensure proper governance of administrative activities. Use the following prompts to gather the information you need:

### Group management activities

You can continue your investigation by focusing on group management activities, which is important for maintaining proper access controls and ensuring that group-related changes are tracked for security and compliance purposes. Use the following prompts to get the information you need:

- *Show me recently deleted groups.*
- *What groups were deleted recently?*
- *Last deleted groups in my directory?*
- *Who created this group?*
- *Find out who created a specific group.*
- *Group creation details.*
- *What groups were created by these users?*
- *Show groups created by specific users.*
- *List all groups created by the user Casey Jensen.*

### Security and authentication activities

To identify potential security issues, focus on security and authentication-related activities in the audit logs. This helps ensure that security policies are being followed and that any suspicious activities are promptly investigated. Use the following prompts to get the information you need:

- *Show me risky sign-ins.*
- *List suspicious logins.*
- *Are there any risky authentications?*

### Provisioning and service activities

You can also investigate provisioning and service principal activities to ensure that these critical operations are functioning correctly and to identify any anomalies that may require attention. Use the following prompts to get the information you need.

- *Check provisioning job status.*
- *Is my provisioning job completed?*
- *Show provisioning jobs for this service principal.*
- *List jobs for this service principal.*

## Improve security posture through recommendations

To get a comprehensive view of your security posture, you can leverage Microsoft Entra recommendations, which can help identify areas for improvement and provide actionable insights to enhance your organization's security and compliance with best practices. 

### General recommendations and secure score

Start with general recommendations and secure score analysis to get an overview of your tenant's security posture. Use the following prompts to gather the information you need:

- *List all Entra recommendations.*
- *Show my tenant's historical Secure Score data.*
- *Show Entra recommendation "example" and its details.*
- *Show the resources affected by an Entra recommendation.*
- *Show resource "example" of Entra recommendation "example".*
- *List secure score recommendations.*
- *List best practice recommendations.*

### Targeted recommendations by category

Once you have a general overview, you can focus on specific categories of recommendations to address particular areas of concern, such as conditional access policies, application security, and tenant configuration. Use the following prompts to get the information you need:

- *List recommendations for conditional access policies.*
- *Show Entra recommendations for a specific feature area.*
- *List high-priority recommendations.*
- *List recommendations with high priority.*
- *List recommendations that are active.*
- *List recommendations to improve app portfolio health.*
- *List recommendations to reduce surface area risk.*
- *List recommendations to improve security posture of my apps.*
- *List recommendations for tenant configuration.*
- *Show Entra recommendations by impact type.*

### Application credential management

You can also focus on application credential management to ensure that your applications are secure and that credentials are being managed properly to prevent unauthorized access. Use the following prompts to get the information you need:

- *Which enterprise applications have credentials about to expire?*
- *Show me service principals with credentials that are expiring soon.*
- *Show me applications with credentials that are expiring soon.*
- *Which of our apps are stale or unused in the tenant?*
- *List the unused apps.*

## Monitor system health

You can continue your assessment by monitoring system health to detect anomalies and proactively address potential issues before they impact your organization. Proactive health monitoring can help prevent service disruptions and maintain system reliability.

### Health alert monitoring

For a general overview of your system's health, you can start by monitoring health alerts. This helps you stay informed about any issues that may require attention and ensures that your systems are functioning optimally. Use the following prompts to get the information you need:

- *What health alerts do I have in my tenant?*
- *List all active health monitoring alerts.*
- *What are my recent health monitoring alerts?*
- *What users are impacted according to the active health monitoring alerts?*
- *Show me health monitoring alert details for alert ID [alertId].*

### Scenario-specific health monitoring

Once you have a general overview, you can focus on specific health monitoring scenarios to address particular areas of concern, such as multifactor authentication (MFA) issues or device compliance. Use the following prompts or ones specific to your scenario to get the information you need:

- *Show me health monitoring alerts related to MFA sign in failure.*
- *Show me managed device health monitoring alerts.*
- *Show me compliant device health monitoring alerts.*
- *Show me device scenario health monitoring alerts.*

## Track Service Level Agreement performance

Finally, you can assess your Service Level Agreement (SLA) performance to ensure that your organization is meeting its commitments and to identify any areas for improvement. Monitor SLA for authentication availability and review SLA reports in conjunction with service outages to ensure service quality and eligibility for service credits.

### SLA performance monitoring

Use the following prompts to monitor your SLA performance and identify any potential issues that may require attention:

- *What is my SLA for Microsoft Entra authentication?*
- *What is my Microsoft Entra SLA?*
- *What is the SLA of Microsoft Entra authentication?*
- *Show me my tenant's authentication availability.*
- *Has my tenant had an SLA breach in the last "X" months?*

## Related content

- Learn more about [Microsoft Entra Health monitoring](/entra/identity/monitoring-health/concept-microsoft-entra-health)
- Learn more about [investigating Microsoft Entra Health monitoring alerts](/entra/identity/monitoring-health/howto-investigate-health-scenario-alerts?tabs=admin-center)
- Learn more about [SLA performance for Microsoft Entra ID](/entra/identity/monitoring-health/reference-sla-performance)
- Learn more about [sign-in logs in Microsoft Entra ID](/entra/identity/monitoring-health/concept-sign-ins)
- Learn more about [audit logs in Microsoft Entra ID](/entra/identity/monitoring-health/concept-audit-logs)
