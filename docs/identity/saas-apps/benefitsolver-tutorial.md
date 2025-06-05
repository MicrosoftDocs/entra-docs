---
title: Configure Benefitsolver for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Benefitsolver.

author: nguhiu
manager: CelesteDG
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Benefitsolver so that I can control who has access to Benefitsolver, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---
# Configure Benefitsolver for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Benefitsolver with Microsoft Entra ID. When you integrate Benefitsolver with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Benefitsolver.
* Enable your users to be automatically signed-in to Benefitsolver with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* Benefitsolver single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra single sign-on in a test environment.

* Benefitsolver supports **SP** initiated SSO.

## Add Benefitsolver from the gallery

To configure the integration of Benefitsolver into Microsoft Entra ID, you need to add Benefitsolver from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Benefitsolver** in the search box.
1. Select **Benefitsolver** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 [!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)]

<a name='configure-and-test-azure-ad-sso-for-benefitsolver'></a>

## Configure and test Microsoft Entra SSO for Benefitsolver

Configure and test Microsoft Entra SSO with Benefitsolver using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Benefitsolver.

To configure and test Microsoft Entra SSO with Benefitsolver, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Benefitsolver SSO](#configure-benefitsolver-sso)** - to configure the single sign-on settings on application side.
    1. **[Create Benefitsolver test user](#create-benefitsolver-test-user)** - to have a counterpart of B.Simon in Benefitsolver that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Benefitsolver** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, perform the following steps:

    a. In the **Identifier** box, type a URL using the following pattern:
    `https://<companyname>.benefitsolver.com/saml20`

    b. In the **Reply URL** text box, type the URL using the following pattern:
    `https://www.benefitsolver.com/benefits/BenefitSolverView?page_name=single_signon_saml`

	 c. In the **Sign-on URL** text box, type a URL using the following pattern:
    `http://<companyname>.benefitsolver.com`

	> [!NOTE]
	> These values aren't real. Update these values with the actual Identifier, Reply URL and Sign on URL. Contact [Benefitsolver Client support team](https://www.businessolver.com/contact-us/) to get these values. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. Benefitsolver application expects the SAML assertions in a specific format. Configure the following claims for this application. You can manage the values of these attributes from the **User Attributes** section on application integration page. On the **Set up Single Sign-On with SAML** page, select **Edit** button to open **User Attributes** dialog.

	![Screenshot shows User Attributes with the edit control called out.](common/edit-attribute.png)

1. In the **User Claims** section on the **User Attributes** dialog, edit the claims by using **Edit icon** or add the claims by using **Add new claim** to configure SAML token attribute as shown in the image above and perform the following steps: 

	| Name |  Source Attribute|
	|---------------|----------------|
	| ClientID | You need to get this value from your [Benefitsolver Client support team](https://www.businessolver.com/contact-us/).|
	| ClientKey | You need to get this value from your [Benefitsolver Client support team](https://www.businessolver.com/contact-us/).|
	| LogoutURL | You need to get this value from your [Benefitsolver Client support team](https://www.businessolver.com/contact-us/).|
	| EmployeeID | You need to get this value from your [Benefitsolver Client support team](https://www.businessolver.com/contact-us/).|
	| | |

	a. Select **Add new claim** to open the **Managed user claims** dialog.

	![Screenshot shows User claims with Add new claim and Save called out.](common/new-save-attribute.png)

	![Screenshot shows Manage user claims where you can enter the values described in this step.](common/new-attribute-details.png)

	b. In the **Name** textbox, type the attribute name shown for that row.

	c. Leave the **Namespace** blank.

	d. Select Source as **Attribute**.

	e. From the **Source attribute** list, type the attribute value shown for that row.

	f. Select **Ok**

	g. Select **Save**.

1. On the **Set up Single Sign-On with SAML** page, in the **SAML Signing Certificate** section, select **Download** to download the **Federation Metadata XML** from the given options as per your requirement and save it on your computer.

	![The Certificate download link](common/metadataxml.png)

1. On the **Set up Benefitsolver** section, copy one or more appropriate URLs as per your requirement.

	![Copy configuration URLs](common/copy-configuration-urls.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Benefitsolver SSO

To configure single sign-on on **Benefitsolver** side, you need to send the downloaded **Metadata XML** and appropriate copied URLs from the application configuration to [Benefitsolver support team](https://www.businessolver.com/contact-us/). They set this setting to have the SAML SSO connection set properly on both sides.

> [!NOTE]
> Your Benefitsolver support team has to do the actual SSO configuration. You'll get a notification when SSO has been enabled for your subscription.

### Create Benefitsolver test user

In this section, you create a user called Britta Simon in Benefitsolver. Work with [Benefitsolver support team](https://www.businessolver.com/contact-us/) to add the users in the Benefitsolver platform. Users must be created and activated before you use single sign-on.

## Test SSO

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

* Select **Test this application**, this option redirects to Benefitsolver Sign-on URL where you can initiate the sign in flow. 

* Go to Benefitsolver Sign-on URL directly and initiate the sign in flow from there.

* You can use Microsoft My Apps. When you select the Benefitsolver tile in the My Apps, this option redirects to Benefitsolver Sign-on URL. For more information, see [Microsoft Entra My Apps](/azure/active-directory/manage-apps/end-user-experiences#azure-ad-my-apps).

## Related content

Once you configure Benefitsolver you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-aad).
