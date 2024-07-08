---
title: Microsoft Global Secure Access built-in roles 
description: Learn about the built-in administrator roles you can assign to manage Global Secure Access permissions.
author: kenwith
ms.author: kenwith
manager: amycolannino
ms.topic: reference
ms.date: 07/05/2024
ms.service: global-secure-access
---

# Microsoft Global Secure Access built-in roles

Global Secure Access uses Role-Based Access Control (RBAC) to effectively manage administrative access. By default, Microsoft Entra ID requires specific administrator roles for accessing Global Secure Access.

This article details the built-in Microsoft Entra roles you can assign for managing Global Secure Access.

### Global Administrator 

**Full access**: This role grants administrators full permissions within Global Secure Access. They can manage policies, configure settings, and view logs; including Conditional Access scenarios, configurations for Private Access, write operations on application segments, and management of user assignments for traffic profiles.

### Security Administrator 

**Limited access**: This role grants permissions to perform specific tasks, such as configuring remote networks, setting up security profiles, managing traffic forwarding profiles, and viewing traffic logs and alerts. However, security admins can't configure Private Access or enable Office 365 logging.

### Global Secure Access Administrator

**Limited access**: This role grants permissions to perform specific tasks, such as configuring remote networks, setting up security profiles, managing traffic forwarding profiles, and viewing traffic logs and alerts. However, Global Secure Access admins can't configure Private Access, create or manage Conditional Access policies, manage user and group assignments, or configure Office 365 logging.

> [!NOTE]
> To perform additional Microsoft Entra tasks, such as editing Conditional Access policies, you need to be both a GSA administrator and have at least one other administrator role assigned to you. Consult the Role-based permissions table above.

### Conditional Access Administrator 

**Conditional Access management**: This role can create and manage Conditional Access policies for Global Secure Access, such as managing all compliant network locations and utilizing Global Secure Access security profiles.

### Application Administrator 

**Private Access configuration**: This role can configure Private Access, including Quick Access, private network connectors, application segments, and enterprise applications.

### Security Reader and Global Reader

**Read-Only access**: These roles have full read-only access to all aspects of Global Secure Access, except traffic logs. They can't change any settings or perform any actions.

## Role-based permissions

The following Microsoft Entra ID admin roles have access to Global Secure Access:

| Permissions | [Global Admin](#global-administrator) | [Security Admin](#security-administrator) | [GSA Admin](#global-secure-access-administrator) | [CA Admin](#conditional-access-administrator) | [Apps Admin](#application-administrator) | [Global Reader](#security-reader-and-global-reader) | [Security Reader](#security-reader-and-global-reader) |
| --- | --- | --- | --- | --- | --- | --- | --- |
| Configure Private Access (Quick Access, private network connectors, application segments, and enterprise apps) | ✅ |  |  |  | ✅ |  |  |
| Create and interact with Conditional Access policies | ✅ | ✅ |  | ✅ |  |  |  |
| Manage traffic forwarding profiles | ✅ | ✅ | ✅ |  |  |  |  |
| User and group assignments | ✅ |  |  |  | ✅ |  |  |
| Configure remote networks | ✅ | ✅ | ✅ |  |  |  |  |
| Security profiles | ✅ | ✅ | ✅ |  |  |  |  |
| View traffic logs and alerts | ✅ | ✅ | ✅ |  |  |  |  |
| View all other logs | ✅ | ✅ | ✅ |  |  | ✅ | ✅ |
| Configure universal tenant restrictions and Global Secure Access signaling for Conditional Access | ✅ | ✅ | ✅ |  |  |  |  |
| Configure Office 365 logging | ✅ |  |  |  |  |  |  |
| Read-only access to product settings | ✅ | ✅ | ✅ |  |  | ✅ | ✅ |

## Next steps
- [Get started with Global Secure Access](how-to-get-started-with-global-secure-access.md)
- [Learn about Microsoft Entra Private Access](concept-private-access.md)
