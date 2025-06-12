---
title: Microsoft Global Secure Access built-in roles
description: Learn about the built-in administrator roles you can assign to manage Global Secure Access permissions.
author: kenwith
ms.author: kenwith
manager: dougeby
ms.topic: reference
ms.date: 03/05/2025
ai-usage: ai-assisted
ms.service: global-secure-access
ms.custom: sfi-ga-nochange
---

# Microsoft Global Secure Access built-in roles

Global Secure Access uses Role-Based Access Control (RBAC) to effectively manage administrative access. By default, Microsoft Entra ID requires specific administrator roles for accessing Global Secure Access.

This article details the built-in Microsoft Entra roles you can assign for managing Global Secure Access.

> [!IMPORTANT]
> It's highly recommended to use the least privileged role required to administer the service. To learn more about least privileged, see [Least privileged roles by task in Microsoft Entra ID](../identity/role-based-access-control/delegate-by-task.md). To learn more about least privilege in Microsoft Entra ID Governance, see [The principle of least privilege with Microsoft Entra ID Governance](../id-governance/scenarios/least-privileged.md).

### Security Administrator 

**Limited access**: This role grants permissions to perform specific tasks, such as configuring remote networks, setting up security profiles, managing traffic forwarding profiles, and viewing traffic logs and alerts. However, security admins can't configure Private Access or enable enriched Microsoft 365 logs.

### Global Secure Access Administrator

**Limited access**: This role grants permissions to perform specific tasks, such as configuring remote networks, setting up security profiles, managing traffic forwarding profiles, and viewing traffic logs and alerts. However, Global Secure Access admins can't configure Private Access, create or manage Conditional Access policies, manage user and group assignments, or configure enriched Microsoft 365 logs.

> [!NOTE]
> To perform additional Microsoft Entra tasks, such as editing Conditional Access policies, you need to be both a Global Secure Access Administrator and have at least one other administrator role assigned to you. Consult the Role-based permissions table above.

### Conditional Access Administrator 

**Conditional Access management**: This role can create and manage Conditional Access policies for Global Secure Access, such as managing all compliant network locations and utilizing Global Secure Access security profiles.

### Application Administrator 

**Private Access configuration**: This role can configure Private Access, including Quick Access, private network connectors, application segments, and enterprise applications.

### Global Secure Access Log Reader

**Read-only access**: This role is primarily intended for security and network personnel who need read-only visibility into traffic logs and related insights to effectively monitor and analyze network activity without the ability to make changes to the environment. Users with this role can view detailed GSA traffic logs, including session, connection, and transaction data, as well as access and review alerts and reports in the GSA portal.

### Security Reader and Global Reader

**Read-only access**: These roles have full read-only access to all aspects of Global Secure Access, except traffic logs. They can't change any settings or perform any actions.

## Role-based permissions

The following Microsoft Entra ID admin roles have access to Global Secure Access:


| Permissions | [Global Admin](#global-administrator) | [Security Admin](#security-administrator) | [GSA Admin](#global-secure-access-administrator) | [CA Admin](#conditional-access-administrator) | [Apps Admin](#application-administrator) | [Global Reader](#security-reader-and-global-reader) | [Security Reader](#security-reader-and-global-reader) | [GSA Log Reader](#global-secure-access-log-reader)
| --- | --- | --- | --- | --- | --- | --- | --- |
| Configure Private Access (Quick Access, private network connectors, application segments, and enterprise apps) | ✅ |  |  |  | ✅ |  |  |
| Create and interact with Conditional Access policies | ✅ | ✅ |  | ✅ |  |  |  |
| Manage traffic forwarding profiles | ✅ | ✅ | ✅ |  |  |  |  |
| User and group assignments | ✅ |  |  |  | ✅ |  |  |
| Configure remote networks | ✅ | ✅ | ✅ |  |  |  |  |
| Security profiles | ✅ | ✅ | ✅ |  |  |  |  |
| View traffic logs and alerts | ✅ | ✅ | ✅ |  |  |  |  | ✅ |
| View all other logs and dashboards | ✅ | ✅ | ✅ |  |  | ✅ | ✅ | ✅ |
| Configure universal tenant restrictions and Global Secure Access signaling for Conditional Access | ✅ | ✅ | ✅ |  |  |  |  |
| Read-only access to product settings | ✅ | ✅ | ✅ |  |  | ✅ | ✅ | ✅ |

## Next steps
- [Get started with Global Secure Access](how-to-get-started-with-global-secure-access.md)
- [Learn about Microsoft Entra Private Access](concept-private-access.md)
