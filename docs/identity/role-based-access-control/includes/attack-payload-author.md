---
title: Attack Payload Author
description: Attack Payload Author
ms.service: entra-id
ms.subservice: role-based-access-control
ms.topic: include
ms.date: 07/09/2025
ms.custom: include file
---

Users in this role can create attack payloads but not actually launch or schedule them. Attack payloads are then available to all administrators in the tenant who can use them to create a simulation. Access to reports is limited to simulations executed by the user, and this role doesn't grant access to aggregate reports such as Training efficacy, Repeat offenders, Training completion, or User coverage.

For more information, see these articles:

- [Get started using Attack simulation training](/defender-office-365/attack-simulation-training-get-started)
- [Microsoft Defender for Office 365 permissions in the Microsoft Defender portal](/microsoft-365/security/office-365-security/mdo-portal-permissions)
- [Permissions in the Microsoft Purview portal](/microsoft-365/compliance/microsoft-365-compliance-center-permissions)


<!-- autogenerated content starts here -->

> [!div class="mx-tableFixed"]
> | Actions | Description |
> | --- | --- |
> | microsoft.office365.protectionCenter/attackSimulator/payload/allProperties/allTasks | Create and manage attack payloads in Attack Simulator |
> | microsoft.office365.protectionCenter/attackSimulator/reports/allProperties/read | Read reports of attack simulation, responses, and associated training |

