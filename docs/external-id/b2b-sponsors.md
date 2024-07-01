---
title: Add sponsors to a guest user in the Microsoft Entra admin center - External ID
description: Shows how an admin can add sponsors to guest users in Microsoft Entra B2B collaboration.

 
ms.service: entra-external-id
ms.topic: how-to
ms.date: 05/03/2024

ms.author: cmulligan
author: csmulligan
manager: CelesteDG
ms.collection: M365-identity-device-management

# Customer intent: As a B2B organization administrator, I want to track and manage sponsors for guest users, so that I can ensure accountability and proper governance of external partners in my directory.
---
# Sponsors field for B2B users

[!INCLUDE [applies-to-workforce-only](./includes/applies-to-workforce-only.md)]

To ensure proper governance of B2B users in their directory, organizations need to have a system in place for tracking who oversees each guest user. Currently, [Entitlement Management](/entra/id-governance/entitlement-management-overview) provides this capability for guests within specified domains, but it doesn't extend to guests outside of these domains.
By implementing the sponsor feature, you can identify a responsible individual or group for each guest user. This allows you to track who invited the guest user and to help with accountability.

This article provides an overview of the sponsor feature and explains how to use it in B2B scenarios.

## Sponsors field on the user object

The **Sponsors** field on the user object refers to the person or group who manages and monitors the lifecycle of the user, ensuring they have access to the appropriate resources. 
Being a sponsor doesn't grant administrative powers for the sponsor user or the group, but it can be used for approval processes in Entitlement Management. You can also use it for custom solutions, but it doesn't provide any other built-in directory powers.

:::image type="content" source="media/b2b-sponsors/single-sponsor.png" alt-text="Screenshot of the sponsors' name.":::

## Who can be a sponsor?

If you send an invitation to a guest user, you'll automatically become the sponsor of that guest user, unless you specify another user in the invite process as a sponsor. Your name will be added to the **Sponsors** field on the user object automatically. If you want to add a different sponsor, you can also specify the sponsor user or group when sending an invitation to a guest user.  

You can also assign multiple people or groups when inviting the guest user. You can assign a maximum of five sponsors to a single guest user.

When a sponsor leaves the organization, as part of the offboarding process the tenant administrator can change the **Sponsors** field on the user object to a different person or group. With this transition, they can ensure that the guest user's account remains properly tracked and accounted for.

## Other scenarios using the B2B sponsors feature

The Microsoft Entra B2B collaboration sponsor feature serves as a foundation for other scenarios that aim to provide a full governance lifecycle for external partners. These scenarios aren't part of the sponsor feature but rely on it for managing guest users:

- Administrators can transfer sponsorship to another user or group, if the guest user starts working on a different project.
- When requesting new access packages, sponsors can be added as approvers to provide extra support in Entitlement Management, which can help reduce the workload on existing reviewers.

## Add sponsors when inviting a new guest user 

You can add up to five sponsors when inviting a new guest user. If you don’t specify a sponsor, the inviter will be added as a sponsor. To invite a guest user, you need to have at least the [Guest Inviter](/entra/identity/role-based-access-control/permissions-reference#guest-inviter) or [User Administrator](/entra/identity/role-based-access-control/permissions-reference#user-administrator) role. 

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [User Administrator](~/identity/role-based-access-control/permissions-reference.md#user-administrator).
1. Browse to **Identity** > **Users** > **All users**.
1. Select **New user** > **Invite external user** from the menu. 
1. Entered the details on the Basics tab and select **Next: Properties**. 
1. You can add sponsors under  **Job information** on the **Properties** tab, 
   :::image type="content" source="media/b2b-sponsors/add-sponsors.png" alt-text="Screenshot showing the Add sponsor option."::: 

1. Select the **Review and invite** button to finalize the process. 

You can also add sponsors with the Microsoft Graph API, using invitation manager for any new guest users, by passing through the payload. If there are no sponsors in the payload, the inviter will be stamped as the sponsor. To learn more about adding guest users with the Microsoft Graph API, see [Assign sponsors](/graph/api/user-post-sponsors).
 
   > [!NOTE]
   > Currently, if an external user is invited through SharePoint (for example, when sharing a file with a non-existing external user), sponsors will not be added to that external user. This is a known issue. For now, you can manually add sponsors to these external users by following the steps outlined above.

## Edit the Sponsors field

When you invite a guest user, you became their sponsor by default. If you need to manually change the guest user's sponsor, follow these steps:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [User Administrator](~/identity/role-based-access-control/permissions-reference.md#user-administrator).
1. Browse to **Identity** > **Users** > **All users**.
4. In the list, select the user's name to open their user profile
5. Under **Properties** > **Job information** check the **Sponsors** field. If the guest user already has a sponsor, you can select **View** to see the sponsor's name.
   :::image type="content" source="media/b2b-sponsors/sponsors-under-properties.png" alt-text="Screenshot of the sponsors field under the job information.":::

6. Close the window with the sponsor name list, if you want to edit the **Sponsors** field.
7. There are two ways to edit the **Sponsors** field. Either select the pencil icon next to the **Job Information**, or select **Edit properties** from the top of the page and go to the **Job Information** tab.
8. If the user has only one sponsor, you can see the sponsor's name.

   If the user has multiple sponsors, you can't see the individual names:
   :::image type="content" source="media/b2b-sponsors/multiple-sponsors.png" alt-text="Screenshot of multiple sponsors option.":::

   To add or remove sponsors, select **Edit**, select or remove the users or groups and select **Save** on the **Job Information** tab.

9. If the guest user doesn't have a sponsor, select **Add sponsors**. 
   :::image type="content" source="media/b2b-sponsors/add-sponsors-existing-user.png" alt-text="Screenshot of adding a sponsor to an existing user.":::

10. Once you selected sponsor users or groups, save the changes on the **Job Information** tab.

## Related content

- [Add and invite guest users](add-users-administrator.yml)
- [Create a new access package](~/id-governance/entitlement-management-access-package-create.md)
- [Manage user profile info](~/fundamentals/how-to-manage-user-profile-info.yml)
