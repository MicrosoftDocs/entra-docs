---
title: Add sponsors to a guest user in the Microsoft Entra admin center - External ID
description: Shows how an admin can add sponsors to guest users in Microsoft Entra B2B collaboration.
ms.service: entra-external-id
ms.topic: how-to
ms.date: 12/12/2024
ms.author: cmulligan
author: csmulligan
manager: dougeby
ms.collection: M365-identity-device-management
ms.custom: sfi-image-nochange
# Customer intent: As a B2B organization administrator, I want to track and manage sponsors for guest users, so that I can ensure accountability and proper governance of external partners in my directory.
---
# Sponsors field for B2B users

[!INCLUDE [applies-to-workforce-only](./includes/applies-to-workforce-only.md)]

The sponsor feature helps you manage B2B users in your directory. It allows tracking of who is responsible for each guest user. While [entitlement management](/entra/id-governance/entitlement-management-overview) can track guests in certain domains, it doesn't include guests outside these areas. By using the sponsor feature, you can assign a person or group to each guest user. This helps track who invited them and supports accountability.  

This article provides an overview of the sponsor feature and explains how to use it in B2B scenarios.

## Sponsors field on the user object

The **Sponsors** field on the user object refers to the person or group who manages and monitors the lifecycle of the user, ensuring they have access to the right resources.
Being a sponsor doesn't grant administrative powers for the sponsor user or the group, but it can be used for approval processes in entitlement management. You can also use it for custom solutions, but it doesn't offer any other built-in directory powers.

:::image type="content" source="media/b2b-sponsors/single-sponsor.png" alt-text="Screenshot of the sponsors' name.":::

## Who can be a sponsor?

If you invite a guest user, you automatically become their sponsor unless you specify someone else during the invitation process. Your name will be added to the **Sponsors** field on the user object automatically. You can also specify a different sponsor, a person, or a group when inviting a guest user.
If a sponsor leaves the organization, the tenant administrator can change the **Sponsors** field to a different person or group during offboarding. This transition ensures the guest user's account remains properly tracked.  

## Other scenarios using the B2B sponsors feature

The Microsoft Entra B2B collaboration sponsor feature serves as a foundation for other scenarios that aim to provide a full governance lifecycle for external partners. These scenarios aren't part of the sponsor feature but rely on it for managing guest users:

- Administrators can transfer sponsorship to another user or group, if the guest user starts working on a different project.
- When requesting new access packages, sponsors can be added as approvers in entitlement management to help reduce reviewers' workload.

## Add sponsors when inviting a new guest user

You can add up to five sponsors when inviting a new guest user. If you don’t specify a sponsor, the inviter will be added as a sponsor. To invite a guest user, you need to have at least the [Guest Inviter](/entra/identity/role-based-access-control/permissions-reference#guest-inviter) or [User Administrator](/entra/identity/role-based-access-control/permissions-reference#user-administrator) role.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [User Administrator](~/identity/role-based-access-control/permissions-reference.md#user-administrator).
1. Browse to **Entra ID** > **Users**.
1. Select **New user** > **Invite external user** from the menu.
1. Entered the details on the Basics tab and select **Next: Properties**.
1. You can add sponsors under  **Job information** on the **Properties** tab.

   :::image type="content" source="media/b2b-sponsors/add-sponsors.png" alt-text="Screenshot showing the Add sponsor option.":::

1. Select the **Review and invite** button to finalize the process.

You can also add sponsors with the Microsoft Graph API, using invitation manager for any new guest users, by including them in the payload. If there are no sponsors in the payload, the inviter will be marked as the sponsor. To learn more, see [Assign sponsors](/graph/api/user-post-sponsors).

   > [!NOTE]
   > Currently, if an external user is invited through SharePoint (for example, when sharing a file with a non-existing external user), sponsors will not be added to that external user. This is a known issue. For now, you can manually add sponsors by following the steps above.  

## Edit the Sponsors field in the Microsoft Entra admin center

When you invite a guest user, you became their sponsor by default. If you need to manually change the guest user's sponsor, follow these steps:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [User Administrator](~/identity/role-based-access-control/permissions-reference.md#user-administrator).
1. Browse to **Entra ID** > **Users**.
1. In the list, select the user's name to open their user profile
1. Under **Properties** > **Job information** check the **Sponsors** field. If the guest user already has a sponsor, you can select **View** to see the sponsor's name.

   :::image type="content" source="media/b2b-sponsors/sponsors-under-properties.png" alt-text="Screenshot of the sponsors field under the job information.":::

1. Close the window with the sponsor name list, if you want to edit the **Sponsors** field.
1. There are two ways to edit the **Sponsors** field. Either select the pencil icon next to the **Job Information**, or select **Edit properties** from the top of the page and go to the **Job Information** tab.
1. If the user has only one sponsor, you can see the sponsor's name. If the user has multiple sponsors, you can't see the individual names:

   :::image type="content" source="media/b2b-sponsors/multiple-sponsors.png" alt-text="Screenshot of multiple sponsors option.":::

1. To add or remove sponsors, select **Edit**, select or remove the users or groups, and select **Save** on the **Job Information** tab.
1. If the guest user doesn't have a sponsor, select **Add sponsors**.

   :::image type="content" source="media/b2b-sponsors/add-sponsors-existing-user.png" alt-text="Screenshot of adding a sponsor to an existing user.":::

1. Once you selected sponsor users or groups, save the changes on the **Job Information** tab.

## Edit the Sponsors field with PowerShell

You can manage the **Sponsors** field for all existing users using the [Update-MsIdInvitedUserSponsorsFromInvitedBy](https://azuread.github.io/MSIdentityTools/commands/Update-MsIdInvitedUserSponsorsFromInvitedBy) PowerShell script in the [Microsoft Identity Tools module](https://azuread.github.io/MSIdentityTools). The script updates the sponsors attribute to include the user who initially invited them to the tenant using the `InvitedBy` property.

## Related content

- [Add and invite guest users](add-users-administrator.yml)
- [Create a new access package](~/id-governance/entitlement-management-access-package-create.md)
- [Manage user profile info](~/fundamentals/how-to-manage-user-profile-info.md)
