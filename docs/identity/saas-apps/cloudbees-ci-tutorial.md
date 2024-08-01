---
title: Microsoft Entra SSO integration with CloudBees CI
description: Learn how to configure single sign-on between Microsoft Entra ID and CloudBees CI.

author: jeevansd
manager: CelesteDG
ms.reviewer: CelesteDG
ms.service: entra-id
ms.subservice: saas-apps

ms.topic: how-to
ms.date: 03/25/2024
ms.author: jeedes


# Customer intent: As an IT administrator, I want to learn how to configure single sign-on between Microsoft Entra ID and CloudBees CI so that I can control who has access to CloudBees CI, enable automatic sign-in with Microsoft Entra accounts, and manage my accounts in one central location.
---

# Microsoft Entra SSO integration with CloudBees CI

In this article, you'll learn how to integrate CloudBees CI with Microsoft Entra ID. Centralize management, ensure compliance, and automate at scale with CloudBees CI - the secure, scalable, and flexible CI solution based on Jenkins. When you integrate CloudBees CI with Microsoft Entra ID, you can:

* Control in Microsoft Entra ID who has access to CloudBees CI.
* Enable your users to be automatically signed-in to CloudBees CI with their Microsoft Entra accounts.
* Manage your accounts in one central location.

You'll configure and test Microsoft Entra single sign-on for CloudBees CI in a test environment. CloudBees CI supports only **SP** initiated single sign-on.

## Prerequisites

To integrate Microsoft Entra ID with CloudBees CI, you need:

* A Microsoft Entra user account. If you don't already have one, you can [Create an account for free](https://azure.microsoft.com/free/?WT.mc_id=A261C142F).
* One of the following roles: [Application Administrator](/entra/identity/role-based-access-control/permissions-reference#application-administrator), [Cloud Application Administrator](/entra/identity/role-based-access-control/permissions-reference#cloud-application-administrator), or [Application Owner](/entra/fundamentals/users-default-permissions#owned-enterprise-applications).
* A Microsoft Entra subscription. If you don't have a subscription, you can get a [free account](https://azure.microsoft.com/free/).
* CloudBees CI single sign-on (SSO) enabled subscription.

## Add application and assign a test user

Before you begin the process of configuring single sign-on, you need to add the CloudBees CI application from the Microsoft Entra gallery. You need a test user account to assign to the application and test the single sign-on configuration.

<a name='add-cloudbees-ci-from-the-azure-ad-gallery'></a>

### Add CloudBees CI from the Microsoft Entra gallery

Add CloudBees CI from the Microsoft Entra application gallery to configure single sign-on with CloudBees CI. For more information on how to add application from the gallery, see the [Quickstart: Add application from the gallery](~/identity/enterprise-apps/add-application-portal.md).

<a name='create-and-assign-azure-ad-test-user'></a>

### Create and assign Microsoft Entra test user

Follow the guidelines in the [create and assign a user account](~/identity/enterprise-apps/add-application-portal-assign-users.md) article to create a test user account called B.Simon.

Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration). In this wizard, you can add an application to your tenant, add users/groups to the app, and assign roles. The wizard also provides a link to the single sign-on configuration pane. [Learn more about Microsoft 365 wizards.](/microsoft-365/admin/misc/azure-ad-setup-guides). 

<a name='configure-azure-ad-sso'></a>

## Configure Microsoft Entra SSO

Complete the following steps to enable Microsoft Entra single sign-on.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Identity** > **Applications** > **Enterprise applications** > **CloudBees CI** > **Single sign-on**.
1. On the **Select a single sign-on method** page, select **SAML**.
1. On the **Set up single sign-on with SAML** page, select the pencil icon for **Basic SAML Configuration** to edit the settings.

   ![Screenshot shows how to edit Basic SAML Configuration.](common/edit-urls.png "Basic Configuration")

1. On the **Basic SAML Configuration** section, perform the following steps:

    a. In the **Identifier** textbox, type a value using the following pattern:
    `<Customer_EntityID>`

    b. In the **Reply URL** textbox, type a URL using one of the following patterns:

    | **Reply URL** |
    |------------|
    | `https://<CustomerDomain>/cjoc/securityRealm/finishLogin` |
    | `https://<CustomerDomain>/<Environment>/securityRealm/finishLogin` |
    | `https://cjoc.<CustomerDomain>/securityRealm/finishLogin` |
    | `https://<Environment>.<CustomerDomain>/securityRealm/finishLogin` |

	c. In the **Sign on URL** textbox, type the URL using one of the following patterns:

	| **Sign on URL** |
    |------------|
    | `https://<CustomerDomain>/cjoc` |
    | `https://<CustomerDomain>/<Environment>` |
    | `https://cjoc.<CustomerDomain>` |
    | `https://<Environment>.<CustomerDomain>` |

	> [!NOTE]
    > These values are not real. Update these values with the actual Identifier, Reply URL and Sign on URL. Contact [CloudBees CI support team](mailto:support@cloudbees.com) to get these values. You can also refer to the patterns shown in the **Basic SAML Configuration** section.

1. CloudBees CI application expects the SAML assertions in a specific format, which requires you to add custom attribute mappings to your SAML token attributes configuration. The following screenshot shows the list of default attributes.

	![Screenshot shows the image of attributes configuration.](common/default-attributes.png "Image")

1. In addition to above, CloudBees CI application expects few more attributes to be passed back in SAML response, which are shown below. These attributes are also pre populated but you can review them as per your requirements.

	| Name |  Source Attribute|
	| ---------------|  --------- |
	| email | user.mail |
	| username | user.userprincipalname |
    | displayname | user.givenname |
	| groups | user.groups |

1. On the **Set-up single sign-on with SAML** page, in the **SAML Signing Certificate** section, find **Federation Metadata XML** and select **Download** to download the certificate and save it on your computer.

    ![Screenshot shows the Certificate download link.](common/metadataxml.png "Certificate")

1. On the **Set up CloudBees CI** section, copy the appropriate URL(s) based on your requirement.

	![Screenshot shows to copy configuration appropriate U R L.](common/copy-configuration-urls.png "Attributes")

## Configure CloudBees CI SSO

To configure single sign-on in CloudBees CI, please follow [Configure Azure](https://github.com/jenkinsci/saml-plugin/blob/main/doc/CONFIGURE_AZURE.md) using the Federation Metadata XML and copied URLs.

## Test SSO 

In this section, you test your Microsoft Entra single sign-on configuration with following options.

* Click on **Test this application**, this will redirect to CloudBees CI Sign-on URL where you can initiate the login flow.

* Go to CloudBees CI Sign-on URL directly and initiate the login flow from there.

* You can use Microsoft My Apps. When you click the CloudBees CI tile in the My Apps, this will redirect to CloudBees CI Sign-on URL. For more information, see [Microsoft Entra My Apps](/azure/active-directory/manage-apps/end-user-experiences#azure-ad-my-apps).

## Additional resources

* [What is single sign-on with Microsoft Entra ID?](~/identity/enterprise-apps/what-is-single-sign-on.md)
* [Plan a single sign-on deployment](~/identity/enterprise-apps/plan-sso-deployment.md).

## Next steps

Once you configure CloudBees CI you can enforce session control, which protects exfiltration and infiltration of your organization’s sensitive data in real time. Session control extends from Conditional Access. [Learn how to enforce session control with Microsoft Cloud App Security](/cloud-app-security/proxy-deployment-aad).
