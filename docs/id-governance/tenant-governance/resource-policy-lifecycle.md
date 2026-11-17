---
title: Update and retire Microsoft Entra resource policies (preview)
description: Publish a new policy version, try it alongside an enforced version, switch enforcement, roll back, and delete or restore resource policies.
ms.topic: how-to
ms.date: 11/11/2026
ai-usage: ai-generated
# Customer intent: As a policy administrator, I want to update or retire a policy so that I can preserve existing protection and recovery options.
---

# Update and retire Microsoft Entra resource policies (preview)

Use this article to update an assigned policy, roll back, or delete and restore policies. Assess a new version through a separate report-only assignment while the existing version stays enforced.

For your first policy assignment, testing, and enforcement readiness, see [Safely deploy resource policy assignments](resource-policy-safe-deployment.md). For parameter-value changes, see [Edit an assignment](resource-policy-manage-portal.md#edit-an-existing-assignment) and [Parameter update behavior](resource-policy-parameters.md#assignment-update-behavior).

Use [Microsoft Graph Explorer](https://developer.microsoft.com/graph/graph-explorer) to call the linked Microsoft Graph APIs for these procedures. For portal assignment controls, see [Manage policies in the Microsoft Entra admin center](resource-policy-manage-portal.md).

## Prerequisites

- A work or school account in the target tenant with active [Resource Policy Administrator](resource-policy-concepts.md#roles-and-api-permissions) and [Reports Reader](~/identity/role-based-access-control/permissions-reference.md#reports-reader) roles. Use Resource Policy Administrator for policy management and evaluation, and Reports Reader for evaluation audit events.
- [Microsoft Graph Explorer](https://developer.microsoft.com/graph/graph-explorer), signed in to that tenant with the same account, with admin consent for the delegated permissions listed below. Request only the permissions for the procedures you follow.
- A Microsoft Entra ID Governance service plan for publishing or updating policies, creating or updating assignments, and restoring deleted items. See [licensing requirements and exceptions](licensing.md#resource-policy-preview).
- A policy or assignment to update, retire, or restore. For the parallel rollout below, the existing assignment must be enabled and enforced.
- A saved copy of the current policy and assignment settings, including parameter values.
- For policies that use `fetchAsPolicy()`, a [configured privileged-read application](resource-policy-privileged-read-app.md) with application permissions for the Microsoft Graph reads used by the policy.

Activate any eligible roles through Privileged Identity Management (PIM) before signing in to Graph Explorer.

| Delegated permission for Graph Explorer | When needed |
| --- | --- |
| `ResourcePolicyDefinition.ReadWrite.All` | Publish, delete, or restore custom definitions, or manage their versions. Not needed for assignment-only changes to built-in policies. |
| `ResourcePolicyAssignment.ReadWrite.All` | Read, create, update, delete, or restore assignments. |
| `ResourcePolicyEvaluation.Read.All` | Test policy changes. |
| `AuditLog.Read.All` | Review evaluation audit events. |

## Publish a new custom policy version

For a built-in policy, select an available newer version and go directly to [Roll out the new version](#roll-out-the-new-version). Don't edit built-in definitions.

1. Update your Rego policy and increase its version number. Update any parameter reference or import to match the new package version. For example, change `1.0.0` to `1.1.0` in the package declaration:

    ```rego
    package graph.application_name_prefix["1.1.0"]
    ```

1. [Test the revised policy](resource-policy-test-troubleshoot.md) with the intended parameter values and requests that should pass and fail. Check that unchanged requirements still behave as expected.
1. [Update the custom definition](/graph/api/resourcepolicydefinition-update?view=graph-rest-beta&preserve-view=true) with the revised Rego, following the API reference's update requirements.
1. Confirm that both versions are available. Keep your existing assignment unchanged.

A parameter schema change requires a higher major version, such as `2.0.0`, and compatible parameter values. Keep the target resource type unchanged. See [Author policies with Rego](resource-policy-rego.md).

## Roll out the new version

Use two assignments: one enforces the old version, and the other evaluates the new version in report-only mode.

Each version can have only one live assignment in a tenant, including a disabled assignment. Choose a new version that isn't already assigned; don't repoint the existing assignment to it.

1. [Create a new assignment](/graph/api/resourcepolicyassignment-create?view=graph-rest-beta&preserve-view=true) with a different name, the new policy version, and its intended parameter values. Set it to enabled (`isEnabled: true`) and report-only (`enforcementMode: doNotEnforce`). Leave the existing enforced assignment on.
1. Wait for [assignment changes to take effect](resource-policy-evaluation.md#assignment-propagation).
1. Confirm that evaluation audit events include both assignment names and their expected policy versions.
1. [Review the new assignment's impact](resource-policy-logs.md#assess-assignment-impact-from-evaluation-events), agree on remediation or supported temporary exceptions, and complete the [checks before enforcement](resource-policy-safe-deployment.md#6-enable-enforcement).
1. [Update the new assignment](/graph/api/resourcepolicyassignment-update?view=graph-rest-beta&preserve-view=true) to **Enforce** (`enforcementMode: enforce`). Keep the old assignment enforced while the change takes effect.
1. Verify the new assignment's enforced results in evaluation audit events, and test compliant and noncompliant requests.
1. Once the new version is enforcing as expected, turn the old assignment **Off** (`isEnabled: false`). Keep that assignment and its policy version available for rollback.

Review each assignment's results separately. The old version can still block requests that the new one would allow. While both versions enforce, either can block.

## Roll back to the previous version

To return to the old version, use the assignment you retained:

1. Check that the old assignment still references the tested version and has its original parameter values.
1. Turn the old assignment **On** with **Enforcement** set to **Enforce**.
1. Wait for [assignment changes to take effect](resource-policy-evaluation.md#assignment-propagation).
1. Verify the old assignment's enforced results in evaluation audit events and test requests.
1. Turn the new assignment **Off** after the old assignment is enforcing again.

This order keeps enforcement in place. Don't create another assignment for a version that already has one.

Rollback doesn't undo resource changes that were already allowed.

## Retire an old version

Keep the old version and assignment until you no longer need them for recovery.

1. Confirm that the replacement works and the policy owner approves retirement.
1. [Delete the old assignment](/graph/api/resourcepolicyassignment-delete?view=graph-rest-beta&preserve-view=true). A disabled assignment still prevents you from deleting its policy version.
1. For a custom policy, [delete the unused previous version](/graph/api/resourcepolicydefinitionversion-delete?view=graph-rest-beta&preserve-view=true). Don't delete Microsoft-managed built-in versions.

> [!WARNING]
> Deleting a previous version is permanent. It can't be restored.

Keep custom policy source in your own repository. See [Version-history limits](resource-policy-service-limits.md#version-history-and-deleted-items).

## Delete a custom policy

To remove a custom policy you no longer need:

1. Save its Rego and assignment settings if you might need them later.
1. Delete all assignments that reference the definition, including disabled assignments.
1. [Delete the custom definition](/graph/api/resourcepolicydefinition-delete?view=graph-rest-beta&preserve-view=true).

Deleted definitions and assignments can be restored for 30 days. Permanent deletion or expiration removes this recovery option.

## Restore a deleted policy or assignment

Restore the policy before an assignment that uses it:

1. [Restore the custom definition](/graph/api/resourcepolicydefinition-restore?view=graph-rest-beta&preserve-view=true) if it was deleted, and confirm that the required version is available.
1. Review the deleted assignment's version, parameters, and enablement and enforcement settings.
1. Confirm that the version has no other live assignment, including a disabled assignment.
1. [Restore the assignment](/graph/api/resourcepolicyassignment-restore?view=graph-rest-beta&preserve-view=true).
1. Allow the restored settings to take effect, then verify request behavior and evaluation audit events.

Restore the deleted assignment rather than reusing its reserved name.

## Related content

- [Create and manage resource policies in the Microsoft Entra admin center](resource-policy-manage-portal.md).
- [Safely deploy resource policy assignments](resource-policy-safe-deployment.md).
- [Analyze resource policy evaluation audit logs](resource-policy-logs.md).
- [Resource policy parameters](resource-policy-parameters.md).
