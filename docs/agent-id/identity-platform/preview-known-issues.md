---
title: Known issues and gaps for Microsoft Entra Agent ID preview
description: Learn about currently known issues and errors encountered when using the Microsoft Entra Agent ID preview.
author: SHERMANOUKO
ms.author: shermanouko
ms.service: entra-id
ms.topic: troubleshooting-known-issue
ms.date: 12/02/2025
ms.custom: agent-id-ignite
ms.reviewer: dastrock
#customer-intent: As a developer or IT administrator, I want to understand known issues and gaps in the Microsoft Entra Agent ID preview so that I can plan accordingly when deploying AI agents in my organization.
---

# Microsoft Entra Agent ID preview: Known issues and gaps

This article lists limitations, issues, and feature gaps observed in the preview. You can always return to this article for the most up to date known issues. These items can change or be resolved without notice. Microsoft Entra Agent ID is subject to its [standard preview terms and conditions](/entra/fundamentals/licensing-preview-info).

## Agent identities and agent identity blueprints

The following known issues and gaps relate to agent identities and agent identity blueprints.

### Agent IDs in Graph API relationships

Microsoft Graph APIs support various relationships involving agent identities and agent identity blueprints, such as `/ownedObjects`, `/deletedItems`, `/owners`, and more. There's no way to filter these queries to return only Agent IDs. 

**Resolution**: Use the existing APIs documented in Microsoft Graph reference docs and perform client side filtering using the `odata.type` property to filter results to Agent IDs.

## Agent users

The following known issues and gaps relate to agent users.

### Clean up agent users

When an agent identity blueprint or agent identity is deleted, any agent users created using that blueprint or identity remain in the tenant. They aren't shown as disabled or deleted, though they can't authenticate. 

**Resolution**: Delete any orphaned agent users via Microsoft Entra admin center, Microsoft Graph APIs, or scripting tools.

## Roles and permissions for agent identity management

The following known issues and gaps relate to roles and permissions for managing agent identities.

### Global Reader can't list agent identities

When querying Microsoft Graph APIs to list agent identities using the endpoint `GET https://graph.microsoft.com/beta/servicePrincipals/graph.agentIdentity`, users assigned the Global Reader role receive a `403 Unauthorized` response.

**Resolution**: Use the endpoint `GET https://graph.microsoft.com/beta/servicePrincipals` instead to make the query.

### Delegated permissions for agent identity creation

There's currently no viable delegated permission for creating agent identities. 

**Resolution**: Implementers must use application permissions to create agent identities.

### Directory.AccessAsUser.All causes other permissions to be ignored

When creating, updating, and deleting Agent IDs, clients can use delegated permissions like *AgentIdentityBlueprint.Create* and *AgentIdentityBlueprintPrincipal.EnableDisable.All*. However, if the client has been granted the delegated permission *Directory.AccessAsUser.All*, the client's permission to create and modify Agent IDs are ignored. This can cause Microsoft Graph requests to fail with `403 Unauthorized`, even though the client and user have the appropriate permissions.

**Resolution**: Remove the *Directory.AccessAsUser.All* permission from the client, request new access tokens, and retry the request.

### Custom roles

You can't include actions for management of agent identities in Microsoft Entra ID custom role definitions.

**Resolution**: Use built-in roles *Agent ID Administrator* and *Agent ID Developer* for all management of Agent IDs.

### Administrative units

You can't add agent identities, agent identity blueprints, and agent identity blueprint principals to administrative units.

**Resolution**: Use the `owners` property of Agent IDs to limit the set of users who can manage these objects.

### Updating photos for agent users

The *Agent ID Administrator* role can't update photos for agent users.

**Resolution**: Use the *User Administrator* role to update photos for agent users.

## Microsoft Entra admin center

The following known issues and gaps relate to the Microsoft Entra admin center.

### No agent identity blueprint management

You can't create or edit agent identity blueprints through the Microsoft Entra admin center or the Azure portal.

**Resolution**: To create agent identity blueprints, follow the [documentation to create and edit blueprint configuration](./create-blueprint.md) using Microsoft Graph APIs and PowerShell.

## Authentication protocols

The following known issues and gaps relate to authentication protocols.

### Single-Sign-On to web apps

Agent IDs can't sign-in to Microsoft Entra ID's sign-in pages. This means they can't single-sign on to websites and web apps using the OpenID Connect or SAML protocols. 

**Resolution**: Use available web APIs to integrate agents with workplace apps and services.

## Consent and permissions

The following known issues and gaps relate to consent and permissions.

### Admin consent workflow (ACW)

The Microsoft Entra ID [admin consent workflow](/entra/identity/enterprise-apps/configure-admin-consent-workflow) doesn't work properly for permissions requested by Agent IDs.

**Resolution**: Users can contact their Microsoft Entra ID tenant admins to request permissions be granted to an Agent ID.

### Application permissions for agent identity blueprints

You can't grant Microsoft Entra ID application permissions (app roles) to agent identity blueprint principals.

**Resolution**: Grant application permissions to individual agent identities instead.

### App role assignment to agent identity

You can't assign Microsoft Entra ID app roles where the target resource of the role assignment is an agent identity.

**Resolution**: Assign app roles using an agent identity blueprint principal as the target resource.

### Consents blocked by risk-based step-up

User consents that are blocked by risk-based step-up have no mention of "risky" in the UX.

**Resolution**: There's no workaround for this. Risk-based step-up is still enforced.

## Microsoft Entra ID administration

The following known issues and gaps relate to Microsoft Entra ID administration.

### Dynamic groups

You can't add agent identities and agent users to Microsoft Entra ID groups with dynamic membership.

**Resolution**: Add Agent IDs to security groups with fixed membership.

## Monitoring and logs

The following known issues and gaps relate to monitoring and logs.

### Audit logs

Audit logs don't distinguish Agent IDs from other identities:

- Operations on agent identities, agent identity blueprints, and agent identity blueprint principals are logged in the *ApplicationManagement* category.
- Operations on agent users are logged in the *User Management* category.
- Operations initiated by agent identities appear as service principals in audit logs.
- Operations initiated by agent users appear as users in audit logs.

**Resolution**: Use the following workarounds to identify Agent ID-related activities in audit logs:

- Use the object IDs provided in audit logs to query Microsoft Graph and determine the entity type.
- Use the Microsoft Entra sign-in logs correlation ID to locate the identity of the actor or subject involved in the auditable activity.

### Microsoft Graph activity logs

The Microsoft Graph activity logs don't distinguish Agent IDs from other identities:

- Requests from agent identities are logged as applications, with the agent identity included in the *appID* column.
- Requests from agent users are logged as users, with the `agentUser` ID in the *UserID* column.

**Resolution**: Join with the Microsoft Entra sign-in logs to determine the entity type.

## Performance and scale

The following known issues and gaps relate to performance and scale.

### Delays in multiple creation requests

When using the Microsoft Graph APIs to create Agent IDs, attempts to create multiple entities in quick sequence might fail with errors like `400 Bad Request: Object with id {id} not found`. Retrying the request might not succeed for several minutes. Examples include:

- Create agent identity blueprint, quickly create blueprint principal.
- Create agent identity blueprint, quickly add credential.
- Create agent identity blueprint principal, then use blueprint to create agent identity.
- Create agent identity, quickly create agent user.

These sequences of requests often fail when using MS Graph application permissions to authorize the requests.

**Resolution**: Use delegated permissions where possible. Add retry logic to your requests with exponential backoff and a reasonable timeout.

## Product integrations

The following known issues and gaps relate to product integrations.

### Copilot Studio agents

Agents built using Copilot Studio must opt in to Agent IDs in the agent's environment settings. Only custom engine agents are supported at this time. Custom engine agents currently use Agent IDs for authenticating to the channels where they're published. Agent IDs aren't currently used for authentication to connectors or tools in Copilot Studio.

## Libraries and SDKs

Agent ID scenarios introduce extra complexity when using MSAL due to the need to manage Federated Identity Credentials (FIC). For .NET developers, Microsoft recommends using [Microsoft.Identity.Web.AgentIdentities](https://github.com/AzureAD/microsoft-identity-web/blob/master/src/Microsoft.Identity.Web.AgentIdentities/README.AgentIdentities.md), which provides a streamlined experience for Agent IDs. For non-.NET implementations, use the [Microsoft Entra SDK for agent ID](/entra/msidweb/agent-id-sdk/overview), designed to simplify Agent ID integration across other languages. 

## Reporting new issues

If you encounter an unlisted issue, report an issue using [aka.ms/agentidfeedback](https://aka.ms/agentidfeedback).
