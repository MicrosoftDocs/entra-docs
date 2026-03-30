---
title: Reset a user's password
description: Instructions about how to reset a user's password using Microsoft Entra ID.
ms.topic: how-to
ms.date: 08/27/2025
ms.reviewer: jeffsta
ms.custom: ge-structured-content-pilot, sfi-image-nochange
---

# Reset a user's password



## Overview

Administrators can reset a user's password if the user forgets the password, if the user gets locked out, or if the user never received a password.

> [!NOTE]
> If you're not an administrator and you need instructions on how to reset your own work or school password, see [Reset your work or school password](https://support.microsoft.com/account-billing/reset-your-work-or-school-password-using-security-info-23dde81f-08bb-4776-ba72-e6b72b9dda9e).
>
> Unless your tenant is the home directory for a user, you can't reset their password. This means that if your user is signing in to your organization using an account from another organization, a Microsoft account, or a Google account, you also can't reset their password.
>
> If your user has a source of authority as Windows Server Active Directory, you can only reset the password if you turned on password writeback and the user domain is managed. Changing the user password for federated domains isn't supported. In this case, change the user password in the on-premises Active Directory.
>
> If your user has a source of authority as External Microsoft Entra ID, you can't reset the password. Only the user, or an administrator in that tenant, can reset the password.

## Prerequisites

You must have at least the following role to reset a user's password.

## To reset a password

Follow these steps:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Password Administrator](~/identity/role-based-access-control/permissions-reference.md#password-administrator).

1. Browse to **Entra ID** > **Users**.

1. Select the user that needs the reset, then select **Reset password**.

   The **Alain Charon - Profile** page appears with the **Reset password** option.

   :::image type="content" source="media/users-reset-password-azure-portal/user-profile-reset-password-link.png" alt-text="Screenshot of the User's profile page, with Reset password option highlighted." lightbox="media/users-reset-password-azure-portal/user-profile-reset-password-link.png":::

1. In the **Reset password** page, select **Reset password**.

   > [!NOTE]
   > When you're using Microsoft Entra ID, Microsoft Entra ID autogenerates a temporary password for the user. When using Active Directory on-premises, you create the password for the user.

1. Copy the password and give it to the user. The user must change the password during the next sign-in process.

> [!NOTE]
> The temporary password never expires. The next time the user signs in, the password still works, regardless of how much time has passed since the temporary password was generated.

> [!IMPORTANT]
> If an administrator can't reset the user's password, and the Application Event Logs on the Microsoft Entra Connect server has error code hr=80231367, review the user's attributes in Active Directory. If the attribute **AdminCount** is set to 1, this prevents an administrator from resetting the user's password. The attribute **AdminCount** must be set to 0, for administrators to reset the user's password.

<!-- preamble to the next step: <After you've reset your user's password, you can perform the following basic processes:> -->

## Related content

- [Add or delete users](./how-to-create-delete-users.yml)
- [Assign roles to users](./how-subscriptions-associated-directory.md)
- [Add or change profile information](./how-to-manage-user-profile-info.md)
