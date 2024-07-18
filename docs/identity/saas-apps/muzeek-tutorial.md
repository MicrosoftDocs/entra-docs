---
title: 'Tutorial: Microsoft Entra single sign-on (SSO) integration with Muzeek'
description: Learn how to configure single sign-on between Microsoft Entra and Muzeek.
services: active-directory
author: jeevansd
manager: CelesteDG
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps
ms.workload: identity
ms.topic: tutorial
ms.date: 06/19/2024
ms.author: jeedes
---

# Tutorial: Microsoft Entra single sign-on (SSO) integration with Muzeek

In this tutorial, you'll learn how to integrate Muzeek with Microsoft Entra ID. When you integrate Muzeek with Microsoft Entra ID, you can:

Use Microsoft Entra ID to control who can access Muzeek.
Enable your users to be automatically signed in to Muzeek with their Microsoft Entra accounts.
Manage your accounts in one central location: the Azure portal.

## Prerequisites

To get started, you need the following items:

* A Microsoft Entra subscription. If you don't have a subscription, you can get a [free account](https://azure.microsoft.com/free/).
* Muzeek single sign-on (SSO) enabled subscription.

## Add Muzeek from the gallery

To configure the integration of Muzeek into Microsoft Entra ID, you need to add Muzeek from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).

1. Browse to **Identity > Applications > Enterprise applications > New application**.

1. In the **Add from the gallery** section, enter **Muzeek** in the search box.

1. Select **Muzeek** in the results panel and then add the app. Wait a few seconds while the app is added to your tenant.

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO in the Microsoft Entra admin center.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).

1. Browse to **Identity** > **Applications** > **Enterprise applications** > **Muzeek** > **Single sign-on**.

1. Perform the following steps in the below section:

    a. Click **Go to application**.

    [![Screenshot showing the identity configuration.](common/go-to-application.png)](common/go-to-application.png#lightbox)

    b. Copy **Application (client) ID** and **Directory (tenant) ID**, use it later in the Muzeek side configuration.

    ![Screenshot of application client values.](./media/muzeek-tutorial/application-id.png)

1. Navigate to **Authentication** tab on the left menu and perform the following steps:

    a. Enable the **Access tokens (used for implicit flows)** and **ID tokens (used for implicit and hybrid flows)**

    [![Screenshot showing the Access tokens.](./media/muzeek-tutorial/access-token.png)](./media/muzeek-tutorial/access-token.png#lightbox)

    b. click **Save**.

    >[!NOTE]
    > The **Redirect URIs** value is auto populate, you don't need to perform any manual configuration here.

1. Navigate to **Certificates & secrets** on the left menu and perform the following steps:

    1. Go to **Client secrets** tab and click **+New client secret**.
    1. Enter a valid **Description** in the textbox and select **Expires** days from the drop-down as per your requirement and click **Add**.

        [![Screenshot showing the client secrets value.](common/client-secret.png)](common/client-secret.png#lightbox)

    1. Once you add a client secret, **Value** will be generated. Copy the value and use it later in the Muzeek side configuration.

        [![Screenshot showing how to add a client secret.](common/client.png)](common/client.png#lightbox)

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

In this section, you'll enable B.Simon to use single sign-on by granting access to Muzeek.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Identity** > **Applications** > **Enterprise applications** > **Muzeek**.
1. In the app's overview page, select **Users and groups**.
1. Select **Add user/group**, then select **Users and groups** in the **Add Assignment** dialog.
   1. In the **Users and groups** dialog, select **B.Simon** from the Users list, then click the **Select** button at the bottom of the screen.
   1. If you are expecting a role to be assigned to the users, you can select it from the **Select a role** dropdown. If no role has been set up for this app, you see "Default Access" role selected.
   1. In the **Add Assignment** dialog, click the **Assign** button.

## Configure Muzeek SSO

Below are the configuration steps to complete the OIDC federation setup:

1. Sign into the Muzeek site as an administrator.

1. Click **Settings** icon at the bottom of the page and perform of the below steps.

    [![Screenshot showing Muzeek configuration.](./media/Muzeek-tutorial/configuration.png)](./media/Muzeek-tutorial/configuration.png#lightbox)

    a. Go to the **Integrations** tab.

    b. In the **ENTRA Domain** field, enter the domain URL value using the following pattern: `https://login.microsoftonline.com/<Tenant_ID>/oauth2/v2.0/authorize`

    > [!NOTE]
    > The domain URL value is not real, replace the **Tenant_ID** value with actual **Directory (tenant) ID**, which you have copied from Entra side.

    c. In the **ENTRA Client ID** field, paste the **Application ID** value, which you have copied from Entra page. 

    d. In the **ENTRA Client Secret** field, paste the value, which you have copied from **Certificates & secrets** section at Entra side.

    e. Click **Save Changes**.

    f. Once saved, Muzeek populates the **Home Page URL** which can be used later in [Connect SSO via MyApps](#connect-sso-via-myapps) section.
    [![Screenshot showing the details of Home Page.](./media/Muzeek-tutorial/image.png)](./media/Muzeek-tutorial/image.png#lightbox)

## Connect SSO via MyApps

To connect your MyApps account to Muzeek in the Microsoft Entra Admin Center, please follow the below steps:

1. Navigate to **App Registrations** > **Muzeek**  > **Branding & Properties**.
[![Screenshot showing the app registrations of Muzeek.](./media/Muzeek-tutorial/home.png)](./media/Muzeek-tutorial/home.png#lightbox)

1. Paste the Home Page URL you copied from Muzeek portal into the **Home Page URL** field in Microsoft Entra Admin Center.

1. Click **Save** and wait for 10 - 15 minutes for the change to propagate in the system.

Once done, you should now be able to successfully navigate to your Muzeek account while logged into MyApps, and any users you have added to your tenant should be able to do so as well.