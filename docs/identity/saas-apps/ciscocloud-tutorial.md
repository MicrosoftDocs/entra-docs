---
title: Configure Cisco Cloud for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Cisco Cloud.

author: nguhiu
manager: CelesteDG
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Cisco Cloud so that I can control who has access to Cisco Cloud, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---
# Configure Cisco Cloud for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Cisco Cloud with Microsoft Entra ID. When you integrate Cisco Cloud with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Cisco Cloud.
* Enable your users to be automatically signed-in to Cisco Cloud with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* Cisco Cloud single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra single sign-on in a test environment.

* Cisco Cloud supports **SP and IDP** initiated SSO.

## Add Cisco Cloud from the gallery

To configure the integration of Cisco Cloud into Microsoft Entra ID, you need to add Cisco Cloud from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Cisco Cloud** in the search box.
1. Select **Cisco Cloud** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 [!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)]

<a name='configure-and-test-azure-ad-sso-for-cisco-cloud'></a>

## Configure and test Microsoft Entra SSO for Cisco Cloud

Configure and test Microsoft Entra SSO with Cisco Cloud using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Cisco Cloud.

To configure and test Microsoft Entra SSO with Cisco Cloud, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Cisco Cloud SSO](#configure-cisco-cloud-sso)** - to configure the single sign-on settings on application side.
    1. **[Create Cisco Cloud test user](#create-cisco-cloud-test-user)** - to have a counterpart of B.Simon in Cisco Cloud that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Cisco Cloud** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, If you wish to configure the application in **IDP** initiated mode, perform the following steps:

    a. In the **Identifier** text box, type a URL using the following pattern:
    `<subdomain>.cisco.com`

    b. In the **Reply URL** text box, type a URL using the following pattern:
    `https://<subdomain>.cisco.com/sp/ACS.saml2`

5. Select **Set additional URLs** and perform the following step if you wish to configure the application in **SP** initiated mode:

    In the **Sign-on URL** text box, type a URL using the following pattern:
    `https://<subdomain>.cloudapps.cisco.com`

    > [!NOTE]
    > These values aren't real. Update these values with the actual Identifier, Reply URL and Sign-on URL. Contact [Cisco Cloud Client support team](mailto:cpr-ops@cisco.com) to get these values. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

6. Your Cisco Cloud application expects the SAML assertions in a specific format, which requires you to add custom attribute mappings to your SAML token attributes configuration. The following screenshot shows the list of default attributes. Select **Edit** icon to open User Attributes dialog.

    ![Screenshot shows User Attributes with the Edit icon selected.](common/edit-attribute.png)

7. In addition to above, Cisco Cloud application expects few more attributes to be passed back in SAML response. In the **User Claims** section on the **User Attributes** dialog, perform the following steps to add SAML token attribute as shown in the below table:

    | Name | Source Attribute|
    | -----------| ------------|
    | country    | user.country |
    | company    | user.companyname |
    | | |

    a. Select **Add new claim** to open the **Manage user claims** dialog.

    ![Screenshot shows User claims with the option to Add new claim.](common/new-save-attribute.png)

    ![Screenshot shows the Manage user claims dialog box where you can enter the values described.](common/new-attribute-details.png)

    b. In the **Name** textbox, type the attribute name shown for that row.

    c. Leave the **Namespace** blank.

    d. Select Source as **Attribute**.

    e. From the **Source attribute** list, type the attribute value shown for that row.

    f. Select **Ok**

    g. Select **Save**.

8. On the **Set up Single Sign-On with SAML** page, In the **SAML Signing Certificate** section, select copy button to copy **App Federation Metadata Url** and save it on your computer.

    ![The Certificate download link](common/copy-metadataurl.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Cisco Cloud SSO

To configure single sign-on on **Cisco Cloud** side, you need to send the **App Federation Metadata Url** to [Cisco Cloud support team](mailto:cpr-ops@cisco.com). They set this setting to have the SAML SSO connection set properly on both sides.

### Create Cisco Cloud test user

In this section, you create a user called Britta Simon in Cisco Cloud. Work with [Cisco Cloud support team](mailto:cpr-ops@cisco.com) to add the users in the Cisco Cloud platform. Users must be created and activated before you use single sign-on.

## Test SSO

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

#### SP initiated:

* Select **Test this application**, this option redirects to Cisco Cloud Sign on URL where you can initiate the login flow.  

* Go to Cisco Cloud Sign-on URL directly and initiate the login flow from there.

#### IDP initiated:

* Select **Test this application**, and you should be automatically signed in to the Cisco Cloud for which you set up the SSO. 

You can also use Microsoft My Apps to test the application in any mode. When you select the Cisco Cloud tile in the My Apps, if configured in SP mode you would be redirected to the application sign on page for initiating the login flow and if configured in IDP mode, you should be automatically signed in to the Cisco Cloud for which you set up the SSO. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Related content

Once you configure Cisco Cloud you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-any-app).
