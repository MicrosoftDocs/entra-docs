---
title: Microsoft agent identity platform error codes
description: Learn about the Agent ID, Agent Blueprint, and Agent Identity error codes.
author: SHERMANOUKO
ms.author: shermanouko
ms.date: 12/02/2025
ms.service: entra-id
ms.reviewer: ryankabir
ms.topic: error-reference
#Customer intent: As a developer troubleshooting errors, I want to understand the meaning and possible resolutions for the Agent ID error codes, so that I can effectively debug and fix issues in my application.
---

# Microsoft agent identity platform error codes

This article provides a comprehensive reference for error codes you might encounter when working with the Microsoft agent identity platform.

## Handling error codes in your application

The [OAuth2.0 spec](https://tools.ietf.org/html/rfc6749#section-5.2) provides guidance on how to handle errors during authentication using the `error` portion of the error response. For more information on handling error code and the possible `error` field values, see the [Microsoft identity platform and OAuth 2.0 error codes documentation](/entra/identity-platform/reference-error-codes#handling-error-codes-in-your-application).

## Microsoft agent identity platform error codes

The following table describes the error codes specific to the Microsoft agent identity platform.

| Error | Description |
|---|---|
| `AgentBlueprint_NotSupportedOnApiVersion` | Agent identity blueprints aren't supported on the API version used in this request. |
| `AgentBlueprint_IncompatibleProperty` | A property specified in the request is incompatible with agent identity blueprints and can't be set. |
| `AgentBlueprint_IncompatibleProperty_NullPropertyName` | A property in the request is incompatible with agent identity blueprints and can't be set. |
| `AgentBlueprintPrincipal_AgentIdentity_IncompatibleProperty` | A property specified in the request is incompatible with agent identity and can't be set. |
| `AgentBlueprintPrincipal_IncompatibleProperty` | A property specified in the request is incompatible with agent identity blueprint principals and can't be set. |
| `AgentBlueprintPrincipal_requireAgentBlueprint` | Agent identity blueprint principals can only be created for Agent Blueprints. |
| `AgentBlueprint_LimitExceeded` | You've reached the maximum number of agent identity blueprints allowed including active and soft-deleted items. To create more, you must permanently delete unneeded blueprints. |
| `AgentIdentity_LimitExceeded` | You've reached the maximum number of agent identities allowed including active and soft-deleted entries. To add more, you must permanently delete unneeded agent identities. |
| `AgentIdentity_AgentBlueprintPrincipalDoesNotExist` | The required agent identity blueprint principal doesn't exist for the specified agent identity blueprint ID. |
| `AgentIdentity_IncompatibleParentType` | The specified Application (AppId) isn't an Agent Blueprint. The *AgentIdentityBlueprintId* must be set to the *AppId* of a valid agent identity blueprint. |
| `Error_AgentIdentitiesCreatingAgentIdentitiesNotAllowed` | Agent identities can't create other agent identities. To create an agent identity, use the associated agent identity blueprint principal or nonagent blueprint service principal with the required permissions. |
| `Error_AgentBlueprintCannotCreateAssociatedIdentity` | Agent identity blueprints can't create agent identities that are associated with another agent identity blueprint. To create this agent identity, either use the agent identity blueprint that's associated with the agent identity, or perform the operation with a different principal that has the required roles/permissions to create agent identities. |
| `Error_AgentIdentitySelfCreateRequired` | Applications can only create agent identities under themselves. The provided *AgentIdentityBlueprintId* doesn't match the calling application's *AppId*. |
| `AgentBlueprintPrincipal_NotSupportedOnApiVersion` | Agent identity blueprint principals aren't supported on the API version used in this request. |
| `AgentIdentity_NotSupportedOnApiVersion` | Agent identities aren't supported on the API version used in this request. |

## Get help

If you have a question or can't find what you're looking for, see [Support and help options for developers](/entra/identity-platform/developer-support-help-options) to learn about other ways you can get help.
