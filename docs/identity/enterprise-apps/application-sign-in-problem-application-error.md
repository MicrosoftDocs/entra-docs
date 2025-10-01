---
title: An app page shows an error message after the user signs in
description: How to resolve issues with Microsoft Entra sign-in when the app returns an error message.

author: omondiatieno
manager: mwongerapk
ms.service: entra-id
ms.subservice: enterprise-apps

ms.topic: troubleshooting
ms.date: 04/29/2025
ms.author: jomondi
ms.reviewer: ergreenl
ms.collection: M365-identity-device-management
ms.custom: enterprise-apps

#customer intent: As an IT admin managing applications in Microsoft Entra ID, I want to learn how to troubleshoot issues with Microsoft Entra sign-in when the app returns an error message, so that I can effectively manage and secure applications in my organization.
---

# An app page shows an error message after the user signs in

In this scenario, Microsoft Entra ID signs the user in. But the application displays an error message and doesn't let the user finish the sign-in flow. The problem is that the app didn't accept the response that Microsoft Entra ID issued.

There are several possible reasons why the app didn't accept the response from Microsoft Entra ID. If there's an error message or code displayed, use the following resources to diagnose the error:

- [Microsoft Entra authentication and authorization error codes](~/identity-platform/reference-error-codes.md)
- [Troubleshooting consent prompt errors](application-sign-in-unexpected-user-consent-error.md)

If the error message doesn't clearly identify what's missing from the response, try the following steps:

- If the app is in the Microsoft Entra gallery, verify that you followed the steps in [How to debug SAML-based single sign-on to applications in Microsoft Entra ID](./debug-saml-sso-issues.md).
- Use a tool like [Fiddler](https://www.telerik.com/fiddler) to capture the SAML request, response, and token.
- Send the SAML response to the app vendor and ask them what's missing.


## Attributes are missing from the SAML response

To add an attribute in the Microsoft Entra configuration that is sent in the Microsoft Entra response, follow these steps:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator). 
1. Browse to **Entra ID** > **Enterprise apps** > **All applications**.
1. Enter the name of the existing application in the search box, and then select the application that you want to configure for single sign-on.
1. After the app loads, select **Single sign-on** in the navigation pane.
1. In the **User Attributes** section, select **View and edit all other user attributes**. Here you can change which attributes to send to the app in the SAML token when users sign in.

   To add an attribute:

   1. Select **Add attribute**. Enter the **Name**, and select the **Value** from the drop-down list.

   1. Select **Save**. You see the new attribute in the table.

1. Save the configuration.

   The next time that the user signs in to the app, Microsoft Entra ID will send the new attribute in the SAML response.

## The app can't identify the user

Signing in to the app fails because the SAML response is missing an attribute such as a role. Or it fails because the app expects a different format or value for the **NameID** (User Identifier) attribute.

If you're using [Microsoft Entra ID automated user provisioning](~/identity/app-provisioning/user-provisioning.md) to create, maintain, and remove users in the app, verify that the user is provisioned to the SaaS app. For more information, see [No users are being provisioned to a Microsoft Entra Gallery application](~/identity/app-provisioning/application-provisioning-config-problem-no-users-provisioned.md).

<a name='add-an-attribute-to-the-azure-ad-app-configuration'></a>

### Add an attribute to the Microsoft Entra app configuration

To change the User Identifier value, follow these steps:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator). 
1. Browse to **Entra ID** > **Enterprise apps** > **All applications**.
1. Select the app that you want to configure for SSO.
1. After the app loads, select **Single sign-on** in the navigation pane.
1. Under **User attributes**, select the unique identifier for the user from the **User Identifier** drop-down list.

### Change the NameID format

If the application expects another format for the **NameID** (User Identifier) attribute, see the [Edit nameID](~/identity-platform/saml-claims-customization.md#edit-nameid) section to change the NameID format.

Microsoft Entra ID selects the format for the **NameID** attribute (User Identifier) based on the value selected or the format that's requested by the app in the SAML AuthRequest. For more information, see the "NameIDPolicy" section of [Single sign-on SAML protocol](~/identity-platform/single-sign-on-saml-protocol.md#nameidpolicy).

## The app expects a different signature method for the SAML response

To change which parts of the SAML token are digitally signed by Microsoft Entra ID, follow these steps:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **Enterprise apps** > **All applications**.
1. Select the application that you want to configure for single sign-on.
1. After the application loads, select **Single sign-on** in the navigation pane.
1. Under **SAML Signing Certificate**, select  **Show advanced certificate signing settings**.
1. Select the **Signing Option** that the app expects from among these options:

   - **Sign SAML response**
   - **Sign SAML response and assertion**
   - **Sign SAML assertion**

   The next time that the user signs in to the app, Microsoft Entra ID will sign the part of the SAML response that you selected.

## The app expects the SHA-1 signing algorithm

By default, Microsoft Entra ID signs the SAML token by using the most-secure algorithm. We recommend that you don't change the signing algorithm to *SHA-1* unless the app requires SHA-1.

To change the signing algorithm, follow these steps:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator). 
1. Browse to **Entra ID** > **Enterprise apps** > **All applications**.
1. Select the app that you want to configure for single sign-on.
1. After the app loads, select **Single sign-on** from the navigation pane on the left side of the app.
1. Under **SAML Signing Certificate**, select **Show advanced certificate signing settings**.
1. Select **SHA-1** as the **Signing Algorithm**.

   The next time that the user signs in to the app, Microsoft Entra ID will sign the SAML token by using the SHA-1 algorithm.

## Related content

- [How to debug SAML-based single sign-on to applications in Microsoft Entra ID](./debug-saml-sso-issues.md)
- [Microsoft Entra authentication and authorization error codes](~/identity-platform/reference-error-codes.md)
- [Troubleshooting consent prompt errors](application-sign-in-unexpected-user-consent-error.md)
