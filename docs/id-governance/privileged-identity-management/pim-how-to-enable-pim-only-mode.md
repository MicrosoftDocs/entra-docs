---
title: Configure PIM-only mode for Azure (preview)
description: Configure PIM-only mode for an Azure subscription to help enforce PIM role assignment settings. Review audit events and configure exceptions before enforcement.
ms.topic: how-to
ms.date: 11/02/2026
ms.custom: msecd-doc-authoring-1030
ai-usage: ai-assisted
#customer intent: As an IT administrator, I want to configure PIM-only mode for an Azure subscription so that PIM role assignment settings apply when administrators manage access.
---

# Configure PIM-only mode for Azure (preview)

PIM-only mode for Azure (preview) helps ensure that your organization's Microsoft Entra Privileged Identity Management (PIM) role assignment settings apply when you manage Azure role assignments. You can manage role assignments in both **Privileged Identity Management** and **Access control (IAM)**.

Use this guide to configure PIM-only mode for an Azure subscription. Start in **Audit** mode to review role assignment operations that would be blocked, configure any necessary exceptions, and then switch to **Deny** mode.

Existing role assignments continue to function.

## Prerequisites

- To read and assign Azure Policy and manage policy exemptions, you need the **Resource Policy Contributor** or **Owner** role at Azure subscription scope.
- To manage PIM role settings for the Azure subscription, you need the **Owner** or **User Access Administrator** role at Azure subscription scope.

## Assign the policy in Audit mode

Start in **Audit** mode to identify role assignment operations that would be blocked in **Deny** mode. Review those operations to determine whether they can follow PIM role assignment settings or need an exception. The policy's default effect is **Audit**. Keep this setting for the initial rollout to review operations before enforcing restrictions.

Both **Privileged Identity Management** and **Access control (IAM)** support role assignment management. The following table shows how **Deny** mode restricts specific operations at Azure subscription scope. Each action requires appropriate permissions.

| Action in the admin interface | Without PIM-only mode | With PIM-only mode (Deny) |
| --- | --- | --- |
| Manage eligible or active assignments in **Privileged Identity Management**. | Available. | Available. |
| Manage eligible assignments in **Access control (IAM)**. | Available. | Available. |
| Manage active assignments in **Access control (IAM)**. | Available. | Blocked; exceptions don't apply. |

> [!WARNING]
> Before enforcing PIM-only mode, ensure that you have an emergency recovery option if your usual administrative access becomes unavailable. Configure emergency access accounts with **permanent active Global Administrator role assignments** in Microsoft Entra ID, as described in [Manage emergency access accounts in Microsoft Entra ID](~/identity/role-based-access-control/security-emergency-access.md).
>
> Microsoft Entra Global Administrators can use [Elevate access](/azure/role-based-access-control/elevate-access-global-admin) to obtain permissions to manage access to Azure resources. In an emergency, an administrator with the required permissions can also [delete the policy assignment through Azure Policy](/azure/governance/policy/assign-policy-portal#clean-up-resources).

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com).

1. Browse to **ID Governance** > **Privileged Identity Management** > **Azure resources**. From the **Subscriptions** dropdown, select the Azure subscription where you want to configure PIM-only mode.

    :::image type="content" source="media/pim-resource-roles-configure-role-settings/resources-list.png" alt-text="Screenshot that shows the list of Azure resources discovered in Privileged Identity Management." lightbox="media/pim-resource-roles-configure-role-settings/resources-list.png":::

1. Select **Assignment Policies**, and then select **+ Assign policy**.

1. On the **Basics** tab, review the **Scope** and any **Exclusions**. Confirm that **Policy definition** is **Azure role assignment management should be restricted to Microsoft Entra Privileged Identity Management**. Keep **Policy enforcement** set to **Enabled**.

    :::image type="content" source="media/pim-resource-roles-configure-role-settings/pim-only-mode-policy-basics.png" alt-text="Screenshot of the Assign policy Basics tab with Assignment Policies selected in the left navigation." lightbox="media/pim-resource-roles-configure-role-settings/pim-only-mode-policy-basics.png":::

1. On the **Parameters** tab, clear **Only show parameters that need input or review**, and confirm that **Effect** is set to **Audit**.

    :::image type="content" source="media/pim-resource-roles-configure-role-settings/pim-only-mode-policy-parameters.png" alt-text="Screenshot of the Assign policy Parameters tab with Effect set to Audit and exception parameters visible." lightbox="media/pim-resource-roles-configure-role-settings/pim-only-mode-policy-parameters.png":::

1. Leave the exception parameters at their default empty lists unless you have a specific scenario that requires an exception to PIM-only mode:

    - **Exempted Role Definition IDs:** Exempt assignments for the listed role definition IDs from PIM-only mode restrictions.
    - **Exempt Requestor Types:** Select the principal types from the dropdown for identities allowed to make assignments without PIM-only mode restrictions.
    - **Exempt Assignee Types:** Select the principal types from the dropdown for identities allowed to receive role assignments without PIM-only mode restrictions.
    - **Excluded Requestors:** Allow the listed requester object IDs to create active assignments without PIM-only mode restrictions. For example, to allow an application to create these assignments, add its object ID to this list.

    These parameters allow exceptions based on the role or identities involved. To exempt a scope instead, use an Azure Policy exemption as described in Review activity logs and configure exemptions. Parameter-based exceptions don't allow active assignment creation through **Access control (IAM)**.

1. On **Review + create**, review the settings, and then select **Create**.

The policy assignment appears on the **Assignment Policies** page. In **Audit** mode, noncompliant attempts to create or update assignments are allowed and recorded as audit events in the Azure Activity Log.

:::image type="content" source="media/pim-resource-roles-configure-role-settings/pim-only-mode-policy-assignments.png" alt-text="Screenshot of the Assignment Policies page showing the created policy assignment and its View activity logs link." lightbox="media/pim-resource-roles-configure-role-settings/pim-only-mode-policy-assignments.png":::

For more information about policy assignment options, see [Create a policy assignment in the Azure portal](/azure/governance/policy/assign-policy-portal).

<a name='review-compliance-and-configure-exemptions'></a>

## Review activity logs and configure exemptions

Use the Azure Activity Log to review role assignment operations before switching to **Deny**. Start from the **Assignment Policies** page in PIM and open the activity logs for the policy assignment.

1. On **Assignment Policies**, select **View activity logs** next to the policy assignment to open its activity logs.
1. Review audit events for noncompliant attempts to create or update role assignments. For each operation, determine whether it can follow PIM role assignment settings or requires an exception.
1. If a scope requires an Azure Policy exemption, select the policy assignment, and then select **Create exemption**.
1. Specify the **Scope**, **Exemption name**, **Exemption category**, **Expiration**, and **Description**. In the description, record the business justification and owner.

    :::image type="content" source="media/pim-resource-roles-configure-role-settings/pim-only-mode-create-exemption.png" alt-text="Screenshot of the Create exemption page showing scope, exemption name, category, expiration, and description fields." lightbox="media/pim-resource-roles-configure-role-settings/pim-only-mode-create-exemption.png":::

1. Select **Review + create**, review the details, and then create the exemption.

Azure Policy exemptions support expiration dates and exemption categories. Review exemptions at least quarterly, and use the narrowest scope and shortest expiration that meets the need.

For more information about exemption scopes, categories, and expiration, see [Azure Policy exemption structure](/azure/governance/policy/concepts/exemption-structure).

<a name='switch-to-enforcement'></a>

## Switch to Deny mode

After you review audit events and configure any necessary exceptions, use the **Deny** effect to help enforce PIM role assignment settings unless an exception applies. Tell administrators who work in the affected scope that they can manage assignments in both **Privileged Identity Management** and **Access control (IAM)**, subject to the **Deny** mode restrictions.

1. Return to **Privileged Identity Management** > **Azure resources**, and select the scope.
1. Under **Manage**, select **Assignment Policies**, and then select the policy assignment.
1. Select **View assignment**, and edit the assignment.
1. On the **Parameters** tab, clear **Only show parameters that need input or review**, and change **Effect** from **Audit** to **Deny**.
1. Save the assignment.

Active assignment creation through **Access control (IAM)** is blocked in **Deny** mode and can't be exempted. Each policy assignment is independent, so you can use **Deny** on one scope while continuing to audit another.

## API and automation behavior

If you use Azure CLI, PowerShell, scripts, or applications to manage assignments, their behavior depends on the API they call and any applicable policy exceptions. These tools aren't categorically blocked.

PIM-only mode uses Azure Policy to audit or block role assignment management through APIs other than PIM APIs. Both **Privileged Identity Management** and **Access control (IAM)** support role assignment management; the restriction depends on the API used for the operation, not just the interface. **Privileged Identity Management** and eligible assignment creation through **Access control (IAM)** use PIM APIs. Active assignment creation through **Access control (IAM)** doesn't use PIM APIs.

| API used to manage assignments | Without PIM-only mode | With PIM-only mode (Deny) |
| --- | --- | --- |
| PIM APIs. | Available with appropriate permissions. | Available with appropriate permissions. |
| Non-PIM APIs. | Available with appropriate permissions. | Blocked unless a configured exception applies for the client. |

<!-- TODO: Confirm which Azure RBAC role assignment APIs are affected and name them explicitly rather than treating all Azure RBAC APIs as equivalent to non-PIM APIs. -->

<!-- TODO: Confirm whether the restricted operations include role activation extensions or role assignment extensions, and verify the full list of management operations before enumerating it. -->

## Scope and preview limitations

PIM-only mode for Azure doesn't govern Microsoft Entra directory roles or the Groups resource provider. Consider these limitations when you review activity logs and plan exceptions:

- **Supported scope:** You can configure PIM-only mode at Azure subscription scope. Management group scope isn't supported in the preview.
- **Activity logs:** Use audit and deny events in the Azure Activity Log to identify noncompliant attempts to create or update role assignments.

<!-- TODO: Confirm whether the preview limitation that the compliance view shows no resources in any policy mode applies to the Azure Policy Compliance page, a PIM page, or both. Add the exact page name and distinguish resource compliance reporting from operation-level activity logs. -->

## Related content

- [Configure Azure resource role settings in PIM](pim-resource-roles-configure-role-settings.md).
