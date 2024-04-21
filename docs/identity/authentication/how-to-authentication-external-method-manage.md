---
title: How to manage an external authentication method in Microsoft Entra ID (Preview)
description: Learn how to manage an external authentication method for Microsoft Entra multifactor authentication


ms.service: entra-id
ms.subservice: authentication
ms.topic: conceptual
ms.date: 04/19/2024

ms.author: justinha
author: justinha
manager: amycolannino
ms.reviewer: gregkmsft, msgustavosa

# Customer intent: As an authentication administrator, I want learn how to manage an external authentication method for Entra ID.

---
# Manage an external authentication method in Microsoft Entra ID (Preview)

External authentication methods enable users to use an external provider when satisfying multifactor authentication requirements when signing in with Entra ID. External authentication methods enable users to satisfy MFA requirements from Conditional Access policies, Identity Protection sign-in risk policies, Privileged Identity Management (PIM) activation, and when the application itself requires MFA. 

External authentication methods differ from federation in that the user identity is originated and managed in Entra ID. With federation, the identity is managed in the external identity provider.

:::image type="content" source="./media/concept-authentication-external-method-provider/how-external-method-authentication-works.png" alt-text="Diagram of how external method authentication works.":::

## Required information from your external authentication provider
Before creating the method, you will need the following information from your external authentication provider:

- An **Application ID** is generally a multitenant application from your provider, which is used as part of the integration. You need to provide admin consent for this application in your tenant.
- A **Client ID** is an identifier from your provider used as part of the authentication integration to identify Entra ID requesting authentication.  
- A **Discovery URL** is the OIDC discovery endpoint for the external authentication provider. 
 

## Manage an external authentication method in the Microsoft Entra admin center

External authentication methods are managed with the Entra ID Authentication methods policy, just like built-in methods. 

### Create an EAM in the admin center

To create an external authentication method using the admin center, you will need the [required information from your external authentication provider](#required-information-from-your-external-authentication-provider). 

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Authentication Policy Administrator](~/identity/role-based-access-control/permissions-reference.md#authentication-policy-administrator).
1. Browse to **Protection** > **Authentication methods** > **Add external method (Preview)**.

   :::image type="content" border="true" source="./media/how-to-authentication-external-method-manage/add-external-method.png" alt-text="Screenshot of how to add an external authentication method in the Microsoft Entra admin center.":::

   Add method properties based on configuration information from your provider. For example:
   
   - Name: Adatum
   - Client ID: 06a011bd-ec92-4404-80fb-db6d5ada8ee2
   - Discovery Endpoint: `https://adatum.com/.well-known/openid-configuration`
   - App ID: 2f3d5a67-7441-4f1e-aa92-e77ca6b5a5ca

   >[!IMPORTANT]
   >The display name can't be changed after the method is created. Display names must be unique.

   :::image type="content" border="true" source="./media/how-to-authentication-external-method-manage/method-properties.png" alt-text="Screenshot of how to add an external authentication method properties.":::

   You need the Global Administrator or Privileged Role Administrator role to grant admin consent for the provider’s application. If you don't have the role required to grant consent, you can still save your authentication method, but you can't enable it until consent is granted.

   After you enter the values from your provider, press the button to request for admin consent to be granted to the application so that it can read the required info from the user to authenticate correctly. You're prompted to sign in with an account with admin permissions and grant the provider’s application with the required permissions.

   After you sign in, click **Accept** to grant admin consent:

   :::image type="content" border="true" source="./media/how-to-authentication-external-method-manage/permissions-requested.png" alt-text="Screenshot of how to grant admin consent.":::

   You can see the permissions the the provider application requests before you grant consent. After you grant admin consent and the change replicates, the page refreshes to show that admin consent was granted.

   :::image type="content" border="true" source="./media/how-to-authentication-external-method-manage/consent-granted.png" alt-text="Screenshot of Authentication methods policy after consent is granted.":::

If the app has permissions then you can also enable the method before saving. Otherwise, you need to save the method in a disabled state, and enable after the app is granted consent.

Once the method is enabled, all users in scope will see the method in the method picker for any MFA prompts. If the app from the provider doesn't have consent approved, then any authentications with the external authentication method fails.

### Configure an EAM in the admin center

To manage your external authentication methods in the Microsoft Entra admin center, open the Authentication methods policy. Select the method name to open the configuration options. You can choose which users are included and excluded from using this method. 

:::image type="content" border="true" source="./media/how-to-authentication-external-method-manage/target.png" alt-text="Screenshot of how to scope usage of the external authentication method for specific users.":::

### Delete an EAM in the admin center

If you no longer want your users to be able to use the external authentication method, you can either:

- Set **Enable** to **Off** to save the method configuration
- Click **Delete** to remove the method

:::image type="content" border="true" source="./media/how-to-authentication-external-method-manage/delete.png" alt-text="Screenshot of how to delete an external authentication method.":::

## Manage an external authentication method using Microsoft Graph

The next sections include examples for using Microsoft Graph to manage an EAM. 

### Create an EAM using Microsoft Graph

To create the external authentication method, you can use Microsoft Graph with the [required information from your external authentication provider](#required-information-from-your-external-authentication-provider), and the display name that you want for the method.  

To update the Authentication methods policy by using Microsoft Graph, you need the `Policy.ReadWrite.AuthenticationMethod` permission. For more information, see [Update authenticationMethodsPolicy](/graph/api/authenticationmethodspolicy-update).

Example post to create the method for all_users:

```json
POST https://graph.microsoft.com/beta/policies/authenticationMethodsPolicy/authenticationMethodConfigurations
{
  "@odata.type": "#microsoft.graph.externalAuthenticationMethodConfiguration",
  "displayName": "Adatum",
  "appId": "600b719b-3766-4dc5-95a6-3c4a8dc31885",
  "openIdConnectSetting": {
    "clientId": "06a011bd-ec92-4404-80fb-db6d5ada8ee2",
    "discoveryUrl": "https://adatum.com/.well-known/openid-configuration"
  }
}

On success, a 201 will be returned:
HTTP/1.1 201 CREATED
{
    "@odata.context": "https://graph.microsoft.com/beta/$metadata#authenticationMethodConfigurations/$entity",
    "@odata.type": "#microsoft.graph.externalAuthenticationMethodConfiguration",
    "id": "7313117c-bddf-4e92-82ea-d44a68019c4d",
    "state": "disabled",
    "displayName": "Adatum",
    "appId": "600b719b-3766-4dc5-95a6-3c4a8dc31885",
    "excludeTargets": [],
    "openIdConnectSetting": {
        "clientId": "06a011bd-ec92-4404-80fb-db6d5ada8ee2",
        "discoveryUrl": "https://adatum.com/.well-known/openid-configuration"
    }
}
```

Example post to create the method targeting to a specific group:

```json
POST https://graph.microsoft.com/beta/policies/authenticationMethodsPolicy/authenticationMethodConfigurations
{
  "@odata.type": "#microsoft.graph.externalAuthenticationMethodConfiguration",
  "displayName": "Adatum",
  "appId": "600b719b-3766-4dc5-95a6-3c4a8dc31885",
  "openIdConnectSetting": {
    "clientId": "06a011bd-ec92-4404-80fb-db6d5ada8ee2",
    "discoveryUrl": "https://adatum.com/.well-known/openid-configuration"
  },
  "includeTargets": [
      {
          "targetType": "group",
          "id": "b185b746-e7db-4fa2-bafc-69ecf18850dd",
          "isRegistrationRequired": false,
      }
  ]
}
```

On success, a 201 will be returned:

```json
HTTP/1.1 201 CREATED
{
    "@odata.type": "#microsoft.graph.externalAuthenticationMethodConfiguration",
    "id": "b3107ab7-68c7-4553-a167-48c8e9c24d52",
    "displayName": "Adatum",
    "appId": "600b719b-3766-4dc5-95a6-3c4a8dc31885",
    "openIdConnectSetting": {
        "clientId": "06a011bd-ec92-4404-80fb-db6d5ada8ee2",
        "discoveryUrl": "https//adatum.com/.well-known/openid-configuration"
    },
    "state": "disabled",
    "excludeTargets": []
}
```

### Get an EAM using Microsoft Graph

```json
GET  https://graph.microsoft.com/beta/policies/authenticationMethodsPolicy/authenticationMethodConfigurations/b3107ab7-68c7-4553-a167-48c8e9c24d52
HTTP/1.1 200 OK
{
  "@odata.type": "#microsoft.graph.externalAuthenticationMethodConfiguration",
  "id": "b3107ab7-68c7-4553-a167-48c8e9c24d52",
  "displayName": "Adatum",
  "appId": "fb263304-618c-4ffb-878a-1f4490bdf200",
  "openIdConnectSetting": {
      "clientId": "06a011bd-ec92-4404-80fb-db6d5ada8ee2",
      "discoveryUrl": "https//Adatum.com/.well-known/openid-configuration"
  },
  "state": "disabled",
  "excludeTargets": [],
  "includeTargets": []
}
```
### Update an EAM using Microsoft Graph

Changes to the authentication method can be made by using PATCH calls.  You can change the include targets, the method state, or the openIdConnectSetting values. The displayName for the method can't be changed.

```json
PATCH https://graph.microsoft.com/beta/policies/authenticationMethodsPolicy/authenticationMethodConfigurations/b3107ab7-68c7-4553-a167-48c8e9c24d52
{
  "@odata.type": "#microsoft.graph.externalAuthenticationMethodConfiguration",
  "includeTargets": [
    {
        "targetType": "group",
        "id": "b185b746-e7db-4fa2-bafc-69ecf18850dd",
        "isRegistrationRequired": false,
    }
  ],
  "state": "enabled"
}

HTTP/1.1 204 NO CONTENT
```

Get now returns:

```json
HTTP/1.1 200 OK
{
  "@odata.type": "#microsoft.graph.externalAuthenticationMethodConfiguration",
  "id": "b3107ab7-68c7-4553-a167-48c8e9c24d52",
  "displayName": "Adatum",
  "appId": "fb263304-618c-4ffb-878a-1f4490bdf200",
  "openIdConnectSetting": {
      "clientId": "06a011bd-ec92-4404-80fb-db6d5ada8ee2",
      "discoveryUrl": "https//Adatum.com/.well-known/openid-configuration"
  },
  "state": "enabled",
  "includeTargets": [
      {
          "targetType": "group",
          "id": "b185b746-e7db-4fa2-bafc-69ecf18850dd",
          "isRegistrationRequired": false,
      }
  ],
  "excludeTargets": []
}
```

### Disable an EAM using Microsoft Graph

If you no longer want your users to be able to use the external authentication method, you can either update the state to disabled as described previously, or you can delete the method. In the following example, the method is deleted by using Microsoft Graph:

```json
DELETE https://graph.microsoft.com/beta/policies/authenticationMethodsPolicy/authenticationMethodConfigurations/b3107ab7-68c7-4553-a167-48c8e9c24d52

HTTP/1.1 204 NO CONTENT
```

## User experience

Users who are enabled for the external authentication method can use it when they sign-in and multifactor authentication is required. 

If the user has other ways to sign in and [system-preferred MFA](/entra/identity/authentication/concept-system-preferred-multifactor-authentication) is enabled, those other methods appear by default order. The user can choose to use a different method, and then select the external authentication method.

:::image type="content" border="true" source="./media/how-to-authentication-external-method-manage/system-preferred.png" alt-text="Screenshot of how to choose an external authentication method when system-preferred MFA is enabled.":::


If the user has no other methods enabled, the user can just choose the external authentication method. They're redirected to the external authentication provider to complete authentication.

:::image type="content" border="true" source="./media/how-to-authentication-external-method-manage/sign-in.png" alt-text="Screenshot of how to sign in with an external authentication method.":::

## Using EAM and Conditional Access custom controls in parallel

External authentication methods and custom controls can operate in parallel. Microsoft recommends that admins configure two Conditional Access policies: one with the custom control enforced and the second with the MFA grant required. Use include targets to scope the policy to a test group of users.  

Include users in one of the two policies, but not both. If the user is in scope for both policies, or if you configure a Conditional Access policy that requires both MFA grant and a custom control, the user has to satisfy MFA during sign-in. They also have to satisfy the custom control, and they're redirected to the external provider a second time.

## Next steps

For more information about how to manage authentication methods, see [Manage authentication methods for Microsoft Entra ID](/entra/identity/authentication/concept-authentication-methods-manage).

For external authentication method provider reference, see [Microsoft Entra multifactor authentication external method provider reference (Preview)](concept-authentication-external-method-provider.md).
