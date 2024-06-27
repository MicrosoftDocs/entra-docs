---
title: Managing admin access to Global Secure Access 
description: Valid Global Secure Access permissions for manage administrative access effectively.
author: kenwith
ms.author: kenwith
manager: amycolannino
ms.topic: reference
ms.date: 06/27/2024
ms.service: global-secure-access
---

# Microsoft Global Secure Access built-in roles

Global Secure Access supports Role-Based Access Control (RBAC), allowing you to manage administrative access effectively. By default, the following Microsoft Entra ID admin roles have access to Global Secure Access.

This article lists the Global Secure Access built-in roles you can assign to allow management of Microsoft Entra resources.

## Role-based permissions

| Permissions | [Global Admin](#global-administrator-and-security-administrator) | [Security Admin](#global-administrator-and-security-administrator) | [GSA Admin](#global-secure-access-administrators) | [CA Admin](#conditional-access-administrator) | [Apps Admin](#application-administrator) | [Global Reader](#security-reader-and-global-reader) | [Security Reader](#security-reader-and-global-reader) |
| --- | --- | --- | --- | --- | --- | --- | --- |
| Configure Private Access (Quick access, Private Network connectors, app segments, Enterprise apps) | X |  |  |  | X |  |  |
| Create and interact with Conditional Access policies | X | X |  | X |  |  |  |
| Manage traffic forwarding profiles | X | X | X |  |  |  |  |
| User and Group assignments | X |  |  |  | X |  |  |
| Configure Remote network | X | X | X |  |  |  |  |
| Security profiles | X | X | X |  |  |  |  |
| View Traffic logs and alerts | X | X | X |  |  |  |  |
| View all other logs | X | X | X |  |  | X | X |
| Configure Universal tenant restrictions and Global Secure Access signaling for Conditional Access | X | X | X |  |  |  |  |
| Configure Office 365 logging | X |  |  |  |  |  |  |
| Read-only access to product settings | X | X | X |  |  | X | X |


### Global Administrator and Security Administrator 

**Full Access**: This role gives administrators full permissions within Global Secure Access. They can manage policies, settings, and view logs, including scenarios that involve Conditional Access, configurations required for Private Access, write operations on app segments, and management of user assignments for traffic profiles. 

### Security Administrator 

**Limited Access**: This role grants permissions to configure remote networks, security profiles, manage traffic forwarding profiles, and view traffic logs and alerts. However, security admins can't configure Private Access or Office 365 logging. 

### Global Secure Access Administrator 

**Limited Access**: This role grants permissions to configure remote networks, security profiles, manage traffic forwarding profiles, and view traffic logs and alerts. However, GSA admins can't configure Private Access, create, or interact with Conditional Access policies, manage user and group assignments, or configure Office 365 logging. 

### Conditional Access Administrator 

**Conditional Access Management**: This role can create and interact with Conditional Access policies for Global Secure Access (such as All Compliant Network locations (Preview) and use Global Secure Access security profiles). 

### Application Administrator 

**Private Access Configuration**: This role can configure Private Access, including Quick Access, Private Network connectors, app segments, and enterprise applications. 

### Security Reader and Global Reader

**Read-Only Access**: This role has full read-only access to all aspects of Global Secure Access, except access to traffic logs. They can't change any settings or take any actions. 

## Next steps
- [Get started with Global Secure Access](how-to-get-started-with-global-secure-access.md)
- [Learn about Microsoft Entra Private Access](concept-private-access.md)