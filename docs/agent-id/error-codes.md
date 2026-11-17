---
title: Microsoft agent identity platform error codes
description: Learn about the Agent ID, Agent Blueprint, and Agent Identity error codes.
ms.date: 11/05/2026
ai-usage: ai-assisted
ms.reviewer: ryankabir
ms.topic: error-reference
#Customer intent: As a developer troubleshooting errors, I want to understand the meaning and possible resolutions for the Agent ID error codes, so that I can effectively debug and fix issues in my application.
---

# Microsoft agent identity platform error codes

This article explains Microsoft Graph errors for agent identity objects. OAuth sign-in failures and local tooling failures use different diagnostics; use the routes below before changing a directory object or its permissions.

## Identify the failing layer

| Failure | Start here |
| --- | --- |
| Local browser, WAM, or missing Microsoft Graph sign-in context. | [Management-client sign-in](create-single-instance-agent.md#set-up-the-management-client). An empty `Get-MgContext` isn't successful authentication. |
| OAuth response containing `AADSTS` or token acquisition failure. | [Microsoft identity platform error codes](~/identity-platform/reference-error-codes.md). Confirm tenant, client ID, audience, and the scenario's required consent. |
| Microsoft Graph HTTP error while provisioning or updating objects. | The tables in this article and [Microsoft Graph error responses](/graph/errors). |
| API returns `401` or `403` after a token is acquired. | Your API's token validation and authorization requirements. A token request succeeding doesn't prove that its audience, scopes, roles, or resource access match the API operation. |

For a failed Graph request, retain the HTTP status, `error.code`, `error.message`, request timestamp, and `request-id` response header. Record which operation and tenant failed, but don't include tokens, secrets, or private keys in support requests. Distinguish the [object and client IDs](key-concepts.md#record-the-identifiers-for-your-scenario) before retrying. Don't treat every `403` as a propagation delay or grant broader permissions without diagnosing the denial.

## Handling error codes in your application

The [OAuth2.0 spec](https://tools.ietf.org/html/rfc6749#section-5.2) provides guidance on how to handle errors during authentication using the `error` portion of the error response. For more information on handling error code and the possible `error` field values, see the [Microsoft identity platform and OAuth 2.0 error codes documentation](/entra/identity-platform/reference-error-codes#handling-error-codes-in-your-application).

## Quota and limit errors

These errors occur when you exceed the tenant quota or the maximum number of agent identity blueprints or agent identities.

| Error code | Description |
|---|---|
| `Agent_Directory_QuotaExceeded` | Agent identity blueprints and/or agent identities have exceeded 95% of the tenant resource quota. To create more, you must permanently delete unneeded blueprints or identities. |
| `AgentBlueprint_LimitExceeded` | You've reached the maximum number of agent identity blueprints allowed including active and soft-deleted items. To create more, you must permanently delete unneeded blueprints. |
| `AgentIdentity_LimitExceeded` | You've reached the maximum number of agent identities allowed including active and soft-deleted entries. To add more, you must permanently delete unneeded agent identities. |

## Agent identity blueprint errors

These errors occur when a request includes properties or API versions that agent identity blueprints don't support.

| Error code | Description |
|---|---|
| `AgentBlueprint_IncompatibleProperty` | A property specified in the request is incompatible with agent identity blueprints and can't be set. |
| `AgentBlueprint_IncompatibleProperty_NullPropertyName` | A property in the request is incompatible with agent identity blueprints and can't be set. |
| `AgentBlueprint_NotSupportedOnApiVersion` | Agent identity blueprints aren't supported on the API version used in this request. |

## Agent identity blueprint principal errors

These errors occur when a request includes properties, API versions, or parent resources that agent identity blueprint principals don't support.

| Error code | Description |
|---|---|
| `AgentBlueprintPrincipal_AgentIdentity_IncompatibleProperty` | A property specified in the request is incompatible with agent identity and can't be set. |
| `AgentBlueprintPrincipal_IncompatibleProperty` | A property specified in the request is incompatible with agent identity blueprint principals and can't be set. |
| `AgentBlueprintPrincipal_NotSupportedOnApiVersion` | Agent identity blueprint principals aren't supported on the API version used in this request. |
| `AgentBlueprintPrincipal_RequireAgentBlueprint` | Agent identity blueprint principals can only be created for Agent Blueprints. |

## Agent identity errors

These errors occur when a request references a missing blueprint principal, an incompatible parent type, or unsupported credentials or API versions for agent identities.

| Error code | Description |
|---|---|
| `AgentIdentity_AgentBlueprintPrincipalDoesNotExist` | For a fleet, [create the blueprint principal](create-blueprint.md#create-an-agent-blueprint-principal) and check that its `appId` matches the blueprint. For a single-instance agent, don't create a principal; use the [single-instance provisioning request](create-single-instance-agent.md#provision-the-agent-identity), which references the blueprint object ID. |
| `AgentIdentity_CredentialsNotSupported` | Credentials are not supported for agent identities. All credentials must be added to the agent identity blueprint. |
| `AgentIdentity_IncompatibleParentType` | The specified Application (AppId) isn't an Agent Blueprint. The *AgentIdentityBlueprintId* must be set to the *AppId* of a valid agent identity blueprint. |
| `AgentIdentity_NotSupportedOnApiVersion` | Agent identities aren't supported on the API version used in this request. |

## Agent identity creation errors

These errors occur when the calling principal isn't allowed to create the requested agent identity.

| Error code | Description |
|---|---|
| `Error_AgentBlueprintCannotCreateAssociatedIdentity` | Agent identity blueprints can't create agent identities that are associated with another agent identity blueprint. To create this agent identity, either use the agent identity blueprint that's associated with the agent identity, or perform the operation with a different principal that has the required roles/permissions to create agent identities. |
| `Error_AgentIdentitiesCreatingAgentIdentitiesNotAllowed` | Agent identities can't create other agent identities. To create an agent identity, use the associated agent identity blueprint principal or nonagent blueprint service principal with the required permissions. |
| `Error_AgentIdentitySelfCreateRequired` | Applications can only create agent identities under themselves. The provided *AgentIdentityBlueprintId* doesn't match the calling application's *AppId*. |

## Get help

If you have a question or can't find what you're looking for, see [Support and help options for developers](/entra/identity-platform/developer-support-help-options) to learn about other ways you can get help.
