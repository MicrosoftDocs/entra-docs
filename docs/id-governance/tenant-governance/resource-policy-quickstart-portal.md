---
title: "Quickstart: Assign and test a built-in Microsoft Entra resource policy (preview)"
description: Assign a built-in resource policy in report-only mode and compare simulated compliant and noncompliant requests without creating applications.
ms.topic: quickstart
ms.date: 11/11/2026
ai-usage: ai-generated
# Customer intent: As a tenant administrator, I want to assign and test a built-in policy so that I can understand its decisions without writing Rego or creating applications.
---

# Quickstart: Assign and test a built-in Microsoft Entra resource policy (preview)

Use the [Microsoft Entra admin center](https://entra.microsoft.com/) to assign a built-in resource policy in report-only mode and [Microsoft Graph Explorer](https://developer.microsoft.com/graph/graph-explorer) to test its decisions with simulated requests. You don't need to write a policy, create applications, or enable enforcement.

## Prerequisites

- An approved test environment.
- A Microsoft Entra ID Governance service plan to create and activate the assignment, including report-only assignments. See [licensing requirements](licensing.md#resource-policy-preview).
- One work or school account in the test tenant. Use this same account and tenant in the Microsoft Entra admin center and Microsoft Graph Explorer throughout the quickstart, including cleanup.

### Microsoft Entra roles for your account

Use an active [Resource Policy Administrator](resource-policy-concepts.md#roles-and-api-permissions) role to create and delete the assignment and evaluate assigned policies.

If the role is eligible through Privileged Identity Management (PIM), activate it before starting.

### Delegated permissions for Microsoft Graph Explorer

Before starting, have an administrator grant consent in the test tenant for Microsoft Graph Explorer's **delegated** `ResourcePolicyEvaluation.Read.All` permission. This permission lets you run `evaluateAssignedPolicies` without performing the proposed write.

Assignment creation and cleanup use the Microsoft Entra admin center, so you don't need to grant Graph Explorer assignment-management permissions.

## 1. Select a built-in policy and assign it in your tenant

Use the **Require a department prefix for application names** built-in policy. This policy requires application names to use an allowed department prefix and contain no banned words.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) with the test-tenant account described in [Prerequisites](#prerequisites).
1. Browse to **Tenant governance** > **Definitions**.
1. On the **Built in** tab, find the **Require a department prefix for application names** policy definition and review the description.
1. Select **Add assignment** on the chosen policy definition.
1. On **Settings**, use assignment identifier `enforce_application_name_prefix` and policy version `1.0.0`. Set **Status** to **On** and **Enforcement** to **Report-only**. Leave other properties at their defaults.
1. On **Parameters**, select **Edit allowed_departments** and enter the following case-sensitive prefixes, one value per row:

    - `Engineering-`
    - `Marketing-`
    - `IT-`
    - `HR-`
    - `Finance-`
    - `Sales-`

    Use **Add row** for the additional `Sales-` value, then select **Apply**. Leave `banned_word_list` and `client_appid_exclusion_list` empty.
1. On **Review**, review the summary and add the assignment.

**On** enables evaluation; **Report-only** records results without blocking requests through this assignment.

## 2. Validate without performing a write

Use `evaluateAssignedPolicies` in Graph Explorer to compare names with and without an allowed prefix, without creating applications. The action evaluates all applicable assignments, so find `enforce_application_name_prefix` in `details` to identify this quickstart's results.

The evaluation action reflects saved assignment settings without waiting for [changes to propagate to real requests](resource-policy-evaluation.md#assignment-propagation).

Sign in to [Microsoft Graph Explorer](https://developer.microsoft.com/graph/graph-explorer) with the same account and tenant you used in the Microsoft Entra admin center. Confirm that Graph Explorer has the delegated permissions listed in [Prerequisites](#prerequisites).

### Check a noncompliant application name

Use `Inventory-Taker`, which doesn't start with any of the configured department prefixes.

1. In [Microsoft Graph Explorer](https://developer.microsoft.com/graph/graph-explorer), select **POST** and **beta**.
1. Enter the following request URL:

    ```http
    https://graph.microsoft.com/beta/admin/resourcePolicy/evaluateAssignedPolicies
    ```

1. Select **Request Body** and enter the following JSON:

    ```json
    {
      "resourceUri": "/beta/applications",
      "httpMethod": "post",
      "resourceBody": {
        "displayName": "Inventory-Taker"
      },
      "scope": "/",
      "isResultDetailed": true
    }
    ```

1. Select **Run query**.
1. In **Response preview**, inspect the evaluation result. Select **Expand** if you need more space.

With this report-only assignment, expect **200 OK** and the following fields:

| Field | Value |
| --- | --- |
| `appliedPoliciesEffects` | `deny` |
| `isBlocked` | `false` |
| `details[].assignmentUniqueName` | `enforce_application_name_prefix` |
| `details[].assignedPolicyDisplayName` | Require a department prefix for application names |
| `details[].appliedPolicyEffects` | `deny` |

The matching entry in `details` includes this reason:

> The application name needs an allowed department prefix. Add a prefix from allowed_departments, then try again.

**200 OK** means the evaluation completed, not that the name is compliant. The `deny` effect identifies the violation; `isBlocked: false` reflects report-only mode. Other applicable assignments can affect the overall result.

### Check a compliant application name

Use `Sales-Inventory-Taker`, which starts with the configured `Sales-` prefix.

1. Keep **POST**, **beta**, and the same evaluation request URL.
1. In **Request Body**, change only `displayName` from `Inventory-Taker` to `Sales-Inventory-Taker`. Keep all other values unchanged.
1. Select **Run query**.
1. In **Response preview**, find the result for `enforce_application_name_prefix`.

With this configuration, expect **200 OK** and the following fields:

| Field | Value |
| --- | --- |
| `appliedPoliciesEffects` | `compliant` |
| `isBlocked` | `false` |
| `details[].assignmentUniqueName` | `enforce_application_name_prefix` |
| `details[].appliedPolicyEffects` | `compliant` |

The response message is:

> Resource is compliant with assigned policies.

Both examples return `isBlocked: false`. Compare the policy effects to distinguish compliance from a report-only violation.

## 3. Clean up or continue

To continue with the [tutorial](resource-policy-tutorial-portal.md), keep `enforce_application_name_prefix` **On** and **Report-only**, with its version and parameters unchanged. Skip deletion.

If you're stopping here, delete the assignment. The simulated tests created no applications to clean up.

1. Browse to **Tenant governance** > **Assignments**.
1. Select the checkbox for `enforce_application_name_prefix`. Confirm that only the intended assignment is selected, including any selections hidden by the current filter.
1. Select **Delete**.
1. In **Remove assignment?**, confirm **Selected items: 1.**, then select **Delete**.

Deleting the assignment stops it from applying the policy and moves it to **Deleted items**. You can restore it for 30 days.

## Next steps

Follow [Tutorial: Observe and enforce a built-in resource policy](resource-policy-tutorial-portal.md) to test real requests, inspect audit events, enable enforcement, and verify recovery.

## Related content

- [Resource policy concepts](resource-policy-concepts.md).
- [Create and manage resource policies in the Microsoft Entra admin center](resource-policy-manage-portal.md).
- [Safely deploy resource policy assignments](resource-policy-safe-deployment.md).
