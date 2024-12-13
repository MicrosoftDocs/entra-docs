---
title: Sign-ins to applications using SAML authentication
description: Learn about the Microsoft Entra Health signals and alerts for sign-ins to applications that use SAML authentication
author: shlipsey3
manager: amycolannino
ms.service: entra-id
ms.topic: how-to
ms.subservice: monitoring-health
ms.date: 10/14/2024
ms.author: sarahlipsey
ms.reviewer: sarbar

# Customer intent: As an IT admin, I want to understand the health of my tenant through identity related signals and alerts so I can proactively address issues and maintain a healthy tenant.
---

# How to investigate the sign-ins to applications using SAML authentication

The Security Assertion Markup Language (SAML) authentication scenario provides health monitoring signal but doesn't trigger alerts. The scenario monitors SAML 2.0 authentication attempts that the Microsoft Entra cloud service for your tenant successfully processed. This metric currently excludes WS-FED/SAML 1.1 apps integrated with Microsoft Entra ID.  

- [Learn how the Microsoft Identity platform uses the SAML protocol](../../identity-platform/saml-protocol-reference.md)
- [Use a SAML 2.0 IdP for single sign on](../hybrid/connect/how-to-connect-fed-saml-idp.md).

![Screenshot of the SAML scenario.](media/scenario-health-sign-ins-saml-auth/scenario-monitoring-SAML.png)