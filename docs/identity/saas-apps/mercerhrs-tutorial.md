---
title: 'Tutorial: Microsoft Entra integration with Mercer BenefitsCentral (MBC)'
description: Learn how to configure single sign-on between Microsoft Entra ID and Mercer BenefitsCentral (MBC).

author: jeevansd
manager: CelesteDG
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: tutorial
ms.date: 03/25/2024
ms.author: jeedes

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Mercer BenefitsCentral (MBC) so that I can control who has access to Mercer BenefitsCentral (MBC), enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---
# Tutorial: Microsoft Entra integration with Mercer BenefitsCentral (MBC)

In this tutorial, you learn how to integrate Mercer BenefitsCentral (MBC) with Microsoft Entra ID.
Integrating Mercer BenefitsCentral (MBC) with Microsoft Entra ID provides you with the following benefits:

* You can control in Microsoft Entra ID who has access to Mercer BenefitsCentral (MBC).
* You can enable your users to be automatically signed-in to Mercer BenefitsCentral (MBC) (Single Sign-On) with their Microsoft Entra accounts.
* You can manage your accounts in one central location.

If you want to know more details about SaaS app integration with Microsoft Entra ID, see [What is application access and single sign-on with Microsoft Entra ID](~/identity/enterprise-apps/what-is-single-sign-on.md).
If you don't have an Azure subscription, [create a free account](https://azure.microsoft.com/free/) before you begin.

## Prerequisites

To configure Microsoft Entra integration with Mercer BenefitsCentral (MBC), you need the following items:

* A Microsoft Entra subscription. If you don't have a Microsoft Entra environment, you can get one-month trial [here](https://azure.microsoft.com/pricing/free-trial/)
* Mercer BenefitsCentral (MBC) single sign-on enabled subscription

## Scenario description

In this tutorial, you configure and test Microsoft Entra single sign-on in a test environment.

* Mercer BenefitsCentral (MBC) supports **IDP** initiated SSO

## Adding Mercer BenefitsCentral (MBC) from the gallery

To configure the integration of Mercer BenefitsCentral (MBC) into Microsoft Entra ID, you need to add Mercer BenefitsCentral (MBC) from the gallery to your list of managed SaaS apps.

**To add Mercer BenefitsCentral (MBC) from the gallery, perform the following steps:**

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Identity** > **Applications** > **Enterprise applications** > **New application**.
1. In the search box, type **Mercer BenefitsCentral (MBC)**, select **Mercer BenefitsCentral (MBC)** from result panel then click **Add** button to add the application.

	 ![Mercer BenefitsCentral (MBC) in the results list](common/search-new-app.png)

<a name='configure-and-test-azure-ad-single-sign-on'></a>

## Configure and test Microsoft Entra single sign-on

In this section, you configure and test Microsoft Entra single sign-on with Mercer BenefitsCentral (MBC) based on a test user called **Britta Simon**.
For single sign-on to work, a link relationship between a Microsoft Entra user and the related user in Mercer BenefitsCentral (MBC) needs to be established.

To configure and test Microsoft Entra single sign-on with Mercer BenefitsCentral (MBC), you need to complete the following building blocks:

1. **[Configure Microsoft Entra Single Sign-On](#configure-azure-ad-single-sign-on)** - to enable your users to use this feature.
2. **[Configure Mercer BenefitsCentral (MBC) Single Sign-On](#configure-mercer-benefitscentral-mbc-single-sign-on)** - to configure the Single Sign-On settings on application side.
3. **[Create a Microsoft Entra test user](#create-an-azure-ad-test-user)** - to test Microsoft Entra single sign-on with Britta Simon.
4. **[Assign the Microsoft Entra test user](#assign-the-azure-ad-test-user)** - to enable Britta Simon to use Microsoft Entra single sign-on.
5. **[Create Mercer BenefitsCentral (MBC) test user](#create-mercer-benefitscentral-mbc-test-user)** - to have a counterpart of Britta Simon in Mercer BenefitsCentral (MBC) that is linked to the Microsoft Entra representation of user.
6. **[Test single sign-on](#test-single-sign-on)** - to verify whether the configuration works.

<a name='configure-azure-ad-single-sign-on'></a>

### Configure Microsoft Entra single sign-on

In this section, you enable Microsoft Entra single sign-on.

To configure Microsoft Entra single sign-on with Mercer BenefitsCentral (MBC), perform the following steps:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Identity** > **Applications** > **Enterprise applications** > **Mercer BenefitsCentral (MBC)** application integration page, select **Single sign-on**.

    ![Configure single sign-on link](common/select-sso.png)

1. On the **Select a Single sign-on method** dialog, select **SAML/WS-Fed** mode to enable single sign-on.

    ![Single sign-on select mode](common/select-saml-option.png)

1. On the **Set up Single Sign-On with SAML** page, click **Edit** icon to open **Basic SAML Configuration** dialog.

	![Edit Basic SAML Configuration](common/edit-urls.png)

4. On the **Set up Single Sign-On with SAML** page, perform the following steps:

    ![Mercer BenefitsCentral (MBC) Domain and URLs single sign-on information](common/idp-intiated.png)

    a. In the **Identifier** text box, type a URL:
    `stg.mercerhrs.com/saml2.0`

    b. In the **Reply URL** text box, type a URL using the following pattern:
    `https://ssous-stg.mercerhrs.com/SP2/Saml2AssertionConsumer.aspx`

	> [!NOTE]
	> The Reply URL value is not real. Update this value with the actual Reply URL. Contact [Mercer BenefitsCentral (MBC) Client support team](https://www.mercer.com/en-gb/about/contact/contact-us/) to get this value. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. On the **Set up Single Sign-On with SAML** page, in the **SAML Signing Certificate** section, click **Download** to download the **Federation Metadata XML** from the given options as per your requirement and save it on your computer.

	![The Certificate download link](common/metadataxml.png)

6. On the **Set up Mercer BenefitsCentral (MBC)** section, copy the appropriate URL(s) as per your requirement.

	![Copy configuration URLs](common/copy-configuration-urls.png)

	a. Login URL

	b. Microsoft Entra Identifier

	c. Logout URL

### Configure Mercer BenefitsCentral (MBC) Single Sign-On

To configure single sign-on on **Mercer BenefitsCentral (MBC)** side, you need to send the downloaded **Federation Metadata XML** and appropriate copied URLs from the application configuration to [Mercer BenefitsCentral (MBC) support team](https://www.mercer.com/en-gb/about/contact/contact-us/). They set this setting to have the SAML SSO connection set properly on both sides.

<a name='create-an-azure-ad-test-user'></a>

### Create a Microsoft Entra test user 

The objective of this section is to create a test user called Britta Simon.

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

In this section, you enable Britta Simon to use Azure single sign-on by granting access to Mercer BenefitsCentral (MBC).

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Identity** > **Applications** > **Enterprise applications** > **Mercer BenefitsCentral (MBC)**.

	![Enterprise applications blade](common/enterprise-applications.png)

1. In the applications list, select **Mercer BenefitsCentral (MBC)**.

	![The Mercer BenefitsCentral (MBC) link in the Applications list](common/all-applications.png)

1. In the app's overview page, select **Users and groups**.
1. Select **Add user/group**, then select **Users and groups** in the **Add Assignment** dialog.
   1. In the **Users and groups** dialog, select **B.Simon** from the Users list, then click the **Select** button at the bottom of the screen.
   1. If you are expecting a role to be assigned to the users, you can select it from the **Select a role** dropdown. If no role has been set up for this app, you see "Default Access" role selected.
   1. In the **Add Assignment** dialog, click the **Assign** button.

### Create Mercer BenefitsCentral (MBC) test user

In this section, you create a user called Britta Simon in Mercer BenefitsCentral (MBC). Work with [Mercer BenefitsCentral (MBC) support team](https://www.mercer.com/en-gb/about/contact/contact-us/) to add the users in the Mercer BenefitsCentral (MBC) platform. Users must be created and activated before you use single sign-on.

### Test single sign-on 

In this section, you test your Microsoft Entra single sign-on configuration using the Access Panel.

When you click the Mercer BenefitsCentral (MBC) tile in the Access Panel, you should be automatically signed in to the Mercer BenefitsCentral (MBC) for which you set up SSO. For more information about the Access Panel, see [Introduction to the Access Panel](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Additional Resources

- [List of Tutorials on How to Integrate SaaS Apps with Microsoft Entra ID](./tutorial-list.md)

- [What is application access and single sign-on with Microsoft Entra ID?](~/identity/enterprise-apps/what-is-single-sign-on.md)

- [What is Conditional Access in Microsoft Entra ID?](~/identity/conditional-access/overview.md)
