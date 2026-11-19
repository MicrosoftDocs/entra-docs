---
title: Identity verification licensing
description: Review licensing requirements and dependencies for identity verification scenarios in Microsoft Entra ID.
author: tilarso
ms.author: tilarso
ms.service: entra-id
ms.topic: include
ms.date: 10/07/2026
ms.custom: include file,licensing,msecd-doc-authoring-108
ai-usage: ai-generated
---

Review the licensing requirements for each capability in your identity verification journey:

- [Authentication](../fundamentals/licensing.md#authentication) for authentication methods and account recovery.
- [Conditional Access](../fundamentals/licensing.md#microsoft-entra-conditional-access) for policies that require identity verification.
- [Microsoft Entra ID Protection](../fundamentals/licensing.md#microsoft-entra-id-protection) for risk-based policies and remediation.
- [Microsoft Entra ID Governance](../fundamentals/licensing.md#microsoft-entra-id-governance) for Lifecycle Workflows and entitlement management.
- [Microsoft Entra Verified ID](../fundamentals/licensing.md#microsoft-entra-verified-id) for credential issuance, verification, and Face Check.

### Features by license

The following table shows identity verification features by license. A check mark indicates that the feature is included, and **Add-on** indicates a separate purchase. Blank cells indicate that the feature isn't included.

| Feature \*\* | Free | Microsoft Entra ID P1 | Microsoft Entra ID P2 | Microsoft Entra ID Governance | Microsoft Entra Suite | Microsoft 365 E7 |
| --- | :---: | :---: | :---: | :---: | :---: | :---: |
| Core Verified ID credential issuance and verification | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
| Face Check | Add-on | Add-on | Add-on | Add-on | :white_check_mark: | :white_check_mark: |
| Account recovery | | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
| Identity verification profiles | | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
| Integrated onboarding with Lifecycle Workflows | | | | :white_check_mark: | :white_check_mark: | :white_check_mark: |
| Identity verification for resource access through Conditional Access | | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
| Risk-based identity verification and remediation | | | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
| Identity verification status, history, and credential provenance reporting | | | :white_check_mark: | | :white_check_mark: | :white_check_mark: |
| Overwrite identity verification events | | | | | :white_check_mark: | :white_check_mark: |
| Credential provenance overwrite | | | | | :white_check_mark: | :white_check_mark: |
| Self-service Verified ID issuance in My Account | :white_check_mark: \* | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |

\* Free includes self-service issuance of Employee ID only.

\*\* If your scenario uses an identity verification provider, purchase the provider's services separately through the [Microsoft Security Store](https://securitystore.microsoft.com/). These services aren't included in the Microsoft Entra licenses listed in the table.
