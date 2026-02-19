---
title: Sign in with alias
description: Learn how to sign in and sign up with alias/username with External ID for customer identity and access management (CIAM). Get detailed steps to enable username as a sign-in identifier and create users with both email address and username. 
ms.author: godonnell
author: garrodonnell
manager: dougeby
ms.service: entra-external-id 
ms.subservice: external
ms.topic: how-to
ms.date: 01/13/2026
ms.custom: it-pro

#Customer intent: As a dev, devops, or it admin, I want to learn about how to enable sign in with alias/username through the Microsoft Entra admin center and Graph API.
---
# Sign in with an alias or username

[!INCLUDE [applies-to-external-only](../includes/applies-to-external-only.md)]

You can allow users who sign in with an email address and password also sign up or sign in with a username and password. A username, also called an alternate sign-in identifier, can be a customer ID, account number, or another identifier that you choose.

:::image type="content" source="media/how-to-sign-in-alias/username-login-option.png" alt-text="Screenshot of the username sign-in option.":::

## Prerequisites

- If you haven't already created your own Microsoft Entra external tenant, [create one now](how-to-create-external-tenant-portal.md).
- [Register an app](/entra/identity-platform/quickstart-register-app).
- [Create a user flow](how-to-user-flow-sign-up-sign-in-customers.md).
- [Add your application](how-to-user-flow-add-application.md) to the user flow.

## Enable username in sign-in identifier policy

To enable username as a sign-in identifier, first enable the sign-in identifier policy in the Microsoft Entra admin center. UserPrincipalName (UPN) and email address are selected by default. Once username is also  enabled, users who have been assigned a username will be able to sign in using either their email address or username.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Authentication Policy Administrator](/entra/identity/role-based-access-control/permissions-reference#authentication-policy-administrator).
1. If you have access to multiple tenants, use the **Settings** icon :::image type="icon" source="media/common/admin-center-settings-icon.png" alt-text="Screenshot of the Microsoft Entra admin center showing the Sign-in identifiers page with Username enabled as a sign-in identifier." border="false"::: in the top menu to switch to your external tenant from the **Directories + subscriptions** menu.
1. Browse to **Sign-in identifiers** either from **Entra ID** > **External Identities** or from **Entra ID** > **Authentication methods**.
1. On the **Sign-in identifiers** page, enable **Username** as a sign-in identifier.

   :::image type="content" source="media/how-to-sign-in-alias/signin-identifiers.png" alt-text="Screenshot of the Sign-in identifiers option in the Microsoft Entra admin center." lightbox="media/how-to-sign-in-alias/signin-identifiers.png":::

1. Select **Save** at the top of the page.

1. **(Optional)** To enable custom username validation, enter a custom regex value, select **Enable**, and then select **Save** to enable the custom validation.

## Create and update users with username

Once you enable username as a sign-in identifier, you can create new users with both email address and username as sign-in identifiers. You can also update existing users to add a username. You can do this using either the Microsoft Entra admin center or the Microsoft Graph API.

# [Microsoft Entra admin center](#tab/admin-center)

**Create users with username in the admin center**

You can create external users with both email address and username as sign-in identifiers using either the Microsoft Entra admin center or the Microsoft Graph API. This section describes creating users in the Microsoft Entra admin center.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Authentication Policy Administrator](/entra/identity/role-based-access-control/permissions-reference#authentication-policy-administrator).
1. If you have access to multiple tenants, use the **Settings** icon :::image type="icon" source="media/common/admin-center-settings-icon.png" border="false"::: in the top menu to switch to your external tenant from the **Directories + subscriptions** menu.
1. In your external tenant, browse to **Entra ID** > **Users**.
1. Select **+ New user** > **Create external user**.
1. Next to **Identities**, enter values for both **Email** and **User Name** sign-in methods. The selection order doesn’t matter.

   :::image type="content" source="media/how-to-sign-in-alias/signin-method-dropdown.png" alt-text="Screenshot of the Sign-in method dropdown in the Create external user pane in the Microsoft Entra admin center." lightbox="media/how-to-sign-in-alias/signin-method-dropdown.png":::

1. On the **Properties** tab, specify the email attribute for the user.

   :::image type="content" source="media/how-to-sign-in-alias/email-attribute.png" alt-text="Screenshot of the Email attribute field in the Create external user pane in the Microsoft Entra admin center." lightbox="media/how-to-sign-in-alias/email-attribute.png":::

1. Select **Review + create** to create the user.

**Update existing users to add a username in the admin center**

Follow these steps to add a username to an existing external user in the Microsoft Entra admin center. Username can only be added to external users with email and password accounts.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Authentication Policy Administrator](/entra/identity/role-based-access-control/permissions-reference#authentication-policy-administrator).
1. If you have access to multiple tenants, use the **Settings** icon :::image type="icon" source="media/common/admin-center-settings-icon.png" border="false"::: in the top menu to switch to your external tenant from the **Directories + subscriptions** menu.
1. In your external tenant, browse to **Entra ID** > **Users**.
1. Select the external user you want to update.
1. In the user pane, select **Edit properties**.
1. On the **Identity** tab, in the **Identities** section select **+ Add identity**.
1. Select **User Name** from the dropdown and enter the username you want to assign to the user.

   :::image type="content" source="media/how-to-sign-in-alias/edit-user-to-add-alias.png" alt-text="Screenshot of adding username to an existing user in the Microsoft Entra admin center." lightbox="media/how-to-sign-in-alias/edit-user-to-add-alias.png":::

1. Select **Save** to apply the changes.

# [Microsoft Graph API](#tab/graph-api)

**Create users with username with the Microsoft Graph API**

After you sign in to the [MS Graph explorer](https://developer.microsoft.com/en-us/graph/graph-explorer), you can use the [Users API](/graph/api/user-post-users) to create users with both email address and username as sign-in identifiers.
The following request example shows how to create a user with both email address and username as sign-in identifiers.

```http
POST https://graph.microsoft.com/v1.0/users
Content-type: application/json
{
    "displayName": "Test User",
    "identities": [
        {
            "signInType": "emailAddress",
            "issuer": "contoso.onmicrosoft.com",
            "issuerAssignedId": "dylan@woodgrovebank.com"
        },
        {
            "signInType": "username",
            "issuer": "contoso.onmicrosoft.com",
            "issuerAssignedId": "dylan123"
        }
    ],
    "mail": "dylan@woodgrovebank.com",
    "passwordProfile": {
        "password": "passwordValue",
        "forceChangePasswordNextSignIn": false
    },
    "passwordPolicies": "DisablePasswordExpiration"
}
```

**Add a username to existing users with the Microsoft Graph API**

You can also add a username to an existing external user.

**Step 1: Get the user details**

Use `$filter` to get the user object, and `$select` to return the ID and `identities[]` properties. The following request example shows how to retrieve a user account using the email address as a sign-in identifier.

```http
GET https://graph.microsoft.com/v1.0/users?$select=displayName,id,identities&$filter=identities/any(c:c/issuerAssignedId eq 'dylan@woodgrovebank.com' and c/issuer eq 'contoso.onmicrosoft.com')
```

The following response example shows the response with the user details.

```http
HTTP/1.1 200 OK
Content-type: application/json
 
{
    "@odata.context": "https://graph.microsoft.com/v1.0/$metadata#users(displayName,id,identities)",
    "value": [
        {
            "displayName": "ciam test 1",
            "id": "0daaf9dd-3583-4cd4-8934-a2ffd0490287",
            "identities": [
                {
                    "signInType": "userPrincipalName",
                    "issuer": "contoso.onmicrosoft.com",
                    "issuerAssignedId": "0daaf9dd-3583-4cd4-8934-a2ffd0490287@contoso.onmicrosoft.com"
                },
                {
                    "signInType": "emailAddress",
                    "issuer": "contoso.onmicrosoft.com",
                    "issuerAssignedId": "dylan@woodgrovebank.com"
                }
            ]
        }
    ]
}
```

**Step 2: Update the user details**

Once you have the user details from the query above, you can update the `identities[]` property of the user. You must replace the entire `identities[]` property of the user.

The following request example shows how to update the `identities[]` property of an email/password user to add a username.

```http
POST https://graph.microsoft.com/v1.0/users/00aa00aa-bb11-cc22-dd33-44ee44ee44ee
Content-type: application/json 
{
            "identities": [
                {
                    "signInType": "userPrincipalName",
                    "issuer": "contoso.onmicrosoft.com",
                    "issuerAssignedId": "00aa00aa-bb11-cc22-dd33-44ee44ee44ee@contoso.onmicrosoft.com"
                },
                {
                    "signInType": "emailAddress",
                    "issuer": "contoso.onmicrosoft.com",
                    "issuerAssignedId": "dylan@woodgrovebank.com"
                },
                {
                    "signInType": "userName",
                    "issuer": "contoso.onmicrosoft.com",
                    "issuerAssignedId": "dylan1234"
                }
            ]
}
```

---

## Sign up with an alias or username (preview)

You can allow users to sign up with a username or alias in addition to their email address in Microsoft Entra External ID. During sign-up, you collect the username from the user. The username must be unique across the tenant.
To configure your user flow to collect a username, follow these steps.

### Step 1: Add the username attribute to your user flow

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Authentication Policy Administrator](/entra/identity/role-based-access-control/permissions-reference#authentication-policy-administrator).
1. If you have access to multiple tenants, use the **Settings** icon :::image type="icon" source="media/common/admin-center-settings-icon.png" border="false"::: in the top menu to switch to your external tenant from the **Directories + subscriptions** menu.
1. In your external tenant, browse to **Entra ID** > **External Identities** > **User flows**.
1. Select the user flow you created in the prerequisites.
1. Under **Settings**, select **User attributes**.
1. Select the **Username** attribute.
1. Select **Save** to add the attribute to your user flow.

   :::image type="content" source="media/how-to-sign-in-alias/username-attribute.png" alt-text="Screenshot of the Username attribute in the Microsoft Entra admin center." lightbox="media/how-to-sign-in-alias/username-attribute.png":::

### Step 2: (Optional) Change the label of the username field

You can change the label of the username field that appears on the sign-up page.

1. In your external tenant, browse to **Entra ID** > **External Identities** > **User flows**.
1. Go to **Page Layout**.
1. Find the **Username** attribute and edit the label. For example, you can change it to "Alias" or "User ID".
1. Select **Save**.

   :::image type="content" source="media/how-to-sign-in-alias/change-label.png" alt-text="Screenshot of the change label option in the Microsoft Entra admin center." lightbox="media/how-to-sign-in-alias/change-label.png":::

## Prefill or assign usernames 

Like other attributes, you can customize signup by pre-filling username or assigning it after gathering other user information.  To prefill the value, use a custom extension with the [onAttributeCollectionStart](../../identity-platform/custom-extension-onattributecollectionstart-retrieve-return-data.md) event, and configure how it is presented via Page Layout or configure via Microsoft Graph. If you need to assign, modify, or validate the username after collecting more details, use the [onAttributeCollectionSubmit](../../identity-platform/custom-extension-onattributecollectionsubmit-retrieve-return-data.md) event.

## Test signing in with the alias or username

You can test signing up and signing in with the email address and username you assigned to the user you created using the [Run user flow](how-to-test-user-flows.md) feature.
When you're testing the sign-up scenario, make sure to enter the username during the attribute collection step. If you sign in with email address, you'll see email address in `preferred_username` claim.  If you sign in with username, you'll see the username in `preferred_username` claim.

> [!NOTE]
> The `identities[]` property on a user object isn’t enforced by the Microsoft Entra sign-in identifiers policy. While administrators can assign values to a user’s `identities[]` property, authentication is determined by the configured sign-in identifier policy. In other words, if a sign-in type is specified for a user but isn't enabled in the policy, the authentication attempt fails at runtime. For example, a user might be assigned the username *User1234*, but if the username sign-in method isn't enabled in the policy, the user won't be able to sign in using that username.  

## Customize the sign-in page (optional)

You can customize the sign-in page to provide a better experience for your users. You can customize the hint text of the identifier field on the sign-in page and localize other strings related to username.

### Customize the hint text of the identifier field on the sign-in page

You can customize the hint text of identifier field on the sign-in page for all apps via [Custom branding](/entra/external-id/customers/how-to-customize-branding-customers#to-customize-the-sign-in-form).

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Organizational Branding Administrator](~/identity/role-based-access-control/permissions-reference.md#organizational-branding-administrator).
1. If you have access to multiple tenants, use the **Settings** icon :::image type="icon" source="media/common/admin-center-settings-icon.png" border="false"::: in the top menu to switch to the external tenant you created earlier from the **Directories + subscriptions** menu.
1. Browse to **Company branding** either by using the search bar or by navigating to **Entra ID** > **Custom Branding**.
1. Select **Edit** to modify the branding.
1. In the **Sign-in form** tab, you can customize the hint text of identifier field on the sign-in page. For example, you can change it to *Email address or Member ID*.

   :::image type="content" source="media/how-to-sign-in-alias/edit-username-hint.png" alt-text="Screenshot of customizing the username hint text  in the Microsoft Entra admin center." lightbox="media/how-to-sign-in-alias/edit-username-hint.png":::

1. Select **Review + save** to save your changes.

### Customize and localize other strings related to username

You can customize and localize other strings related to an end user's experience of signing in with a username by uploading a language file. For more information, see [Add language customization to a user flow](/entra/external-id/customers/how-to-customize-languages-customers#add-language-customization-to-a-user-flow).

## Related content

- You can use the [Users API](/graph/api/user-post-users) to create users with both email address and username with Microsoft Graph.
- You can [customize the look and feel of the authentication experience for the external tenant](/entra/external-id/customers/concept-branding-customers#add-language-customization-to-a-user-flow).