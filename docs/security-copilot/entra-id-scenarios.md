---
title: Microsoft Security Copilot scenarios in Microsoft Entra ID
description: Learn how to use Microsoft Security Copilot with Microsoft Entra ID for identity and security scenarios.
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
# Customer intent: As an identity administrator, I want to learn how to use Microsoft Security Copilot for Microsoft Entra ID scenarios so I can improve my organization's security posture.
---

# Microsoft Security Copilot scenarios in Microsoft Entra ID

Microsoft Security Copilot is a powerful tool that can help you manage and secure your Microsoft Entra ID environment. This article describes how to use Microsoft Security Copilot with Microsoft Entra ID core features to enhance your identity protection efforts. Using this feature requires a tenant with Microsoft Security Copilot enabled.

## Microsoft Entra ID scenarios supported by Microsoft Security Copilot

Security Copilot is integrated into the Microsoft Entra admin center and works seamlessly with Microsoft Entra ID features. The following table provides an overview of the scenarios supported by Security Copilot:

| Scenario | Role(s) | License | Tenant |
|----------|---------|---------|--------|
| [Tenants](#tenants) | [Global Reader](/entra/identity/role-based-access-control/permissions-reference#global-reader) | Any Microsoft Entra ID license | Any |
| [Users](#users) | [User Administrator](/entra/identity/role-based-access-control/permissions-reference#user-administrator) | Any Microsoft Entra ID license | Any |
| [Groups](#groups) | [Directory Writer](/entra/identity/role-based-access-control/permissions-reference#directory-writer)<br>[Groups Administrator](/entra/identity/role-based-access-control/permissions-reference#groups-administrator)<br>[User Administrator](/entra/identity/role-based-access-control/permissions-reference#user-administrator) | Free Microsoft Entra ID license | Any public cloud tenant with more than one group |
| [Domains](#domains) | [Domain Name Administrator](/entra/identity/role-based-access-control/permissions-reference#domain-name-administrator) | Any Microsoft Entra ID license | Any |
| [Licenses](#licenses) | [Global Reader](/entra/identity/role-based-access-control/permissions-reference#global-reader) | [Microsoft Entra ID Governance license](/entra/id-governance/licensing-fundamentals) | Any |
| [Sign-in logs](#sign-in-logs) | [Reports Reader](/entra/identity/role-based-access-control/permissions-reference#reports-reader)<br>[Security Reader](/entra/identity/role-based-access-control/permissions-reference#security-reader)<br>[Security Administrator](/entra/identity/role-based-access-control/permissions-reference#security-administrator)<br>[Global Reader](/entra/identity/role-based-access-control/permissions-reference#global-reader) | [Microsoft Entra ID P1 or P2 license](/entra/id-protection/overview-identity-protection#license-requirements) | Any public cloud tenant with sign-in data |
| [Audit logs](#audit-logs) | [Reports Reader](/entra/identity/role-based-access-control/permissions-reference#reports-reader)<br>[Security Reader](/entra/identity/role-based-access-control/permissions-reference#security-reader)<br>[Security Administrator](/entra/identity/role-based-access-control/permissions-reference#security-administrator)<br>[Global Administrator](/entra/identity/role-based-access-control/permissions-reference#global-administrator) | Free Microsoft Entra ID license | Any public cloud tenant with audit activity |
| [Recommendations](#recommendations) | [Application Administrator](/entra/identity/role-based-access-control/permissions-reference#application-administrator)<br>[Identity Governance Administrator](/entra/identity/role-based-access-control/permissions-reference#identity-governance-administrator)<br>[Privileged Role Administrator](/entra/identity/role-based-access-control/permissions-reference#privileged-role-administrator)<br>[Conditional Access Administrator](/entra/identity/role-based-access-control/permissions-reference#conditional-access-administrator)<br>[Security Administrator](/entra/identity/role-based-access-control/permissions-reference#security-administrator)<br>[Hybrid Identity Administrator](/entra/identity/role-based-access-control/permissions-reference#hybrid-identity-administrator)<br>[Authentication Policy Administrator](/entra/identity/role-based-access-control/permissions-reference#authentication-policy-administrator)<br>[Authentication Administrator](/entra/identity/role-based-access-control/permissions-reference#authentication-administrator) | Free Microsoft Entra ID license or [Microsoft Entra ID P1/P2 license](/entra/id-protection/overview-identity-protection#license-requirements) | Any (also available in Microsoft Entra Workload ID) |
| [Health monitoring alerts](#health-monitoring-alerts) | [Reports Reader](/entra/identity/role-based-access-control/permissions-reference#reports-reader)<br>[Helpdesk Administrator](/entra/identity/role-based-access-control/permissions-reference#helpdesk-administrator)<br>[Security Reader](/entra/identity/role-based-access-control/permissions-reference#security-reader)<br>[Security Operator](/entra/identity/role-based-access-control/permissions-reference#security-operator)<br>[Security Administrator](/entra/identity/role-based-access-control/permissions-reference#security-administrator)<br>[Global Reader](/entra/identity/role-based-access-control/permissions-reference#global-reader) | [Microsoft Entra ID P2 license](/entra/id-protection/overview-identity-protection#license-requirements) | Any public cloud tenant |
| [Service Level Agreement](#service-level-agreement) | [Reports Reader](/entra/identity/role-based-access-control/permissions-reference#reports-reader) | Any Microsoft Entra ID license | Any |
| [Roles and administrators](#roles-and-administrators) | [Directory Reader](/entra/identity/role-based-access-control/permissions-reference#directory-readers)<br>[Global Reader](/entra/identity/role-based-access-control/permissions-reference#global-reader) | Any Microsoft Entra ID license | Any |
| [Devices](#devices) | Any user | Free Microsoft Entra ID license | Any |
| [Conditional Access](#conditional-access) | [Security Administrator](/entra/identity/role-based-access-control/permissions-reference#security-administrator)<br>[Global Reader](/entra/identity/role-based-access-control/permissions-reference#global-reader)<br>[Security Reader](/entra/identity/role-based-access-control/permissions-reference#security-reader) | [Microsoft Entra ID P1 license](/entra/id-protection/overview-identity-protection#license-requirements) | Any with Conditional Access policies configured |
| [Authentication](#authentication) | [Authentication Policy Administrator](/entra/identity/role-based-access-control/permissions-reference#authentication-policy-administrator) (tenant level)<br>[Privileged Authentication Administrator](/entra/identity/role-based-access-control/permissions-reference#privileged-authentication-administrator) (user level) | Any Microsoft Entra ID license | Any |

## Enterprise user management scenarios

With Microsoft Security Copilot, administrators can now manage and investigate their Microsoft Entra tenants, users, groups, domains and licenses using natural language.

### Tenants

Using Security Copilot, admins can ask questions about their tenant, such as the tenant ID, display name, and active licenses assigned to their tenant. It also provides insights into the technical and security compliance contacts for the tenant, and whether users can create new tenants.

This feature requires a minimum of the [Global Reader](/entra/identity/role-based-access-control/permissions-reference#global-reader) role in Microsoft Entra ID, and can be used with any tenant and Microsoft Entra ID license.

Refer to the prompts and examples in [Enterprise user management with Microsoft Security Copilot](./entra-enterprise-user-management.md#understand-tenant-configuration) to learn how to use Microsoft Security Copilot for tenant information scenarios.

### Users

Using Security Copilot, IT administrators can quickly view user details, manage roles, and troubleshoot access issues. This helps keep user identities secure and up to date, reducing time spent navigating portals and improving response times for user-related requests.

Refer to the prompts and examples in [Enterprise user management with Microsoft Security Copilot](./entra-enterprise-user-management.md) to learn how to use Microsoft Security Copilot with user management for the following use-cases;

- [User information and details](./entra-enterprise-user-management.md#user-information-and-details)
- [User authentication and permissions](./entra-enterprise-user-management.md#user-authentication-and-permissions)
- [User filtering and organization](./entra-enterprise-user-management.md#user-filtering-and-organization)

### Groups

Using Security Copilot, IT administrators can quickly view group configurations, manage memberships, and identify group hygiene issues such as ownerless groups. By providing relevant group information in context, Copilot helps minimize time spent navigating portals and improves response times for group-related tasks.

Users with the following can use this feature:

Refer to the prompts and examples in [Enterprise user management with Microsoft Security Copilot](./entra-enterprise-user-management.md) to learn how to use Microsoft Security Copilot with group management for the following use-cases;

- [Group membership and composition](./entra-enterprise-user-management.md#group-membership-and-composition)
- [Group configuration and roles](./entra-enterprise-user-management.md#group-configuration-and-roles)
- [Group organization and governance](./entra-enterprise-user-management.md#group-organization-and-governance)

### Domains

Security Copilot can help IT admins simplify domain management in the Microsoft Entra admin center. This feature allows administrators to quickly access domain information, verify DNS records, and manage domain settings using natural language queries.

Refer to the prompts and examples in [Enterprise user management with Microsoft Security Copilot](./entra-enterprise-user-management.md) to learn how to use Microsoft Security Copilot with domain management for the following use-case;

- [Domain details and verification](./entra-enterprise-user-management.md#domain-details-and-verification)

### Licenses

Managing license purchases and usage across your Microsoft Entra tenant can be challenging. Using Security Copilot, you can ask questions about license usage, helping your organization optimize license utilization and get the most value from your Microsoft Entra investment.

Refer to the prompts and examples in [Enterprise user management with Microsoft Security Copilot](./entra-enterprise-user-management.md) to learn how to use Microsoft Security Copilot with license usage for the following use-case;

- [License analysis and utilization](./entra-enterprise-user-management.md#license-analysis-and-utilization)

For more information, see:

- [Microsoft Entra licensing](../fundamentals/licensing.md)

## Monitoring and Health scenarios

Microsoft Entra uses the capabilities of Microsoft Security Copilot to help administrators monitor and maintain the health of their Microsoft Entra ID environment. By using natural language queries, admins can quickly access and analyze sign-in logs, audit logs, recommendations, health monitoring alerts, and SLA performance data. This enables them to identify potential issues, investigate anomalies, and take proactive measures to ensure the security and reliability of their identity infrastructure.

### Sign-in logs

With Security Copilot, IT admins can streamline the process of reviewing and troubleshooting sign-in activities in Microsoft Entra. Instead of manually sorting through complex log data, IT administrators and Helpdesk teams can quickly analyze sign-in logs, identify issues, and receive clear, actionable answers. Security Copilot also suggests helpful follow-up questions to support your troubleshooting process and guide your next steps.

Refer to the prompts and examples in [Understand monitoring and operations with Microsoft Security Copilot](./entra-monitoring-operations.md) to learn how to use Microsoft Security Copilot with sign-in logs for the following use-cases;

- [Application and authentication analysis](./entra-monitoring-operations.md#application-and-authentication-analysis)
- [Device and location analysis](./entra-monitoring-operations.md#device-and-location-analysis)
- [User activity and security monitoring](./entra-monitoring-operations.md#user-activity-and-security-monitoring)

### Audit logs

With Security Copilot, IT admins can streamline the process of investigating and troubleshooting audit logs in Microsoft Entra. Instead of manually searching through extensive log data, IT administrators and Helpdesk teams can quickly analyze audit activities, identify issues, and receive clear, actionable answers. Security Copilot also suggests helpful follow-up questions to support your investigation and guide your next steps.

Refer to the prompts and examples in [Understand monitoring and operations with Microsoft Security Copilot](./entra-monitoring-operations.md) to learn how to use Microsoft Security Copilot with audit logs for the following use-cases;

- [Group management activities](./entra-monitoring-operations.md#group-management-activities)
- [Security and authentication activities](./entra-monitoring-operations.md#security-and-authentication-activities)
- [Provisioning and service activities](./entra-monitoring-operations.md#provisioning-and-service-activities)

### Recommendations

With recommendations, Security Copilot can help you quickly investigate how to evolve your tenant to a secure and healthy state, by providing actionable insights and guidance. These recommendations cover features, best practices, and settings of Microsoft Entra, such as using least privileged administrator roles, configuring Self-Service Password Reset, and protecting your tenant with Conditional Access policies. Some recommendations factor into your Identity Secure Score, which can help you monitor and improve the security of your tenant. Using the capabilities of Microsoft Security Copilot, you can now interact with these recommendations using natural language, enabling your security team to quickly investigate how to evolve your tenant to a secure and healthy state.

Refer to the prompts and examples in [Governance and optimization with Microsoft Security Copilot](./entra-governance-optimization.md) to learn how to use Microsoft Security Copilot with recommendations for the following use-cases;

- [General recommendations and secure score](./entra-monitoring-operations.md#general-recommendations-and-secure-score)
- [Targeted recommendations by category](./entra-monitoring-operations.md#targeted-recommendations-by-category)
- [Application credential management](./entra-monitoring-operations.md#application-credential-management)

For more information, see;

- [What are Microsoft Entra Recommendations?](../identity/monitoring-health/overview-recommendations.md)
- [How to use Microsoft Entra Recommendations](../identity/monitoring-health/howto-use-recommendations.md)

### Health monitoring alerts

Using Security Copilot, administrators can now investigate health monitoring alerts in External Health Monitoring to analyze scenario-specific metrics for each tenant, detect anomalies, and raise alerts. Metrics include sign-in success rates, failure rates, and counts for multifactor authentication (MFA).

Refer to the prompts and examples in [Understand monitoring and operations with Microsoft Security Copilot](./entra-monitoring-operations.md) to learn how to use Microsoft Security Copilot with health monitoring for the following use-cases;

- [Health alert monitoring](./entra-monitoring-operations.md#health-alert-monitoring)
- [Scenario-specific health monitoring](./entra-monitoring-operations.md#scenario-specific-health-monitoring)

For more information, see:

- [What is Microsoft Entra Health monitoring?](/entra/identity/monitoring-health/concept-microsoft-entra-health)
- [How to investigate Microsoft Entra Health monitoring alerts](/entra/identity/monitoring-health/howto-investigate-health-scenario-alerts?tabs=admin-center)

### Service Level Agreement

With Microsoft Security Copilot, IT administrators can easily access and analyze Service Level Agreement (SLA) reports for authentication availability in their Microsoft Entra tenant. Security Copilot uses the Microsoft Graph API to provide monthly look-back insights on core authentication availability, helping admins quickly identify periods where SLA attainment may have fallen below 99.99%. This enables proactive review of SLA data alongside service outages, and helps determine eligibility for service credits according to the [Microsoft Entra SLA](/entra/identity/monitoring-health/reference-sla-performance). Security Copilot streamlines the process, allowing admins to use natural language queries to investigate SLA performance and ensure their organization’s authentication reliability.

Refer to the prompts and examples in [Understand monitoring and operations with Microsoft Security Copilot](./entra-monitoring-operations.md) to learn how to use Microsoft Security Copilot with SLA information for the following use-cases;

- [SLA performance monitoring](./entra-monitoring-operations.md#sla-performance-monitoring)

For more information, see:

- [SLA performance for Microsoft Entra ID](/entra/identity/monitoring-health/reference-sla-performance)

## Roles and administrators

Microsoft Entra role-based access control (RBAC) helps you manage who has access to Microsoft Entra resources by assigning roles to users, groups, or applications. You can use built-in roles or create custom roles with specific permissions to meet your organization's needs. You can now use Microsoft Security Copilot to investigate roles within a directory. For example, you can ask which roles a user or group has, who has a specific role, or get details about a particular role. This makes it easier for administrators and analysts to understand and manage role assignments across your environment.

Refer to the prompts and examples in [Security and access control with Microsoft Security Copilot](./entra-security-access-control.md) to learn how to use Microsoft Security Copilot with role management for the following use-cases;

- [Role assignment queries](./entra-security-access-control.md#role-assignment-queries)
- [Role information and identification](./entra-security-access-control.md#role-information-and-identification)

For more information, see:

- [Overview of role-based access control in Microsoft Entra ID](/entra/identity/role-based-access-control/custom-overview)
- [Microsoft Entra built-in roles](/entra/identity/role-based-access-control/permissions-reference#application-administrator)

## Devices

Microsoft Entra uses the capabilities of Security Copilot to help administrators investigate their Microsoft Entra ID devices using natural language queries. This feature allows admins to quickly access device information, such as device IDs, compliance status, activity and whether devices are Entra ID registered, joined, or hybrid joined.

Refer to the prompts and examples in [Enterprise user management with Microsoft Security CopilotManage identities with Microsoft Security Copilot](./entra-enterprise-user-management.md) to learn how to use Microsoft Security Copilot with device management for the following use-cases;

- [Device identification and status](./entra-security-access-control.md#device-identification-and-status)
- [Device join types and configuration](./entra-security-access-control.md#device-join-types-and-configuration)
- [Device activity and operating systems](./entra-security-access-control.md#device-activity-and-operating-systems)

## Conditional Access

Microsoft Entra Conditional Access applies the capabilities of Microsoft Security Copilot to help admins easily understand and evaluate their Conditional Access policies. By combining Conditional Access APIs with the power of generative AI, Security Copilot enables analysts to ask natural language questions, such as identifying what policies apply to users or what policies use certain controls, and receive clear insights in seconds.

Refer to the prompts and examples in [Security and access control with Microsoft Security Copilot](./entra-security-access-control.md) to learn how to use Microsoft Security Copilot with Conditional Access for the following use-cases;

- [Policy identification and status](./entra-security-access-control.md#policy-identification-and-status)
- [Policy configuration and management](./entra-security-access-control.md#policy-configuration-and-management)

## Authentication

Microsoft Security Copilot empowers administrators to quickly assess and manage authentication methods across their Microsoft Entra tenant. By using natural language queries, you can easily discover which authentication methods are enabled, understand user registration status, and identify potential gaps in your organization's authentication strategy. This capability streamlines security management, helping you ensure that strong authentication practices are in place to protect your users and resources.

Refer to the prompts and examples in [Security and access control with Microsoft Security Copilot](./entra-security-access-control.md) to learn how to use Microsoft Security Copilot with authentication methods for the following use-cases;

- [Authentication method configuration](./entra-security-access-control.md#authentication-method-configuration)
- [User authentication status](./entra-security-access-control.md#user-authentication-status)

## See also

- [Microsoft Security Copilot scenarios in Microsoft Entra ID Protection](./entra-id-protection-scenarios.md)
- [Microsoft Security Copilot scenarios in Microsoft Entra ID Governance](./entra-id-governance-scenarios.md)
- [Get started with Microsoft Security Copilot](/copilot/security/get-started-security-copilot)