---
title: 'Tutorial: Microsoft Entra integration with Sansan'
description: Learn how to configure single sign-on between Microsoft Entra ID and Sansan.

author: jeevansd
manager: CelesteDG
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: tutorial
ms.date: 11/21/2022
ms.author: jeedes

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Sansan so that I can control who has access to Sansan, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Tutorial: Integrate Sansan with Microsoft Entra ID

In this tutorial, you'll learn how to integrate Sansan with Microsoft Entra ID. When you integrate Sansan with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Sansan.
* Enable your users to be automatically signed-in to Sansan with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

To get started, you need the following items:

* A Microsoft Entra subscription. If you don't have a subscription, you can get a [free account](https://azure.microsoft.com/free/).
* Sansan single sign-on (SSO) enabled subscription.

## Scenario description

In this tutorial, you configure and test Microsoft Entra SSO in a test environment.
* Sansan supports **SP** initiated SSO.

## Add Sansan from the gallery

To configure the integration of Sansan into Microsoft Entra ID, you need to add Sansan from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Identity** > **Applications** > **Enterprise applications** > **New application**.
1. In the **Add from the gallery** section, type **Sansan** in the search box.
1. Select **Sansan** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, as well as walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)

<a name='configure-and-test-azure-ad-sso-for-sansan'></a>

## Configure and test Microsoft Entra SSO for Sansan

Configure and test Microsoft Entra SSO with Sansan using a test user called **Britta Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Sansan.

To configure and test Microsoft Entra SSO with Sansan, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** to enable your users to use this feature.
   1. **[Create a Microsoft Entra test user](#create-an-azure-ad-test-user)** to test Microsoft Entra single sign-on with Britta Simon.
   1. **[Assign the Microsoft Entra test user](#assign-the-azure-ad-test-user)** to enable Britta Simon to use Microsoft Entra single sign-on.
1. **[Configure Sansan SSO](#configure-sansan-sso)** to configure the SSO settings on application side.
   1. **[Create Sansan test user](#create-sansan-test-user)** to have a counterpart of Britta Simon in Sansan that is linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Identity** > **Applications** > **Enterprise applications** > **Sansan** application integration page, find the **Manage** section and select **Single sign-on**.
1. On the **Select a Single sign-on method** page, select **SAML**.
1. On the **Set up Single Sign-On with SAML** page, click the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** page, perform the following steps:

   1. In the **Identifier (Entity ID)** text box, type a URL using the following pattern: 
   `https://ap.sansan.com/saml2/<COMPANY_NAME>`

   1. In the **Reply URL** text box, type a URL using one of the following patterns:
    
       | Environment | URL |
      |:--- |:--- |
      | PC |`https://ap.sansan.com/v/saml2/<COMPANY_NAME>/acs` |
      | Smartphone App |`https://internal.api.sansan.com/saml2/<COMPANY_NAME>/acs` |
      | Smartphone Web |`https://ap.sansan.com/s/saml2/<COMPANY_NAME>/acs` |

   1. In the **Sign-on URL** text box, type the URL: 
   `https://ap.sansan.com/`

    > [!NOTE]
    > These values are not real. Check the actual Identifier and Reply URL values on the **Sansan admin settings**.

1. On the **Set up Single Sign-On with SAML** page, in the **SAML Signing Certificate** section, find **Certificate (Base64)** and select **Download** to download the certificate and save it on your computer.

   ![The Certificate download link](common/certificatebase64.png)

1. On the **Set up Sansan** section, copy the appropriate URL(s) based on your requirement.

   ![Copy configuration URLs](common/copy-configuration-urls.png)

   ```Logout URL
    https://login.microsoftonline.com/common/wsfederation?wa=wsignout1.0
    ```

<a name='create-an-azure-ad-test-user'></a>

### Create a Microsoft Entra test user

In this section, you'll create a test user called Britta Simon.

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

In this section, you'll enable Britta Simon to use Azure single sign-on by granting access to Sansan.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Identity** > **Applications** > **Enterprise applications** > **Sansan**.
1. In the app's overview page, find the **Manage** section and select **Users and groups**.
1. Select **Add user**, then select **Users and groups** in the **Add Assignment** dialog.
1. In the **Users and groups** dialog, select **Britta Simon** from the Users list, then click the **Select** button at the bottom of the screen.
1. If you're expecting any role value in the SAML assertion, in the **Select Role** dialog, select the appropriate role for the user from the list and then click the **Select** button at the bottom of the screen.
1. In the **Add Assignment** dialog, click the **Assign** button.

## Configure Sansan SSO

To perform the **Single Sign-On settings** on the **Sansan** side, please follow the below steps according to your requirement.

   * [Japanese](https://jp-help.sansan.com/hc/ja/articles/900001551383) version.

   * [English](https://jp-help.sansan.com/hc/en-us/articles/900001551383) version.


### Create Sansan test user

In this section, you create a user called Britta Simon in Sansan. For more information on how to create a user, please refer [these](https://jp-help.sansan.com/hc/articles/206508997-Adding-users) steps.

## Test SSO

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

* Click on **Test this application**, this will redirect to Sansan Sign-on URL where you can initiate the login flow. 

* Go to Sansan Sign-on URL directly and initiate the login flow from there.

* You can use Microsoft My Apps. When you click the Sansan tile in the My Apps, this will redirect to Sansan Sign-on URL. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Next steps

Once you configure Sansan you can enforce session control, which protects exfiltration and infiltration of your organization's sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-aad).
