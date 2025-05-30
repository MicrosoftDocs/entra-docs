---
title: Sign-in logs in Microsoft Entra ID
description: Learn about the different types of sign-in logs that are available in Microsoft Entra monitoring and health.
author: shlipsey3
manager: femila
ms.service: entra-id
ms.topic: conceptual
ms.subservice: monitoring-health
ms.date: 05/21/2025
ms.author: sarahlipsey
ms.reviewer: egreenberg14
ms.custom: sfi-image-nochange
# Customer intent: As an IT admin, I need to know what information is available in the sign-in logs so that I can use the logs to monitor the health of my tenant and troubleshoot issues.
---
# What are Microsoft Entra sign-in logs?

Microsoft Entra logs all sign-ins into a Microsoft Entra tenant, which includes your internal apps and resources. As an IT administrator, you need to know what the sign-in log details mean, so that you can interpret the log values correctly.

Reviewing sign-in errors and patterns provides valuable insight into how your users access applications and services. The sign-in logs provided by Microsoft Entra ID are a powerful type of [activity log](overview-monitoring-health.md) that you can analyze. This article describes several key aspects of the sign-in logs.

Two other activity logs are also available to help monitor the health of your tenant:

- **[Audit](concept-audit-logs.md)** – Information about changes applied to your tenant, such as users and group management or updates applied to your tenant’s resources.
- **[Provisioning](concept-provisioning-logs.md)** – Activities performed by a provisioning service, such as the creation of a group in ServiceNow or a user imported from Workday.

## What can you do with sign-in logs?

You can use the sign-in logs to answer questions such as:

- How many users signed into a particular application this week?
- How many failed sign-in attempts occurred in the last 24 hours?
- Are users signing in from specific browsers or operating systems?
- Which of my Azure resources were accessed by managed identities and service principals?

You can also describe the activity associated with a sign-in request by identifying the following details:

- **Who** – The identity (User) performing the sign-in.
- **How** – The client (Application) used for the sign-in.  
- **What** – The target (Resource) accessed by the identity.

> [!NOTE]
> Entries in the sign-in logs are system generated and can't be changed or deleted.

## How do you access the sign-in logs?

There are several ways to access the logs, depending on your needs. For more information, see [How to access activity logs](howto-access-activity-logs.md).

To view the sign-in logs from the Microsoft Entra admin center:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Reports Reader](../role-based-access-control/permissions-reference.md#reports-reader).
1. Browse to **Entra ID** > **Monitoring & health** > **Sign-in logs**.

To more effectively use the sign-in logs in the Microsoft Entra admin center, adjust the filters to only view a specific set of logs. For more information, see [Filter sign-in logs](howto-customize-filter-logs.md).

## What are the types of sign-in logs?

There are four types of logs in the sign-in logs preview:

- [Interactive user sign-ins](concept-interactive-sign-ins.md)
- [Non-interactive user sign-ins](concept-noninteractive-sign-ins.md)
- [Service principal sign-ins](concept-service-principal-sign-ins.md)
- [Managed identity sign-ins](concept-managed-identity-sign-ins.md)

The classic sign-in logs only include interactive user sign-ins.

### Microsoft Entra Agent ID

The Microsoft Entra Agent ID was launched at Microsoft Build 2025 and provides a unified directory of all agent identities created across Microsoft Copilot Studio and Azure AI Foundry. With this initial release, IT administrators can view and manage agent identities directly in the Microsoft Entra admin center, including updated sign-in logs. Because agents can operate with user-delegated or app-only permissions, their sign-ins might appear across each of the four sign-in log types.

A new complex sign-in log resource type, `agentSignIn`, was added to the Microsoft Entra sign-in logs. This resource type contains properties about the agent, such as if the agent is an app or an instance of an app. If the agent type is `agenticAppInstance`, the `parentID` property is included to provide traceability to the provisioning agent.

The new sign-in log resource type is available in the Microsoft Entra admin center and the Microsoft Graph API.

- Use the `isAgent` filter in the Microsoft Entra admin center sign-in logs to filter on only agentic sign-in events.
- From **Enterprise applications**, set the **Application type** filter to **Agent ID (Preview)** to view all agent identities in your tenant. Then select **Sign-in logs** from the app details page to view the sign-in activity.
- For information about the resource type in Microsoft Graph, see [agentSignIn](/graph/api/resources/agentic-agentsignin?view=graph-rest-beta&preserve-view=true) 

For more information, see the [Microsoft Entra Blog](https://techcommunity.microsoft.com/blog/microsoft-entra-blog/announcing-microsoft-entra-agent-id-secure-and-manage-your-ai-agents/3827392) announcement.

## Sign-in data used by other services

Sign-in data is used by several services in Azure and Microsoft Entra to monitor risky sign-ins, provide insight into application usage, and more. 

### Microsoft Entra ID Protection
<a name='azure-ad-identity-protection'></a>

Sign-in log data visualization that relates to risky sign-ins is available in the **Microsoft Entra ID Protection** overview, which uses the following data:

- Risky users
- Risky user sign-ins
- Risky workload identities

For more information about the Microsoft Entra ID Protection tools, see the [Microsoft Entra ID Protection overview](../../id-protection/overview-identity-protection.md).

### Microsoft Entra Usage and insights
<a name='azure-ad-usage-and-insights'></a>

To view application-specific sign-in data, browse to **Microsoft Entra ID** > **Monitoring & health** > **Usage & insights**. These reports provide a closer look at sign-ins for Microsoft Entra application activity and AD FS application activity. For more information, see [Microsoft Entra Usage & insights](concept-usage-insights-report.md).

:::image type="content" source="media/concept-sign-ins/usage-insights.png" alt-text="Screenshot of the Usage & insights report." lightbox="media/concept-sign-ins/usage-insights-expanded.png":::

There are several reports available in **Usage & insights**. Some of these reports are in preview.

- Microsoft Entra application activity (preview)
- AD FS application activity
- Authentication methods activity
- Service principal sign-in activity
- Application credential activity

### Microsoft 365 activity logs

You can view Microsoft 365 activity logs from the [Microsoft 365 admin center](/microsoft-365/admin/admin-overview/admin-center-overview). Microsoft 365 activity and Microsoft Entra activity logs share a significant number of directory resources. Only the Microsoft 365 admin center provides a full view of the Microsoft 365 activity logs.

You can access the Microsoft 365 activity logs programmatically by using the [Office 365 Management APIs](/office/office-365-management-api/office-365-management-apis-overview).
