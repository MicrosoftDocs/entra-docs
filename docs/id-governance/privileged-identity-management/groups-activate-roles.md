---
title: Activate your group membership or ownership in Privileged Identity Management
description: Learn how to activate eligible group membership or ownership with Microsoft Entra Privileged Identity Management (PIM).
ms.author: tamimsangrar
ms.topic: how-to
ms.date: 11/17/2026
ms.reviewer: ilyal
ms.custom: pim, msecd-doc-authoring-1032
ai-usage: ai-assisted
zone_pivot_groups: pim-activation-portals
#customer intent: As a user with eligible group membership or ownership, I want to activate my just-in-time access so that I can perform tasks that require group permissions.
---
# Activate your group membership or ownership in Privileged Identity Management

<a name="overview"></a>

You can use Privileged Identity Management (PIM) in Microsoft Entra ID to have just-in-time membership in the group or just-in-time ownership of the group.

This article is for eligible members or owners who want to activate their group membership or ownership in PIM.

Choose the portal you use to activate your group membership or ownership.

## Understand activation and deactivation

> [!IMPORTANT]
> When a group membership or ownership is activated, Microsoft Entra PIM temporarily adds an active assignment. Microsoft Entra PIM creates an active assignment (adds user as member or owner of the group) within seconds. When deactivation (manual or through activation time expiration) happens, Microsoft Entra PIM removes the user’s group membership or ownership within seconds as well.
>
> An application might provide access to users based on their group membership. In some situations, application access might not immediately reflect the fact that user was added to the group or removed from it. If application previously cached the fact that user isn't member of the group – when user tries to access application again, access might not be provided. Similarly, if application previously cached the fact that user is member of the group – when group membership is deactivated, user might still get access. Specific situation depends on the application’s architecture. For some applications, signing out and signing back in might help to get access added or removed.

## PIM for Groups and ownership deactivation

[!INCLUDE [groups-deactivation-include](../includes/groups-deactivation-include.md)]

::: zone pivot="my-access"

<a name="activate-group-membership-or-ownership-in-my-access"></a>

## Activate group membership or ownership in My Access portal

Use [**Roles**](https://aka.ms/pim/roles) under **My Access** in the [My Access portal](../my-access-portal-overview.md) to activate your eligible group membership or ownership.

Group membership and ownership activation through the My Access portal is in preview. You activate an existing eligible assignment to obtain temporary membership or ownership for your signed-in identity.

1. Sign in to the [My Access portal](https://myaccess.microsoft.com) in the tenant where you have an eligible group assignment.
1. Under **My Access**, select [**Roles**](https://aka.ms/pim/roles), and then select **Groups**.
1. Find the group and select the eligible membership or ownership assignment you need for your task.

    :::image type="content" source="media/groups-activate-roles/my-access-groups.png" alt-text="Screenshot of My Access Groups showing an eligible group membership assignment and its Activate action." lightbox="media/groups-activate-roles/my-access-groups.png":::

1. Review the activation details and complete the activation requirements shown for your membership or ownership assignment.
1. Select **Activate** to submit your activation request. If approval is required, wait for approval before using the group access.

The [ownership deactivation restriction](#pim-for-groups-and-ownership-deactivation) also applies when you activate ownership through the [My Access portal](../my-access-portal-overview.md).

## View and cancel a pending request in My Access

If you no longer need a pending membership or ownership activation, cancel the request in the My Access portal.

1. Under **My Access**, select [**Roles**](https://aka.ms/pim/roles), and then select **Groups**.
1. In the **Assignment status** dropdown, select **Pending**.
1. Find the membership or ownership request you no longer need, and select **Cancel**.

::: zone-end

::: zone pivot="entra-admin-center"

## Activate a role

When you need to take on a group membership or ownership, you can request activation by using the **My roles** navigation option in PIM.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com).

1. Browse to **ID Governance** > **Privileged Identity Management** > **My roles** > **Groups**.
    > [!NOTE]
    > You might also use this [short link](https://aka.ms/pim) to open the **My roles** page directly.

1. In the **Eligible assignments** blade, review the list of groups that you have eligible membership or ownership for.

    :::image type="content" source="media/pim-for-groups/pim-group-6.png" alt-text="Screenshot of the list of groups that you have eligible membership or ownership for." lightbox="media/pim-for-groups/pim-group-6.png":::

1. Select **Activate** for the eligible assignment you want to activate.

1. Depending on the group’s setting, you might be asked to provide multifactor authentication or another form of credential.

1. If necessary, specify a custom activation start time. The membership or ownership activates only after the selected time.

1. Depending on the group’s setting, justification for activation might be required. If needed, provide the justification in the **Reason** box.

    :::image type="content" source="media/pim-for-groups/pim-group-7.png" alt-text="Screenshot of where to provide a justification in the Reason box." lightbox="media/pim-for-groups/pim-group-7.png":::

1. Select **Activate**.

If the [role requires approval](groups-approval-workflow.md) to activate, an Azure notification appears in the upper right corner of your browser informing you the request is pending approval.

## View the status of your requests

You can view the status of your pending requests to activate. It's important when your requests undergo approval of another person.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com).

1. Browse to **ID Governance** > **Privileged Identity Management** > **My requests** > **Groups**.

1. Review the list of requests.

    :::image type="content" source="media/pim-for-groups/pim-group-8.png" alt-text="Screenshot of where to review the list of requests." lightbox="media/pim-for-groups/pim-group-8.png":::


## Cancel a pending request

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com).

1. Browse to **ID Governance** > **Privileged Identity Management** > **My requests** > **Groups**.

    :::image type="content" source="media/pim-for-groups/pim-group-8.png" alt-text="Screenshot of where to select the request you want to cancel." lightbox="media/pim-for-groups/pim-group-8.png":::

1. For the request that you want to cancel, select **Cancel**.

When you select **Cancel**, the request is canceled. To activate the role again, you have to submit a new request for activation.

::: zone-end

## Next steps

- [Approve activation requests for group members and owners](groups-approval-workflow.md)
