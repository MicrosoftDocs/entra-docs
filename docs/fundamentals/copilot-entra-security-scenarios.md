---
title: Microsoft Security Copilot scenarios in Microsoft Entra
description: Learn how to use Microsoft Security Copilot in the Microsoft Entra admin center for identity and security scenarios.
keywords: null
author: cilwerner
ms.author: cwerner
manager: pmwongera
ms.date: 06/09/2025
ms.topic: conceptual
ms.service: entra
ms.custom: microsoft-copilot
ms.collection: null
# Customer intent: As an identity administrator, I want to learn how to use Microsoft Security Copilot for a variety of Microsoft Entra scenarios so I can improve my organization's security posture.
---

# Microsoft Security Copilot scenarios in Microsoft Entra

Microsoft Security Copilot is a powerful tool that can help you manage and secure your Microsoft Entra identity environment. This article describes how to use Microsoft Security Copilot with Microsoft Entra in identity related scenarios to enhance your identity protection efforts. Using this feature requires a tenant with Microsoft Security Copilot enabled.

## Create Security Copilot prompts in the Microsoft Entra admin center (preview)

Security Copilot is a part of the Microsoft Entra admin center, and you can use it to create your own prompts. Security Copilot is launched from a globally available button in the menu bar. Choose from a set of starter prompts that appear at the top of the Security Copilot window or enter your own in the prompt bar to get started. Suggested prompts can appear after a response, which are predefined prompts that Security Copilot selects based on the prior response. 

:::image type="content" source="./media/copilot-security-entra/security-copilot-entra-admin-center.png" alt-text="Screenshot that shows Security Copilot in the Microsoft Entra admin center.":::

Specific scenarios supported by Security Copilot embedded in Microsoft Entra skills include: 

- [Investigate recommendations](#investigate-recommendations): Use natural language to interact with Microsoft Entra recommendations and improve your tenant's security posture.
- [Summarize a user's risk level](#summarize-a-users-risk-level): Quickly summarize a user's risk level and receive insights relevant to the incident at hand.
- [Investigate access reviews](#investigate-access-reviews): Extract and analyze access review data using natural language queries.
- [Investigate insights within entitlements management](#investigate-insights-within-entitlements-management): Get quick access to information about access packages, policies, connected organizations, and catalog resources.
- [Investigate alerts in Scenario Health Monitoring](#investigate-alerts-in-scenario-health-monitoring): Analyze scenario-specific metrics, detect anomalies, and raise alerts for proactive investigation.
- [SLA in Scenario Health Monitoring](#sla-in-scenario-health-monitoring): Get look-back reporting on Service Level Agreements (SLA) for authentication availability in your Microsoft Entra tenant.
- [Microsoft Entra domains](#microsoft-entra-domains): Simplify domain management by accessing domain information, verifying DNS records, and managing domain settings using natural language queries.
- [Microsoft Entra tenants](#microsoft-entra-tenants): Get quick access to your Microsoft Entra ID organization information, including tenant ID, display name, active licenses, and contacts.
- [Microsoft Entra Role Based Access Control (RBAC)](#microsoft-entra-role-based-access-control-rbac): Investigate roles within a directory, such as which roles a user or group has, who has a specific role, or details about a particular role.
- [License Usage](#license-usage): Track licenses purchased and actual usage across your Microsoft Entra tenant using natural language queries.

### Investigate recommendations

Recommendations in Microsoft Entra help you improve the security posture of your tenant by providing actionable insights and guidance. These recommendations cover the many features, best practices, and settings of Microsoft Entra, such as using least privileged administrator roles, configuring Self-Service Password Reset, and protecting your tenant with Conditional Access policies. Some recommendations factor into your Identity Secure Score, which can help you monitor and improve the security of your tenant. Using the capabilities of Microsoft Security Copilot, you can now interact with these recommendations using natural language, enabling your security team to quickly investigate how to evolve your tenant to a secure and healthy state. 

This feature is available using a free Microsoft Entra ID license, or a [Microsoft Entra ID P1 or P2 license](/entra/id-protection/overview-identity-protection#license-requirements). It's also available in Microsoft Entra Workload ID. 

The following roles can use this feature: 

- [Application Administrator](/entra/identity/role-based-access-control/permissions-reference#application-administrator)
- [Identity Governance Administrator](/entra/identity/role-based-access-control/permissions-reference#identity-governance-administrator)
- [Privileged Role Administrator](/entra/identity/role-based-access-control/permissions-reference#privileged-role-administrator)
- [Conditional Access Administrator](/entra/identity/role-based-access-control/permissions-reference#conditional-access-administrator)
- [Security Administrator](/entra/identity/role-based-access-control/permissions-reference#security-administrator)
- [Hybrid Identity Administrator](/entra/identity/role-based-access-control/permissions-reference#hybrid-identity-administrator)
- [Authentication Policy Administrator](/entra/identity/role-based-access-control/permissions-reference#authentication-policy-administrator)
- [Authentication Administrator](/entra/identity/role-based-access-control/permissions-reference#authentication-administrator)

The following example prompts can be used to investigate recommendations in Microsoft Entra:

- *List all Microsoft Entra recommendations*
- *List secure score recommendations*
- *List recommendations for conditional access policies*
- *Show Microsoft Entra recommendations for a specific feature area*
- *List recommendations with high priority*
- *List recommendations to improve app portfolio health*
- *List recommendations to improve security posture of my apps*
- *Which enterprise applications have credentials about to expire?*
- *Which of our apps are stale or unused in the tenant?*

For more information, see;

- [What are Microsoft Entra Recommendations?](../identity/monitoring-health/overview-recommendations.md)
- [How to use Microsoft Entra Recommendations](../identity/monitoring-health/howto-use-recommendations.md)

### Summarize a user's risk level

Microsoft Entra ID Protection applies the capabilities of Security Copilot to [summarize a user's risk level](copilot-entra-risky-user-summarization.md), provide insights relevant to the incident at hand, and provide recommendations for rapid mitigation. Identity risk investigation is a crucial step to defend an organization. Copilot helps reduce the time to resolution by providing IT admins and security operations center (SOC) analysts the right context to investigate and remediate identity risk and identity-based incidents. Risky user summarization provides admins and responders quick access to the most critical information in context to aid their investigation.

Using this feature requires the [Identity Governance Administrator](/entra/identity/role-based-access-control/permissions-reference#identity-governance-administrator) role in Microsoft Entra ID and a [Microsoft Entra ID P2 license](/entra/id-protection/overview-identity-protection#license-requirements).

:::image type="content" source="./media/copilot-entra-risky-user-summarization/risky-user-details.png" alt-text="Screenshot that shows the ID Protection risky user summarization details.":::

### Investigate access reviews

Administrators can use Microsoft Security Copilot with Microsoft Entra ID Governance Access Reviews to extract and analyze access review data. This integration allows admins to explore, track, and analyze access reviews at scale. 

This feature helps administrators;

- Understand who approved access
- Identify reviewers who took no decisions
- Investigate overrides of AI recommendations

Using this feature requires a minimum of the [Identity Governance Administrator](/entra/identity/role-based-access-control/permissions-reference#identity-governance-administrator) role in Microsoft Entra ID, a [Microsoft Entra ID P2 license](/entra/id-protection/overview-identity-protection#license-requirements) and a tenant with access reviews configured.

Use the following example prompts to extract access reviews data in Microsoft Entra:

| Use Case | Example Prompts |
|----------|-----------------|
| Explore current configured access reviews in the tenant | *Show me the top 10 pending access reviews* |
| Get detailed info on a specific access review | *Get access review details for Finance Microsoft 365 Groups Q2* |
| View access review decisions for a specific instance | *Who approved or denied access in the Q2 finance review?* |
| Track reviews assigned to a specific reviewer | *List reviews where Alex Chen is the assigned reviewer* |
| Identify decisions that went against AI recommendations | *Which access review decisions overrode AI-suggested actions?* |
| View assigned reviewers for a specific access review | *Who are the reviewers for the Sales App Access Q2 review?* |

For more information, see;

- [What are access reviews?](/entra/id-governance/access-reviews-overview)
- [Prepare for an access review of users' access to an application](/entra/id-governance/access-reviews-application-preparation) 

### Investigate insights within entitlements management

Use Microsoft Security Copilot with Microsoft Entra ID Governance Entitlement Management to get quick access to information about access packages, policies, connected organizations, and catalog resources.

Entitlement management in Microsoft Entra ID enables organizations to manage identity and access lifecycle at scale, by automating workflows, access assignments, reviews, and expirations. Using the capabilities of Microsoft Security Copilot with Microsoft Entra ID Governance Entitlement Management, administrators can now interact with entitlement management data using natural language. You can get quick access to information about access packages, policies, connected organizations, and catalog resources, and customize curated data only previously available through custom scripting.

Using this feature requires a minimum of the [Identity Governance Administrator](/entra/identity/role-based-access-control/permissions-reference#identity-governance-administrator) role in Microsoft Entra ID and a [Microsoft Entra ID P2 licenses](/entra/id-protection/overview-identity-protection#license-requirements).

You can use the following example prompts to investigate insights within entitlements management in Microsoft Entra:

* *What resources are in catalog “XYZ”*
* *How many catalogs and access packages are in the tenant?*
* *Which access packages are in catalog "Test Catalog"?*
* *What resource role scopes are in access package “My Package”?*
* *What access package assignments does “User” have?*
* *Find all access packages where the name contains “Sales”?*
* *Who are the external users of connected organization “XYZ”?*
* *What custom extensions does catalog “XYZ” have?*

For more information, see;

[What is entitlement management?](/entra/id-governance/entitlement-management-overview)

### Investigate alerts in Scenario Health Monitoring 

External Health Monitoring is a feature in Microsoft Entra that analyzes scenario-specific metrics for each tenant, detects anomalies, and raises alerts. These alerts are sent via the Microsoft Graph API and displayed in the Microsoft Entra admin center UI, enabling tenant admins to proactively investigate and address issues. For example, in the multifactor authentication (MFA) scenario, External Health Monitoring tracks metrics such as sign-in success rate, sign-in failure rate, and failure count. If there's a spike in failures, an alert is raised to notify the tenant admin, who can then take appropriate action to resolve the issue. 

Using this feature requires [Microsoft Entra ID P2 licenses](/entra/id-protection/overview-identity-protection#license-requirements) and a public cloud tenant.

The following roles can use this feature:

- [Reports Reader](/entra/identity/role-based-access-control/permissions-reference#reports-reader)
- [Helpdesk Administrator](/entra/identity/role-based-access-control/permissions-reference#helpdesk-administrator)
- [Security Reader](/entra/identity/role-based-access-control/permissions-reference#security-reader)
- [Security Operator](/entra/identity/role-based-access-control/permissions-reference#security-operator)
- [Security Administrator](/entra/identity/role-based-access-control/permissions-reference#security-administrator)
- [Global Reader](/entra/identity/role-based-access-control/permissions-reference#global-reader)

The following example prompts can be used to investigate alerts in Scenario Health Monitoring:

- *What health alerts do I have in my tenant?*
- *What users are impacted according to the active health monitoring alerts?*
- *Show me health monitoring alert details for alert ID [alertId]*
- *Show me managed device health monitoring alerts*
- *Show me compliant device health monitoring alerts*
- *Show me device scenario health monitoring alerts*

For more information, see:

- [What is Microsoft Entra Health monitoring?](/entra/identity/monitoring-health/concept-microsoft-entra-health)
- [How to investigate Microsoft Entra Health monitoring alerts](/entra/identity/monitoring-health/howto-investigate-health-scenario-alerts?tabs=admin-center)

### SLA in Scenario Health Monitoring

Microsoft Entra Health provides look-back reporting on Service Level Agreements (SLA) for authentication availability for your Microsoft Entra tenant. The SLA Attainment is a monthly look-back solution that shows the core authentication availability of Microsoft Entra ID each month. IT admins often need to review the SLA reports in conjuntion with service outages. If availability dips below 99.99% in any given month, you might be eligible for service credits in alignment with the [Microsoft Entra SLA](/entra/identity/monitoring-health/reference-sla-performance). Security Copilot interacts with the Microsoft Entra SLA using the Microsoft Graph API.

Using this feature requires a minimum of the [Reports Reader](/entra/identity/role-based-access-control/permissions-reference#reports-reader) role.

The following example prompts can be used to get SLA information:

- *What is my SLA for Microsoft Entra authentication?*
- *What is my Microsoft Entra SLA?*
- *What is the SLA of Microsoft Entra authentication?*
- *Show me my tenant's authentication availability.*
- *Has my tenant had an SLA breach in the last "X" months?*

For more information, see:

- [SLA performance for Microsoft Entra ID](/entra/identity/monitoring-health/reference-sla-performance)

### Microsoft Entra domains

Microsoft Entra uses the capabilities of Security Copilot to simplify domain management in the Microsoft Entra admin center. This feature allows administrators to quickly access domain information, verify DNS records, and manage domain settings using natural language queries.

Using this feature requires a minimum of the [Domain Name Administrator](/entra/identity/role-based-access-control/permissions-reference#domain-name-administrator) role in Microsoft Entra ID, and can be used with any tenant and Microsoft Entra ID license.

The following example prompts can be used to investigate alerts in Scenario Health Monitoring:

- *List details of contoso.com*
- *Show me DNS verification records of contoso.com*
- *What is my initial domain name?*

### Microsoft Entra tenants

With Microsoft Security Copilot, administrators can now get quick access to their Microsoft Entra ID organization information using natural language. This feature allows admins to ask questions about their tenant, such as the tenant ID, display name, and active licenses. It also provides insights into the technical and security compliance contacts for the tenant, and whether users can create new tenants.

This feature requires a minimum of the [Global Reader](/entra/identity/role-based-access-control/permissions-reference#global-reader) role in Microsoft Entra ID, and can be used with any tenant and Microsoft Entra ID license.

The following example prompts can be used to investigate alerts in Scenario Health Monitoring:

- *What is my tenant's display name?*
- *What is my tenant ID?*
- *What are all the active licenses assigned to my tenant?*
- *Who is the technical contact for my tenant?*
- *Who is the security compliance contact for my tenant?*

### Microsoft Entra Role Based Access Control (RBAC)

Microsoft Entra role-based access control (RBAC) helps you manage who has access to Microsoft Entra resources by assigning roles to users, groups, or applications. You can use built-in roles or create custom roles with specific permissions to meet your organization's needs. You can now use Microsoft Security Copilot to investigate roles within a directory. For example, you can ask which roles a user or group has, who has a specific role, or get details about a particular role. This makes it easier for administrators and analysts to understand and manage role assignments across your environment.

Users assigned the following roles can use this feature:

- [Directory Reader](/entra/identity/role-based-access-control/permissions-reference#directory-readers)
- [Global Reader](/entra/identity/role-based-access-control/permissions-reference#global-reader)

The following example prompts can be used to investigate roles in Microsoft Entra:

- *What role does user/group/app <name/email/id> have?*
- *What are the transitive roles user/group/app <name/email/id> has?*
- *What are the eligible roles user/group/app <name/email/id> has?*
- *What are the scheduled roles user/group/app <name/email/id> has?*
- *Who has the Cloud Application Administrator role assigned to them?*
- *Who has eligibility for the Global Reader role?*

For more information, see:

- [Overview of role-based access control in Microsoft Entra ID](/entra/identity/role-based-access-control/custom-overview)
- [Microsoft Entra built-in roles](/entra/identity/role-based-access-control/permissions-reference#application-administrator)

### License Usage 

Managing license purchases and usage across your Microsoft Entra tenant can be challenging. Microsoft Security Copilot simplifies this process by allowing administrators to ask natural language questions about license usage, such as “How many Microsoft Entra P2 licenses are in use?” or “How many users are using Conditional Access?” Security Copilot provides clear and actionable answers in seconds, helping your organization optimize license utilization and get the most value from your Microsoft Entra investment.

This feature requires a minimum of the [Global Reader](/entra/identity/role-based-access-control/permissions-reference#global-reader) role in Microsoft Entra ID, and can be used with any tenant and Microsoft Entra ID license.

The following example prompts can be used to investigate roles in Microsoft Entra:

- *How many Microsoft Entra P1/P2 licenses do I have?*
- *Show me the Microsoft Entra P1/P2 feature utilization*
- *Show me the Microsoft Entra P1/P2 license usage details*

For more information, see:

- [Microsoft Entra licensing](/entra/fundamentals/licensing)

## See also

- [Get started with Microsoft Security Copilot](/copilot/security/get-started-security-copilot)
- [Microsoft Security Copilot experiences](/copilot/security/experiences-security-copilot)
- [Respond to identity threats using risky user summarization](/entra/fundamentals/copilot-entra-risky-user-summarization)
