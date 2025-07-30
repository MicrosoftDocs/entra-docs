---
title: Sign-ins to applications using SAML authentication
description: Learn about the Microsoft Entra Health signals and alerts for sign-ins to applications that use SAML authentication
author: shlipsey3
manager: pmwongera 
ms.service: entra-id
ms.topic: how-to
ms.subservice: monitoring-health
ms.date: 07/23/2025
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

> [!IMPORTANT]
> Microsoft Entra Health scenario monitoring and alerts are currently in PREVIEW.
> This information relates to a prerelease product that might be substantially modified before release. Microsoft makes no warranties, expressed or implied, with respect to the information provided here.

## Prerequisites

There are different roles, permissions, and license requirements to view health monitoring signals and configure and receive alerts. We recommend using a role with least privilege access to align with the [Zero Trust guidance](/security/zero-trust/zero-trust-overview).

- A tenant with a [Microsoft Entra P1 or P2 license](../../fundamentals/get-started-premium.md) is required to view the Microsoft Entra health scenario monitoring signals.
- The [Reports Reader](../role-based-access-control/permissions-reference.md#reports-reader) role is the least privileged role required to view scenario monitoring signals.
- The `HealthMonitoringAlert.Read.All` permission is required to *view the alerts using the Microsoft Graph API*.
- For a full list of roles, see [Least privileged role by task](../role-based-access-control/delegate-by-task.md#microsoft-entra-health-least-privileged-roles).

## Investigate the signals and alerts

[!INCLUDE [entra-health-alerts-investigate](../../includes/entra-health-alerts-investigate.md)]

1. Sign into the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Reports Reader](../role-based-access-control/permissions-reference.md#reports-reader).

1. Browse to **Entra ID** > **Monitoring & health** > **Health**. The page opens to the Service Level Agreement (SLA) Attainment page.

1. Select the **Health Monitoring** tab.

1. Select the **Sign-ins to applications using SAML authentication** scenario and then select an active alert.

    :::image type="content" source="media/scenario-health-sign-ins-saml-auth/health-monitoring-saml-authentication.png" alt-text="Screenshot of the SAML Health monitoring scenario." lightbox="media/scenario-health-sign-ins-saml-auth/health-monitoring-saml-authentication-expanded.png":::

1. View the signal from the **View data graph** section to get familiar with the pattern and identify anomalies.

1. View the signal from the **View data graph** section to get familiar with the pattern and identify anomalies.

1. Review the sign-in logs.
    - [Review the sign-in log details](concept-sign-in-log-activity-details.md).
    - In the Microsoft Entra admin center, you might need to add the **Authentication protocol** column, then filter for **SAML 2.0** sign-ins to look for patterns in the sign-ins.

## Mitigate common issues

The following common issues could cause a spike or dip in sign-ins to applications using SAML authentication. In general, this alert fires if a new application was rolled out without being properly configured for SAML authentication. This list isn't exhaustive, but provides a starting point for investigation.

### Application is missing signing certificates

A decrease in SAML sign-ins could indicate users are blocked because the application is missing the signing certificate. The application object is considered corrupted, and users can't sign in to the application.

To investigate:

1. From the **Affected entities** section of the selected scenario, select **View** for applications.
    - A list of affected applications appears in a panel. Select the application to navigate directly to the application registration details.
1. Check the **Certificates and secrets** section of the application to ensure that the signing certificate is present and valid.
    - If the signing certificate is missing or expired, you need to update it with a valid certificate.
1. Browse to the **Enterprise applications** > **Single sign-on** and select **Edit** in the **SAML Certificates** tile to update the certificate.
1. After updating the certificate and validating the configuration works, remove any old certificates that are no longer needed.

### Reply URL is missing or incorrect

A dip in SAML sign-ins could also indicate the SAML reply URL is missing or incorrect. Sign-in attempts are blocked because Microsoft doesn't know where to send the sign-in response.

To investigate:

1. From the **Affected entities** section of the selected scenario, select **View** for applications.
    - A list of affected applications appears in a panel. Select the application to navigate directly to the application registration details.
1. From **Enterprise applications** > **Single sign-on** and review the **Basic SAML Configuration** tile and make sure the **Reply URL** is configured correctly.
    - If the reply URL is missing or incorrect, you need to update it with the correct URL.

### Application access is misconfigured

A dip in SAML sign-ins might mean the access permissions for the application are misconfigured, preventing users from signing in. This dip could affect a small number of users or a large group, depending on if the user or the application that doesn't have the correct permissions.

If the dip in sign-ins affects a small number of users:

1. From the **Affected entities** section of the selected scenario, select **View** for users.
1. Select a user to navigate directly to their profile where you can review their group memberships and role permissions.

If the dip in sign-ins affects a large group of users:

1. From the **Affected entities** section of the selected scenario, select the **View** link for any affected applications.
    - Confirm that the appropriate sign-sign on configurations and app permissions are in place.
1. Review any Conditional Access policies that might block access to the application.

## Related content

- LINKS