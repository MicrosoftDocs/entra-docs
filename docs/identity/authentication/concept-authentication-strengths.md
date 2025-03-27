---
title: Overview of Microsoft Entra authentication strength 
description: Learn how admins can use Microsoft Entra Conditional Access to distinguish which authentication methods can be used based on relevant security factors.


ms.service: entra-id
ms.subservice: authentication
ms.topic: conceptual
ms.date: 03/04/2025

ms.author: justinha
author: inbarckms
manager: femila
ms.reviewer: inbarc
---
# Conditional Access authentication strength 

Authentication strength is a Conditional Access control that specifies which combinations of authentication methods can be used to access a resource. Users can satisfy the strength requirements by authenticating with any of the allowed combinations. 

For example, an authentication strength can require that only phishing-resistant authentication methods be used to access a sensitive resource. To access a nonsensitive resource, administrators can create another authentication strength that allows less secure multifactor authentication (MFA) combinations, such as password + text message. 

Authentication strength is based on the [Authentication methods policy](concept-authentication-methods.md), where administrators can scope authentication methods for specific users and groups to be used across Microsoft Entra ID federated applications. Authentication strength allows further control over the usage of these methods based upon specific scenarios such as sensitive resource access, user risk, location, and more. 

## Scenarios for authentication strengths

Authentication strengths can help customers address these scenarios: 

- Require specific authentication methods to access a sensitive resource.
- Require a specific authentication method when a user takes a sensitive action within an application (in combination with Conditional Access authentication context).
- Require users to use a specific authentication method when they access sensitive applications outside of the corporate network.
- Require more secure authentication methods for users at high risk. 
- Require specific authentication methods from guest users who access a resource tenant (in combination with cross-tenant settings). <!-- Namrata - Add / review external users scenario here -->

## Authentication strengths  

Administrators can specify an authentication strength to access a resource by creating a Conditional Access policy with the **Require authentication strength** control. They can choose from three built-in authentication strengths: **Multifactor authentication strength**, **Passwordless MFA strength**, and **Phishing-resistant MFA strength**. They can also create a custom authentication strength based on the authentication method combinations they want to allow. 

:::image type="content" border="true" source="./media/concept-authentication-strengths/conditional-access-policy-authentication-strength-grant-control.png" alt-text="Screenshot of a Conditional Access policy with an authentication strength configured in grant controls.":::

### Built-in authentication strengths

Built-in authentication strengths are combinations of authentication methods that are predefined by Microsoft. Built-in authentication strengths are always available and can't be modified. Microsoft will update built-in authentication strengths when new methods become available. 

For an example, the built-in **Phishing-resistant MFA strength** allows the following combinations:

- Windows Hello for Business

  Or

- FIDO2 security key

  Or

- Microsoft Entra certificate-based authentication (Multifactor)

:::image type="content" border="true" source="./media/concept-authentication-strengths/authentication-strength-definitions.png" alt-text="Screenshot showing the phishing-resistant MFA strength definition.":::

The combinations of authentication methods for each built-in authentication strength are listed in the following table. These combinations include methods that need to be registered by users and enabled in the Authentication methods policy or the legacy MFA settings policy.

-	**MFA strength** - the same set of combinations that could be used to satisfy the **Require multifactor authentication** setting.
-	**Passwordless MFA strength** - includes authentication methods that satisfy MFA but don't require a password.
-	**Phishing-resistant MFA strength** - includes methods that require an interaction between the authentication method and the sign-in surface.

|Authentication method combination |MFA strength | Passwordless MFA strength| Phishing-resistant MFA strength|
|----------------------------------|-------------|-------------------------------------|-------------------------------------------|
|FIDO2 security key| &#x2705; | &#x2705; | &#x2705; |
|Windows Hello for Business| &#x2705; | &#x2705; | &#x2705; |
|Certificate-based authentication (Multi-Factor) | &#x2705; | &#x2705; | &#x2705; |
|Microsoft Authenticator (Phone Sign-in)| &#x2705; | &#x2705; | | 
|Temporary Access Pass (One-time use AND Multi-use)| &#x2705; | | | 
|Password + something you have<sup>1</sup>| &#x2705; | | |
|Federated single-factor + something you have<sup>1</sup>| &#x2705; | | |
|Federated Multi-Factor| &#x2705; | | |
|Certificate-based authentication (single-factor)| | | |
|SMS sign-in | | | |
|Password | | | |
|Federated single-factor| | | |

<!-- We will move these methods  back to the table as they become supported - expected very soon
|Email One-time pass (Guest)| | | |
-->

<sup>1</sup> Something you have refers to one of the following methods: text message, voice, push notification, software OATH token, or hardware OATH token.

The following API call can be used to list definitions of all the built-in authentication strengths:

```http
GET https://graph.microsoft.com/beta/identity/conditionalAccess/authenticationStrength/policies?$filter=policyType eq 'builtIn'
```

Conditional Access Administrators can also create custom authentication strengths to exactly suit their access requirements. For more information, see [Custom Conditional Access authentication strengths](concept-authentication-strength-advanced-options.md).

## Limitations

- **Conditional Access policies are only evaluated after the initial authentication** - As a result, authentication strength doesn't restrict a user's initial authentication. Suppose you are using the built-in phishing-resistant MFA strength. A user can still type in their password, but they are required to sign in with a phishing-resistant method such as FIDO2 security key before they can continue.

- **Require multifactor authentication and Require authentication strength can't be used together in the same Conditional Access policy** - These two Conditional Access grant controls can't be used together because the built-in authentication strength **Multifactor authentication** is equivalent to the **Require multifactor authentication** grant control.

- **Authentication methods that aren't currently supported by authentication strength** - The **Email one-time pass (Guest)** authentication method isn't included in the available combinations.

- **Windows Hello for Business** – If the user signed in with Windows Hello for Business as their primary authentication method, it can be used to satisfy an authentication strength requirement that includes Windows Hello for Business. However, if the user signed in with another method like password as their primary authentication method, and the authentication strength requires Windows Hello for Business, they aren't prompted to sign in with Windows Hello for Business. The user needs to restart the session, choose **Sign-in options**, and select a method required by the authentication strength.

## Known issues

- **Authentication strength and sign-in frequency** - When a resource requires an authentication strength and a sign-in frequency, users can satisfy both requirements at two different times. 

  For example, let's say a resource requires passkey (FIDO2) for the authentication strength, and a 1-hour sign-in frequency. 24 hours ago, a user signed in with passkey (FIDO2) to access the resource. 
  
  When the user unlocks their Windows device using Windows Hello for Business, they can access the resource again. Yesterday's sign-in satisfies the authentication strength requirement, and today's device unlock satisfies the sign-in frequency requirement.

- **Authentication strength blade double representation** - Platform credentials, such as Windows Hello for Business and **Platform Credential for macOS** are both represented in authentication strength under **Windows Hello For Business**. To configure a custom authentication strength that allows the use of **Platform Credential for macOS**, use **Windows Hello For Business**.

## FAQ

### Should I use authentication strength or the Authentication methods policy?
Authentication strength is based on the Authentication methods policy. The Authentication methods policy helps to scope and configure authentication methods to be used across Microsoft Entra ID by specific users and groups. Authentication strength allows another restriction of methods for specific scenarios, such as sensitive resource access, user risk, location, and more.

For example, the administrator of Contoso wants to allow their users to use Microsoft Authenticator with either push notifications or passwordless authentication mode. The administrator goes to the Microsoft Authenticator settings in the Authentication methods policy, scopes the policy for the relevant users, and sets the **Authentication mode** to **Any**. 

Then for Contoso's most sensitive resource, the administrator wants to restrict the access to only passwordless authentication methods. The administrator creates a new Conditional Access policy, using the built-in **Passwordless MFA strength**. 

As a result, users in Contoso can access most of the resources in the tenant using password + push notification from the Microsoft Authenticator OR only using Microsoft Authenticator (phone sign-in). However, when the users in the tenant access the sensitive application, they must use Microsoft Authenticator (phone sign-in).

## Prerequisites

- **Microsoft Entra ID P1** - Your tenant needs to have Microsoft Entra ID P1 license to use Conditional Access. If needed, you can enable a [free trial](https://www.microsoft.com/security/business/get-started/start-free-trial).

## Next steps

- [Custom Conditional Access authentication strengths](concept-authentication-strength-advanced-options.md)
- [How authentication strength works for external users](concept-authentication-strength-external-users.md)
- [Troubleshoot authentication strengths](troubleshoot-authentication-strengths.md) 

