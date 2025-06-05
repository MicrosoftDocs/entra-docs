---
title: Set up claims mapping for OIDC
description: Learn how to configure the standard OpenID Connect claims with the claims your identity provider provides in your external tenant.
author: csmulligan
manager: celestedg
ms.service: entra-external-id
ms.subservice: external
ms.topic: how-to
ms.date: 03/12/2025
ms.author: cmulligan
ms.reviewer: brozbab
ms.custom: it-pro, sfi-image-nochange
#Customer intent: As a developer, devops, or it administrator, I want to learn how to configure the standard OpenID Connect claims with the claims my identity provider provides in my external tenant.
---

# OpenID Connect claims mapping

[!INCLUDE [applies-to-external-only](../includes/applies-to-external-only.md)]

In OpenID Connect protocol, claims are used to communicate information about the end user and contains pieces of information about a user that an identity provider states inside the ID token they issue for that user. The ID Token is a security token that contains claims about the end-user. These ID token claims are used to uniquely identify and provide information about the user during sign-up. These information pieces are stored in the corresponding user attributes in the user's profile in your directory.

To set up claims mapping, you need to create an identity provider (IdP) in your Microsoft Entra External ID tenant. The IdP configuration includes the **Claims mapping** section where you can configure the standard OpenID Connect (OIDC) claims with the claims your identity provider provides in the ID Token.

:::image type="content" source="media/reference-oidc-claims-mapping-customers/oidc-claims-mapping.png" alt-text="Screenshot of adding claims mapping.":::

## Claim and attribute mappings

Find the list of standard OpenID Connect claims and the corresponding user flow attributes. You can map to your IdP claims with the OIDC standard claims in the following table:

|OIDC Standard Claim|User flow attribute|Description|
|:-------|:-------|:----------|
|sub|N/A|Subject - Identifier for the end-user at the Issuer.|
|name|Display Name|Full name in displayable form including all name parts, possibly including titles and suffixes, ordered according to the end-user's locale and preferences.|
|given_name|First Name |Given name(s) or first name(s) of the end-user.|
|family_name|Last Name |Surname(s) or family name of the end-user.|
|email (required)|Email|Preferred e-mail address.|
|email_verified|N/A|In the received ID token, the value of this claim is true if the end-user's e-mail address has been verified by the identity provider; otherwise, false. When this claim value is true, this means that your identity provider took affirmative steps to ensure that this e-mail address was controlled by the end-user at the time the verification was performed. If this claim value is false or not mapped to any claim from the identity provider, the user will not be able to create an account. A verified email address is required for account creation. If the email is missing or unverified, an error message appears.|
|phone_number|Phone number|The claim provides the phone number for the user.|
|phone_number_verified|N/A|In the received ID token, the value of this claim is true if the end-user's phone number has been verified; otherwise, false. When this claim value is true, this means that your identity provider took affirmative steps to verify the phone number.|
|street_address|Street Address|Full mailing address, formatted for display or use on a mailing label. In the token response, this field MAY contain multiple lines, separated by newlines. Newlines can be represented either as a carriage return/line feed pair ("\r\n") or as a single line feed character ("\n").|
|locality |City|City or locality.|
|region|State or Province|State, province, prefecture, or region.|
|postal_code|ZIP or Postal Code|Zip code or postal code.|
|country |Country or Region|Country name.|

> [!NOTE]
> To collect user data from the ID token issued by your identity provider, you need to do two things. First, map your external identity provider claims with the OIDC standard claims. Second, enable the corresponding user flow attributes in the user flow, which the identity provider is attached.

## Review the identity provider

After you have added the claims mapping, you can review the OIDC configuration in the **Review** tab. The **Review** tab displays the claims list and the corresponding user flow attributes that you have mapped to your IdP claims. 

:::image type="content" source="media/reference-oidc-claims-mapping-customers/review-oidc-config.png" alt-text="Screenshot of reviewing the claims list.":::