---
title: Microsoft Entra synchronization protocol overview
description: Architectural guidance on integrating Microsoft Entra ID with legacy synchronization protocols
author: janicericketts
manager: martinco

ms.service: entra
ms.subservice: architecture
ms.topic: conceptual
ms.date: 2/8/2023
ms.author: jricketts

---

# Microsoft Entra integrations with synchronization protocols

Microsoft Entra ID enables integration with many synchronization protocols. The synchronization integrations enable you to sync user and group data to Microsoft Entra ID, and then user Microsoft Entra management capabilities. Some sync patterns also enable automated provisioning.

## Synchronization patterns

The following table presents Microsoft Entra integration with synchronization patterns and their capabilities. Select the name of a pattern to see

- A detailed description

- When to use it

- Architectural diagram

- Explanation of system components

- Links for how to implement the integration

| Synchronization pattern| Directory synchronization| User provisioning |
| - | - | - |
| [Directory synchronization](sync-directory.md)| ![check mark](./media/authentication-patterns/check.png)|  |
| [LDAP Synchronization](sync-ldap.md)| ![check mark](./media/authentication-patterns/check.png)|  |
| [System for Cross-Domain Identity Management (SCIM) synchronization](sync-scim.md)| ![check mark](./media/authentication-patterns/check.png)| ![check mark](./media/authentication-patterns/check.png) |
