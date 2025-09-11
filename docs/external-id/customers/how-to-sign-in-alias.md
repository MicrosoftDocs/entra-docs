---
title: Sign in with alias
description: Learn how to Sign in with alias/username with External ID for customer identity and access management (CIAM). Get detailed steps to enable username as a sign-in identifier and create users with both email address and username. 
ms.author: cmulligan
author: csmulligan
manager: dougeby
ms.service: entra-external-id 
ms.subservice: external
ms.topic: how-to
ms.date: 09/10/2025
ms.custom: it-pro

#Customer intent: As a dev, devops, or it admin, I want to learn about how to enable sign in with alias/username through the Microsoft Entra admin center and Graph API.

https://learn.microsoft.com/en-us/help/patterns/level4/global-how-to-template

---
# Sign in with an alias or username (preview)

You can enable users who sign in with a local account (email and password) to authenticate using either their email address or an alternative identifier—such as a customer ID, membership ID, insurance number, or frequent flyer number. These alternative identifiers must be assigned to the user via the Microsoft Graph API.

## Prerequisites

- If you haven't already created your own Microsoft Entra external tenant, [create one now](how-to-create-external-tenant-portal.md).
- [Register an app](/entra/identity-platform/quickstart-register-app)
- [Create user a flow](how-to-user-flow-sign-up-sign-in-customers.md)
- [Add your application](how-to-user-flow-add-application.md) to the user flow.

## Step 1: Enable username in sign-in identifier policy

The "canned" sign-in identifier policy enabled for the initial private preview will be deleted. By default, there will be no sign-in identifier policy. In order to enable username, you must enable the sign-in identifier policy.

### Admin UX

Use this feature flag to access the new sign-in identifier policy:

```
https://entra.microsoft.com/?isSignInIdentifiersEnabled=true&enableSignInIdentifiers=true#view/Microsoft_AAD_IAM/CompanyRelationshipsMenuBlade/~/SignInIdentifiers/menuId/ExternalIdentitiesGettingStarted
```

You will see "Sign-in identifiers" in the left navigation of External Identities blade.

> **Note:** You may need to Enable the sign in identifier policy first. For EEID tenants, Email and UPN are required sign-in identifiers.

1. Enable "username" as a sign-in identifier. At run-time, use of this identifier will validate values of username against a 'default' regular expression.
2. Select "enable" checkbox.
3. Click "Save" at the top of the page.

### Alternative: Custom username identifier

If you want to validate values of username against a custom regular expression, you can enable "Custom username" identifier:

1. Click "Customize" – this will bring up a modal window
2. Click "Enable" – which will enable the custom username sign-in identifier and allow you to specify up to 2 regular expressions against which you want to validate
3. Click "Save" at the bottom of the modal window.

> **Note:** There is no validation mechanism for custom regular expressions beyond ensuring they are not in the format of an email address. Authentication may fail at runtime if the provided value does not match the regex or if the regex itself is invalid.

## Step 2: Create user with email address & username as sign-in identifiers

### Graph API

Use Users API to create user with email address and username as sign-in identifiers.

```http
POST https://graph.microsoft.com/v1.0/users
Content-type: application/json

{
    "displayName": "Test User",
    "identities": [
        {
            "signInType": "emailAddress",
            "issuer": "contoso.onmicrosoft.com",
            "issuerAssignedId": "adelev@adatum.com"
        },
        {
            "signInType": "username",
            "issuer": "contoso.onmicrosoft.com",
            "issuerAssignedId": "adelev123"
        }
    ],
    "mail": "adelev@adatum.com",
    "passwordProfile": {
        "password": "passwordValue",
        "forceChangePasswordNextSignIn": false
    },
    "passwordPolicies": "DisablePasswordExpiration"
}
```

### EEID Admin Portal

Use this feature flag to create user with email address and username:

```
https://entra.microsoft.com/?feature.allowUserNameUpdateForCIAM=true#view/Microsoft_AAD_UsersAndTenants/CreateExternalUser.ReactView/tenantType/CIAM
```

You will see an additional value in the Sign-in method dropdown.

#### Step 2.1 - Specify email address and username for new user on Basics tab

#### Step 2.2 - Specify Email attribute under "Properties" tab

## Step 2 Alternative: Add a username to an existing user

Get a user account using a sign-in identifier. You must use `$filter` to get the user object and you must `$select` to retrieve the id and identities[] properties:

```http
GET https://graph.microsoft.com/v1.0/users?$select=displayName,id&$filter=identities/any(c:c/issuerAssignedId eq 'adelev@adatum.com' and c/issuer eq 'contoso.onmicrosoft.com')
```

Response will look something like this:

```http
HTTP/1.1 200 OK
Content-type: application/json

{
  "value": [
    {
      "displayName": "Test User",
      "id": "87d349ed-44d7-43e1-9a83-5f2406dee5bd"
    }
  ]
}
```

Update identities[] property of the user. Note: you must replace the entire identities[] property.

```http
POST https://graph.microsoft.com/v1.0/users/87d349ed-44d7-43e1-9a83-5f2406dee5bd
Content-type: application/json

{
    "identities": [
        {
            "signInType": "emailAddress",
            "issuer": "contoso.onmicrosoft.com",
            "issuerAssignedId": "adelev@adatum.com"
        },
        {
            "signInType": "username",
            "issuer": "contoso.onmicrosoft.com",
            "issuerAssignedId": "adelev123"
        }
    ]
}
```

## Step 3: Test signing in with the user created in Step 1

### Test user flow

Copy (and modify, as desired) the Run user flow endpoint URL to launch the sign-in page for your app.

Sign in with the username you assigned to the user you created/edited in Step 1.

> **Note:** Population of the identities[] property on the user object is not enforced by the Entra sign-in identifiers policy. Administrators can assign values for a users identities[] property but authentication will be determined by sign-in identifier policy. In other words, if a sign-in type is used for authentication but is not enabled in the Entra sign-in identifiers policy, the authentication will fail at runtime. For example, a user may be assigned "User1234" but without enabling the Username sign-in identifier, the user will not be able to sign in with User1234.

## Step 4: Customize strings (optional)

You can customize the hint text of identifier field on the Sign in page via Company Branding.

To customize and localize various additional strings related to an End User's experience of Signing in with Username:

1. Go to External Identities | Languages
2. Select the Language and download the defaults
3. Upload a file that ONLY contains overrides for the strings you want to customize

Highlighted are the new strings that are related to username.
