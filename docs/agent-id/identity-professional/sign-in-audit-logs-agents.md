---
title: Agent identity logs
description: Learn about enhanced logging capabilities for agent identities, including the agentSignIn resource type.
author: omondiatieno
ms.author: jomondi
manager: mwongerapk
ms.service: entra-id
ms.topic: concept-article
ms.date: 11/04/2025
ms.reviewer: egreenberg

#customer-intent: As an IT administrator, I want to understand the enhanced logging capabilities available for agent identities and know where to find comprehensive documentation for sign-in and audit logs.
---

# Agent identity logs

Microsoft Entra Agent ID platform provides enhanced logging capabilities that extend traditional sign-in and audit logs with agent-specific information. These enhancements ensure comprehensive visibility into agent activities across your organization, whether agents operate with user-delegated permissions or app-only access.

The logging system introduces two key enhancements: an `agentSignIn` resource type for capturing agent authentication events, and additional metadata into the base-type audit categories that specify when an identity is an AgentID.

## Sign-in logs for agents

Agent sign-in activities are captured within existing sign-in event types but with enhanced visibility via the `agentSignIn` resource type. This allows customers to determine when an agent ID was the subtype of the identity involved in an authentication event. This resource type includes agent type identification, parent-child relationships for agent instances, and blueprint correlation for centralized management visibility.

Access agent sign-in logs through the Microsoft Entra admin center using the `isAgent` and `IsAgentSubject` filters in sign-in logs, or programmatically through the Microsoft Graph API using the enhanced `agentSignIn` resource type. The system provides visibility, capturing agent activities across Microsoft platforms such as Microsoft Copilot Studio and Azure AI Foundry, and third-party platforms.

For comprehensive information about sign-in logs capabilities, filtering options, and detailed analysis, see [Sign-in logs in Microsoft Entra ID](../identity/monitoring-health/concept-sign-ins.md).

## Audit logs for agents

Agent audit logging provides comprehensive tracking capabilities. This includes agent application operations, service principal management, individual agent identity operations, and specialized user principal operations for agents requiring user-like capabilities. The audit system includes an enhanced schema with a `PerformedBy` entity that identifies when agents perform operations, including identity type distinction and blueprint correlation.

Access agent audit logs through the Microsoft Entra admin center or programmatically through the Microsoft Graph API using the standard directoryAudits endpoint with agent-specific filtering.

For comprehensive information about audit logs structure, querying capabilities, and detailed operational tracking, see [Learn about the audit logs in Microsoft Entra ID](../identity/monitoring-health/concept-audit-logs.md).

## Accessing agent logs

Both sign-in and audit logs for agents are available through standard Microsoft Entra interfaces:

- Microsoft Entra admin center with specialized filtering for agent activities
- Microsoft Graph API with enhanced resource types and filtering capabilities
- Export logs to storage or a Security Incident and Event Management service through [Diagnostic Settings](https://learn.microsoft.com/en-us/entra/identity/monitoring-health/howto-configure-diagnostic-settings)

Agent activities might appear across different log types depending on the operation and permission model used, so check multiple log sources for comprehensive visibility.

## Related content

- [Sign-in logs in Microsoft Entra ID](../identity/monitoring-health/concept-sign-ins.md)
- [Learn about the audit logs in Microsoft Entra ID](../identity/monitoring-health/concept-audit-logs.md)
- [agentSignIn resource type](/graph/api/resources/agentic-agentsignin?view=graph-rest-beta&preserve-view=true)
