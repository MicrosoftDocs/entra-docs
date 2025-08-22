---
title: Microsoft Entra ID Protection to Investigate Risk Telemetry
description: Learn how Security Operations Center (SOC) admins use Microsoft Entra ID Protection to bring identity risk-related telemetry into security investigations. 
author: gargi-sinha
manager: martinco
ms.author: gasinh
ms.service: entra-id-protection
ms.topic: concept-article
ms.date: 08/22/2025

#CustomerIntent: As an SOC administrator, I want to use Microsoft Entra ID Protection so that I can bring identity risk-related telemetry into security investigations.
---
# Microsoft Entra ID Protection scenario: identity risk-related telemetry in security investigations

The proof-of-concept (PoC) guidance in this series of articles helps you to learn, deploy, and test Microsoft Entra ID Protection to detect, investigate, and remediate identity-based risks.

An overview of the guidance begins with [Introduction to Microsoft Entra ID Protection proof-of-concept guidance](id-protection-guide-introduction.md).

Detailed guidance continues with these scenarios:

- [Use real-time risk detection to grant access to protected resources](id-protection-guide-detect.md)
- [Allow users to self-remediate identity risk for enterprise-managed resources](id-protection-guide-remediate.md)

This article helps Security Operations Center (SOC) administrators to bring identity risk-related telemetry into security investigations.

Configure the following features for identity risk-related telemetry with Microsoft Entra ID Protection:

- [Investigate identity-based incidents](#investigate-identity-based-incidents)
- [Investigate with Microsoft Security Copilot](#investigate-with-microsoft-security-copilot-in-microsoft-entra)
- [Remediate and respond](#remediate-and-respond)
- [Review for audit and compliance](#review-for-audit-and-compliance)
- [Configure access in multitenant environments](#configure-access-in-multitenant-environments)

## Investigate identity-based incidents

Detect and investigate identity threats in the Microsoft Entra admin center or with Microsoft Graph APIs:

1. [Risky sign-ins](../id-protection/howto-identity-protection-investigate-risk.md#risky-sign-ins-report) (such as [impossible travel](../id-protection/howto-identity-protection-investigate-risk.md#investigating-atypical-travel-detections), [anonymous IPs, and malware-linked IPs](../id-protection/howto-identity-protection-investigate-risk.md#investigating-malicious-ip-address-detections))
1. [Risky users](../id-protection/howto-identity-protection-investigate-risk.md#risky-users-report) (such as accounts with [leaked credentials](../id-protection/howto-identity-protection-investigate-risk.md#investigating-leaked-credentials-detections) and [suspicious behavior](../id-protection/howto-identity-protection-investigate-risk.md#investigating-password-spray-detections))
1. [Risk detections](../id-protection/howto-identity-protection-investigate-risk.md#risk-detections-report) (such as [token replay](../id-protection/howto-identity-protection-investigate-risk.md#investigating-anomalous-token-and-token-issuer-anomaly-detections) and unfamiliar sign-in properties)

## Investigate with Microsoft Security Copilot in Microsoft Entra

Microsoft Security in Microsoft Entra brings together the power of artificial intelligence (AI) and human expertise to help admins and security teams to respond to threats and attacks faster. Through the embedded experience, you can investigate and resolve identity risks, assess identities, and quickly access complete complex tasks.

Use natural language prompts in [Microsoft Security Copilot](../fundamentals/copilot-security-entra-investigate-incident.md):

- Summarize why a user is risky.
- Retrieve sign-in logs, audit trails, and group memberships.
- Get remediation recommendations and links to documentation.

To learn more about Microsoft Security Copilot scenarios in Microsoft Entra, please read [this document](../fundamentals/copilot-entra-security-scenarios.md).

## Remediate and respond

After you confirm a threat:

1. Track that [risk-based Conditional Access](../id-protection/concept-identity-protection-policies.md) was triggered to block or challenge access.
1. Manually dismiss or confirm compromise to [remediate risks and unblock users](../id-protection/howto-identity-protection-remediate-unblock.md#administrator-manual-remediation).
1. [Initiate secure password resets or MFA re-registration](../id-protection/concept-identity-protection-user-experience.md).
1. Use response playbooks to guide next steps.

## Review for audit and compliance

Log and audit all SOC actions in Microsoft Entra to perform the following steps:

1. Review logs in the Microsoft Entra admin center.
1. For correlation and storage, export logs to [Azure Monitor Log Analytics](../identity/monitoring-health/howto-analyze-activity-logs-log-analytics.md), [Microsoft Sentinel](/azure/sentinel/overview?tabs=defender-portal), or your dedicated SIEM.
1. Generate alerts for specific actions (such as policy changes, user unblocks).

## Configure access in multitenant environments

For [multitenant environments](../identity/multi-tenant-organizations/defender-xdr-microsoft-entra-mto.md):

1. Configure [cross-tenant access policies](../external-id/cross-tenant-access-overview.md).
1. To limit scope, use [role-based access control](../identity/role-based-access-control/custom-overview.md) (such as Security Reader, Security Operator).
1. Automate deployment with [PowerShell or Microsoft Graph APIs](../id-protection/howto-identity-protection-graph-api.md).

## Next steps

- [Introduction to Microsoft Entra ID Protection proof-of-concept guidance](id-protection-guide-introduction.md)
- [Use real-time risk detection to grant access to protected resources](id-protection-guide-detect.md)
- [Allow users to self-remediate identity risk for enterprise-managed resources](id-protection-guide-remediate.md)
