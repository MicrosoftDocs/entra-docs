---
title: Sign-ins to applications using SAML authentication
description: Learn about the Microsoft Entra Health signals and alerts for sign-ins to applications that use SAML authentication
author: shlipsey3
manager: femila
ms.service: entra-id
ms.topic: how-to
ms.subservice: monitoring-health
ms.date: 02/03/2025
ms.author: sarahlipsey
ms.reviewer: sarbar

# Customer intent: As an IT admin, I want to understand the health of my tenant through identity related signals and alerts so I can proactively address issues and maintain a healthy tenant.
---

# How to investigate the sign-ins to applications using SAML authentication

Microsoft Entra Health monitoring provides a set of tenant-level health metrics you can monitor to help improve the health of your tenant. The Security Assertion Markup Language (SAML) authentication scenario monitors SAML 2.0 authentication attempts that the Microsoft Entra cloud service for your tenant successfully processed. 

- [Learn how the Microsoft Identity platform uses the SAML protocol](../../identity-platform/saml-protocol-reference.md)
- [Use a SAML 2.0 IdP for single sign on](../hybrid/connect/how-to-connect-fed-saml-idp.md).
- This metric currently excludes WS-FED/SAML 1.1 apps integrated with Microsoft Entra ID.
- Alerts are not available for this scenario.

## Prerequisites

There are different roles, permissions, and license requirements to view health monitoring signals and configure and receive alerts. We recommend using a role with least privilege access to align with the [Zero Trust guidance](/security/zero-trust/zero-trust-overview).

- A tenant with a [Microsoft Entra P1 or P2 license](../../fundamentals/get-started-premium.md) is required to view the Microsoft Entra health scenario monitoring signals.
- The [Reports Reader](../role-based-access-control/permissions-reference.md#reports-reader) role is the least privileged role required to view scenario monitoring signals.
- The `HealthMonitoringAlert.Read.All` permission is required to *view the alerts using the Microsoft Graph API*.
- For a full list of roles, see [Least privileged role by task](../role-based-access-control/delegate-by-task.md#monitoring-and-health---audit-and-sign-in-logs-least-privileged-roles).

## Investigate the signals

You can view the signal using the Microsoft Entra admin center and the Microsoft Graph API. For more information, see [How to investigate health scenario alerts](../monitoring-health/howto-investigate-health-scenario-alerts.md) for guidance on how to gather data using the Microsoft Graph API. 

1. Sign into the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Reports Reader](../role-based-access-control/permissions-reference.md#reports-reader).

1. Browse to **Entra ID** > **Monitoring & health** > **Health**. The page opens to the Service Level Agreement (SLA) Attainment page.

1. Select the **Health Monitoring** tab.

1. Select the **Sign-ins to applications using SAML authentication** scenario.

    :::image type="content" source="media/scenario-health-sign-ins-saml-auth/health-monitoring-saml-authentication.png" alt-text="Screenshot of the SAML Health monitoring scenario." lightbox="media/scenario-health-sign-ins-saml-auth/health-monitoring-saml-authentication-expanded.png":::