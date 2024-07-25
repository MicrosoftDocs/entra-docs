---
title: Activate your group membership or ownership in Privileged Identity Management
description: Learn how to activate your group membership or ownership in Privileged Identity Management (PIM).

author: barclayn
manager: amycolannino
ms.service: entra-id-governance
ms.topic: how-to
ms.subservice: privileged-identity-management
ms.date: 09/12/2023
ms.author: barclayn
ms.reviewer: ilyal
ms.custom: pim

---

# Activate your group membership or ownership in Privileged Identity Management

You can use Privileged Identity Management (PIM) In Microsoft Entra ID to have just-in-time membership in the group or just-in-time ownership of the group.

This article is for eligible members or owners who want to activate their group membership or ownership in PIM.

>[!IMPORTANT]
>When a group membership or ownership is activated, Microsoft Entra PIM temporarily adds an active assignment. Microsoft Entra PIM creates an active assignment (adds user as member or owner of the group) within seconds. When deactivation (manual or through activation time expiration) happens, Microsoft Entra PIM removes user’s group membership or ownership within seconds as well.
>
>Application may provide access to users based on their group membership. In some situations, application access may not immediately reflect the fact that user was added to the group or removed from it. If application previously cached the fact that user is not member of the group – when user tries to access application again, access may not be provided. Similarly, if application previously cached the fact that user is member of the group – when group membership is deactivated, user may still get access. Specific situation depends on the application’s architecture. For some applications, signing out and signing back in may help to get access added or removed.

## Activate a role

When you need to take on a group membership or ownership, you can request activation by using the **My roles** navigation option in PIM.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Privileged Role Administrator](~/identity/role-based-access-control/permissions-reference.md#privileged-role-administrator).

1. Browse to **Identity governance** > **Privileged Identity Management** > **My roles** > **Groups**. 
    >[!NOTE]
    > You may also use this [short link](https://aka.ms/pim) to open the **My roles** page directly.

1. Using **Eligible assignments** blade, review the list of groups that you have eligible membership or ownership for.

    :::image type="content" source="media/pim-for-groups/pim-group-6.png" alt-text="Screenshot of the list of groups that you have eligible membership or ownership for." lightbox="media/pim-for-groups/pim-group-6.png":::

1. Select **Activate** for the eligible assignment you want to activate.

1. Depending on the group’s setting, you may be asked to provide multi-factor authentication or another form of credential.

1. If necessary, specify a custom activation start time. The membership or ownership is to be activated only after the selected time.

1. Depending on the group’s setting, justification for activation may be required. If needed, provide the justification in the **Reason** box.

    :::image type="content" source="media/pim-for-groups/pim-group-7.png" alt-text="Screenshot of where to provide a justification in the Reason box." lightbox="media/pim-for-groups/pim-group-7.png":::

1. Select **Activate**.

If the [role requires approval](pim-resource-roles-approval-workflow.md) to activate, an Azure notification appears in the upper right corner of your browser informing you the request is pending approval.

## View the status of your requests

You can view the status of your pending requests to activate. It is important when your requests undergo approval of another person.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com).

1. Browse to **Identity governance** > **Privileged Identity Management** > **My requests** **Groups**. 

1. Review list of requests.

    :::image type="content" source="media/pim-for-groups/pim-group-8.png" alt-text="Screenshot of where to review the list of requests." lightbox="media/pim-for-groups/pim-group-8.png":::


## Cancel a pending request

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com).

1. Browse to **Identity governance** > **Privileged Identity Management** > **My requests** **Groups**. 

    :::image type="content" source="media/pim-for-groups/pim-group-8.png" alt-text="Screenshot of where to select the request you want to cancel." lightbox="media/pim-for-groups/pim-group-8.png":::

1. For the request that you want to cancel, select **Cancel**.

When you select **Cancel**, the request is canceled. To activate the role again, you have to submit a new request for activation.

## Next steps

- [Approve activation requests for group members and owners](groups-approval-workflow.md)
