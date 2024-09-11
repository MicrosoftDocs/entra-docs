---
title: include file
description: include file
author: barclayn
manager: amycolannino
ms.service: entra-id
ms.topic: include
ms.date: 01/17/2024
ms.author: barclayn
ms.custom: include file,licensing
---

The requirements to view the scenario monitoring signals and configure and receive alerts are different. Separate permissions are required to access scenario monitoring and health alerts in [Microsoft Graph](/graph/permissions-overview). We recommend using a role with least privilege access to align with the [Zero Trust guidance](/security/zero-trust/zero-trust-overview).

| Activity | Roles | Licenses and other requirements |
|--|--|--|
| View scenario monitoring signals | [Reports Reader](../identity/role-based-access-control/permissions-reference.md#reports-reader)<br>[Security Reader](../identity/role-based-access-control/permissions-reference.md#security-reader)<br>[Security Administrator](../identity/role-based-access-control/permissions-reference.md#security-administrator)<br>[Global Reader](../identity/role-based-access-control/permissions-reference.md#global-reader)<br>| Microsoft Entra P1 or P2 |
| Configure and receive alerts | [Security Administrator](../identity/role-based-access-control/permissions-reference.md#security-administrator)<br>[Helpdesk Administrator](../identity/role-based-access-control/permissions-reference.md#helpdesk-administrator) | Microsoft Entra P1 or P2<br>AND<br>At least 100 monthly active users |
| View and modify Conditional Access policies | [Conditional Access Administrator](../role-based-access-control/permissions-reference.md#conditional-access-administrator) | Microsoft Entra P1 or P2 |
| Configure Microsoft Graph alert notifications | [Security Administrator](../role-based-access-control/permissions-reference.md#security-administrator)<br>[Helpdesk Administrator](../role-based-access-control/permissions-reference.md#helpdesk-administrator) | |
| View the alerts using the Microsoft Graph API |`HealthMonitoringAlert.Read.All` permission | |
| View and modify the alerts using the Microsoft Graph API | `HealthMonitoringAlert.ReadWrite.All` permission | |