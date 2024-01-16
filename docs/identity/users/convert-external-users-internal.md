---
title: Convert external users to internal users (Preview)
description: You can convert users from external to internal without the need to recreate them.
services: active-directory 
author: barclayn
ms.author: barclayn
manager: amycolannino
ms.date: 01/16/2024
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

- **Internal users** are users who authenticate with the internal tenant.
- **External users** are users who authenticate via a method not managed by the host organization, such as another organization's Microsoft Entra ID, Google federation, or Microsoft account. While many external users may have a userType of 'guest', there is no formal relation between userType and how a user signs in. Some external users may have a userType of 'member', and they are also eligible for conversion.

The feature includes the ability to convert on-premises synced external users to synced internal users. When converting a cloud-only external user, the admin must specify the UPN and password for the user, to allow the user to authenticate with the host's organization. The API updates the userType from guest to member and also stamps the "externalUserConvertedOn" attribute with a datetime value indicating when the user was converted. When an on-premises synced user is converted, you can't specify UPN or password. The user continues to use the on-premises credentials, as on-premises synced user is managed on-premises.

External User Conversion can be performed using MS Graph API or the Microsoft Entra ID Portal.


>[!NOTE]
> When an external user is converted the property "convertedToInternalUserDateTime" gets stamped on their object.

## Converting external users

It is important to note that a userType of member vs guest doesn't indicate where a user authenticates. Member vs guest only defines the level of permissions the user has in the current tenant. Customers can update the user type for their users, but that alone doesn't change the users' external vs internal state.

Cloud user conversion
When a cloud user is converted from external to internal, administrators must specify a UPN and password for the user. This ensures the user can authenticate with the current tenant.

Synched user conversion
For on-premises synced users where the tenant is a managed, meaning it uses cloud authentication, administrators are required to specify a password during conversion.

For on-premises synced users where the tenant uses federated authentication and Password Hash Sync (PHS) is enabled, administrators are blocked from setting a new password during conversion. However, if the federated tenant doesn't have PHS enabled, administrators have the option to set a password.


## Testing external user conversion

When testing external user conversion we recommend, you use test accounts or accounts that wouldn't create a disruption if unavailable.

### Requirements

- Converting external users requires an account with at least the [user administrator](~/identity/role-based-access-control/permissions-reference.md#user-administrator)
role assigned.
- Only users configured with an authentication method external to the host organization are eligible for conversion. 
    - A check for eligibility is performed via an internal property that stores information regarding external sign in types. If a user isn't eligible for conversion the API or PowerShell command will return a 400 "Bad request" with a message that the user isn't eligible.
- If you are using MSGraph API from your own application, the least privileged permission is required is ‘UserConvertToInternal.ReadWrite.All” permission.

### Converting an External user


1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [User Administrator](~/identity/role-based-access-control/permissions-reference.md#user-administrator).

1. Browse to **Identity** > **Users** > **All users**.

1. Select an external user.
1. As shown in the image below, select **Convert to internal user**

:::image type="content" source="media/convert-external-users-internal/user-properties.png" alt-text="Screenshot showing the user properties with a red box around the Convert to Internal user option":::

1. In the **Convert to internal user** section, you need to finalize a couple of steps:
    1. A user principal name
    1. Choose whether you would like an auto generated password 
    1. And if you would like to change email address
1. Once that you have made these last choices, you can choose **Convert**

:::image type="content" source="media/convert-external-users-internal/convert.png" alt-text="Screenshot showing the last set of options that must be chosen prior to converting an external user to an internal user":::


## Known issues

- Currently, converted users may not be able to access Teams Shared Channels. We are working 
with the Teams team to actively resolve this issue.
- Converted users can't access Viva Engage (Yammer).
- A user can't be converted if they have a role assigned to them.

### Errors

| Scenario | Code | Message |
| --- | --- | --- |
| UserPrincipalName email domain doesn't belong to the tenant verified domain list. | 400 | The provided UPN doesn't have a valid domain. |
| UserPrincipalName is empty. | 400 | The provided UPN can't be empty. |
| Mail address email domain doesn't belong to the tenant verified domain list. | 400 | The provided UPN doesn't have a valid domain. |
| Mail address is empty "". | 400 | The mail provided can't be empty. |
| Password is invalid. | 400 | The provided password isn't valid. |
| User isn't eligible for conversion. | 400 | The user authentication is already internal and isn't eligible for conversion. |
| UserPrincipalName name and password should be empty for on-premises users | 400 | For users synchronized from on-premises, userPrincipalName and passwordProfile must be empty |
| UserState isn't accepted or pending. | 412 | If a user who was previously converted from external to internal is invited again, this error indicates the user can't be converted back to external. Search for any users in tenant matching invited email and confirm user was previously converted via externalUserConvertedOn attribute presence |


## Questions and feedback

If you have questions or feedback about external user conversion email 