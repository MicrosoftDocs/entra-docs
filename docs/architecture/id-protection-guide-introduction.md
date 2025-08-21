---
title: Microsoft Entra ID Protection Proof-of-Concept Guidance
description: Learn, deploy, and test Microsoft Entra ID Protection so that you can detect, investigate, and remediate identity-based risks.
author: gargi-sinha
manager: martinco
ms.author: gasinh
ms.service: entra-id-protection
ms.topic: concept-article
ms.date: 08/21/2025

#CustomerIntent: As an IT admin, I want to learn, deploy, and test Microsoft Entra ID Protection so that I can detect, investigate, and remediate identity-based risks.
---
# Introduction to Microsoft Entra ID Protection proof-of-concept guidance

The proof-of-concept (PoC) guidance in this series of articles helps you to learn, deploy, and test Microsoft Entra ID Protection to detect, investigate, and remediate identity-based risks. Detailed guidance for specific scenarios continues in these articles:

- [Use real-time risk detection to grant access to protected resources](id-protection-guide-detect.md)
- [Bring identity risk-related telemetry into security investigations](id-protection-guide-investigate.md)
- [Allow users to self-remediate identity risk for enterprise-managed resources](id-protection-guide-remediate.md)

This guide assumes you're running a PoC in a production environment. Running a PoC in a test environment might give you more flexibility. Follow the guidance in these articles to ensure a successful Microsoft Entra ID Protection PoC launch.

## Understand the products

Understanding the products and their core concepts is the first step toward running a successful PoC. Start with the resources in this section:

- [What is Microsoft Entra ID Protection?](../id-protection/overview-identity-protection.md) explains how you can feed identity-based risks into tools like Conditional Access (CA) to make access decisions. You can also send them to a security information and event management (SIEM) tool for investigation and correlation.

  - Tables in the [What are risk detections](../id-protection/concept-identity-protection-risks.md) article summarize sign-in and user risk detections, their license requirements, and whether the detection occurs in real-time or offline.
  - [How to investigate risks](../id-protection/howto-identity-protection-investigate-risk.md) describes how to use Microsoft Entra ID Protection reports to investigate identity risks in your environment.
  - [Risk policies](../id-protection/howto-identity-protection-configure-risk-policies.md) explains how to use the sign-in risk policy and user risk policy to allow users to self-remediate detected risks.
  - [Microsoft Graph PowerShell SDK and Microsoft Entra ID Protection](../id-protection/howto-identity-protection-graph-api.md) shows you how to use Microsoft Graph data to manage risky users.
  - [How to export risk data](../id-protection/howto-export-risk-data.md) describes methods to export risk data from Microsoft Entra ID Protection for long-term storage and analysis.

- [Plan a Microsoft Entra ID Protection deployment](../id-protection/how-to-deploy-identity-protection.md) provides step-by-step guidance that extends concepts in the [Conditional Access deployment plan](../identity/conditional-access/plan-conditional-access.md). Follow detailed instructions for these steps:

  - Configure [Microsoft Entra ID Protection notifications](../id-protection/howto-identity-protection-configure-notifications.md).
  - [Configure the MFA registration policy](../id-protection/howto-identity-protection-configure-mfa-policy.md).
  - Configure and enable [risk policies](../id-protection/howto-identity-protection-configure-risk-policies.md).
  - [Simulate risk detections](../id-protection/howto-identity-protection-simulate-risk.md).
  - [Provide risk feedback](../id-protection/howto-identity-protection-risk-feedback.md).

- The [Impact analysis of risk-based access policies workbook](../id-protection/workbook-risk-based-policy-impact.md) shows you how to immediately view risk impact from sign-in logs.
- Review the [Microsoft Entra ID Protection Power Platform connector reference guide](/connectors/azureadip/) for these services: Copilot Studio, Logic Apps, Power Apps, and Power Automate.

## Meet prerequisites

To kick off a Microsoft Entra ID Protection PoC, you need these prerequisites.

- An enabled working Microsoft Entra tenant with Microsoft Entra ID P2 or trial license. You can [create one for free](https://azure.microsoft.com/free/).
- Microsoft 365 E5 or Microsoft Enterprise Mobility + Security E5 licenses for some risk detections.
- One or more of the following role assignments, depending on tasks performed. To follow the [Zero Trust principle of least privilege](/security/zero-trust/), consider using [Privileged Identity Management (PIM)](../id-governance/privileged-identity-management/pim-configure.md) to just-in-time activate privileged role assignments.

  - Read Microsoft Entra ID Protection and Conditional Access policies and configurations

    - [Security Reader](../identity/role-based-access-control/permissions-reference.md#security-reader)
    - [Global Reader](../identity/role-based-access-control/permissions-reference.md#global-reader)

  - Manage Microsoft Entra ID Protection

    - [Security Operator](../identity/role-based-access-control/permissions-reference.md#security-operator)
    - [Security Administrator](../identity/role-based-access-control/permissions-reference.md#security-administrator)

  - Create or modify Conditional Access policies

    - [Conditional Access Administrator](../identity/role-based-access-control/permissions-reference.md#conditional-access-administrator)
    - [Security Administrator](../identity/role-based-access-control/permissions-reference.md#security-administrator)

  - A test user who isn't an administrator to verify that policies work as expected before you deploy real users. To create a user, follow the steps in [How to create, invite, and delete users](../fundamentals/how-to-create-delete-users.yml).

- A group of which the user is a member. To create a group, see [Create a group and add members in Microsoft Entra ID](../fundamentals/how-to-manage-groups.yml).

## Identify use cases and plan configuration and testing

While you design your PoC, identify relevant use cases and plan for appropriate configuration and testing.

For all scenarios, plan to include the following steps:

1. Review the [Microsoft Entra ID Protection reports](../id-protection/howto-identity-protection-investigate-risk.md). Before you deploy risk-based Conditional Access policies, investigate existing suspicious behavior. Determine criteria to dismiss risks or confirm users as safe.

- [Investigate risk detections](../id-protection/howto-identity-protection-investigate-risk.md)
- [Remediate risks and unblock users](../id-protection/howto-identity-protection-remediate-unblock.md)
- [Make bulk changes using Microsoft Graph PowerShell](../id-protection/howto-identity-protection-graph-api.md)

1. Plan for Conditional Access risk policies. Microsoft Entra ID Protection sends risk signals to Conditional Access to make decisions and enforce organizational policies. These policies might require users to perform [multifactor authentication](../identity/authentication/howto-mfa-getstarted.md) (MFA) or secure password change.

- Exclude [Emergency Access/Break-Glass](../identity/role-based-access-control/security-emergency-access.md) and [Service accounts/Service principals](../identity/managed-identities-azure-resources/overview.md) (such as Microsoft Entra Connect Sync) accounts from your policies.
- Deploy MFA so users can self-remediate risk. Users need to be able to perform MFA to self-remediate.

1. Configure [named locations in Conditional Access](../identity/conditional-access/concept-assignment-network.md#how-are-these-locations-defined).
1. Add your VPN ranges to [Microsoft Defender for Cloud Apps](/defender-cloud-apps/ip-tags#create-an-ip-address-range).
1. Scope and define success criteria.
1. Test everything in [Report-only mode](../identity/conditional-access/howto-conditional-access-insights-reporting.md), a Conditional Access policy state that allows you to evaluate the effect of Conditional Access policies before enforcement.
1. Compile a comprehensive report on PoC results.
1. Make recommendations for full-scale implementation based on PoC findings.
1. Outline a timeline and resource plan for deployment.

## Microsoft Entra ID Protection licensing

Review the following table for licensing requirements for Microsoft Entra ID Protection key capabilities. The [Microsoft Entra plans and pricing](https://www.microsoft.com/security/business/microsoft-entra-pricing) page provides additional information to help you select the best option for your identity needs.

|Capability|Details|Microsoft Entra ID Free / Microsoft 365 Apps|Microsoft Entra ID|Microsoft Entra ID P2 / Microsoft Entra Suite|
|---|---|---|---|---|
|Risk policies|Sign-in and user risk policies (via ID Protection or Conditional Access)|No|No|Yes|
|Security reports|Overview|No|No|Yes|
|Security reports|Risky users|Limited information. Shows only users with medium and high risk. No details drawer or risk history.|Limited information. Shows only users with medium and high risk. No details drawer or risk history.|Full access|
|Security reports|Risky sign-ins|Limited information. No risk detail or risk level.|Limited information. No risk detail or risk level.|Full access|
|Security reports|Risk detections|No|Limited information. No details drawer.|Full access|
|Notifications|Users at risk detected alerts|No|No|Yes|
|Notifications|Weekly digest|No|No|Yes|
|MFA registration policy|Require MFA (via Conditional Access)|No|No|Yes|
|Microsoft Graph|All risk reports|No|No|Yes|

If you [secure workload identities](../id-protection/concept-workload-identity-risk.md), you need Workload Identities Premium licensing to view the Risky workload identities report and the Workload identity detections tab in the Risk detections report.

If you want Microsoft Entra ID Protection to receive signals from Microsoft Defender products, you need the appropriate Microsoft Defender license.

Microsoft 365 E5 covers these signals:

- Microsoft Defender for Cloud Apps

  - Activity from anonymous IP address
  - Impossible travel
  - Mass access to sensitive files
  - New country/region

- Microsoft Defender for Office 365 (suspicious inbox rules)
- Microsoft Defender for Endpoint (possible attempt to access primary refresh token)

## Next steps

- [Use real-time risk detection to grant access to protected resources](id-protection-guide-detect.md)
- [Bring identity risk-related telemetry into security investigations](id-protection-guide-investigate.md)
- [Allow users to self-remediate identity risk for enterprise-managed resources](id-protection-guide-remediate.md)
