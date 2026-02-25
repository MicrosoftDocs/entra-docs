---
title: Grant Agents Access to Microsoft 365 Resources
description: Learn how to grant access to agents through consent, manual authorization, and other authorization systems for Microsoft 365 resources.
author: omondiatieno
ms.service: entra-id
ms.topic: how-to
ms.date: 11/04/2025
ms.author: jomondi
ms.reviewer: ergreenl

#Customer intent: As an IT administrator managing agent identities, I want to understand how to grant agents access to Microsoft 365 resources through various authorization methods, so that I can properly configure consent, manual authorization, and other authorization systems for agents in my organization.
---

# Grant agents access to Microsoft 365 resources

This article provides guidance on how to grant access to agents through consent, manual authorization, and other authorization systems. Learn about the different methods available for authorizing agents to access Microsoft 365 resources and when to use each approach.

## Prerequisites

- An agent identity blueprint and at least one agent identity created from it.
- An agent identity blueprint with a valid redirect URI.

## How to request consent (delegated or application permissions)

Users or administrators can grant agents access to data by consenting to API permissions during the OAuth flow. This section explains how to request consent for delegated and application permissions for your agents.

### When to use delegated or application permissions

The type of permissions you request depends on how your agent operates and what resources it needs to access.

Use delegated permissions when your interactive agent needs to act on behalf of a signed-in user. For example, read that user's mail, calendar, or files. Delegated access is carried in the token's scp claim.

Use application permissions when your autonomous agent runs without a user present and requires app-only access. For example, to read all users' profiles. App permissions appear in the token's roles claim.

For more information, see [permissions and consent overview](../../identity-platform/permissions-consent-overview.md)

### How consent works

For delegated permissions, when you redirect the user to the Microsoft identity platform `/authorize` endpoint, they review scopes such as `User.Read` and `Mail.Read`. If consent is granted, Microsoft Entra ID records an OAuth2PermissionGrant from your agent (client) to the resource such as Microsoft Graph. Future delegated tokens for that resource include the approved scopes in `scp` without reprompting unless consent changes. If your app requests consent for admin restricted permissions, your users get an error. An admin requests these permissions directly. For more information, see [admin-restricted permissions](/entra/identity-platform/scopes-oidc#admin-restricted-permissions).

### Building the consent URL

When building your consent URL, the client ID should be your agent identity's ID. 

For more information, see [requesting permissions through consent](#how-to-request-consent-delegated-or-application-permissions). Some permissions require consent from an administrator before they can be granted within a tenant. For more information, see [admin consent on the Microsoft identity platform](/entra/identity-platform/v2-admin-consent)

## How to manually grant authorization (delegated or application)

You can create the underlying authorization objects directly. It's useful for situations where you want to automate authorization or when you want to avoid interactive prompts.

- [Manually grant delegated permissions](/graph/api/oauth2permissiongrant-post). Set your client ID as the agent identity ID.
- [Manually grant application permissions (app role assignment)](/graph/api/serviceprincipal-post-approleassignments). Set your principal ID as the agent identity ID.

## How to manage access through access packages

Using access packages, you can enable standardized access for many AI Agents with the same access needs. The access package can include Entra roles, OAuth2 delegated and application permission grants and security group memberships. Agents can then request an access package, or a sponsor or admin can request for them, and once approved, the agent identity or agent user receives the access rights until the assignment is revoked or expires. For more information, see [access packages for agent identities](agent-access-packages.md).

## Other authorization systems

Agents can be authorized in several ways beyond app-role assignments, group memberships and OAuth2 permission grants. These alternative systems offer flexibility for assigning access tailored to different platforms, services, and security requirements. The following sections summarize some of the many methods for agent authorization.

### Azure role-based access control (Azure RBAC)

Assign Azure roles to the agent identity at the narrowest scope (resource, resource group, subscription). For example, you can grant the Key Vault Reader role on a single vault so the agent can read secrets without needing broad directory or tenant permissions. For more information and step-by-step guidance, see [Azure RBAC documentation](/azure/role-based-access-control/built-in-roles).

### Microsoft Entra roles

Some low-privilege directory roles might be assignable to agents for metadata or read scenarios. High-privilege roles are blocked for agents by platform policy. To learn more about Microsoft Entra roles and PIM, see [Microsoft Entra roles](/entra/identity/role-based-access-control/permissions-reference).

### Exchange RBAC

Exchange RBAC (Role-Based Access Control) lets administrators delegate permissions to Exchange resources. It ensures agents can get granular authorization, such as autonomous access to one mailbox or a few mailboxes. For information, see [Role Based Access Control for Applications in Exchange Online](/exchange/permissions-exo/application-rbac)

### Teams Resource-Specific Consent (RSC)

Teams Resource-Specific Consent (RSC) enables granular permission assignments for agents within Microsoft Teams. RSC allows you to grant permissions to an app or agent on a per-team basis, rather than at the tenant level. This approach is especially useful when you want to limit access to only the resources and data within specific teams. Such data includes channels, messages, or roster information, without granting broader organizational permissions. For more information, see [Resource-specific consent for your Teams app](/microsoftteams/platform/graph-api/rsc/resource-specific-consent).

### Custom (third‑party) APIs

Agents can call other OAuth‑protected APIs. Ensure the resource application and its service principal exist in the tenant, define required scopes/app roles, and follow the same delegated or app‑permission flows. For more information, see Microsoft's guide to permissions and consent in the Microsoft identity platform.

## Related content

- [Permissions and consent in the Microsoft identity platform](~/identity-platform/permissions-consent-overview.md)
- [Microsoft Entra built-in roles](~/identity/role-based-access-control/permissions-reference.md)
