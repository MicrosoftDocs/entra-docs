---
title: include file
description: include file
author: garrodonnell
ms.service: entra
ms.topic: include
ms.date: 04/24/2026
ms.author: godonnell
ms.custom: include file
---

The following table shows Microsoft Entra Agent ID features and which license includes them. Agent identity is a core Microsoft Entra platform feature required for agent policies, governance, and security protections. For pricing details, see [Microsoft Agent 365 licensing FAQ](https://www.microsoft.com/licensing/faqs/122).

### Features by license

| Feature | Description | Microsoft Cloud subscription | Microsoft Agent 365 |
|---|---|:---:|:---:|
| **Observability** ||||
| Agent identity | Create and manage agent identities in Microsoft Entra ID. | :white_check_mark: | :white_check_mark: |
| **Security** ||||
| Conditional Access and Identity Protection for agents | Conditional Access and Identity Protection for agents. Applies to agents with delegated access, extending user policies to agents. | | :white_check_mark: |
| Secure Access Service Edge (SASE) for agents | Monitor and block malicious and noncompliant network traffic. Applies to agents operating on user endpoint devices and Copilot Studio agents. | | :white_check_mark: |
| **Governance** ||||
| Agent identity governance | Access packages for agents with reduced permission scope compared to users. | | :white_check_mark: |
| Lifecycle management for agents | Built-in Microsoft Entra lifecycle policies, sponsor-driven workflows, and automated accountability enforcement. | | :white_check_mark: |

> [!NOTE]
> - Conditional Access for delegated access flows requires the user to have Microsoft Entra ID P1 or Microsoft 365 E3.
> - Identity Protection for delegated access flows requires the user to have Microsoft Entra ID P2, Microsoft 365 E5, or Microsoft Entra Suite.
