---
title: Learn about the monitoring and health activity log schemas
description: Learn how to interpret the details found in the Microsoft Entra audit and sign-in and logs schema.

author: shlipsey3
manager: pmwongera
ms.service: entra-id
ms.topic: conceptual
ms.subservice: monitoring-health
ms.date: 05/27/2025
ms.author: sarahlipsey
ms.reviewer: egreenberg

# Customer intent: As an IT admin, I want to understand the schema of the Microsoft Entra audit and sign-in logs so that I can interpret the data in the logs and use it to monitor and troubleshoot my organization's identity and access management.
---

# Microsoft Entra activity logs schema

This article describes the information contained in the Microsoft Entra activity logs and how that schema is used by other services. This article covers the schemas from the Microsoft Entra admin center and Microsoft Graph. Descriptions of some key fields are provided.

## Prerequisites

- For license and role requirements, see [Microsoft Entra monitoring and health licensing](../../fundamentals/licensing.md#microsoft-entra-monitoring-and-health).
- The option to download logs is available in all editions of Microsoft Entra ID.
- Downloading logs programmatically with Microsoft Graph requires a [premium license](../../fundamentals/licensing.md#microsoft-entra-monitoring-and-health).
- **Reports Reader** is the least privileged role required to view Microsoft Entra activity logs.
- Audit logs are available for features that you've licensed.
- The results of a downloaded log might show `hidden` for some properties if you don't have the required license.

## What is a log schema?

Microsoft Entra monitoring and health offer logs, reports, and monitoring tools that can be integrated with Azure Monitor, Microsoft Sentinel, and other services. These services need to map the properties of the logs to their service's configurations. The schema is the map of the properties, the possible values, and how they're used by the service. Understanding the log schema is helpful for effective troubleshooting and data interpretation.

Microsoft Graph is the primary way to access Microsoft Entra logs programmatically. The response for a Microsoft Graph call is in JSON format and includes the properties and values of the log. The schema of the logs is defined in the [Microsoft Graph documentation](/graph/api/overview?view=graph-rest-1.0&preserve-view=true).

There are two endpoints for the Microsoft Graph API. The V1.0 endpoint is the most stable and is commonly used for production environments. The beta version often contains more properties, but they're subject to change. For this reason, we don't recommend using the beta version of the schema in production environments.

Microsoft Entra customers can configure activity log streams to be sent to a Log Analytics workspace. This integration enables Security Information and Event Management (SIEM) connectivity, long-term storage, and improved querying capabilities with Log Analytics. The log schemas for Azure Monitor might differ from the Microsoft Graph schemas.

For full details on these schemas, see the following articles:

- [Azure Monitor audit logs](/azure/azure-monitor/reference/tables/auditlogs)
- [Azure Monitor sign-in logs](/azure/azure-monitor/reference/tables/signinlogs)
- [Azure Monitor provisioning logs](/azure/azure-monitor/reference/tables/aadprovisioninglogs)
- [Microsoft Graph audit logs](/graph/api/resources/directoryaudit?view=graph-rest-1.0&preserve-view=true)
- [Microsoft Graph sign-in logs](/graph/api/resources/signin?view=graph-rest-1.0&preserve-view=true)
- [Microsoft Graph provisioning logs](/graph/api/resources/provisioningobjectsummary?view=graph-rest-1.0&preserve-view=true)

## How to interpret the schema

When looking up the definitions of a value, pay attention to the version you're using. There might be differences between the V1.0 and beta versions of the schema.

### Values found in all log schemas

Some values are common across all log schemas. 

- `correlationId`: This unique ID helps correlate activities that span across various services and is used for troubleshooting. This value's presence in multiple logs doesn't indicate the ability to join logs across services.
- `status` or `result`: This important value indicates the result of the activity. Possible values are: `success`, `failure`, `timeout`, `unknownFutureValue`.
- Date and time: The date and time when the activity occurred is in Coordinated Universal Time (UTC).
- Some reporting features require a Microsoft Entra ID P2 license. If you don't have the correct licenses, the value `hidden` is returned.

### Audit logs

- `activityDisplayName`: Indicates the activity name or the operation name (examples: "Create User" and "Add member to group"). For more information, see [Audit log activities](reference-audit-activities.md).
- `category`: Indicates which resource category that's targeted by the activity. For example: `UserManagement`, `GroupManagement`, `ApplicationManagement`, `RoleManagement`. For more information, see [Audit log activities](reference-audit-activities.md).
- `initiatedBy`: Indicates information about the user or app that initiated the activity.
- `targetResources`: Provides information on which resource was changed. Possible values include `User`, `Device`, `Directory`, `App`, `Role`, `Group`, `Policy` or `Other`.

### Sign-in logs

- ID values: There are unique identifiers for users, tenants, applications, and resources. Examples include:
    - `resourceId`: The *resource* that the user signed into.
    - `resourceTenantId`: The tenant that owns the *resource* being accessed. Might be the same as the `homeTenantId`.
    - `homeTenantId`: The tenant that owns the user *account* that is signing in.
- Risk details: Provides the reason behind a specific state of a risky user, sign-in, or risk detection.
    - `riskState`: Reports status of the risky user, sign-in, or a risk event.
    - `riskDetail`: Provides the reason behind a specific state of a risky user, sign-in, or risk detection. The value `none` means that no action has been performed on the user or sign-in so far.
    - `riskEventTypes_v2`: Risk detection types associated with the sign-in.
    - `riskLevelAggregated`: Aggregated risk level. The value `hidden` means the user or sign-in wasn't enabled for Microsoft Entra ID Protection.
- `crossTenantAccessType`: Describes the type of cross-tenant access used to access the resource. For example, B2B, Microsoft Support, and passthrough sign-ins are captured here.
- `status`: The sign-in status that includes the error code and description of the error (if a sign-in failure occurs).

### Applied Conditional Access policies

The `appliedConditionalAccessPolicies` subsection lists the Conditional Access policies related to that sign-in event. The section is called *applied* Conditional Access policies; however, policies that were *not* applied also appear in this section. A separate entry is created for each policy. For more information, see [conditionalAccessPolicy resource type](/graph/api/resources/conditionalaccesspolicy?view=graph-rest-1.0&preserve-view=true).

