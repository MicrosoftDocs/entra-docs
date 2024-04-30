---
title: "Tutorial: Microsoft Entra single sign-on (SSO) integration with Zscaler Internet Access ZSNet"
description: Learn how to configure single sign-on between Microsoft Entra ID and Zscaler Internet Access ZSNet.

author: jeevansd
manager: CelesteDG
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: tutorial
ms.date: 04/10/2024
ms.author: jeedes

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Zscaler Internet Access ZSNet so that I can control who has access to Zscaler Internet Access ZSNet, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Tutorial: Microsoft Entra single sign-on (SSO) integration with Zscaler Internet Access ZSNet

In this tutorial, you'll learn how to integrate Zscaler Internet Access ZSNet with Microsoft Entra ID. When you integrate Zscaler Internet Access ZSNet with Microsoft Entra ID, you can:

- Control in Microsoft Entra ID who has access to Zscaler Internet Access ZSNet.
- Enable your users to be automatically signed-in to Zscaler Internet Access ZSNet with their Microsoft Entra accounts.
- Manage your accounts in one central location.

## Prerequisites

To get started, you need the following items:

- A Microsoft Entra subscription. If you don't have a subscription, you can get a [free account](https://azure.microsoft.com/free/).
- Zscaler Internet Access ZSNet single sign-on (SSO) enabled subscription.

## Scenario description

In this tutorial, you configure and test Microsoft Entra SSO in a test environment.

* Zscaler Internet Access ZSNet supports **SP** initiated SSO.
* Zscaler Internet Access ZSNet supports **Just In Time** user provisioning.
* Zscaler Internet Access ZSNet supports [Automated user provisioning](zscaler-provisioning-tutorial.md).

## Adding Zscaler Internet Access ZSNet from the gallery

To configure the integration of Zscaler Internet Access ZSNet into Microsoft Entra ID, you need to add Zscaler Internet Access ZSNet from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Identity** > **Applications** > **Enterprise applications** > **New application**.
1. In the **Add from the gallery** section, type **Zscaler Internet Access ZSNet** in the search box.
1. Select **Zscaler Internet Access ZSNet** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, as well as walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)

<a name='configure-and-test-azure-ad-sso-for-zscaler'></a>

## Configure and test Microsoft Entra SSO for Zscaler Internet Access ZSNet

Configure and test Microsoft Entra SSO with Zscaler Internet Access ZSNet using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Zscaler Internet Access ZSNet.

To configure and test Microsoft Entra SSO with Zscaler Internet Access ZSNet, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
   1. **[Create a Microsoft Entra test user](#create-an-azure-ad-test-user)** - to test Microsoft Entra single sign-on with B.Simon.
   1. **[Assign the Microsoft Entra test user](#assign-the-azure-ad-test-user)** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Zscaler Internet Access ZSNet SSO](#configure-zscaler-internet-access-zsnet-sso)** - to configure the Single Sign-On settings on application side.
   1. **[Create Zscaler Internet Access ZSNet test user](#create-zscaler-internet-access-zsnet-test-user)** - to have a counterpart of B.Simon in Zscaler Internet Access ZSNet that is linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Identity** > **Applications** > **Enterprise applications** > **Zscaler Internet Access ZSNet** application integration page, find the **Manage** section and select **Single sign-on**.
1. On the **Select a Single sign-on method** page, select **SAML**.
1. On the **Set up Single Sign-On with SAML** page, click the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, enter the values for the following fields:

   In the **Sign-on URL** text box, type a URL using the following pattern:
   `https://<companyname>.zscaler.net`

   > [!NOTE]
   > The value is not real. Update the value with the actual Sign-On URL. Contact [Zscaler Internet Access ZSNet Client support team](https://www.zscaler.com/company/contact) to get the value. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. Your Zscaler Internet Access ZSNet application expects the SAML assertions in a specific format, which requires you to add custom attribute mappings to your SAML token attributes configuration. The following screenshot shows the list of default attributes. Click **Edit** icon to open **User Attributes** dialog.

   ![Screenshot shows User Attributes with the Edit icon selected.](common/edit-attribute.png)

1. In addition to above, Zscaler Internet Access ZSNet application expects few more attributes to be passed back in SAML response. In the **User Claims** section on the **User Attributes** dialog, perform the following steps to add SAML token attribute as shown in the below table:

   | Name     | Source Attribute   |
   | -------- | ------------------ |
   | memberOf | user.assignedroles |

   a. Click **Add new claim** to open the **Manage user claims** dialog.

   b. In the **Name** textbox, type the attribute name shown for that row.

   c. Leave the **Namespace** blank.

   d. Select Source as **Attribute**.

   e. From the **Source attribute** list, type the attribute value shown for that row.

   f. Click **Save**.

   > [!NOTE]
   > Please click [here](~/identity-platform/howto-add-app-roles-in-apps.md#app-roles-ui) to know how to configure Role in Microsoft Entra ID.

1. On the **Set up Single Sign-On with SAML** page, in the **SAML Signing Certificate** section, find **Certificate (Base64)** and select **Download** to download the certificate and save it on your computer.

   ![The Certificate download link](common/certificatebase64.png)

1. On the **Set up Zscaler Internet Access ZSNet** section, copy the appropriate URL(s) based on your requirement.

   ![Copy configuration URLs](common/copy-configuration-urls.png)

<a name='create-an-azure-ad-test-user'></a>

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

<a name='assign-the-azure-ad-test-user'></a>

### Assign the Microsoft Entra test user

In this section, you'll enable B.Simon to use single sign-on by granting access to Zscaler Internet Access ZSNet.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Identity** > **Applications** > **Enterprise applications** > **Zscaler Internet Access ZSNet**.
1. In the app's overview page, find the **Manage** section and select **Users and groups**.
1. Select **Add user**, then select **Users and groups** in the **Add Assignment** dialog.
1. In the **Users and groups** dialog, select **B.Simon** from the Users list, then click the **Select** button at the bottom of the screen.
1. If you have setup the roles as explained in the above, you can select it from the **Select a role** dropdown.
1. In the **Add Assignment** dialog, click the **Assign** button.

## Configure Zscaler Internet Access ZSNet SSO
1. In a different web browser window, sign in to your Zscaler Internet Access ZSNet company site as an administrator

1. Go to **Administration > Authentication > Authentication Settings** and perform the following steps:

   ![Screenshot shows the Zscaler One site with steps as described.](./media/zscaler-tutorial/ic800206.png "Administration")

   a. Under Authentication Type, choose **SAML**.

   b. Click **Configure SAML**.

1. On the **Edit SAML** window, perform the following steps: and click Save.

   ![Manage Users & Authentication](./media/zscaler-tutorial/ic800208.png "Manage Users & Authentication")

   a. In the **SAML Portal URL** textbox, Paste the **Login URL**..

   b. In the **Login Name Attribute** textbox, enter **NameID**.

   c. Click **Upload**, to upload the Azure SAML signing certificate that you have downloaded from Azure portal in the **Public SSL Certificate**.

   d. Toggle the **Enable SAML Auto-Provisioning**.

   e. In the **User Display Name Attribute** textbox, enter **displayName** if you want to enable SAML auto-provisioning for displayName attributes.

   f. In the **Group Name Attribute** textbox, enter **memberOf** if you want to enable SAML auto-provisioning for memberOf attributes.

   g. In the **Department Name Attribute** Enter **department** if you want to enable SAML auto-provisioning for department attributes.

   h. Click **Save**.

1. On the **Configure User Authentication** dialog page, perform the following steps:

   ![Screenshot shows the Configure User Authentication dialog box with Activate selected.](./media/zscaler-tutorial/ic800207.png)

   a. Hover over the **Activation** menu near the bottom left.

   b. Click **Activate**.

## Configuring proxy settings

### To configure the proxy settings in Internet Explorer

1. Start **Internet Explorer**.

1. Select **Internet options** from the **Tools** menu for open the **Internet Options** dialog.

   ![Internet Options](./media/zscaler-tutorial/ic769492.png "Internet Options")

1. Click the **Connections** tab.

   ![Connections](./media/zscaler-tutorial/ic769493.png "Connections")

1. Click **LAN settings** to open the **LAN Settings** dialog.

1. In the Proxy server section, perform the following steps:

   ![Proxy server](./media/zscaler-tutorial/ic769494.png "Proxy server")

   a. Select **Use a proxy server for your LAN**.

   b. In the Address textbox, type **gateway.zscaler.net**.

   c. In the Port textbox, type **80**.

   d. Select **Bypass proxy server for local addresses**.

   e. Click **OK** to close the **Local Area Network (LAN) Settings** dialog.

1. Click **OK** to close the **Internet Options** dialog.

### Create Zscaler Internet Access ZSNet test user

In this section, a user called Britta Simon is created in Zscaler Internet Access ZSNet. Zscaler Internet Access ZSNet supports just-in-time user provisioning, which is enabled by default. There is no action item for you in this section. If a user doesn't already exist in Zscaler Internet Access ZSNet, a new one is created after authentication.

> [!Note]
> If you need to create a user manually, contact [Zscaler Internet Access ZSNet support team](https://www.zscaler.com/company/contact).

## Test SSO

In this section, you test your Microsoft Entra single sign-on configuration with following options.

- Click on **Test this application**, this will redirect to Zscaler Internet Access ZSNet Sign-on URL where you can initiate the login flow.

- Go to Zscaler Internet Access ZSNet Sign-on URL directly and initiate the login flow from there.

- You can use Microsoft My Apps. When you click the Zscaler Internet Access ZSNet tile in the My Apps, this will redirect to Zscaler Internet Access ZSNet Sign-on URL. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Next steps

Once you configure Zscaler Internet Access ZSNet you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-any-app).
