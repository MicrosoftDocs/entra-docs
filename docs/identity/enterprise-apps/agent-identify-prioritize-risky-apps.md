---
title: Remediate risky apps
description: Learn how to use the App Lifecycle Management Agent to identify unused high-privileged applications and safely remediate risks through batch removal plans.
ms.author: jomondi
author: omondiatieno
manager: mwongerapk
ms.date: 11/14/2025
ms.service: entra-id
ms.subservice: enterprise-apps
ms.topic: how-to
ms.reviewer: ariels
#customer intent: As an IT administrator, I want to identify and safely remove unused high-privileged applications so that I can eliminate security vulnerabilities without disrupting business operations.
---

# Remediate risky apps

The App Lifecycle Management Agent identifies unused applications with high-privilege permissions and provides safe remediation workflows to reduce your organization's attack surface while maintaining operational continuity.

## Prerequisites

Before using the risk remediation features, ensure you have:

- At least one of the following Microsoft Entra roles:
  - [Application Administrator](/entra/identity/role-based-access-control/permissions-reference#application-administrator)
  - [Cloud Application Administrator](/entra/identity/role-based-access-control/permissions-reference#cloud-application-administrator)
- [Microsoft Entra ID P2 or Workload Identity Premium P2 license](/entra/fundamentals/licensing)
- Provisioned Security Copilot SCUs (Security Compute Units)

### Limitations

- Due to scale constraints, the agent currently limits unused application recommendations to 10,000, displaying up to all unused app recommendations that meet filtering criteria.
- Agent can only notify app owners from the latest report generated
- Agent doesn't support notifying unknown app owners not assigned in Microsoft Entra

## How it works

The agent analyzes applications and service principals in your tenant to identify unused apps with high-privilege permissions.

The agent performs these steps:

1. Scans applications: Analyzes all applications and service principals for high-privilege permissions
1. Checks usage patterns: Examines sign-in logs over the past 90 days to identify unused applications based on the [Microsoft Entra recommendation for removing unused applications](/entra/identity/monitoring-health/recommendation-remove-unused-apps?tabs=microsoft-entra-admin-center)
1. Identifies owners: Attempts to find application owners through Microsoft Entra registration data
1. Creates risk reports: Generates prioritized reports of unused high-privileged applications
1. Facilitates owner communication: Provides workflows to contact app owners for remediation decisions

## Review suggestions and agent logic

To review risk suggestions:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](../role-based-access-control/permissions-reference.md#cloud-application-administrator)
1. Browse to **Agents** in the left menu
1. Select the **App Lifecycle Management Agent (Preview)** card
1. Select **View details** to open the agent dashboard

### View risk suggestions

In the agent dashboard:

1. Navigate to the **Suggestions** tab
2. Look for these suggestion types:
   - **Review high privileged unused apps**
   - **Contact known app owners for remediation**
   - **Disable high privileged unused apps**

### Review unused app reports

To view detailed unused app information:

1. Select **Review suggestion** on the **Review high privileged unused apps** suggestion
2. Review the summary report showing:
   - Number of unused apps with high privileged permissions
   - Number of apps with assigned owners
   - Total unused applications (accessible via **View full list**)

      :::image type="content" source="media/agent-identify-prioritize-risky-apps/unused-high-privileged-apps-report.png" alt-text="Screenshot showing the summary report of unused high-privileged applications with metrics and details." lightbox="media/agent-identify-prioritize-risky-apps/unused-high-privileged-apps-report.png":::

### View agent's full activity

To understand the risk assessment process:

1. From any suggestion, select **View agent's full activity**
2. Review how the agent identified unused applications
3. Review the permissions and usage patterns considered. For more information, see [Investigate risky applications](/entra/security-copilot/entra-investigate-risky-apps#view-the-permissions-granted-on-a-microsoft-entra-service-principal)

### Create remediation plans

For detailed guidance on creating safe batch removal plans for unused applications, including customization options and execution workflows, see [Create remediation plans for unused applications with the App Lifecycle Management Agent](agent-app-lifecycle-remediation-plans.md).

## Related content

- [Discover and onboard apps with the App Lifecycle Management Agent](agent-app-lifecycle-discovery-onboard.md)
- [Microsoft Entra App Lifecycle Management Agent](agent-app-lifecycle-management.md)
- [Privacy and data security in Microsoft Security Copilot](/copilot/security/privacy-data-security)
