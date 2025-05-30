---
title: Investigate insights within entitlements management in Microsoft Entra Copilot
description: Use Microsoft Security Copilot and Microsoft Entra skills to quickly investigate identity-based security incident.
keywords:
author: cilwerner
ms.author: cwerner
manager: pmwongera
ms.date: 05/29/2025
ms.topic: conceptual
ms.service: entra
ms.custom: microsoft-copilot
ms.collection: ce-skilling-ai-copilot
# Customer intent: 
---

# Investigate insights within entitlements management in Microsoft Entra Copilot

> [!NOTE]
> 
> This article is a work in progress. It will be updated with more information, methods, and examples before GA.

Entitlement management in Microsoft Entra ID enables organizations to manage identity and access lifecycle at scale, by automating workflows, access assignments, reviews and expirations. Using the capabilities of Microsoft Security Copilot with Microsoft Entra ID Governance Entitlement Management, administrators can now interact with entitlement management data using natural language. You can get quick access to information about access packages, policies, connected organizations, and catalog resources, and customize curated data only previously available through custom scripting.

This article describes how to use Microsoft Security Copilot to investigate insights within entitlements management in Microsoft Entra. Using this feature requires [Microsoft Entra ID P2 licenses](/entra/id-governance/entitlement-management/overview#license-requirements) and a workforce tenant in Microsoft Entra ID.

## Investigate insights within entitlements management
 
To view insights:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com/) as at least an [Identity Governance Administrator](/entra/identity/role-based-access-control/permissions-reference#identity-governance-administrator).
1. Navigate to **Identity Governance** > **Entitlement management**.
1. {ADDME}

> [!NOTE]
> This space is being reserved for an image showing the Copilot experience in the Microsoft Entra admin center.

## Example Prompts

You can use the following example prompts to investigate insights within entitlements management in Microsoft Entra:

* *What resources are in catalog “XYZ”*
* *How many catalogs are in the tenant?*
* *Which access packages are in catalog “XYZ”?*
* *How many access packages are in the tenant?*
* *What resource role scopes are in access package “XYZ”?*
* *What access package assignments does “User” have?*
* *Find all access packages where the name contains “Sales”?*
* *Who are the external users of connected organization “XYZ”?*
* *Who are the sponsors for connected organization “XYZ”?*
* *What custom extensions does catalog “XYZ” have?*

## See also

- [What is entitlement management](/entra/id-governance/entitlement-management-overview)
- [Create an access package in entitlement management](/entra/id-governance/entitlement-management-access-package-create)