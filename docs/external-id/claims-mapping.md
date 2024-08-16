---
title: B2B collaboration user claims mapping
description: Customize the user claims that are issued in the SAML token for Microsoft Entra B2B users.

 
ms.service: entra-external-id
ms.topic: concept-article
ms.date: 06/27/2024

ms.author: cmulligan
author: csmulligan
manager: celestedg


ms.collection: M365-identity-device-management

# Customer intent: As a B2B collaboration user, I want to customize the claims issued in the SAML token for my application in Microsoft Entra External ID, so that I can ensure the token contains the specific information I need for user identification and authentication.

---

# B2B collaboration user claims mapping in Microsoft Entra External ID

[!INCLUDE [applies-to-workforce-only](./includes/applies-to-workforce-only.md)]

With Microsoft Entra External ID, you can customize the claims that are issued in the SAML token for [B2B collaboration](what-is-b2b.md) users. When a user authenticates to the application, Microsoft Entra ID issues a SAML token to the app that contains information (or claims) about the user that uniquely identifies them. By default, this claim includes the user's user name, email address, first name, and family name.

In the [Microsoft Entra admin center](https://entra.microsoft.com), you can view or edit the claims that are sent in the SAML token to the application. To access the settings, browse to **Identity** > **Applications** > **Enterprise applications** > the application that's configured for single sign-on > **Single sign-on**. See the SAML token settings in the **User Attributes** section.

:::image type="content" source="media/claims-mapping/view-claims-in-saml-token-attributes.png" alt-text="Screenshot of the SAML token attributes in the UI.":::

There are two possible reasons why you might need to edit the claims that are issued in the SAML token:

1. The application requires a different set of claim URIs or claim values.

2. The application requires the NameIdentifier claim to be something other than the user principal name [(UPN)](~/identity/hybrid/connect/plan-connect-userprincipalname.md#what-is-userprincipalname) that's stored in Microsoft Entra ID.

For information about how to add and edit claims, see [Customizing claims issued in the SAML token for enterprise applications in Microsoft Entra ID](~/identity-platform/saml-claims-customization.md).

## UPN claims behavior for B2B users

If you need to issue the UPN value as an application token claim, the actual claim mapping may behave differently for B2B users. If the B2B user authenticates with an external Microsoft Entra identity and you issue user.userprincipalname as the source attribute, Microsoft Entra ID issues the UPN attribute from the home tenant for this user.  

All [other external identity types](redemption-experience.md#invitation-redemption-flow) such as SAML/WS-Fed, Google, Email OTP issues the UPN value rather than the email value when you issue user.userprincipalname as a claim. If you want the actual UPN to be issued in the token claim for all B2B users, you can set user.localuserprincipalname as the source attribute instead. 

>[!NOTE]
>The behavior mentioned in this section is same for both cloud-only B2B users and synced users who were [invited/converted to B2B collaboration](invite-internal-users.md). 

## Related content

- For information about B2B collaboration user properties, see [Properties of a Microsoft Entra B2B collaboration user](user-properties.md).
- For information about user tokens for B2B collaboration users, see [Understand user tokens in Microsoft Entra B2B collaboration](user-token.md).
