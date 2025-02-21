---
title: First party app service principal reference table
description: Reference table that maps application IDs to applications and their service principal usage from the sign-in logs.

author: shlipsey3
manager: amycolannino
ms.service: entra-id
ms.topic: reference
ms.subservice: monitoring-health
ms.date: 02/20/2025
ms.author: sarahlipsey
ms.reviewer: dhanyahk
---
# Microsoft service principal sign-in logs table

The Microsoft service principal sign-in logs capture authentication events for Microsoft services. It can be helpful to understand what's happening with some service-to-service authentication events in your tenant. While not necessary for security investigations, the information can be useful for understanding how your services are interacting with each other.

This article provides a table that maps the application IDs from the logs to the application name. A description of the authentication even is also provided.

## How to access the logs

These logs are only available by configuring diagnostic settings in Microsoft Entra to route the logs to an endpoint of your choice. For full guidance on this process, see [Configure diagnostic settings](howto-configure-diagnostic-settings.md).

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Security Administrator](../role-based-access-control/permissions-reference.md#security-administrator).
1. Browse to **Identity** > **Monitoring & health** > **Diagnostics**.
1. Adjust the filters accordingly.
1. Select **+ Add diagnostic setting**.
1. 

## Microsoft service principal sign-in logs

| Application display name | Application ID | Description |
|---|---|---|
| AAD App Management | f0ae4899-d877-4d3c-ae25-679e38eea492 | App registrations and service principals are created to represent gallery application instances, such as Salesforce or ServiceNow. |
| App Protection | c6e44401-4d0a-4542-ab22-ecd4c90d28d7 | The service automatically disables applications based on user-defined and predefined policies.</br>This app doesn't create app registrations or service principals in your tenant but can disable a service principal associated with a suspicious application. |

