---
title: Microsoft Global Secure Access built-in roles 
description: Learn about the built-in administrator roles you can assign to manage Global Secure Access permissions.
author: kenwith
ms.author: kenwith
manager: amycolannino
ms.topic: reference
ms.date: 06/27/2024
ms.service: global-secure-access
---

# Microsoft Global Secure Access built-in roles

Global Secure Access uses Role-Based Access Control (RBAC) to effectively manage administrative access. By default, certain Microsoft Entra ID administrator roles have access to Global Secure Access.

This article details the built-in Global Secure Access roles you can assign for managing Microsoft Entra resources.

## Role-based permissions
By default, the following Microsoft Entra ID admin roles have access to Global Secure Access:

### Global Administrator 

**Full Access**: This role gives administrators full permissions within Global Secure Access. It can manage policies, settings, and view logs, including scenarios that involve Conditional Access, configurations required for Private Access, write operations on application segments, and management of user assignments for traffic profiles. 

### Security Administrator 

**Limited Access**: This role grants permissions to perform tasks such as configuring remote networks, setting up security profiles, managing traffic forwarding profiles, and viewing traffic logs and alerts. However, security administrators can't configure Private Access or enable Office 365 logging. 

### Global Secure Access Administrator

**Limited Access**: This role grants permissions to perform tasks such as configuring remote networks, setting up security profiles, managing traffic forwarding profiles, and viewing traffic logs and alerts.. However, GSA admins can't configure Private Access, create or interact with Conditional Access policies, manage user and group assignments, or configure Office 365 logging. 

> [!NOTE]
> To perform additional Entra tasks, you need to be both a Global Secure Access Administrator administrator and have at least one other administrator role assigned to you.

### Conditional Access Administrator 

**Conditional Access Management**: This role can create and interact with Conditional Access policies for Global Secure Access, such as All Compliant Network locations and use Global Secure Access security profiles. 

### Application Administrator 

**Private Access Configuration**: This role can configure Private Access, including Quick Access, Private Network connectors, application segments, and enterprise applications. 

### Security Reader and Global Reader

**Read-Only Access**: These roles have full read-only access to all aspects of Global Secure Access, except access to traffic logs. They can't change any settings or take any actions. 



| Permissions | [Global Admin](#global-administrator-and-security-administrator) | [Security Admin](#global-administrator-and-security-administrator) | [GSA Admin](#global-secure-access-administrator) | [CA Admin](#conditional-access-administrator) | [Apps Admin](#application-administrator) | [Global Reader](#security-reader-and-global-reader) | [Security Reader](#security-reader-and-global-reader) |
| --- | --- | --- | --- | --- | --- | --- | --- |
| Manage Private Access (Quick Access, Private Network connectors, application segments, Enterprise apps) | ✅ |  |  |  | ✅ |  |  |
| Manage Conditional Access policies | ✅ | ✅ |  | ✅ |  |  |  |
| Manage traffic forwarding profiles | ✅ | ✅ | ✅ |  |  |  |  |
| Manage User and Group assignments | ✅ |  |  |  | ✅ |  |  |
| Manage Remote network | ✅ | ✅ | ✅ |  |  |  |  |
| Manage Security profiles | ✅ | ✅ | ✅ |  |  |  |  |
| View Traffic logs and alerts | ✅ | ✅ | ✅ |  |  |  |  |
| View all other logs | ✅ | ✅ | ✅ |  |  | ✅ | ✅ |
| Manage Universal tenant restrictions and Global Secure Access signaling for Conditional Access | ✅ | ✅ | ✅ |  |  |  |  |
| Manage Office 365 logging | ✅ |  |  |  |  |  |  |
| View product settings | ✅ | ✅ | ✅ |  |  | ✅ | ✅ |

## Next steps
- [Get started with Global Secure Access](how-to-get-started-with-global-secure-access.md)
- [Learn about Microsoft Entra Private Access](concept-private-access.md)
