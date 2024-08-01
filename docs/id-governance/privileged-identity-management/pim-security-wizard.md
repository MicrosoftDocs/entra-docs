---
title: Microsoft Entra roles Discovery and insights (preview) in Privileged Identity Management former Security Wizard
description: Discovery and insights (formerly Security Wizard) help you convert permanent Microsoft Entra role assignments to just-in-time assignments with Privileged Identity Management.

author: barclayn
manager: amycolannino

ms.service: entra-id-governance
ms.topic: how-to
ms.subservice: privileged-identity-management
ms.date: 09/13/2023
ms.author: barclayn
ms.reviewer: shaunliu
ms.custom: pim ; H1Hack27Feb2017

---

# Discovery and Insights (preview) for Microsoft Entra roles (formerly Security Wizard)

If you're starting out using Privileged Identity Management (PIM) in Microsoft Entra ID to manage role assignments in your organization, you can use the **Discovery and insights (preview)** page to get started. This feature shows you who is assigned to privileged roles in your organization and how to use PIM to quickly change permanent role assignments into just-in-time assignments. You can view or make changes to your permanent privileged role assignments in **Discovery and Insights (preview)**. It's an analysis tool and an action tool.

## Discovery and insights (preview)

Before your organization starts using Privileged Identity Management, all role assignments are permanent. Users are always in their assigned roles even when they don't need their privileges. Discovery and insights (preview), which replaces the former Security Wizard, shows you a list of privileged roles and how many users are currently in those roles. You can list out assignments for a role to learn more about the assigned users if one or more of them are unfamiliar.

:heavy_check_mark: [!INCLUDE [emergency-access-accounts](../../includes/definitions/emergency-access-accounts.md)]

Also, keep role assignments permanent if a user has a Microsoft account (in other words, an account they use to sign in to Microsoft services like Skype, or Outlook.com). If you require multi-factor authentication for a user with a Microsoft account to activate a role assignment, the user will be locked out.

## Open Discovery and insights (preview)

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Privileged Role Administrator](~/identity/role-based-access-control/permissions-reference.md#privileged-role-administrator).

1. Browse to **Identity governance** > **Privileged Identity Management** > **Microsoft Entra roles** >**Discovery and insights (Preview)**.

1. Opening the page begins the discovery process to find relevant role assignments.

    :::image type="content" source="./media/pim-security-wizard/new-preview-link.png" alt-text="Screenshot showing Microsoft Entra roles Discovery and insights page.":::

1. Select **Reduce Global Administrators**.

    :::image type="content" source="./media/pim-security-wizard/new-preview-page.png" alt-text="Screenshot that shows the Discovery and insights (Preview) with the Reduce Global Administrators action selected.":::

1. Review the list of Global Administrator role assignments.

    :::image type="content" source="./media/pim-security-wizard/new-global-administrator-list.png" alt-text="Screenshot showing the Roles pane showing all Global Administrators.":::

1. Select **Next** to select the users or groups you want to make eligible, and then select **Make eligible** or **Remove assignment**.

    :::image type="content" source="./media/pim-security-wizard/new-global-administrator-buttons.png" alt-text="Screenshot showing how to convert members to eligible page with options to select members you want to make eligible for roles.":::

1. You can also require all Global Administrators to review their own access.

    :::image type="content" source="./media/pim-security-wizard/new-global-administrator-access-review.png" alt-text="Screenshot showing the Global Administrators page showing the access reviews section.":::

1. After you select any of these changes, you'll see an Azure notification.

1. You can then select **Eliminate standing access** or **Review service principals** to repeat the above steps on other privileged roles and on service principal role assignments. For service principal role assignments, you can only remove role assignments.

    :::image type="content" source="./media/pim-security-wizard/new-preview-page-service-principals.png" alt-text="Screenshot showing additional insights options to eliminate standing access and review service principals.":::

## Next steps

- [Assign Microsoft Entra roles in Privileged Identity Management](pim-how-to-add-role-to-user.md)
