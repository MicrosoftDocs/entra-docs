---
title: Microsoft Entra single sign-on (SSO) integration with IBM Storage Virtualize
description: Learn how to configure single sign-on between Microsoft Entra and IBM Storage Virtualize.
services: active-directory
author: nguhiu
manager: CelesteDG
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps
ms.workload: identity
ms.topic: how-to
ms.date: 08/02/2024
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and IBM Storage Virtualize so that I can control who has access to IBM Storage Virtualize, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Microsoft Entra single sign-on (SSO) integration with IBM Storage Virtualize

In this article,  you'll learn how to integrate IBM Storage Virtualize with Microsoft Entra ID. When you integrate IBM Storage Virtualize with Microsoft Entra ID, you can:

Use Microsoft Entra ID to control who can access IBM Storage Virtualize.
Enable your users to be automatically signed in to IBM Storage Virtualize with their Microsoft Entra accounts.
Manage your accounts in one central location: the Azure portal.

## Prerequisites

To get started, you need the following items:

* A Microsoft Entra subscription. If you don't have a subscription, you can get a [free account](https://azure.microsoft.com/free/).
* IBM Storage Virtualize single sign-on (SSO) enabled subscription.

## Add IBM Storage Virtualize from the gallery

To configure the integration of IBM Storage Virtualize into Microsoft Entra ID, you need to add IBM Storage Virtualize from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).

1. Browse to **Identity > Applications > Enterprise applications > New application**.

1. In the **Add from the gallery** section, enter **IBM Storage Virtualize** in the search box.

1. Select **IBM Storage Virtualize** in the results panel and then add the app. Wait a few seconds while the app is added to your tenant.

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO in the Microsoft Entra admin center.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).

1. Browse to **Identity** > **Applications** > **Enterprise applications** > **IBM Storage Virtualize** > **Single sign-on**.

1. Perform the following steps in the below section:

    1. Click **Go to application**.

        [![Screenshot of showing the identity configuration.](common/go-to-application.png)](common/go-to-application.png#lightbox)

    1. Copy **Application (client) ID** and use it later in the IBM Storage Virtualize side configuration.

        [![Screenshot of application client values.](common/application-id.png)](common/application-id.png#lightbox)
        
1. Navigate to **Authentication** tab on the left menu and perform the following steps:

    1. In the **Redirect URIs** textbox, paste the **Redirect URI** value, which you have copied from the IBM Storage Virtualize side.

        [![Screenshot of showing the redirect values.](common/redirect.png)](common/redirect.png#lightbox)

    1. Click **Configure** button.

1. Navigate to **Certificates & secrets** on the left menu and perform the following steps:

    1. Go to **Client secrets** tab and click **+New client secret**.
    1. Enter a valid **Description** in the textbox and select **Expires** days from the drop-down as per your requirement and click **Add**.

        [![Screenshot of showing the client secrets value.](common/client-secret.png)](common/client-secret.png#lightbox)

    1. Once you add a client secret, **Value** will be generated. Copy the value and use it later in the IBM Storage Virtualize side configuration.

        [![Screenshot of showing how to add a client secret.](common/client.png)](common/client.png#lightbox)

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

In this section, you'll enable B.Simon to use single sign-on by granting access to IBM Storage Virtualize.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Identity** > **Applications** > **Enterprise applications** > **IBM Storage Virtualize**.
1. In the app's overview page, select **Users and groups**.
1. Select **Add user/group**, then select **Users and groups** in the **Add Assignment** dialog.
   1. In the **Users and groups** dialog, select **B.Simon** from the Users list, then click the **Select** button at the bottom of the screen.
   1. If you are expecting a role to be assigned to the users, you can select it from the **Select a role** dropdown. If no role has been set up for this app, you see "Default Access" role selected.
   1. In the **Add Assignment** dialog, click the **Assign** button.

## Configure IBM Storage Virtualize SSO

Below are the configuration steps to complete the OAuth/OIDC federation setup:

1. Sign in to the IBM Storage Virtualize administrator dashboard by using the following URL:
`https://tenant.verify.ibm.com/ui/admin`.

1. In the IBM Security Verify interface, select **Applications**  > **Add application**.

    > [!Note]
    >  Each system must be added as a separate application.

1. Navigate to **General tab** and perform the following steps:

    1. In the **Name** field, enter a unique name to identity the system.

    1. In the **Description** field, enter a brief description of the system.

    1. In the **Company name** field, enter name of organization or company.

1. Navigate to **Sign-on** tab and perform the following steps:

    1. Enter your **Application URL** which is used to access the management GUI for your system.

    1. Select **Authorization code** and **JWT bearer** Grant type.

    1. In the **Client ID** field, paste the **Application ID** value, which you have copied from Entra page.

    1. In the **Client Secret** field, paste the value, which you have copied from **Certificates & secrets** section at Entra side.

    1. For User consent, select **Do not ask for consent** button.

    1. Copy the **Redirect URIs** and use it later in the Entra configuration.

    1. Select **Username** from the JWT bearer user identification.

    1. Ensure **Cloud Directory** is selected in JWT bearer default identity source.

    1. Ensure **Generate refresh token** option is unchecked.

    1. Ensure **Send all known user attributes in the ID token** option is checked.

    1. Under **Access policies**, Deselect **Use default policy** > click the **Edit** icon > **Select Always require 2FA in all devices** > click **OK**.

    1. Ensure **Restrict custom scopes** option is unchecked.

    1. Click **Save**.

    1. On the confirmation page, click **Confirm** to enable single sign-on for the system.
