---
title: Configure Timetabling Solutions for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Timetabling Solutions.
author: nguhiu
manager: mwongerapk
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps
ms.topic: how-to
ms.date: 05/20/2025
ms.author: gideonkiratu
ms.custom: sfi-image-nochange
# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Timetabling Solutions so that I can control who has access to Timetabling Solutions, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure Timetabling Solutions for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Timetabling Solutions with Microsoft Entra ID. When you integrate Timetabling Solutions with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Timetabling Solutions.
* Enable your users to be automatically signed-in to Timetabling Solutions with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

To get started, you need the following items:

* A Microsoft Entra subscription. If you don't have a subscription, you can get a [free account](https://azure.microsoft.com/free/).
* Timetabling Solutions single sign-on (SSO) enabled subscription.
* Along with Cloud Application Administrator, Application Administrator can also add or manage applications in Microsoft Entra ID.
For more information, see [Azure built-in roles](~/identity/role-based-access-control/permissions-reference.md).

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* Timetabling Solutions supports **SP** initiated SSO.

> [!NOTE]
> Identifier of this application is a fixed string value so only one instance can be configured in one tenant.

## Add Timetabling Solutions from the gallery

To configure the integration of Timetabling Solutions into Microsoft Entra ID, you need to add Timetabling Solutions from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Timetabling Solutions** in the search box.
1. Select **Timetabling Solutions** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

<a name='configure-and-test-azure-ad-sso-for-timetabling-solutions'></a>

## Configure and test Microsoft Entra SSO for Timetabling Solutions

Configure and test Microsoft Entra SSO with Timetabling Solutions using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Timetabling Solutions.

To configure and test Microsoft Entra SSO with Timetabling Solutions, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Timetabling Solutions SSO](#configure-timetabling-solutions-sso)** - to configure the single sign-on settings on application side.
    1. **[Create Timetabling Solutions test user](#create-timetabling-solutions-test-user)** - to have a counterpart of B.Simon in Timetabling Solutions that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Timetabling Solutions** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Screenshot shows to edit Basic S A M L Configuration.](common/edit-urls.png "Basic Configuration")

1. On the **Basic SAML Configuration** section, perform the following steps:

    a. In the **Identifier (Entity ID)** text box, type the URL:
     `https://auth.timetabling.education`

    b. In the **Reply URL (Assertion Consumer Service URL)** text box, type the URL:
     `https://auth.timetabling.education`
     
    c. In the **Sign-on URL** text box, type the URL:
     `https://auth.timetabling.education`

1. In the **SAML Signing Certificate** section, select **Edit** button to open **SAML Signing Certificate** dialog.

	![Screenshot shows to edit SAML Signing Certificate.](common/edit-certificate.png "Certificate")

1. In the **SAML Signing Certificate** section, copy the **Thumbprint Value** and save it on your computer.

    ![Screenshot shows to copy thumbprint value.](common/copy-thumbprint.png "Thumbprint")

1. On the **Set up Timetabling Solutions** section, copy the appropriate URL(s) based on your requirement.

	![Screenshot shows to copy configuration appropriate U R L.](common/copy-configuration-urls.png "Metadata")

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Timetabling Solutions SSO

In this section, you populate the relevant SSO values in the Timetabling Solutions Administration Console.

1. In the [Administration Console](https://admin.timetabling.education/), select **5 Settings**, and then select the **SAML SSO** tab.
1. Perform the following steps in the **SAML SSO** section:
 
    ![Screenshot for SSO settings.](./media/timetabling-solutions-tutorial/timetabling-configuration.png)

    a. Enable SAML Integration.

    b. In the **SAML Login Path** textbox, paste the **Login URL** value, which you copied previously.

    c. In the **SAML Logout Path** textbox, paste the **Logout URL** value, which you copied previously.

    d. In the **SAML Certificate Fingerprint** textbox, paste the **Thumbprint Value**, which you copied previously.

    e. Enter the **Custom Domain** name.
    
    f. **Save** the settings. 


## Create Timetabling Solutions test user

In this section, you create a user called Britta Simon in the Timetabling Solutions Administration Console. 

1. In the [Administration Console](https://admin.timetabling.education/), select **1 Manage Users**, and select **Add**.
2. Enter the mandatory fields **First Name**, **Family Name** and **Email Address**. Add other appropriate values in the non-mandatory fields.
3. Ensure **Online** is active in Status.
4. Select **Save and Next**.


> [!NOTE]
> To add the users in the Timetabling Solutions platform. Users must be created and activated before you use single sign-on.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

* Select **Test this application**, this option redirects to Timetabling Solutions Sign-On URL where you can initiate the login flow. 

* Go to Timetabling Solutions Sign-On URL directly and initiate the login flow from there.

* You can use Microsoft My Apps. When you select the Timetabling Solutions tile in the My Apps, this option redirects to Timetabling Solutions Sign-On URL. For more information, see [Microsoft Entra My Apps](/azure/active-directory/manage-apps/end-user-experiences#azure-ad-my-apps).

## Related content

Once you configure Timetabling Solutions you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Cloud App Security](/cloud-app-security/proxy-deployment-aad).
