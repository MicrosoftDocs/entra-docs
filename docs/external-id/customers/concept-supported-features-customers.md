---
title: External Tenant Features
description: Compare the features and capabilities of a workforce vs. an external tenant configuration. Determine which tenant type applies to your external identities scenario.
 
author: msmimart
manager: celestedg
ms.service: entra-external-id
 
ms.subservice: external
ms.topic: concept-article
ms.date: 10/07/2024
ms.author: mimart
ms.custom: it-pro, seo-july-2024

#Customer intent: As a dev, devops, or it admin, I want to learn about features supported in a CIAM tenant. 
---

# Supported features in workforce and external tenants

There are two ways to configure a Microsoft Entra tenant, depending on how the organization intends to use the tenant and the resources they want to manage:

- A **workforce** tenant configuration is for your employees, internal business apps, and other organizational resources. B2B collaboration is used in a workforce tenant to collaborate with external business partners and guests.
- An **external** tenant configuration is used exclusively for External ID scenarios where you want to publish apps to consumers or business customers.

This article gives a detailed comparison of the features and capabilities available in [workforce and external tenants](../tenant-configurations.md).

> [!NOTE]
> During preview, features or capabilities that require a premium license are unavailable in external tenants.

## General feature comparison

The following table compares the general features and capabilities available in workforce and external tenants.

|Feature  |Workforce tenant  | External tenant |
|---------|---------|---------|
| **External identities scenario** | Allow business partners and other external users to collaborate with your workforce. Guests can securely access your business applications through invitations or self-service sign-up.  | Use External ID to secure your applications. Consumers and business customers can securely access your consumer apps through self-service sign-up. Invitations are also supported.  |
| **Local accounts** | Local accounts are supported for *internal* members of your organization only.    | Local accounts are supported for:</br>- External users (consumers, business customers) who use self-service sign-up.</br>- Accounts created by admins. |
| **Groups** | [Groups](~/fundamentals/how-to-manage-groups.yml) can be used to manage administrative and user accounts.| Groups can be used to manage administrative accounts. Support for Microsoft Entra groups and [application roles](how-to-use-app-roles-customers.md) is being phased into customer tenants. For the latest updates, see [Groups and application roles support](reference-group-app-roles-support.md). |
| **Roles and administrators**| [Roles and administrators](~/fundamentals/how-subscriptions-associated-directory.yml) are fully supported for administrative and user accounts. | Roles aren't supported with customer accounts. Customer accounts don't have access to tenant resources.|
| **ID Protection**    |   Provides ongoing risk detection for your Microsoft Entra tenant. It allows organizations to discover, investigate, and remediate identity-based risks.    |   A subset of the Microsoft Entra ID Protection risk detections is available. [Learn more](how-to-identity-protection-customers.md).    |
| **Self-service password reset**    |   Allow users to reset their password using up to two authentication methods (see the next row for available methods).    |   Allow users to reset their password using email with one time passcode. [Learn more](how-to-enable-password-reset-customers.md).     |  
| **Language customization**    | Customize the sign-in experience based on browser language when users authenticate into your corporate intranet or web-based applications.     |   Use languages to modify the strings displayed to your customers as part of the sign-in and sign-up process. [Learn more](concept-branding-customers.md).   |
| **Custom attributes**    |    Use directory extension attributes to store more data in the Microsoft Entra directory for user objects, groups, tenant details, and service principals.    |   Use directory extension attributes to store more data in the customer directory for user objects. Create custom user attributes and add them to your sign-up user flow. [Learn more](how-to-define-custom-attributes.md).    |

## Look and feel customization

The following table compares the features available for look and feel customization in workforce and external tenants.

|Feature  |Workforce tenant  | External tenant |
|---------|---------|---------|
| **Company branding** | You can add [company branding](~/fundamentals/how-to-customize-branding.md) that applies to all these experiences to create a consistent sign-in experience for your users. | Same as workforce. [Learn more](how-to-customize-branding-customers.md) |
| **Language customization** | [Customize the sign-in experience by browser language](~/fundamentals/how-to-customize-branding.md). | Same as workforce. [Learn more](how-to-customize-languages-customers.md) |
| **Custom domain names** |  You can use [custom domains](~/fundamentals/add-custom-domain.yml) for administrative accounts only. | The [custom URL domain (preview)](concept-custom-url-domain.md) feature for external tenants lets you brand app sign-in endpoints with your own domain name.|
| **Native authentication** for mobile apps| Not available |Microsoft Entra’s [native authentication](concept-native-authentication.md) allows you to have full control over the design of your mobile application sign-in experiences.|


## Adding your own business logic

Custom authentication extensions allow you to customize the Microsoft Entra authentication experience by integrating with external systems. A custom authentication extension is essentially an event listener that, when activated, makes an HTTP call to a REST API endpoint where you define your own business logic. The following table compares the [custom authentication extensions](./concept-custom-extensions.md) events available in workforce and external tenants.

|Event  |Workforce tenant  | External tenant |
|---------|---------|---------|
| **TokenIssuanceStart**    |  [Add claims from external systems](~/identity-platform/custom-extension-overview.md).    |   [Add claims from external systems](./concept-custom-extensions.md).    |  
| **OnAttributeCollectionStart**|Not available| Occurs at the beginning of the sign-up's attribute collection step, before the attribute collection page renders. You can add actions such as prefilling values and displaying a blocking error. [Learn more](~/identity-platform/custom-extension-attribute-collection.md?toc=%2Fentra%2Fexternal-id%2Ftoc.json&bc=%2Fentra%2Fexternal-id%2Fbreadcrumb%2Ftoc.json&tabs=start-continue%2Csubmit-continue) |
| **OnAttributeCollectionSubmit**|Not available| Occurs during the sign-up flow, after the user enters and submits attributes. You can add actions such as validating or modifying the user's entries. [Learn more](~/identity-platform/custom-extension-attribute-collection.md?toc=%2Fentra%2Fexternal-id%2Ftoc.json&bc=%2Fentra%2Fexternal-id%2Fbreadcrumb%2Ftoc.json&tabs=start-continue%2Csubmit-continue)|

## Identity providers and authentication methods

The following table compares the [identity providers](../identity-providers.md) and methods available for primary authentication and multifactor authentication (MFA) in workforce and external tenants.

|Feature  |Workforce tenant  | External tenant |
|---------|---------|---------|
| **Identity providers for external users (primary authentication)** | **For self-service sign-up guests**</br>- Microsoft Entra accounts</br>- Microsoft accounts</br>- Email one-time passcode</br>- Google federation</br>- Facebook federation<br></br>**For invited guests**</br>- Microsoft Entra accounts</br>- Microsoft accounts</br>- Email one-time passcode</br>- Google federation</br>- SAML/WS-Fed federation | **For self-service sign-up users (consumers, business customers)**</br>- [Email with password](concept-authentication-methods-customers.md#email-and-password-sign-in)</br>- [Email one-time passcode](./concept-authentication-methods-customers.md#email-with-one-time-passcode-sign-in)</br>- [Google federation (preview)](./how-to-google-federation-customers.md)</br>- [Facebook federation (preview)](./how-to-facebook-federation-customers.md)<br></br>**For invited guests (preview)**</br>Guests invited with a directory role (for example, admins):</br>- Microsoft Entra accounts </br>- Microsoft accounts </br>- [Email one-time passcode](./concept-authentication-methods-customers.md#email-with-one-time-passcode-sign-in) |
|   **Authentication methods for MFA**  | **For internal users (employees and admins)** </br>- [Authentication and verification methods](~/identity/authentication/concept-authentication-methods.md) </br>**For guests (invited or self-service sign-up)** </br>- [Authentication methods for guest MFA](../authentication-conditional-access.md#table-1-authentication-strength-mfa-methods-for-external-users)  |  **For self-service sign-up users (consumers, business customers) or invited users (preview)**</br>- [Email one-time passcode](concept-multifactor-authentication-customers.md#email-one-time-passcode)</br>- [SMS-based authentication](concept-multifactor-authentication-customers.md#sms-based-authentication)    |

## Application registration

The following table compares the features available for [Application registration](./how-to-register-ciam-app.md) in each type of tenant.

|Feature  |Workforce tenant  | External tenant |
|---------|---------|---------|
|   **Protocol**     |   SAML relying parties, OpenID Connect, and OAuth2    |   OpenID Connect and OAuth2    |
| **Supported account types**| The following [account types](~/identity-platform/quickstart-register-app.md#register-an-application): <ul><li>Accounts in this organizational directory only (Single tenant)</li><li>Accounts in any organizational directory (Any Microsoft Entra tenant - Multitenant)</li><li>Accounts in any organizational directory (Any Microsoft Entra tenant - Multitenant) and personal Microsoft accounts (such as Skype, Xbox)</li><li>Personal Microsoft accounts only</li></ul> | Always use *Accounts in this organizational directory only (Single tenant)*. |
| **Platform** | The following [platforms](~/identity-platform/quickstart-register-app.md#configure-platform-settings): <ul><li>Public client/native (mobile & desktop)</li><li>Web</li><li>Single page application (SPA)</li><ul>| The following [platforms](~/identity-platform/quickstart-register-app.md#configure-platform-settings): <ul><li>Public client (mobile & desktop)</li><li>[Native authentication mobile](concept-native-authentication.md) </li><li>Web</li><li>Single page application (SPA)</li><ul>|
| **Authentication** > **Redirect URIs**| The URIs Microsoft Entra ID accepts as destinations when returning authentication responses (tokens) after successfully authenticating or signing out users. | Same as workforce.|
| **Authentication** > **Front-channel logout URL**| This URL is where Microsoft Entra ID sends a request to have the application clear the user's session data. The Front-channel logout URL is required for single sign-out to work correctly.| Same as workforce.|
| **Authentication** > **Implicit grant and hybrid flows**| Request a token directly from the authorization endpoint. | Same as workforce.|
| **Certificates & secrets** | <ul><li>[Certificate](../../identity-platform/quickstart-register-app.md?tabs=certificate)</li><li>[Client secrets](../../identity-platform/quickstart-register-app.md?tabs=client-secret)</li><li>[Federated credentials](../../identity-platform/quickstart-register-app.md?tabs=federated-credential)</li></ul>| Same as workforce.|
| **API permissions** | Add, remove, and replace permissions to an application. After permissions are added to your application, users or admins need to grant consent to the new permissions. Learn more about [updating an app's requested permissions in Microsoft Entra ID](../../identity-platform/howto-update-permissions.md).  | The following are the allowed permissions: Microsoft Graph `offline_access`, `openid`, and `User.Read` and your **My APIs** delegated permissions. Only an admin can consent on behalf of the organization.  |
| **Expose an API** | [Define custom scopes](../../identity-platform/quickstart-configure-app-expose-web-apis.md) to restrict access to data and functionality protected by the API. An application that requires access to parts of this API can request that a user or admin consent to one or more of these scopes. | Define custom scopes to restrict access to data and functionality protected by the API. An application that requires access to parts of this API can request that admin consent to one or more of these scopes. |
| **App roles**| App roles are [custom roles](../../identity-platform/howto-add-app-roles-in-apps.md) to assign permissions to users or apps. The application defines and publishes the app roles and interprets them as permissions during authorization.| Same as workforce. Learn more about [using role-based access control for applications](how-to-use-app-roles-customers.md) in an external tenant. |
| **Owners** | Application owners can view and edit the application registration. Additionally, any user (who might not be listed) with administrative privileges to manage any application (for example, [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator)) can view and edit the application registration. | Same as workforce. |
| **Roles and administrators** | [Administrative roles](~/identity/role-based-access-control/permissions-reference.md) are used for granting access for privileged actions in Microsoft Entra ID. | Only the [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator) role can be used for apps in external tenants. This role grants the ability to create and manage all aspects of application registrations and enterprise applications.  |
|**Assigning users and groups to an app**| When user assignment is required, only those users you assign to the application (either through direct user assignment or based on group membership) are able to sign in. For more information, see [manage users and groups assignment to an application](~/identity/enterprise-apps/assign-user-or-group-access-portal.md)| Not available |

## OpenID Connect and OAuth2 flows

The following table compares the features available for OAuth 2.0 and OpenID Connect authorization flows in each type of tenant.

|Feature  |Workforce tenant  | External tenant |
|---------|---------|---------|
|[OpenID Connect](../../identity-platform/v2-protocols-oidc.md)| Yes| Yes|
|[Authorization code](../../identity-platform/v2-oauth2-auth-code-flow.md)| Yes| Yes|
|[Authorization code with Code Exchange (PKCE)](../../identity-platform/v2-oauth2-auth-code-flow.md)|Yes| Yes|
|[Client credentials](../../identity-platform/v2-oauth2-client-creds-grant-flow.md)|Yes| [v2.0 applications](../../identity-platform/reference-app-manifest.md) (preview)|
|[Device authorization](../../identity-platform/v2-oauth2-device-code.md)| Yes| Preview |
|[On-Behalf-Of flow](../../identity-platform/v2-oauth2-on-behalf-of-flow.md)| Yes| Yes|
|[Implicit grant](../../identity-platform/v2-oauth2-implicit-grant-flow.md)| Yes| Yes|
|[Resource Owner Password Credentials](../../identity-platform/v2-oauth-ropc.md)| Yes| No, for mobile applications, use [native authentication](concept-native-authentication.md). |

### Authority URL in OpenID Connect and OAuth2 flows

The authority URL is a URL that indicates a directory that MSAL can request tokens from. For apps in external tenants, always use the following format: *&lt;tenant-name&gt;.ciamlogin.com*

The following JSON shows an example of a .NET application appsettings.json file with an authority URL:

```json
{
    "AzureAd": {
        "Authority": "https://<Enter_the_Tenant_Subdomain_Here>.ciamlogin.com/",
        "ClientId": "<Enter_the_Application_Id_Here>"
    }
}
```

## Conditional Access

The following table compares the features available for Conditional Access in each type of tenant.

|Feature  |Workforce tenant  | External tenant |
|---------|---------|---------|
| **Assignments**| [Users, groups](~/identity/conditional-access/concept-conditional-access-users-groups.md), and [workload identities](~/identity/conditional-access/concept-conditional-access-users-groups.md#workload-identities) | Include **all users**, and exclude users and groups. For more information, see [Add multifactor authentication (MFA) to an app](./how-to-multifactor-authentication-customers.md).|
|**Target resources**|<ul><li>[Cloud apps](~/identity/conditional-access/concept-conditional-access-cloud-apps.md)</li><li>[User actions](~/identity/conditional-access/concept-conditional-access-cloud-apps.md#user-actions)</li><li>[Global Secure Access](~/identity/conditional-access/concept-conditional-access-cloud-apps.md#traffic-forwarding-profiles)</li><li>[Authentication context](~/identity/conditional-access/concept-conditional-access-cloud-apps.md#authentication-context)</li></ul>|<ul><li>[All resources, selected apps](./how-to-multifactor-authentication-customers.md), or [filter applications](~/identity/conditional-access/concept-filter-for-applications.md).</li><li>[Authentication context](~/identity/conditional-access/concept-conditional-access-cloud-apps.md#authentication-context)</li></ul>|
| **Conditions**|<ul><li>[Sign-in risk](~/identity/conditional-access/concept-conditional-access-conditions.md#sign-in-risk)</li><li>[User risk](~/identity/conditional-access/concept-conditional-access-conditions.md#user-risk)</li><li>[Device platforms](~/identity/conditional-access/concept-conditional-access-conditions.md#device-platforms)</li><li>[Locations](~/identity/conditional-access/concept-conditional-access-conditions.md#locations)</li><li>[Client apps](~/identity/conditional-access/concept-conditional-access-conditions.md#client-apps)</li><li>[Filter for devices](~/identity/conditional-access/concept-conditional-access-conditions.md#filter-for-devices)</li></ul>|<ul><li>[Sign-in risk](~/identity/conditional-access/concept-conditional-access-conditions.md#sign-in-risk)</li><li>[User risk](~/identity/conditional-access/concept-conditional-access-conditions.md#user-risk)</li><li>[Device platforms](~/identity/conditional-access/concept-conditional-access-conditions.md#device-platforms)</li><li>[Locations](~/identity/conditional-access/concept-conditional-access-conditions.md#locations)</li></ul>|
|**Grant**|[Grant or block access to resources](~/identity/conditional-access/concept-conditional-access-grant.md)|<ul><li>[Block access](~/identity/conditional-access/concept-conditional-access-grant.md#block-access)</li><li>[Require multifactor authentication](./how-to-multifactor-authentication-customers.md)</li><li>[Require password reset](./how-to-enable-password-reset-customers.md)</li></ul>|
|**Session**|[Session controls](~/identity/conditional-access/concept-conditional-access-session.md)|Not available|

## Account management

The following table compares the features available for user management in each type of tenant. As noted in the table, certain account types are created through invitation or self-service sign-up. A user admin in the tenant can also create accounts via the admin center.

|Feature  |Workforce tenant  | External tenant |
|---------|---------|---------|
|**Types of accounts** | <ul><li>Internal members, for example employees and admins.</li><li>External users who are [invited](../what-is-b2b.md) or use self-service sign-up. | <ul><li>Internal users in your tenant, for example admins.</li><li>External consumers and business customers who use self-service sign-up or who are created by admins.</li><li>External users who are invited (preview).</ul>|
| **Manage user profile info** | Programmatically and by [using the Microsoft Entra admin center](~/fundamentals/how-to-manage-user-profile-info.yml). |Same as workforce.|
| **Reset a user's password** | Administrators can [reset a user's password](~/fundamentals/users-reset-password-azure-portal.yml) if the password is forgotten, if the user gets locked out of a device, or if the user never received a password. |Same as workforce.|
|**Restore or remove a recently deleted user**|After you delete a user, the account remains in a suspended state for 30 days. During that 30-day window, the user account can be restored, along with all its properties.|Same as workforce.|
|**Disable accounts**| Prevent the new user from being able to sign in. |Same as workforce.|

## Password protection

The following table compares the features available for password protection in each type of tenant.

|Feature  |Workforce tenant  | External tenant |
|---------|---------|---------|
|**Smart lockout**| [Smart lockout](~/identity/authentication/howto-password-smart-lockout.md) helps lock out bad actors that try to guess your users' passwords or use brute-force methods to get in|Same as workforce. |
| **Custom banned passwords**| The Microsoft Entra custom banned password list lets you add specific strings to evaluate and block. | Not available. |

## Token customization

The following table compares the features available for token customization in each type of tenant.

|Feature  |Workforce tenant  | External tenant |
|---------|---------|---------|
| **Claims mapping** | [Customize claims](~/identity-platform/jwt-claims-customization.md) issued in the JSON web token (JWT) for enterprise applications. | Same as workforce. Optional claims must be configured through [Attributes & Claims](how-to-add-attributes-to-token.md).|
| **Claims transformation** | [Apply a transformation to a user attribute](~/identity-platform/jwt-claims-customization.md) issued in the JSON web token (JWT) for enterprise applications. | Same as workforce.|
|**Custom claims provider**| [Custom authentication extension](~/identity-platform/custom-extension-overview.md) that calls an external REST API, to fetch claims from external systems. | Same as workforce. [Learn more](../../identity-platform/custom-claims-provider-overview.md)|
|**Security groups**| [Configure groups optional claims](../../identity-platform/optional-claims.md#configure-groups-optional-claims). |[Configure groups optional claims](../../identity-platform/optional-claims.md#configure-groups-optional-claims) are limited to the group object ID.|
| **Token lifetimes**| You can [specify the lifetime](../../identity-platform/configurable-token-lifetimes.md) of security tokens issued by the Microsoft Entra ID.| Same as workforce.|

## Microsoft Graph APIs

All features that are supported in external tenants are also supported for automation through Microsoft Graph APIs. Some features that are in preview in external tenants might be generally available through Microsoft Graph. For more information, see [Manage Microsoft Entra identity and network access by using Microsoft Graph](/graph/api/resources/identity-network-access-overview).


## Next steps

- [Planning for CIAM](concept-planning-your-solution.md)
