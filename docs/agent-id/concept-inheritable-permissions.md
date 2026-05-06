---
title: Inheritable Permissions and Required Resource Access in Microsoft Entra Agent ID
description: Understand the difference between required resource access declarations and inheritable permissions for agent identity blueprints in Microsoft Entra Agent ID.
author: shlipsey3
ms.author: sarahlipsey
ms.reviewer: sarahlipsey
ms.service: entra-agent-id
ms.topic: concept-article
ms.custom: msecd-doc-authoring-1012
ms.date: 04/30/2026
ai-usage: ai-assisted

#customer intent: As a developer or IT administrator, I want to understand the difference between required resource access and inheritable permissions so that I can configure agent identity blueprints to balance security with ease of deployment.

---

# Inheritable permissions and required resource access in Microsoft Entra Agent ID

When you build an agent identity blueprint, there are two key permission-related configurations: *required resource access* and *inheritable permissions*. These configurations work together to define what an agent needs, what administrators review during consent, and how permissions flow to agent identities.

Understanding the relationship between these configurations and how they affect authorization is essential for both developers designing agent blueprints and administrators onboarding agents into their organizations.

## Required resource access

Required resource access is the agent identity blueprint's initial declaration of the APIs and permissions that the blueprint's child agent identities need to operate. It's expressed as a set of target resource applications and the specific delegated scopes and application roles the agent requests.

Required resource access serves as the agent's list of static consent permissions. When a tenant administrator reviews the agent for approval, this list makes the consent decision explicit and reviewable. It answers the question: *"What does this agent need to function?"*

Dynamic consent can still grant permissions that are inherited when the permission is explicitly requested and the resource app is configured as inheritable. However, dynamically requested permissions aren't visible up front unless they're also declared in required resource access.

Key characteristics of required resource access:

- Declares the baseline set of permissions the agent needs for its initial experience.
- Is visible to tenant administrators during the consent and onboarding process.
- Is a declaration, not a permission grant. Authorization requires administrator consent.

## Inheritable permissions

Inheritable permissions is a list of resource apps configured on an agent identity blueprint that defines which permissions can be automatically inherited by agent identities created from that blueprint. When an administrator grants permissions to the agent identity blueprint principal and those permissions are from resource apps listed as inheritable, all present and future agent identities created from that blueprint in the organization automatically receive those permissions with their tokens.

Inheritable permissions address a common deployment challenge: when you have multiple instances of the same agent across environments or business units, you don't want administrators to re-consent for the same permissions on every agent identity. Inheritable permissions let the administrator approve once at the blueprint level and have that approval apply automatically.

### Two conditions for inheritance

For a permission to be inherited by an agent identity, *both* of the following conditions must be met:

- The **resource scopes, roles, or both must be listed** in the inheritable permissions configuration on the agent identity blueprint.
- The **permission must be granted** with:
    -  static consent using *required resource access*, or
    -  dynamic consent with the permissions explicitly declared on the consent request.

If either condition is missing, inheritance doesn't occur.

### What inheritable permissions include

Inheritable permissions support both:

- **Delegated scopes**: Appear in the agent's delegated application permission access token `scp` claim.
- **Application roles**: Appear in the agent's application permission token `roles` claim.

### Inheritance patterns

The following patterns are supported per resource app:

| Pattern | Description |
|---|---|
| **All allowed** | Inherit all available delegated scopes or application roles for the specified resource app. Newly granted scopes or roles on the blueprint principal are automatically included. |
| **None** | Inherit no scopes or roles for the specified resource app. Use this pattern to explicitly disable inheritance for scopes or roles independently. |

You can configure scopes and roles independently on the same resource app. For example, you can inherit all scopes while inheriting no roles, or vice versa.

## Declaration, grant, and inheritance

Required resource access and inheritable permissions are *configurations*: they don't grant any authorization by themselves. It's important to understand the distinction between what's declared, what's granted, and what's inherited.

| Layer | What it is | Who controls it | Effect |
|---|---|---|---|
| **Required resource access** | The list of APIs and permissions the agent needs to function | Developer (on the blueprint) | Visible to admins during consent review. Doesn't grant access. |
| **Inheritable permissions** | The list of resource apps eligible for inheritance | Developer (on the blueprint) | Defines which resource apps can have permissions flow to agent identities. Doesn't grant access. |
| **Consent on blueprint principal** | Permissions granted by an admin to the blueprint principal in a tenant | Tenant administrator | Grants authorization. If the resource app is also listed as inheritable, the permission flows to all agent identities. |
| **User or agent consent on agent identity** | Permissions granted directly to a specific agent identity | Tenant administrator | Grants authorization for that specific agent identity only. |
| **Effective permissions in token** | The merged set of inherited + directly granted permissions | Platform (at token issuance) | What the agent identity can actually do at runtime. |

> [!NOTE]
> Inherited permissions aren't visible as permissions on agent identities in the Microsoft Entra admin center or through Microsoft Graph. They're only observable in the token contents at runtime. The platform merges inherited and directly granted permissions during token issuance.

## Permission configuration cheat sheet

Use these quick rules:

- Static consent at the blueprint level depends on the permission being in required resource access.
- Dynamic consent at the blueprint level can work even when the permission isn't in required resource access, but the permission must be explicitly requested.
- Inheritance to agent identities depends on whether the resource app is configured as inheritable.
- Up-front visibility depends on whether the permission is in required resource access.

### Static consent (blueprint principal)

| Permission in required resource access? | Resource app is inheritable? | Inherited by agent identities? | Visible to admins up front? |
|---|---|---|---|
| Yes | Yes | Yes | Yes |
| Yes | No | No | Yes |
| No | Yes | No | No |
| No | No | No | No |

### Dynamic consent (blueprint principal, permission explicitly requested)

| Permission in required resource access? | Resource app is inheritable? | Inherited by agent identities? | Visible to admins up front? |
|---|---|---|---|
| Yes | Yes | Yes | Yes |
| Yes | No | No | Yes |
| No | Yes | Yes | No |
| No | No | No | No |

Direct consent on an agent identity remains available in all cases, but those grants apply only to that specific agent identity.

## Best practices

When you configure required resource access and inheritable permissions for agent blueprints, balance security, usability, and future scalability.

- **Minimize up-front permissions.** Only include resource access that's essential for the agent's core functionality in the required resource access. Requesting unnecessary permissions at installation increases friction and reduces trust with tenant administrators.

- **Predeclare potential future permissions.** Specify resource apps that might be needed for future agent features in the inheritable permissions list. This transparency enables admins to anticipate future consent requests and facilitates smoother deployments across environments.

- **Use inheritable permissions for reusability.** Use inheritable permissions to let admins grant consent once at the blueprint level and have that approval automatically apply to all agent identities, including across multiple deployments and environments. If you're going to require a permission, it's good practice to also make its resource app inheritable so administrators don't have to grant it on each agent identity individually.

- **Keep governance simple and predictable.** Explicitly defining which permissions are required and which might be requested later helps organizations maintain clear access control and avoid unexpected permission escalations.

- **Review security implications.** Ensure that inheritable permissions don't grant excessive access or expose sensitive resources beyond what's necessary. Regularly audit permission lists to maintain compliance and minimize risk.

<!-- TODO: Confirm with engineering whether the enumerated scopes pattern (mentioned in manage-agent-identities-admin.md) is still a supported inheritance pattern or has been removed in favor of allAllowed/none only. -->

## Example scenarios

The following scenarios illustrate how different permission configurations serve different deployment needs.

### Scenario 1: Agent has optional features that require permissions later

Priya is building an IT help desk agent that answers questions from a knowledge base. Priya expects customers to later enable optional actions like creating incidents or posting to Teams. Priya leaves required resource access empty or minimal. She defines the resource apps her agent uses in the inheritable permissions list. When her company enables an action feature, the admin grants the needed permission once on the blueprint principal, and that approval is reused for all deployments.

### Scenario 2: Agent requires permissions up front that should be inheritable

Mateo is building a new hire onboarding agent that needs Microsoft Graph access to read user profiles and create tasks. Mateo lists the baseline Graph permissions in required resource access and also adds the Graph resource app to the inheritable permissions list. When his company rolls the agent out to multiple business units, the admin review is consistent: the same permissions are requested every time, and the inheritable designation reduces repeated approval effort.

### Scenario 3: Agent requires permissions that should not be inheritable

Lin is building privileged operations agent used by a small team of admins to perform sensitive tasks. The agent needs high-privilege permissions immediately. Lin includes these in required resource access but intentionally doesn't add them to the inheritable permissions list. For her company, each installation requires a fresh, explicit admin decision, reducing permission sprawl for highly privileged access.

### Scenario 4: Agent requires different permissions in different organizations

Aisha is building a compliance evidence collector agent. Some tenants need it to pull from Microsoft 365 audit sources; others need it to pull from SharePoint sites. Aisha defines a small core set in required resource access and lists the full menu of possible resources in the inheritable permissions list. Each organization grants only the permissions that match their architecture, and the inheritable approach reduces repeated approvals during rollout.

## Related content

- [Configure inheritable permissions for agent identity blueprints](configure-inheritable-permissions-blueprints.md)
- [Agent identity blueprints in Microsoft Entra Agent ID](agent-blueprint.md)
- [Authorization in Microsoft Entra Agent ID](authorization-agent-id.md)
- [Agent ID design patterns](concept-agent-id-design-patterns.md)
- [Best practices for Microsoft Entra Agent ID](best-practices-agent-id.md)