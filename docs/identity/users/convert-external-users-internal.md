---
title: Convert external users to internal users (Preview)
description: You can convert users from external to internal without the need to recreate them.
services: active-directory 
author: barclayn
ms.author: barclayn
manager: amycolannino
ms.date: 02/07/2024
ms.topic: how-to
ms.service: active-directory
ms.subservice: enterprise-users
ms.workload: identity
ms.custom: 
ms.reviewer: yuank

---

# Convert external users to internal users (Preview)

Enterprises go through reorganizations, mergers and acquisitions typically require a change in the way you work with some or all of your existing users. In some cases, you could need to change existing external users into internal ones. External user conversion enables administrators to turn external users to internal members without the need to delete the existing user object and create new one. Keeping the original object ensures the 
user’s account and access isn’t disrupted and that their history of activities remains intact as their relationship with the host organization changes

- **Internal users** are users who authenticate with the local tenant.
- **External users** are users who authenticate via a method not managed by the host organization, such as another organization's Microsoft Entra ID, Google federation, or Microsoft account. Many external users have a ***userType*** of 'guest', but there's no formal relation between ***userType**** and how a user signs in. External users who have a ***userType*** of 'member', could also be eligible for conversion.

External user conversion can be performed using MS Graph API or the Microsoft Entra ID Portal.

## Converting external users

It is important to note that a userType of member vs guest doesn't indicate where a user authenticates. Member vs guest only defines the level of permissions the user has in the current tenant. Customers can update the user type for their users, but that alone doesn't change the users' external vs internal state.

### Cloud user conversion

When a cloud user is converted from external to internal, administrators must specify a UPN and password for the user. This ensures the user can authenticate with the current tenant.

### Synced user conversion

For on-premises synced users the administrator is unable to specify the UPN because on-premiss synced users are managed on-premises. 

- Synced users where the tenant uses federated authentication
  - If Password Hash Sync (PHS) is enabled, administrators are blocked from setting a new password during conversion. 
  - if the federated tenant doesn't have PHS enabled, administrators have the option to set a password.
- In cases where the tenant is managed, meaning it uses cloud authentication, administrators are required to specify a password during conversion.

## Testing external user conversion

When testing external user conversion, it is recommended to use test accounts or accounts that wouldn't create a disruption if they are unavailable.

### Requirements

- Converting external users requires an account with at least the [user administrator](~/identity/role-based-access-control/permissions-reference.md#user-administrator)
role assigned.
- Only users configured with an authentication method external to the host organization are eligible for conversion. 

### Converting an External user

You can convert external users to internal using the Microsoft Entra admin center. 

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [User Administrator](~/identity/role-based-access-control/permissions-reference.md#user-administrator).

1. Browse to **Identity** > **Users** > **All users**.

1. Select an external user.
1. As shown in the image below, select **Convert to internal user**

:::image type="content" source="media/convert-external-users-internal/user-properties.png" alt-text="Screenshot showing the user properties with a red box around the Convert to Internal user option":::

1. In the **Convert to internal user** section, you need to finalize a couple of steps:
    1. A **user principal name**, This value will be the new UPN value for the user. For cloud-only users, the UPN domain must be one that is nonfederated. For on-premises synced users, you don't need to provide a UPN. The user continues to use the on-premises credentials. 
    1. Choose whether you would like an auto generated password
    1. Checkbox for **Change email address**, allows you to specify an optional new mail address for cloud users.
1. After reviewing the options and making and choices, you can choose **Convert**

:::image type="content" source="media/convert-external-users-internal/convert.png" alt-text="Screenshot showing the last set of options that must be chosen prior to converting an external user to an internal user":::


