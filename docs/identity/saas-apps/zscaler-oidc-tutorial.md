---
title: 'Tutorial: Microsoft Entra single sign-on (SSO) integration with Zscaler'
description: Learn how to configure single sign-on between Microsoft Entra and Zscaler.
services: active-directory
author: jeevansd
manager: CelesteDG
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps
ms.workload: identity
ms.topic: tutorial
ms.date: 05/06/2024
ms.author: jeedes
---

# Tutorial: Microsoft Entra single sign-on (SSO) integration with Zscaler

In this tutorial, you'll learn how to integrate Zscaler with Microsoft Entra ID. When you integrate Zscaler with Microsoft Entra ID, you can:

Use Microsoft Entra ID to control who can access Zscaler.
Enable your users to be automatically signed in to Zscaler with their Microsoft Entra accounts.
Manage your accounts in one central location: the Azure portal.

## Prerequisites

To get started, you need the following items:

* A Microsoft Entra subscription. If you don't have a subscription, you can get a [free account](https://azure.microsoft.com/free/).
* Zscaler single sign-on (SSO) enabled subscription.

## Add Zscaler from the gallery

To configure the integration of Zscaler into Microsoft Entra ID, you need to add Zscaler from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).

1. Browse to **Identity > Applications > Enterprise applications > New application**.

1. In the **Add from the gallery** section, enter **Zscaler** in the search box.

1. Select **Zscaler** in the results panel and then add the app. Wait a few seconds while the app is added to your tenant.

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO in the Microsoft Entra admin center.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).

1. Browse to **Identity** > **Applications** > **Enterprise applications** > **Zscaler** > **Single sign-on**.

1. Perform the following steps in the below section:

    1. Click **Go to application**.

        ![Screenshot showing the identity configuration.](common/go-to-application.png)

    1. Copy **Application (client) ID** and use it later in the Zscaler side configuration.

        ![Screenshot of application client values.](common/application-id.png)

    1. Under **Endpoints** tab, copy **OpenID Connect metadata document** link and use it later in the Zscaler side configuration.

        ![Screenshot showing the endpoints on tab.](common/endpoints.png)

1. Navigate to **Authentication** tab on the left menu and perform the following steps:

    1. In the **Redirect URIs** textbox, paste the **Redirect URI** value, which you have copied from Zscaler side.

        ![Screenshot showing the redirect values.](common/authentication.png)

1. Navigate to **Certificates & secrets** on the left menu and perform the following steps:

    1. Go to **Client secrets** tab and click **+New client secret**.
    1. Enter a valid **Description** in the textbox and select **Expires** days from the drop-down as per your requirement and click **Add**.

        ![Screenshot showing the client secrets value.](common/client-secret.png)

    1. Once you add a client secret, **Value** will be generated. Copy the value and use it later in the Zscaler side configuration.

        ![Screenshot showing how to add a client secret.](common/client.png)

### Create a Microsoft Entra test user

In this section, you'll create a test user called B.Simon.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [User Administrator](~/identity/role-based-access-control/permissions-reference.md#user-administrator).
1. Browse to **Identity** > **Users** > **All users**.
1. Select **New user** > **Create new user**, at the top of the screen.
1. In the **User** properties, follow these steps:
   1. In the **Display name** field, enter `B.Simon`.  
   1. In the **User principal name** field, enter the username@companydomain.extension. For example, `B.Simon@contoso.com`.
   1. Select the **Show password** check box, and then write down the value that's displayed in the **Password** box.
   1. Select **Review + create**.
1. Select **Create**.

### Assign the Microsoft Entra test user

In this section, you'll enable B.Simon to use single sign-on by granting access to Zscaler.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Identity** > **Applications** > **Enterprise applications** > **Zscaler**.
1. In the app's overview page, select **Users and groups**.
1. Select **Add user/group**, then select **Users and groups** in the **Add Assignment** dialog.
   1. In the **Users and groups** dialog, select **B.Simon** from the Users list, then click the **Select** button at the bottom of the screen.
   1. If you are expecting a role to be assigned to the users, you can select it from the **Select a role** dropdown. If no role has been set up for this app, you see "Default Access" role selected.
   1. In the **Add Assignment** dialog, click the **Assign** button.

## Configure Zscaler SSO

Below are the configuration steps to complete the OIDC federation setup:

1. Sign into the Zscaler site.

2. Select **ZSLogin Administration** as Microsoft Partner Tenant. 

    ![Screenshot showing federation setup.](./media/zscaler-oidc-tutorial/admin.png)

3. Go to **External Identities** in the **Administration**.

    ![Screenshot showing External Identities.](./media/zscaler-oidc-tutorial/external-identities.png)

1. In the External Identities, go to **Secondary Identity Providers** and click **+ Add Secondary IdP**.

    ![Screenshot showing Add Secondary Idp.](./media/zscaler-oidc-tutorial/add-secondary.png)

1. In the **BASIC** section, perform the following steps in the **GENERAL** tab:

    ![Screenshot showing GENERAL tab.](./media/zscaler-oidc-tutorial/basic-configuration.png)

    a. In the **Name** field, enter the name for identification.

    b. In the **Identity Vendor** field, select Microsoft Entra ID from the dropdown.

    c. Select your **Domain** from the list.

    d. Select SAML as a **Protocol** and enable the **Status**.

1. In the **BASIC** section, perform the following steps in the **OIDC CONFIGURATION** tab:

    ![Screenshot showing oidc configuration tab.](./media/zscaler-oidc-tutorial/oidc-configuration.png)

    a. Paste the **Open ID Connect metadata document** value in the **Metadata URL** field, which you have copied from Entra page and click **FETCH**. The values will auto-populate.

    b. Copy the **Redirect URI** value, which is generated once you click the FETCH button and use it later in the Entra side configuration.

    c. In the **Client ID** field, paste the **Application ID** value, which you have copied from Entra page. 

    d. In the **Client Secret** field, paste the value, which you have copied from **Certificates & secrets** section at Entra side.

    e. In the **Requested Scopes**, add email and profile.

    f. Click **Update**.

1. In the **PROVISIONING** section, enable the JIT provisioning and click **Update**.

    ![Screenshot showing PROVISIONING.](./media/zscaler-oidc-tutorial/provisioning.png)

