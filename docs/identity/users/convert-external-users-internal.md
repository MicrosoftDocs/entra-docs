---
title: Convert external users to internal users (Preview)
description: You can convert users from external to internal without the need to recreate them.
author: barclayn
ms.author: barclayn
manager: amycolannino
ms.date: 04/29/2024
ms.topic: how-to
ms.service: entra-id
ms.subservice: users
ms.workload: identity
ms.custom: 
ms.reviewer: yuank
---

# Convert external users to internal users (Preview)

Enterprises going through reorganizations, mergers, and acquisitions may be forced to change the way they work with some or all of their existing users. In some cases, administrators need to change existing external users into internal ones. External user conversion handles the conversion of external users into internal members without the need to delete  existing user objects and create new ones. The preservation of the user objects allows users to keep their original account and their access isn’t disrupted. A converted user's account maintains its history of activities intact as their relationship with the host organization changes.

- **Internal users** are users who authenticate with the local tenant.
- **External users** are users who authenticate via a method not managed by the host organization, such as another organization's Microsoft Entra ID, Google federation, or Microsoft account. Many external users have a ***userType*** of 'guest', but there's no formal relation between ***userType**** and how a user signs in. External users who have a ***userType*** of 'member', could also be eligible for conversion.

External user conversion can be performed using Microsoft Graph API or the Microsoft Entra ID Portal.

## Converting external users

It is important to note that a userType of member vs guest doesn't indicate where a user authenticates. Member vs guest only defines the level of permissions the user has in the current tenant. You can update the user type for your users, but that alone doesn't change the users' external vs internal state.

### Cloud user conversion

When a cloud user is converted from external to internal, administrators must specify a UPN and password for the user. This ensures the user can authenticate with the current tenant.

### Synced user conversion

In this document, when we say 'Synced user', we mean users synced from on-premises. As these accounts are managed at the source, administrators are unable to specify the UPN for these users.

- Synced users where the tenant uses federated authentication
  - If Password Hash Sync (PHS) is enabled, administrators are blocked from setting a new password during conversion. 
  - if the federated tenant doesn't have PHS enabled, administrators have the option to set a password.
- In cases where the tenant is managed, meaning it uses cloud authentication, administrators are required to specify a password during conversion.

## Testing external user conversion

When testing external user conversion, we recommend that you use test accounts or accounts that wouldn't create a disruption if they were to become unavailable.

### Requirements

- Converting external users requires an account with at least the [user administrator](~/identity/role-based-access-control/permissions-reference.md#user-administrator)
role assigned.
- Only users configured with an authentication method external to the host organization are eligible for conversion. 

### Converting an External user

You can convert external users to internal using the Microsoft Entra admin center. 

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [User Administrator](~/identity/role-based-access-control/permissions-reference.md#user-administrator).

1. Browse to **Identity** > **Users** > **All users**.

1. Select an external user.
1. As shown in the image, select **Convert to internal user**

    :::image type="content" source="media/convert-external-users-internal/user-properties.png" alt-text="Screenshot showing the user properties with a red box around the Convert to Internal user option.":::

1. In the **Convert to internal user** section, you need to finalize a couple of steps:
    1. A **user principal name**, This value is the new UPN value for the user. For cloud-only users, the UPN domain must be one that is nonfederated. For on-premises synced users, you don't need to provide a UPN. The user continues to use the on-premises credentials.
    1. Choose whether you would like an auto generated password
    1. Checkbox for **Change email address**, allows you to specify an optional new mail address for cloud users.
1. After reviewing the options and making and choices, you can choose **Convert**.

    :::image type="content" source="media/convert-external-users-internal/convert.png" alt-text="Screenshot showing the last set of options that must be chosen prior to converting an external user to an internal user.":::


## Related content

- [User management enhancements](users-search-enhanced.md)
- [user: convertExternalToInternalMemberUser Microsoft Graph API](/graph/api/user-convertexternaltointernalmemberuser)