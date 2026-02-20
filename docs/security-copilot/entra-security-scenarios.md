---
title: Microsoft Security Copilot scenarios in Microsoft Entra overview
description: Learn about the Microsoft Security Copilot scenarios across Microsoft Entra products and services.
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
# Customer intent: As an identity administrator, I want to understand the Microsoft Security Copilot scenarios available across Microsoft Entra products so I can improve my organization's security posture.
---

# Microsoft Security Copilot scenarios in Microsoft Entra overview

Microsoft Security Copilot is a powerful tool that can help you manage and secure your Microsoft Entra identity environment. This article outlines the different capabilities in Microsoft Entra that you can investigate using natural language queries. These capabilities are available across different Microsoft Entra products to enhance your identity protection efforts. To use Security Copilot in Microsoft Entra, ensure that you have a tenant with Security Copilot enabled.

## Microsoft Security Copilot integration with Microsoft Entra

Security Copilot is a part of the Microsoft Entra admin center, and you can use it to create your own prompts. Security Copilot is launched from a globally available button in the menu bar. Choose from a set of starter prompts that appear at the top of the Security Copilot window or enter your own in the prompt bar to get started. Suggested prompts can appear after a response, which are predefined prompts that Security Copilot selects based on the prior response.

:::image type="content" source="./media/copilot-security-entra/security-copilot-entra-admin-center.png" alt-text="Screenshot that shows Security Copilot in the Microsoft Entra admin center.":::

### Data exploration using Microsoft Security Copilot (preview)

Microsoft Security Copilot supports data exploration when prompts return datasets with more than 10 items. This feature is in preview and available for select Microsoft Entra scenarios. From the Copilot chat response, select **Open list** to access a comprehensive data grid. This allows you to explore large datasets with complete and accurate results, enabling more efficient decision-making. Each data grid displays the underlying Microsoft Graph URL, helping you verify query accuracy and build confidence in the results.

> [!NOTE]
> This functionality is currently in preview and limited to simple, single-step prompts (for example *"Provide a list of users in the Sales department"*). Tasks that require multi-step prompting and cross scenario functionality (for example *"Which risky apps have high privileged permissions?"*) are not currently supported by this feature. Copilot will still provide chat-based summaries for all prompts.

:::image type="content" source="./media/copilot-security-entra/data-explorer.png" alt-text="Screenshot that shows Data Exploration in Security Copilot for Microsoft Entra." lightbox="./media/copilot-security-entra/data-explorer.png":::

## Security Copilot scenarios in Microsoft Entra

There's a large selection of Security Copilot scenarios available in Microsoft Entra. Use the following table to learn more about each scenario by product area, their use cases, license and role requirements.

| Microsoft Entra product | Security Copilot scenarios | Data Exploration Enabled |
| --- | --- |:---:|
| **Microsoft Entra ID** | [Tenants](./entra-id-scenarios.md#tenants)<br>[Users](./entra-id-scenarios.md#users)<br>[Groups](./entra-id-scenarios.md#groups)<br>[Domains](./entra-id-scenarios.md#domains)<br>[Licenses](./entra-id-scenarios.md#licenses)<br>[Sign-in logs](./entra-id-scenarios.md#sign-in-logs)<br>[Audit logs](./entra-id-scenarios.md#audit-logs)<br>[Provisioning logs](./entra-id-scenarios.md#provisioning-logs)<br>[Recommendations](./entra-id-scenarios.md#recommendations)<br>[Health monitoring alerts](./entra-id-scenarios.md#health-monitoring-alerts)<br>[Service Level Agreement](./entra-id-scenarios.md#service-level-agreement)<br>[Roles and administrators](./entra-id-scenarios.md#roles-and-administrators)<br>[Devices](./entra-id-scenarios.md#devices)<br>[Conditional Access](./entra-id-scenarios.md#conditional-access)<br>[Authentication](./entra-id-scenarios.md#authentication) | ![Tenants data exploration enabled](../media/common/applies-to-yes.png) <br> ![Users data exploration enabled](../media/common/applies-to-yes.png) <br> ![Groups data exploration enabled](../media/common/applies-to-yes.png) <br> ![Domains data exploration enabled](../media/common/applies-to-yes.png) <br> ![Licenses data exploration enabled](../media/common/applies-to-no.png) <br> ![Sign in logs data exploration enabled](../media/common/applies-to-yes.png) <br> ![Audit logs data exploration enabled](../media/common/applies-to-yes.png) <br> ![Provisioning logs data exploration enabled](../media/common/applies-to-no.png) <br> ![Recommendations data exploration enabled](../media/common/applies-to-yes.png) <br> ![Health monitoring alerts data exploration enabled](../media/common/applies-to-yes.png) <br> ![Service Level Agreement data exploration enabled](../media/common/applies-to-yes.png) <br> ![Role and administrators data exploration enabled](../media/common/applies-to-yes.png) <br> ![Devices data exploration enabled](../media/common/applies-to-yes.png) <br> ![Conditional access data exploration enabled](../media/common/applies-to-yes.png) <br> ![Authentication data exploration enabled](../media/common/applies-to-yes.png)| 
| **Microsoft Entra ID Protection** | [Risky users](./entra-id-protection-scenarios.md#risky-users)<br>[Application risk](./entra-id-protection-scenarios.md#application-risk) | ![Risky users data exploration enabled](../media/common/applies-to-yes.png) <br> ![Application risk data exploration enabled](../media/common/applies-to-yes.png)| 
| **Microsoft Entra ID Governance** | [Access reviews](./entra-id-governance-scenarios.md#access-reviews)<br>[Entitlement management](./entra-id-governance-scenarios.md#entitlement-management)<br>[Privileged Identity Management (PIM)](./entra-id-governance-scenarios.md#privileged-identity-management-pim)<br>[PIM write actions](./entra-id-governance-scenarios.md#privileged-identity-management-pim-write-actions)<br>[Lifecycle workflows](./entra-id-governance-scenarios.md#lifecycle-workflows) | ![Access reviews data exploration enabled](../media/common/applies-to-yes.png) <br> ![Entitlement management data exploration enabled](../media/common/applies-to-yes.png) <br> ![Privileged Identity Management (PIM) data exploration enabled](../media/common/applies-to-yes.png) <br> ![Privileged Identity Management (PIM) write actions data exploration enabled](../media/common/applies-to-no.png) <br>![Lifecycle workflows data exploration enabled](../media/common/applies-to-yes.png)|
| **Microsoft Entra Internet Access**<br>**Microsoft Entra Private Access** | [Global Secure Access](./entra-internet-access-private-access-scenarios.md#global-secure-access) | ![Global Secure Access data exploration enabled](../media/common/applies-to-yes.png) |

## Microsoft Entra ID scenarios

Microsoft Entra ID is the foundational production of Microsoft Entra, and provides the essential identity, authentication, policy, and protection to secure users, devices, apps, and resources. Security Copilot enhances these capabilities across multiple areas:

- **Enterprise user management**: Quickly retrieve user, group, domain and license information
- **Authentication**: Discover enabled authentication methods, registration status, and overall authentication strategy
- **Role based access control (RBAC)**: Investigate role assignments within a directory
- **Conditional Access**: Understand and evaluate conditional access policies
- **Device identity**: Explore device details and compliance status

## Microsoft Entra ID Protection scenarios

Microsoft Entra ID Protection focuses on identity risk detection and remediation. Security Copilot provides AI-powered insights for:

- **Risky user investigation**: Summarize user risk levels and provide remediation recommendations
- **Application risk assessment**: Analyze workload identities and application permissions

## Microsoft Entra ID Governance scenarios

Microsoft Entra ID Governance helps you manage identity lifecycle and access governance at scale. Security Copilot enhances these capabilities for:

- **Access reviews**: Analyze access review data and decision patterns
- **Entitlement management**: Manage access packages and connected organizations
- **Privileged Identity Management**: Monitor privileged access and role assignments
- **Lifecycle workflows**: Configure and troubleshoot employee lifecycle automation

## Related content

- [Microsoft Security Copilot scenarios in Microsoft Entra ID](./entra-id-scenarios.md)
- [Microsoft Security Copilot scenarios in Microsoft Entra ID Protection](./entra-id-protection-scenarios.md)
- [Microsoft Security Copilot scenarios in Microsoft Entra ID Governance](./entra-id-governance-scenarios.md)
- [Get started with Microsoft Security Copilot](/copilot/security/get-started-security-copilot)
