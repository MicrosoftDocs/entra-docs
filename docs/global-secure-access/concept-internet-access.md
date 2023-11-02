---
title: Learn about Microsoft Entra Internet Access
description: Learn about how Microsoft Entra Internet Access secures access to the Internet.
author: kenwith
ms.author: kenwith
manager: amycolannino
ms.topic: how-to
ms.date: 11/02/2023
ms.service: network-access
ms.custom: 
ms.reviewer: frankgomulka

---

# Learn about Microsoft Entra Internet Access for all apps

Microsoft Entra Internet Access is an identity-centric Secure Web Gateway (SWG) for Software as a Service (SaaS) applications and other Internet traffic. It protects users, devices, and data from the Internet's wide threat landscape with best-in-class security controls and visibility through Traffic Logs.

## Security profiles
Security profiles are a grouping of filtering policies. You can assign, or link, security profiles with Microsoft Entra Conditional Access policies. One security profile can contain multiple filtering policies. And one security profile can be associated with multiple Conditional Access policies.

## Web content filtering

The key introductory feature for Microsoft Entra Internet Access for all apps is Web content filtering. This feature allows you to choose which types of web content users can access. By explicitly blocking known inappropriate, evil, or unsafe sites, you secure your users and their devices from any Internet connection whether they're remote or within the corporate network. Web content filtering makes use of Microsoft Entra Conditional Access. To learn more about Conditional Access, see [Microsoft Entra Conditional Access](/azure/active-directory/conditional-access/).

## Next steps

- [Configure web content filtering](how-to-configure-quick-access.md)
