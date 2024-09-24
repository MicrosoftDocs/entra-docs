---
title: Sign-up logs in Microsoft Entra External ID
description: Learn about the sign-up logs that are available in Microsoft Entra External ID monitoring and health.
author: msmimart
manager: celestedg
ms.service: entra-id
ms.topic: conceptual
ms.subservice: monitoring-health
ms.date: 03/01/2024
ms.author: mimart
ms.reviewer: celested

# Customer intent: As an IT admin for an external tenant, I need to know what information is available in the sign-up logs so that I can use the logs to monitor all sign-up attempts and troubleshoot issues.
---
# What are External ID sign-up logs?

Microsoft Entra External ID logs all self-service sign-up events, including both successful sign-ups and failed attempts. The logs include information that helps organizations optimize their sign-up processes, enhance the user experience, and improve overall customer engagement. This article explains how to access and use the sign-up logs.

The sign-up logs provided by Microsoft Entra External ID are a powerful type of [activity log](overview-monitoring-health.md) that you can analyze. In addition to the External ID sign-up logs, three other activity logs are also available to help monitor the health of your external tenant:

- **[Sign-ins](concept-sign-ins.md)** – Information about sign-ins and how your resources are used by your users.
- **[Audit](concept-audit-logs.md)** – Information about changes applied to your tenant, such as users and group management or updates applied to your tenant’s resources.
- **[Provisioning](concept-provisioning-logs.md)** – Activities performed by a provisioning service, such as the creation of a group in ServiceNow or a user imported from Workday.

## License and role requirements

[!INCLUDE [Microsoft Entra monitoring and health](../../includes/licensing-monitoring-health.md)]

## What can you do with sign-up logs?

You can use the sign-in logs to find the following information:

- The percentage of sign-up attempts that result in account creation.
- The stage in the sign-up process with the highest drop-off rate.
- How drop-off rates compare between social sign-ups and local account sign-ups.

You can also describe the activity associated with a sign-up request by identifying the following details:

- **Who** – The identity (User) performing the sign-in.
- **How** – The client (Application) used for the sign-in.  
- **What** – The target (Resource) accessed by the identity.

## Next steps

[Access activity logs using Microsoft Graph](howto-analyze-activity-logs-with-microsoft-graph.md) and query the activity logs for [sign-up activity](howto-analyze-activity-logs-with-microsoft-graph.md#sample-sign-up-queries).
