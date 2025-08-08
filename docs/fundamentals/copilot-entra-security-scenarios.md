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

## Scenarios supported by Microsoft Security Copilot in Microsoft Entra

Security Copilot is a part of the Microsoft Entra admin center, and you can use it to create your own prompts. Security Copilot is launched from a globally available button in the menu bar. Choose from a set of starter prompts that appear at the top of the Security Copilot window or enter your own in the prompt bar to get started. Suggested prompts can appear after a response, which are predefined prompts that Security Copilot selects based on the prior response. 

:::image type="content" source="./media/copilot-security-entra/security-copilot-entra-admin-center.png" alt-text="Screenshot that shows Security Copilot in the Microsoft Entra admin center.":::

| Microsoft Entra product | Security Copilot and Microsoft Entra scenario |
| --- | --- |
| Microsoft Entra ID | [Tenants](#tenants)<br>[Users](#users)<br>[Groups](#groups)<br>[Devices](#devices)<br>[Roles and administrators](#roles-and-administrators)<br>[Domain services](#domain-services)<br>[Conditional Access](#conditional-access)<br>[Authentication](#authentication)<br>[Sign in logs](#sign-in-logs)<br>[Audit logs](#audit-logs)<br>[Recommendations](#recommendations)<br>[Health monitoring alerts](#health-monitoring-alerts)<br>[Service Level Agreement](#service-level-agreement) |
| Microsoft Entra ID Protection | [Risky users](#risky-users)<br>[Application risk](#application-risk) |
| Microsoft Entra ID Governance | [Access reviews](#access-reviews)<br>[Entitlement management](#entitlement-management)<br>[Privileged Identity Management (PIM)](#privileged-identity-management-pim)<br>[Lifecycle workflows](#lifecycle-workflows) |
| Microsoft Entra Internet Access<br>Microsoft Entra Private Access | [License Usage](#license-usage) |

## Microsoft Entra ID

The following sections describe how to use Microsoft Security Copilot for various scenarios in Microsoft Entra ID.

### Tenants

With Microsoft Security Copilot, administrators can now get quick access to their Microsoft Entra ID organization information using natural language. This feature allows admins to ask questions about their tenant, such as the tenant ID, display name, and active licenses. It also provides insights into the technical and security compliance contacts for the tenant, and whether users can create new tenants.

This feature requires a minimum of the [Global Reader](/entra/identity/role-based-access-control/permissions-reference#global-reader) role in Microsoft Entra ID, and can be used with any tenant and Microsoft Entra ID license.

The following example prompts can be used to investigate alerts in Scenario Health Monitoring:

- *What is my tenant's display name?*
- *What is my tenant ID?*
- *What are all the active licenses assigned to my tenant?*
- *Who is the technical contact for my tenant?*
- *Who is the security compliance contact for my tenant?*

### Users

Microsoft Security Copilot streamlines user management in Microsoft Entra by enabling IT administrators to quickly view user details, manage roles, and troubleshoot access issues using natural language queries. This capability helps keep user identities secure and up to date, reducing time spent navigating portals and improving response times for user-related requests.

This feature is available to users with the minimum role of [User Administrator](/entra/identity/role-based-access-control/permissions-reference#user-administrator), and can be used with any tenant and Microsoft Entra ID license.

The following example prompts can be used to investigate and manage users in Microsoft Entra:

- *Show recently deleted users*
- *Tell me about myself*
- *Are there guest users in the Human Resources department?*
- *Show transitive reports of Brandon Artois*
- *Give the member count of each department*
- *What are Abbi Atin’s authentication methods?*
- *Who is Asha Brunelle's manager?*
- *Is Blake Martin's account cloud managed?*
- *Show users by mail nickname*
- *List users without assigned licenses*
- *List users in Finance or Marketing department*
- *Show users not in {Company Name}*
- *Show users with account disabled*
- *How many users are reporting to Brandon Artois?*
- *Look up Abadi Bod’s permissions*
- *Are there any users with {Specific license}?*

### Groups

Microsoft Security Copilot streamlines Microsoft Entra Groups management by enabling IT administrators to quickly view group configurations, manage memberships, and identify group hygiene issues such as ownerless groups. By providing relevant group information in context, Copilot helps minimize time spent navigating portals and improves response times for group-related tasks.

This feature is available with a free Microsoft Entra license and in any public cloud tenant which contains one or more groups.

Users assigned the following roles can use this feature:

- [Directory Writer](/entra/identity/role-based-access-control/permissions-reference#directory-writer)
- [Groups Administrator](/entra/identity/role-based-access-control/permissions-reference#groups-administrator)
- [User Administrator](/entra/identity/role-based-access-control/permissions-reference#user-administrator)

The following example prompts can be used to investigate and manage groups in Microsoft Entra:

- *Count the total ownerless groups in my tenant*
- *Count the total user memberships for a group*
- *Provide separate counts for users, groups, devices, and service principals in a group*
- *How many different object types does a group have in total?*
- *Show me all user members of a group*
- *Which users are included in a group?*
- *What directory roles are assigned to a group?*
- *Does this group have any built-in roles?*
- *Show the count of groups categorized by group type*
- *List the number of groups under each of the group types*
- *How many groups exist for each group type?*
- *Show me the membership rules for a group*
- *Is the dynamic membership rule currently processing for a group?*

### Devices

Microsoft Entra uses the capabilities of Security Copilot to help administrators investigate their Microsoft Entra ID devices using natural language queries. This feature allows admins to quickly access device information, such as device IDs, compliance status, activity and whether devices ae Entra ID registered, joined or hybrid joined.

This feature is available using a free Microsoft Entra ID license, and to any user in any tenant.

The following example prompts can be used to investigate devices in Microsoft Entra:

- *Show me the device for with an ID of {ID}*
- *Show me all compliant devices/Show me all non-compliant devices*
- *List devices that are not under management*
- *List all devices that are Entra ID registered/Entra ID joined/Entra ID hybrid joined*
- *Show me when device {ID} was last active*
- *List the devices with specific {operating system name}*
- *Show me how many devices are running Windows (8,10,11)*
- *Show the count of Windows devices categorized by release*

### Roles and administrators

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

### Domain services

Microsoft Entra uses the capabilities of Security Copilot to simplify domain management in the Microsoft Entra admin center. This feature allows administrators to quickly access domain information, verify DNS records, and manage domain settings using natural language queries.

Using this feature requires a minimum of the [Domain Name Administrator](/entra/identity/role-based-access-control/permissions-reference#domain-name-administrator) role in Microsoft Entra ID, and can be used with any tenant and Microsoft Entra ID license.

The following example prompts can be used to investigate alerts in Scenario Health Monitoring:

- *List details of contoso.com*
- *Show me DNS verification records of contoso.com*
- *What is my initial domain name?*

### Conditional Access

Microsoft Entra Conditional Access applies the capabilities of Microsoft Security Copilot to help admins easily understand and evaluate their Conditional Access policies. By combining Conditional Access APIs with the power of generative AI, Security Copilot enables analysts to ask natural language questions, such as identifying what policies apply to users or what policies use certain controls, and receive clear insights in seconds.

Using this feature requires at least the roles of [Security Administrator](/entra/identity/role-based-access-control/permissions-reference#security-administrator), [Global Reader](/entra/identity/role-based-access-control/permissions-reference#global-reader), or [Security Reader](/entra/identity/role-based-access-control/permissions-reference#security-reader). You will also need a [Microsoft Entra ID P1 license](/entra/id-protection/overview-identity-protection#license-requirements) and a tenant with Conditional Access policies configured.

- *List active MFA Conditional Access policies in my tenant.*
- *Which MFA policies are enforced in my tenant?*
- *Which Conditional Access policies are enabled in my tenant?*
- *Which CA policies should I enable?*
- *Which CA policies are not enabled in my tenant?*
- *List all inactive Conditional Access policies in my tenant.*
- *List CA policies that are currently active in my tenant.*
- *Which Conditional Access policies in my tenant exclude trusted locations?*
- *Get all CA policies for user by group.*

### Authentication

Microsoft Security Copilot empowers administrators to quickly assess and manage authentication methods across their Microsoft Entra tenant. By using natural language queries, you can easily discover which authentication methods are enabled, understand user registration status, and identify potential gaps in your organization's authentication strategy. This capability streamlines security management, helping you ensure that strong authentication practices are in place to protect your users and resources.

Using this feature requires a minimum of the [Authentication Policy Administrator](/entra/identity/role-based-access-control/permissions-reference#authentication-policy-administrator) for tenant level configurations or [Privileged Authentication Administrator](/entra/identity/role-based-access-control/permissions-reference#privileged-authentication-administrator) for user level configurations in Microsoft Entra ID, and can be used with any tenant and Microsoft Entra ID license.

The following example prompts can be used to investigate MFA and authentication methods in Microsoft Entra:

- *What authentication methods are enabled in my tenant?*
- *Is Microsoft Authenticator enabled in my tenant? For who?*
- *Is report suspicious activity enabled in my tenant? For who?*
- *What authentication methods does karita@woodgrovebank.com have registered?*
- *Is user karita@woodgrovebank.com enabled for per-user MFA?*
- *How many users have the FIDO2 Security keys method registered?*

### Sign-in logs

Microsoft Security Copilot streamlines the process of reviewing and troubleshooting sign-in activities in Microsoft Entra. Instead of manually sorting through complex log data, IT administrators and Helpdesk teams can use natural language queries to quickly analyze sign-in logs, identify issues, and receive clear, actionable answers. Copilot also suggests helpful follow-up questions to support your troubleshooting process and guide your next steps. Users in supported roles can access Copilot from the Entra command bar. When opened from the Sign-in Logs blade, Copilot provides tailored prompts for sign-in data analysis.

Users assigned the following roles can use this feature:

- [Reports Reader](/entra/identity/role-based-access-control/permissions-reference#reports-reader)
- [Security Reader](/entra/identity/role-based-access-control/permissions-reference#security-reader)
- [Security Administrator](/entra/identity/role-based-access-control/permissions-reference#security-administrator)
- [Global Reader](/entra/identity/role-based-access-control/permissions-reference#global-reader)

This feature is available with a [Microsoft Entra ID P1 or P2 license](/entra/id-protection/overview-identity-protection#license-requirements) and in any public cloud tenant with sign-in data.

The following example prompts can be used to investigate sign-in logs in Microsoft Entra:

- *Show sign-ins to a specific application*
- *Show sign-ins without multi-factor authentication*
- *Show sign-in failures due to a specific Conditional Access policy*
- *Show sign-ins with unsatisfied Conditional Access policies*
- *Show sign-in activities since a specific time period*
- *Show sign-ins from non-compliant devices*
- *Show logins from specific web browsers*
- *Show logins from specific operating systems*
- *Show sign-ins from specific locations*
- *Show sign-in activity for a specific user*
- *Show suspicious login activities*
- *Display risky sign-ins*

### Audit logs

Microsoft Security Copilot streamlines the process of investigating and troubleshooting audit logs in Microsoft Entra. Instead of manually searching through extensive log data, IT administrators and Helpdesk teams can use natural language queries to quickly analyze audit activities, identify issues, and receive clear, actionable answers. Copilot also suggests helpful follow-up questions to support your investigation and guide your next steps.

This feature is available to users with the following roles:

- [Reports Reader](/entra/identity/role-based-access-control/permissions-reference#reports-reader)
- [Security Reader](/entra/identity/role-based-access-control/permissions-reference#security-reader)
- [Security Administrator](/entra/identity/role-based-access-control/permissions-reference#security-administrator)
- [Global Administrator](/entra/identity/role-based-access-control/permissions-reference#global-administrator)

A free license is required, and the feature is available in any public cloud tenant with audit activity.

The following example prompts can be used to investigate audit logs in Microsoft Entra:

- *Show me recently deleted groups*
- *What groups were deleted recently?*
- *Last deleted groups in my directory*
- *Show me risky sign-ins*
- *List suspicious logins*
- *Are there any risky authentications?*
- *Who created this group?*
- *Find out who created {A specific group}*
- *What groups were created by these users?*
- *Show groups created by specific users*
- *List all groups created by user "Casey Jensen"*
- *Check provisioning job status*
- *Is my provisioning job completed?*
- *Show provisioning jobs for this service principal*

### Recommendations

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

### Health monitoring alerts

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

### Service Level Agreement

Microsoft Entra Health provides look-back reporting on Service Level Agreements (SLA) for authentication availability for your Microsoft Entra tenant. The SLA Attainment is a monthly look-back solution that shows the core authentication availability of Microsoft Entra ID each month. IT admins often need to review the SLA reports in conjunction with service outages. If availability dips below 99.99% in any given month, you might be eligible for service credits in alignment with the [Microsoft Entra SLA](/entra/identity/monitoring-health/reference-sla-performance). Security Copilot interacts with the Microsoft Entra SLA using the Microsoft Graph API.

Using this feature requires a minimum of the [Reports Reader](/entra/identity/role-based-access-control/permissions-reference#reports-reader) role.

The following example prompts can be used to get SLA information:

- *What is my SLA for Microsoft Entra authentication?*
- *What is my Microsoft Entra SLA?*
- *What is the SLA of Microsoft Entra authentication?*
- *Show me my tenant's authentication availability.*
- *Has my tenant had an SLA breach in the last "X" months?*

For more information, see:

- [SLA performance for Microsoft Entra ID](/entra/identity/monitoring-health/reference-sla-performance)

## Microsoft Entra ID Protection

The following sections describe how to use Microsoft Security Copilot for various scenarios in Microsoft Entra ID Protection.

### Risky users

Microsoft Entra ID Protection applies the capabilities of Security Copilot to [summarize a user's risk level](copilot-entra-risky-user-summarization.md), provide insights relevant to the incident at hand, and provide recommendations for rapid mitigation. Identity risk investigation is a crucial step to defend an organization. Copilot helps reduce the time to resolution by providing IT admins and security operations center (SOC) analysts the right context to investigate and remediate identity risk and identity-based incidents. Risky user summarization provides admins and responders quick access to the most critical information in context to aid their investigation.

Using this feature requires the [Identity Governance Administrator](/entra/identity/role-based-access-control/permissions-reference#identity-governance-administrator) role in Microsoft Entra ID and a [Microsoft Entra ID P2 license](/entra/id-protection/overview-identity-protection#license-requirements).

:::image type="content" source="./media/copilot-entra-risky-user-summarization/risky-user-details.png" alt-text="Screenshot that shows the ID Protection risky user summarization details.":::

You can also add your own prompts in the Copilot window for the following use cases;

- [List or Identify Users Based on Risk](copilot-entra-risky-user-summarization.md#list-or-identify-users-based-on-risk)
- [User-Specific Risk Information](copilot-entra-risky-user-summarization.md#user-specific-risk-information)
- [User Risk History](copilot-entra-risky-user-summarization.md#user-risk-history)

### Application risk

Identity administrators and security analysts can use Microsoft Security Copilot to quickly assess the risk level of applications from workload identities. By leveraging natural language queries, you can easily discover the granted permissions, unused apps in your tenant, and the risk level of applications. This allows admins to take appropriate actions to mitigate risks and ensure the security of your organization's applications.

Using this feature requires a minimum of the [Application Administrator](/entra/identity/role-based-access-control/permissions-reference#application-administrator) or [Cloud Application Administrator](/entra/identity/role-based-access-control/permissions-reference#cloud-application-administrator) role in Microsoft Entra ID. Your tenant must be licensed for Workload Identity Premium or Risky Service Principal prompts. A [Microsoft Entra ID P2 license](/entra/id-protection/overview-identity-protection#license-requirements) is also needed for full functionality.

Refer to the prompts and examples in [Assess application risks using Microsoft Security Copilot in Microsoft Entra](./copilot-security-entra-investigate-risky-apps.md) to learn how to use Microsoft Security Copilot to assess application risk for the following use-cases;

- [Explore Microsoft Entra risky service principals](./copilot-security-entra-investigate-risky-apps.md#explore-microsoft-entra-risky-service-principals)
- [Explore Microsoft Entra service principals](./copilot-security-entra-investigate-risky-apps.md#explore-microsoft-entra-service-principals)
- [Explore Microsoft Entra applications](./copilot-security-entra-investigate-risky-apps.md#explore-microsoft-entra-applications)
- [View the permissions granted on a Microsoft Entra service principal](./copilot-security-entra-investigate-risky-apps.md#explore-microsoft-entra-risky-service-principals)
- [Explore unused Microsoft Entra applications](./copilot-security-entra-investigate-risky-apps.md#explore-unused-microsoft-entra-applications)
- [Explore Microsoft Entra Applications outside my tenant](./copilot-security-entra-investigate-risky-apps.md#explore-microsoft-entra-applications-outside-my-tenant)

## Microsoft Entra ID Governance

The following sections describe how to use Microsoft Security Copilot for various scenarios and use cases within Microsoft Entra ID Governance.

### Entitlement management

Use Microsoft Security Copilot with Microsoft Entra ID Governance entitlement management to get quick access to information about access packages, policies, connected organizations, and catalog resources.

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

### Access reviews

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

### Privileged Identity Management (PIM)

With Microsoft Security Copilot, you can easily manage and monitor privileged access in your organization using natural language queries. Security Copilot integrates with Microsoft Entra Privileged Identity Management (PIM) to provide instant insights into just-in-time role assignments, group memberships, and access to critical resources. By leveraging AI-powered analysis, Security Copilot helps you quickly identify who has eligible or active PIM assignments, track changes, and respond to potential risks—streamlining privileged access management and strengthening your security posture.

Using this feature requires a at least the roles of [Security Administrator](/entra/identity/role-based-access-control/permissions-reference#security-administrator), [Global Reader](/entra/identity/role-based-access-control/permissions-reference#global-reader), or [Security Reader](/entra/identity/role-based-access-control/permissions-reference#security-reader) in Microsoft Entra ID. You will also need a [Microsoft Entra ID P2 license](/entra/id-protection/overview-identity-protection#license-requirements), and a tenant with PIM configured.

- *Which PIM roles are currently assigned to the user karita@woodgrovebank.com?*
- *Which PIM eligible roles are assigned to the user casey@woodgrovebank.com?*
- *Who has PIM eligible assignment of Security Reader?*
- *Who has PIM active assignment of Cloud Application Administrator?*

### Lifecycle workflows

Microsoft Entra ID Governance applies the capabilities of [Microsoft Security Copilot](/security-copilot/microsoft-security-copilot) to save identity administrators time and effort when configuring custom workflows to manage the lifecycle of users across JML scenarios. It also helps you to customize workflows more efficiently using natural language to configure workflow information including custom tasks, execute workflows, and get workflow insights.

Using this feature requires a minimum of the [Lifecycle Workflows Administrator](/entra/identity/role-based-access-control/permissions-reference#lifecycle-workflows-administrator) role in Microsoft Entra ID, and a Microsoft Entra.

Refer to the prompts and examples in [Manage employee lifecycle using Microsoft Security Copilot](./copilot-entra-lifecycle-workflow.md) to learn how to use Microsoft Security Copilot with lifecycle workflows for the following use-cases;

- [Create step-by-step guidance for a new lifecycle workflow](./copilot-entra-lifecycle-workflow.md#create-step-by-step-guidance-for-a-new-lifecycle-workflow)
- [Explore available workflow configurations](./copilot-entra-lifecycle-workflow.md#explore-available-workflow-configurations)
- [Analyze active workflow lists](./copilot-entra-lifecycle-workflow.md#analyze-active-workflow-list)
- [Troubleshoot a Lifecycle Workflow run](./copilot-entra-lifecycle-workflow.md#troubleshoot-a-lifecycle-workflow-run)
- [Compare versions of a lifecycle workflow](./copilot-entra-lifecycle-workflow.md#compare-versions-of-a-lifecycle-workflow)

## Microsoft Entra Internet Access and Private Access

The following sections describe how to use Microsoft Security Copilot for scenarios and use cases within Global Secure Access.

### License Usage 

Managing license purchases and usage across your Microsoft Entra tenant can be challenging. Microsoft Security Copilot simplifies this process by allowing administrators to ask natural language questions about license usage, such as “How many Microsoft Entra P2 licenses are in use?” or “How many users are using Conditional Access?” Security Copilot provides clear and actionable answers in seconds, helping your organization optimize license utilization and get the most value from your Microsoft Entra investment.

This feature requires a minimum of the [Global Reader](/entra/identity/role-based-access-control/permissions-reference#global-reader) role in Microsoft Entra ID, and can be used with any tenant and a [Microsoft Entra ID Governance license](/entra/id-governance/licensing-fundamentals).

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
