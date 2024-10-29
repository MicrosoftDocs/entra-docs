---
title: include file
description: include file
author: barclayn
manager: amycolannino
ms.service: entra-id
ms.topic: include
ms.date: 10/28/2024
ms.author: barclayn
ms.custom: include file,licensing
---

The required roles and licenses vary based on the report. Separate permissions are required to access monitoring and health data in [Microsoft Graph](/graph/permissions-overview). We recommend using a role with least privilege access to align with the [Zero Trust guidance](/security/zero-trust/zero-trust-overview). For a full list of roles, see [Least privileged roles by task](../identity/role-based-access-control/delegate-by-task.md).

| Log / Report | Roles | Licenses |
|--|--|--|
| Audit logs | [Reports Reader](../identity/role-based-access-control/permissions-reference.md#reports-reader)<br>[Security Reader](../identity/role-based-access-control/permissions-reference.md#security-reader)<br>[Security Administrator](../identity/role-based-access-control/permissions-reference.md#security-administrator) | All editions of Microsoft Entra ID |
| Sign-in logs | [Reports Reader](../identity/role-based-access-control/permissions-reference.md#reports-reader)<br>[Security Reader](../identity/role-based-access-control/permissions-reference.md#security-reader)<br>[Security Administrator](../identity/role-based-access-control/permissions-reference.md#security-administrator) | All editions of Microsoft Entra ID |
| Sign-up logs (preview) | [Reports Reader](../identity/role-based-access-control/permissions-reference.md#reports-reader)<br>[Security Reader](../identity/role-based-access-control/permissions-reference.md#security-reader)<br>[Security Administrator](../identity/role-based-access-control/permissions-reference.md#security-administrator)<br>[Global Reader](../identity/role-based-access-control/permissions-reference.md#global-reader)<br> | Microsoft Entra External ID |
| Provisioning logs | [Reports Reader](../identity/role-based-access-control/permissions-reference.md#reports-reader)<br>[Security Reader](../identity/role-based-access-control/permissions-reference.md#security-reader)<br>[Application Administrator](../identity/role-based-access-control/permissions-reference.md#application-administrator)<br>[Cloud App Administrator](../identity/role-based-access-control/permissions-reference.md#cloud-application-administrator) | Microsoft Entra ID P1 or P2 |
| Custom security attribute audit logs* | [Attribute Log Administrator](../identity/role-based-access-control/permissions-reference.md#attribute-log-administrator)<br>[Attribute Log Reader](../identity/role-based-access-control/permissions-reference.md#attribute-log-reader) | All editions of Microsoft Entra ID |
| Health | [Reports Reader](../identity/role-based-access-control/permissions-reference.md#reports-reader)<br>[Security Reader](../identity/role-based-access-control/permissions-reference.md#security-reader)<br>[Helpdesk Administrator](../identity/role-based-access-control/permissions-reference.md#helpdesk-administrator) | Microsoft Entra ID P1 or P2 |
| Microsoft Entra ID Protection** | [Security Administrator](../identity/role-based-access-control/permissions-reference.md#security-administrator)<br>[Security Operator](../identity/role-based-access-control/permissions-reference.md#security-operator)<br>[Security Reader](../identity/role-based-access-control/permissions-reference.md#security-reader)<br>[Global Reader](../identity/role-based-access-control/permissions-reference.md#global-reader)<br> | Microsoft Entra ID Free<br>Microsoft 365 Apps<br>Microsoft Entra ID P1 or P2 |
| Microsoft Graph activity logs | [Security Administrator](../identity/role-based-access-control/permissions-reference.md#security-administrator)<br>Permissions to access data in the corresponding log destination | Microsoft Entra ID P1 or P2 |
| Usage and insights | [Reports Reader](../identity/role-based-access-control/permissions-reference.md#reports-reader)<br>[Security Reader](../identity/role-based-access-control/permissions-reference.md#security-reader)<br>[Security Administrator](../identity/role-based-access-control/permissions-reference.md#security-administrator) | Microsoft Entra ID P1 or P2 |

*Viewing the custom security attributes in the audit logs or creating diagnostic settings for custom security attributes requires one of the Attribute Log roles. You also need the appropriate role to view the standard audit logs.

**The level of access and capabilities for Microsoft Entra ID Protection varies with the role and license. For more information, see the [license requirements for ID Protection](~/id-protection/overview-identity-protection.md#license-requirements).
