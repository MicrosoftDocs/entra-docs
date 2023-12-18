---
title: Microsoft identity platform admin consent protocols
description: A description of authorization in the Microsoft identity platform, including scopes, permissions, and consent.
author: rwike77
manager: CelesteDG
ms.author: ryanwi
ms.custom:
ms.date: 11/08/2023
ms.reviewer: ludwignick
ms.service: active-directory
ms.subservice: develop
ms.topic: reference
#Customer intent: As an application developer, I want to use the admin consent endpoint in my app, so that the user can request permissions from the organization's admin if needed.
---

# Admin consent on the Microsoft identity platform

Some permissions require consent from an administrator before they can be granted within a tenant. You can also use the admin consent endpoint to grant permissions to an entire tenant.

## Recommended: Sign the user into your app

Typically, when you build an application that uses the admin consent endpoint, the app needs a page or view in which the admin can approve the app's permissions. This page can be part of the app's sign-up flow, part of the app's settings, or it can be a dedicated "connect" flow. In many cases, it makes sense for the app to show this "connect" view only after a user has signed in with a work or school Microsoft account.

When you sign the user into your app, you can identify the organization to which the admin belongs before asking them to approve the necessary permissions. Although not strictly necessary, it can help you create a more intuitive experience for your organizational users.

## Request the permissions from a directory admin

When you're ready to request permissions from your organization's admin, you can redirect the user to the Microsoft identity platform *admin consent endpoint*.

```none
https://login.microsoftonline.com/{tenant}/v2.0/adminconsent
        ?client_id=535fb089-9ff3-47b6-9bfb-4f1264799865
        &scope=https://graph.microsoft.com/Calendars.Read https://graph.microsoft.com/Mail.Send
        &redirect_uri=http://localhost/myapp/permissions
        &state=12345
```

| Parameter | Condition | Description |
| :--- | :--- | :--- |
| `tenant` | Required | The directory tenant that you want to request permission from. Can be provided in GUID or friendly name format OR generically referenced with `organizations` as seen in the example. Do not use 'common', as personal accounts cannot provide admin consent except in the context of a tenant. To ensure best compatibility with personal accounts that manage tenants, use the tenant ID when possible. |
| `client_id` | Required | The **Application (client) ID** that the [Microsoft Entra admin center – App registrations](https://go.microsoft.com/fwlink/?linkid=2083908) experience assigned to your app. |
| `redirect_uri` | Required |The redirect URI where you want the response to be sent for your app to handle. It must exactly match one of the redirect URIs that you registered in the app registration portal. |
| `state` | Recommended | A value included in the request that will also be returned in the token response. It can be a string of any content you want. Use the state to encode information about the user's state in the app before the authentication request occurred, such as the page or view they were on. |
|`scope` | Required | Defines the set of permissions being requested by the application. This can be either static (using `/.default`) or dynamic scopes. This can include the OIDC scopes (`openid`, `profile`, `email`). |

At this point, Microsoft Entra ID requires a tenant administrator to sign in to complete the request. The administrator is asked to approve all the permissions that you have requested in the `scope` parameter.  If you've used a static (`/.default`) value, it will function like the v1.0 admin consent endpoint and request consent for all scopes found in the required permissions (both user and app). In order to request app permissions, you must use the `/.default` value. If you don't want admins to see a given permission in the admin consent screen all the time when you use `/.default`, the best practice is to not put the permission in the required permissions section. Instead you can use dynamic consent to add the permissions you want to be in the consent screen at run time, rather than using `/.default`.

### Successful response

If the admin approves the permissions for your app, the successful response looks like this:

```none
http://localhost/myapp/permissions
    ?admin_consent=True
    &tenant=fa00d692-e9c7-4460-a743-29f2956fd429
    &scope=https://graph.microsoft.com/Calendars.Read https://graph.microsoft.com/Mail.Send
    &state=12345
```

| Parameter | Description |
| :--- | :--- |
| `tenant`| The directory tenant that granted your application the permissions it requested, in GUID format.|
| `state` | A value included in the request that also will be returned in the token response. It can be a string of any content you want. The state is used to encode information about the user's state in the app before the authentication request occurred, such as the page or view they were on.|
| `scope` | The set of permissions that were granted access to, for the application.|
| `admin_consent` | Will be set to `True`.|

> [!WARNING]
> Never use the **tenant ID** value of the `tenant` parameter to authenticate or authorize users. The tenant ID value can be updated and sent by bad actors to impersonate a response to your app. This can cause your application to be exposed to security incidents.

### Error response

```none
http://localhost/myapp/permissions
        ?admin_consent=True
        &error=consent_required
        &error_description=AADSTS65004%3a+The+resource+owner+or+authorization+server+denied+the+request.%0d%0aTrace+ID%3a+d320620c-3d56-42bc-bc45-4cdd85c41f00%0d%0aCorrelation+ID%3a+8478d534-5b2c-4325-8c2c-51395c342c89%0d%0aTimestamp%3a+2019-09-24+18%3a34%3a26Z
        &state=12345
```

Adding to the parameters seen in a successful response, error parameters are seen as below.

| Parameter | Description |
|:-------------------|:-------------------------------------------------------------------------------------------------|
| `error` | An error code string that can be used to classify types of errors that occur, and can be used to react to errors.|
| `error_description` | A specific error message that can help a developer identify the root cause of an error.|
| `state` | A value included in the request that also will be returned in the token response. It can be a string of any content you want. The state is used to encode information about the user's state in the app before the authentication request occurred, such as the page or view they were on.|
| `admin_consent` | Will be set to `True` to indicate that this response occurred on an admin consent flow.|

## Next steps
- See [how to convert an app to be multi-tenant](howto-convert-app-to-be-multi-tenant.md)
- Learn how [consent is supported at the OAuth 2.0 protocol layer during the authorization code grant flow](v2-oauth2-auth-code-flow.md#request-an-authorization-code).
- Learn [how a multi-tenant application can use the consent framework](./howto-convert-app-to-be-multi-tenant.md) to implement "user" and "admin" consent, supporting more advanced multi-tier application patterns.
- Understanding [Microsoft Entra application consent experiences](application-consent-experience.md)
