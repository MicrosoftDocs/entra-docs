---
title: How Microsoft Entra resource policy evaluation works (preview)
description: Understand request matching, Rego evaluation, enforcement modes, multiple assignments, and propagation of resource policy changes.
ms.topic: concept-article
ms.date: 11/11/2026
ai-usage: ai-generated
# Customer intent: As a tenant administrator, I want to understand policy evaluation so that I can interpret results and safely enable enforcement.
---

# How Microsoft Entra resource policy evaluation works (preview)

Microsoft Entra resource policy evaluates matching Microsoft Graph requests before the requested resource operation proceeds. Evaluation combines assignment settings with the assigned policy's applicability and compliance rules.

## Request-time evaluation

Evaluation has three stages.

1. **Match assignments.** The service finds enabled assignments whose scope, target resource or action, and operations match the incoming request. If none match, resource policy doesn't evaluate Rego for the request.
1. **Check applicability.** If the assigned policy has an `applicable` rule, the service evaluates it. A false result excludes the request from that policy's compliance evaluation.
1. **Evaluate compliance.** The service evaluates each applicable policy's `deny` rule. A true result identifies noncompliance; a false result identifies compliance.

The service combines the results with assignment enforcement modes to determine whether resource policy blocks the request.

## Multiple policies and enforcement modes

An assignment's `enforcementMode` doesn't change the policy's compliance result. It changes how the service applies that result.

| Results | Request-time behavior |
| --- | --- |
| At least one applicable policy returns a noncompliant result through an `enforce` assignment. | Resource policy blocks the request. |
| Noncompliant results occur only through `doNotEnforce` assignments. | Those assignments don't block the request, and evaluation results are recorded. |
| All applicable policies evaluate successfully and are compliant. | Resource policy doesn't block the request. |

An excluded or compliant result from one policy doesn't override a different enforced policy's noncompliant result.

> [!NOTE]
> Passing policy evaluation doesn't guarantee that the underlying operation succeeds. Microsoft Graph permissions, resource validation, and other service controls still apply.

## Disabled assignments and exceptions

A disabled assignment doesn't evaluate requests. An enabled assignment in `doNotEnforce` mode evaluates without enforcing its result.

An exception expressed in a policy's applicability logic affects only that policy. It doesn't grant Microsoft Graph permissions or bypass other assignments.

## Simulated evaluation

Use evaluation actions to test policy behavior without performing the simulated resource operation.

| Action | What it evaluates |
| --- | --- |
| `evaluatePolicy` | Rego supplied directly in the evaluation request, with any supplied parameter values. |
| `evaluateAssignedPolicies` | Assigned policies that match the simulated request. |

Inspect policy results and errors even when the evaluation returns HTTP success. Success alone doesn't prove compliance.

Both actions return `appliedPoliciesEffects` and `isBlocked`. A noncompliant result can have `appliedPoliciesEffects: "deny"` and `isBlocked: false` when it isn't enforced. For `evaluatePolicy`, supply `enforcementMode` to test the intended behavior; its default is `doNotEnforce`. For `evaluateAssignedPolicies`, the assignments supply their enforcement modes.

Request detailed results with `isResultDetailed: true` to inspect policy-provided violation reasons separately from evaluation errors.

For testing guidance, see [Test and troubleshoot a resource policy](resource-policy-test-troubleshoot.md).

## Assignment propagation

Assignment creation, updates, and deletion can take up to 10 minutes to affect incoming requests. The evaluation actions and policy management APIs reflect saved assignment changes without that propagation delay.

Account for propagation when testing enablement, enforcement-mode changes, version changes, or rollback. An immediate management response doesn't prove that every incoming request uses the updated assignment.

## Errors and diagnostics

Distinguish a noncompliant policy result from a loading or evaluation failure. Failures can arise from invalid Rego, unexpected input, unavailable policy versions, or unsuccessful additional reads.

Review per-policy results and available error details. Don't assume that an evaluation error is equivalent to a deny result.

| Condition | Request-time behavior |
| --- | --- |
| An applicable policy's `deny` evaluation fails or returns an undefined result. | An `enforce` assignment blocks the request. A `doNotEnforce` assignment records the error without blocking through that assignment. |
| An optional `applicable` rule fails or returns an invalid result. | That policy doesn't proceed to `deny` evaluation. Other matching policies can still block the request. |
| The request payload exceeds the policy evaluation input-size limit. | Policy evaluation is skipped. A matching enforced deny assignment blocks the request; assignments in `doNotEnforce` don't block through this size check. |
| An unexpected service error prevents policy evaluation from completing. | The request can continue without completed policy evaluation. A successful write isn't proof that all policies evaluated successfully. |

For additional reads, the policy must inspect the `fetchAsPolicy()` response code. A failed read isn't automatically a noncompliant result; the policy's handling of that response determines whether it returns a result or encounters an evaluation error.

Use [evaluation audit logs](resource-policy-logs.md) to investigate real requests. Inspect the assignment and version in each event: a request's overall decision can differ from an individual assignment's result. These logs don't assess preexisting resource configuration.

## Related content

- [Resource policy concepts](resource-policy-concepts.md).
- [Author resource policies with Rego](resource-policy-rego.md).
- [Test and troubleshoot a resource policy](resource-policy-test-troubleshoot.md).
- [Safely deploy resource policy assignments](resource-policy-safe-deployment.md).
