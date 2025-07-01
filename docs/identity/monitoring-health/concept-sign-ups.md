---
title: Sign-up logs in Microsoft Entra External ID
description: Learn about the sign-up logs that are available in Microsoft Entra External ID monitoring and health.
author: msmimart
manager: celestedg
ms.service: entra-id
ms.topic: conceptual
ms.subservice: monitoring-health
ms.date: 06/30/2025
ms.author: mimart
ms.reviewer: celested

# Customer intent: As an IT admin for an external tenant, I need to know what information is available in the sign-up logs so that I can use the logs to monitor all sign-up attempts and troubleshoot issues.
---
# External ID sign-up logs (preview)

[!INCLUDE [applies-to-external-only](../../includes/applies-to-external-only.md)]

Microsoft Entra External ID logs all self-service sign-up events, including both successful sign-ups and failed attempts. The logs include information that helps organizations optimize their sign-up processes, enhance the user experience, and improve overall customer engagement. This article explains how to access and use the sign-up logs.

The sign-up logs provided by Microsoft Entra External ID are a powerful type of [activity log](overview-monitoring-health.md) that you can analyze. In addition to the External ID sign-up logs, three other activity logs are also available to help monitor the health of your external tenant:

- **[Sign-ins](concept-sign-ins.md)** – Information about sign-ins and how your resources are used by your users.
- **[Audit](concept-audit-logs.md)** – Information about changes applied to your tenant, such as users and group management or updates applied to your tenant’s resources.
- **[Provisioning](concept-provisioning-logs.md)** – Activities performed by a provisioning service, such as the creation of a group in ServiceNow or a user imported from Workday.

## What can you do with sign-up logs?

You can use the sign-up logs to find the following information:

- The percentage of sign-up attempts that result in account creation.
- The stage in the sign-up process with the highest drop-off rate.
- How drop-off rates compare between social sign-ups and local account sign-ups.

You can also describe the activity associated with a sign-up request by identifying the following details:

- Who performed the sign-up
- When the user performed the sign-up
- How the user signed up (for example, local account or social identity provider)
- What app they accessed to sign up
- Whether the sign-up was successful
- Where an unsuccessful sign-up failed in the sign-up flow
- Whether the user who tried to sign up already had an account  

## Next steps

[Access activity logs using Microsoft Graph](howto-analyze-activity-logs-with-microsoft-graph.md) and query the activity logs for [sign-up activity](howto-analyze-activity-logs-with-microsoft-graph.md#sample-sign-up-queries-preview).
