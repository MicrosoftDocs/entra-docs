---
title: External Tenant Features
description: Compare features and capabilities of a workforce versus an external tenant configuration. Determine which tenant type applies to your external identities scenario.
ms.topic: concept-article
ms.date: 03/30/2026

ms.custom: it-pro, seo-july-2024, sfi-ropc-nochange
#Customer intent: As a dev, DevOps, or IT admin, I want to learn about features supported in a CIAM tenant so that I can configure tenants according to my organization's needs.
---

# Supported features in workforce and external tenants

There are two ways to configure a Microsoft Entra tenant, depending on how an organization intends to use the tenant and the resources that you want to manage:

- A *workforce* tenant configuration is for your employees, internal business apps, and other organizational resources. A workforce tenant uses B2B collaboration in Microsoft Entra External ID for collaboration with external business partners and guests.
- An *external* tenant configuration is exclusively for External ID scenarios where you want to publish apps to consumers or business customers.

This article gives a detailed comparison of the features and capabilities in workforce and external tenants. For more information about these tenants, see [Workforce and external tenant configurations in Microsoft Entra External ID](../tenant-configurations.md).

> [!NOTE]
> During the preview, features or capabilities that require a premium license are unavailable in external tenants.

## General feature comparison

The following table compares the general features and capabilities in workforce and external tenants.

| Feature | Workforce tenant | External tenant |
| ------ | ---------------- | --------------- |
| External identities scenario | Allow business partners and other external users to collaborate with your workforce. Guests can securely access your business applications through invitations or self-service sign-up. | Use External ID to help secure your applications. Consumers and business customers can access your consumer apps through self-service sign-up. Invitations are also supported. |
| Local accounts | Local accounts are supported for *internal* members of your organization only. | Local accounts are supported for:<ul><li> Consumers and business customers who use self-service sign-up. </li><li>Admin-created internal accounts (with or without an admin role).</li></ul> All users in an external tenant have [default permissions](reference-user-permissions.md) unless they're [assigned an admin role](how-to-manage-admin-accounts.md). |
| Groups | Use [groups](/entra/fundamentals/how-to-manage-groups) to manage administrative and user accounts. | Use groups to manage administrative accounts. Support for Microsoft Entra groups and [application roles](how-to-use-app-roles-customers.md) is being phased into customer tenants. For the latest updates, see [Groups and application roles support](reference-group-app-roles-support.md). |
| Roles and administrators | [Roles and administrators](~/fundamentals/how-subscriptions-associated-directory.md) are fully supported for administrative and user accounts. | Roles are supported for all users. All users in an external tenant have [default permissions](reference-user-permissions.md) unless they're assigned an [admin role](how-to-manage-admin-accounts.md). |
| Microsoft Entra ID Protection | This product provides ongoing risk detection for your Microsoft Entra tenant. It allows organizations to discover, investigate, and remediate identity-based risks. | Not available. |
| Microsoft Entra ID Governance | This product enables organizations to govern identity and access lifecycles, along with secure privileged access. [Learn more](~/id-governance/identity-governance-overview.md). | Not available. |
| Self-service password reset | Allow users to reset their password by using up to two authentication methods. | Allow users to reset their password by using email with a one-time passcode or SMS. [Learn more](how-to-enable-password-reset-customers.md). |
| Language customization | Customize the sign-in experience based on browser language when users authenticate into your corporate intranet or web-based applications. | Use languages to modify the strings displayed to your customers as part of the sign-in and sign-up process. [Learn more](concept-branding-customers.md). |
| Custom attributes | Use directory extension attributes to store more data in the Microsoft Entra directory for user objects, groups, tenant details, and service principals. | Use directory extension attributes to store more data in the customer directory for user objects. Create custom user attributes and add them to your sign-up user flow. [Learn more](how-to-define-custom-attributes.md). |
| Pricing | Get [monthly active users (MAU) pricing](../external-identities-pricing.md) for external guests through B2B collaboration (`UserType=Guest`). | Get [MAU pricing](../external-identities-pricing.md) for all users in the external tenant regardless of role or `UserType` value. |

## Interface customization

The following table compares the features for interface customization in workforce and external tenants.

| Feature | Workforce tenant | External tenant |
| ------- | ---------------- | --------------- |
| Company branding | You can add [company branding](~/fundamentals/how-to-customize-branding.md) that applies to all these experiences to create a consistent sign-in experience for your users. | Same as workforce. [Learn more](how-to-customize-branding-customers.md). |
| Language customization | [Customize the sign-in experience by browser language](~/fundamentals/how-to-customize-branding.md). | Same as workforce. [Learn more](how-to-customize-languages-customers.md). |
| Custom domain names | You can use [custom domains](~/fundamentals/add-custom-domain.md) for administrative accounts only. | You can use the [custom URL domain](concept-custom-url-domain.md) feature for external tenants to brand app sign-in endpoints with your own domain name. |
| Native authentication for mobile apps | Not available. | Microsoft Entra [native authentication](concept-native-authentication.md) gives you full control over the design of your mobile application's sign-in experiences. |

## Adding your own business logic

You can use [custom authentication extensions](./concept-custom-extensions.md) to customize the Microsoft Entra authentication experience by integrating with external systems. A custom authentication extension is essentially an event listener. When you activate it, it makes an HTTP call to a REST API endpoint where you define your own business logic.

The following table compares the events for custom authentication extensions in workforce and external tenants.

| Event | Workforce tenant | External tenant |
| ----- | ---------------- | --------------- |
| `TokenIssuanceStart` | [Add claims from external systems](~/identity-platform/custom-extension-overview.md). | [Add claims from external systems](./concept-custom-extensions.md). |  
| `OnAttributeCollectionStart` | Not available. | This event occurs at the beginning of the sign-up's attribute collection step, before the attribute collection page renders. You can add actions such as prefilling values and displaying a blocking error. [Learn more](~/identity-platform/custom-extension-attribute-collection.md?toc=%2Fentra%2Fexternal-id%2Ftoc.json&bc=%2Fentra%2Fexternal-id%2Fbreadcrumb%2Ftoc.json&tabs=start-continue%2Csubmit-continue). |
| `OnAttributeCollectionSubmit` | Not available. | This event occurs during the sign-up flow, after the user enters and submits attributes. You can add actions such as validating or modifying the user's entries. [Learn more](~/identity-platform/custom-extension-attribute-collection.md?toc=%2Fentra%2Fexternal-id%2Ftoc.json&bc=%2Fentra%2Fexternal-id%2Fbreadcrumb%2Ftoc.json&tabs=start-continue%2Csubmit-continue). |
| `OnOtpSend` | Not available. | Configure a custom email provider for one-time passcode send events. [Learn more](~/identity-platform/custom-extension-email-otp-get-started.md?toc=%2Fentra%2Fexternal-id%2Ftoc.json&bc=%2Fentra%2Fexternal-id%2Fbreadcrumb%2Ftoc.json&tabs=azure-communication-services%2Cazure-portal). |

## Identity providers and authentication methods

The following table compares the [identity providers](../identity-providers.md) and methods for primary authentication and multifactor authentication (MFA) in workforce and external tenants.

| Feature | Workforce tenant | External tenant |
| ------- | ---------------- | --------------- |
| Identity providers for external users (primary authentication) | For self-service sign-up guests:<ul><li>Microsoft Entra accounts</li><li>Microsoft accounts</li><li>Emailed one-time passcode</li><li>Google federation</li><li>Facebook federation</li></ul></br>For invited guests:<ul><li>Microsoft Entra accounts</li><li>Microsoft accounts</li><li>Emailed one-time passcode</li><li>Google federation</li><li>SAML/WS-Fed federation</li></ul> | For self-service sign-up users (consumers, business customers):<ul><li>[Authentication methods available in External ID](#authentication-methods-available-in-external-id)</li></ul></br>For invited guests (preview) via a directory role (for example, admins):<ul><li>Microsoft Entra accounts</li><li>Microsoft accounts</li><li>[Emailed one-time passcode](./concept-authentication-methods-customers.md#email-with-one-time-passcode-sign-in)</li><li>[SAML/WS-Fed federation](../direct-federation.md)</li></ul></br> You can invite external users for administrative purposes only. You can't use this feature to invite customers to sign in to your apps. This feature isn't compatible with customer identity and access management (CIAM) user flows. |
| Authentication methods for MFA | For internal users (employees and admins):<ul><li>[Authentication and verification methods](~/identity/authentication/overview-authentication.md)</li></ul></br>For guests (invited or self-service sign-up):<ul><li>[Authentication methods for guest MFA](../authentication-conditional-access.md#table-1-authentication-strength-mfa-methods-for-external-users)</li></ul> | For self-service sign-up users (consumers, business customers):<ul><li>[Authentication methods available in External ID](#authentication-methods-available-in-external-id)</li></ul></br>For invited users (preview):<ul><li>[Emailed one-time passcode](concept-multifactor-authentication-customers.md#email-one-time-passcode)</li><li>[SMS-based authentication](concept-multifactor-authentication-customers.md#sms-based-authentication)</li></ul> |

### Authentication methods available in External ID

You can use some authentication methods as the primary factor when users sign in to an application, such username and password. Other authentication methods are available only as a secondary factor. The following table outlines when you can use an authentication method during sign-in, self-service sign-up, self-service password reset, and MFA in External ID.

| Method | Sign-in | Sign-up | Password reset | MFA |
| ------ | ------- | ------- | -------------- | --- |
| [Email with password](./concept-authentication-methods-customers.md#email-and-password-sign-in) | :::image type="icon" source="../media/common/applies-to-yes.png" border="false"::: | :::image type="icon" source="../media/common/applies-to-yes.png" border="false"::: | | |
| [Emailed one-time passcode](./concept-authentication-methods-customers.md#email-with-one-time-passcode-sign-in) | :::image type="icon" source="../media/common/applies-to-yes.png" border="false"::: | :::image type="icon" source="../media/common/applies-to-yes.png" border="false"::: | :::image type="icon" source="../media/common/applies-to-yes.png" border="false"::: | :::image type="icon" source="../media/common/applies-to-yes.png" border="false"::: |
| [SMS-based authentication](./concept-multifactor-authentication-customers.md#sms-based-authentication) | | | :::image type="icon" source="../media/common/applies-to-yes.png" border="false"::: | :::image type="icon" source="../media/common/applies-to-yes.png" border="false"::: |
| [Apple federation](./how-to-apple-federation-customers.md) | :::image type="icon" source="../media/common/applies-to-yes.png" border="false"::: | :::image type="icon" source="../media/common/applies-to-yes.png" border="false"::: | | |
| [Facebook federation](./how-to-facebook-federation-customers.md) | :::image type="icon" source="../media/common/applies-to-yes.png" border="false"::: | :::image type="icon" source="../media/common/applies-to-yes.png" border="false"::: | | |
| [Google federation](./how-to-google-federation-customers.md) | :::image type="icon" source="../media/common/applies-to-yes.png" border="false"::: | :::image type="icon" source="../media/common/applies-to-yes.png" border="false"::: | | |
| Microsoft personal account ([OpenID Connect](./how-to-custom-oidc-federation-customers.md)) | :::image type="icon" source="../media/common/applies-to-yes.png" border="false"::: | :::image type="icon" source="../media/common/applies-to-yes.png" border="false"::: | | |
| [OpenID Connect federation](./how-to-custom-oidc-federation-customers.md) | :::image type="icon" source="../media/common/applies-to-yes.png" border="false"::: | :::image type="icon" source="../media/common/applies-to-yes.png" border="false"::: | | |
| [SAML/WS-Fed federation](../direct-federation.md) | :::image type="icon" source="../media/common/applies-to-yes.png" border="false"::: | :::image type="icon" source="../media/common/applies-to-yes.png" border="false"::: | | |

## Application registration

The following table compares the features for [application registration](../../identity-platform/quickstart-register-app.md) in each type of tenant.

| Feature | Workforce tenant | External tenant |
| ------- | ---------------- | --------------- |
| Protocol | Protocols include SAML relying parties, OpenID Connect, and OAuth2. | Protocols include [SAML relying parties](how-to-register-saml-app.md), [OpenID Connect](how-to-register-ciam-app.md), and OAuth2. |
| Supported account types | The following [account types](~/identity-platform/quickstart-register-app.md#register-an-application) are available: <ul><li>Accounts in this organizational directory only (single tenant)</li><li>Accounts in any organizational directory (any Microsoft Entra tenant in a multitenant configuration)</li><li>Accounts in any organizational directory (any Microsoft Entra tenant in a multitenant configuration) and personal Microsoft accounts (such as Skype and Xbox)</li><li>Personal Microsoft accounts only</li></ul> | Always use accounts in this organizational directory only (single tenant). |
| Platform | The following [platforms](../../identity-platform/how-to-add-redirect-uri.md) are available: <ul><li>Public client/native (mobile and desktop)</li><li>Web</li><li>Single-page application (SPA)</li></ul> | The following [platforms](../../identity-platform/how-to-add-redirect-uri.md) are available: <ul><li>Public client (mobile and desktop)</li><li>Web</li><li>SPA</li><li>Native authentication for [mobile](concept-native-authentication.md) and [single-page](how-to-native-authentication-cors-solution-production-environment.md) applications </li></ul> |
| Redirect URIs for authentication | Microsoft Entra ID accepts these URIs as destinations when it returns authentication responses (tokens) after successfully authenticating or signing out users. | Same as workforce. |
| Front-channel logout URL for authentication | This URL is where Microsoft Entra ID sends a request to have the application clear the user's session data. The front-channel logout URL is required for single sign-out to work correctly. | Same as workforce. |
| Implicit grant and hybrid flows for authentication | Request a token directly from the authorization endpoint. | Same as workforce. |
| Certificates and secrets | Multiple credentials are available: <ul><li>[Certificates](../../identity-platform/how-to-add-credentials.md?tabs=certificate)</li><li>[Client secrets](../../identity-platform/how-to-add-credentials.md?tabs=client-secret)</li><li>[Federated credentials](../../identity-platform/how-to-add-credentials.md?tabs=federated-credential)</li></ul> | Same as workforce. |
| Rotation for certificates and secrets | Update client credentials to help ensure that they remain valid and secure, while users can continue to sign-in. You can rotate [certificates](../../identity-platform/how-to-add-credentials.md?tabs=certificate), [secrets](../../identity-platform/how-to-add-credentials.md?tabs=client-secret), and [federated credentials](../../identity-platform/how-to-add-credentials.md?tabs=federated-credential) by adding a new one and then removing the old one. | Same as workforce. |
| Policy for certificates and secrets | Configure the [application management policies](~/identity/enterprise-apps/tutorial-enforce-secret-standards.md) to enforce secret and certificate restrictions. | Not available. |
| API permissions | Add, remove, and replace permissions to an application. After permissions are added to your application, users or admins need to grant consent to the new permissions. [Learn more about updating an app's requested permissions in Microsoft Entra ID](../../identity-platform/howto-update-permissions.md). | The following permissions are allowed: Microsoft Graph `offline_access`, `openid`, and `User.Read`, along with your **My APIs** delegated permissions. Only an admin can consent on behalf of the organization. |
| Expose an API | [Define custom scopes](../../identity-platform/quickstart-configure-app-expose-web-apis.md) to restrict access to data and functionality that the API helps protect. An application that requires access to parts of this API can request user or admin consent to one or more of these scopes. | Same as workforce. |
| Owners | Application owners can view and edit the application registration. Additionally, any user (who might not be listed) with administrative privileges to manage any application (for example, [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator)) can view and edit the application registration. | Same as workforce. |
| Roles and administrators | [Administrative roles](~/identity/role-based-access-control/permissions-reference.md) are used for granting access for privileged actions in Microsoft Entra ID. | Only the [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator) role can be used for apps in external tenants. This role grants the ability to create and manage all aspects of application registrations and enterprise applications. |

### Access control for applications

The following table compares the features for application authorization in each type of tenant.

| Feature | Workforce tenant | External tenant |
| ------- | ---------------- | --------------- |
| Role-based access control (RBAC) | You can define [application roles](../../identity-platform/custom-rbac-for-developers.md#app-roles) for your application and assign those roles to users and groups. Microsoft Entra ID includes the user roles in the security token. Your application can then make authorization decisions based on the values in the security token. | Same as workforce. [Learn more about using role-based access control for applications in an external tenant](how-to-use-app-roles-customers.md). For available features, see [Groups and application roles support](./reference-group-app-roles-support.md). |
| Security groups | You can use [security groups](../../identity-platform/custom-rbac-for-developers.md#groups) to implement RBAC in your applications, where the memberships of users in specific groups are interpreted as their role memberships. Microsoft Entra ID includes user group membership in the security token. Your application can then make authorization decisions based on the values in the security token. | Same as workforce. The [group optional claims](../../identity-platform/optional-claims.md#configure-groups-optional-claims) are limited to the group object ID. |
| Attribute-based access control (ABAC) | You can configure the app to include user attributes in the access token. Your application can then make authorization decisions based on the values in the security token. For more information, see [Token customization](#token-customization). | Same as workforce. |
| Require user assignment | When user assignment is required, only the users you assign to the application (either through direct user assignment or based on group membership) can sign in. For more information, see [Manage user and group assignments to an application](../../identity-platform/howto-restrict-your-app-to-a-set-of-users.md). | Same as workforce. For details, see [Groups and application roles support](./reference-group-app-roles-support.md). |

## Enterprise applications

The following table compares the unique features for [enterprise application](/entra/identity/enterprise-apps/) registration in workforce and external tenants.

| Feature | Workforce tenant | External tenant |
| ------- | ---------------- | --------------- |
| Application gallery | The [application gallery](/entra/identity/enterprise-apps/overview-application-gallery) contains thousands of applications that are integrated into Microsoft Entra ID. | Choose from a range of integrated apps. To find a partner app, use the search bar. The application gallery catalog isn't available. |
| Register a custom enterprise application | [Add an enterprise application.](/entra/identity/enterprise-apps/add-application-portal) | [Register a SAML app in your external tenant.](/entra/external-id/customers/how-to-register-saml-app) |
| Self-service application assignment | Let users [self-discover apps](/entra/identity/enterprise-apps/manage-self-service-access). | Self-service application assignment in the [My Apps portal](/entra/identity/enterprise-apps/myapps-overview) isn't available. |
| Application proxy | [Microsoft Entra application proxy](/entra/identity/app-proxy/overview-what-is-app-proxy) provides secure remote access to on-premises web applications. | Not available. |
| Deactivate app registration | [Deactivate an app registration](/entra/identity/enterprise-apps/deactivate-app-registration) to prevent token issuance while preserving configuration. | Same as workforce. |

### Consent and permission features for enterprise applications

The following table shows which consent and permission features are available for enterprise applications in each type of tenant.

| Feature | Workforce tenant | External tenant |
| ------- | ---------------- | --------------- |
| Admin consent for enterprise applications | You can [grant tenant-wide admin permissions](/entra/identity/enterprise-apps/grant-admin-consent). You can also [review and revoke](/entra/identity/enterprise-apps/manage-application-permissions?pivots=portal) them. | Same as workforce. |
| User consent for enterprise applications | You can configure how [users consent to applications](/entra/identity/enterprise-apps/configure-user-consent), and you can [update these permissions](/entra/identity-platform/howto-update-permissions). | Limited to permissions that don't require [admin consent](/entra/identity/enterprise-apps/grant-admin-consent). |
| Review or revoke admin consent | [Review and revoke](/entra/identity/enterprise-apps/manage-application-permissions) permissions. | [Use the Microsoft Entra admin center](/entra/identity/enterprise-apps/manage-application-permissions?pivots=portal) to revoke admin consent. |
| Review or revoke user consent | [Review and revoke](/entra/identity/enterprise-apps/manage-application-permissions) permissions. | Use [Microsoft Graph API](/entra/identity/enterprise-apps/manage-application-permissions?pivots=ms-graph) or [PowerShell](/entra/identity/enterprise-apps/manage-application-permissions?pivots=entra-powershell) to revoke user consent. |
| Assign users or groups to apps | You can [manage access to apps](/entra/identity/enterprise-apps/what-is-access-management) in an individual or group-based assignment. [Nested group](/entra/fundamentals/how-to-manage-groups) memberships aren't supported. | Same as workforce. |
| RBAC for app roles | You can define and assign roles for fine-grained [access control](/entra/external-id/customers/how-to-use-app-roles-customers). | Same as workforce. |

## OpenID Connect and OAuth2 flows

The following table compares the features for OAuth 2.0 and OpenID Connect authorization flows in each type of tenant.

| Feature | Workforce tenant | External tenant |
| ------- | ---------------- | --------------- |
| [OpenID Connect](../../identity-platform/v2-protocols-oidc.md) | Yes | Yes |
| [Authorization code](../../identity-platform/v2-oauth2-auth-code-flow.md) | Yes | Yes |
| [Authorization code with Proof Key for Code Exchange (PKCE)](../../identity-platform/v2-oauth2-auth-code-flow.md) | Yes | Yes |
| [Client credentials](../../identity-platform/v2-oauth2-client-creds-grant-flow.md) | Yes | [v2.0 applications](../../identity-platform/reference-app-manifest.md) |
| [Device authorization](../../identity-platform/v2-oauth2-device-code.md) | Yes | Yes |
| [On-behalf-of flow](../../identity-platform/v2-oauth2-on-behalf-of-flow.md) | Yes | Yes |
| [Implicit grant](../../identity-platform/v2-oauth2-implicit-grant-flow.md) | Yes | Yes |
| [Resource owner password credentials](../../identity-platform/v2-oauth-ropc.md) | Yes | No; for mobile applications, use [native authentication](concept-native-authentication.md) |

### Authority URL in OpenID Connect and OAuth2 flows

The authority URL indicates a directory that the Microsoft Authentication Library (MSAL) can request tokens from. For apps in external tenants, always use the following format: `<tenant-name>.ciamlogin.com`.

The following JSON shows an example of a .NET application `appsettings.json` file with an authority URL:

```json
{
    "AzureAd": {
        "Authority": "https://<Enter_the_Tenant_Subdomain_Here>.ciamlogin.com/",
        "ClientId": "<Enter_the_Application_Id_Here>"
    }
}
```

## Conditional Access

The following table compares the features for Microsoft Entra Conditional Access in each type of tenant.

| Feature | Workforce tenant | External tenant |
| ------- | ---------------- | --------------- |
| Assignments | [Users, groups](~/identity/conditional-access/concept-conditional-access-users-groups.md), and [workload identities](~/identity/conditional-access/concept-conditional-access-users-groups.md#workload-identities). | Include all users, and exclude users and groups. For more information, see [Add multifactor authentication (MFA) to an app](./how-to-multifactor-authentication-customers.md). |
| Target resources | <ul><li>[Cloud apps](~/identity/conditional-access/concept-conditional-access-cloud-apps.md)</li><li>[User actions](~/identity/conditional-access/concept-conditional-access-cloud-apps.md#user-actions)</li><li>[Global Secure Access](~/identity/conditional-access/concept-conditional-access-cloud-apps.md#traffic-forwarding-profiles)</li><li>[Authentication context](~/identity/conditional-access/concept-conditional-access-cloud-apps.md#authentication-context)</li></ul> | <ul><li>[All resources, selected apps](./how-to-multifactor-authentication-customers.md), or [filter applications](~/identity/conditional-access/concept-filter-for-applications.md)</li><li>[Authentication context](~/identity/conditional-access/concept-conditional-access-cloud-apps.md#authentication-context)</li></ul> |
| Conditions | <ul><li>[Sign-in risk](~/identity/conditional-access/concept-conditional-access-conditions.md#sign-in-risk)</li><li>[User risk](~/identity/conditional-access/concept-conditional-access-conditions.md#user-risk)</li><li>[Device platforms](~/identity/conditional-access/concept-conditional-access-conditions.md#device-platforms)</li><li>[Locations](~/identity/conditional-access/concept-conditional-access-conditions.md#locations)</li><li>[Client apps](~/identity/conditional-access/concept-conditional-access-conditions.md#client-apps)</li><li>[Filter for devices](~/identity/conditional-access/concept-conditional-access-conditions.md#filter-for-devices)</li></ul> | <ul><li>[Device platforms](~/identity/conditional-access/concept-conditional-access-conditions.md#device-platforms)</li><li>[Locations](~/identity/conditional-access/concept-conditional-access-conditions.md#locations)</li></ul> |
| Grant | [Grant or block access to resources](~/identity/conditional-access/concept-conditional-access-grant.md) | <ul><li>[Block access](~/identity/conditional-access/concept-conditional-access-grant.md#block-access)</li><li>[Require multifactor authentication](./how-to-multifactor-authentication-customers.md)</li><li>[Require password reset](./how-to-enable-password-reset-customers.md)</li></ul> |
| Session | [Session controls](~/identity/conditional-access/concept-conditional-access-session.md) | The following session controls are available: <ul><li>Sign-in frequency</li><li>Persistent browser session</li></ul> |

## Terms-of-use policies

The following table compares the features for terms-of-use policies in each type of tenant.

| Feature | Workforce tenant | External tenant |
| ------- | ---------------- | --------------- |
| Conditional Access policies | See the [Microsoft Entra terms of use](~/identity/conditional-access/terms-of-use.md). | Not available. |
| Self-service sign-up | Not available. | Add a [required attribute](how-to-define-custom-attributes.md#configure-a-single-select-checkbox-checkboxsingleselect) linked to your terms-of-use policies on the sign-up page. You can customize the hyperlink to support various languages. |
| Sign-in page | You can add links to the lower-right corner for privacy information by using [company branding](~/fundamentals/how-to-customize-branding.md). | [Same as workforce](how-to-customize-branding-customers.md#to-customize-the-logo-privacy-link-and-terms-of-use). |

## Account management

The following table compares the features for user management in each type of tenant. As noted in the table, certain account types are created through invitation or self-service sign-up. A user admin in the tenant can also create accounts via the admin center.

| Feature | Workforce tenant | External tenant |
| ------- | ---------------- | --------------- |
| Types of accounts | <ul><li>Internal members, such as employees and admins.</li><li>External users who are [invited](../what-is-b2b.md) or use self-service sign-up.</li></ul> | <ul><li> External users created through self-service sign-up or [by an admin](how-to-manage-customer-accounts.md).</li><li> Internal users, with or without an admin role. </li><li> Invited users (preview), with or without an admin role. </li></ul> All users in an external tenant have [default permissions](reference-user-permissions.md) unless they're assigned an [admin role](how-to-manage-admin-accounts.md). |
| Manage user profile info | <ul><li>Manage users programmatically and by [using the admin center](~/fundamentals/how-to-manage-user-profile-info.md).</li><li>Manage guest users across tenants with [cross-tenant synchronization](/entra/identity/multi-tenant-organizations/cross-tenant-synchronization-overview).</li></ul> | Same as workforce, except cross-tenant synchronization isn't available. |
| Reset a user's password | Administrators can [reset a user's password](~/fundamentals/users-reset-password-azure-portal.md) if the user forgets the password, is locked out of a device, or never received a password. | Same as workforce. |
| Restore or remove a recently deleted user | After you delete a user, the account remains in a suspended state for 30 days. During that 30-day window, the user account can be restored, along with all its properties. | Same as workforce. |
| Disable accounts | Prevent the new user from signing in. | Same as workforce. |

## Password protection

The following table compares the features for password protection in each type of tenant.

| Feature | Workforce tenant | External tenant |
| ------- | ---------------- | --------------- |
| Smart lockout | [Smart lockout](~/identity/authentication/howto-password-smart-lockout.md) helps lock out bad actors who try to guess your users' passwords or use brute-force methods to get in. | Same as workforce. |
| Global banned passwords | The [global banned passwords list](~/identity/authentication/concept-password-ban-bad.md#global-banned-password-list) automatically blocks commonly used weak or compromised passwords based on analysis of Microsoft Entra security data. | Same as workforce. |
| Custom banned passwords | Use the [custom banned passwords list](../../identity/authentication/tutorial-configure-custom-password-protection.md) to add specific strings to evaluate and block during password creation and reset. | Same as workforce. |

## Token customization

The following table compares the features for token customization in each type of tenant.

| Feature | Workforce tenant | External tenant |
| ------- | ---------------- | --------------- |
| Claims mapping | [Customize claims](~/identity-platform/jwt-claims-customization.md) issued in the JSON web token (JWT) for enterprise applications. | Same as workforce. Optional claims must be configured through [Attributes & Claims](how-to-add-attributes-to-token.md). |
| Claims transformation | [Apply a transformation to a user attribute](~/identity-platform/jwt-claims-customization.md) issued in the JWT for enterprise applications. | Same as workforce. |
| Custom claims provider | Use a [custom authentication extension](~/identity-platform/custom-extension-overview.md) that calls an external REST API to fetch claims from external systems. | Same as workforce. [Learn more](../../identity-platform/custom-claims-provider-overview.md). |
| Security groups | [Configure group optional claims](../../identity-platform/optional-claims.md#configure-groups-optional-claims). | [Configure group optional claims](../../identity-platform/optional-claims.md#configure-groups-optional-claims), limited to the group object ID. |
| Token lifetimes | [Specify the lifetime](../../identity-platform/configurable-token-lifetimes.md) of security tokens issued by Microsoft Entra ID. | Same as workforce. |
| Session and token revocation | An administrator can [invalidate all the refresh tokens and session](/graph/api/user-revokesigninsessions) for a user. | Same as workforce. |

## Single sign-on

[Single sign-on (SSO)](../../identity-platform/msal-js-sso.md) provides a more seamless experience by reducing the number of times a user is asked for credentials. Users enter their credentials once. Other applications can reuse the established session on the same device and web browser without further prompting.

The following table compares the features for SSO in each type of tenant.

| Feature | Workforce tenant | External tenant |
| ------- | ---------------- | --------------- |
| Types of application registration | <ul><li>OpenID Connect</li> <li>OAuth 2.0</li> <li>SAML (enterprise application)</li></ul><br>Enterprise applications offer [more options](../../identity/enterprise-apps/plan-sso-deployment.md), like password-based, linked, and header-based registration. | <ul><li>OpenID Connect</li> <li>OAuth 2.0</li> <li>SAML (enterprise application)</li></ul> |
| Domain name | When a user is authenticated, a session cookie is set on the Microsoft Entra domain `login.microsoftonline.com` in the web browser. | When a user is authenticated, a session cookie is set on the Microsoft Entra External ID domain `<tenant-name>.ciamlogin.com` or a [custom URL domain](concept-custom-url-domain.md) in the web browser. To ensure that SSO functions correctly, use a single URL domain. |
| Stay signed in | You can turn on or turn off the option to [stay signed in](~/fundamentals/how-to-manage-stay-signed-in-prompt.yml). | Same as workforce. |
| User provisioning | Use [automatic user provisioning](/entra/architecture/sync-scim) with System for Cross-domain Identity Management (SCIM) to sync user accounts between External ID and supported apps. This approach keeps user data up to date automatically.<br><br> User provisioning supports differential queries. These queries sync only the changes since the last update. This behavior improves performance and reduces system load. | Same as workforce. |
| Session invalidation | Scenarios where SSO might be invalidated, which requires reauthentication: <ul><li>Session expiry</li><li>Browser issues, such as clearing browser cookies or cache</li><li>Conditional Access policy, such as a multifactor authentication requirement</li><li>[Session revocation](/graph/api/user-revokesigninsessions)</li><li>Security issues, such as suspicious activity</li></ul><br>The application specifies in the authorization request to prompt the user for credentials by using the `login=prompt` query string parameter in OpenID Connect and the `ForceAuthn` attribute in the SAML request. | Same as workforce. |
| Conditional Access | Check the [Conditional Access](#conditional-access) section. | Check the [Conditional Access](#conditional-access) section. |
| Microsoft Entra native authentication | Not available. | [Native authentication](concept-native-authentication.md) doesn't support SSO. |
| Sign-out | When a [SAML](../../identity-platform/single-sign-out-saml-protocol.md) or [OpenID Connect](../../identity-platform/v2-protocols-oidc.md#send-a-sign-out-request) application directs the user to the logout endpoint, Microsoft Entra ID removes and invalidates the user's session from the browser. | Same as workforce. |
| Single sign-out | Upon successful sign-out, Microsoft Entra ID sends a sign-out notification to all other [SAML](../../identity-platform/single-sign-out-saml-protocol.md) and [OpenID Connect](../../identity-platform/v2-protocols-oidc.md#single-sign-out) applications that the user is signed in to. | Same as workforce. |

## Integrated security solutions

Microsoft Entra External ID supports integrated security features and partner solutions to help protect identities across the lifecycle. These capabilities include protection against distributed denial-of-service (DDoS) attacks, prevention of sign-up fraud, and unified monitoring.

You can enable these solutions directly in External ID and access partner integrations through the [Microsoft Security Store](https://securitystore.microsoft.com/). This approach allows organizations to deploy trusted security tools quickly without complex setup.

| Feature | Workforce tenant | External tenant |
| ------- | ---------------- | --------------- |
| Sign-up fraud protection | The Security Store wizard experience isn't available. | Use [Arkose Labs](/entra/external-id/customers/how-to-integrate-fraud-protection?pivots=arkose) and [HUMAN Security](/entra/external-id/customers/how-to-integrate-fraud-protection?pivots=human) to help protect against sign-up fraud and block automated bot attacks. |
| DDoS and web application firewall (WAF) protection | The Security Store wizard experience isn't available. | Use [Cloudflare](/entra/external-id/customers/how-to-configure-waf-integration) and [Akamai](/entra/external-id/customers/how-to-configure-akamai-integration) to help protect against DDoS attacks and secure apps with a WAF. |
| Security analytics | The Security Store wizard experience isn't available. | Use [Azure Monitor and Microsoft Sentinel](/entra/external-id/customers/how-to-azure-monitor) to enable one-click monitoring, Log Analytics, and advanced threat detection. |

### Akamai and Cloudflare

[Akamai](/entra/external-id/customers/how-to-configure-akamai-integration) and [Cloudflare](/entra/external-id/customers/how-to-configure-waf-integration) provide DDoS protection, bot mitigation, and WAF capabilities. These capabilities help defend applications against malicious traffic, abusive automation, and common web vulnerabilities such as SQL injection, cross‑site scripting, and API‑based attacks.

When you integrate either service with External ID, you can apply these security controls in front of your customer-facing identity flows. This action improves resilience and reduces exposure to credential stuffing and other identity‑targeted threats.

## Activity logs and reports

The following table compares the features for activity logs and reports across various types of tenants.

| Feature | Workforce tenant | External tenant |
| ------- | ---------------- | --------------- |
| [Audit logs](~/identity/monitoring-health/concept-audit-logs.md) | These logs provide a detailed report of all events logged in Microsoft Entra ID, including modifications to applications, groups, and users. | Same as workforce. |
| [Sign-in logs](~/identity/monitoring-health/concept-sign-ins.md) | The sign-in logs track all sign-in activities within a Microsoft Entra tenant, including access to your applications and resources. | Same as workforce. |
| [Sign-up logs](~/identity/monitoring-health/concept-sign-ups.md) (preview) | Not available. | Microsoft Entra External ID logs all self-service sign-up events, including both successful sign-ups and failed attempts. |
| [Provisioning logs](~/identity/monitoring-health/concept-provisioning-logs.md) | The provisioning logs provide detailed records of provisioning events within a tenant, such as user account creations, updates, and deletions. | Not available. |
| [Activity logs for retention policies](~/identity/monitoring-health/concept-provisioning-logs.md) | Microsoft Entra data retention policies determine how long various types of logs (like audit, sign-in, and provisioning logs) are stored. | Seven days. |
| [Export activity logs](~/identity/monitoring-health/howto-configure-diagnostic-settings.md) | By using diagnostic settings in Microsoft Entra ID, you can integrate logs with Azure Monitor, stream logs to an event hub, or integrate with security information and event management (SIEM) tools. | [Azure Monitor for external tenants (preview)](./how-to-azure-monitor.md). |
| [Reports for application user activity](./how-to-user-insights.md) | Not available. | Application user activity provides analytics on how users interact with registered applications in your tenant. It tracks metrics like active users, new users, sign-ins, and MFA success rates. |

## Microsoft Graph APIs

All features that are supported in external tenants are also supported for automation through Microsoft Graph APIs. Some features that are in preview in external tenants might be generally available through Microsoft Graph. For more information, see [Manage Microsoft Entra identity and network access by using Microsoft Graph](/graph/api/resources/identity-network-access-overview).

## Related content

- [Planning for customer identity and access management](concept-planning-your-solution.md)
