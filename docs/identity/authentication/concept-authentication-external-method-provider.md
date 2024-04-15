---
title: Microsoft Entra multifactor authentication external method provider reference (Preview)
description: Learn how to configure an external authentication method provider for Microsoft Entra multifactor authentication


ms.service: entra-id
ms.subservice: authentication
ms.topic: conceptual
ms.date: 02/28/2024

ms.author: justinha
author: justinha
manager: amycolannino
ms.reviewer: gregkmsft, msgustavosa

# Customer intent: As an external identity provider (IdP) for Microsoft Entra ID, I want to learn how to configure an external authentication method for Entra ID tenants.

---
# Microsoft Entra multifactor authentication external method provider reference (Preview)

This topic describes how external authentication providers connect to Entra ID, and how tenant admins can manage authentication requirements for their tenant to be satisfied by external provider authentication for a second factor. 

Entra ID external authentication methods are the way to allow customers to integrate external authentication providers as a method to satisfy the authentication requirements for the resource/application being requested.  

When a user signs in, that tenant's policies are evaluated. The authentication requirements are determined based on the resource being accessed. Any number of policies may apply to a given sign-in given the parameters of each policy. Those parameters include users and groups, applications, platform, sign-in risk level, and others. Based on the authentication requirements, the user may need use an additional factor that satisfies the MFA requirement.  This factor will need to complement the type of first factor. 

The user’s authentication will be treated as having met the MFA requirement once Entra ID has validated that the first factor completed with Entra ID and the second factor completed with the external provider satisfy the requirement for two or more types of methods from "something you know", "something you have", "something you are."

This document describes integration of authentication methods provided by external authentication providers, called external authentication methods, to satisfy the second factor, in addition to the built-in authentication methods. External authentication methods are added to Entra ID by the tenant admin.

External authentication methods are implemented on top of Open ID Connect. This implementation requires at least three publicly facing endpoints: 

- An Open ID Connect Discovery endpoint, described in [Discovery of provider metadata via OIDC Discovery](how-to-authentication-external-method-interaction.md#discovery-of-provider-metadata)
- A valid Open ID Connect authentication endpoint
- A URL where the public certificates of the provider are published

The flow to satisfy authentication that includes an external method is as follows:

1. User attempts to sign in to an app that is protected by Entra ID, satisfies first factor (such as an Entra ID password).
1. Entra ID determines that an additional factor needs to be satisfied, for example, by processing Conditional Access policies for the user’s tenant.
1. User chooses the external auth method as second factor.
1. Entra ID redirects the user's browser session to the external authentication method URL:
   1. This URL is discovered from the discovery URL provisioned by the admin when creating the external authentication method.
   1. The app provides an expired/near-expired token that contains information identifying the user and tenant.
1. The external authentication provider validates that the token came from Entra ID and checks the contents of the token.
1. The external authentication provider might optionally make a call to Microsoft Graph to fetch additional information about the user.
1. The external authentication provider performs any actions it deems necessary, such as authenticating the user with some credential.
1. The external authentication provider redirects the user back to Entra ID with a valid token, including all required claims.
1. Entra ID validates that the token's signature came from the configured external authentication provider and then checks the contents of the token.
1. Entra ID compares the claims in the token to the claims required.
1. If the claims meet the required claims list, the user has satisfied the requirement. If the user satisfies any additional policy requirements, authentication succeeds and the access token is issued satisfying MFA.

:::image type="content" source="./media/concept-authentication-external-method-provider/how-external-method-authentication-works.png" alt-text="Diagram of how external method authentication works.":::

## Custom controls and external authentication methods

In Entra ID, external authentication methods and Conditional Access custom controls can operate in parallel while customers prepare for and migrate to external authentication methods.

Customers that are currently using an integration with an external provider via custom controls can continue to use the custom control and any configured Conditional Access policies to manage their authentication requirements for resources. Admins are recommended to create parallel set of Conditional Access policies during this migration period:

- The policies should use the **Require multifactor authentication** grant control instead of the Custom Control grant.  

   >[!NOTE]
   >Grant controls based on authentication strengths, including the built-in MFA strength, will not be satisfied by the external authentication method. Policies should only be configured with **Require multifactor authentication**. Authentication strengths support for external authentication methods will be added later.

- The new policy can be tested first with a subset of users. The test group would be excluded from the policy that requires the custom controls and included in the policy that requires multifactor authentication. Once the admin is comfortable with the policy requiring multifactor authentication and being satisified via the external authentication method, all required users can be included in the policy with the multifactor authentication grant, and the policy configured for custom controls can be moved to "off". 

## Entra ID error response handling

Services in Microsoft Azure platform use a correlationId to correlate calls across various internal and external systems. It serves as a common identifier of the whole operation (or flow) potentially involving multiple HTTP calls. When an error occurs during any of the operations, the response will contain a field named Correlation Id.

When reaching out to Microsoft support or similar service, please provide the value of this CorrelationId as it helps to access the telemetry and logs faster.

For example:

ENTRA IDSTS70002: Error validating credentials. ENTRA IDSTS50012: External ID token from issuer 'https://sts.XXXXXXXXX.com/auth/realms/XXXXXXXXXmfa' failed signature verification. KeyID of token is 'Rk3vlP4vD3OMJzBvrig81pnvaMqA'
Trace ID: 01c2cd09-8997-45bf-bfe4-18fdf9d1a101
**Correlation ID**: 72826bb4-abb7-4221-b253-100f530b4b0a
Timestamp: 2023-07-24 16:51:34Z


## Integration support

If you have any issues building your external authentication methods integration with Entra ID, the Microsoft Customer Experience Engineering (CxE) ISV team may be able to assist. To engage with the CxE ISV team, submit a [request for assistance](https://aka.ms/EAMProviderSupport).

## References

- [OAuth2.0 and OIDC specification](https://oauth.net/2/)

## Next steps

- [Configure an external authentication method identity provider](how-to-authentication-external-method-configure.md)
- [Add an external authentication method identity provider](how-to-authentication-external-method-add.md)
- [Entra ID interaction with provider](how-to-authentication-external-method-interaction.md)
