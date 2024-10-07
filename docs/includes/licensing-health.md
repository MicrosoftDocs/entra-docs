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

There are different roles, permissions, and license requirements to view health monitoring signals and configure and receive alerts. Separate permissions are required to access health monitoring signals and alerts in [Microsoft Graph](/graph/permissions-overview). We recommend using a role with least privilege access to align with the [Zero Trust guidance](/security/zero-trust/zero-trust-overview).

- A tenant with a [Microsoft Entra P1 or P2 license](~/fundamentals/get-started-premium.md) is required to **view** the Microsoft Entra health scenario monitoring signals.
- A tenant with both a [Microsoft Entra P1 or P2 license](~/fundamentals/get-started-premium.md) *and* at least 100 monthly active users is required to **view alerts** and **receive alert notifications**.

### Required roles and permissions

| Activity | Roles |
|--|--|
| View scenario monitoring signals and alerts and alert configurations | [Reports Reader](../identity/role-based-access-control/permissions-reference.md#reports-reader)<br>[Security Reader](../identity/role-based-access-control/permissions-reference.md#security-reader)<br>[Security Operator](../identity/role-based-access-control/permissions-reference.md#security-operator)<br>[Security Administrator](../identity/role-based-access-control/permissions-reference.md#security-administrator)<br>[Helpdesk Administrator](../identity/role-based-access-control/permissions-reference.md#helpdesk-administrator)<br>[Company Administrator](../identity/role-based-access-control/permissions-reference.md#company-administrator)<br>[Global Reader](../identity/role-based-access-control/permissions-reference.md#global-reader)<br>|
| Update alerts | [Security Operator](../identity/role-based-access-control/permissions-reference.md#security-operator)<br>[Security Administrator](../identity/role-based-access-control/permissions-reference.md#security-administrator)<br>[Helpdesk Administrator](../identity/role-based-access-control/permissions-reference.md#helpdesk-administrator)<br>[Company Administrator](../identity/role-based-access-control/permissions-reference.md#company-administrator) |
| Update alert notification configurations | [Security Administrator](../identity/role-based-access-control/permissions-reference.md#security-administrator)<br>[Helpdesk Administrator](../identity/role-based-access-control/permissions-reference.md#helpdesk-administrator)<br>[Company Administrator](../identity/role-based-access-control/permissions-reference.md#company-administrator) |
| View and modify Conditional Access policies | [Conditional Access Administrator](../role-based-access-control/permissions-reference.md#conditional-access-administrator) |
| View the alerts using the Microsoft Graph API |`HealthMonitoringAlert.Read.All` permission |
| View and modify the alerts using the Microsoft Graph API | `HealthMonitoringAlert.ReadWrite.All` permission |