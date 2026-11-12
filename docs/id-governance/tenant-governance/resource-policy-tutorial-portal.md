---
title: "Tutorial: Observe and enforce a built-in Microsoft Entra resource policy (preview)"
description: Continue from the resource policy quickstart to observe real requests, inspect audit events, enforce a policy, verify recovery, and clean up.
ms.topic: tutorial
ms.date: 11/12/2026
ms.custom: msecd-doc-authoring-1030
ai-usage: ai-generated
# Customer intent: As a tenant administrator, I want to observe, enforce, and recover a built-in policy so that I can understand its complete lifecycle before planning a production rollout.
---

# Tutorial: Observe and enforce a built-in Microsoft Entra resource policy (preview)

Continue from [Quickstart: Assign and test a built-in resource policy](resource-policy-quickstart-portal.md) to see how the same assignment affects real Microsoft Graph requests. Use the [Microsoft Entra admin center](https://entra.microsoft.com/) to manage the assignment and [Microsoft Graph Explorer](https://developer.microsoft.com/graph/graph-explorer) to create test applications and investigate evaluation audit events.

In this tutorial, you:

- Compare compliant and noncompliant requests in report-only mode.
- Inspect the corresponding evaluation audit events.
- Enable enforcement and verify allowed and blocked requests.
- Return to report-only mode and verify recovery.
- Remove the assignment and test applications.

Unlike the quickstart's simulated evaluations, these tests create real application registrations when requests are allowed. Enforcement affects matching requests throughout the test tenant. Allow time between stages for assignment propagation and audit-event availability.

## Prerequisites

- Complete the [built-in policy quickstart](resource-policy-quickstart-portal.md). Retain its assignment, version, and parameter values. If you already deleted the assignment, follow the recovery instructions in [Confirm the starting assignment](#1-confirm-the-starting-assignment).
- Keep the quickstart's Microsoft Entra ID Governance service plan to update or restore the assignment. See [licensing requirements](licensing.md#resource-policy-preview).
- Use the same work or school account and test tenant in the Microsoft Entra admin center and Microsoft Graph Explorer throughout the tutorial, including cleanup.

### Microsoft Entra roles for your account

| Role | Purpose in this tutorial |
| --- | --- |
| [Resource Policy Administrator](resource-policy-concepts.md#roles-and-api-permissions) | Update, restore, and delete the assignment, and repeat simulated validation if needed. |
| [Application Developer](~/identity/role-based-access-control/permissions-reference.md#application-developer) | Create the test app registrations and manage the apps you own, including deleting them during cleanup. |
| [Reports Reader](~/identity/role-based-access-control/permissions-reference.md#reports-reader) | Read the evaluation audit-log events. |

Application Developer lets you create test apps even when **Users can register applications** is **No**. You don't need it if default user permissions already let you create and manage your own apps.

If a required role is eligible through Privileged Identity Management (PIM), activate it before starting.

### Delegated permissions for Microsoft Graph Explorer

Before starting, have an administrator grant consent in the test tenant for the following **delegated** Microsoft Graph permissions for **Microsoft Graph Explorer**:

| Permission | Purpose in this tutorial |
| --- | --- |
| `AuditLog.Read.All` | Query evaluation audit events through `/auditLogs/resourcePolicy`. |
| `Application.ReadWrite.All` | Create the test app registrations through `/applications`. |
| `ResourcePolicyEvaluation.Read.All` | Retain the quickstart's grant to repeat simulated validation if you restore or change the assignment. |

Grant these permissions to Graph Explorer, not the test apps. Assignment changes and app cleanup use the Microsoft Entra admin center with your account's roles and app ownership.

## 1. Confirm the starting assignment

1. Sign in to the Microsoft Entra admin center with the same account and tenant used in the quickstart.
1. Browse to **Tenant governance** > **Assignments** and open `enforce_application_name_prefix`.
1. Confirm the saved assignment settings:

    | Setting | Expected value |
    | --- | --- |
    | Policy definition | Require a department prefix for application names |
    | Policy version | `1.0.0` |
    | Status | **On** |
    | Enforcement | **Report-only** |
    | `allowed_departments` | `Engineering-`, `Marketing-`, `IT-`, `HR-`, `Finance-`, `Sales-` |
    | `banned_word_list` | Empty |
    | `client_appid_exclusion_list` | Empty |

1. Sign in to Graph Explorer with the same account and tenant. Confirm it has the delegated permissions listed in [Prerequisites](#prerequisites).

If the assignment isn't ready, use the matching recovery path:

| Assignment state | Action |
| --- | --- |
| Deleted | Find it under **Tenant governance** > **Deleted items** > **Assignments**. Verify its identity and saved **On / Report-only** settings before [restoring it](resource-policy-manage-portal.md#restore-deleted-items). |
| Settings differ from the table above | [Edit the assignment](resource-policy-manage-portal.md#edit-an-existing-assignment) to restore those values. |
| Neither live nor restorable | Repeat the quickstart. Don't create a second live assignment for the same policy version. |

After restoring or correcting the assignment, repeat the quickstart's [simulated validation](resource-policy-quickstart-portal.md#2-validate-without-performing-a-write) before continuing.

## 2. Review real request impact

Wait for [assignment changes to propagate](resource-policy-evaluation.md#assignment-propagation), then test both names. This report-only assignment allows both requests, but other policies or service controls can still block them.

1. In Graph Explorer, select **POST** and **beta**, and enter this request URL:

    ```http
    https://graph.microsoft.com/beta/applications
    ```

1. In **Request Body**, enter the noncompliant application name:

    ```json
    {
      "displayName": "Inventory-Taker"
    }
    ```

1. Select **Run query** and confirm **201 Created**. Record the UTC time, response `request-id`, any returned `client-request-id`, and returned application's object `id` for cleanup.
1. Repeat with `displayName` set to `Sales-Inventory-Taker`. Confirm **201 Created** and record the time, request identifiers, and object `id` separately.
1. Select **GET** and enter the following URL. Replace the placeholder with one recorded request ID and the timestamps with a UTC window that includes the request. The start and end times are inclusive:

    ```http
    https://graph.microsoft.com/beta/auditLogs/resourcePolicy?$filter=requestId eq '{request-id-or-client-request-id}' and evaluatedDateTime ge 2026-11-06T09:00:00Z and evaluatedDateTime le 2026-11-06T18:00:00Z&$select=id,requestId,policyDecision,policyDetails
    ```

1. Select **Run query**.
1. Find `enforce_application_name_prefix` in `policyDetails` and confirm `policyVersion` is `1.0.0`. If no event matches the response `request-id`, try the returned `client-request-id`. Allow for logging delay; no event isn't proof of compliance.
1. Repeat the query for the other recorded request and compare the results below.

| Application name | Expected assignment detail in report-only mode |
| --- | --- |
| `Inventory-Taker` | `isApplicable: true`, `isCompliant: false`, `isEnforced: false`, and a naming explanation in `policyMessage`. |
| `Sales-Inventory-Taker` | `isApplicable: true`, `isCompliant: true`, and `isEnforced: false`. |

Check that `policyLoadingError`, `applicabilityEvaluationError`, and `evaluationError` are null or absent. Treat errors separately from a successfully evaluated violation.

These two requests don't measure the policy's impact on all production traffic. For a production rollout, [assess representative traffic](resource-policy-logs.md#assess-assignment-impact-from-evaluation-events) and follow [safe deployment practices](resource-policy-safe-deployment.md). The preview doesn't provide aggregated impact reports.

## 3. Enforce the policy

1. Browse to **Tenant governance** > **Assignments** and open `enforce_application_name_prefix`.
1. On **Assignment details**, select **Edit**.
1. On **Settings**, keep **Status** set to **On** and change **Enforcement** from **Report-only** to **Enforce**.
1. On **Parameters**, keep `Engineering-`, `Marketing-`, `IT-`, `HR-`, `Finance-`, and `Sales-` in `allowed_departments`. Leave `banned_word_list` and `client_appid_exclusion_list` empty.
1. On **Review**, review the summary and select **Save**.
1. Reopen **Assignment details** and confirm **Status** is **On** and **Enforcement** is **Enforce**.

Wait for [assignment changes to propagate](resource-policy-evaluation.md#assignment-propagation), then use Graph Explorer to test enforcement. The noncompliant name should be blocked; the compliant name should create an application.

### Test a noncompliant request

Try to create an application with a name that doesn't start with an allowed prefix.

1. In Graph Explorer, select **POST** and **beta**, and enter this request URL:

    ```http
    https://graph.microsoft.com/beta/applications
    ```

1. In **Request Body**, enter:

    ```json
    {
      "displayName": "Inventory-Taker"
    }
    ```

1. Select **Run query**.
1. In **Response preview**, confirm **403 Forbidden** with `error.code` set to `DeniedByResourcePolicy`. The error message identifies assignment `enforce_application_name_prefix` and explains that the application name needs an allowed department prefix.

Inspect the response body rather than relying on Graph Explorer's generic permissions message for a **403** response. The `DeniedByResourcePolicy` code, assignment identifier, and naming reason identify the policy denial in this example.

### Test a compliant request

Use the same application-creation URL with a name that starts with an allowed prefix.

1. Keep **POST**, **beta**, and the same request URL.
1. In **Request Body**, enter:

    ```json
    {
      "displayName": "Sales-Inventory-Taker"
    }
    ```

1. Select **Run query**.
1. In **Response preview**, confirm **201 Created** and copy the returned application's `id` for cleanup. Use the object `id`, not the `appId`.

## 4. Return to report-only and verify recovery

To stop blocking requests without removing the assignment, return it to report-only mode.

1. Open **Assignment details** for `enforce_application_name_prefix` and select **Edit**.
1. On **Settings**, keep **Status** set to **On** and change **Enforcement** to **Report-only**. Leave the parameters unchanged.
1. On **Review**, select **Save**.
1. Reopen **Assignment details** and confirm **On** and **Report-only**.
1. Wait for [assignment changes to propagate](resource-policy-evaluation.md#assignment-propagation).
1. In Graph Explorer, repeat **POST** to `https://graph.microsoft.com/beta/applications` with `displayName` set to `Inventory-Taker`. Expect **201 Created** unless another control blocks it, and record the returned object's `id` for cleanup.

Confirm recovery with the real request, not just the saved setting or a simulated evaluation. Report-only continues to evaluate the assignment but doesn't enforce its deny effect.

## 5. Clean up

Remove the assignment retained from the quickstart and clean up only the test resources you created.

### Remove the assignment

Delete the assignment from the tenant-wide list.

1. Browse to **Tenant governance** > **Assignments**.
1. Select the checkbox for `enforce_application_name_prefix`. Confirm that only the intended assignment is selected, including any selections hidden by the current filter.
1. Select **Delete**.
1. In **Remove assignment?**, confirm **Selected items: 1.**, then select **Delete**.

Deleting the assignment stops it from applying the policy and moves it to **Deleted items**. You can restore it for 30 days.

### Remove the test applications

Remove every application created by the report-only, enforcement, and recovery tests. More than one application can have the same display name. Use each object's `id` returned by a successful creation request to identify the test resource, not its `appId` or display name alone.

1. In the Microsoft Entra admin center, go to **Entra ID** > **App registrations** and select a test application.
1. On the application's **Overview** page, confirm its object ID matches one recorded during this tutorial, then select **Delete**.
1. In **Delete app registration**, review the warning that the app won't be able to sign in users or access protected resources, then select **Delete**.
1. Open **Notifications** and confirm the deletion succeeded for that application.
1. Repeat for each remaining test application whose object ID you recorded.

## Next steps

For a production rollout, use [Safely deploy resource policy assignments](resource-policy-safe-deployment.md) to plan representative observation, application-owner review, and recovery.

## Related content

- [Quickstart: Assign and test a built-in resource policy](resource-policy-quickstart-portal.md).
- [Analyze resource policy evaluation audit logs](resource-policy-logs.md).
- [Create and manage resource policies in the Microsoft Entra admin center](resource-policy-manage-portal.md).
- [Update and retire resource policies](resource-policy-lifecycle.md).
