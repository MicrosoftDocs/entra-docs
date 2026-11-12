---
title: Safely deploy Microsoft Entra resource policy assignments (preview)
description: Test a resource policy, review real traffic, plan temporary application exceptions, and enable enforcement without disrupting critical workflows.
ms.topic: how-to
ms.date: 11/11/2026
ai-usage: ai-generated
# Customer intent: As a tenant administrator, I want to deploy policy assignments safely so that I can enforce requirements without unexpected disruption.
---

# Safely deploy Microsoft Entra resource policy assignments (preview)

Follow these steps to test a policy, assess real traffic, and enable enforcement.

## Prerequisites

- A built-in or custom policy definition available in the target tenant, with the version and parameter values you plan to assign.
- A Microsoft Entra ID Governance service plan to create and update assignments. See [licensing requirements](licensing.md#resource-policy-preview).
- A work or school account in that tenant with active [Resource Policy Administrator](resource-policy-concepts.md#roles-and-api-permissions) and [Reports Reader](~/identity/role-based-access-control/permissions-reference.md#reports-reader) roles. Use this account in the [Microsoft Entra admin center](https://entra.microsoft.com) to manage assignments and in Microsoft Graph Explorer to test policies and read evaluation audit events.
- [Microsoft Graph Explorer](https://developer.microsoft.com/graph/graph-explorer) with admin consent for the delegated `ResourcePolicyEvaluation.Read.All` and `AuditLog.Read.All` permissions.
- For real `fetchAsPolicy()` reads during `evaluatePolicy`, a [configured privileged-read app](resource-policy-privileged-read-app.md) and admin consent for the delegated `ResourcePolicyDefinition.ReadWrite.All` permission in Graph Explorer.
- An approved test plan for the target tenant.
- A policy owner, contacts for affected application owners, and saved settings for recovery.

Activate any eligible roles through Privileged Identity Management (PIM) before starting. Graph Explorer doesn't need assignment-management permissions for this workflow because assignment changes use the Microsoft Entra admin center.

## 1. Define the intended impact

1. Select the policy version and parameter values. Record the resource changes it should allow and block.
1. Identify existing business-critical applications that might need temporary exceptions, and contact their owners.

## 2. Test representative requests

1. Use `evaluatePolicy` with supplied Rego, parameter values, and a proposed request URI, HTTP method, and body. Use `evaluateAssignedPolicies` for existing assignments. See [Test and troubleshoot a resource policy](resource-policy-test-troubleshoot.md).
1. Test requests that should pass, requests that should fail, and requests covered by an intended exception. Include missing values or partial updates where relevant.
1. Inspect the policy results and errors, not just the HTTP status. Check that each result matches your expectation.

Evaluation actions don't perform the simulated write, but policies can still make real additional reads.

## 3. Assign without enforcement

1. [Create an assignment](resource-policy-manage-portal.md#create-an-assignment) with **Status** set to **On** and **Enforcement** set to **Report-only** (`doNotEnforce`). Check the policy version and parameters.
1. Wait for [assignment changes to take effect](resource-policy-evaluation.md#assignment-propagation).

For a version update, create this assignment for the new version and leave the old assignment enforced. Follow [Roll out the new version](resource-policy-lifecycle.md#roll-out-the-new-version) for the handover.

## 4. Review impact

1. Choose an observation period that covers normal business operations, including infrequent automation.
1. [Retrieve evaluation audit events](resource-policy-logs.md#assess-assignment-impact-from-evaluation-events) and find the intended assignment and version in the policy details.
1. List affected applications, violations, and evaluation errors. Review errors separately, and check whether approved exceptions work as intended.

A quiet period or missing events doesn't prove readiness for enforcement.

## 5. Resolve violations and review exceptions

You don't have to update every existing application before enforcing a policy. When the policy supports application exceptions, use an approved exception list to keep business-critical applications running. Other applications, including new ones, must meet the policy's requirements.

1. With application owners, decide which applications can be updated now and which need temporary exceptions.
1. Add approved applications to the supported exception parameter, using the identifiers specified by its description.
1. For each exception, record an owner, required application changes, a target completion date, and removal criteria. Include unresolved evaluation errors in the investigation plan.
1. Retest allowed, denied, and excepted requests with the updated values. After assignment changes take effect, confirm the results in evaluation audit events.

Track remediation after enforcement. Once an application makes compliant changes, remove its exception, wait for the change to take effect, and verify its normal requests still succeed. See [Parameter update behavior](resource-policy-parameters.md#assignment-update-behavior).

## 6. Enable enforcement

1. Get the policy owner's approval of the results, temporary exceptions and remediation plans, and recovery settings.
1. [Edit the assignment](resource-policy-manage-portal.md#edit-an-existing-assignment) to set **Enforcement** to **Enforce** (`enforce`).
1. Wait for [assignment changes to take effect](resource-policy-evaluation.md#assignment-propagation). For a version update, confirm new enforcement before disabling the old assignment.
1. Verify a compliant request succeeds, a noncompliant request outside the exception list is blocked by this policy, and an excepted workflow still works.

Continue reviewing evaluation audit events and the exception-removal plan. Other policies and service controls can still affect the same requests.

## 7. Recover from unexpected impact

Choose the recovery path for your deployment.

### First deployment

Use this recovery path when you don't have a previous enforced version or working parameter values to restore.

Turning off the assignment or returning it to report-only removes its enforcement protection; neither change takes effect on every request immediately.

1. [Turn off the affected assignment](resource-policy-manage-portal.md#turn-off-an-assignment) to stop evaluation. To keep evaluating without blocking, [edit it](resource-policy-manage-portal.md#edit-an-existing-assignment) instead: keep **Status** set to **On** and set **Enforcement** to **Report-only**.
1. Wait for [assignment changes to take effect](resource-policy-evaluation.md#assignment-propagation), then retest the affected workflow. Other enforced assignments and service controls can still block requests.
1. Correct and test the policy or parameters. Repeat the report-only assessment and approval steps before enabling enforcement again.

### Version or parameter changes

For a version regression, re-enable the retained old assignment and confirm it is enforcing before disabling the new one. Follow [Roll back to the previous version](resource-policy-lifecycle.md#roll-back-to-the-previous-version).

For an incorrect parameter change, restore the saved working values, allow the change to take effect, and retest the affected requests. Review any temporary application exceptions with their owners while you investigate.

## Related content

- [Quickstart: Assign a built-in resource policy](resource-policy-quickstart-portal.md).
- [Create and manage resource policies in the Microsoft Entra admin center](resource-policy-manage-portal.md).
- [Analyze resource policy evaluation audit logs](resource-policy-logs.md).
