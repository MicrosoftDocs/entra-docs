---
title: Identity Providers
description: Learn about sign-in and MFA options for customer identity and access management (CIAM) in external tenants, including email, one-time passcodes, Google, Facebook, Apple and custom OIDC.  
 
author: msmimart
manager: celestedg
ms.service: entra-external-id
 
ms.subservice: external
ms.topic: concept-article
ms.date: 08/09/2024
ms.author: mimart
ms.custom: it-pro, seo-july-2024
---

# Identity providers for external tenants

[!INCLUDE [applies-to-external-only](../includes/applies-to-external-only.md)]

> [!TIP]
> This article applies to External ID in external tenants. For information about workforce tenants, see [Identity providers for External ID in workforce tenants](../identity-providers.md).

With Microsoft Entra External ID, you can create secure, customized sign-in experiences for your consumer- and business customer-facing apps. In an external tenant, there are several ways for users to sign up for your app. They can create an account using their email and either a password or a one-time passcode. Or, if you enable sign-in with Facebook, Google, Apple or a custom OIDC identity provider, they can sign in with their own account.

This article describes the identity providers that are available for primary authentication when signing up and signing in to apps in external tenants. You can also enhance security by enforcing a multifactor authentication (MFA) policy that requires a second form of verification each time a user signs in ([learn more](concept-multifactor-authentication-customers.md)).

## Email and password sign-in

Email sign-up is enabled by default in your local account identity provider settings. With the email option, customers can sign up and sign in with their email address and a password.

- **Sign-up**: Customers are prompted for an email address, which is verified at sign-up with a one-time passcode. The customer then enters any other information requested on the sign-up page, for example, display name, given name, and surname. Then they select Continue to create an account.

- **Sign-in**: After the customer signs up and creates an account, they can sign in by entering their email address and password.

- **Password reset**: If you enable email and password sign-in, a password reset link appears on the password page. If the customer forgets their password, selecting this link sends a one-time passcode to their email address. After verification, the customer can choose a new password.

   :::image type="content" source="media/concept-authentication-methods-customers/email-password-sign-in.png" alt-text="Screenshots of the email with password sign-in screens." border="false":::

When you [create a sign-up and sign-in user flow](how-to-user-flow-sign-up-sign-in-customers.md#create-and-customize-a-user-flow), **Email with password** is the default option.

## Email with one-time passcode sign-in

Email with one-time passcode is an option in your local account identity provider settings. With this option, the customer signs in with a temporary passcode instead of a stored password each time they sign in.

- **Sign-up**: Customers can sign up with their email address and request a temporary code, which is sent to their email address. Then they enter this code to continue signing in.

- **Sign-in**: After the customer signs up and creates an account, each time they sign in they'll enter their email address and receive a temporary passcode.

   :::image type="content" source="media/concept-authentication-methods-customers/email-passcode-sign-in.png" alt-text="Screenshots of the email with one-time passcode sign-in screens." border="false":::

You can also configure options for showing, hiding, or customizing the self-service password reset link on the sign-in page ([learn more](how-to-customize-branding-customers.md#to-customize-self-service-password-reset)).

When you [create a sign-up and sign-in user flow](how-to-user-flow-sign-up-sign-in-customers.md#create-and-customize-a-user-flow), **Email one-time passcode** is one of the local account options.

## Social identity providers: Facebook, Google and Apple

For an optimal sign-in experience, federate with social identity providers whenever possible so you can give your customers a seamless sign-up and sign-in experience. In an external tenant, you can allow a customer to sign up and sign in using their own Facebook, Google, or Apple account. When a customer signs up for your app using their social account, the social identity provider creates, maintains, and manages identity information while providing authentication services to applications.

When you enable social identity providers, customers can select from the social identity providers options you make available on the sign-up page. To set up social identity providers in your external tenant, you create an application at the identity provider and configure credentials. You obtain a client or app ID and a client or app secret, which you can then add to your external tenant.

### Google sign-in (preview)

By setting up federation with Google, you can allow customers to sign in to your applications with their own Gmail accounts. After you add Google as one of your application's sign-in options, on the sign-in page, users can sign in to Microsoft Entra External ID with a Google account.

The following screenshots show the sign-in with Google experience. In the sign-in page, users select **Sign-in with Google**. At that point, the user is redirected to the Google identity provider to complete the sign-in.

   :::image type="content" source="media/concept-authentication-methods-customers/google-sign-in.png" alt-text="Screenshots of google sign-in screens." border="false":::

Learn how to [add Google as an identity provider](how-to-google-federation-customers.md).

### Facebook sign-in (preview)

By setting up federation with Facebook, you can allow invited users to sign in to your applications with their own Facebook accounts. After you add Facebook as one of your application's sign-in options, on the sign-in page, users can sign-in to Microsoft Entra External ID with a Facebook account.

The following screenshots show the sign-in with Facebook experience. In the sign-in page, users select **Sign-in with Facebook**. Then the user is redirected to the Facebook identity provider to complete the sign-in.

   :::image type="content" source="media/concept-authentication-methods-customers/facebook-sign-in.png" alt-text="Screenshots of Facebook sign-in screens." border="false":::

Learn how to [add Facebook as an identity provider](how-to-facebook-federation-customers.md).

### Apple sign-in (preview)

By setting up federation with Apple, you can allow invited users to sign in to your applications with their own Apple accounts. After you add Apple as one of your application's sign-in options, on the sign-in page, users can sign-in to Microsoft Entra External ID with an Apple account.

The following screenshots show the sign-in with Apple experience. In the sign-in page, users select **Sign-in with Apple**. Then the user is redirected to the Apple identity provider to complete the sign-in.
Learn how to [add Apple as an identity provider](how-to-apple-federation-customers.md).

## Custom OIDC identity provider (preview)

You can set up a custom OpenID Connect (OIDC) identity provider to enable customers to sign up and sign in to your applications with their own accounts. When a customer signs up for your app using their custom OIDC identity provider, the identity provider creates, maintains, and manages identity information while providing authentication services to applications.

You can also federate your sign-in and sign-up flows with an Azure AD B2C tenant using the OIDC protocol.

Learn how to [set up a custom OIDC identity provider](how-to-custom-oidc-federation-customers.md).

## Updating sign-in methods

At any time, you can update the sign-in options for an app. For example, you can add social identity providers or change the local account sign-in method.

When you change sign-in methods, the change affects only new users. Existing users continue to sign in using their original method. For example, suppose you start out with the email and password sign-in method, and then change to email with one-time passcode. New users sign in using a one-time passcode, but any users who already signed up with an email and password continue to be prompted for their email and password.

## Microsoft Graph APIs

The following Microsoft Graph API operations are supported for managing identity providers and authentication methods in Microsoft Entra External ID:

- To identify what identity providers and authentication methods are supported, you call the [List availableProviderTypes](/graph/api/identityproviderbase-availableprovidertypes) API.
- To identify the identity providers and authentication methods that are already configured and enabled in the tenant, you call the [List identityProviders](/graph/api/identitycontainer-list-identityproviders) API.
- To enable a supported identity provider or authentication method, you call the [Create identityProvider](/graph/api/identitycontainer-post-identityproviders) API.

## Related content

- [Add Facebook as an identity provider](how-to-facebook-federation-customers.md)
- [Add Google as an identity provider](how-to-google-federation-customers.md)
- [Add Apple as an identity provider](how-to-apple-federation-customers.md)
