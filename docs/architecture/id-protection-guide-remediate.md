---
title: Microsoft Entra ID Protection to Self-Remediate User Risk
description: Learn how IT administrators use Microsoft Entra ID Protection to identify and remediate identity risks for users that access enterprise-managed resources.
author: gargi-sinha
manager: martinco
ms.author: gasinh
ms.service: entra-id-protection
ms.topic: concept-article
ms.date: 08/21/2025

#CustomerIntent: As an IT administrator, I want to use Microsoft Entra ID Protection to identify and remediate identity risks so that I can protect users that access enterprise-managed resources.
---
# Microsoft Entra ID Protection scenario: user identity risk self-remediation for enterprise-managed resources

The proof-of-concept (PoC) guidance in this series of articles helps you to learn, deploy, and test Microsoft Entra ID Protection to detect, investigate, and remediate identity-based risks.

An overview of the guidance begins with [Introduction to Microsoft Entra ID Protection proof-of-concept guidance](id-protection-guide-introduction.md).

Detailed guidance continues with these scenarios:

- [Use real-time risk detection to grant access to protected resources](id-protection-guide-detect.md)
- [Bring identity risk-related telemetry into security investigations](id-protection-guide-investigate.md)

This article helps administrators to identify and remediate identity risks for users accessing enterprise-managed resources, including Microsoft 361. Use real-time and offline risk detections to evaluate sign-ins and user behavior. Apply automated responses such as multifactor authentication (MFA), password resets, or block access based on risk levels. Risk-based conditional access policies that scale across large environments enforce these protections.

Configure the following features for user self-remediation of identity risk for enterprise-managed resources with Microsoft Entra ID Protection:

- [Configure risky sign-in self-remediation](#configure-risky-sign-in-self-remediation)
- [Configure password reset protection and self-service](#configure-password-reset-protection-and-self-service)
- [Enforce Conditional Access](#enforce-conditional-access)
- [Configure visibility into account health](#configure-visibility-into-account-health)
- [Integrate with Microsoft Defender for incident correlation and investigation](/defender-xdr/incidents-overview)

## Configure risky sign-in self-remediation

Prompt Microsoft 365 users that you enroll in Microsoft Entra ID Protection to complete multifactor authentication (MFA) upon [risky sign-in detection](../id-protection/howto-identity-protection-remediate-unblock.md).

## Configure password reset protection and self-service

Configure password protection features, especially in large Microsoft 365 environments where password hygiene and autonomy are critical.

1. Configure [password protection policies](../identity/authentication/concept-password-ban-bad.md) that block weak or banned passwords.
1. To allow users to securely recover access with multiple authentication methods, configure [self-service password reset (SSPR)](../id-protection/howto-identity-protection-configure-risk-policies.md#user-risk-policy-in-conditional-access).
1. [Move to phishing-resistant passwordless authentication.](../identity/authentication/how-to-plan-prerequisites-phishing-resistant-passwordless-authentication.md)

## Enforce Conditional Access

Configure Conditional Access policies for users with dynamic enforcement based on:

1. [Sign-in risk](../id-protection/concept-identity-protection-risks.md) (such as from an unfamiliar location or device)
1. [User risk](../id-protection/concept-identity-protection-risks.md#user-risk-detections) (such as leaked credentials or suspicious behavior)

Require users to verify their identity or restrict access to sensitive apps until after risk mitigation.

## Configure visibility into account health

Configure user alerts and notifications for the following scenarios:

1. Suspicious activity on their account
1. Required actions to maintain access (such as reauthentication or device compliance)

## Next steps

- [Introduction to Microsoft Entra ID Protection proof-of-concept guidance](id-protection-guide-introduction.md)
- [Use real-time risk detection to grant access to protected resources](id-protection-guide-detect.md)
- [Bring identity risk-related telemetry into security investigations](id-protection-guide-investigate.md)
