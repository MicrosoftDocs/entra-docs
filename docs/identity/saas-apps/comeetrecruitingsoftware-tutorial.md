---
title: Configure Comeet Recruiting Software for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Comeet Recruiting Software.

author: nguhiu
manager: CelesteDG
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Comeet Recruiting Software so that I can control who has access to Comeet Recruiting Software, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---
# Configure Comeet Recruiting Software for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Comeet Recruiting Software with Microsoft Entra ID. When you integrate Comeet Recruiting Software with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Comeet Recruiting Software.
* Enable your users to be automatically signed-in to Comeet Recruiting Software with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* Comeet Recruiting Software single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* Comeet Recruiting Software supports **SP and IDP** initiated SSO.
* Comeet Recruiting Software supports [Automated user provisioning](comeet-recruiting-software-provisioning-tutorial.md).


## Add Comeet Recruiting Software from the gallery

To configure the integration of Comeet Recruiting Software into Microsoft Entra ID, you need to add Comeet Recruiting Software from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Comeet Recruiting Software** in the search box.
1. Select **Comeet Recruiting Software** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 [!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)]


<a name='configure-and-test-azure-ad-sso-for-comeet-recruiting-software'></a>

## Configure and test Microsoft Entra SSO for Comeet Recruiting Software

Configure and test Microsoft Entra SSO with Comeet Recruiting Software using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Comeet Recruiting Software.

To configure and test Microsoft Entra SSO with Comeet Recruiting Software, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with Britta Simon.
    1. **Assign the Microsoft Entra test user** - to enable Britta Simon to use Microsoft Entra single sign-on.
2. **[Configure Comeet Recruiting Software SSO](#configure-comeet-recruiting-software-sso)** - to configure the Single Sign-On settings on application side.
    1. **[Create Comeet Recruiting Software test user](#create-comeet-recruiting-software-test-user)** - to have a counterpart of Britta Simon in Comeet Recruiting Software that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Comeet Recruiting Software** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, If you wish to configure the application in **IDP** initiated mode, perform the following steps:

    a. In the **Identifier** text box, type a URL using the following pattern:
    `https://app.comeet.co/adfs_auth/acs/<UNIQUEID>/`

    b. In the **Reply URL** text box, type a URL using the following pattern:
    `https://app.comeet.co/adfs_auth/acs/<UNIQUEID>/`

    > [!NOTE]
    > These values aren't real. Update these values with the actual Identifier, and Reply URL. Contact [Comeet Recruiting Software Client support team](https://support.comeet.co/knowledgebase/adfs-single-sign-on/) to get these values. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

5. Select **Set additional URLs** and perform the following step if you wish to configure the application in **SP** initiated mode:

    In the **Sign-on URL** text box, type a URL:
    `https://app.comeet.co`

5. Comeet Recruiting Software application expects the SAML assertions in a specific format. Configure the following claims for this application. You can manage the values of these attributes from the **User Attributes** section on application integration page. On the **Set up Single Sign-On with SAML** page, select **Edit** button to open **User Attributes** dialog.

    ![Screenshot that shows the "User Attributes" section with the "Edit" button selected.](common/edit-attribute.png)

6. In the **User Claims** section on the **User Attributes** dialog, edit the claims by using **Edit icon** or add the claims by using **Add new claim** to configure SAML token attribute as shown in the image above and perform the following steps: 

    | Name |  Source Attribute|
    | ---------------| --------------- |
    | nameidentifier | user.mail |
    | comeet_id | user.userprincipalname |

    a. Select **Add new claim** to open the **Manage user claims** dialog.

    ![Screenshot that shows the "User claims" section with the "Add new claim" and "Save" actions highlighted.](common/new-save-attribute.png)

    ![image](common/new-attribute-details.png)

    b. In the **Name** textbox, type the attribute name shown for that row.

    c. Leave the **Namespace** blank.

    d. Select Source as **Attribute**.

    e. From the **Source attribute** list, type the attribute value shown for that row.

    f. Select **Ok**

    g. Select **Save**.

4. On the **Set up Single Sign-On with SAML** page, in the **SAML Signing Certificate** section, select **Download** to download the **Federation Metadata XML** from the given options as per your requirement and save it on your computer.

    ![The Certificate download link](common/metadataxml.png)

6. On the **Set up Comeet Recruiting Software** section, copy the appropriate URL(s) as per your requirement.

    ![Copy configuration URLs](common/copy-configuration-urls.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Comeet Recruiting Software SSO

To configure single sign-on on **Comeet Recruiting Software** side, you need to send the downloaded **Federation Metadata XML** and appropriate copied URLs from the application configuration to [Comeet Recruiting Software support team](https://support.comeet.co/knowledgebase/adfs-single-sign-on/). They set this setting to have the SAML SSO connection set properly on both sides.

### Create Comeet Recruiting Software test user

In this section, you create a user called Britta Simon in Comeet Recruiting Software. Work with [Comeet Recruiting Software support team](mailto:support@comeet.co) to add the users in the Comeet Recruiting Software platform. Users must be created and activated before you use single sign-on.

Comeet Recruiting Software also supports automatic user provisioning, you can find more details [here](./comeet-recruiting-software-provisioning-tutorial.md) on how to configure automatic user provisioning.

### Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options.

SP initiated:

* Select **Test this application**, this option redirects to Comeet Recruiting Software Sign on URL where you can initiate the login flow.

* Go to Comeet Recruiting Software Sign-on URL directly and initiate the login flow from there.

IDP initiated:

* Select **Test this application**, and you should be automatically signed in to the Comeet Recruiting Software for which you set up the SSO

You can also use Microsoft My Apps to test the application in any mode. When you select the Comeet Recruiting Software tile in the My Apps, if configured in SP mode you would be redirected to the application sign on page for initiating the login flow and if configured in IDP mode, you should be automatically signed in to the Comeet Recruiting Software for which you set up the SSO. For more information, see [Microsoft Entra My Apps](/azure/active-directory/manage-apps/end-user-experiences#azure-ad-my-apps).


## Related content

Once you configure Comeet Recruiting Software you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-any-app).
