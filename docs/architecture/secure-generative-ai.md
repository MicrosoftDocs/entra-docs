---
title: Secure Generative AI with Microsoft Entra
description: Learn how to mitigate specific security challenges that Generative AI (Gen AI) poses to ensure organizational security with Microsoft Entra.
author: gargi-sinha
ms.author: gasinh
manager: martinco
ms.service: entra
ms.subservice: architecture
ms.topic: conceptual
ms.date: 11/12/2024
ms.reviewer: joflore
ms.custom: sfi-ga-nochange
#CustomerIntent: As an identity and security administrator, I want to mitigate security challenges that Generative AI (Gen AI) poses, so that I can ensure organizational security with Microsoft Entra.
---
# Secure Generative AI with Microsoft Entra

As the digital landscape rapidly evolves, organizations across various industries increasingly adopt [Generative Artificial Intelligence](/ai/playbook/technology-guidance/generative-ai/) (Gen AI) to drive innovation and enhance productivity. A recent [research study](https://techcommunity.microsoft.com/t5/security-compliance-and-identity/security-for-ai-how-to-secure-and-govern-ai-usage/ba-p/4082269) indicates that 93% of businesses are implementing or developing an AI strategy. Approximately the same percentage of risk leaders report feeling under-prepared or only somewhat prepared to address the associated risks. As you integrate Gen AI into your operations, you must mitigate significant security and governance risks.

Microsoft Entra offers a comprehensive suite of capabilities to securely manage AI applications, appropriately control access, and protect sensitive data:

- [Microsoft Entra Permissions Management](../permissions-management/overview.md) (MEPM)
- [Microsoft Entra ID Governance](/graph/api/resources/identitygovernance-overview)
- [Microsoft Entra Conditional Access](../identity/conditional-access/overview.md)
- [Microsoft Entra Privileged Identity Management](../id-governance/privileged-identity-management/pim-configure.md) (PIM)
- [Microsoft Purview Insider Risk](/purview/insider-risk-management-adaptive-protection)

This article delves into the specific security challenges that Gen AI poses and how you can address them with the capabilities offered by Microsoft Entra.

## Discover overprivileged identities

Ensure that users have the appropriate permissions to comply with the [principle of least privilege](../identity-platform/secure-least-privileged-access.md). Based on our telemetry, over 90% of identities use less than 5% of permissions granted. Over 50% of those permissions are high risk. Compromised accounts can cause catastrophic damage.

Multicloud environment management is difficult as Identity and Access Management (IAM) and security teams often need to collaborate cross-functionally. Multicloud environments can limit comprehensive view into identities, permissions, and resources. This limited view increases the attack surface on identities that have overly privileged roles and over permissioned accounts. Risk of compromised unused accounts with high permissions increases as organizations adopt multicloud.

### Identify nonhuman accounts

Nonhuman accounts have repeatable patterns and are less likely to change over time. When you identify these accounts, consider using [workload or managed identities](../workload-id/workload-identities-overview.md) and Microsoft Entra Permissions Management. Permissions Management is a Cloud Infrastructure Entitlement Management (CIEM) tool. It provides comprehensive visibility into permissions that you assign to all identities across Azure, Amazon Web Services (AWS), and Google Cloud Platform (GCP).

Trim roles down to the [Zero Trust](/security/zero-trust/zero-trust-overview) least privilege access security principle. Pay close attention to [super identities](https://techcommunity.microsoft.com/blog/identity/securing-access-to-any-resource-anywhere/4120308) (such as [serverless functions and apps](https://azure.microsoft.com/resources/cloud-computing-dictionary/what-is-serverless-computing)). Factor in use cases for Gen AI applications.

### Enforce just-in-time access for Microsoft Entra roles

Microsoft Entra Privileged Identity Management (PIM) helps you manage, control, and monitor access to resources in Microsoft Entra ID, Azure, and other Microsoft Online Services (such as Microsoft 365 or Microsoft Intune). Non-PIM enabled privileged users have standing access (always in their assigned roles even when they don't need their privileges). The PIM [discovery and insights page](../id-governance/privileged-identity-management/pim-security-wizard.md) shows permanent Global Administrator assignments, accounts with highly privileged roles, and service principals with privileged role assignments. When you see these permissions, make note of what should be normal for your environment. Consider trimming down these roles or reducing them to just-in-time (JIT) access with PIM eligible assignments.

Directly within the discovery and insights page, you can make privileged roles PIM-eligible to reduce standing access. You can remove the assignment altogether if they don't need privileged access. You can create an access review for Global Administrators that prompts them to regularly review their own access.

## Enable access controls

Permission creep creates a risk of unauthorized access and restricted company data manipulation. Secure AI applications with the same governance rules that you apply to all corporate resources. To achieve this goal, define and roll out granular access policies for all users and company resources (including Gen AI apps) with ID Governance and Microsoft Entra Conditional Access.

Ensure that only the right people have the right access level for the right resources. Automate access lifecycles at scale through controls with Entitlement Management, Lifecycle Workflows, access requests, reviews, and expirations.

Govern your [Joiner, Mover, and Leaver (JML)](../id-governance/understanding-lifecycle-workflows.md) user processes with Lifecycle Workflows and control access in ID Governance.

### Configure policies and controls to govern user access

Use [Entitlement Management](../id-governance/entitlement-management-overview.md) in ID Governance to control who can access applications, groups, Teams, and SharePoint sites with multi-stage approval policies.

[Configure automatic assignment](../id-governance/entitlement-management-access-package-auto-assignment-policy.md) policies in Entitlement Management to automatically give users access to resources based on user properties such as department or cost center. Remove user access when those properties change.

To right size access, we recommend that you apply an [expiration date](../id-governance/entitlement-management-access-package-lifecycle-policy.md) and/or periodic [access review](../id-governance/entitlement-management-access-reviews-create.md) to entitlement management policies. These requirements ensure users don't indefinitely retain access through time-limited assignments and recurring application access reviews.

### Enforce organizational policies with Microsoft Entra Conditional Access 

Conditional Access brings signals together to make decisions and enforce organizational policies. Conditional Access is Microsoft's [Zero Trust policy engine](/security/zero-trust/deploy/identity) that takes into account signals from various sources to enforce policy decisions.

Enforce least privilege principles and apply the right access controls to keep your organization secure with [Conditional Access policies](../identity/conditional-access/plan-conditional-access.md). Think of Conditional Access policies as if-then statements where identities that meet certain criteria can only access resources if they meet specific requirements such as MFA or device compliance status.

[Restrict access to Gen AI apps based on signals](/entra/identity/conditional-access/policy-all-users-copilot-ai-security) like users, groups, roles, location, or risk to enhance policy decisions.

- Use the [authentication strength](../identity/authentication/concept-authentication-strengths.md) Conditional Access control that specifies combinations of authentication methods to access a resource. Require users to complete [phishing-resistant multifactor authentication](../identity/conditional-access/policy-all-users-mfa-strength.md) (MFA) to access Gen AI apps.
- Deploy [Microsoft Purview adaptive protection](/purview/insider-risk-management-adaptive-protection) to mitigate and manage AI usage risks. Use the [Insider Risk](../identity/conditional-access/concept-conditional-access-conditions.md#insider-risk) condition to [block Gen AI apps access for users with elevated insider risk](../identity/conditional-access/policy-risk-based-insider-block.md).
- Deploy [Microsoft Intune device compliance policies](/mem/intune/protect/device-compliance-get-started) to incorporate device compliance signals into Conditional Access policy decisions. Use the device compliance condition to [require users to have a compliant device to access Gen AI apps.](../identity/conditional-access/policy-all-users-device-compliance.md)

After you deploy Conditional Access policies, use the [Conditional Access gap analyzer workbook](../identity/monitoring-health/workbook-conditional-access-gap-analyzer.md) to identify sign-ins and applications where you aren't enforcing these policies. We recommend deploying at least one [Conditional Access policy that targets all resources](../identity/conditional-access/policy-all-users-mfa-strength.md) to ensure baseline access control.

### Enable automation to manage employee identity lifecycle at scale

Give users access to information and resources only if they have a genuine need for them to perform their tasks. This approach prevents unauthorized access to sensitive data and minimizes potential security breach impact. Use automated [user provisioning](../id-governance/what-is-provisioning.md) to reduce unnecessary granting of access rights.

Automate lifecycle processes for Microsoft Entra users at scale with [Lifecycle Workflows](../id-governance/what-are-lifecycle-workflows.md) in ID Governance. Automate workflow tasks to right size user access when key events occur. Example events include before a new employee is scheduled to start work at the organization, as employees change status, and as employees leave the organization.

### Govern highly privileged administrative role access

There might be cases where identities require higher privilege access due to business/operational requirements such as [break glass](../identity/role-based-access-control/security-emergency-access.md) accounts.

[Privileged accounts](/security/privileged-access-workstations/privileged-access-accounts) should have the highest protection level. Compromised privileged accounts can cause potentially significant or material impact on organizational operations.

Only assign authorized users to administrative [roles](/azure/role-based-access-control/rbac-and-directory-admin-roles) in [Microsoft Azure](../id-governance/privileged-identity-management/pim-resource-roles-assign-roles.md) and [Microsoft Entra](../id-governance/privileged-identity-management/pim-how-to-add-role-to-user.md). Microsoft recommends you require phishing-resistant MFA on the following roles at a minimum:

[!INCLUDE [conditional-access-admin-roles](../includes/conditional-access-admin-roles.md)]

Your organization might choose to include or exclude roles based on requirements. To review role memberships, configure and use [directory role access reviews](../id-governance/privileged-identity-management/pim-create-roles-and-resource-roles-review.md).

Apply role-based access control using Privileged Identity Management (PIM) and just-in-time (JIT) access. PIM provides JIT access to resources by assigning time-bound access. Eliminate standing access to lower risk of excessive or misused access. PIM allows for approval and justification requirements, MFA enforcement for role activation, and audit history.

### Manage external guest identity lifecycle and access

In most organizations, end-users invite [business partners (B2B)](../external-id/what-is-b2b.md) and vendors for collaboration and provide access to applications. Typically, collaboration partners receive application access during the onboarding process. When collaborations don't have a clear end date, it isn't clear when a user no longer needs access.

[Entitlement Management](../id-governance/entitlement-management-overview.md) features enable [automated lifecycle of external identities](../id-governance/entitlement-management-external-users.md#manage-the-lifecycle-of-external-users) with access to resources. Establish processes and procedures to manage access through Entitlement Management. Publish resources through access packages. This approach helps you to track external user access to resources and reduce the problem's complexity.

When you authorize employees to collaborate with external users, they can invite any number of users from outside your organization. If [external identities](../external-id/external-identities-overview.md) use applications, [Microsoft Entra access reviews](../id-governance/create-access-review.md) help you to review access. You can let the resource owner, external identities themselves, or another delegated person you trust attest to whether they require continued access.

Use Microsoft Entra access reviews to block external identities from signing in to your tenant and deleting external identities from your tenant after 30 days.

### Enforce data security and compliance protections with Microsoft Purview

Use [Microsoft Purview](/purview/ai-microsoft-purview) to mitigate and manage the risks associated with AI usage. Implement corresponding protection and governance controls. Microsoft Purview AI Hub is currently in preview. It provides easy-to-use graphical tools and reports to quickly gain insights into AI use within your organization. One-click policies help you protect your data and comply with regulatory requirements.

Within Conditional Access, you can enable Microsoft Purview Adaptive Protection to flag behavior that's indicative of insider risk. Apply Adaptive Protection as you apply [other Conditional Access controls](../identity/monitoring-health/recommendation-insider-risk-condition.md) to prompt the user for MFA or provide other actions based on your use cases.

## Monitor access

Monitoring is crucial to detect potential threats and vulnerabilities early. Watch for [unusual activities and configuration changes](../id-governance/governance-custom-alerts.md#custom-alert-notifications) to prevent security breaches and maintain data integrity.

Continually review and monitor access to your environment to discover suspicious activity. Avoid permissions creep and get alerts when things unintentionally change.

- To proactively monitor your environment for configuration changes and suspicious activity, [integrate Microsoft Entra ID Audit Logs with Azure Monitor](../identity/monitoring-health/howto-configure-diagnostic-settings.md).
- Configure [security alerts](../id-governance/privileged-identity-management/pim-how-to-configure-security-alerts.md) to monitor when users activate privileged roles.
- Watch for atypical user usage patterns with [Microsoft Entra ID Protection](../id-protection/concept-identity-protection-risks.md). Atypical usage might indicate that a bad actor is poking around and inappropriately using Gen AI tools.

In some scenarios, you might only use AI applications seasonally. For example, financial apps might have low usage outside of tax and audit season while retail apps might have usage spikes during the holiday season. Disable accounts that go unused for a significant period, especially external partner accounts, with Lifecycle Workflows. Consider seasonality if JIT or temporary account deactivation is more appropriate.

Ideally, all users follow access policies to secure access to organizational resources. When you need to use Conditional Access policies with exclusions for individual users or guests, you can avoid policy exception oversight. Use Microsoft Entra access reviews to provide auditors with proof of regular exception review.

Continually review Permissions Management. As identities stay with an organization, they tend to gather permissions while they work on new projects or move teams. Monitor the Permissions Creep Index (PCI) score within Permissions Management and set up monitoring and alerting capabilities. This approach reduces gradual permissions creep and decreases the blast radius around compromised user accounts.

- [Configure reports to regularly run](../permissions-management/how-to-audit-trail-results.md). [Configure custom reports](../permissions-management/report-create-custom-report.md) for specific use cases, especially for identities that need to access Gen AI apps.
- To monitor permissions creep across [Azure, AWS, and GCP](../permissions-management/onboard-enable-tenant.md), use Permissions Management. Apply recommendations to workload identities to ensure that your Gen AI apps don't have excessive permissions or have more permissions added over time than necessary.

## Related content

- [Microsoft Security Copilot](/copilot/security/microsoft-security-copilot) helps support security professionals in end-to-end scenarios such as incident response, threat hunting, intelligence gathering, and posture management.
- [Microsoft Purview Information Barriers](/purview/information-barriers) are policies that can prevent individuals or groups from communicating with each other. [Information barriers in Microsoft Teams](/purview/information-barriers-teams) can determine and prevent unauthorized collaborations.
- For [Microsoft 365 Copilot requirements](/microsoft-365-copilot/microsoft-365-copilot-requirements), review [Enterprise data protection in Copilot for Microsoft 365 and Microsoft Copilot](/copilot/microsoft-365/enterprise-data-protection#what-is-enterprise-data-protection-in-copilot-for-microsoft-365-and-microsoft-copilot).
