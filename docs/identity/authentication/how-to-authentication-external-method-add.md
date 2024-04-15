---
title: Add an external authentication method to Microsoft Entra ID
description: Learn how to add an external authentication method to Entra ID


ms.service: entra-id
ms.subservice: authentication
ms.topic: conceptual
ms.date: 02/27/2024

ms.author: justinha
author: justinha
manager: amycolannino
ms.reviewer: gregkmsft, msgustavosa
---
# Add an external authentication method to Entra ID

External identity provider information will be stored in each tenant's authentication methods policy as an authentication method of externalAuthenticationMethodConfiguration type.  Each provider will have one entry in the list object of the policy, and per the authentication method framework, will have state of whether it’s enabled, include groups capable to use the method, and exclude groups that are not allowed to use the method.  

This authentication method will eventually be able to be included in authentication strengths, and then admins can use those authentication strengths as part of defining a Conditional Access policy requirement; this functionality will be added in the future.

The **ExternalAuthenticationMethodConfiguration** entry has the following members:

Member name | Description
------------|------------
Name | Name of the provider.  This is the name the user will see when they choose the method, and it cannot be changed after the method is added.
AppId | The provider app’s client id. This is the application identifier that was generated for the provider during its registration as an application in Entra ID. 
ClientId | The Entra ID’s client id. This is the identifier used by the provider to identify Entra ID. In OIDC parlance this is the client_id that external identity provider assigns to Entra ID, which is also a recipient of a token from the external identity provider.
DiscoveryUrl | This is the host url of the external identity provider’s [OIDC Discovery](http://openid.net/specs/openid-connect-discovery-1_0.html#ProviderConfig) endpoint. This endpoint must support the OIDC discovery process.

Each time Entra ID loads a ExternalAuthenticationMethodConfiguration entry, it will verify that the prefix of the **authorization_endpoint** retrieved through OIDC Discovery using the host url matches one of the reply URLs registered to the provider identified by the AppId. This verification ties the AppId to the HostUrl and ensures they go together.

## Add an external authentication method by using Miccrosoft Graph

To add the external authentication method, the customer admin will need the values listed in the previous section  (**ExternalAuthenticationMethodConfiguration**: Name, AppId, ClientId, and DiscoveryUrl) and will call the Microsoft Graph authentication methods policy endpoint to POST a new configuration. Note that the user will need the Policy.ReadWrite.AuthenticationMethod permission to manage this policy.

>[!IMPORTANT]
>The method will be targeted to all users when created unless specific include targets are specified during creation. For more information about how to get group IDs so that you can specify them in the method creation, see [Groups overview](/graph/api/resources/groups-overview).

>[!IMPORTANT]
>Users that are in scope for an external authentication method are considered MFA-capable during the initial preview.  If the user does not have other methods registered to satisfy second factor and the user is unable to use the method, for example because they have not yet registered the with the external provider, then the user will not be able to satisfy sign-ins requiring MFA.  This includes managing the security information for the user, such as registering additional authentication methods.
>
> Support for registration will be added during the preview.  When it is added, any users that have already been using the method will have to register the method with Entra ID.  If they do not have other methods registered to satisfy MFA, the user will need to register the method on next sign-in.  If the user has other methods, they will need to use MySignIns to register the method so that it is available to them again for satisfying MFA requirements.

Example post to create the method:

```json
POST https://graph.microsoft.com/beta/policies/authenticationMethodsPolicy/authenticationMethodConfigurations
{
  "@odata.type": "#microsoft.graph.externalAuthenticationMethodConfiguration",
  "displayName": "Adatum",
  "appId": "600b719b-3766-4dc5-95a6-3c4a8dc31885",
  "openIdConnectSetting": {
    "clientId": "06a011bd-ec92-4404-80fb-db6d5ada8ee2",
    "discoveryUrl": "https//Adatum.com/.well-known/openid-configuration"
  }
}

On success a 201 will be returned:
HTTP/1.1 201 CREATED
{
    "@odata.type": "#microsoft.graph.externalAuthenticationMethodConfiguration",
    "id": "b3107ab7-68c7-4553-a167-48c8c2c24d52",
    "displayName": "Adatum",
    "appId": "600b719b-3766-4dc5-95a6-3c4a8dc31885",
    "openIdConnectSetting": {
        "clientId": "06a011bd-ec92-4404-80fb-db6d5ada8ee2",
        "discoveryUrl": "https//Adatum.com/.well-known/openid-configuration"
    },
    "state": "disabled",
    "excludeTargets": []
}
```

## Add an external authentication method by using Entra admin center

To add the external authentication method, the customer admin will need the values listed previously (**ExternalAuthenticationMethodConfiguration**: Name, AppId, ClientId, and DiscoveryUrl). These values will be updated in the Entra admin center authentication methods policy (**Security** > **Authentication methods** > **Policies**), after selecting to add an external authentication method.

:::image type="content" source="./media/how-to-authentication-external-method-add/add-external-method.png" alt-text="Screenshot of how to add an external authentication method.":::

:::image type="content" source="./media/how-to-authentication-external-method-add/method-properties.png" alt-text="Screenshot of external method properties.":::

## Grant consent for the provider’s application

The administrator for the tenant must grant consent for the application represented by the AppID to be added to their tenant. This requires either Global Administrator or Privileged Role Administrator permissions. If the external authentication method is being added to the tenant via the Entra admin center, then the admin will be prompted to consent the application as part of adding the method, and will not be enabled until the app has the required permissions in the tenant. If the method is added via API, the admin will need to ensure that the method is not set to enabled until the application has been consented.

Providers can also create an experience that adds the multi-tenant application into the customer tenant and enables the admin to grant consent to the app. Admins should complete this step prior to adding the external authentication method in the Entra ID authentication methods policy.

## Get and update the external authentication method by using Microsoft Graph

Use the following call to get the configuration:

```json
GET  https://graph.microsoft.com/beta/policies/authenticationMethodsPolicy/authenticationMethodConfigurations/b3107ab7-68c7-4553-a167-48c8c2c24d52
HTTP/1.1 200 OK
{
  "@odata.type": "#microsoft.graph.externalAuthenticationMethodConfiguration",
  "id": "b3107ab7-68c7-4553-a167-48c8c2c24d52",
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

Changes to the authentication method can be made by using PATCH calls. You can change the include targets, the method state, or the openIdConnectSetting values. The displayName for the method can't be changed.

```json
PATCH https://graph.microsoft.com/beta/policies/authenticationMethodsPolicy/authenticationMethodConfigurations/b3107ab7-68c7-4553-a167-48c8c2c24d52
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

HTTP/1.1 204 NO 
```

Get now returns:

```json
HTTP/1.1 200 OK
{
  "@odata.type": "#microsoft.graph.externalAuthenticationMethodConfiguration",
  "id": "b3107ab7-68c7-4553-a167-48c8c2c24d52",
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

## Delete an external authentication method
If you no longer want your users to be able to use the external authentication method, you can either update the state to disabled as described previously, or you can delete the method. In the following example, the method is deleted by using Microsoft Graph:

```json
DELETE https://graph.microsoft.com/beta/policies/authenticationMethodsPolicy/authenticationMethodConfigurations/b3107ab7-68c7-4553-a167-48c8c2c24d52

HTTP/1.1 204 NO CONTENT
```

## Next steps

- [Entra ID interaction with provider](how-to-authentication-external-method-interaction.md)
