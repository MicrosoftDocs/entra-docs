---
title: Configure Smartcat for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra and Smartcat.
services: active-directory
author: nguhiu
manager: mwongerapk
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps
ms.workload: identity
ms.topic: how-to
ms.date: 08/02/2024
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Smartcat  so that I can control who has access to Smartcat, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure Smartcat for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Smartcat with Microsoft Entra ID. When you integrate Smartcat  with Microsoft Entra ID, you can:

- Use Microsoft Entra ID to control who can access Smartcat.
- Enable your users to be automatically signed in to Smartcat  with their Microsoft Entra accounts.
- Manage your accounts in one central location: the Azure portal.

## Prerequisites

To get started, you need the following items:

* A Microsoft Entra subscription. If you don't have a subscription, you can get a [free account](https://azure.microsoft.com/free/).
* Smartcat single sign-on (SSO) enabled subscription.

## Add Smartcat from the gallery

To configure the integration of Smartcat  into Microsoft Entra ID, you need to add Smartcat from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).

1. Browse to **Entra ID** > **Enterprise apps** > **New application**.

1. In the **Add from the gallery** section, enter **Smartcat** in the search box.

1. Select **Smartcat** in the results panel and then add the app. Wait a few seconds while the app is added to your tenant.

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO in the Microsoft Entra admin center.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).

1. Browse to **Entra ID** > **Enterprise apps** > **Smartcat** > **Single sign-on**.

1. Perform the following steps in the below section:

    1. Select **Go to application**.

        [![Screenshot of showing the identity configuration.](common/go-to-application.png)](common/go-to-application.png#lightbox)

    1. Copy **Application (client) ID** and use it later in the Smartcat  side configuration.

        [![Screenshot of application client values.](common/application-id.png)](common/application-id.png#lightbox)

    1. Under **Endpoints** tab, copy **OpenID Connect metadata document** link and use it later in the Smartcat  side configuration.

        [![Screenshot of showing the endpoints on tab.](common/endpoints.png)](common/endpoints.png#lightbox)

1. Navigate to **Authentication** tab on the left menu and perform the following steps:

    1. In the **Redirect URIs** textbox, type a URL using the following pattern: 
    `https://<HOST_NAME>/users/auth/oAuthCallback`

        [![Screenshot of showing the redirect values.](common/redirect.png)](common/redirect.png#lightbox)

    1. Select **Configure** button.

1. Navigate to **Certificates & secrets** on the left menu and perform the following steps:

    1. Go to **Client secrets** tab and select **+New client secret**.
    1. Enter a valid **Description** in the textbox and select **Expires** days from the drop-down as per your requirement and select **Add**.

        [![Screenshot of showing the client secrets value.](common/client-secret.png)](common/client-secret.png#lightbox)

    1. Once you add a client secret, **Value** is generated. Copy the value and use it later in the Smartcat side configuration.

        [![Screenshot of showing how to add a client secret.](common/client.png)](common/client.png#lightbox)

### Create a Microsoft Entra test user

In this section, you create a test user called B.Simon.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [User Administrator](~/identity/role-based-access-control/permissions-reference.md#user-administrator).
1. Browse to **Entra ID** > **Users**.
1. Select **New user** > **Create new user**, at the top of the screen.
1. In the **User** properties, follow these steps:
   1. In the **Display name** field, enter `B.Simon`.  
   1. In the **User principal name** field, enter the username@companydomain.extension. For example, `B.Simon@contoso.com`.
   1. Select the **Show password** check box, and then write down the value that's displayed in the **Password** box.
   1. Select **Review + create**.
1. Select **Create**.

### Assign the Microsoft Entra test user

In this section, you enable B.Simon to use single sign-on by granting access to Smartcat.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Smartcat**.
1. In the app's overview page, select **Users and groups**.
1. Select **Add user/group**, then select **Users and groups** in the **Added Assignment** dialog.
   1. In the **Users and groups** dialog, select **B.Simon** from the Users list, then select the **Select** button at the bottom of the screen.
   1. If you're expecting a role to be assigned to the users, you can select it from the **Select a role** dropdown. If no role has been set up for this app, you see "Default Access" role selected.
   1. In the **Added Assignment** dialog, select the **Assign** button.

## Configure Smartcat SSO

To complete the OAuth/OIDC federation setup on **Smartcat** side, you need to send the copied values like  Tenant ID, Application ID, and Client Secret from Microsoft Entra to [Smartcat  support team](mailto:support@smartcat.com). They set this setting to have the OIDC connection set properly on both sides.
