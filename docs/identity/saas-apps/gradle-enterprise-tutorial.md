---
title: Configure Gradle Enterprise for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Gradle Enterprise.

author: nguhiu
manager: mwongerapk
ms.reviewer: jomondi
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu

---

# Configure Gradle Enterprise for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Gradle Enterprise with Microsoft Entra ID. When you integrate Gradle Enterprise with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Gradle Enterprise.
* Enable your users to be automatically signed-in to Gradle Enterprise with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* Gradle Enterprise single sign-on (SSO) enabled subscription.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* Gradle Enterprise supports **SP** initiated SSO

## Adding Gradle Enterprise from the gallery

To configure the integration of Gradle Enterprise into Microsoft Entra ID, you need to add Gradle Enterprise from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Gradle Enterprise** in the search box.
1. Select **Gradle Enterprise** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 [!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)]


<a name='configure-and-test-azure-ad-sso-for-gradle-enterprise'></a>

## Configure and test Microsoft Entra SSO for Gradle Enterprise

Configure and test Microsoft Entra SSO with Gradle Enterprise using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Gradle Enterprise.

To configure and test Microsoft Entra SSO with Gradle Enterprise, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Gradle Enterprise SSO](#configure-gradle-enterprise-sso)** - to configure the single sign-on settings on application side.
    1. **[Create Gradle Enterprise test user](#create-gradle-enterprise-test-user)** - to have a counterpart of B.Simon in Gradle Enterprise that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Gradle Enterprise** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the edit/pen icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, enter the values for the following fields:

	a. In the **Sign on URL** text box, type a URL using the following pattern:
    `https://<CLIENT_DOMAIN>`

    b. In the **Identifier (Entity ID)** text box, type a URL using the following pattern:
    `https://<CLIENT_DOMAIN>/keycloak/realms/gradle-enterprise`

    c. In the **Reply URL** text box, type a URL using the following pattern:
    `https://<CLIENT_DOMAIN>/keycloak/realms/gradle-enterprise/broker/saml/endpoint`

	> [!NOTE]
	> These values aren't real. Update these values with the actual Sign on URL and Identifier. Contact [Gradle Enterprise Client support team](https://gradle.com/brand/) to get these values. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section,  find **Federation Metadata XML** and select **Download** to download the certificate and save it on your computer.

	![The Certificate download link](common/metadataxml.png)

1. On the **Set up Gradle Enterprise** section, copy the appropriate URL(s) based on your requirement.

	![Copy configuration URLs](common/copy-configuration-urls.png)
<a name='create-an-azure-ad-test-user'></a>

### Create a Microsoft Entra test user

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

<a name='assign-the-azure-ad-test-user'></a>

### Assign the Microsoft Entra test user

In this section, you enable B.Simon to use single sign-on by granting access to Gradle Enterprise.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Gradle Enterprise**.
1. In the app's overview page, select **Users and groups**.
1. Select **Add user/group**, then select **Users and groups** in the **Add Assignment** dialog.
   1. In the **Users and groups** dialog, select **B.Simon** from the Users list, then select the **Select** button at the bottom of the screen.
   1. If you're expecting a role to be assigned to the users, you can select it from the **Select a role** dropdown. If no role has been set up for this app, you see "Default Access" role selected.
   1. In the **Add Assignment** dialog, select the **Assign** button.

## Configure Gradle Enterprise SSO

To configure single sign-on on **Gradle Enterprise** side, you need to send the downloaded **Federation Metadata XML** and appropriate copied URLs from the application configuration to [Gradle Enterprise support team](https://gradle.com/brand/). They set this setting to have the SAML SSO connection set properly on both sides.

### Create Gradle Enterprise test user

In this section, you create a user called Britta Simon in Gradle Enterprise. Work with [Gradle Enterprise support team](https://gradle.com/brand/) to add the users in the Gradle Enterprise platform. Users must be created and activated before you use single sign-on.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

1. Select **Test this application**, this option redirects to Gradle Enterprise Sign-on URL where you can initiate the login flow. 

2. Go to Gradle Enterprise Sign-on URL directly and initiate the login flow from there.

3. You can use Microsoft Access Panel. When you select the Gradle Enterprise tile in the Access Panel, this option redirects to Gradle Enterprise Sign-on URL. For more information about the Access Panel, see [Introduction to the Access Panel](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).


## Related content

Once you configure Gradle Enterprise you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-any-app).
