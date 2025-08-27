---
title: External Tenant Features
description: Compare features and capabilities of a workforce vs. an external tenant configuration. Determine which tenant type applies to your external identities scenario.
ms.author: cmulligan
author: csmulligan
manager: dougeby
ms.service: entra-external-id
ms.subservice: external
ms.topic: concept-article
ms.date: 07/02/2025

ms.custom: it-pro, seo-july-2024, sfi-ropc-nochange
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
| **Local accounts** | Local accounts are supported for *internal* members of your organization only.    | Local accounts are supported for:<ul><li> Consumers and business customers who use self-service sign-up. </li><li>Admin-created internal accounts (with or without an admin role).</li></ul> **Note:** All users in an external tenant have [default permissions](reference-user-permissions.md) unless they’re [assigned an admin role](how-to-manage-admin-accounts.md).  |
| **Groups** | [Groups](/entra/fundamentals/how-to-manage-groups) can be used to manage administrative and user accounts.| Groups can be used to manage administrative accounts. Support for Microsoft Entra groups and [application roles](how-to-use-app-roles-customers.md) is being phased into customer tenants. For the latest updates, see [Groups and application roles support](reference-group-app-roles-support.md). |
| **Roles and administrators**| [Roles and administrators](~/fundamentals/how-subscriptions-associated-directory.md) are fully supported for administrative and user accounts. | Roles are supported for all users. All users in an external tenant have [default permissions](reference-user-permissions.md) unless they’re assigned an [admin role](how-to-manage-admin-accounts.md).|
| **ID Protection**    |   Provides ongoing risk detection for your Microsoft Entra tenant. It allows organizations to discover, investigate, and remediate identity-based risks.    |   Not available    |
| **ID Governance**    |   Enables organizations to govern identity and access lifecycles, and secure privileged access. [Learn more](~/id-governance/identity-governance-overview.md).    |   Not available    |
| **Self-service password reset**    |   Allow users to reset their password using up to two authentication methods (see the next row for available methods).    |   Allow users to reset their password using email with one time passcode. [Learn more](how-to-enable-password-reset-customers.md).     |  
| **Language customization**    | Customize the sign-in experience based on browser language when users authenticate into your corporate intranet or web-based applications.     |   Use languages to modify the strings displayed to your customers as part of the sign-in and sign-up process. [Learn more](concept-branding-customers.md).   |
| **Custom attributes**    |    Use directory extension attributes to store more data in the Microsoft Entra directory for user objects, groups, tenant details, and service principals.    |   Use directory extension attributes to store more data in the customer directory for user objects. Create custom user attributes and add them to your sign-up user flow. [Learn more](how-to-define-custom-attributes.md).    |
| **Pricing**    | [Monthly active users (MAU) pricing](../external-identities-pricing.md) for B2B collaboration external guests (UserType=Guest).      | [Monthly active users (MAU) pricing](../external-identities-pricing.md) for all users in the external tenant regardless of role or UserType.    |


## Look and feel customization

The following table compares the features available for look and feel customization in workforce and external tenants.

|Feature  |Workforce tenant  | External tenant |
|---------|---------|---------|
| **Company branding** | You can add [company branding](~/fundamentals/how-to-customize-branding.md) that applies to all these experiences to create a consistent sign-in experience for your users. | Same as workforce. [Learn more](how-to-customize-branding-customers.md) |
| **Language customization** | [Customize the sign-in experience by browser language](~/fundamentals/how-to-customize-branding.md). | Same as workforce. [Learn more](how-to-customize-languages-customers.md) |
| **Custom domain names** |  You can use [custom domains](~/fundamentals/add-custom-domain.md) for administrative accounts only. | The [custom URL domain](concept-custom-url-domain.md) feature for external tenants lets you brand app sign-in endpoints with your own domain name.|
| **Native authentication** for mobile apps| Not available |Microsoft Entra’s [native authentication](concept-native-authentication.md) allows you to have full control over the design of your mobile application sign-in experiences.|


## Adding your own business logic

Custom authentication extensions allow you to customize the Microsoft Entra authentication experience by integrating with external systems. A custom authentication extension is essentially an event listener that, when activated, makes an HTTP call to a REST API endpoint where you define your own business logic. The following table compares the [custom authentication extensions](./concept-custom-extensions.md) events available in workforce and external tenants.

|Event  |Workforce tenant  | External tenant |
|---------|---------|---------|
| **TokenIssuanceStart**    |  [Add claims from external systems](~/identity-platform/custom-extension-overview.md).    |   [Add claims from external systems](./concept-custom-extensions.md).    |  
| **OnAttributeCollectionStart**|Not available| Occurs at the beginning of the sign-up's attribute collection step, before the attribute collection page renders. You can add actions such as prefilling values and displaying a blocking error. [Learn more](~/identity-platform/custom-extension-attribute-collection.md?toc=%2Fentra%2Fexternal-id%2Ftoc.json&bc=%2Fentra%2Fexternal-id%2Fbreadcrumb%2Ftoc.json&tabs=start-continue%2Csubmit-continue) |
| **OnAttributeCollectionSubmit**|Not available| Occurs during the sign-up flow, after the user enters and submits attributes. You can add actions such as validating or modifying the user's entries. [Learn more](~/identity-platform/custom-extension-attribute-collection.md?toc=%2Fentra%2Fexternal-id%2Ftoc.json&bc=%2Fentra%2Fexternal-id%2Fbreadcrumb%2Ftoc.json&tabs=start-continue%2Csubmit-continue)|
| **OnOtpSend**|Not available| Configure a custom email provider for one time passcode send events. [Learn more](~/identity-platform/custom-extension-email-otp-get-started.md?toc=%2Fentra%2Fexternal-id%2Ftoc.json&bc=%2Fentra%2Fexternal-id%2Fbreadcrumb%2Ftoc.json&tabs=azure-communication-services%2Cazure-portal)|

## Identity providers and authentication methods

The following table compares the [identity providers](../identity-providers.md) and methods available for primary authentication and multifactor authentication (MFA) in workforce and external tenants.

|Feature  |Workforce tenant  | External tenant |
|---------|---------|---------|
| **Identity providers for external users (primary authentication)** | **For self-service sign-up guests**</br>- Microsoft Entra accounts</br>- Microsoft accounts</br>- Email one-time passcode</br>- Google federation</br>- Facebook federation<br></br>**For invited guests**</br>- Microsoft Entra accounts</br>- Microsoft accounts</br>- Email one-time passcode</br>- Google federation</br>- SAML/WS-Fed federation | **For self-service sign-up users (consumers, business customers)**</br>- [Authentication methods available in Microsoft Entra external ID](#authentication-methods-available-in-microsoft-entra-external-id)<br></br>**For invited guests (preview)**</br>Guests invited with a directory role (for example, admins):</br>- Microsoft Entra accounts </br>- Microsoft accounts </br>- [Email one-time passcode](./concept-authentication-methods-customers.md#email-with-one-time-passcode-sign-in)<br>- [SAML/WS-Fed federation](../direct-federation.md) |
| **Authentication methods for MFA**  | **For internal users (employees and admins)** </br>- [Authentication and verification methods](~/identity/authentication/concept-authentication-methods.md) </br>**For guests (invited or self-service sign-up)** </br>- [Authentication methods for guest MFA](../authentication-conditional-access.md#table-1-authentication-strength-mfa-methods-for-external-users)  |  **For self-service sign-up users (consumers, business customers)**</br>- [Authentication methods available in Microsoft Entra external ID](#authentication-methods-available-in-microsoft-entra-external-id) </br></br>**For invited users (preview)**</br>- [Email one-time passcode](concept-multifactor-authentication-customers.md#email-one-time-passcode)</br>- [SMS-based authentication](concept-multifactor-authentication-customers.md#sms-based-authentication)    |

### Authentication methods available in Microsoft Entra external ID

Some authentication methods can be used as the primary factor when users sign in to an application, such username and password. Other authentication methods are only available as a secondary factor. The following table outlines when an authentication method can be used during sign-in, self-service sign-up, self-service password reset, and  multifactor authentication (MFA) in Microsoft Entra external ID.

|Method  |Sign-in  |Sign-up  |Password reset  |MFA  |
|---------|---------|---------|---------|---------|
| [Email with password](./concept-authentication-methods-customers.md#email-and-password-sign-in) | :::image type="icon" source="../media/common/applies-to-yes.png" border="false":::  | :::image type="icon" source="../media/common/applies-to-yes.png" border="false":::  |  |  |
| [Email one-time passcode](./concept-authentication-methods-customers.md#email-with-one-time-passcode-sign-in)| :::image type="icon" source="../media/common/applies-to-yes.png" border="false":::  | :::image type="icon" source="../media/common/applies-to-yes.png" border="false":::  |:::image type="icon" source="../media/common/applies-to-yes.png" border="false":::   | :::image type="icon" source="../media/common/applies-to-yes.png" border="false":::  |
| [SMS-based authentication](./concept-multifactor-authentication-customers.md#sms-based-authentication)|  |  |  | :::image type="icon" source="../media/common/applies-to-yes.png" border="false":::  |
| [Apple federation](./how-to-apple-federation-customers.md)| :::image type="icon" source="../media/common/applies-to-yes.png" border="false":::  |:::image type="icon" source="../media/common/applies-to-yes.png" border="false":::   |  |  |
| [Facebook federation](./how-to-facebook-federation-customers.md)| :::image type="icon" source="../media/common/applies-to-yes.png" border="false":::  | :::image type="icon" source="../media/common/applies-to-yes.png" border="false":::  |  |  |
| [Google federation](./how-to-google-federation-customers.md) | :::image type="icon" source="../media/common/applies-to-yes.png" border="false":::  | :::image type="icon" source="../media/common/applies-to-yes.png" border="false":::  |  |  |
| Microsoft personal account ([OpenID Connect](./how-to-custom-oidc-federation-customers.md)) | :::image type="icon" source="../media/common/applies-to-yes.png" border="false":::  | :::image type="icon" source="../media/common/applies-to-yes.png" border="false":::  |  |  |
| [OpenID Connect federation](./how-to-custom-oidc-federation-customers.md)| :::image type="icon" source="../media/common/applies-to-yes.png" border="false":::  | :::image type="icon" source="../media/common/applies-to-yes.png" border="false":::  |  |  |
| [SAML/WS-Fed federation](../direct-federation.md)| :::image type="icon" source="../media/common/applies-to-yes.png" border="false"::: | :::image type="icon" source="../media/common/applies-to-yes.png" border="false"::: ||

## Application registration

The following table compares the features available for [Application registration](../../identity-platform/quickstart-register-app.md) in each type of tenant.

|Feature  |Workforce tenant  | External tenant |
|---------|---------|---------|
|   **Protocol** |  SAML relying parties, OpenID Connect, and OAuth2  |  [SAML relying parties](how-to-register-saml-app.md), [OpenID Connect](how-to-register-ciam-app.md), and OAuth2 |
| **Supported account types**| The following [account types](~/identity-platform/quickstart-register-app.md#register-an-application): <ul><li>Accounts in this organizational directory only (Single tenant)</li><li>Accounts in any organizational directory (Any Microsoft Entra tenant - Multitenant)</li><li>Accounts in any organizational directory (Any Microsoft Entra tenant - Multitenant) and personal Microsoft accounts (such as Skype, Xbox)</li><li>Personal Microsoft accounts only</li></ul> | Always use *Accounts in this organizational directory only (Single tenant)*. |
| **Platform** | The following [platforms](../../identity-platform/how-to-add-redirect-uri.md): <ul><li>Public client/native (mobile & desktop)</li><li>Web</li><li>Single page application (SPA)</li></ul>| The following [platforms](../../identity-platform/how-to-add-redirect-uri.md): <ul><li>Public client (mobile & desktop)</li><li>Web</li><li>Single page application (SPA)</li><li>Native authentication for [mobile](concept-native-authentication.md) and [single page (SPA)](how-to-native-authentication-cors-solution-production-environment.md) applications. </li></ul>|
| **Authentication** > **Redirect URIs**| The URIs Microsoft Entra ID accepts as destinations when returning authentication responses (tokens) after successfully authenticating or signing out users. | Same as workforce.|
| **Authentication** > **Front-channel logout URL**| This URL is where Microsoft Entra ID sends a request to have the application clear the user's session data. The Front-channel logout URL is required for single sign-out to work correctly.| Same as workforce.|
| **Authentication** > **Implicit grant and hybrid flows**| Request a token directly from the authorization endpoint. | Same as workforce.|
| **Certificates & secrets** | Multiple credentials: <ul><li>[Certificates](../../identity-platform/how-to-add-credentials.md?tabs=certificate)</li><li>[Client secrets](../../identity-platform/how-to-add-credentials.md?tabs=client-secret)</li><li>[Federated credentials](../../identity-platform/how-to-add-credentials.md?tabs=federated-credential)</li></ul> | Same as workforce.|
| **Certificates & secrets** > **Rotation**| Update client credentials to ensure they remain valid and secure, while users can continue to sign-in. [Certificates](../../identity-platform/how-to-add-credentials.md?tabs=certificate), [secrets](../../identity-platform/how-to-add-credentials.md?tabs=client-secret), and [federated credentials](../../identity-platform/how-to-add-credentials.md?tabs=federated-credential) can be rotated by adding a new one and then removing the old one.|Same as workforce.|
|**Certificates & secrets** > **Policy** | Configure the [application management policies](~/identity/enterprise-apps/tutorial-enforce-secret-standards.md) to enforce secret and certificate restrictions. | Not available |
| **API permissions** | Add, remove, and replace permissions to an application. After permissions are added to your application, users or admins need to grant consent to the new permissions. Learn more about [updating an app's requested permissions in Microsoft Entra ID](../../identity-platform/howto-update-permissions.md).  | The following are the allowed permissions: Microsoft Graph `offline_access`, `openid`, and `User.Read` and your **My APIs** delegated permissions. Only an admin can consent on behalf of the organization.  |
| **Expose an API** | [Define custom scopes](../../identity-platform/quickstart-configure-app-expose-web-apis.md) to restrict access to data and functionality protected by the API. An application that requires access to parts of this API can request that a user or admin consent to one or more of these scopes. | Define custom scopes to restrict access to data and functionality protected by the API. An application that requires access to parts of this API can request that admin consent to one or more of these scopes. |
| **Owners** | Application owners can view and edit the application registration. Additionally, any user (who might not be listed) with administrative privileges to manage any application (for example, [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator)) can view and edit the application registration. | Same as workforce. |
| **Roles and administrators** | [Administrative roles](~/identity/role-based-access-control/permissions-reference.md) are used for granting access for privileged actions in Microsoft Entra ID. | Only the [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator) role can be used for apps in external tenants. This role grants the ability to create and manage all aspects of application registrations and enterprise applications.  |

### Access control for applications

The following table compares the features available for application authorization in each type of tenant.

|Feature  |Workforce tenant  | External tenant |
|---------|---------|---------|
| **Role-based access control (RBAC)**| You can define [application roles](../../identity-platform/custom-rbac-for-developers.md#app-roles) for your application and assign those roles to users and groups. Microsoft Entra ID includes the user roles in the security token. Your application can then make authorization decisions based on the values in the security token.| Same as workforce. Learn more about [using role-based access control for applications](how-to-use-app-roles-customers.md) in an external tenant. For available features, see [groups and application roles support](./reference-group-app-roles-support.md).  |
|**Security groups**| You can use [security groups](../../identity-platform/custom-rbac-for-developers.md#groups) to implement RBAC in your applications, where the memberships of the user in specific groups are interpreted as their role memberships. Microsoft Entra ID includes user group membership in the security token. Your application can then make authorization decisions based on the values in the security token. |Same as workforce. The [groups optional claims](../../identity-platform/optional-claims.md#configure-groups-optional-claims) are limited to the group object ID.|
| **Attribute-based access control (ABAC)** | You can configure the app to include user attributes in the access token. Your application can then make authorization decisions based on the values in the security token. For more information, see [token customization](#token-customization). | Same as workforce.|
| **Require user assignment**| When user assignment is required, only those users you assign to the application (either through direct user assignment or based on group membership) are able to sign in. For more information, see [manage users and groups assignment to an application](../../identity-platform/howto-restrict-your-app-to-a-set-of-users.md)| Same as workforce. For details, see [groups and application roles support](./reference-group-app-roles-support.md). |

## Enterprise applications

The following table compares the unique features available for [enterprise application](/entra/identity/enterprise-apps/) registration in workforce and external tenants. 

Feature  |Workforce tenant  | External tenant |
|---------|---------|---------|
| **Application gallery**         | The [application gallery](/entra/identity/enterprise-apps/overview-application-gallery) contains thousands of applications that are preintegrated into Microsoft Entra ID.   | Choose from a range of pre-integrated apps. To find a third-party app, use the search bar. The application gallery catalog isn’t available yet.    |
| **Register a custom enterprise application**         | [Add an enterprise application.](/entra/identity/enterprise-apps/add-application-portal)  |  [Register a SAML app in your external tenant.](/entra/external-id/customers/how-to-register-saml-app)    |
| **Self-service application assignment**         | Let users [self-discover apps](/entra/identity/enterprise-apps/manage-self-service-access).  | Self-service application assignment in the [My Apps portal](/entra/identity/enterprise-apps/myapps-overview) is not available.   |
| **Application proxy**         | [Microsoft Entra application proxy](/entra/identity/app-proxy/overview-what-is-app-proxy) provides secure remote access to on-premises web applications.  | Not available.    |

### Consent and permission features for enterprise applications 

The following table shows which consent and permission features are available for enterprise applications in each type of tenant.

|Feature  |Workforce tenant  | External tenant |
|---------|---------|---------|
| **Admin consent for enterprise applications**            | You can [grant tenant-wide admin permissions](/entra/identity/enterprise-apps/grant-admin-consent), and  you can also [review and revoke](/entra/identity/enterprise-apps/manage-application-permissions?pivots=portal) them.  |  Same as workforce.        |
| **User consent for enterprise applications**             | You can configure how [users consent to applications](/entra/identity/enterprise-apps/configure-user-consent) and you can [update these permissions](/entra/identity-platform/howto-update-permissions).           | Limited to permissions that don’t require [admin consent](/entra/identity/enterprise-apps/grant-admin-consent).  |
| **Review or revoke admin consent**               | [Review and revoke](/entra/identity/enterprise-apps/manage-application-permissions) permissions.  | [Use the Microsoft Entra admin center](/entra/identity/enterprise-apps/manage-application-permissions?pivots=portal) to revoke admin consent. |
| **Review or revoke user consent**                | [Review and revoke](/entra/identity/enterprise-apps/manage-application-permissions) permissions.                           | Use [Microsoft Graph API](/entra/identity/enterprise-apps/manage-application-permissions?pivots=ms-graph) or [PowerShell](/entra/identity/enterprise-apps/manage-application-permissions?pivots=entra-powershell) to revoke user consent.   |  
| **Assign users or groups to apps**               |  You can [manage access to apps](/entra/identity/enterprise-apps/what-is-access-management) either in an individual or group-base assignment.  [Nested group](/entra/fundamentals/how-to-manage-groups) memberships aren't supported.     | Same as workforce.  |
| **Role-based access control (RBAC) for app roles** | You can define and assign roles for fine-grained [access control](/entra/external-id/customers/how-to-use-app-roles-customers).               | Same as workforce.  |

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
| **Conditions**|<ul><li>[Sign-in risk](~/identity/conditional-access/concept-conditional-access-conditions.md#sign-in-risk)</li><li>[User risk](~/identity/conditional-access/concept-conditional-access-conditions.md#user-risk)</li><li>[Device platforms](~/identity/conditional-access/concept-conditional-access-conditions.md#device-platforms)</li><li>[Locations](~/identity/conditional-access/concept-conditional-access-conditions.md#locations)</li><li>[Client apps](~/identity/conditional-access/concept-conditional-access-conditions.md#client-apps)</li><li>[Filter for devices](~/identity/conditional-access/concept-conditional-access-conditions.md#filter-for-devices)</li></ul>|<ul><li>[Device platforms](~/identity/conditional-access/concept-conditional-access-conditions.md#device-platforms)</li><li>[Locations](~/identity/conditional-access/concept-conditional-access-conditions.md#locations)</li></ul>|
|**Grant**|[Grant or block access to resources](~/identity/conditional-access/concept-conditional-access-grant.md)|<ul><li>[Block access](~/identity/conditional-access/concept-conditional-access-grant.md#block-access)</li><li>[Require multifactor authentication](./how-to-multifactor-authentication-customers.md)</li><li>[Require password reset](./how-to-enable-password-reset-customers.md)</li></ul>|
|**Session**|[Session controls](~/identity/conditional-access/concept-conditional-access-session.md)|Not available|

## Terms of use policies

The following table compares the features available for terms of use policies in each type of tenant.

|Feature  |Workforce tenant  | External tenant |
|---------|---------|---------|
| Conditional Access policies | [Microsoft Entra terms of use](~/identity/conditional-access/terms-of-use.md) |Not available|
| Self-service sign-up| Not available | Add a [required attribute](how-to-define-custom-attributes.md#configure-a-single-select-checkbox-checkboxsingleselect) linked to your terms of use policies on the sign-up page. The hyperlink can be customized to support various languages. |
| Sign-in page | Links you can add to the lower-right corner for privacy information using [Company branding](~/fundamentals/how-to-customize-branding.md). | [Same as workforce](how-to-customize-branding-customers.md#to-customize-the-logo-privacy-link-and-terms-of-use).|

## Account management

The following table compares the features available for user management in each type of tenant. As noted in the table, certain account types are created through invitation or self-service sign-up. A user admin in the tenant can also create accounts via the admin center.

|Feature  |Workforce tenant  | External tenant |
|---------|---------|---------|
|**Types of accounts** | <ul><li>Internal members, for example employees and admins.</li><li>External users who are [invited](../what-is-b2b.md) or use self-service sign-up.</li></ul> | <ul><li> External users created through self-service sign-up or [by an admin](how-to-manage-customer-accounts.md).</li><li> Internal users, with or without an admin role. </li><li> 	Invited users (preview), with or without an admin role. </li></ul> **Note:** All users in an external tenant have [default permissions](reference-user-permissions.md) unless they’re assigned an [admin role](how-to-manage-admin-accounts.md). |
| **Manage user profile info** | <ul><li>Programmatically and by [using the Microsoft Entra admin center](~/fundamentals/how-to-manage-user-profile-info.md).</li><li>Manage guest users across tenants with [Cross-tenant synchronization](/entra/identity/multi-tenant-organizations/cross-tenant-synchronization-overview).</li></ul> |Same as workforce, except cross-tenant synchronization is not available.|
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
| **Session and token revocation** | Administrator can [invalidate all the refresh tokens and session](/graph/api/user-revokesigninsessions) for a user. | Same as workforce.|

## Single sign-on

[Single sign-on (SSO)](../../identity-platform/msal-js-sso.md) provides a more seamless experience by reducing the number of times a user is asked for credentials. Users enter their credentials once, and the established session can be reused by other applications on the same device and web browser without further prompting. The following table compares the features available for SSO in each type of tenant.

|Feature  |Workforce tenant  | External tenant |
|---------|---------|---------|
| **Types of application registration** | <ul><li>OpenID Connect</li> <li>OAuth 2.0</li> <li>SAML (enterprise application)</li><li>Enterprise applications offer [more options](../../identity/enterprise-apps/plan-sso-deployment.md), like password-based, linked, and header-based.</li></ul> |<ul><li>OpenID Connect</li> <li>OAuth 2.0</li> <li>SAML (enterprise application)</li></ul>|
| **Domain name** | When a user authenticates, a session cookie is set on the Microsoft Entra domain `login.microsoftonline.com` in the web browser.| When a user authenticates, a session cookie is set on the Microsoft Entra external ID domain `<tenant-name>.ciamlogin.com` or a [custom URL domain](concept-custom-url-domain.md) in the web browser. To ensure SSO functions correctly, use a single URL domain.|
| **Keep me signed in** | You can enable or disabled [stay signed in](~/fundamentals/how-to-manage-stay-signed-in-prompt.yml) option. | Same as workforce. |
| **User provisioning** | Use [automatic user provisioning](/entra/architecture/sync-scim) with the System for Cross-domain Identity Management (SCIM) to sync user accounts between Microsoft Entra External ID and supported apps. This keeps user data up to date automatically. User provisioning supports differential queries. These queries sync only the changes since the last update. This improves performance and reduces system load. | Same as workforce. |
| **Session invalidation** | Scenarios where SSO may be invalidated, which require reauthentication: <ul><li>Session expiry</li><li>Browser issues, such as clearing browser cookies or cache.</li><li>Conditional Access policy, such as multifactor authentication requirement.</li><li>[Session revocation](/graph/api/user-revokesigninsessions)</li><li>Security issues, such as suspicious activity.</li><li>The application specifies in the authorization request to prompt the user for their credentials using `login=prompt` query string parameter in OpenID Connect and `ForceAuthn` attribute in SAML request. </li></ul> |Same as workforce.|
|**Conditional Access**| Check the [Conditional Access](#conditional-access) section. | Check the [Conditional Access](#conditional-access) section.| 
|**Microsoft Entra’s native authentication**| Not available| [Native authentication](concept-native-authentication.md) doesn't support SSO.|
| **Sign-out** | When a [SAML](../../identity-platform/single-sign-out-saml-protocol.md) or [OpenID Connect](../../identity-platform/v2-protocols-oidc.md#send-a-sign-out-request) application directs the user to the logout endpoint, Microsoft Entra ID removes and invalidates the user's session from the browser. | Same as workforce.|
| **Single sign-out**| Upon successful sign-out, Microsoft Entra ID sends a logout notification to all other [SAML](../../identity-platform/single-sign-out-saml-protocol.md) and [OpenID Connect](../../identity-platform/v2-protocols-oidc.md#single-sign-out) applications that the user is signed into. | Same as workforce.|

## Activity logs and reports

The table below compares the features available for activity logs and reports across different types of tenants.

|Feature  |Workforce tenant  | External tenant |
|---------|---------|---------|
|[Audit logs](~/identity/monitoring-health/concept-audit-logs.md)|Detailed report of all events logged in Microsoft Entra ID, including modifications to applications, groups, and users.|Same as workforce.|
|[Sign-in logs](~/identity/monitoring-health/concept-sign-ins.md) |The sign-in logs track all sign-in activities within a Microsoft Entra tenant, including access to your applications and resources.|Same as workforce.|
|[Sign-up logs](~/identity/monitoring-health/concept-sign-ups.md) (preview)| Not available|Microsoft Entra External ID logs all self-service sign-up events, including both successful sign-ups and failed attempts. |
| [Provisioning logs](~/identity/monitoring-health/concept-provisioning-logs.md)| The provisioning logs provide detailed records of provisioning events within a tenant, such as user account creations, updates, and deletions.|Not available|
| [Retention policies activity logs](~/identity/monitoring-health/concept-provisioning-logs.md) | Microsoft Entra data retention policies determine how long different types of logs (like audit, sign-in, and provisioning logs) are stored.| Seven days|
|[Export activity logs](~/identity/monitoring-health/howto-configure-diagnostic-settings.md)| Using diagnostic settings in Microsoft Entra ID, you can integrate logs with Azure Monitor, stream logs to an event hub, or integrate with Security Information and Event Management (SIEM) tools.| [Azure Monitor for external tenants (preview)](./how-to-azure-monitor.md)|
|[Application user activity reports](./how-to-user-insights.md)|Not available| Application user activity provides analytics on how users interact with registered applications in your tenant. It tracks metrics like active users, new users, sign-ins, and multifactor authentication (MFA) success rates. |

## Microsoft Graph APIs

All features that are supported in external tenants are also supported for automation through Microsoft Graph APIs. Some features that are in preview in external tenants might be generally available through Microsoft Graph. For more information, see [Manage Microsoft Entra identity and network access by using Microsoft Graph](/graph/api/resources/identity-network-access-overview).


## Next steps

- [Planning for customer identity and access management (CIAM)](concept-planning-your-solution.md)
