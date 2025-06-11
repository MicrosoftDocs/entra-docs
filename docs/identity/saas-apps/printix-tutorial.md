---
title: Configure Printix for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Printix.
author: nguhiu
manager: CelesteDG
ms.service: entra-id
ms.subservice: saas-apps
ms.topic: how-to
ms.date: 05/20/2025
ms.author: gideonkiratu
ms.custom: sfi-image-nochange
# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Printix so that I can control who has access to Printix, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---
# Configure Printix for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Printix with Microsoft Entra ID. When you integrate Printix with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Printix.
* Enable your users to be automatically signed-in to Printix with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

To get started, you need the following items:

* A Microsoft Entra subscription. If you don't have a subscription, you can get a [free account](https://azure.microsoft.com/free/).
* Printix single sign-on (SSO) enabled subscription.
* Along with Cloud Application Administrator, Application Administrator can also add or manage applications in Microsoft Entra ID.
For more information, see [Azure built-in roles](~/identity/role-based-access-control/permissions-reference.md).

> [!NOTE]
> To test the steps in this article,  we don't recommend using a production environment.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* Rootly supports **SP** initiated SSO.
* Rootly supports **Just In Time** user provisioning.

> [!NOTE]
> Identifier of this application is a fixed string value so only one instance can be configured in one tenant.

## Add Printix from the gallery

To configure the integration of Printix into Microsoft Entra ID, you need to add Printix from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Printix** in the search box.
1. Select **Printix** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, and walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)

<a name='-configuring-and-testing-azure-ad-sso-for-printix'></a>

##  Configuring and testing Microsoft Entra SSO for Printix

In this section, you configure and test Microsoft Entra single sign-on with Printix based on a test user called "Britta Simon".

For single sign-on to work, Microsoft Entra ID needs to know what the counterpart user in Printix is to a user in Microsoft Entra ID. In other words, a link relationship between a Microsoft Entra user and the related user in Printix needs to be established.

In Printix, assign the value of the **user name** in Microsoft Entra ID as the value of the **Username** to establish the link relationship.

To configure and test Microsoft Entra single sign-on with Printix, you need to perform the following steps:

1. **[Configuring Microsoft Entra SSO](#configuring-azure-ad-sso)** - to enable your users to use this feature.
	1. **[Creating a Microsoft Entra test user](#creating-an-azure-ad-test-user)** - to test Microsoft Entra single sign-on with Britta Simon.
	1. **[Assigning the Microsoft Entra test user](#assigning-the-azure-ad-test-user)** - to enable Britta Simon to use Microsoft Entra single sign-on.

1. **[Creating a Printix test user](#creating-a-printix-test-user)** - to have a counterpart of Britta Simon in Printix that's linked to the Microsoft Entra representation of user.

1. **[Testing SSO](#testing-sso)** - to verify whether the configuration works.

<a name='configuring-azure-ad-sso'></a>

## Configuring Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Printix** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

    ![Screenshot shows to edit Basic S A M L Configuration.](common/edit-urls.png "Basic Configuration")

1. On the **Printix Domain and URLs** section, perform the following step:

    In the **Sign-on URL** textbox, type a URL using the following pattern: `https://<subdomain>.printix.net`

	> [!NOTE] 
	> The value isn't real. Update the value with the actual Sign-On URL. Contact [Printix Client support team](mailto:support@printix.net) to get the value. 
 
1. On the **Set-up single sign-on with SAML** page, in the **SAML Signing Certificate** section,  find **Federation Metadata XML** and select **Download** to download the certificate and save it on your computer.

    ![Screenshot shows the Certificate download link.](common/metadataxml.png "Certificate") 

1. Select **Save** button.

1. Sign on to your Printix tenant as an administrator.

1. In the menu on the top, select the icon at the upper right corner and select "**Authentication**".
   
    ![Screenshot shows Authentication selected from the menu.](./media/printix-tutorial/menu.png "Authentication")

1. On the **Setup** tab, select **Enable Azure/Office 365 authentication**.

1. On the **Azure** tab, input federation metadata URL to the textbox of "**Federation metadata document**". 

    Attach the metadata xml file, which you downloaded from Microsoft Entra ID to [Printix support team](mailto:support@printix.net). Then they upload the xml file and provide a federation metadata URL.
   
    ![Screenshot shows the Printix.net page where you can specify a Federation metadata document.](./media/printix-tutorial/metadata.png "Federation")
   
1. Select the "**Test**" button and select "**OK**" button if the test was successful.
   
    Microsoft Entra ID page will show after selecting the **test** button. "The test was successful" here means after entering the credentials of your Azure test account it will pop up a message "Settings tested OK".Then select the **OK** button.
   
    ![Screenshot shows the results of the test.](./media/printix-tutorial/test.png "Results")

1. Select the **Save** button on "**Authentication**" page.

> [!TIP]
> You can now read a concise version of these instructions inside the [Azure portal](https://portal.azure.com), while you're setting up the app!  After adding this app from the **Active Directory > Enterprise Applications** section, simply select the **Single Sign-On** tab and access the embedded documentation through the **Configuration** section at the bottom. You can read more about the embedded documentation feature here: [Microsoft Entra ID embedded documentation](https://go.microsoft.com/fwlink/?linkid=845985)
> 

<a name='creating-an-azure-ad-test-user'></a>

### Creating a Microsoft Entra test user

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

<a name='assigning-the-azure-ad-test-user'></a>

### Assigning the Microsoft Entra test user

In this section, you enable B.Simon to use single sign-on by granting access to Printix.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Printix**.
1. In the app's overview page, select **Users and groups**.
1. Select **Add user/group**, then select **Users and groups** in the **Add Assignment** dialog.
   1. In the **Users and groups** dialog, select **B.Simon** from the Users list, then select the **Select** button at the bottom of the screen.
   1. If you're expecting a role to be assigned to the users, you can select it from the **Select a role** dropdown. If no role has been set up for this app, you see "Default Access" role selected.
   1. In the **Add Assignment** dialog, select the **Assign** button.
	
## Creating a Printix test user

The objective of this section is to create a user called Britta Simon in Printix. Printix supports just-in-time provisioning, which is by default enabled.

There's no action item for you in this section. A new user is created during an attempt to access Printix if it doesn't exist yet. 

> [!NOTE]
> If you need to create a user manually, you need to contact the [Printix support team](mailto:support@printix.net).
> 

## Testing SSO

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

* Select **Test this application**, this option redirects to Printix Sign-on URL where you can initiate the login flow. 

* Go to Printix Sign-on URL directly and initiate the login flow from there.

* You can use Microsoft My Apps. When you select the Printix tile in the My Apps, this option redirects to Printix Sign-on URL. For more information, see [Microsoft Entra My Apps](/azure/active-directory/manage-apps/end-user-experiences#azure-ad-my-apps).

## Related content

Once you configure Printix you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Cloud App Security](/cloud-app-security/proxy-deployment-aad).
