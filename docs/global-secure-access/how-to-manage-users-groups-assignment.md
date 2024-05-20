---
title: Assigning users and groups to traffic forwarding profiles
description: Learn how to roll out traffic forwarding profiles to users and groups with Global Secure Access (preview)
author: kenwith
ms.author: kenwith
manager: amycolannino
ms.topic: how-to
ms.date: 05/20/2024
ms.service: global-secure-access
---
# How to assign users and groups to traffic forwarding profiles

Assign specific users and groups to a traffic forwarding profile. User or group assignment limits the scope of the traffic forwarding profile so you have a mechanism to roll out the profile safely and at a controlled pace.

## Prerequisites

To assign a traffic forwarding profile to specific users and groups, you must have:

- A [**Global Secure Access Administrator**](/azure/active-directory/roles/permissions-reference#global-secure-access-administrator) role in Microsoft Entra ID to view the traffic forwarding profile.
- An [**Application Administrator**](../identity/role-based-access-control/permissions-reference.md#application-administrator) role to assign the traffic profile to the selected users and groups.
- The preview requires a Microsoft Entra ID P1 license. If needed, you can [purchase licenses or get trial licenses](https://aka.ms/azureadlicense).
- The minimum required Global Secure Access client version is 1.7.376.0. Clients below this version won't receive the traffic forwarding profile when assigned to the user.

## Assign a traffic forwarding profile to specific users and groups

Global Secure Access traffic forwarding profiles default to all users being assigned the traffic profile. To scope the traffic profile to a specific user or group:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as a [Global Secure Access Administrator](/azure/active-directory/roles/permissions-reference#global-secure-access-administrator) AND [Application Administrator](../identity/role-based-access-control/permissions-reference.md#application-administrator).

1. Browse to **Global Secure Access** > **Connect** > **Traffic forwarding**.

1. Select the **View** link in the **user and group assignments** section.

    ![Screenshot of the traffic forwarding profiles with the view link highlighted.](media/how-to-manage-users-groups-assignment/traffic-profile-view-user-group-assignments.png)

1. Change the **Assign to all users** toggle to **No**, review the confirmation message, and select the **OK** button.

1. Select the **0 Users, 0 Groups assigned** link.

    ![Screenshot of the 0 users, 0 groups assigned link.](media/how-to-manage-users-groups-assignment/user-group-assignment-link.png)

1. Select **Add user/group**.
    - The default list groups users and groups together but you can select either the **Users** or **Groups** tab to view one or the other.
    - You can also use the Search box to find the user or group directly.

    ![Screenshot of the users and groups page with the Add user/group button highlighted.](media/how-to-manage-users-groups-assignment/traffic-profile-add-user-group-button.png)

1. Select the **None selected** link, select the users and/or groups from the list, and select the **Select** button.

    ![Screenshot of the user/group selection process with the None selected link highlighted.](media/how-to-manage-users-groups-assignment/user-group-selection-steps.png)

1. Select the **Assign** button.

> [!NOTE]
> When you enable a traffic forwarding profile, zero users and groups are assigned by default. This default setting lets you slowly roll out the feature in a controlled manner.

### Automatic assignment using user attributes

You can create and assign a dynamic group of users to the profile who satisfy specific criteria. To learn more about automatic assignment using user attributes, see [Create or update a dynamic group in Microsoft Entra ID](../identity/users/groups-create-rule.md).

## Assign the traffic profile to all users

Once you assign a traffic forwarding profile to a specific user or group, you can quickly change the setting to scope the traffic profile to all users and back again to a specific group. Any users and groups assigned to that traffic forwarding profile are retained so you don't need to add them again. 

1. Browse to **Global Secure Access** > **Connect** > **Traffic forwarding**.

1. Select the **View** link in the **user and group assignments** section.

1. Change the **Assign to all users** toggle to **Yes**, review the confirmation message, and select the **OK** button.

    ![Screenshot of the assign to all users confirmation message.](media/how-to-manage-users-groups-assignment/toggle-confirmation-message.png)

1. Select the **Done** button.

### Revert all users assignment back to a specific user or group

You can revert the assignment of all users to a traffic profile. When you toggle off the assignment for all users, you revert to the users and groups that were assigned when you toggled it on.

1. Browse to **Global Secure Access** > **Connect** > **Traffic forwarding**.

1. Select the **View** link in the **user and group assignments** section.

1. Change the **Assign to all users** toggle to **No**, review the confirmation message, and select the **OK** button.

1. Select **Done**. 

## Notes on user identity and group assignment

Review the following notes to better understand the user and group assignment capabilities.

- Traffic profiles are fetched on behalf of the Microsoft Entra user logged into the device​, not the user logged into the client​. 
- If there's no Microsoft Entra user logged in, the traffic profile is fetched only if it's assigned to all users. For example, if you log into the device as a local admin you're part of the all users.
- Multiple users logging into the same device simultaneously isn't supported.
- Group-based assignment is supported for Security groups and Microsoft 365 groups whose `SecurityEnabled` setting is set to `True`.
- Nested group memberships aren't supported. A user must be a direct member of the group assigned to the profile. 

## Next steps

- [Learn about Global Secure Access clients](concept-clients.md)
