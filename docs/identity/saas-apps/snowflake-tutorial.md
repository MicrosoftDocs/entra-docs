---
title: Configure Snowflake for Single sign-on with Microsoft Entra ID
description: Learn how to configure single sign-on between Microsoft Entra ID and Snowflake.
author: nguhiu
manager: CelesteDG
ms.reviewer: celested
ms.service: entra-id
ms.subservice: saas-apps
ms.topic: how-to
ms.date: 05/20/2025
ms.author: gideonkiratu
ms.custom: sfi-image-nochange
# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and Snowflake so that I can control who has access to Snowflake, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---
# Configure Snowflake for Single sign-on with Microsoft Entra ID

In this article,  you learn how to integrate Snowflake with Microsoft Entra ID. When you integrate Snowflake with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to Snowflake.
* Enable your users to be automatically signed-in to Snowflake with their Microsoft Entra accounts.
* Manage your accounts in one central location.

## Prerequisites

To configure Microsoft Entra integration with Snowflake, you need the following items:

* A Microsoft Entra subscription. If you don't have a Microsoft Entra environment, you can get a [free account](https://azure.microsoft.com/free/).
* Snowflakes single sign-on enabled subscription.
* Along with Cloud Application Administrator, Application Administrator can also add or manage applications in Microsoft Entra ID.
For more information, see [Azure built-in roles](~/identity/role-based-access-control/permissions-reference.md).

> [!NOTE]
> This integration is also available to use from Microsoft Entra US Government Cloud environment. You can find this application in the Microsoft Entra US Government Cloud Application Gallery and configure it in the same way as you do from public cloud.

## Scenario description

In this article,  you configure and test Microsoft Entra single sign-on in a test environment.

* Snowflake supports **SP and IDP** initiated SSO.
* Snowflake supports [automated user provisioning and deprovisioning](snowflake-provisioning-tutorial.md) (recommended).

## Add Snowflake from the gallery

To configure the integration of Snowflake into Microsoft Entra ID, you need to add Snowflake from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **New application**.
1. In the **Add from the gallery** section, type **Snowflake** in the search box.
1. Select **Snowflake** from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

 Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, and walk through the SSO configuration as well. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides)

<a name='configure-and-test-azure-ad-sso-for-snowflake'></a>

## Configure and test Microsoft Entra SSO for Snowflake

Configure and test Microsoft Entra SSO with Snowflake using a test user called **B.Simon**. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Snowflake.

To configure and test Microsoft Entra SSO with Snowflake, perform the following steps:

1. **[Configure Microsoft Entra SSO](#configure-azure-ad-sso)** - to enable your users to use this feature.
	1. **Create a Microsoft Entra test user** - to test Microsoft Entra single sign-on with B.Simon.
	1. **Assign the Microsoft Entra test user** - to enable B.Simon to use Microsoft Entra single sign-on.
1. **[Configure Snowflake SSO](#configure-snowflake-sso)** - to configure the single sign-on settings on application side.
	1. **[Create Snowflake test user](#create-snowflake-test-user)** - to have a counterpart of B.Simon in Snowflake that's linked to the Microsoft Entra representation of user.
1. **[Test SSO](#test-sso)** - to verify whether the configuration works.

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **Snowflake** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Screenshot shows to edit Basic S A M L Configuration.](common/edit-urls.png "Basic Configuration")

1. In the **Basic SAML Configuration** section, perform the following steps, if you wish to configure the application in **IDP** initiated mode:

    a. In the **Identifier** text box, type a URL using the following pattern:
    `https://<SNOWFLAKE-URL>.snowflakecomputing.com`

    b. In the **Reply URL** text box, type a URL using the following pattern:
    `https://<SNOWFLAKE-URL>.snowflakecomputing.com/fed/login`

1. Select **Set additional URLs** and perform the following step if you wish to configure the application in **SP** initiated mode:

	a. In the **Sign-on URL** text box, type a URL using the following pattern:
    `https://<SNOWFLAKE-URL>.snowflakecomputing.com`
    
	b. In the **Logout URL** text box, type a URL using the following pattern:
    `https://<SNOWFLAKE-URL>.snowflakecomputing.com/fed/logout`

    > [!NOTE]
	> These values aren't real. Update these values with the actual Identifier, Reply URL, Sign-on URL, and sign out URL. Contact [Snowflake Client support team](https://support.snowflake.net/s/) to get these values. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. On the **Set up Single Sign-On with SAML** page, in the **SAML Signing Certificate** section, select **Download** to download the **Certificate (Base64)** from the given options as per your requirement and save it on your computer.

	![Screenshot shows the Certificate download link.](common/certificatebase64.png "Certificate")

1. On the **Set up Snowflake** section, copy one or more appropriate URLs as per your requirement.

	![Screenshot shows to copy configuration appropriate U R L.](common/copy-configuration-urls.png "Metadata")  

<a name='create-an-azure-ad-test-user'></a>

[!INCLUDE [create-assign-users-sso.md](~/identity/saas-apps/includes/create-assign-users-sso.md)]

## Configure Snowflake SSO

1. In a different web browser window, sign in to Snowflake as a Security Administrator.

1. **Switch Role** to **ACCOUNTADMIN**, by selecting **profile** on the top right side of page.

	> [!NOTE]
	> This is separate from the context you have selected in the top-right corner under your User Name.
    
	![The Snowflake admin](./media/snowflake-tutorial/account.png)

1. Open the **downloaded Base 64 certificate** in notepad. Copy the value between “-----BEGIN CERTIFICATE-----” and “-----END CERTIFICATE-----" and paste this content into the **SAML2_X509_CERT**.

1. In the **SAML2_ISSUER**, paste **Identifier** value, which you copied previously.

1. In the **SAML2_SSO_URL**, paste **Login URL** value, which you copied previously.

1. In the **SAML2_PROVIDER**, give the value like `CUSTOM`.

1. Select the **All Queries** and select **Run**.

    ![Snowflake sql](./media/snowflake-tutorial/certificate.png)

    ```
    CREATE [ OR REPLACE ] SECURITY INTEGRATION [ IF NOT EXISTS ]
    TYPE = SAML2
    ENABLED = TRUE | FALSE
    SAML2_ISSUER = '<EntityID/Issuer value which you have copied>'
    SAML2_SSO_URL = '<Login URL value which you have copied>'
    SAML2_PROVIDER = 'CUSTOM'
    SAML2_X509_CERT = '<Paste the content of downloaded certificate from Azure portal>'
    [ SAML2_SP_INITIATED_LOGIN_PAGE_LABEL = '<string_literal>' ]
    [ SAML2_ENABLE_SP_INITIATED = TRUE | FALSE ]
    [ SAML2_SNOWFLAKE_X509_CERT = '<string_literal>' ]
    [ SAML2_SIGN_REQUEST = TRUE | FALSE ]
    [ SAML2_REQUESTED_NAMEID_FORMAT = '<string_literal>' ]
    [ SAML2_POST_LOGOUT_REDIRECT_URL = '<string_literal>' ]
    [ SAML2_FORCE_AUTHN = TRUE | FALSE ]
    [ SAML2_SNOWFLAKE_ISSUER_URL = '<string_literal>' ]
    [ SAML2_SNOWFLAKE_ACS_URL = '<string_literal>' ]
    ```

If you're using a new Snowflake URL with an organization name as the sign in URL, it's necessary to update the following parameters:

Alter the integration to add Snowflake Issuer URL and SAML2 Snowflake ACS URL, please follow  the step-6 in [this](https://community.snowflake.com/s/knowledgebase) article for more information.

1. [ SAML2_SNOWFLAKE_ISSUER_URL = '<string_literal>' ] 

    alter security integration `<your security integration name goes here>` set SAML2_SNOWFLAKE_ISSUER_URL = `https://<organization_name>-<account name>.snowflakecomputing.com`;

2. [ SAML2_SNOWFLAKE_ACS_URL = '<string_literal>' ]

    alter security integration `<your security integration name goes here>` set SAML2_SNOWFLAKE_ACS_URL = `https://<organization_name>-<account name>.snowflakecomputing.com/fed/login`;

> [!NOTE]
> Follow [this](https://docs.snowflake.com/en/sql-reference/sql/create-security-integration.html) guide to know more about how to create a SAML2 security integration.

> [!NOTE]
> If you have an existing SSO setup using `saml_identity_provider` account parameter, then follow [this](https://docs.snowflake.com/en/user-guide/admin-security-fed-auth-advanced.html) guide to migrate it to the SAML2 security integration.

### Create Snowflake test user

To enable Microsoft Entra users to sign in to Snowflake, they must be provisioned into Snowflake. In Snowflake, provisioning is a manual task.

**To provision a user account, perform the following steps:**

1. Sign in to Snowflake as a Security Administrator.

2. **Switch Role** to **ACCOUNTADMIN**, by selecting **profile** on the top right side of page.  

	![The Snowflake admin](./media/snowflake-tutorial/account.png)

3. Create the user by running the below SQL query, ensuring "sign in name" is set to the Microsoft Entra username on the worksheet as shown below.

	![The Snowflake adminsql](./media/snowflake-tutorial/user.png)

    ```
	use role accountadmin;
	CREATE USER britta_simon PASSWORD = '' LOGIN_NAME = 'BrittaSimon@contoso.com' DISPLAY_NAME = 'Britta Simon';
    ```
> [!NOTE]
> Manually provisioning is unnecessary, if users and groups are provisioned with a SCIM integration. See how to enable auto provisioning for [Snowflake](snowflake-provisioning-tutorial.md).

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options. 

#### SP initiated:

* Select **Test this application**, this option redirects to Snowflake Sign on URL where you can initiate the login flow.  

* Go to Snowflake Sign-on URL directly and initiate the login flow from there.

#### IDP initiated:

* Select **Test this application**, and you should be automatically signed in to the Snowflake for which you set up the SSO. 

You can also use Microsoft My Apps to test the application in any mode. When you select the Snowflake tile in the My Apps, if configured in SP mode you would be redirected to the application sign-on page for initiating the login flow and if configured in IDP mode, you should be automatically signed in to the Snowflake for which you set up the SSO. For more information, see [Microsoft Entra My Apps](/azure/active-directory/manage-apps/end-user-experiences#azure-ad-my-apps).

## Prevent application access through local accounts

Once you've validated that SSO works and rolled it out in your organization, we recommend disabling application access using local credentials. This ensures that your Conditional Access policies, MFA, etc. is in place to protect sign-ins to Snowflake. Review the Snowflake documentation for [configuring SSO](https://docs.snowflake.com/en/user-guide/admin-security-fed-auth-use), and use the ALTER USER commandlet to remove user passwords.  

## Related content

Once you configure Snowflake you can enforce Session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Defender for Cloud Apps](/cloud-app-security/proxy-deployment-aad).
