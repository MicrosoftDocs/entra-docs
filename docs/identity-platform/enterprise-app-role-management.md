---
title: Configure the role claim
description: Learn how to configure the role claim issued in the SAML token for enterprise applications in Microsoft Entra ID.
author: cilwerner
manager: CelesteDG
ms.author: cwerner
ms.custom: 
ms.date: 06/09/2023
ms.reviewer: jeedes
ms.service: identity-platform

ms.topic: how-to

#Customer intent: As a cloud Application Administrator, I want to customize the role claim in the access token for an enterprise application, so that I can define custom roles and assign them to user accounts.
---

# Configure the role claim

You can customize the role claim in the access token that is received after an application is authorized. Use this feature if your application expects custom roles in the token. You can create as many roles as you need.

## Prerequisites

- A Microsoft Entra subscription with a configured tenant. For more information, see [Quickstart: Set up a tenant](quickstart-create-new-tenant.md).
- An enterprise application that has been added to the tenant. For more information, see [Quickstart: Add an enterprise application](~/identity/enterprise-apps/add-application-portal.md).
- Single sign-on (SSO) configured for the application. For more information, see [Enable single sign-on for an enterprise application](~/identity/enterprise-apps/add-application-portal-setup-sso.md).
- A user account that is assigned to the role. For more information, see [Quickstart: Create and assign a user account](~/identity/enterprise-apps/add-application-portal-assign-users.md).

> [!NOTE]
> This article explains how to create, update, or delete application roles on the service principal using APIs. To use the new user interface for App Roles, see [Add app roles to your application and receive them in the token](./howto-add-app-roles-in-apps.md).

## Locate the enterprise application

[!INCLUDE [portal updates](~/includes/portal-update.md)]

Use the following steps to locate the enterprise application:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Identity** > **Applications** > **Enterprise applications** > **All applications**.
1. Enter the name of the existing application in the search box, and then select the application from the search results.
1. After the application is selected, copy the object ID from the overview pane.

## Add roles

Use the Microsoft Graph Explorer to add roles to an enterprise application.

1. Open [Microsoft Graph Explorer](https://developer.microsoft.com/graph/graph-explorer) in another window and sign in using the administrator credentials for your tenant.

    > [!NOTE]
    > The Cloud Application Administrator and Application Administrator role won't work in this scenario, use the Privileged Role Administrator.

1. Select **modify permissions**, select **Consent** for the `Application.ReadWrite.All` and the `Directory.ReadWrite.All` permissions in the list.
1. Replace `<objectID>` in the following request with the object ID that was previously recorded and then run the query:

    `https://graph.microsoft.com/v1.0/servicePrincipals/<objectID>`

1. An enterprise application is also referred to as a service principal. Record the **appRoles** property from the service principal object that was returned. The following example shows the typical appRoles property:

    ```json
    {
      "appRoles": [
        {
          "allowedMemberTypes": [
            "User"
          ],
          "description": "msiam_access",
          "displayName": "msiam_access",
          "id": "00aa00aa-bb11-cc22-dd33-44ee44ee44ee",
          "isEnabled": true,
          "origin": "Application",
          "value": null
        }
      ]
    }
    ```

1. In Graph Explorer, change the method from **GET** to **PATCH**.
1. Copy the appRoles property that was previously recorded into the **Request body** pane of Graph Explorer, add the new role definition, and then select **Run Query** to execute the patch operation. A success message confirms the creation of the role. The following example shows the addition of an *Admin* role:

    ```json
    {
      "appRoles": [
        {
          "allowedMemberTypes": [
            "User"
          ],
          "description": "msiam_access",
          "displayName": "msiam_access",
          "id": "00aa00aa-bb11-cc22-dd33-44ee44ee44ee",
          "isEnabled": true,
          "origin": "Application",
          "value": null
        },
        {
          "allowedMemberTypes": [
            "User"
          ],
          "description": "Administrators Only",
          "displayName": "Admin",
          "id": "11bb11bb-cc22-dd33-ee44-55ff55ff55ff",
          "isEnabled": true,
          "origin": "ServicePrincipal",
          "value": "Administrator"
        }
      ]
    }
    ```

    You must include the `msiam_access` role object in addition to any new roles in the request body. Failure to include any existing roles in the request body removes them from the **appRoles** object. Also, you can add as many roles as your organization needs. The value of these roles is sent as the claim value in the SAML response. To generate the GUID values for the ID of new roles use the web tools, such as the [Online GUID / UUID Generator](https://www.guidgenerator.com/). The appRoles property in the response includes what was in the request body of the query.

## Edit attributes

Update the attributes to define the role claim that is included in the token.

1. Locate the application in the Microsoft Entra admin center, and then select **Single sign-on** in the left menu.
1. In the **Attributes & Claims** section, select **Edit**.
1. Select **Add new claim**.
1. In the **Name** box, type the attribute name. This example uses **Role Name** as the claim name.
1. Leave the **Namespace** box blank.
1. From the **Source attribute** list, select **user.assignedroles**.
1. Select **Save**. The new **Role Name** attribute should now appear in the **Attributes & Claims** section. The claim should now be included in the access token when signing into the application.

## Assign roles

After the service principal is patched with more roles, you can assign users to the respective roles.

1. Locate the application to which the role was added in the Microsoft Entra admin center.
1. Select **Users and groups** in the left menu and then select the user that you want to assign the new role.
1. Select **Edit assignment** at the top of the pane to change the role.
1. Select **None Selected**, select the role from the list, and then select **Select**.
1. Select **Assign** to assign the role to the user.

## Update roles

To update an existing role, perform the following steps:

1. Open [Microsoft Graph Explorer](https://developer.microsoft.com/graph/graph-explorer).
1. Sign in to the Graph Explorer site as a Privileged Role Administrator.
1. Using the object ID for the application from the overview pane, replace `<objectID>` in the following request with it and then run the query:

    `https://graph.microsoft.com/v1.0/servicePrincipals/<objectID>`

1. Record the **appRoles** property from the service principal object that was returned.
1. In Graph Explorer, change the method from **GET** to **PATCH**.
1. Copy the appRoles property that was previously recorded into the **Request body** pane of Graph Explorer, add update the role definition, and then select **Run Query** to execute the patch operation.

## Delete roles

To delete an existing role, perform the following steps:

1. Open [Microsoft Graph Explorer](https://developer.microsoft.com/graph/graph-explorer).
1. Sign in to the Graph Explorer site as a Privileged Role Administrator.
1. Using the object ID for the application from the overview pane in the Azure portal, replace `<objectID>` in the following request with it and then run the query:

    `https://graph.microsoft.com/v1.0/servicePrincipals/<objectID>`

1. Record the **appRoles** property from the service principal object that was returned.
1. In Graph Explorer, change the method from **GET** to **PATCH**.
1. Copy the appRoles property that was previously recorded into the **Request body** pane of Graph Explorer, set the **IsEnabled** value to **false** for the role that you want to delete, and then select **Run Query** to execute the patch operation. A role must be disabled before it can be deleted.
1. After the role is disabled, delete that role block from the **appRoles** section. Keep the method as **PATCH**, and select **Run Query** again.

## Next steps

- For information about customizing claims, see [Customize claims issued in the SAML token for enterprise applications](saml-claims-customization.md).
