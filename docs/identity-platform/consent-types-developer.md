---
title: Developer’s Guide to Requesting Permissions and Consent in Microsoft Identity Platform
description: Learn how developers can request for permissions through consent in the Microsoft identity platform endpoint.
author: omondiatieno
manager: celesteDG
ms.author: jomondi
ms.date: 05/21/2025
ms.reviewer: jawoods, ludwignick, phsignor
ms.service: identity-platform

ms.topic: concept-article

#Customer intent: As a developer building an application that requires user consent for accessing resources or APIs, I want to understand the different types of consent available (static, incremental, dynamic) and how to request permissions through consent, so that I can implement the appropriate consent approach in my application and provide a better user experience.
---
# Developer’s guide to requesting permissions and consent in Microsoft Identity Platform

Applications in the Microsoft identity platform rely on consent in order to gain access to necessary resources or APIs. Different types of consent are better for different application scenarios. Choosing the best approach to consent for your app enables it to be more successful with users and organizations.

In this article, you learn about the different types of consent and how to request permissions for your application through consent.

## Static user consent

In the static user consent scenario, you must specify all the permissions it needs in the app's configuration in the Microsoft Entra admin center. If the user (or administrator, as appropriate) doesn't grant consent for this app, then Microsoft identity platform prompts the user to provide consent at this time.

Static permissions also enable administrators to consent on behalf of all users in the organization.

While relying on static consent and a single permissions list keeps the code nice and simple, it also means that your app requests all of the permissions it might ever need up front. This setting can discourage users and admins from approving your app's access request.

## Incremental and dynamic user consent

With the Microsoft identity platform endpoint, you can ignore the static permissions defined in the application registration information in the Microsoft Entra admin center. Instead, you can request permissions incrementally. You can ask for a bare minimum set of permissions upfront and request more over time as the customer uses more application features. To do so, you can specify the scopes your application needs at any time by including the new scopes in the `scope` parameter when [requesting an access token](#requesting-individual-user-consent) - without the need to predefine them in the application registration information. 

If the user doesn't consent to new scopes added to the request, they get a prompt to consent only to the new permissions. Incremental, or dynamic consent, only applies to delegated permissions and not to application permissions.

Allowing an application to request permissions dynamically through the `scope` parameter gives developers full control over your user's experience. You front load your consent experience and ask for all permissions in one initial authorization request. If your application requires a large number of permissions, you can gather those permissions from the user incrementally as they try to use certain features of the application over time.

> [!IMPORTANT]
> Dynamic consent can be convenient, but presents a significant challenge for permissions that require admin consent. The admin consent experience in the **App registrations** and **Enterprise applications** blades in the portal doesn't know about those dynamic permissions at consent time. We recommend that a developer list all the admin privileged permissions that the application needs in the portal. 
> 
> This enables tenant admins to consent on behalf of all their users in the portal once. Users don't need to go through the consent experience for those permissions on sign in. The alternative is to use dynamic consent for those permissions. To grant admin consent, an individual admin signs in to the app, triggers a consent prompt for the appropriate permissions, and selects **consent for my entire org** in the consent dialogue.

## Requesting individual user consent

In an [OpenID Connect or OAuth 2.0](./v2-protocols.md) authorization request, an application can request the permissions it needs by using the `scope` query parameter. For example, when a user signs in to an app, the application sends a request like the following example. (Line breaks are added for legibility).

```HTTP
GET https://login.microsoftonline.com/common/oauth2/v2.0/authorize?
client_id=00001111-aaaa-2222-bbbb-3333cccc4444
&response_type=code
&redirect_uri=http%3A%2F%2Flocalhost%2Fmyapp%2F
&response_mode=query
&scope=
https%3A%2F%2Fgraph.microsoft.com%2Fcalendars.read%20
https%3A%2F%2Fgraph.microsoft.com%2Fmail.send
&state=12345
```

The `scope` parameter is a space-separated list of delegated permissions that the application is requesting. Each permission is indicated by appending the permission value to the resource's identifier (the application ID URI). In the request example, the application needs permission to read the user's calendar and send mail as the user.

After sign-in, the Microsoft identity platform checks for existing user consent. If the user doesn't approve the requested permissions and an administrator doesn't approve them either, the platform prompts the user to grant consent.

In the following example, the `offline_access` ("Maintain access to data you grant access to") permission and `User.Read` ("Sign you in and read your profile") permission are automatically included in the initial consent to an application. These permissions are required for proper application functionality. 

The `offline_access` permission gives the application access to refresh tokens that are critical for native apps and web apps. The `User.Read` permission gives access to the `sub` claim. It allows the client or application to correctly identify the user over time and access rudimentary user information.

:::image type="content" source="./media/consent-types-developer/request-permissions-through-consent.png" alt-text="Example screenshot that shows work account consent." lightbox="./media/consent-framework/grant-consent.png":::

When the user approves the permission request, consent is recorded. The user doesn't have to consent again when they later sign in to the application.

## Requesting consent for an entire tenant through admin consent

Requesting consent for an entire tenant requires admin consent. Admin consent done on behalf of an organization requires the static permissions registered for the app. Set those permissions in the app registration portal if you need an admin to give consent on behalf of the entire organization.

### Admin Consent for Delegated Permissions

When your app requests [delegated permissions that require admin consent](scopes-oidc.md#admin-restricted-permissions), users see an "unauthorized to consent" error and need to ask an administrator for access. Once an admin grants consent for the entire tenant, users aren't prompted again unless consent is revoked or new permissions are added.

Administrators using the same application see the admin consent prompt. The admin consent prompt provides a checkbox that allows them to grant the application access to the requested data on behalf of the users for the entire tenant. For more information on the user and admin consent experience, see [Application consent experience](application-consent-experience.md).

Examples of delegated permissions for Microsoft Graph that require admin consent are:

- Read all user's full profiles by using User.Read.All
- Write data to an organization's directory by using Directory.ReadWrite.All
- Read all groups in an organization's directory by using Groups.Read.All

To view the full list of Microsoft Graph permissions, see [Microsoft Graph permissions reference](/graph/permissions-reference).

You can also configure permissions on your own resources to require admin consent. For more information on how to add scopes that require admin consent, see [Add a scope that requires admin consent](quickstart-configure-app-expose-web-apis.md#add-a-scope-requiring-admin-consent).

Some organizations might change the default user consent policy for the tenant. When your application requests access to permissions they're evaluated against these policies. The user might need to request admin consent even when not required by default. To learn how administrators manage consent policies for applications, see [Manage app consent policies](~/identity/enterprise-apps/manage-app-consent-policies.md).

>[!NOTE]
>In Microsoft identity platform authorization, token, or consent requests, omitting the resource identifier in the `scope` parameter defaults to Microsoft Graph. For example, `scope=User.Read` is treated as `https://graph.microsoft.com/User.Read`.

### Admin Consent for Application permissions

Application permissions always require admin consent. Application permissions don't have a user context and the consent grant isn't done on behalf of any specific user. Instead, the client application is granted permissions directly. These types of permissions are used only by daemon services and other non-interactive applications that run in the background. Administrators need to configure the permissions upfront and [grant admin consent](~/identity/enterprise-apps/grant-admin-consent.md) through the Microsoft Entra admin center.

### Admin consent for multitenant applications

In case the application requesting the permission is a multitenant application, its application registration only exists in the tenant where it was created, therefore permissions can't be configured in the local tenant. If the application requests permissions that require admin consent, the administrator needs to consent on behalf of the users. To consent to these permissions, the administrators need to sign in to the application themselves, so the admin consent sign-in experience is triggered. To learn how to set up the admin consent experience for multitenant applications, see [Enable multitenant log-ins](howto-convert-app-to-be-multi-tenant.md#understand-user-and-admin-consent-and-make-appropriate-code-changes)

An administrator can grant consent for an application with the following options.

### Recommended: Sign the user into your app

Typically, when you build an application that requires admin consent, the application needs a page or view in which the admin can approve the app's permissions. This page can be:

- Part of the app's sign-up flow.
- Part of the app's settings.
- A dedicated "connect" flow.

In many cases, it makes sense for the application to show the "connect" view only after a user is signed in with a work Microsoft account or school Microsoft account.

When you sign the user into your app, you can identify the organization to which the admin belongs before you ask them to approve the necessary permissions. Although this step isn't strictly necessary, it can help you create a more intuitive experience for your organizational users.

To sign the user in, follow the [Microsoft identity platform protocol tutorials](./v2-protocols.md).

### Request the permissions in the app registration portal

In the app registration portal, applications can list the permissions they require, including both delegated permissions and application permissions. This setup allows the use of the `.default` scope and the Microsoft Entra admin center's **Grant admin consent** option.  

In general, the permissions should be statically defined for a given application. They should be a superset of the permissions that the application requests dynamically or incrementally.

> [!NOTE]
>Application permissions can be requested only by using [`.default`](scopes-oidc.md#the-default-scope). So if your application needs application permissions, make sure they're listed in the app registration portal.

To configure the list of statically requested permissions for an application:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Entra ID** > **App registrations** > **All applications**.
1. Select an application, or [create an app](quickstart-register-app.md) if you haven't already.
1. On the application's **Overview** page, under **Manage**, select **API Permissions** > **Add a permission**.
1. Select **Microsoft Graph** from the list of available APIs. Then add the permissions that your application requires.
1. Select **Add Permissions**.

### Successful response

If the admin approves the permissions for your app, the successful response looks like this:

```HTTP
GET http://localhost/myapp/permissions?tenant=aaaabbbb-0000-cccc-1111-dddd2222eeee&state=state=12345&admin_consent=True
```

| Parameter | Description |
| --- | --- |
| `tenant` | The directory tenant that granted your application the permissions it requested, in GUID format. |
| `state` | A value included in the request returned in the token response. It can be a string of any content you want. The state is used to encode information about the user's state in the application before the authentication request occurred, such as the page or view they were on. |
| `admin_consent` | Is set to `True`. |

After you receive a successful response from the admin consent endpoint, your application is granted the permissions it requested. Next, you can request a token for the resource you want.

#### Error response

If the admin doesn't approve the permissions for your app, the failed response looks like this:

```HTTP
GET http://localhost/myapp/permissions?error=permission_denied&error_description=The+admin+canceled+the+request
```

| Parameter | Description |
| --- | --- |
| `error` | An error code string that can be used to classify types of errors that occur. It can also be used to react to errors. |
| `error_description` | A specific error message that can help a developer identify the root cause of an error. |

## Using permissions after consent

After the user consents to permissions for your app, your application can acquire access tokens that represent the app's permission to access a resource in some capacity. An access token can be used only for a single resource. But encoded inside the access token is every permission that your application is granted for that resource. To acquire an access token, your application can make a request to the Microsoft identity platform token endpoint, like this:

```HTTP
POST common/oauth2/v2.0/token HTTP/1.1
Host: https://login.microsoftonline.com
Content-Type: application/json

{
    "grant_type": "authorization_code",
    "client_id": "00001111-aaaa-2222-bbbb-3333cccc4444",
    "scope": "https://microsoft.graph.com/Mail.Read https://microsoft.graph.com/mail.send",
    "code": "AwABAAAAvPM1KaPlrEqdFSBzjqfTGBCmLdgfSTLEMPGYuNHSUYBrq...",
    "redirect_uri": "https://localhost/myapp",
    "client_secret": "A1bC2dE3f..."  // NOTE: Only required for web apps
}
```

You can use the resulting access token in HTTP requests to the resource. It reliably indicates to the resource that your application has the proper permission to do a specific task.

For more information about the OAuth 2.0 protocol and how to get access tokens, see the [Microsoft identity platform endpoint protocol reference](./v2-protocols.md).

## Related content

- [Consent experience](application-consent-experience.md)
- [ID tokens](id-tokens.md)
- [Access tokens](access-tokens.md)
