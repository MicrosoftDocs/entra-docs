---
title: Microsoft Entra Agent ID Logs
description: Learn how audit and sign-in activities associated with agent identities are logged in Microsoft Entra ID.
author: shlipsey3
ms.service: entra
ms.topic: concept-article
ms.date: 11/07/2025
ms.author: sarahlipsey
ms.reviewer: egreenberg14
ms.custom: agent-id-ignite

# Customer intent: As an IT admin, I need to know what information is available in the sign-in logs so that I can use the logs to monitor the health of my tenant and troubleshoot issues.
---
# Microsoft Entra Agent ID logs

As the usage, capabilities, and scope of AI agents grow, it's important to understand how activities associated with agent identities are logged in Microsoft Entra ID. As an IT admin, you need to know what information is available in the audit and sign-in logs and how to use that information to monitor agent activity.

This article describes how agent identity activities are logged in Microsoft Entra ID and how to access those logs using the Microsoft Entra admin center and Microsoft Graph.

## Audit log types

Agent related activity appears in the audit logs and the sign-in logs.

### Audit logs

Agent activity is logged under the base identity type from where they originate. There are currently three agent identity types that appear in the audit logs, each correlating to an existing identity type in Microsoft Entra ID.

For example, the creation of an agent identity user appears as a "Create user" audit activity. Creating an agent identity appears as a "Create service principal" and deleting an agent identity blueprint appears as a "Delete application" audit event.

### Sign-in logs

A new complex sign-in log resource type, `agentSignIn`, now appears in the Microsoft Entra sign-in logs. This resource type contains properties about the agent, such as if the agent is an app or an instance of an app. Because agents can sign in with either user-delegated or app-only permissions, their sign-ins might appear across each of the four sign-in log types. The new sign-in log resource type is available in the Microsoft Entra admin center and the Microsoft Graph API.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Reports Reader](../../identity/role-based-access-control/permissions-reference.md#reports-reader).
1. Browse to **Entra ID** > **Monitoring & health** > **Sign-in logs**.
1. Use the following filter options to view agent sign-ins:
   - **Agent type**: Choose from **Agent ID user**, **Agent Identity**, **Agent Identity Blueprint** or **Not Agentic**
   - **Is Agent**: Choose from **No** or **Yes**

## Agent identity logs with Microsoft Graph

Microsoft Entra Agent ID logs can be viewed and managed using Microsoft Graph on the `/beta` endpoint.

To get started, follow these instructions to work with recommendations using Microsoft Graph in Graph Explorer.

1. Sign in to [Graph Explorer](https://developer.microsoft.com/graph/graph-explorer).
1. Select **GET** as the HTTP method from the dropdown.
1. Set the API version to **beta**.

### Retrieve agent identity sign-in events

To retrieve only sign-in events where Microsoft Entra Agent ID was involved, you need to find events initiated by a service principal where the agent type is `AgentIdentity`. Use the following Microsoft Graph request:

```http
GET https://graph.microsoft.com/beta/auditLogs/signIns?$filter=signInEventTypes/any(t: t eq 'servicePrincipal') and agent/agentType eq 'AgentIdentity'
```