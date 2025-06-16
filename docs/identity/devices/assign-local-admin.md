---
title: How to manage local administrators on Microsoft Entra joined devices
description: Learn how to assign Azure roles to the local administrators group of a Windows device.
ms.service: entra-id
ms.subservice: devices
ms.topic: how-to
ms.date: 06/27/2024
ms.author: owinfrey
author: owinfreyATL
manager: dougeby
ms.reviewer: 
ms.custom: sfi-ga-nochange
#Customer intent: As an IT admin, I want to manage the local administrators group assignment during a Microsoft Entra join, so that I can control who can manage Microsoft Entra joined devices
---
# How to manage the local administrators group on Microsoft Entra joined devices

To manage a Windows device, you need to be a member of the local administrators group. As part of the Microsoft Entra join process, Microsoft Entra ID updates the membership of this group on a device. You can customize the membership update to satisfy your business requirements. A membership update is, for example, helpful if you want to enable your helpdesk staff to do tasks requiring administrator rights on a device.

This article explains how the local administrators membership update works and how you can customize it during a Microsoft Entra join. The content of this article doesn't apply to **Microsoft Entra hybrid joined** devices.

## How it works

At the time of Microsoft Entra join, the following security principals are added to the local administrators group on the device:

- The [Microsoft Entra Joined Device Local Administrator](../role-based-access-control/permissions-reference.md#microsoft-entra-joined-device-local-administrator) and the [Global Administrator](../role-based-access-control/permissions-reference.md#global-administrator) roles
- The user performing the Microsoft Entra join

> [!NOTE]
> This is done during the join operation only. If an administrator makes changes after this point they will need to update the group membership on the device.

By adding users to the Microsoft Entra Joined Device Local Administrator role, you can update the users that can manage a device anytime in Microsoft Entra ID without modifying anything on the device. The Microsoft Entra Joined Device Local Administrator role is added to the local administrators group to support the principle of least privilege.

## Manage administrator roles

To view and update the membership of an [administrator role](../role-based-access-control/permissions-reference.md) role, see:

- [View all members of an administrator role in Microsoft Entra ID](../role-based-access-control/view-assignments.md)
- [Assign a user to administrator roles in Microsoft Entra ID](../role-based-access-control/manage-roles-portal.md)

## Manage the Microsoft Entra Joined Device Local Administrator role

You can manage the [Microsoft Entra Joined Device Local Administrator](~/identity/role-based-access-control/permissions-reference.md#microsoft-entra-joined-device-local-administrator) role from **Device settings**.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Privileged Role Administrator](~/identity/role-based-access-control/permissions-reference.md#privileged-role-administrator).
1. Browse to **Identity** > **Devices** > **All devices** > **Device settings**.
1. Select **Manage Additional local administrators on all Microsoft Entra joined devices**.
1. Select **Add assignments** then choose the other administrators you want to add and select **Add**.

To modify the Microsoft Entra Joined Device Local Administrator role, configure **Additional local administrators on all Microsoft Entra joined devices**.

> [!NOTE]
> This option requires Microsoft Entra ID P1 or P2 licenses.

Microsoft Entra Joined Device Local Administrators are assigned to all Microsoft Entra joined devices. You can't scope this role to a specific set of devices. Updating the Microsoft Entra Joined Device Local Administrator role doesn't necessarily have an immediate impact on the affected users. On devices where a user is already signed in to, the privilege elevation takes place when *both* the below actions happen:

- Up to 4 hours passed for Microsoft Entra ID to issue a new Primary Refresh Token with the appropriate privileges.
- User signs out and signs back in, not lock/unlock, to refresh their profile.

Users aren't directly listed in the local administrator group, their permissions are received through the Primary Refresh Token.

> [!NOTE]
> The above actions are not applicable to users who have not signed in to the relevant device previously. In this case, the administrator privileges are applied immediately after their first sign in to the device.

<a name='manage-administrator-privileges-using-azure-ad-groups-preview'></a>
<a name='manage-administrator-privileges-using-microsoft-entra-groups-preview'></a>

## Manage administrator privileges using Microsoft Entra groups

You can use Microsoft Entra groups to manage administrator privileges on Microsoft Entra joined devices with the [Local Users and Groups](/windows/client-management/mdm/policy-csp-localusersandgroups) mobile device management (MDM) policy. This policy allows you to assign individual users or Microsoft Entra groups to the local administrators group on a Microsoft Entra joined device, providing you with the granularity to configure distinct administrators for different groups of devices.

Organizations can use Intune to manage these policies using [Custom OMA-URI Settings](/mem/intune/configuration/custom-settings-windows-10) or [Account protection policy](/mem/intune/protect/endpoint-security-account-protection-policy). A few considerations for using this policy:

- Adding Microsoft Entra groups through the policy requires the group's security identifier (SID) that can be obtained by executing the [Microsoft Graph API for Groups](/graph/api/resources/group). The SID equates to the property `securityIdentifier` in the API response.

- Administrator privileges using this policy are evaluated only for the following well-known groups on a Windows 10 or newer device - Administrators, Users, Guests, Power Users, Remote Desktop Users, and Remote Management Users.

- Managing local administrators using Microsoft Entra groups isn't applicable to Microsoft Entra hybrid joined or Microsoft Entra registered devices.

- Microsoft Entra groups deployed to a device with this policy don't apply to remote desktop connections. To control remote desktop permissions for Microsoft Entra joined devices, you need to add the individual user's SID to the appropriate group.

> [!IMPORTANT]
> Windows sign-in with Microsoft Entra ID supports evaluation of up to 20 groups for administrator rights. We recommend having no more than 20 Microsoft Entra groups on each device to ensure that administrator rights are correctly assigned. This limitation also applies to nested groups.

## Manage regular users

By default, Microsoft Entra ID adds the user performing the Microsoft Entra join to the administrator group on the device. If you want to prevent regular users from becoming local administrators, you have the following options:

- [Windows Autopilot](/autopilot/windows-autopilot) - Windows Autopilot provides you with an option to prevent primary user performing the join from becoming a local administrator by [creating an Autopilot profile](/autopilot/enrollment-autopilot#create-an-autopilot-deployment-profile).
- [Bulk enrollment](/mem/intune/enrollment/windows-bulk-enroll) - a Microsoft Entra join that is performed in the context of a bulk enrollment happens in the context of an autocreated user. Users signing in after a device is joined aren't added to the administrators group.

## Manually elevate a user on a device

In addition to using the Microsoft Entra join process, you can also manually elevate a regular user to become a local administrator on one specific device. This step requires you to already be a member of the local administrators group.

Starting with the **Windows 10 1709** release, you can perform this task from **Settings** > **Accounts** > **Other users**. Select **Add a work or school user**, enter the user's user principal name (UPN) under **User account** and select *Administrator* under **Account type**

Additionally, you can also add users using the command prompt:

- If your tenant users are synchronized from on-premises Active Directory, use `net localgroup administrators /add "Contoso\username"`.
- If your tenant users are created in Microsoft Entra ID, use `net localgroup administrators /add "AzureAD\UserUpn"`

## Considerations

- You can only assign role based groups to the Microsoft Entra Joined Device Local Administrator role.
- The Microsoft Entra Joined Device Local Administrator role is assigned to all Microsoft Entra joined devices. This role can't be scoped to a specific set of devices.
- Local administrator rights on Windows devices aren't applicable to [Microsoft Entra B2B guest users](~/external-id/what-is-b2b.md).
- When you remove users from the Microsoft Entra Joined Device Local Administrator role, changes aren't instant. Users still have local administrator privilege on a device as long as they're signed in to it. The privilege is revoked during their next sign-in when a new primary refresh token is issued. This revocation, similar to the privilege elevation, could take up to 4 hours.

## Next steps

- To get an overview of how to manage devices, see [Managing device identities](manage-device-identities.md).
- To learn more about device-based Conditional Access, see [Conditional Access: Require compliant or Microsoft Entra hybrid joined device](~/identity/conditional-access/policy-alt-all-users-compliant-hybrid-or-mfa.md).
