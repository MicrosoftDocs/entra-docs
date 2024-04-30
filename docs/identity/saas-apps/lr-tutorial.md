---
title: 'Tutorial: Microsoft Entra integration with LoginRadius'
description: Learn how to configure single sign-on between Microsoft Entra ID and LoginRadius.

author: jeevansd
manager: CelesteDG
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: tutorial
ms.date: 11/21/2022
ms.author: jeedes

# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and LoginRadius so that I can control who has access to LoginRadius, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---
# Tutorial: Microsoft Entra integration with LoginRadius

In this tutorial, you'll learn how to integrate LoginRadius with Microsoft Entra ID. When you integrate LoginRadius with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to LoginRadius.
* Enable your users to be automatically signed-in to LoginRadius with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

To configure Microsoft Entra integration with LoginRadius, you need the following items:

* A Microsoft Entra subscription. If you don't have a Microsoft Entra environment, you can get a [free account](https://azure.microsoft.com/free/).
* A LoginRadius single sign-on enabled subscription.

## Scenario description

In this tutorial, you configure and test Microsoft Entra single sign-on in a test environment.

* LoginRadius supports **SP** initiated SSO.

> [!NOTE]
> Identifier of this application is a fixed string value so only one instance can be configured in one tenant.

## Add LoginRadius from the gallery

To configure the integration of LoginRadius into Microsoft Entra ID, you need to add LoginRadius from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Identity** > **Applications** > **Enterprise applications** > **New application**.
1. In the **Add from the gallery** section, type **LoginRadius** in the search box.
1. Select **LoginRadius** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, as well as walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)

<a name='configure-and-test-azure-ad-sso-for-loginradius'></a>

## Configure and test Microsoft Entra SSO for LoginRadius

Configure and test Microsoft Entra SSO with LoginRadius using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in LoginRadius.

To configure and test Microsoft Entra SSO with LoginRadius, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
    1. **[Create a Microsoft Entra test user](#create-an-azure-ad-test-user)** - to test Microsoft Entra single sign-on with B.Simon.
    1. **[Assign the Microsoft Entra test user](#assign-the-azure-ad-test-user)** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure LoginRadius SSO](#configure-loginradius-sso)** - to configure the single sign-on settings on application side.
    1. **[Create LoginRadius test user](#create-loginradius-test-user)** - to have a counterpart of B.Simon in LoginRadius that is linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Identity** > **Applications** > **Enterprise applications** > **LoginRadius** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, click the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Edit Basic SAML Configuration](common/edit-urls.png)

1. On the **Basic SAML Configuration** section, perform the following steps:

   1. In the **Identifier (Entity ID)** text box, enter the URL `https://lr.hub.loginradius.com/`

   1. In the **Reply URL (Assertion Consumer Service URL)** textbox, enter the LoginRadius ACS URL `https://lr.hub.loginradius.com/saml/serviceprovider/AdfsACS.aspx` 

   1. In the **Sign on URL** text box, enter the URL `https://secure.loginradius.com/login`

1. On the **Set up Single Sign-On with SAML** page, in the **SAML Signing Certificate** section, select **Download** to download the **Federation Metadata XML** from the given options as per your requirement and save it on your computer.

	![The Certificate download link](common/metadataxml.png)

6. In the **Set up LoginRadius** section, copy the appropriate URL(s) as per your requirement.

   ![Copy configuration URLs](common/copy-configuration-urls.png)

<a name='create-an-azure-ad-test-user'></a>

### Create a Microsoft Entra test user 

In this section, you'll create a test user called B.Simon.

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

In this section, you'll enable B.Simon to use single sign-on by granting access to LoginRadius.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Identity** > **Applications** > **Enterprise applications** > **LoginRadius**.
1. In the app's overview page, select **Users and groups**.
1. Select **Add user/group**, then select **Users and groups** in the **Add Assignment** dialog.
   1. In the **Users and groups** dialog, select **B.Simon** from the Users list, then click the **Select** button at the bottom of the screen.
   1. If you are expecting a role to be assigned to the users, you can select it from the **Select a role** dropdown. If no role has been set up for this app, you see "Default Access" role selected.
   1. In the **Add Assignment** dialog, click the **Assign** button.

## Configure LoginRadius SSO

In this section, you enable Microsoft Entra single sign-on in the LoginRadius Admin Console.

1. Log in to your LoginRadius [Admin Console](https://adminconsole.loginradius.com/login) account.

2. Go to your **Team Management** section in the [LoginRadius Admin Console](https://www.loginradius.com/docs/api/v2/admin-console/overview/).

3. Select the **Single Sign-On** tab, and then select **Microsoft Entra ID**:

   ![Screenshot that shows the single-sign-on menu in the LoginRadius Team Management console](./media/loginradius-tutorial/azure-ad.png)

4. In the Microsoft Entra setup page, complete the following steps:

   ![Screenshot that shows Microsoft Entra configuration in the LoginRadius Team Management console](./media/loginradius-tutorial/single-sign-on.png)

  	1. In **ID Provider Location**, enter the SIGN-ON ENDPOINT, which you get from your Microsoft Entra account.

	1. In **ID Provider Logout URL**, enter the SIGN-OUT ENDPOINT, which you get from your Microsoft Entra account.
 
  	1. In **ID Provider Certificate**, enter the Microsoft Entra certificate, which you get from your Microsoft Entra account. Enter the certificate value with the header and footer. Example: `-----BEGIN CERTIFICATE-----<certificate value>-----END CERTIFICATE-----`

  	1. In **Service Provider Certificate** and **Server Provider Certificate Key**, enter your certificate and key. 

       You can create a self-signed certificate by running the following commands on the command line (Linux/Mac):

       - Command to get the certificate key for SP: `openssl genrsa -out lr.hub.loginradius.com.key 2048`

       - Command to get the certificate for SP: `openssl req -new -x509 -key lr.hub.loginradius.com.key -out lr.hub.loginradius.com.cert -days 3650 -subj /CN=lr.hub.loginradius.com`

	   > [!NOTE]
	   > Be sure to enter the certificate and certificate key values with the header and footer:
	   > - Certificate value example format: `-----BEGIN CERTIFICATE-----<certificate value>-----END CERTIFICATE-----`
	   > - Certificate key value example format: `-----BEGIN RSA PRIVATE KEY-----<certificate key value>-----END RSA PRIVATE KEY-----`

5. In the **Data Mapping** section, select the fields (SP fields) and enter the corresponding Microsoft Entra ID fields(IdP fields).

	Following are some listed field names for Microsoft Entra ID.

	| Fields    | Profile Key                                                          |
	| --------- | -------------------------------------------------------------------- |
	| Email     | `http://schemas.xmlsoap.org/ws/2005/05/identity/claims/emailaddress` |
	| FirstName | `http://schemas.xmlsoap.org/ws/2005/05/identity/claims/givenname`    |
	| LastName  | `http://schemas.xmlsoap.org/ws/2005/05/identity/claims/surname`      |

	> [!NOTE]
	> The **Email** field mapping is required. **FirstName** and **LastName** field mappings are optional.

### Create LoginRadius test user

1. Log in to your LoginRadius [Admin Console](https://adminconsole.loginradius.com/login) account.

2. Go to your team management section in the LoginRadius Admin Console.

   ![Screenshot that shows the LoginRadius Admin Console](./media/loginradius-tutorial/team-management.png)

3. Select **Add Team Member** in the side menu to open the form. 

4. In the **Add Team Member** form, you create a user called Britta Simon in your LoginRadius site by providing the user's details and assigning the permissions you want the user to have. To know more about the permissions based on roles, see the [Role Access Permissions](https://www.loginradius.com/docs/api/v2/admin-console/team-management/manage-team-members#roleaccesspermissions0) section of the LoginRadius [Manage Team Members](https://www.loginradius.com/docs/api/v2/admin-console/team-management/manage-team-members#roleaccesspermissions0) document. Users must be created and activated before you use single sign-on.

## Test SSO

In this section, you test your Microsoft Entra single sign-on configuration using MyApps.

1. In a browser, go to https://accounts.loginradius.com/auth.aspx and select **Fed SSO log in**.
2. Enter your LoginRadius app name, and then select **Login**.
3. It should open a pop-up for asking you to sign in to your Microsoft Entra account.
4. After the authentication, your pop-up will close and you will be logged in to the LoginRadius Admin Console.

## Next steps

Once you configure LoginRadius you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-aad).
