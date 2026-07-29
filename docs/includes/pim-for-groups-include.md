---
title: include file
description: include file
author: amsliu
ms.service: entra-id
ms.topic: include
ms.date: 01/31/2023
ms.author: amsliu
ms.custom: include file
---

>[!Note]
> For groups used for elevating into Microsoft Entra roles, we recommend that you require an approval process for eligible member assignments. Assignments that can be activated without approval can leave you vulnerable to a security risk from less-privileged administrators, who might be able to reset a user's credentials and then activate the assignment on their behalf.
>
> Confirm that groups used for role elevation are created as [role-assignable](~/identity/role-based-access-control/groups-concept.md). Only the Privileged Authentication Administrator and the Global Administrator can change the credentials of members and owners of a role-assignable group.
