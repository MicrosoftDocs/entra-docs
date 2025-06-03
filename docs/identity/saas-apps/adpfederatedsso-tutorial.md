---
title: Configure ADP for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and ADP.
author: nguhiu
manager: CelesteDG
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps
ms.topic: how-to
ms.date: 03/25/2025
ms.author: gideonkiratu
ms.custom: sfi-image-nochange
# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and ADP so that I can control who has access to ADP, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Configure ADP for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate ADP with Microsoft Entra ID. When you integrate ADP with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to ADP.
* Enable your users to be automatically signed-in to ADP with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

The scenario outlined in this article assumes that you already have the following prerequisites:

[!INCLUDE [common-prerequisites.md](~/identity/saas-apps/includes/common-prerequisites.md)]
* ADP single sign-on (SSO) enabled subscription.

> [!NOTE]
> This integration is also available to use from Microsoft Entra US Government Cloud environment. You can find this application in the Microsoft Entra US Government Cloud Application Gallery and configure it in the same way as you do from public cloud.

## Scenario description

In this article,  you configure and test Microsoft Entra SSO in a test environment.

* ADP supports **IDP** initiated SSO.

> [!NOTE]
> Identifier of this application is a fixed string value so only one instance can be configured in one tenant.

## Add ADP from the gallery

To configure the integration of ADP into Microsoft Entra ID, you need to add ADP from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **ADP** in the search box.
1. Select **ADP** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 [!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)]

<a name='configure-and-test-azure-ad-sso-for-adp'></a>

## Configure and test Microsoft Entra SSO for ADP

Configure and test Microsoft Entra SSO with ADP using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in ADP.

To configure and test Microsoft Entra SSO with ADP, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
    1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
2. **[Configure ADP SSO](#configure-adp-sso)** - to configure the single sign-on settings on application side.
    1. **[Create ADP test user](#create-adp-test-user)** - to have a counterpart of B.Simon in ADP that's linked to the Microsoft Entra representation of user.
3. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **ADP** application integration page, select **Properties tab** and perform the following steps: 

    ![Single sign-on properties](./media/adpfederatedsso-tutorial/properties.png)

    a. Set the **Enabled for users to sign-in** field value to **Yes**.

    b. Copy the **User access URL** and you have to paste it in **Configure Sign-on URL section**, which is explained later in the article.

    c. Set the **User assignment required** field value to **Yes**.

    d. Set the **Visible to users** field value to **No**.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **ADP** application integration page, find the **Manage** section and select **Single sign-on**.
1. On the **Select a Single sign-on method** page, select **SAML**.
1. On the **Set up Single Sign-On with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, perform the following steps:

    In the **Identifier (Entity ID)** text box, type the URL:
    `https://fed.adp.com`

1. On the **Set up Single Sign-On with SAML** page, in the **SAML Signing Certificate** section,  find **Federation Metadata XML** and select **Download** to download the certificate and save it on your computer.

    ![The Certificate download link](common/metadataxml.png)

1. On the **Set up ADP** section, copy the appropriate URL(s) based on your requirement.

    ![Copy configuration URLs](common/copy-configuration-urls.png)

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure ADP SSO




1. In a different web browser window, sign in to your up ADP company site as an administrator

1. Select **Federation Setup** and go to **Identity Provider** then, select the **Microsoft Azure**.

	![Screenshot for identity provider.](./media/adpfederatedsso-tutorial/microsoft-azure.png)

1. In the **Services Selection**, select all applicable service(s) for connection, and then select **Next**.

    ![Screenshot for services selection.](./media/adpfederatedsso-tutorial/services.png)

1. In the **Configure** section, select the **Next**.

1. In the **Upload Metadata**, select **Browse** to upload the metadata XML file which you have downloaded and select **UPLOAD**.

    ![Screenshot for uploading metadata.](./media/adpfederatedsso-tutorial/metadata.png)

### Configure your ADP service(s) for federated access

> [!Important]
> Your employees who require federated access to your ADP services must be assigned to the ADP service app and subsequently, users must be reassigned to the specific ADP service.
Upon receipt of confirmation from your ADP representative, configure your ADP service(s) and assign/manage users to control user access to the specific ADP service.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **ADP** in the search box.
1. Select **ADP** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 [!INCLUDE [sso-wizard.md](~/identity/saas-apps/includes/sso-wizard.md)]

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps**.
1. Select the **ADP** application integration page, select **Properties tab** and perform the following steps:  

    ![Single sign-on linked properties tab](./media/adpfederatedsso-tutorial/application.png)

    1. Set the **Enabled for users to sign-in** field value to **Yes**.

    1. Set the **User assignment required** field value to **Yes**.

    1. Set the **Visible to users** field value to **Yes**.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **ADP** application integration page, find the **Manage** section and select **Single sign-on**.

1. On the **Select a Single sign-on method** dialog, select **Mode** as **Linked** to link your application to **ADP**.

1. Navigate to the **Configure Sign-on URL** section, perform the following steps:

    ![Configure Single sign-on](./media/adpfederatedsso-tutorial/users.png)

    1. Paste the **User access URL**, which you have copied from above **properties tab** (from the main ADP app).

    1. Following are the 5 apps that support different **Relay State URLs**. You have to append the appropriate **Relay State URL** value for particular application manually to the **User access URL**.

        * **ADP Workforce Now**

            `<User access URL>&relaystate=https://fed.adp.com/saml/fedlanding.html?WFN`

        * **ADP Workforce Now Enhanced Time**

            `<User access URL>&relaystate=https://fed.adp.com/saml/fedlanding.html?EETDC2`

        * **ADP Vantage HCM**

            `<User access URL>&relaystate=https://fed.adp.com/saml/fedlanding.html?ADPVANTAGE`

        * **ADP Enterprise HR**

            `<User access URL>&relaystate=https://fed.adp.com/saml/fedlanding.html?PORTAL`

        * **MyADP**

            `<User access URL>&relaystate=https://fed.adp.com/saml/fedlanding.html?REDBOX`

1. **Save** your changes.

1. Upon receipt of confirmation from your ADP representative, begin test with one or two users.

    1. Assign few users to the ADP service App to test federated access.

    1. Test is successful when users access the ADP service app on the gallery and can access their ADP service.

1. On confirmation of a successful test, assign the federated ADP service to individual users or user groups, which is explained later in the article and roll it out to your employees.

### Configure ADP to support multiple instances in the same tenant

1. Go to **Basic SAML Configuration** section and enter any instance specific URL in the **Identifier (Entity ID)** textbox. 

    > [!NOTE]
    > Please note that this can be any random value which you feel relevant for your instance.

1. To support multiple instances in the same tenant, please follow the below steps:

    ![Screenshot shows how to configure audience claim value.](./media/adpfederatedsso-tutorial/audience.png "Claim")

    1. Navigate to **Attributes & Claims** section > **Advanced settings** > **Advanced SAML claims options** and select **Edit**.

    1. Enable **Append application ID to issuer** checkbox.

    1. Enable **Override audience claim** checkbox.

    1. In the **Audience claim value** textbox, enter `https://fed.adp.com` and select **Save**.

1. Navigate to **Properties** tab under Manage section and copy **Application ID**.

    ![Screenshot shows how to copy application value from properties tab.](./media/adpfederatedsso-tutorial/app.png "Tab")

1. Download and open the **Federation Metadata XML** file and edit the **entityID** value by adding **Application ID** manually at the end.

    ![Screenshot shows how to add the application value in the federation file.](./media/adpfederatedsso-tutorial/federation.png "File")
    
1. **Save** the xml file and use in the ADP side.

### Create ADP test user

The objective of this section is to create a user called B.Simon in ADP. Work with [ADP support team](https://www.adp.com/contact-us/overview.aspx) to add the users in the ADP account. 

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options.

* Select **Test this application**, and you should be automatically signed in to the ADP for which you set up the SSO.

* You can use Microsoft My Apps. When you select the ADP tile in the My Apps, you should be automatically signed in to the ADP for which you set up the SSO. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Related content

Once you configure ADP you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-any-app).
