---
ms.author: joflore
author: MicrosoftGuyJFlo
ms.service: entra-id
ms.topic: include
ms.date: 05/10/2024
ms.author: joflore
ms.custom: Identity-Managed-Definition
# Common include file for referencing break-glass or emergency access accounts.
---

Microsoft recommends that organizations have two cloud-only emergency access accounts permanently assigned the [Global Administrator](/entra/identity/role-based-access-control/permissions-reference#global-administrator) role. These accounts are highly privileged and aren't assigned to specific individuals. The accounts are limited to emergency or "break glass" scenarios where normal accounts can't be used or all other administrators are accidentally locked out. These accounts should be created following the [emergency access account recommendations](/entra/identity/role-based-access-control/security-emergency-access).
