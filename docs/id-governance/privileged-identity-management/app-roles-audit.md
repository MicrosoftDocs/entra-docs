---
title: View app role audit history in PIM (preview)
description: Learn how to view application-level and personal app role audit history in Microsoft Entra Privileged Identity Management during preview.
ms.topic: how-to
ms.date: 10/29/2026
ms.custom: pim, msecd-doc-authoring-1031
ai-usage: ai-generated
#Customer Intent: As an administrator or assignee, I want to view app role audit history so that I can investigate assignment changes and review my role activity.
---

# View app role audit history in Privileged Identity Management (preview)

Microsoft Entra Privileged Identity Management (PIM) for app roles is in preview. Use resource and personal audit history to investigate app role assignment changes, activation activity, and role-setting changes.

<a name="overview"></a>

## Prerequisites

PIM for app roles (preview) requires Microsoft Entra ID Governance licenses.

To view **Resource audit**, you must own the target service principal or have one of the administrative roles listed in [Role assignment conditions](app-roles-assign.md#permissions).

## View resource audit history

Use **Resource audit** to investigate the app role activity recorded for the selected application.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com).
1. Browse to **ID Governance** > **Privileged Identity Management** > **App Roles (Preview)**.
1. Select the application you want to view audit history for.
1. Expand **Activity**, and then select **Resource audit**.
1. Use **Time span**, **Audit type**, **Original requestor**, and **Subject type** to narrow the results.
1. Use **Search by requestor, resource, primary target or subject** to find relevant entries.
1. Review the **Time**, **Requestor**, **Action**, **Resource name**, **Primary target**, **Subject**, and **Status** columns.
1. Select an entry to open **Audit details**. Review its **Action**, **Status**, and **Status Reason**, together with the other available details.
1. Select **Close** to return to the list. Use **Refresh** to reload the audit view.

**Audit details** includes **Date**, **Requestor**, **Action**, **Resource**, **Scope**, **Primary target**, **Subject**, **Type**, **Reason**, **Ticket system**, **Ticket number**, **Status**, **Status Reason**, and **Correlation ID**. Some fields can be empty or show a dash for a particular event.

## View my audit

Use **My audit** to review app role activity associated with your account for the selected application.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com).
1. Browse to **ID Governance** > **Privileged Identity Management** > **App Roles (Preview)**.
1. Select the application you want to view audit history for.
1. Expand **Activity**, and then select **My audit**.
1. Set **Time span** to **Last day**, **Last week**, **Last month**, or **Custom**.
1. Use **Audit type** to choose **All**, **Eligible**, **Assigned**, **Activated**, or **Active (Assigned + Activated)**.
1. Use **Subject type** and **Search by requestor, resource, primary target or subject** to narrow the results.
1. Select an entry to inspect **Audit details**. Review the recorded action, status, and other available fields, and select **Close** when you finish.

## Export audit history

The audit toolbar provides **Export**. The following steps describe the **Export Audits** dialog shown from **My audit**.

1. Open **My audit**, and select **Export**.
1. Under **Select the format of file**, choose **CSV** or **JSON**.
1. Enter **Name of the file**.
1. Select **Start** to begin the export.



## Next steps

- [Assign app roles in PIM (preview)](app-roles-assign.md).
- [Activate app roles in PIM (preview)](app-roles-activate.md).
