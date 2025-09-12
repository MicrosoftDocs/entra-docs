---
title: Sign in with alias
description: Learn how to Sign in with alias/username with External ID for customer identity and access management (CIAM). Get detailed steps to enable username as a sign-in identifier and create users with both email address and username. 
ms.author: cmulligan
author: csmulligan
manager: dougeby
ms.service: entra-external-id 
ms.subservice: external
ms.topic: how-to
ms.date: 09/10/2025
ms.custom: it-pro

#Customer intent: As a dev, devops, or it admin, I want to learn about how to enable sign in with alias/username through the Microsoft Entra admin center and Graph API.
---
# Sign in with an alias or username (preview)

[!INCLUDE [applies-to-external-only](../includes/applies-to-external-only.md)]

You can enable users who sign in with a local account (email and password) to sign in with an alias or username in addition to their email address. This allows users to authenticate using either their email address or an alternative identifier—such as a customer ID, membership ID, insurance number, or frequent flyer number or any other unique identifier.

:::image type="content" source="media/how-to-sign-in-alias/username-login-option.png" alt-text="Screenshot of the username sign-in option in the Microsoft Entra admin center.":::

## Prerequisites

- If you haven't already created your own Microsoft Entra external tenant, [create one now](how-to-create-external-tenant-portal.md).
- [Register an app](/entra/identity-platform/quickstart-register-app)
- [Create user a flow](how-to-user-flow-sign-up-sign-in-customers.md)
- [Add your application](how-to-user-flow-add-application.md) to the user flow.

## Enable username in sign-in identifier policy

To enable username as a sign-in identifier, you must first enable the sign-in identifier policy in the Microsoft Entra admin center. Then you can create users with both email address and username as sign-in identifiers. 

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [External Identity Provider Administrator](~/identity/role-based-access-control/permissions-reference.md#external-identity-provider-administrator). <!--- NEED TO CLARIFY --->
1. If you have access to multiple tenants, use the **Settings** icon :::image type="icon" source="media/common/admin-center-settings-icon.png" border="false"::: in the top menu to switch to your external tenant from the **Directories + subscriptions** menu.
1. Browse to **Entra ID** > **External Identities** then select **Sign-in identifiers**.

   :::image type="content" source="media/how-to-sign-in-alias/sign-in-identifiers-option.png" alt-text="Screenshot of the Sign-in identifiers option in the Microsoft Entra admin center.":::

1. On the **Sign-in identifiers** page, enable **Username** as a sign-in identifier.
1. Select **Save** at the top of the page.

   :::image type="content" source="media/how-to-sign-in-alias/enable-username.png" alt-text="Screenshot of enabling username in the Sign-in identifiers option in the Microsoft Entra admin center.":::

You can also validate values of username against a custom regular expression. To do this, select **Customize** to open a modal window where you can specify up to two regular expressions. There's no validation mechanism for custom regular expressions beyond ensuring they aren't in the format of an email address. Authentication may fail at runtime if the provided value doesn't match the regex or if the regex itself is invalid.

   :::image type="content" source="media/how-to-sign-in-alias/enable-custom-username.png" alt-text="Screenshot of enabling custom username in the Sign-in identifiers option in the Microsoft Entra admin center.":::

1. Select **Save** at the bottom of the modal window and then at the top of the page.

## Create users with both email address and username as sign-in identifiers

You can create users with both email address and username as sign-in identifiers using either the Microsoft Graph API or the Microsoft Entra admin center.

### Create users with email address & username as sign-in identifiers in the Microsoft Entra admin center

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [User Administrator](/entra/identity/role-based-access-control/permissions-reference#user-administrator).
1. If you have access to multiple tenants, use the **Settings** icon :::image type="icon" source="media/common/admin-center-settings-icon.png" border="false"::: in the top menu to switch to your external tenant from the **Directories + subscriptions** menu.
1. Browse to **Entra ID** > **Users**.
1. Select **+ New user** > **Create external user**.
1. Next to **Identities**, you can select **Email** or **User Name** from the dropdown. You can select either or both options.  <!--- IS THERE A LIMIT? --->

   :::image type="content" source="media/how-to-sign-in-alias/sign-in-method-dropdown.png" alt-text="Screenshot of the Sign-in method dropdown in the Create external user pane in the Microsoft Entra admin center.":::

1. On the **Properties** tab, you can specify the email attribute for the user. This is required if you want the user to be able to sign in with their email address.

   :::image type="content" source="media/how-to-sign-in-alias/email-attribute.png" alt-text="Screenshot of the Email attribute field in the Create external user pane in the Microsoft Entra admin center.":::

1. Select **Review + Create** to create the user.

### Create users with email address & username as sign-in identifiers with Graph API

You can use the [Users API](/graph/api/user-post-users) to create users with both email address and username as sign-in identifiers. You can also use the Users API to add a username to an existing user.

#### Request

The following example shows a request.

```http
POST https://graph.microsoft.com/v1.0/users
Content-type: application/json
{
    "displayName": "Test User",
    "identities": [
        {
            "signInType": "emailAddress",
            "issuer": "contoso.onmicrosoft.com",
            "issuerAssignedId": "dylan@woodgrove.com"
        },
        {
            "signInType": "username",
            "issuer": "contoso.onmicrosoft.com",
            "issuerAssignedId": "dylan123"
        }
    ],
    "mail": "dylan@woodgrove.com",
    "passwordProfile": {
        "password": "passwordValue",
        "forceChangePasswordNextSignIn": false
    },
    "passwordPolicies": "DisablePasswordExpiration"
}
```

### Add a username to an existing user

You can also add a username to an existing user.

1. For this scenario, you must first get a user account using a [sign-in identifier](/graph/api/user-list#example-2-get-a-user-account-using-a-sign-in-name).  You must use `$filter` to get the user object and you must `$select` to retrieve the `id` and `identities[]` properties.

#### Request

The following example shows a request.

```http
GET https://graph.microsoft.com/v1.0/users?$select=displayName,id&$filter=identities/any(c:c/issuerAssignedId eq 'dylan@woodgrove.com' and c/issuer eq 'contoso.onmicrosoft.com')
```

#### Response

The following example shows the response.

```http
HTTP/1.1 200 OK
Content-type: application/json
 
{
  "value": [
    {
      "displayName": "Dylan Williams",
      "id": "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
    }
  ]
}
```

1. Update the `identities[]` property of the user. Note: you must replace the entire `identities[]` property.

#### Request

The following example shows a request.

```http
POST https://graph.microsoft.com/v1.0/users/87d349ed-44d7-43e1-9a83-5f2406dee5bd
Content-type: application/json
 
{
    "identities": [
        {
            "signInType": "emailAddress",
            "issuer": "contoso.onmicrosoft.com",
            "issuerAssignedId": "adelev@adatum.com"
        },
        {
            "signInType": "username",
            "issuer": "contoso.onmicrosoft.com",
            "issuerAssignedId": "adelev123"
        }
    ]
}
```

## Test signing in with the alias or username

You can test signing in with the email address and username you assigned to the user you created using the [Run user flow](how-to-test-user-flows) feature.

The population of the `identities[]` property on a user object isn't enforced by the Microsoft Entra sign-in identifiers policy. While administrators can assign values to a user’s `identities[]` property, authentication is determined by the configured sign-in identifier policy. In other words, if a sign-in type is specified for a user but isn't enabled in the policy, the authentication attempt fails at runtime.

For example, a user might be assigned the username *User1234*, but if the **User Name** sign-in method isn't enabled in the policy, the user won't be able to sign in using that username.   <!--- IT'S USER NAME ON THE UI --->

## Customize the sign-in page (optional)

### Customize the hint text of identifier field on the sign-in page

You can customize the hint text of identifier field on the sign-in page via Company Branding. 

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Organizational Branding Administrator](~/identity/role-based-access-control/permissions-reference.md#organizational-branding-administrator).
1. If you have access to multiple tenants, use the **Settings** icon :::image type="icon" source="media/common/admin-center-settings-icon.png" border="false"::: in the top menu to switch to the external tenant you created earlier from the **Directories + subscriptions** menu.
1. Browse to **Company branding** either by using the search bar or by navigating to **Entra ID** > **Custom Branding**.
1. Select **Edit** to modify the branding.
1. In the **Sign-in form** tab, you can customize the hint text of identifier field on the sign-in page. For example, you can change it to "Email or Username".

   :::image type="content" source="media/how-to-sign-in-alias/edit-username-hint.png" alt-text="Screenshot of customizing the username hint text  in the Microsoft Entra admin center.":::

1. Select **Review + save** to save your changes.

### Customize and localize other strings related to username

You can customize and localize additional strings related to an end user's experience of signing in with a username by uploading a language file. For more information, see [Customize browser language for authentication experience](/entra/external-id/customers/how-to-customize-languages-customers).


## Related content

- [Customize the look and feel of the authentication experience for the external tenant](/entra/external-id/customers/concept-branding-customers)

