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

Global Secure Access uses Role-Based Access Control (RBAC) to effectively manage administrative access. By default, Microsoft Entra ID requires specific administrator roles for accessing Global Secure Access.

This article details the built-in Microsft Entra roles you can assign for managing Global Secure Access.

## Role-based permissions
The following Microsoft Entra ID admin roles have access to Global Secure Access:

### Global Administrator 

**Full Access**: This role grants administrators full permissions within Global Secure Access. They can manage policies, settings, and view logs, including Conditional Access scenarios, configurations for Private Access, write operations on application segments, and management of user assignments for traffic profiles 

### Security Administrator 

**Limited Access**: This role grants permissions to perform tasks such as configuring remote networks, setting up security profiles, managing traffic forwarding profiles, and viewing traffic logs and alerts. However, security administrators can't configure Private Access or enable Office 365 logging. 

### Global Secure Access Administrator

**Limited Access**: This role grants permissions to configure remote networks, set up security profiles, manage traffic forwarding profiles, and view traffic logs and alerts. However, GSA admins cannot configure Private Access, create or manage Conditional Access policies, manage user and group assignments, or configure Office 365 logging

> [!NOTE]
> To perform additional Microsoft Entra tasks, you need both the Global Secure Access Administrator role and at least one other Microsoft Entra administrator role

### Conditional Access Administrator 

**Conditional Access Management**: This role can create and manage Conditional Access policies for Global Secure Access, such as All Compliant Network locations, and utilize Global Secure Access security profiles.

### Application Administrator 

**Private Access Configuration**: This role can configure Private Access, including Quick Access, Private Network connectors, application segments, and enterprise applications.

### Security Reader and Global Reader

**Read-Only Access**: These roles have full read-only access to all aspects of Global Secure Access, except traffic logs. They cannot change any settings or perform any actions.



| Permissions | [Global Admin](#global-administrator) | [Security Admin](#security-administrator) | [GSA Admin](#global-secure-access-administrator) | [CA Admin](#conditional-access-administrator) | [Apps Admin](#application-administrator) | [Global Reader](#security-reader-and-global-reader) | [Security Reader](#security-reader-and-global-reader) |
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
