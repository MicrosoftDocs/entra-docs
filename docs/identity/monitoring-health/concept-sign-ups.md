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

### Fine-tune your queries

To search for specific activity log entries, use the $filter and createdDateTime query parameters with one of the available properties. Some of the following queries use the `beta` endpoint. The beta endpoint is subject to change and isn't recommended for production use.

- [Sign-up log properties](/graph/api/resources/signup#properties)

Try using the following queries for sign-up activity:

- For sign-up attempts that failed at any point during sign-up:
  - *Need Graph call*

- For signup attempts that failed during user object creation:
  - *Need Graph call*

- For sign-up attempts that failed during email validation (applies only to local accounts):
  - *Need Graph call*

- For sign-ups during a date range:
  - GET `https://graph.microsoft.com/v1.0/auditLogs/signIns?&$filter=(createdDateTime ge 2024-01-13T14:13:32Z and createdDateTime le 2024-01-14T17:43:26Z)`

- For sign-ups for a specific application:
  - GET `https://graph.microsoft.com/v1.0/signupLogs/signIns?&$filter=appId eq 'APP ID'`

- For local account sign-ups:
  - *Need Graph call*

- For social account sign-ups:
  - *Need Graph call*

- To get the authentication method or identity provider of a user:
  - *Need Graph call*
  - Requires `UserAuthenticationMethod.Read.All` permission

- To query the user object to get the authentication method:
  - GET `https://graph.microsoft.com/beta/users/{userObjectId}/authentication/methods`
  - Requires `UserAuthenticationMethod.Read.All` permission

- For sign-in log entries with the same correlation id:
  - *Need Graph call*

- For sign-up attempts that included calls to a token augmentation custom extension:
  - *Need Graph call*

- For sign-up attempts for a specific user flow:
  - *Need Graph call*

## Next steps
