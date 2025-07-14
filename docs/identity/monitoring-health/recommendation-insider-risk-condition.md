---
title: Protect your tenant with Insider Risk in Conditional Access
description: Learn how you can protect your tenant by enabling the Insider Risk condition in Conditional Access integrated with Microsoft Purview Adaptive Protection.
author: shlipsey3
manager: pmwongera
ms.service: entra-id
ms.topic: how-to
ms.subservice: monitoring-health
ms.date: 04/09/2025
ms.author: sarahlipsey
ms.reviewer: poulomib

# Customer intent: As an IT admin, I need to make sure that high risk users are blocked from certain activities.
---

# Microsoft Entra recommendation: Protect your tenant with Insider Risk condition in Conditional Access policy

[Microsoft Entra recommendations](overview-recommendations.md) is a feature that provides you with personalized insights and actionable guidance to align your tenant with recommended best practices.

This article covers the recommendation to protect your tenant by enabling the Insider Risk condition in Conditional Access paired with Microsoft Purview Adaptive Protection. This recommendation is called `insiderRiskPolicy` in the recommendations API in Microsoft Graph. 

## Description

Adaptive protection dynamically assigns appropriate Data Loss Prevention (DLP) policies to users based on the risk levels defined and analyzed by the machine learning models in insider risk management. With this new capability, static DLP policies become adaptive based on user context. The most effective policy, such as blocking data sharing, is applied only to high-risk users while low-risk users can maintain productivity. 

These risk signals, when integrated with Conditional Access policies, allow Administrators to take appropriate actions for each risk level. Configuring Conditional Access policies with insider risk allows organizations to respond effectively to changing threat landscapes.  

## Value

Implementing a Conditional Access policy that blocks access to resources for high-risk internal users is of high priority due to its critical role in proactively enhancing security, mitigating insider threats, and safeguarding sensitive data in real-time.

## Action plan

1. Enable [Adaptive Protection](https://compliance.microsoft.com/insiderriskmgmt?viewid=dynamicriskprevention&innerviewid=summary) in Microsoft Purview.
	- You must be a member of the Insider Risk Management or Insider Risk Management Admins role group in Microsoft Purview to configure Adaptive Protection.
	- For information, see [Roles and role groups for Microsoft Purview](/microsoft-365/security/office-365-security/scc-permissions)

1. Create a [Conditional Access policy](https://entra.microsoft.com/#view/Microsoft_AAD_ConditionalAccess/CaTemplates.ReactView/templateIds~/%5B%2216aaa400-bfdf-4756-a420-ad2245d4cde8%22%5D) that includes the Insider Risk condition.
	- You must be signed in as a [Conditional Access Administrator](../role-based-access-control/permissions-reference.md#conditional-access-administrator) to view this template.
	- For more information, see [Conditional Access conditions: Insider Risk](../../identity/conditional-access/concept-conditional-access-conditions.md#insider-risk).

## License requirements

Using this feature requires Microsoft Entra ID P2 licenses.

## Next steps

- [Review the Microsoft Entra recommendations overview](overview-recommendations.md)
- [Learn how to use Microsoft Entra recommendations](howto-use-recommendations.md)
- [Explore the Microsoft Graph API properties for recommendations](/graph/api/resources/recommendation)
