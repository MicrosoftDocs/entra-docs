---
title: Microsoft Entra SSO integration with HPE Aruba Networking EdgeConnect Orchestrator
description: Learn how to configure single sign-on between Microsoft Entra ID and HPE Aruba Networking EdgeConnect Orchestrator.

author: jeevansd
manager: CelesteDG
ms.reviewer: CelesteDG
ms.service: entra-id
ms.subservice: saas-apps
ms.topic: how-to
ms.date: 12/20/2023
ms.author: jeedes
---

# Microsoft Entra SSO integration with HPE Aruba Networking EdgeConnect Orchestrator

In this tutorial, you'll learn how to integrate HPE Aruba Networking EdgeConnect Orchestrator with Microsoft Entra ID. When you integrate HPE Aruba Networking EdgeConnect Orchestrator with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to HPE Aruba Networking EdgeConnect Orchestrator.
* Enable your users to be automatically signed-in to HPE Aruba Networking EdgeConnect Orchestrator with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

To integrate Microsoft Entra ID with HPE Aruba Networking EdgeConnect Orchestrator, you need:

* A Microsoft Entra subscription. If you don't have a subscription, you can get a [free account](https://azure.microsoft.com/free/).
* HPE Aruba Networking EdgeConnect Orchestrator version 9.4.1 or newer.


## Scenario description

In this tutorial, you configure and test Microsoft Entra SSO in a test environment.

* HPE Aruba Networking EdgeConnect Orchestrator supports both **SP and IDP** initiated SSO.

## Add HPE Aruba Networking EdgeConnect Orchestrator from the gallery

To configure the integration of HPE Aruba Networking EdgeConnect Orchestrator into Microsoft Entra ID, you need to add HPE Aruba Networking EdgeConnect Orchestrator from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Identity** > **Applications** > **Enterprise applications** > **New application**.
1. In the **Add from the gallery** section, type **HPE Aruba Networking EdgeConnect Orchestrator** in the search box.
1. Select **HPE Aruba Networking EdgeConnect Orchestrator** tile from results panel. Enter a **name**, and click **Create** to add the app. Wait a few seconds while the app is added to your tenant.
   ![Screenshot shows how to select HPE Aruba Networking EdgeConnect Orchestrator](https://github.com/MicrosoftDocs/entra-docs/assets/8731469/b613e7a2-323b-4f00-b508-397f053c4c7a)

Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, and walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)

## Configure and test Microsoft Entra SSO for HPE Aruba Networking EdgeConnect Orchestrator

Configure and test Microsoft Entra SSO with HPE Aruba Networking EdgeConnect Orchestrator using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in HPE Aruba Networking EdgeConnect Orchestrator.

To configure and test Microsoft Entra SSO with HPE Aruba Networking EdgeConnect Orchestrator, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-microsoft-entra-sso)** - to enable your users to use this feature.
    1. **[Create a Microsoft Entra ID test user](#create-a-microsoft-entra-id-test-user)** - to test Microsoft Entra single sign-on with B.Simon.
    1. **[Assign the Microsoft Entra ID test user](#assign-the-microsoft-entra-id-test-user)** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure HPE Aruba Networking EdgeConnect Orchestrator SSO](#configure-hpe-aruba-networking-edgeconnect-orchestrator-sso)** - to configure the single sign-on settings on application side.
    1. **[Create HPE Aruba Networking EdgeConnect Orchestrator test user](#create-hpe-aruba-networking-edgeconnect-orchestrator-test-user)** - to have a counterpart of B.Simon in HPE Aruba Networking EdgeConnect Orchestrator that is linked to the Microsoft Entra ID representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO in the Microsoft Entra admin center.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Identity** > **Applications** > **Enterprise applications**. In the search bar, type the name of the **HPE Aruba Networking EdgeConnect Orchestrator** app you created earlier. The **Overview** page opens.
1. In the left pane, under **Manage**, click **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, click the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Screenshot shows how to edit Basic SAML Configuration.](common/edit-urls.png "Basic Configuration")

1. On the **Basic SAML Configuration** section, perform the following steps:

    a. You must enter the values of **Identifier (Entity ID)** text box, **Reply URL (Assertion Consumer Service URL)** text box, and Logout Url (Optional) values. To find these values, first, **log in to Orchestrator** and navigate to the **Authentication** dialog box **(Orchestrator > Users & Authentication > Authentication)**.
   
    ![Screenshot shows how to navigate to Authentication dialog](https://github.com/MicrosoftDocs/entra-docs/assets/8731469/bd037628-42a2-4349-83f6-54ddf3dbc1af)

    b. In the **Authentication** dialog, click **+Add New Server**.

    c. Select **SAML** from the **Type** field.

    d. In the **Name** field, enter a name for your your SAML configuration.

    e. Click the copy icon next to the **ACS URL** field.

    f. Go to the **Basic SAML Configuration** section on Microsoft **Set up single sign-on with SAML** page:
	
 	- Under **Identifier (Entity ID)**, click **Add identifier** link. Paste the ACS URL value on the Identifier field.

	- Under **Reply URL (Assertion Consumer Service URL)**, click **Add reply URL link**. Paste the same ACS URL value on the Reply URL field.

	- Under **Logout URL (Optional)**, paste the **EdgeConnect SLO Endpoint** value from the Orchestrator’s Remote Authentication Server page as shown on the image below:

	> [!NOTE] **IMPORTANT**:
	> On self-hosted Orchestrators, if the Orchestrator is displaying the private IP address of it on the ACS URL field and the EdgeConnect SLO Endpoint field, please update it with the public IP address of the Orchestrator. As shown on the screenshot below, all five fields must contain the public IP address of the Orchestrator (not the private IP):

	![Screenshot shows how to configure Basic SAML Configuration section](https://github.com/MicrosoftDocs/entra-docs/assets/8731469/f946920c-2583-49ce-bbc5-369724835fc3)

    g. Click **Save** to close the **Basic SAML Configuration** section

1. On the **Set up single sign-on with SAML** page, in the **Attributes & Claims** section, click the edit icon and copy the highlighted entry below, and paste the information into the **Username Attribute** field in Orchestrator as shown below:

	![Screenshot shows how to configure username attribute.](https://github.com/MicrosoftDocs/entra-docs/assets/8731469/2115afb6-12c4-4174-8c21-323cda042741)


1. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section, find **Certificate (Base64)** and select **Download** to download the certificate:

	![Screenshot shows the Certificate download link.](common/certificatebase64.png "Certificate")

1. Open the certificate using a text editor such as Notepad. Copy and paste the content of the certificate on the **IdP X.509 Cert** field in Orchestrator as shown below:

	![Screenshot shows how to configure certificate.](https://github.com/MicrosoftDocs/entra-docs/assets/8731469/1a0c0ef3-4cca-4240-9178-cca926975b5d)

1. On the **Set up single sign-on with SAML** page, in the **Set up HPE Aruba Networking EdgeConnect Orchestrator** section, copy the **Microsoft Entra Identifier** and paste it into the **Issuer URL** field in Orchestrator:

	![Screenshot shows how to configure Issuer URL.](https://github.com/MicrosoftDocs/entra-docs/assets/8731469/2b542dc3-195e-428f-8ea9-35a07d03744a)

1. Click the Properties tab and copy the **User access URL** and paste it into the **SSO Endpoint** field in Orchestrator as shown below: 

	![Screenshot shows how to configure SSO Endpoint.](https://github.com/MicrosoftDocs/entra-docs/assets/8731469/b6a994a2-8208-43b4-a3b9-250fdbcc6c37)

1. On the Orchestrator Remote Authentication Server dialog, set the **Default role** field. Example: SuperAdmin. (This is the last item on the dropdown list)
   The Default role is needed if you did not define Role Based Access Control (RBAC) in the user attributes in the Attributes & Claims section.
   
1. Click **Save** on the Remote Authentication Server dialog.
   
1. You have successfully configured SAML SSO authentication on the Orchestrator. The next step is to create a test user and assign the Orchestrator application to that user to verify if SAML is configured successfully. 

### Create a Microsoft Entra ID test user

In this section, you'll create a test user in the Microsoft Entra admin center called B.Simon.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [User Administrator](~/identity/role-based-access-control/permissions-reference.md#user-administrator).
1. Browse to **Identity** > **Users** > **All users**.
1. Select **New user** > **Create new user**, at the top of the screen.
1. In the **User** properties, follow these steps:
   1. In the **Display name** field, enter `B.Simon`.  
   1. In the **User principal name** field, enter the username@companydomain.extension. For example, `B.Simon@contoso.com`.
   1. Select the **Show password** check box, and then write down the value that's displayed in the **Password** box.
   1. Select **Review + create**.
1. Select **Create**.

### Assign the Microsoft Entra ID test user

In this section, you'll enable B.Simon to use Microsoft Entra single sign-on by granting access to HPE Aruba Networking EdgeConnect Orchestrator.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Identity** > **Applications** > **Enterprise applications** > **HPE Aruba Networking EdgeConnect Orchestrator**.
1. In the app's overview page, select **Users and groups**.
1. Select **Add user/group**, then select **Users and groups** in the **Add Assignment** dialog.
   1. In the **Users and groups** dialog, select **B.Simon** from the Users list, then click the **Select** button at the bottom of the screen.
   1. If you are expecting a role to be assigned to the users, you can select it from the **Select a role** dropdown. If no role has been set up for this app, you see "Default Access" role selected.
   1. In the **Add Assignment** dialog, click the **Assign** button.

## Configure HPE Aruba Networking EdgeConnect Orchestrator SSO

To configure single sign-on on **HPE Aruba Networking EdgeConnect Orchestrator** side, you need to send the downloaded **Certificate (Base64)** and appropriate copied URLs from Microsoft Entra admin center to [HPE Aruba Networking EdgeConnect Orchestrator support team](mailto:support@silver-peak.com). They set this setting to have the SAML SSO connection set properly on both sides.

### Create HPE Aruba Networking EdgeConnect Orchestrator test user

In this section, you create a user called B.Simon in HPE Aruba Networking EdgeConnect Orchestrator. Work with [HPE Aruba Networking EdgeConnect Orchestrator support team](mailto:support@silver-peak.com) to add the users in the HPE Aruba Networking EdgeConnect Orchestrator platform. Users must be created and activated before you use single sign-on.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options.
 
#### SP initiated:
 
* Click on **Test this application** in Microsoft Entra admin center. This will redirect to HPE Aruba Networking EdgeConnect Orchestrator Sign on URL where you can initiate the login flow.  
 
* Go to HPE Aruba Networking EdgeConnect Orchestrator Sign on URL directly and initiate the login flow from there.
 
#### IDP initiated:
 
* Click on **Test this application** in Microsoft Entra admin center and you should be automatically signed in to the HPE Aruba Networking EdgeConnect Orchestrator for which you set up the SSO.
 
You can also use Microsoft My Apps to test the application in any mode. When you click the HPE Aruba Networking EdgeConnect Orchestrator tile in the My Apps, if configured in SP mode you would be redirected to the application sign-on page for initiating the login flow and if configured in IDP mode, you should be automatically signed in to the HPE Aruba Networking EdgeConnect Orchestrator for which you set up the SSO. For more information about the My Apps, see [Introduction to the My Apps](https://support.microsoft.com/account-billing/sign-in-and-start-apps-from-the-my-apps-portal-2f3b1bae-0e5a-4a86-a33e-876fbd2a4510).

## Next steps

Once you configure HPE Aruba Networking EdgeConnect Orchestrator you can enforce session control, which protects exfiltration and infiltration of your organization's sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-any-app).
