---
title: Monitor governing tenant admin activity in a governed tenant (preview)
titleSuffix: Microsoft Entra ID Governance
description: Learn how to monitor and audit governing tenant administrator activity in your governed tenant using sign-in and audit logs
author: barclayn
ms.author: barclayn
ms.service: entra-id-governance
ms.topic: how-to
ms.date: 03/10/2026
---

# Monitor governing tenant admin activity in the governed tenant (preview)

> [!IMPORTANT]
> This information relates to a prerelease product that might be substantially modified before release. Microsoft makes no warranties, expressed or implied, with respect to the information provided here.

After you establish a governance relationship between a governing tenant and a governed tenant, administrators from the governing tenant can sign in to the governed tenant using their governing tenant credentials through granular delegated admin privileges (GDAP). As a governed tenant admin, you can monitor these activities through sign-in logs and audit logs to maintain security visibility and ensure that governing tenant admins operate within their authorized scope.

This article describes how to identify, review, and monitor the activities that governing tenant administrators perform in your governed tenant.

## Prerequisites

- An active governance relationship between the governing tenant and your governed tenant.

- One of these roles assigned in the governed tenant:

  - [Reports Reader](/entra/identity/role-based-access-control/permissions-reference#reports-reader)
  - [Security Reader](/entra/identity/role-based-access-control/permissions-reference#security-reader)
  - [Security Administrator](/entra/identity/role-based-access-control/permissions-reference#security-administrator)
  - [Global Reader](/entra/identity/role-based-access-control/permissions-reference#global-reader)
  - [Global Administrator](/entra/identity/role-based-access-control/permissions-reference#global-administrator)

- Access to the [Microsoft Entra admin center](https://entra.microsoft.com).

## Identify governing tenant administrators in logs

Governing tenant administrators who sign in to the governed tenant through GDAP appear differently from regular users in your logs. Understanding how to identify them is the first step in monitoring their activity.

When a governing tenant admin signs in to your governed tenant:

- **User display name** in sign-in logs and audit logs appears as: **"{Governing tenant name} Technician"**. For example, if the governing tenant is named "Contoso IT," the display name shows as "Contoso IT Technician."

- **Username** appears in the format: **user_{user object ID in the governing tenant without dashes}**. For example, `user_a1b2c3d4e5f6a1b2c3d4e5f6a1b2c3d4`.

## Review sign-in logs for governing tenant admin activity

Use sign-in logs to monitor when and how governing tenant administrators sign in to your governed tenant.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Reports Reader](~/identity/role-based-access-control/permissions-reference.md#reports-reader).

1. Browse to **Identity** > **Monitoring & health** > **Sign-in logs**.

1. To filter for governing tenant admin sign-ins, select **Add filters**.

1. Select the **User** filter, and enter **Technician** as the search term to find entries matching the "{Governing tenant name} Technician" display name format.

1. Select **Apply** to view the filtered results.

1. Select a sign-in entry to view details, including:

   - **Date and time** of the sign-in.
   - **Application** the admin accessed.
   - **Status** indicating whether the sign-in succeeded or failed.
   - **Conditional Access** policies that Microsoft Entra evaluated or applied.

## Review audit logs for governing tenant admin actions

Use audit logs to track the specific actions and changes that governing tenant administrators make in your governed tenant.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Reports Reader](~/identity/role-based-access-control/permissions-reference.md#reports-reader).

1. Browse to **Identity** > **Monitoring & health** > **Audit logs**.

1. To filter for actions performed by governing tenant admins, select **Add filters**.

1. Select the **Initiated by (actor)** filter. This filter uses a **startsWith** match, so enter the governing tenant's name (for example, **Contoso IT**) to find entries where the actor starts with "{Governing tenant name}" and matches the "{Governing tenant name} Technician" display name format.

1. Select **Apply** to view the filtered results.

1. Review the audit entries, which include:

   - **Activity** describing the action the admin performed (for example, "Update user," "Add member to role").
   - **Date and time** the action occurred.
   - **Target resource(s)** that the admin modified.
   - **Result** indicating whether the action succeeded or failed.

1. Select an individual entry to view the full details, including which properties changed and their old and new values.

## Related content

- [Use cross-tenant delegated administration](how-to-delegated-administration.md)
- [Set up a governance relationship](how-to-setup-governance-relationship.md)
- [Governance policy templates](governance-policy-templates.md)
- [What are Microsoft Entra sign-in logs?](/entra/identity/monitoring-health/concept-sign-ins)
- [What are Microsoft Entra audit logs?](/entra/identity/monitoring-health/concept-audit-logs)
- [How to integrate Microsoft Entra logs with Azure Monitor logs](/entra/identity/monitoring-health/howto-integrate-activity-logs-with-azure-monitor-logs)
