---
title: Token claims reference for agent IDs
description: Learn about specialized token claims used by agent applications in Microsoft Entra to identify entity types, relationships, and roles during authentication and authorization flows.
titleSuffix: Microsoft Entra Agent ID
author: SHERMANOUKO
ms.author: shermanouko
ms.service: entra-id
ms.topic: reference
ms.date: 11/04/2025
ms.custom: agent-id-ignite
ms.reviewer: jmprieur

#customer-intent: As a developer or security engineer, I want to understand the token claims structure for Agent Identity tokens, so that I can properly validate and authorize agent applications in my resource servers and implement secure authentication flows.
---

# Token claims reference for agents

Agents use specialized token claims to identify different entity types and their relationships during authentication and authorization flows. These claims enable proper attribution, policy evaluation, and audit trails for agent operations. This article outlines the token claims for agent applications, detailing how tokens identify agent entities and their roles in authentication flows.

Clients using agent identities are expected to treat the access tokens issued to them to use at resource servers as opaque, and not try to parse them. However, resource servers that receive access tokens issued to agents need to parse the tokens to validate them and extract claims for authorization purposes.

## Core token claim types

Tokens issued for identities used for resource access include claims that you'd normally expect to see in access tokens that Microsoft Entra issues. For more information, see [access token claim reference](/entra/identity-platform/access-token-claims-reference). The following example shows a sample access token issued to an agent acting autonomously. 

```json
{
  "aud": "f2510d34-8dca-4ab8-a0bc-aaec4d3a3e36",
  "iss": "https://sts.windows.net/00000001-0000-0ff1-ce00-000000000000/",
  "iat": 1753392285,
  "nbf": 1753392285,
  "exp": 1753421385,
  "aio": "Y2JgYGhn1nzmErKqi0vc4Fr6H22/C5/4FP+xZbZYpik8nRkp+gEA",
  "appid": "aaaaaaaa-1111-2222-3333-444444444444",
  "appidacr": "2",
  "idp": "https://sts.windows.net/00000001-0000-0ff1-ce00-000000000000/",
  "idtyp": "app",
  "oid": "bbbbbbbb-1111-2222-3333-444444444444",
  "rh": "1.AAAAAQAAAAAA8Q_OAAAAAAAAADQNUfLKjbhKoLyq7E06PjYAAAAAAA.",
  "sub": "cccccccc-1111-2222-3333-444444444444",
  "tid": "00000001-0000-0ff1-ce00-000000000000",
  "uti": "m5RaaRnoFUyp2TbSCAAAAA",
  "ver": "1.0",
  "xms_act_fct": "3 9 11",
  "xms_ftd": "Z5DrW4HFOkR_Lz0M5qETa260d2-fO6seMZJ_tOwRNuc",
  "xms_idrel": "7 10",
  "xms_sub_fct": "9 3 11",
  "xms_tnt_fct": "3 9",
  "xms_par_app_azp": "30cf4c22-9985-4ef7-8756-91cc888176bd"
}
```

In v2 tokens, you see `azp` instead of `appid`. They both refer to the application ID of the agent identity.

You'd notice that the token includes a few claims that aren't previously seen in access tokens issued to applications. The following optional claims are also supported to identify that the tokens are for agent identities. They also provide more context in which the agent identity is acting. 

- `xms_tnt_fct`
- `xms_sub_fct`
- `xms_act_fct`
- `xms_par_app_azp`

| Claim Name        | Description                                                                           |
| ----------------- | ------------------------------------------------------------------------------------- |
| `tid`             | Tenant ID of the customer tenant where the agent identity is registered. It's the tenant where the token is valid.            |
| `sub`             | Subject (the user, service principal, or agent identity being authenticated)         |
| `oid`             | Object ID of the subject. User object ID for user delegation scenarios. Agent ID service principal OID for app-only scenarios. Agent user OID for user impersonation scenarios.          |
| `idtyp`           | Type of entity the subject is. Values are `user`, `app`.                               |
| `tid`             | Tenant ID of the customer tenant where the agent identity is registered.              |
| `xms_idrel`       | Relationship between the subject and the resource tenant. Learn [more](#xms_idrel).   |
| `aud`             | Audience (the API that the agent is trying to access)                                 |
| `azp` or `appid`  | Authorized party / actor. The application ID of the agent identity. Enables proper client attribution in audit logs.     |
| `scp`             | Scope. Delegated permissions for user-context tokens. Only present in user delegation and agent user scenarios. Empty or `/` for app-only scenarios                                            |
| `xms_act_fct`     | Actor facets claim. Learn [more](#xms_tnt_fct-xms_sub_fct-and-xms_act_fct-claims).    |
| `xms_sub_fct`     | Subject facets claim. Learn [more](#xms_tnt_fct-xms_sub_fct-and-xms_act_fct-claims) . |
| `xms_tnt_fct`     | Tenant facets claim. Learn [more](#xms_tnt_fct-xms_sub_fct-and-xms_act_fct-claims) .  |
| `xms_par_app_azp` | Parent application of the authorized party. Learn [more](#xms_par_app_azp) .          |

## xms_idrel

The `xms_idrel` claim indicates the identity relationship between the entity for which the token is issued and the resource tenant.

Here are the possible values for the `xms_idrel` claim. It's a multivalued claim, meaning it can have multiple values, separated by spaces. The values are represented as integers. The valid values are always odd numbers starting from 1.

| Claim Value | Description                                         |
| ----------- | --------------------------------------------------- |
| `1`         | Member user                                         |
| `3`         | MSA member user                                     |
| `5`         | Guest user                                          |
| `7`         | Service principal                                   |
| `9`         | Device principal                                    |
| `11`        | GDAP user                                           |
| `13`        | SPLess application                                  |
| `15`        | Passthrough                                         |
| `17`        | Native identity user with profile                   |
| `19`        | Native identity user                                |
| `21`        | Native identity Teams meeting participant           |
| `23`        | Passthrough authenticated Teams meeting participant |
| `25`        | Native identity content sharing user                |
| `27`        | Fully synced MTO member                             |
| `29`        | Weak MTO user                                       |
| `31`        | DAP user                                            |
| `33`        | Federated managed identity                          |

## xms_tnt_fct, xms_sub_fct, and xms_act_fct claims

The `xms_tnt_fct` claim describes the tenant (identified by the `tid` claim). The `xms_sub_fct` and `xms_act_fct` claims are used to describe facts about the subject (`sub`) and the actor (`azp` or `appid`) of the token, respectively. These claims provide more context about the agent's identity and the actions it's performing.

Here are the relevant values for these claims. These claims are multivalued, meaning they can have multiple values, separated by spaces. The valid values are always odd numbers starting from 1.

| Claim Value | Description                             |
| ----------- | --------------------------------------- |
| `11`        | AgentIdentity                           |
| `13`        | AgentIDUser                             |

You should ignore any values that aren't relevant to your scenario or validation logic. Ignore the values that aren't relevant to your application. Don't assume any order of the values in these claims.

## xms_par_app_azp

The `xms_par_app_azp` claim is used to identify the parent application of the authorized party (`azp` or `appid`). It's a GUID, when included. You can use the claim to determine the parent

Log the parent application ID for auditing purposes. Microsoft Entra ID sign-in logs always includes the parent ID if available, so resource server should do the same. It isn't recommended to use the parent application ID for authorization decisions, as it would result in widespread access by many agents.

## Scenario-wise examples

The following section outlines some auth scenarios and the relevant claims for each one of them.

### Agent identity acting on behalf of a human user

In this scenario, the agent identity is acting on behalf of a human user. The access token includes the following claims:

| Claim Name  | Description                                             |
| ----------- | ------------------------------------------------------- |
| `tid `       | Tenant ID of the customer tenant                       |
| `idtyp `     | `user` (indicating the subject is a user)              |
| `xms_idrel`  | `1` (indicating a member user; others possible too)    |
| `azp` / `appid` | Application ID of the agent identity                |
| `scp`         | Delegated permissions granted to the agent identity   |
| `oid`         | Object ID of the user                                 |
| `aud`        | Resource audience for the token                        |
| `xms_act_fct` | `11` (AgentIdentity)                                  |

### Agent identity acting autonomously

In this scenario, the agent identity acts using its own identity. The access token includes the following claims:

| Claim Name  | Description                                             |
| ----------- | ------------------------------------------------------- |
| `tid`         | Tenant ID of the customer tenant                        |
| `idtyp`       | `app` (indicating the subject is an application)        |
| `xms_idrel`   | `7` (indicating a service principal)                    |
| `azp` / `appid` | Application ID of the agent identity       |
| `roles`       | Permissions granted to the agent identity          |
| `oid`         | Object ID of the agent identity |
| `xms_act_fct` | `11` (AgentIdentity)                               |
| `xms_sub_fct` | `11` (AgentIdentity)                               |
| `aud`         | Resource audience for the token                          |
| `scp`         | Empty or `/` (unscoped).                          |

### Agent identity acts autonomously via agent user

In this scenario, the agent obtains a token using the agent user associated with its agent identity. The access token includes the following claims:

| Claim Name  | Description                                         |
| ------------- | --------------------------------------------------- |
| `tid`         | Tenant ID of the customer tenant                    |
| `idtyp`       | `user` (indicating the subject is a user)           |
| `xms_idrel`   | `1` (indicating a member user; others possible too) |
| `azp` / `appid` | Application ID of the agent identity   |
| `scp`         | Delegated permissions granted to the agent identity      |
| `oid`         | Object ID of the agent user                       |
| `xms_act_fct` | `11` (Agent identity)                           |
| `xms_sub_fct` | `13` (Agent user)                                  |
| `aud`         | Resource audience for the token                      |
