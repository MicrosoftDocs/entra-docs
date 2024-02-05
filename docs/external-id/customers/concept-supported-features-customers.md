---
title: Supported features in customer tenants
description: Learn about supported features in customer tenants.
 
author: msmimart
manager: celestedg
ms.service: active-directory
 
ms.subservice: ciam
ms.topic: conceptual
ms.date: 02/05/2024
ms.author: mimart
ms.custom: it-pro

#Customer intent: As a dev, devops, or it admin, I want to learn about features supported in a CIAM tenant. 
---
# Supported features in Microsoft Entra ID for customers (preview)

Microsoft Entra ID for customers is designed for businesses that want to make applications available to their customers, using the Microsoft Entra platform for identity and access. With the introduction of this feature, Microsoft Entra ID now offers two different types of tenants that you can create and manage:

- A **workforce tenant** contains your employees and the apps and resources that are internal to your organization. If you've worked with Microsoft Entra ID, this is the type of tenant you're already familiar with. You might already have an existing workforce tenant for your organization.

- A **customer tenant** represents your customer-facing app, resources, and directory of customer accounts. A customer tenant is distinct and separate from your workforce tenant.

[!INCLUDE [preview-alert](../customers/includes/preview-alert/preview-alert-ciam.md)]

## Compare workforce and customer tenant capabilities

Although workforce tenants and customer tenants are built on the same underlying Microsoft Entra platform, there are some feature differences. The following table compares the features available in each type of tenant.

> [!NOTE]
> During preview, features or capabilities that require a premium license are unavailable in customer tenants.

|Feature  |Workforce tenant  | Customer tenant |
|---------|---------|---------|
| **External Identities** | Invite partners and other external users to your workforce tenant for collaboration. External users become guests in your workforce directory. | Enable self-service sign-up for customers and authorize access to apps. Users are added to your directory as customer accounts.  |
| **Identity providers** | - Microsoft Entra accounts </br>- Microsoft accounts </br>- Google federation</br>- Facebook federation</br>- SAML/WS-Fed federation | - Google federation</br>- Facebook federation|
|   **Authentication methods**    | - Username and password</br>- Microsoft Authenticator</br>- FIDO2</br>- SMS</br>- Temporary Access Pass</br>- Third-party software OATH tokens</br>- Voice call</br>- Email one-time passcode</br>- Certificate-based authentication    |   </br>- Username and password</br>- Email one-time passcode    | 
| **Groups** | [Groups](~/fundamentals/how-to-manage-groups.md) can be used to manage administrative and user accounts.| Groups can be used to manage administrative accounts. Support for Microsoft Entra groups and [application roles](how-to-use-app-roles-customers.md) is being phased into customer tenants. For the latest updates, see [Groups and application roles support](reference-group-app-roles-support.md). |
| **Roles and administrators**| [Roles and administrators](~/fundamentals/how-subscriptions-associated-directory.md) are fully supported for administrative and user accounts. | Roles aren't supported with customer accounts. Customer accounts don't have access to tenant resources.|
| **Custom domain names** |  You can use [custom domains](~/fundamentals/add-custom-domain.md) for administrative accounts only. | Not currently supported. However, the URLs visible to customers in sign-up and sign-in pages are neutral, unbranded URLs. [Learn more](concept-branding-customers.md)|
|   **Identity protection**    |   Provides ongoing risk detection for your Microsoft Entra tenant. It allows organizations to discover, investigate, and remediate identity-based risks.    |   A subset of the Microsoft Entra ID Protection risk detections is available. [Learn more](how-to-identity-protection-customers.md).    |
|   **Custom authentication extension**    |   Add claims from external systems.    |   Add claims from external systems.    |  
|   **Token customization**    |   Add user attributes, custom authentication extension (preview), claims transformation and security groups membership to token claims.     |   Add user attributes, custom authentication extension and security groups membership to token claims. [Learn more](how-to-add-attributes-to-token.md).    |
|   **Self-service password reset**    |   Allow users to reset their password using up to two authentication methods (see the next row for available methods).    |   Allow users to reset their password using email with one time passcode. [Learn more](how-to-enable-password-reset-customers.md).     |  
|   **Company branding**    |   Microsoft Entra tenant supports Microsoft look and feel as a default state for authentication experience. Administrators can customize the default Microsoft sign-in experience.    |   Microsoft provides a neutral branding as the default for the customer tenant, which can be customized to meet the specific needs of your company. The default branding for the customer tenant is neutral and doesn't include any existing Microsoft branding. [Learn more](concept-branding-customers.md).    |  
|   **Language customization**    | Customize the sign-in experience based on browser language when users authenticate into your corporate intranet or web-based applications.     |   Use languages to modify the strings displayed to your customers as part of the sign-in and sign-up process. [Learn more](concept-branding-customers.md).   |
|   **Custom attributes**    |    Use directory extension attributes to store more data in the Microsoft Entra directory for user objects, groups, tenant details, and service principals.    |   Use directory extension attributes to store more data in the customer directory for user objects. Create custom user attributes and add them to your sign-up user flow. [Learn more](how-to-define-custom-attributes.md).    |

## Application registration

 The following table compares the features available for [Application registration](./how-to-register-ciam-app.md) in each type of tenant.

|Feature  |Workforce tenant  | Customer tenant |
|---------|---------|---------|
|   **Protocol**     |   SAML relying parties, OpenID Connect, and OAuth2    |   OpenID Connect and OAuth2    |
| **Supported account types**| The following [account types](../../identity-platform/quickstart-register-app.md#register-an-application): <ul><li>Accounts in this organizational directory only (Single tenant)</li><li>Accounts in any organizational directory (Any Microsoft Entra ID tenant - Multitenant)</li><li>Accounts in any organizational directory (Any Microsoft Entra ID tenant - Multitenant) and personal Microsoft accounts (e.g. Skype, Xbox)</li><li>Personal Microsoft accounts only</li></ul> | For customer-facing applications, always use *Accounts in this organizational directory only (Single tenant)*. |
| **Platform** | The following [platforms](../../identity-platform/quickstart-register-app.md#configure-platform-settings): <ul><li>Public client/native (mobile & desktop)</li><li>Web</li><li>Single page application (SPA)</li><ul>| Same as workforce. |
| **Authentication** > **Redirect URIs**| The URIs Microsoft Entra ID accepts as destinations when returning authentication responses (tokens) after successfully authenticating or signing out users. | Same as workforce.|
| **Authentication** > **Front-channel logout URL**| This URL is where Microsoft Entra ID sends a request to have the application clear the user's session data. The Front-channel logout URL is required for single sign-out to work correctly.| Same as workforce.|
| **Authentication** > **Implicit grant and hybrid flows**| Request a token directly from the authorization endpoint. | Same as workforce.|
| **Certificates & secrets** | <ul><li>[Certificate](../../identity-platform/quickstart-register-app.md#add-a-certificate)</li><li>[Client secrets](../../identity-platform/quickstart-register-app.md#add-a-client-secret)</li><li>[Federated credentials](../../identity-platform/quickstart-register-app.md#add-a-federated-credential)</li></ul>| Same as workforce.|
|**Token configuration**| <ul><li>[Optional claims](../../identity-platform/optional-claims.md)</li><li>[Groups optional claims](../../identity-platform/optional-claims.md#configure-groups-optional-claims)</li></ul>| <ul><li>Optional claims must be configured through [Attributes & Claims](./how-to-add-attributes-to-token.md) or a [custom claims provider](../../identity-platform/custom-extension-get-started.md)</li><li>[Groups optional claims](../../identity-platform/optional-claims.md#configure-groups-optional-claims) are limited to the group object ID.</li></li></ul>|
| **API permissions** | Add, remove and replace permissions to an application. After permissions are added to your application, users or admins need to grant consent to the new permissions. Learn more about [updating an app's requested permissions in Microsoft Entra ID](../../identity-platform/howto-update-permissions.md).  | For customer-facing applications, the following are the allowed permissions: Microsoft Graph `offline_access`, `openid` and `User.Read` and your **My APIs** delegated permissions. Only an admin can consent on behalf of the organization.  |
| **Expose an API** | [Define custom scopes](../../identity-platform/quickstart-configure-app-expose-web-apis.md) to restrict access to data and functionality protected by the API. An application that requires access to parts of this API can request that a user or admin consent to one or more of these scopes. | Define custom scopes to restrict access to data and functionality protected by the API. An application that requires access to parts of this API can request that admin consent to one or more of these scopes. |
| **App roles**| App roles are [custom roles](../../identity-platform/howto-add-app-roles-in-apps.md) to assign permissions to users or apps. The application defines and publishes the app roles and interprets them as permissions during authorization.| Same as workforce. Learn more about [using role-based access control for applications](how-to-use-app-roles-customers.md) in a customer tenant. |
| **Owners** | Application owners can view and edit the application registration. Additionally, any user (who might not be listed) with administrative privileges to manage any application (for example, Global Administrator, Cloud App Administrator, etc.) can view and edit the application registration. | Same as workforce. |
| **Roles and administrators** | [Administrative roles](../../identity/role-based-access-control/permissions-reference.md) are used for granting access for privileged actions in Microsoft Entra ID. | Only the [Cloud Application Administrator](../../identity/role-based-access-control/permissions-reference.md#cloud-application-administrator) role can be used for customer-facing applications. This role grants the ability to create and manage all aspects of application registrations and enterprise applications.  |
|**Assigning users and groups to an app**| When user assignment is required, only those users you assign to the application (either through direct user assignment or based on group membership) are able to sign in. For more information, see [manage users and groups assignment to an application](../../identity/enterprise-apps/assign-user-or-group-access-portal.md)| Not available |


## OpenID Connect and OAuth2 flows

The following table compares the features available for OAuth 2.0 and OpenID Connect authorization flows in each type of tenant.

|Feature  |Workforce tenant  | Customer tenant |
|---------|---------|---------|
|[OpenID Connect](../../identity-platform/v2-protocols-oidc.md)| Yes| Yes|
|[Authorization code](../../identity-platform/v2-oauth2-auth-code-flow.md)| Yes| Yes|
|[Authorization code with Code Exchange (PKCE)](../../identity-platform/v2-oauth2-auth-code-flow.md)|Yes| Yes|
|[Client credentials](../../identity-platform/v2-oauth2-client-creds-grant-flow.md)|Yes| [v2.0 applications](../../identity-platform/reference-app-manifest.md)|
|[Device authorization](../../identity-platform/v2-oauth2-device-code.md)| Yes| [Yes](./sample-browserless-app-dotnet-sign-in.md)|
|[On-Behalf-Of flow](../../identity-platform/v2-oauth2-on-behalf-of-flow.md)| Yes| Yes|
|[Implicit grant](../../identity-platform/v2-oauth2-implicit-grant-flow.md)| Yes| Yes|
|[Resource Owner Password Credentials](../../identity-platform/v2-oauth-ropc.md)| Yes| No|

### Authority URL in OpenID Connect and OAuth2 flows

The authority URL is a URL that indicates a directory that MSAL can request tokens from. For customer-facing applications, always use the following format: *&lt;tenant-name&gt;.ciamlogin.com*

The following JSON shows an example of a .NET application app settings with an authority URL:

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

|Feature  |Workforce tenant  | Customer tenant |
|---------|---------|---------|
| **Assignments**| [Users, groups](../../identity/conditional-access/concept-conditional-access-users-groups.md), and [workload identities](../../identity/conditional-access/concept-conditional-access-users-groups.md#workload-identities) | Include **all users**, and exclude users and groups. For more information, [Add multifactor authentication (MFA) to a customer-facing app](./how-to-multifactor-authentication-customers.md).|
|**Target resources**|<ul><li>[Cloud apps](../../identity/conditional-access/concept-conditional-access-cloud-apps.md)</li><li>[User actions](../../identity/conditional-access/concept-conditional-access-cloud-apps.md#user-actions)</li><li>[Global Secure Access](../../identity/conditional-access/concept-conditional-access-cloud-apps.md#traffic-forwarding-profiles)</li><li>[Authentication context](../../identity/conditional-access/concept-conditional-access-cloud-apps.md#authentication-context)</li></ul>|<ul><li>[All cloud apps, or selected apps](./how-to-multifactor-authentication-customers.md)</li><li>[Authentication context](../../identity/conditional-access/concept-conditional-access-cloud-apps.md#authentication-context)</li></ul>|
| **Conditions**|<ul><li>[Sign-in risk](../../identity/conditional-access/concept-conditional-access-conditions.md#sign-in-risk)</li><li>[User risk](../../identity/conditional-access/concept-conditional-access-conditions.md#user-risk)</li><li>[Device platforms](../../identity/conditional-access/concept-conditional-access-conditions.md#device-platforms)</li><li>[Locations](../../identity/conditional-access/concept-conditional-access-conditions.md#locations)</li><li>[Client apps](../../identity/conditional-access/concept-conditional-access-conditions.md#client-apps)</li><li>[Filter for devices](../../identity/conditional-access/concept-conditional-access-conditions.md#filter-for-devices)</li></ul>|<ul><li>[Sign-in risk](../../identity/conditional-access/concept-conditional-access-conditions.md#sign-in-risk)</li><li>[Locations](../../identity/conditional-access/concept-conditional-access-conditions.md#locations)</li></ul>|
|**Grant**|[Grant or block access to resources](../../identity/conditional-access/concept-conditional-access-grant.md)|<ul><li>[Block access](../../identity/conditional-access/concept-conditional-access-grant.md#block-access)</li><li>[Require multifactor authentication](./how-to-multifactor-authentication-customers.md)</li></ul>|
|**Session**|[Session controls](../../identity/conditional-access/concept-conditional-access-session.md)|Not available|


## Next steps

- [Planning for CIAM](concept-planning-your-solution.md)
