---
title: Convert external users to internal users
description: You can convert users from external to internal without the need to recreate them.
author: barclayn
ms.author: barclayn
manager: pmwongera
ms.date: 01/06/2025
ms.topic: how-to
ms.service: entra-id
ms.subservice: users
ms.workload: identity
ms.custom: sfi-image-nochange
ms.reviewer: yuank
---

# Convert external users to internal users

Enterprises, such as those going through reorganizations, mergers, and acquisitions, sometimes need to change the way they work with some or all of their existing users. In some cases, administrators need to change existing external users into internal ones. 

External user conversion handles the conversion of external users into internal users without the need to delete  existing user objects and create new ones. The preservation of the user objects allows users to keep their original account so that their access isn’t disrupted. A converted user's account maintains its history of activities intact as their relationship with the host organization changes.

- **Internal users** are users who authenticate with the local tenant.
- **External users** are users who authenticate via a method not managed by the host organization, such as another organization's Microsoft Entra ID, Google federation, or Microsoft account. Many external users have a *userType* of `guest`, but there's no formal relation between *userType* and how a user signs in. External users who have a *userType* of `member`, could also be eligible for conversion.

External user conversion can be performed using [Microsoft Graph API](https://graph.microsoft.com) or the Microsoft Entra ID Portal.

## Converting external users

It's important to understand that the *userType* for `member` versus `guest` doesn't indicate where a user authenticates; instead, it only defines the level of permissions that a user has in the current tenant. You can update the *userType* for your users, but that alone doesn't change the users' external versus internal state. To change external users to internal users, see [synced user conversion](#synced-user-conversion).

There are two types of external users that you can convert to internal:

- Cloud-only users
- Synced users 

### Cloud user conversion

When a cloud user is converted from external to internal, administrators must specify a *UPN* and *password* for the user. Converting cloud users to synced users ensures that the user can authenticate with the current tenant.

### Synced user conversion

Synced user conversion allows you to convert a user from external to internal in Microsoft Entra ID. You can use [Microsoft Entra Connect](~/identity/hybrid/connect/whatis-azure-ad-connect.md) to synchronize your on-premises identities. When you convert a user from an external user to an internal user, the source of authority for the user continues to be on-premises, but the user will authenticate as an internal user.

 *Synced user* are users synced from on-premises. As these accounts are managed at the source, administrators are unable to specify the UPN for these users.

- Synced users where the tenant has Password Hash Sync (PHS) enabled, administrators are blocked from setting a new password during conversion.
- If the tenant uses federated authentication, administrators are blocked from setting a new password for synced users during conversion
- In cases where the tenant is managed, meaning it uses cloud authentication, and the tenant doesn't have PHS enabled, administrators are required to specify a password during conversion.

## Testing external user conversions

When testing external user conversions, we recommend that you use test accounts or accounts that wouldn't create a disruption if they were to become unavailable.

### Requirements

- Converting external users to internal users requires an account with at least the [user administrator](~/identity/role-based-access-control/permissions-reference.md#user-administrator) role assigned.
- Only users configured with an authentication method external to the host organization are eligible for conversion. 

### Converting an external user

You can convert external users, such as cloud-only and synced users, to internal users using the Microsoft Entra admin center. 

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [User Administrator](~/identity/role-based-access-control/permissions-reference.md#user-administrator).

1. Browse to **Entra ID** > **Users**.

1. Select an external user.
1. Select **Convert to internal user**.

    :::image type="content" source="media/convert-external-users-internal/user-properties.png" alt-text="Screenshot showing the user properties with a red box around the Convert to Internal user option.":::

1. In the **Convert to internal user** section, you need to finalize a couple of steps:
    1. Provide a **user principal name (UPN)**. This value is the new UPN value for the user. For cloud-only users, the UPN domain must be one that is nonfederated. For on-premises synced users, you don't need to provide a UPN. The user continues to use the on-premises credentials.
    1. Check the box if you would like an autogenerated password.
    1. Check the box for **Change email address** to specify an optional new email address for cloud users.

    :::image type="content" source="media/convert-external-users-internal/convert.png" alt-text="Screenshot showing the last set of options that must be chosen prior to converting an external user to an internal user.":::

1. After reviewing the options and making your selected choices, choose **Convert**.

## Related content

- [User management enhancements](users-search-enhanced.md)
- [user: convertExternalToInternalMemberUser Microsoft Graph API](/graph/api/user-convertexternaltointernalmemberuser)
