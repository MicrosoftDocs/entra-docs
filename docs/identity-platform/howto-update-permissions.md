---
title: Update an app's requested permissions in Microsoft Entra ID
description: Learn how developers can stop applications from requesting unnecessary permissions and also add new permissions for applications in the Microsoft identity platform.
author: omondiatieno
manager: celesteDG
ms.author: jomondi
ms.date: 12/05/2023
ms.reviewer: yuhko, ergreenl
ms.service: identity-platform

ms.topic: how-to
services: active-directory
zone_pivot_groups: enterprise-apps-with-ms-graph
---
# Update an app's requested permissions in Microsoft Entra ID

When setting up an application with Microsoft Entra ID, developers can request access to data from other apps and services using permissions. They can request permissions by adding static permissions to their app’s manifest or by dynamically requesting permissions at runtime. Users or administrators can then choose to grant permissions during consent, allowing the app to access the data it needs.

As an application's functionality evolves, the resources it requires access to also change. These changes could involve enabling new features, eliminating unnecessary access, or replacing highly privileged permissions with less privileged ones. This article explains how to update the permissions your application requests using the Microsoft Entra admin center and Microsoft Graph API calls.

Updating permissions for your app isn't only a security best practice, but also a way to enhance your app's user experience and adoption. The following section outlines some of the benefits of updating permissions for your app:  

- If your app has a new functionality, you can request more permissions that enable the app to access the extra resources it needs.
- Customers are more likely to adopt your application if it requests only the least privileged permissions necessary to function. It shows that your app respects the customer's privacy and data protection and doesn't access more resources than it needs.
- Additionally, if your app is compromised, there's a smaller blast radius if it has fewer or lesser-privileged permissions. It means that the attacker has less access to the customer's data and resources, and thus the potential damage is reduced.
- By updating permissions for your app, you can improve your app's security, usability, and compliance, and build trust with your customers.

## Prerequisites

To update an app's requested permissions, you need:

- A Microsoft Entra user account. If you don't already have one, [create an account for free](https://azure.microsoft.com/free/?WT.mc_id=A261C142F).
- One of the following roles: Application Administrator, Cloud Application Administrator. An application owner who isn't an administrator is able to update an app's requested permissions.

## Scenarios for updating permissions

The following section lists the three main scenarios where you need to update the permissions your application requests:

- Add permissions to an application
- Remove unused permissions from an application
- Replace a permission

> [!NOTE]
> Updating the requested permissions for your application doesn't automatically grant or revoke your app's access to the protected resources. Your customers, or the admins in your organization need to grant consent to new permissions added, or manually revoke the permissions themselves.

## Add permissions to an application

You can add a permission if your app has a new functionality that needs a permission it didn’t need before.

It’s best practice to only request access to the minimum permissions your app needs to function. If you need to add a new permission to support new functionality in your app, request only the least privileged permission for that feature.
For example, to add an email notification feature to your application, it needs to access your user’s emails. To do so, you would need to request access for the `Mail.ReadWrite` permission.

### Add permissions into static consent

Static consent is a way of requesting permissions from users or administrators at the time of an application's registration, rather than at runtime. Static consent requires the app to declare all the permissions it needs in the **App registrations** pane in the Microsoft Entra admin center. Using The Microsoft Entra admin center, you can only update permissions for static consent. To learn more about the different types of consent, see [Types of consent](consent-types-developer.md). To learn how to update permissions for dynamic consent, refer to the Microsoft Graph tab of this article.

:::zone pivot="portal"

In this section, you learn how to add permissions into static consent.

You can add permissions to static consent in two different ways in the Microsoft Entra admin center:

### Option 1: Add permissions in the **API permissions** pane

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator) or application owner.
1. Browse to **Identity** > **Applications** > **App registrations** > **All applications**.
1. Find the app registration that you want to add permissions to and select it. You can add permissions in two different ways:
1. Add permissions in **API permissions** pane.
   1. Locate the **API permissions** pane and select **Add a permission**.
   1. Select the API that you want to access and the permission that you want to request from the list of available options and select **Add permissions**.

      :::image type="content" source="media/howto-update-permissions/add-permissions.png" alt-text="Screenshot of API permissions pane." lightbox="media/howto-update-permissions/add-permissions.png":::

### Option 2: Add permissions to the application manifest

1. From the left navigation pane, under the **Manage** menu group, select **Manifest**. The selection opens an editor that allows you to directly edit the attributes of the app registration object.
1. Carefully edit the `requiredResourceAccess` property in the application's manifest file.
1. Add the `resourceAppId` property and `resourceAccess` property and assign the required permissions.
1. Save your changes.

:::zone-end

:::zone pivot="ms-graph"

To complete the following steps of adding permissions, you need the following resources and privileges:

- Run the HTTP requests in a tool of your choice, for example, in your app, or through Graph Explorer.
- Run the APIs as a user with at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator), or as an owner of the target app registration.
- The app used to make these changes must be granted the `Application.ReadWrite.All` permission.

1. Identify the permissions your app requires, their permission IDs, and whether they're app roles (application permissions) or delegated permissions. For example, if you want to request Microsoft Graph permissions, see [Microsoft Graph permissions](/graph/permissions-reference#permission-scenarios) for a list of permissions and their IDs.
1. Add the required Microsoft Graph permissions to your app.
   The following example calls the [Update application](/graph/api/application-update) API to add the required Microsoft Graph permissions to an app registration identified by object ID `aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb`. This example uses `Analytics.Read` and `Application.Read.All` delegated permission and application permission. Microsoft Graph is identified as a ServicePrincipal object with `00000003-0000-0000-c000-000000000000` as its globally unique `AppId`.

   ```http
   PATCH https://graph.microsoft.com/v1.0/applications/aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb
   Content-Type: application/json
    {
        "requiredResourceAccess": [
            {
                "resourceAppId": "00000003-0000-0000-c000-000000000000",
                "resourceAccess": [
                    {
                        "id": "e03cf23f-8056-446a-8994-7d93dfc8b50e",
                        "type": "Scope"
                    },
                    {
                        "id": "9a5d68dd-52b0-4cc2-bd40-abcf44ac3a30",
                        "type": "Role"
                    }
                ]
            }
        ]
    }
   ```

### Add permissions into dynamic consent

Dynamic consent is a way of requesting permissions from users or administrators at runtime, rather than statically declaring them in the **App registrations** pane. Dynamic consent allows the app to ask for only the permissions it needs for a specific functionality, and to obtain consent from the user or admin when needed. Dynamic consent can be used with delegated permissions and can be combined with the `/.default` scope to request admin consent for all permissions.

To add permissions into dynamic consent:

- **Use Microsoft Graph**: Add the required Microsoft Graph permissions to an app registration. This example uses `Analytics.Read` and `Application.Read.All` delegated permission and application permission. Replace the values in \`scopes\` with values of any Microsoft Graph delegated permissions you want to configure for the app.

   The request should be like the following example:

   `https://login.microsoftonline.com/common/oauth2/v2.0/authorize?client_id=00001111-aaaa-2222-bbbb-3333cccc4444&response_type=code&scope=Analytics.Read+Application.Read`

- Use **MSAL.js**: Replace the values in \`scopes\` with values of any Microsoft Graph delegated permissions you want to configure for the app.

  ```msal
    const Request = {
        scopes: ["openid", "profile"],
        loginHint: "example@domain.net"
    };

    myMSALObj.ssoSilent(Request)
        .then((response) => {
            // your logic
        }).catch(error => {
            console.error("Silent Error: " + error);
            if (error instanceof msal.InteractionRequiredAuthError) {
                myMSALObj.loginRedirect(loginRequest);
            }
    });
  ```

:::zone-end

## Grant consent for the added permissions for the enterprise application

After permissions are added to your application, users or admins need to grant consent to the new permissions. Nonadmin users see a consent prompt when they sign into your app. Admin users on the other hand can grant consent to the new permissions on behalf of all users in their organization when they first sign in to your app or in the Microsoft Entra admin center.

When the added permissions require admin consent, the required actions vary based on app type:

- **Single tenant app and multitenant app in home tenant**: The user must sign in as at least a [Privileged Role Administrator role](~/identity/role-based-access-control/permissions-reference.md#privileged-role-administrator) and [grant tenant-wide consent](~/identity/enterprise-apps/grant-admin-consent.md).
- **Multi-tenant apps in customer's tenants**: User sees new consent prompts on their next sign-in attempt. If the permissions only require user consent, the user can grant consent. If the permissions require admin consent, the user must contact their administrator to grant consent.

### Stop requesting unused permissions

Removing permissions can reduce the risk of exposing sensitive data or compromising security and simplify the consent process for your users or administrators. If your app no longer needs a permission, you should prevent your app from requesting it by removing the permission from your app registration’s required resource access and code. For example, an application that no longer sends email notifications can remove the `Mail.ReadWrite` permission.

> [!IMPORTANT]
> Removing a permission from your app registration doesn't automatically revoke the permissions already granted to the app. You need to revoke the permissions manually. For more information, see the [Revoke consent for the removed permissions for the enterprise application](#revoke-consent-for-the-removed-permissions-for-the-enterprise-application) section of this article.

## Stop requesting permissions for static consent

:::zone pivot="portal"

To stop requesting permissions that require static consent, you need to remove the permission from the **App registrations** pane. An admin of the tenant also needs to revoke the permission on the **Enterprise applications** pane. For more information on how to revoke permissions granted to an enterprise application, see [Revoke permissions for an enterprise application](~/identity/enterprise-apps/manage-application-permissions.md#review-and-revoke-permissions).

In this section, you learn how to stop requesting permissions for static consent.

You can remove permissions from static consent in two different ways in the Microsoft Entra admin center:

### Option 1: From the **API permissions** pane

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator) or application owner.
1. Browse to **Identity** > **Applications** > **App registrations** > **All applications**.
1. Find the app registration that you want to remove permissions from and select it.
1. Remove the permissions from the **API permissions** pane:
   1. Locate the **API permissions** pane and find the permissions you want to remove.
   1. Select the API that you want to remove and select **Revoke admin consent** first and **remove permission** next. It ensures that the granted permission is removed from your tenant.

      :::image type="content" source="media/howto-update-permissions/remove-permissions.png" alt-text="Screenshot shows how to remove permissions via the API permissions pane." lightbox="media/howto-update-permissions/remove-permissions.png":::

### Option 2: From the application manifest

   1. From the left navigation pane, under the **Manage** menu group, select **Manifest**. An editor opens that allows you to directly edit the attributes of the app registration object.
   1. Carefully edit the `requiredResourceAccess` property in the application's manifest file.
   1. Remove the unneeded permissions from `resourceAppId` property and `resourceAccess` property.
   1. Save your changes.

:::zone-end

:::zone pivot="ms-graph"

To complete the following steps of removing permissions, you need the following resources and privileges:

- Run the HTTP requests in a tool of your choice, for example, in your app, or through Graph Explorer.
- Call the APIs as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator), or as an owner of the target app registration.
- The app used to make these changes must be granted the `Application.ReadWrite.All` permission.

1. Identify the permissions for your app.
1. For example, to stop your app from requesting Microsoft Graph permissions, identify the Microsoft Graph permissions for your app, their permission IDs, and whether they're app roles (application permissions) or delegated permissions.
1. Remove the unwanted Microsoft Graph permissions from your app.
   The following example calls the [Update application](/graph/api/application-update) API to remove the unwanted Microsoft Graph permissions from an app registration identified by a sample client ID `00001111-aaaa-2222-bbbb-3333cccc4444`. In this example, the application has `Analytics.Read`, `User.Read`, and `Application.Read.All`. We need to remove `Analytics.Read` and `Application.Read.All` delegated permission and application permission. Microsoft Graph is identified as a ServicePrincipal object with `00000003-0000-0000-c000-000000000000` as its globally unique `AppId` and Microsoft Graph as its `DisplayName` and `AppDisplayName`.

    ```http
    PATCH https://graph.microsoft.com/v1.0/applications/00001111-aaaa-2222-bbbb-3333cccc4444
    Content-Type: application/json
    {
        "requiredResourceAccess": [
            {
                "resourceAppId": "00000003-0000-0000-c000-000000000000",
                "resourceAccess": [
                    {
                        "id": "311a71cc-e848-46a1-bdf8-97ff7156d8e6 ",
                        "type": "Scope"
                    }
                ]
            }
        ]
    }
    ```

### Stop requesting permissions with dynamic consent

When you need to remove delegated permissions from dynamic consent request, specify the scope parameter while leaving out the permissions that you want to remove. Removing the permissions ensures the app doesn't call the corresponding API.

To stop requesting permissions with dynamic consent:

- **Using Microsoft Graph**: Remove the unwanted Microsoft Graph delegated permissions from the \`scopes\` parameter. In this example, your application is requesting three permissions - `Analytics.Read`, `User.Read` and `Application.Read.All`. The delegated permission, `Analytics.Read` and application permission, `Application.Read.All` are no longer required for this app. It only requires `User.Read`.

The request should be similar to the following example:

`https://login.microsoftonline.com/common/oauth2/v2.0/authorize?client_id=00001111-aaaa-2222-bbbb-3333cccc4444&response_type=code&scope=User.Read`

- **using MSAL.js**: Remove the unwanted Microsoft Graph delegated permissions in \`scopes\`.

    ```msal
        const Request = {
            scopes: ["openid", "profile"],
            loginHint: "example@domain.net"
        };

        myMSALObj.ssoSilent(Request)
            .then((response) => {
                // your logic
            }).catch(error => {
                console.error("Silent Error: " + error);
                if (error instanceof msal.InteractionRequiredAuthError) {
                    myMSALObj.loginRedirect(loginRequest);
                }
        });
    ```

:::zone-end

## Revoke consent for the removed permissions for the enterprise application

After the permissions are removed from the app registration, an admin in the tenant also needs to revoke consent to protect your organization's data. When the removed permission requires admin consent, the required actions vary based on app type:

- **Single tenant app and multitenant app in home tenant**: For a single tenant app, contact the admin of the tenant to revoke the permissions already granted to the app. For a multitenant app, contact the admins of all the tenants where instances of your application reside to [revoke permissions granted to the enterprise application](~/identity/enterprise-apps/manage-application-permissions.md). Revoking consent to the removed permissions ensures that the application doesn't maintain access through the removed permission.
- **Multi-tenant apps in customers' tenants**: Ensure that you communicate with your customers to revoke permissions through announcements, blogs and any other communication channels.

For both single tenant and multitenant apps, nonadmin users in tenants where user consent is enabled can use the MyApps portal to revoke consent to permissions they previously granted. For more information on how end users can revoke permissions in the MyApps portal, see [Revoke end user consent](https://support.microsoft.com/account-billing/edit-or-revoke-application-permissions-in-the-my-apps-portal-169be2b4-ee26-4338-aea8-d19bb2f329ee).

### Replace a permission

You should replace a highly privileged permission when a less privileged permission would suffice.

Replacing permissions can also reduce the risk of exposing sensitive data or compromising security and thus improve the user experience and trust. If your app is using a highly privileged permission, such as `Directory.ReadWrite.All`, you should consider if a less-privileged permission, such as `User.ReadWrite.All`, would be sufficient for your app’s functionality.

> [!NOTE]
> When you modify an app's requested permissions for static consent, the customer will need to reconsent. The act of reconsenting revokes all previously granted permissions and grant consent to the new ones.
> When you modify an app's requested permissions for dynamic consent, the previously granted permissions aren't revoked. The customer has to revoke the permissions manually.

To replace a permission, you need to remove the unnecessary permission and add the alternative one. The steps are like the ones described in the [Stop requesting unused permissions](#stop-requesting-unused-permissions) and [add permissions](#add-permissions-to-an-application) sections of this article.
