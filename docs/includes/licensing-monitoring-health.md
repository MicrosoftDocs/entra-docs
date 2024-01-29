---
title: include file
description: include file
author: barclayn
manager: amycolannino
ms.service: active-directory
ms.topic: include
ms.date: 01/17/2024
ms.author: barclayn
ms.custom: include file,licensing
---

The required roles and licenses might vary based on the report. Global Administrator can access all reports, but we recommend using a role with least privilege access to align with the [Zero Trust guidance](/security/zero-trust/zero-trust-overview).

| Log / Report | Roles | Licenses |
|--|--|--|
| Audit | Report Reader<br>Security Reader<br>Security Administrator<br>Global Reader<br>A custom role with `AuditLogsRead` or `CustomSecAuditLogsRead` permission | All editions of Microsoft Entra ID |
| Sign-ins | Report Reader<br>Security Reader<br>Security Administrator<br>Global Reader<br>A custom role with `SignInLogsRead` permission | All editions of Microsoft Entra ID |
| Provisioning | Same as audit and sign-ins, plus<br>Security Operator<br>Application Administrator<br>Cloud App Administrator<br>A custom role with `ProvisioningLogsRead` permission | Microsoft Entra ID P1/P2 |
| Usage and insights | Security Reader<br>Reports Reader<br> Security Administrator  | Microsoft Entra ID P1/P2 |
| Identity Protection* | Security Administrator<br>Security Operator<br>Security Reader<br>Global Reader<br>A custom role with `IdentityRiskEventReadWrite` permission | Microsoft Entra ID Free<br>Microsoft 365 Apps<br>Microsoft Entra ID P1/P2 |
| Microsoft Graph activity logs | Security Administrator<br>A custom role with `ListKeys` permission  | Microsoft Entra ID P1/P2 |

*The level of access and capabilities for Identity Protection varies with the role and license. For more information, see the [license requirements for Identity Protection](~/id-protection/overview-identity-protection.md#license-requirements).
