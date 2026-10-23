---
title: Assign users and devices to traffic forwarding profiles
description: Assign users, groups, devices, and device platforms to Global Secure Access traffic forwarding profiles.
ms.topic: how-to
ms.date: 09/20/2026
ai-usage: ai-assisted
---
# Assign users and devices to traffic forwarding profiles

## Overview

You can assign specific users, groups, devices, and device platforms to a Global Secure Access traffic forwarding profile. Assignments let you deploy a profile gradually and provide different traffic acquisition rules to different users and devices.

This article explains assignments for traffic forwarding profiles, including custom Private Access profiles.

## Prerequisites

To manage assignments, you must have:

- A [Global Secure Access Administrator](../identity/role-based-access-control/permissions-reference.md#global-secure-access-administrator) role in Microsoft Entra ID to view and manage the traffic forwarding profile.
- The required Global Secure Access product licenses. For details, see [What is Global Secure Access](overview-what-is-global-secure-access.md).
- The latest supported Global Secure Access client on applicable devices. The minimum client version for user and group assignment is 1.7.376.0.

## How assignments are evaluated

A traffic forwarding profile has two assignment conditions:

- **User and device assignments** determine which users, groups, or individual devices are in scope.
- **Device platform assignments** determine which device platforms are in scope.

The conditions are evaluated with an `AND`. A device receives a profile only when it matches both conditions.

If multiple enabled profiles for the same traffic type apply to a user and device, only the applicable profile with the highest priority is used.

## Assign users, groups, and devices

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as a Global Secure Access Administrator and Application Administrator.
1. Browse to **Global Secure Access** > **Connect** > **Traffic forwarding**.
1. Select the traffic forwarding profile.
1. Select **Assignments**.
1. Next to **User and device assignments**, select **View**.
1. Select one of the following options:

   - **No users and devices**: The profile isn't assigned through the Global Secure Access client.
   - **All users and devices**: All devices with the Global Secure Access client are in scope, subject to the device-platform assignment.
   - **Selected users and devices**: Select specific users, groups, or devices.

   ![Screenshot of the Edit user and device assignments pane with All users and devices selected.](media/how-to-manage-users-groups-assignment/edit-user-device-assignments.png)

1. If you selected **Selected users and devices**, select the assignment link, choose the users, groups, and devices, and then select **Select**.
1. Select **Save**.

## Assign device platforms

1. From the profile's **Assignments** page, select **View** next to **Device platform assignments**.
1. Select the device platforms that should receive the profile.
1. Select **Save**.

You can combine platform assignment with user and device assignment. For example:

- Assign **All users and devices** and select **iOS** to apply the profile to all iOS devices with the Global Secure Access client.
- Assign a user group and select **Windows** and **macOS** to apply the profile only to desktop devices used by members of that group.

## Assignment evaluation examples

| User and device assignments | Device platform assignments | Result |
| --- | --- | --- |
| All users and devices | All device platforms | All devices with the Global Secure Access client receive the profile. |
| All users and devices | Windows and macOS | All Windows and macOS devices with the client receive the profile. |
| All users and devices | None | No devices receive the profile. |
| Five users and two devices | All device platforms | All client devices used by the five users and the two selected devices receive the profile. |
| Five users and two devices | Android | Android client devices used by the five users and the selected devices receive the profile only if those devices are Android devices. |
| No users, groups, or devices | Any platform | No devices receive the profile. |

## Assign a profile to all devices on a platform

To assign a profile to all devices on a specific platform:

1. Set **User and device assignments** to **All users and devices**.
1. Under **Device platform assignments**, select only the target platform.
1. Save both assignment settings.

## Automatic assignment through user attributes

You can assign a dynamic group whose members satisfy specific user criteria. For more information, see [Create or update a dynamic group in Microsoft Entra ID](../identity/users/groups-create-rule.md).

## Validate the effective profile

1. Sign in to a registered device as a user included in the assignment.
1. Right-click the Global Secure Access client, and then select **Advanced diagnostics** > **Forwarding profile**.
1. Expand the applicable traffic type, such as **Private Access rules**.
1. Confirm that the expected application segments appear.

If more than one profile could apply, confirm that the profile with the highest priority is effective.

## Notes about identity, groups, and devices

- Traffic profiles are fetched for the Microsoft Entra user signed in to the device, not the user signed in to the client.
- If no Microsoft Entra user is signed in, a profile is fetched only when **All users and devices** is selected.
- Multiple users signed in to the same device simultaneously aren't supported.
- Group assignment supports security groups and nested group membership is supported.

## Next steps

- [Create a Private Access traffic forwarding profile](how-to-create-traffic-forwarding-profile.md)
- [Manage Private Access traffic forwarding profiles](how-to-manage-private-access-profile.md)
- [Learn about Global Secure Access clients](concept-clients.md)
