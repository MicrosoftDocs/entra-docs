---
title: Microsoft Entra resource policy concepts (preview)
description: Understand policy definitions, versions, assignments, parameters, enforcement modes, and permissions in Microsoft Entra resource policy.
ms.topic: concept-article
ms.date: 11/11/2026
ai-usage: ai-generated
# Customer intent: As a tenant administrator, I want to understand the resource policy object model so that I can manage policies and assignments safely.
---

# Microsoft Entra resource policy concepts (preview)

Microsoft Entra resource policy separates the logic that identifies noncompliant requests from the assignment that controls where and how that logic applies. This article explains the shared concepts used across the Microsoft Entra admin center and Microsoft Graph.

## Policy definitions

A policy definition describes a configuration requirement and the requests to which it applies.

- A **built-in policy** provides Microsoft-managed, read-only logic that you can assign without authoring Rego. Use the `builtInDefinitions` collection to discover available definitions and versions.
- A **custom policy** contains Rego that you author and manage.

A custom definition has a `uniqueName` that identifies it across versions. Its Rego package uses `graph.<uniqueName>["X.Y.Z"]` to identify the name and version. Metadata describes the policy, and `__metadata__.selector` identifies its target resource type or action and operations.

Creating a definition doesn't enforce it. Create and enable an assignment to evaluate matching requests.

## Policy versions

Custom policy definitions start at `1.0.0` and use semantic versions in the `X.Y.Z` format. Updating the policy source publishes a higher version, and the former current version becomes an immutable previous version. A parameter schema change requires a major version increase.

Each assignment references a specific definition and version, including assignments of built-in policies. Select an exact available version; publishing a newer version doesn't automatically update existing assignments.

Keep policy code and its change history in source control. Service-maintained version history isn't a substitute for a source repository.

For update, rollback, and retirement procedures, see [Update and retire resource policies](resource-policy-lifecycle.md).

## Policy assignments

A policy assignment connects a policy to a scope and provides its runtime settings. The assignment's `assignedPolicy` reference identifies a custom or built-in definition by `policyUniqueName` and a specific `version`.

Each definition version can have one live assignment per tenant. A live assignment is one that hasn't been soft-deleted; disabled assignments count too. Update the existing assignment to change its parameters or enforcement settings.

| Setting | Purpose |
| --- | --- |
| `uniqueName` | Identifies the assignment. The name can't be changed after creation. |
| `scope` | Identifies the assignment scope. Tenant-wide scope is represented by `/`. |
| `isEnabled` | Controls whether the assignment participates in evaluation. |
| `enforcementMode` | Controls whether a noncompliant result blocks the request. |
| `params` | Supplies typed values for the policy's parameters. |

For custom definition and assignment names, choose a `uniqueName` that starts with an ASCII letter, contains only ASCII letters, digits, or underscores, and has at most 128 characters. The prefixes `microsoft` and `ms`, including `msft`, are reserved regardless of case. The exact custom definition names `utils` and `input` are also reserved regardless of case. For example, use `contosoApplicationNaming` rather than a Microsoft-reserved prefix.

Multiple assignments can match a request. Review all applicable assignments when investigating a blocked operation.

## Enforcement modes and enablement

Enablement and enforcement mode control different behavior.

| Assignment state | Behavior |
| --- | --- |
| Disabled | The assignment doesn't participate in policy evaluation. |
| Enabled with `doNotEnforce` | The policy evaluates matching requests and records results without blocking them through this assignment. |
| Enabled with `enforce` | A noncompliant result from this assignment can block the request. |

Use `doNotEnforce` to assess impact before enforcing a policy. It isn't an exception to a different enforced assignment.

## Parameters

Parameters let you reuse policy logic with different values, such as a required naming prefix.

Custom definitions declare parameter types and defaults in `__metadata__.paramsSchema`; assignments supply values in `params`. For validation rules, Rego references, and examples, see [Resource policy parameters](resource-policy-parameters.md).

## Applicability and exceptions

The required `__metadata__.selector` identifies matching resource types or actions and operations. An optional `applicable` rule can further narrow which requests a custom policy evaluates. For selector syntax and derived-type behavior, see [Applicability metadata](resource-policy-rego.md#applicability-metadata).

Use parameters and applicability logic to express narrowly defined exceptions when the policy supports them. An exception excludes a request from that policy; it doesn't grant permission to perform the operation or bypass other policies.

Review exception ownership, scope, and continued need as part of [safe deployment](resource-policy-safe-deployment.md).

## Roles and API permissions

Microsoft Entra roles and Microsoft Graph API permissions serve different purposes. In a delegated API workflow, the client needs the required delegated permissions, and the signed-in user needs the role required for the operation. Application-only workflows use application permissions.

| Role | Intended tasks |
| --- | --- |
| Resource Policy Administrator | Manage definitions and assignments, and evaluate policies. |
| Resource Policy Reader | Read definitions and assignments, and inspect policy behavior. |
| Resource Policy Evaluator | Evaluate policy logic without policy management permissions. |
| Reports Reader | Read [evaluation audit events](resource-policy-logs.md). |

The following Microsoft Graph API permissions cover resource policy tasks and are available as delegated and application permissions:

| API permission | Intended tasks |
| --- | --- |
| `ResourcePolicyDefinition.Read.All` | Read built-in and custom definitions, versions, and deleted custom definitions. |
| `ResourcePolicyDefinition.ReadWrite.All` | Read and manage custom definitions and versions, including restoring or permanently deleting definitions. |
| `ResourcePolicyAssignment.Read.All` | Read assignments, including deleted assignments. |
| `ResourcePolicyAssignment.ReadWrite.All` | Read and manage assignments, including restore and permanent deletion. |
| `ResourcePolicyEvaluation.Read.All` | Test inline or assigned policies with `evaluatePolicy` and `evaluateAssignedPolicies`. |
| `ResourcePolicyConfiguration.Read.All` | Read tenant configuration and retrieve the federated identity credential subject. |
| `ResourcePolicyConfiguration.ReadWrite.All` | Read and update tenant configuration, including the privileged-read application. |
| `AuditLog.Read.All` | Read [evaluation audit events](resource-policy-logs.md). |

Use standard role assignment and consent experiences. Choose the least-privileged role and API permissions for each task. Policy management access doesn't grant access to the resources used in a test operation.

Real additional reads through `fetchAsPolicy()` use a [configured privileged-read application](resource-policy-privileged-read-app.md). Running those reads through `evaluatePolicy` also requires `ResourcePolicyDefinition.ReadWrite.All` and, for delegated access, a role that can manage definitions.

## Delete and restore

Deleting a custom definition or assignment follows a soft-delete lifecycle. Restore dependencies in order: restore the definition before an assignment that references it.

Deleting an individual previous definition version is different: that operation is permanent. For retention, dependency checks, and irreversible operations, see [Update and retire resource policies](resource-policy-lifecycle.md).

## Related content

- [What is Microsoft Entra resource policy?](resource-policy-overview.md).
- [How resource policy evaluation works](resource-policy-evaluation.md).
- [Author resource policies with Rego](resource-policy-rego.md).
- [Safely deploy resource policy assignments](resource-policy-safe-deployment.md).
