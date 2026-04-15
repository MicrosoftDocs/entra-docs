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

## Audit logs

Agent activity is logged under the base identity type from where the activity originates. There are currently three agent identity types that appear in the audit logs, each correlating to an existing identity type in Microsoft Entra ID.

- **Agent identity blueprint** activities appear as application events (for example, "Add application" or "Delete application").
- **Agent identity** activities appear as service principal events (for example, "Add service principal" or "Update service principal").
- **Agent's user account** activities appear as user events (for example, "Add user").

To identify whether an audit event involves an agent identity, check the `agentType` property on the `initiatedBy` and `targetResources` fields. A value other than `notAgentic` indicates agent involvement.

### agentType

A new `agentType` value now appears to further clarify agent identity actions. The `agentType` property indicates whether the identity involved in an audit event is an agent identity, agent identity blueprint, or an agent's user account.

The `agentType` property appears on the following resources:
- [auditAppIdentity](/graph/api/resources/auditappidentity?view=graph-rest-beta&preserve-view=true)
- [auditUserIdentity](/graph/api/resources/audituseridentity?view=graph-rest-beta&preserve-view=true)
- [targetResource](/graph/api/resources/targetresource?view=graph-rest-beta&preserve-view=true)
- [auditActivityPerformer](/graph/api/resources/auditactivityperformer?view=graph-rest-beta&preserve-view=true)

| Value | Description |
|---|---|
| `notAgentic` | The identity isn't an agent. This is a standard app, user, or service principal. |
| `agenticApp` | An agent identity blueprint, which is the template or definition for an agent. Analogous to an app registration. |
| `agenticAppInstance` | An agent identity, which is a specific running instance of an agent. Analogous to a service principal. |
| `agentIdentityBlueprintPrincipal` | The blueprint principal itself, which is the service principal that represents the blueprint. |
| `agentIDuser` | An agent's user account. This identity lets an agent act as a user with user-delegated permissions. |
| `unknownFutureValue` | Evolvable enumeration sentinel value. Don't use. |

The following table summarizes how these agent activities and values map together and appear in the audit logs:

| Agent action | Audit activity | agentType value |
|---|---|---|
| Create an agent identity blueprint | Add application | `agenticApp` |
| Create an agent identity | Add service principal | `agenticAppInstance` |
| Create an agent's user account | Add user | `agentIDuser` |
| Update an agent identity blueprint | Update application | `agenticApp` |
| Update an agent identity | Update service principal | `agenticAppInstance` |
| Delete an agent identity blueprint | Delete application | `agenticApp` |
| Delete an agent identity | Delete service principal | `agenticAppInstance` |

> [!TIP]
> To receive `agentIdentityBlueprintPrincipal` and `agentIDuser` values in Microsoft Graph responses, include the `Prefer: include-unknown-enum-members` request header. These values are part of an [evolvable enumeration](/graph/best-practices-concept#handling-future-members-in-evolvable-enumerations).

### blueprintId

The `blueprintId` property is the object ID of the [agentIdentityBlueprint](/graph/api/resources/agentidentityblueprint?view=graph-rest-beta&preserve-view=true) associated with the agent. Use this property to correlate an agent identity (instance) back to its blueprint (template). This property appears on [auditAppIdentity](/graph/api/resources/auditappidentity?view=graph-rest-beta&preserve-view=true), [targetResource](/graph/api/resources/targetresource?view=graph-rest-beta&preserve-view=true), and [auditActivityPerformer](/graph/api/resources/auditactivityperformer?view=graph-rest-beta&preserve-view=true).

The relationship between `blueprintId` and the agent identity is similar to the relationship between an app registration and its service principal. Multiple agent identities can share the same blueprint.

### What changed in the audit log schema

The following changes to the audit log schema enable agent identity tracking:

- The `initiatedBy.app` property now uses the [auditAppIdentity](/graph/api/resources/auditappidentity?view=graph-rest-beta&preserve-view=true) resource type, which includes `agentType` and `blueprintId` alongside the existing `appId`, `displayName`, `servicePrincipalId`, and `servicePrincipalName` properties.
- The [targetResource](/graph/api/resources/targetresource?view=graph-rest-beta&preserve-view=true) resource type now includes `agentType` and `blueprintId` properties.
- The [auditUserIdentity](/graph/api/resources/audituseridentity?view=graph-rest-beta&preserve-view=true) resource type now includes an `agentType` property.
- A new [auditActivityPerformer](/graph/api/resources/auditactivityperformer?view=graph-rest-beta&preserve-view=true) resource type provides `agentType`, `appId`, and `blueprintId` for the actor of an audit event.

## Sign-in logs

A complex sign-in log resource type, `agentSignIn`, appears in the Microsoft Entra sign-in logs. This resource type contains properties about the agent, such as if the agent is an app or an instance of an app. Because agents can sign in with either user-delegated or app-only permissions, their sign-ins might appear across each of the four sign-in log types. The `agentSignIn` resource type is available in the Microsoft Entra admin center and the Microsoft Graph API.

### [Microsoft Entra admin center](#tab/microsoft-entra-admin-center)

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Reports Reader](../identity/role-based-access-control/permissions-reference.md#reports-reader).
1. Browse to **Entra ID** > **Monitoring & health** > **Sign-in logs**.
1. Use the following filter options to view agent sign-ins:
   - **Agent type**: Choose from **Agent ID user**, **Agent Identity**, **Agent Identity Blueprint** or **Not Agentic**
   - **Is Agent**: Choose from **No** or **Yes**


### [Microsoft Graph](#tab/microsoft-graph)

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
