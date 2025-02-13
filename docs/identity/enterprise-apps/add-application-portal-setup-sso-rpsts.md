---
title: Enable single sign-on for an enterprise application with a relying party security token service
description: Enable single sign-on for an enterprise application that has a relying party security token service in Microsoft Entra ID.

author: markwahl-msft
manager: CelesteDG
ms.service: entra-id
ms.subservice: enterprise-apps
ms.topic: how-to
ms.date: 02/01/2025
ms.author: mwahl
ms.reviewer: ergreenl
ms.custom: mode-other, enterprise-apps

#customer intent: As an IT admin, I want to enable single sign-on for an enterprise application in Microsoft Entra, so that my users can sign in using their Microsoft Entra credentials and have a seamless authentication experience, by connecting the application's relying party STS to Microsoft Entra ID via SAML. 
---

# Enable single sign-on for an enterprise application with a relying party STS

In this article, you use the Microsoft Entra admin center to enable single sign-on (SSO) for an enterprise application which supports SAML through leveraging a relying party security token service (STS). After you configure SSO, your users can sign in to the application by using their Microsoft Entra credentials.

:::image type="content" source="media/add-application-portal-setup-sso-rpsts/saml-topology.png" alt-text="Diagram showing the trust relationship between an application, a relying party STS, and Microsoft Entra ID as an identity provider.":::

We recommend that you use a nonproduction environment to test the steps in this article, before configuring an application in a production tenant.

## Prerequisites

To configure SSO, you need:

- A relying party STS, such as Active Directory Federation Services or PingFederate, with HTTPS endpoints
- An application which has been integrated with that relying party STS
- One of the following roles in Microsoft Entra: Cloud Application Administrator, Application Administrator

## Document the entity identifier and Reply URL of your relying party STS

1. You'll need to obtain the entity identifier (entity ID) of the relying party STS. This must be unique across all relying party STS configured in a Microsoft Entra tenant. If AD FS is the relying party STS, then the identifier may be a URL of the form `http://{hostname.domain}/adfs/services/trust`.
1. You'l also need to obtain the assertion consumer service reply URL of the relying party STS. This will be a `HTTPS` URL to securely transfer SAML tokens from Microsoft Entra to the relying party STS as part of single sign-on to an application. If AD FS is the relying party STS, then the URL may be of the form `https://{hostname.domain}/adfs/ls/`.

## Create an application in Microsoft Entra

First, create an enterprise application in Microsoft Entra, which will enable Microsoft Entra to generate SAML tokens for the relying party STS.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Identity** > **Applications** > **Enterprise applications** > **All applications**.
1. If you have already configured an application representing the relying party STS, then enter the name of the existing application in the search box, select the application from the search results, and continue at the next section.
1. Select **New application**.
1. Select **Create your own application**.
1. Type the name of the new application in the input name box, select **Integrate any other application you don't find in the gallery (Non-gallery)**, and select **Create**.

## Configure single sign-on in the application

1. In the **Manage** section of the left menu, select **Single sign-on** to open the **Single sign-on** pane for editing.
1. Select **SAML** to open the SSO configuration page.
1. In the **Basic SAML configuration** box, select **Edit**.
1. In the Basic SAML configuration, under **Identifier (Entity ID)**, if there is no identifier listed, select **Add identifier**. Type the identifier for the application as provided by the relying party STS. For example, the identifier may be a URL of the form `http://{hostname.domain}/adfs/services/trust`.
1. In the Basic SAML configuration, under **Reply URL (Assertion Consumer Service URL)**, select **Add reply URL**. Type the HTTPS URL of the relying party STS' Assertion Consumer Service. For example, the URL may be of the form `https://{hostname.domain}/adfs/ls/`.
1. Optionally, configure the **sign on**, **relay state**, or **logout** URLs, if required by the relying party STS.
1. Select **Save**.

## Download metadata and certificates from Microsoft Entra

Your relying party STS may require the federation metadata from Microsoft Entra as the identity provider in order to complete the configuration. These are provided in the **SAML Certificates** section of the **Basic SAML configuration** page.

- If your relying party STS can download federation metadata from an Internet endpoint, then copy the value next to the **App Federation Metadata Url**.
- If your relying party STS requires a local XML file containing the federation metadata, then select **Download** next to **Federation Metadata XML**.
- If your relying party STS requires the certificate of the identity provider, then select **Download** next to either the **Certificate (Base64)** or **Certificate (Raw)**.

## Configure claims in Microsoft Entra

By default, only a few attributes from Microsoft Entra users are included in the SAML token Microsoft Entra sends to the relying party STS. You can add additional claims which your applications require, and change the attribute provided in the SAML name identifier.

1. In the **Attributes & Claims** box, select **Edit**.
1. To change which Entra ID attribute is sent as the value of the Name identifier, select the row **Unique User Identifier (Name ID)**. You can change the source attribute to another Microsoft Entra built-in or extension attribute. Then select **Save**.
1. To change which Entra ID attribute is sent as the value of a claim already configured, select the row in the **Additional claims** section.  
1. To add a new claim, select **Add new claim**.
1. When complete, select **SAML-based Sign-on** to close this screen.

## Configure who can sign-in to the application

When testing the configuration, you should assign a designated test user to the application in Microsoft Entra, to validate that the user is able to sign on to the application via Microsoft Entra and the relying party STS.

1. In the **Manage** section of the left menu, select **Properties**.
1. Confirm that the value of **Enabled for users to sign-in?** is set to **Yes**.
1. Confirm that the value of **Assignment required?** is set to **Yes**.
1. If you have made any changes, select **Save**.
1. In the **Manage** section of the left menu, select **Users and groups**.
1. Select **Add user/group**.
1. Select **None selected**.
1. In the search box, type the name of the test user, then pick the user and select **Select**.
1. Select **Assign** to assign the user to the default **User** role of the application.

After configuration is complete, you can use other features such as dynamic groups or entitlement management to assign additional users to the application. For more information, see [Quickstart: Create and assign a user account](add-application-portal-assign-users.md).

## Configure Microsoft Entra as an identity provider in your relying party STS

Next, import the federation metadata into your relying party STS. The following steps are shown using AD FS, but another relying party STS could be used instead.

1. In the claims provider trust list of your relying party STS, select **Add Claims Provider Trust**, and select **Start**.
1. Depending on whether you downloaded the federation metadata from Microsoft Entra, select **Import data about the the claims provider published online or on a local network**, or **Import data about the claims provider from a file**.
1. You may need to also provide the certificate of Microsoft Entra to the relying party STS.
1. When your configuration of Microsoft Entra as an identity provider is complete, confirm that:
   - The claims provider identifier is a URI of the form `https://sts.windows.net/{tenantid}`.
   - The endpoints for SAML single sign on are URI of the form `https://login.microsoftonline.com/{tenantid}/saml2`.
   - A certificate of Microsoft Entra is recognized by the relying party STS.
   - No encryption is configured.
   - The claims configured in Microsoft Entra are listed as available for claims rule mappings in your relying party STS. If you subsequently added additional claims, you may need to also add them to the configuration of the identity provider in your relying party STS.

## Configure claims rules in your relying party STS

Once the claims that Microsoft Entra will send as the identity provider are known to the relying party STS, you'll need to map or transform those claims into the claims required by your application. The following steps are shown using AD FS, but another relying party STS could be used instead.

1. In the claims provider trust list of your relying party STS, select the claims provider trust for Microsoft Entra, and select **Edit Claims Rules**.
1. For each claim provided by Microsoft Entra and required by your application, select **Add Rule**. In each rule, select **Pass through or Filter an Incoming Claim**, or **Transform an Incoming Claim**, based on the requirements of your application.

## Test the single sign-on to your application

After the application is configured in Microsoft Entra and your relying party STS, users can sign into it by authenticating to Microsoft Entra, and having a token provided by Microsoft Entra transformed by your relying party STS into the form and claims required by your application.

This tutorial illustrates testing the sign-in flow using a web-based application which implements the relying party initiated single sign-on pattern.

:::image type="content" source="media/add-application-portal-setup-sso-rpsts/saml-redirects.png" alt-text="Diagram showing the web browser redirects between an application, a relying party STS, and Microsoft Entra ID as an identity provider.":::

1. In a web browser private browsing session, connect to the application and initiate the login process. The application will redirect the web browser to the relying party STS, and the relying party STS will determine the identity providers which can provide appropriate claims.
1. Select the Microsoft Entra identity provider. The relying party STS will redirect the web browser to the Microsoft Entra login endpoint, `https://login.microsoftonline.com`.
1. Sign in to Microsoft Entra using the identity of the test user, previously configured in the step [configure who can sign into the application](#configure-who-can-sign-in-to-the-application). Microsoft Entra will then locate the enterprise application, and redirect the web browser to the relying party STS reply URL endpoint, with the web browser transporting the SAML token.
1. The relying party STS will validate the SAML token was issued by Microsoft Entra, then extract and transform the claims from the SAML token, and redirect the web browser to the application. Confirm that your application has received the required claims from Microsoft Entra via this process.

## Plan to maintain the certificate in your relying party STS configuration

After configuration, you'll need to ensure that your relying party STS stays up to date as new certificates are added to Microsoft Entra. Some relying party STS may have a built-in process to monitor the federation metadata of the identity provider.

## Next steps

* [What is application management in Microsoft Entra ID?](what-is-application-management.md)
* [Govern access for applications in your environment](~/id-governance/identity-governance-applications-prepare.md)
