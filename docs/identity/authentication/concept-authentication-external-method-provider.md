---
title: Microsoft Entra multifactor authentication external method provider reference (Preview)
description: Learn how to configure an external authentication method (EAM) provider for Microsoft Entra multifactor authentication


ms.service: entra-id
ms.subservice: authentication
ms.topic: conceptual
ms.date: 04/27/2024

ms.author: justinha
author: gregkmsft
manager: amycolannino
ms.reviewer: gkinasewitz, gustavosa

# Customer intent: As an external identity provider (IdP) for Microsoft Entra ID, I want to learn how to configure an external authentication method (EAM) for Entra ID tenants.

---
# Microsoft Entra multifactor authentication external method provider reference (Preview)

This topic describes how an external authentication provider connects to Microsoft Entra multifactor authentication (MFA). An external authentication provider can integrate with Entra ID tenants as an external authentication method (EAM). An EAM can satisfy the second factor of an MFA requirement for access to a resource or application.  

When a user signs in, that tenant policies are evaluated. The authentication requirements are determined based on the resource that the user tries to access. 

Multiple policies may apply to the sign-in, depending on their parameters. Those parameters include users and groups, applications, platform, sign-in risk level, and more. 

Based on the authentication requirements, the user may need to sign in with another factor to meet the MFA requirement. The second factor needs to complement the type of first factor. 

EAMs are added to Entra ID by the tenant admin. If a tenant requires an EAM for MFA, the sign-in is considered to meet the MFA requirement after Entra ID validates both:

- The first factor completed with Entra ID <!---completed with a built-in method in Entra ID?--->
- The second factor completed with the EAM

That validation meets the MFA requirement for two or more types of methods from:

- Something you know
- Something you have
- Something you are

EAMs are implemented on top of Open ID Connect (OIDC). This implementation requires at least three publicly facing endpoints: 

- An OIDC Discovery endpoint, as described in [Discovery of provider metadata](#discovery-of-provider-metadata)
- A valid OIDC authentication endpoint
- A URL where the public certificates of the provider are published

Let's look closer at how sign-in works with an EAM:

1. The user tries to sign in with a first factor, like a password, to an application protected by Entra ID.
1. Entra ID determines that another factor needs to be satisfied. For example, a Conditional Access policy requires MFA.
1. The user chooses the EAM as a second factor.
1. Entra ID redirects the user's browser session to the EAM URL:
   1. This URL is discovered from the discovery URL provisioned by an admin when they created the EAM.
   1. The application provides an expired or nearly expired token that contains information to identify the user and tenant.
1. The external authentication provider validates that the token came from Entra ID, and checks the contents of the token.
1. The external authentication provider might optionally make a call to Microsoft Graph to fetch additional information about the user.
1. The external authentication provider performs any actions it deems necessary, such as authenticating the user with some credential.
1. The external authentication provider redirects the user back to Entra ID with a valid token, including all required claims.
1. Entra ID validates that the token's signature came from the configured external authentication provider, and then checks the contents of the token.
1. Entra ID validates the token against the requirements.
1. If the validation succeeds, the user satisfied the MFA requirement. The user might also have to meet other policy requirements.

:::image type="content" source="./media/concept-authentication-external-method-provider/how-external-method-authentication-works.png" alt-text="Diagram of how external method authentication works.":::

## Configure a new external authentication provider with Microsoft Entra ID

An application representing the integration is required for EAMs to issue the id_token_hint. The application can be created in two ways:

- Created in each tenant that uses the external provider. 
- Created as one multi-tenant application. Privileged Role Administrators need to grant consent to enable the integration for their tenant.  

A multi-tenant application reduces the chance of misconfiguration in each tenant. It also lets providers make changes to metadata like reply URLs in one place, rather than require each tenant to make the changes. 

To configure a multi-tenant application, the provider admin must first:

1. Create an Entra ID tenant if they don't have one yet.
1. Using that tenant, register an application in Entra ID. 
1. Set the Supported Account types of the application to: Accounts in any organizational directory (Any Microsoft Entra ID tenant - Multitenant). 
1. Add the delegated permission `openid` and profile of Microsoft Graph to the application.
1. Don't publish any scopes in this application. 
1. Add the external identity provider’s valid authorization_endpoint URLs to that application as Reply URLs. 
   
   >[!NOTE]
   >The authorization_endpoint provided in the provider’s discovery document should be added as a redirect url in the application registration. 
   >Otherwise, you get the following error:
   >*ENTRA IDSTS50161: Failed to validate authorization url of external claims provider!*

The application registration process creates an application with several properties. These properties are required for our scenario.

Property | Description
---------|------------
Object Id | The provider can use the object ID with Microsoft Graph to query the application information. <br>The provider can use the object ID to programmatically retrieve and edit the application information.
Application ID | The provider can use the application ID as the ClientId of their application.
Home page URL | The provider home page URL isn't used for anything, but is required as part of application registration.
Reply URLs | Valid redirect URLs for the provider. One should match the provider host URL that was set for the provider’s Entra ID tenant. One of the reply URLs registered must match the prefix of the authorization_endpoint that Entra ID retrieves through OIDC discovery for the host url.

An application for each tenant is also a valid model to support the integration. If you use a single-tenant registration, the tenant admin needs to create an application registration with the properties in the preceding table for a single-tenant application.

>[!NOTE]
>Admin consent for the application is required in the tenant that uses the EAM. If consent isn't granted, the following error appears when an admin tries to use the EAM:
>AADSTS900491: Service principal \<your App ID> not found.

### Configure optional claims

A provider can configure more claims by using [optional claims for id_token](/entra/identity-platform/optional-claims).

>[!NOTE]
>Regardless of how the application is created, the provider needs to configure optional claims for each cloud environment. If a multi-tenant application is used for public Azure and Azure for US Government, each cloud environment requires a different application and application ID.

##  Add an EAM to Entra ID

External identity provider information is stored in the Authentication methods policy of each tenant. The provider information is stored as an authentication method of externalAuthenticationMethodConfiguration type. 

Each provider has one entry in the list object of the policy. Each entry needs to state:

- If the method is enabled
- The included groups that can use the method
- The excluded groups that can't use the method

Conditional Access Administrators can create a policy with the Require MFA Grant to set the MFA requirement for user sign-in. External authentication methods aren't currently supported with authentication strengths.

For more information about how to add an external authentication method in the Microsoft Entra admin center, see [Manage an external authentication method in Microsoft Entra ID (Preview)](how-to-authentication-external-method-manage.md).

## Entra ID interaction with provider

The next sections explain provider requirements and include examples for Entra ID interaction with a provider.

### Discovery of provider metadata 

An external identity provider needs to provide an [OIDC Discovery endpoint](http://openid.net/specs/openid-connect-discovery-1_0.html#ProviderConfig). This endpoint is used to get more configuration data. The *full* URL, including .*well-known*/*oidc-configuration*, must be included in the Discovery URL configured when the EAM is created. The endpoint returns a Provider Metadata [JSON document](http://openid.net/specs/openid-connect-discovery-1_0.html#ProviderMetadata) hosted there. The endpoint must also return the valid content-length header.

The following table lists the data that should be present in the metadata of the provider. These values are required for this extensibility scenario. The JSON metadata document may contain more information. 
For the OIDC document with the values for Provider Metadata, see [Provider Metadata](http://openid.net/specs/openid-connect-discovery-1_0.html#ProviderMetadata).


Metadata value	       | Value  | Comments
-----------------------|--------|----------
Issuer                 |        | This URL should match both the host URL used for discovery and the iss claim in the tokens issued by the provider’s service.
authorization_endpoint |        | The endpoint that Entra ID communicates with for authorization. This endpoint must be present as one of the reply URLs for the allowed applications.
jwks_uri               |        | Where Entra ID can find the public keys needed to verify the signatures issued by the provider. <br>[!NOTE]<br>The JSON WEb Key (JWK) **x5c** parameter must be present to provide X.509 representations of keys provided.
scopes_supported       | openid | Other values may also be included but aren't required.
response_types_supported | id_token | Other values may also be included but aren't required.
subject_types_supported	 |  |
id_token_signing_alg_values_supported | | Microsoft supports RS256
claim_types_supported | normal | This property is optional but if present, it should include the normal value; other values may also be included.


```json
http://customcaserver.azurewebsites.net/v2.0/.well-known/openid-configuration
{
  "authorization_endpoint": "https://customcaserver.azurewebsites.net/api/Authorize",
  "claims_supported": [
    "email"
  ],
  "grant_types_supported": [
    "implicit"
  ],
  "id_token_signing_alg_values_supported": [
    "RS256"
  ],
  "issuer": "https://customcaserver.azurewebsites.net",
  "jwks_uri": "http://customcaserver.azurewebsites.net/.well-known/jwks",
  "response_modes_supported": [
    "form_post"
  ],
  "response_types_supported": [
    "id_token"
  ],
  "scopes_supported": [
    "openid"
  ],
  "SigningKeys": [],
  "subject_types_supported": [
    "public"
  ]
}

http://customcaserver.azurewebsites.net/.well-known/jwks
{
  "keys": [
    {
      "kty": "RSA",
      "use": "sig",
      "kid": "CEYm9GmLvfIqrl0zBJc9-Chk_LM",
      "x5t": "CEYm9GmLvfIqrl0zBJc9-Chk_LM",
      "n": "jq277LRoE6WKM0awT3b-—redacted--vt8J6MZvmgboVB9S5CMQ",
      "e": "AQAB",
      "x5c": [
        "cZa3jEzEd0nvztzAVM6Uy—redacted--Z0HBHjTZq9IWiPHSWo0rzA="
      ]
    }
  ]
}
```

>[!NOTE]
>The JWK **x5c** parameter must be present to provide X.509 representations of keys provided.

#### Provider metadata caching

To improve performance, Entra ID caches metadata returned by the provider, including the keys. Provider metadata caching prevents a discovery call each time Entra ID talks to an external identity provider.

This cache is refreshed every 24 hrs (1 day). Here's how we suggest a provider roll over their keys: 

1. Publish the **Existing Cert** and **New Cert** in the "jwks_uri".
1. Keep signing with **Existing Cert** until Entra ID cache is refreshed,expired, or updated (every 2 days).
1. Switch to signing with **New Cert**.

We don't publish schedules for key rollovers. The dependent service must be prepared to handle both immediate and periodic rollovers. We suggest using a dedicated library built for this purpose, like [azure-activedirectory-identitymodel-extensions-for-dotnet](https://github.com/AzureAD/azure-activedirectory-identitymodel-extensions-for-dotnet). For more information, see [Signing key rollover in Entra ID](/azure/active-directory/develop/active-directory-signing-key-rollover).

#### Discovery of Entra ID metadata

Providers also need to retrieve the public keys of Entra ID to validate the tokens issued by Entra ID.

Entra ID metadata discovery endpoints:

- Public Azure: `https://login.microsoftonline.com/common/v2.0/.well-known/openid-configuration`
- Azure for US Government: `https://login.microsoftonline.us/common/v2.0/.well-known/openid-configuration`
- Microsoft Azure operated by 21Vianet (Azure in China): `https://login.partner.microsoftonline.cn/common/v2.0/.well-known/openid-configuration`


Using the public key identifier from the token ([the "kid" from JSON Web Signature (JWS)](https://tools.ietf.org/html/rfc7515#section-4.1.4)), one can determine which of the keys retrieved from the jwks_uri property should be used to validate the Entra ID token signature.

#### Validating tokens issued by Entra ID

For information about how to validate the tokens issued by Entra ID, see [Validating and ID token](/entra/identity-platform/id-tokens#validating-an-id_token). There are no special steps for the consumers of our discovery metadata. 

Microsoft’s [token validation library](https://github.com/AzureAD/azure-activedirectory-identitymodel-extensions-for-dotnet/wiki) has all the details on the specifics of token validation that are documented, or they can be ascertained from browsing the source code. For a sample, see [Azure Samples](https://github.com/Azure-Samples/active-directory-dotnet-webapi-manual-jwt-validation).

Once validation succeeds, you can work with the claims payload to get details of the user and the tenant they belong to.

### Entra ID call to the external identity provider

Entra ID uses the [OIDC implicit flow](http://openid.net/specs/openid-connect-core-1_0.html#ImplicitFlowAuth) to communicate with the external identity provider. Using this flow, communication with the provider is done exclusively by using the provider's authorization endpoint. To let the provider know the user for whom Entra ID is making the request, Entra ID passes a token in through the [id_token_hint](http://openid.net/specs/openid-connect-core-1_0.html#AuthRequest) parameter.

This call is made through a POST request, as the list of parameters passed to the provider is large and this prevents the use of browsers that limit the length of a GET request.

The Authentication request parameters are listed in the following table.

>[!NOTE]
>Unless they're listed in the following table, other parameters in the request should be ignored by the provider.

| Authentication Query Parameter | Value  | Description |
|--------------------------------|--------|-------------|
|scope                           | openid |             |
|response_type                   | Id_token |The value used for the implicit flow. |
|response_mode                   | form_post | We’ll use form post to avoid issues with large URLs. We expect all the parameters to be sent in the body of the request.|
|client_id                       |        | The client ID given to Entra ID by the external identity provider, such as "ABCD". For more information, see [External authentication method description](#add-an-eam-to-entra-id).|
|redirect_url                    |        | The redirection Uniform Resource Identifier (URI) to which the response (id_token_hint) is sent by the external identity provider.
See an [example](#example-of-a-redirection-uri) after this table. |
| nonce |               | A random string generated by Entra ID. It can be the session ID. If provided, it needs to be returned in the response back to Entra ID. |
| state	|               | If passed in, the provider should return state in its response. Entra ID uses state to keep context about the call. |
| id_token_hint |        | A token issued by Entra ID for the end user, and passed in for the benefit of the provider. |
|claims	|                | A JSON blob that contains the claims requested. For details about the format of this parameter, see [claims request parameter](http://openid.net/specs/openid-connect-core-1_0.html#ClaimsParameter) from the OIDC documentation and an [example](#example-of-an-eam-that-satisfies-mfa) after this table.|
|client-request-id |  A GUID value | A provider can log this value to help troubleshoot problems.|

#### Example of a redirection URI

<input type="hidden" name="redirect_uri" 
value="https://login.microsoftonline.com/common/federation/externalauthprovider" />

This should have been registered with the provider off-band. The redirect URIs that can be sent are:

- Public Azure: `https://login.microsoftonline.com/common/federation/externalauthprovider`
- Azure for US Government: `https://login.microsoftonline.us/common/federation/externalauthprovider`
- Microsoft Azure operated by 21Vianet (Azure in China): `https://login.partner.microsoftonline.cn/common/federation/externalauthprovider`


#### Example of an EAM that satisfies MFA

Here is an example of this (decoded) for an authentication where an EAM satisfies MFA. This example helps a provider know what claims Entra ID expects.  

The combination of the `acr` and `amr` values are used by Entra ID to validate:

- The authentication method used for second factor satisfies the MFA requirement
- The authentication method differs in 'type' from the method used to complete the first factor for sign-in to Entra ID

```json
{
  "id_token": {
    "acr": {
      "essential": true,
      "values":["possessionorinherence"]
    },
    "amr": {
      "essential": true,
      "values": ["face", "fido", "fpt", "hwk", "iris", "otp", "pop", "retina", "sc", "sms", "swk", "tel", "vbm"]
    }
  }
}
```

#### Default Id_token_hint claims

This section describes the required content of the token passed as id_token_hint in the request made to the provider. The token may contain more claims than in the following table.

| Claim |Value | Description |
|-------|------|-------------|
|iss    |      | Identifies the security token service (STS) that constructs and returns the token, and the Entra ID tenant in which the user authenticated. Your app should use the GUID portion of the claim to restrict the set of tenants that can sign in to the app, if applicable. Issuer should match the issuer URL from the OIDC discovery JSON metadata for the tenant where the user signed in.|
| aud   |        | The audience should be set to the external identity provider’s client ID for Entra ID.|
|exp    |        | The expiration time is set to expire a short time after the issuing time, sufficient to avoid time skew issues. Because this token is not meant for authentication, there's no reason for its validity to outlast the request by much. |
|iat    |        | Set issuing time as usual.|
|tid    |        | The tenant ID is for advertising the tenant to the provider. It represents the Entra ID tenant that the user is from. |
|oid    |        | The immutable identifier for an object in the Microsoft identity platform. In this case, it's a user account. It can also be used to perform authorization checks safely, and as a key in database tables. This ID uniquely identifies the user across applications. Two different applications that sign in the same user receive the same value in the oid claim. Thus, oid can be used in queries to Microsoft online services, such as Microsoft Graph. |
| preferred_username |        | Provides a human readable value that identifies the subject of the token. This value is not guaranteed to be unique within a tenant, and is designed to be used only for display purposes. |
| sub  |            | Subject identifier for the end user at the Issuer. The principal about which the token asserts information, such as the user of an application. This value is immutable and can't be reassigned or reused. It can be used to perform authorization checks safely, such as when the token is used to access a resource, and can be used as a key in database tables. Because the subject is always present in the tokens that Entra ID issues, we recommend using this value in a general-purpose authorization system. The subject is, however, a pairwise identifier; it's unique to a particular application ID. *Therefore, if a single user signs in to two different applications using two different client IDs, those applications receive two different values for the subject claim*. This may or may not be desired, depending on your architecture and privacy requirements. See also the **oid** claim (which does remain the same across apps within a tenant).| 

To prevent the token for being used for anything else other than a hint, it's issued as expired. The token is signed, and can be verified using the published Entra ID discovery metadata.

#### Optional claims from Entra ID

If a provider needs optional claims from Entra ID then you can configure these optional claims for id_token. For more information, see [Optional claims](/azure/active-directory/develop/optional-claims).

#### Recommended use of claims
Microsoft recommends associating accounts on the provider side with the account in Azure AD by using the oid and tid claims. These two claims are guaranteed to be unique for the account in the tenant. 

#### Example of an id_token_hint

An example of an id_token_hint for a directory member is provided below.

```json
{
  "typ": "JWT",
  "alg": "RS256",
  "kid": "7_Zuf1tvkwLxYaHS3q6lUjUYIGw"
}.{
  "ver": "2.0",
  "iss": "https://login.microsoftonline.com/9122040d-6c67-4c5b-b112-36a304b66dad/v2.0",
  "sub": "mBfcvuhSHkDWVgV72x2ruIYdSsPSvcj2R0qfc6mGEAA",
  "aud": "600b719b-3766-4dc5-95a6-3c4a8dc31885",
  "exp": 1536093790,
  "iat": 1536093791,
  "nbf": 1536093791,
  "name": "Test User 2",
  "preferred_username": "testuser2@contoso.com"
  "oid": "951ddb04-b16d-45f3-bbf7-b0fa18fa7aee",
  "tid": "14c2f153-90a7-4689-9db7-9543bf084dad"
  }.

```

Here's an example of the id_token hint for a guest user in the tenant:

```json
{
  "typ": "JWT",
  "alg": "RS256",
  "kid": "7_Zuf1tvkwLxYaHS3q6lUjUYIGw"
}.{
  "ver": "2.0",
  "iss": "https://login.microsoftonline.com/9122040d-6c67-4c5b-b112-36a304b66dad/v2.0",
  "sub": "mBfcvuhSHkDWVgV72x2ruIYdSsPSvcj2R0qfc6mGEAA",
  "aud": "600b719b-3766-4dc5-95a6-3c4a8dc31885",
  "exp": 1536093790,
  "iat": 1536093791,
  "nbf": 1536093791,
  "name": "External Test User (Hotmail)",
  "preferred_username": "externaltestuser@hotmail.com",
  "oid": "951ddb04-b16d-45f3-bbf7-b0fa18fa7aee",
  "tid": "14c2f153-90a7-4689-9db7-9543bf084dad"
  }.


```


#### Suggested actions for external identity providers

We suggest that external identity providers complete these steps. The list isn't exhaustive, and providers should complete other validation steps as they see fit. 

1. From the request:
   - Ensure that the redirect_uri is published provided in [Entra ID call to the external identity provider](#entra-id-call-to-the-external-identity-provider).
   - Ensure that the client_id has a value assigned to Entra ID, such as *ABCD*.
   - The provider should first [validate](/entra/identity-platform/id-tokens#validating-an-id_token) the id_token_hint that is presented to it by Entra ID.
1. From the claims in the id_token_hint:
   - They can (optionally) make a call to [Microsoft Graph](https://graph.microsoft.com/) to fetch additional details about this user. The **oid** and **tid** claims in the id_token_hint is useful in this regard. For details about the claims provided in the id_token_hint, see [Default id_token_hint claims](#default-id_token_hint-claims).
1. Then carry out whatever additional authentication activity that the provider’s product is built to do.
1. Depending upon the result of user’s actions and other factors, the provider would then construct and send a response back to Entra ID as explained below.

####	Entra ID processing of the provider response

The provider needs to POST a response back to the **redirect_uri**. The following parameters should be provided on a successful response:

Parameter | Value | Description
----------|-------|------------
id_token  |       | The token issued by the external identity provider.
state     |       | The same state that was passed in the request, if any. Otherwise, this should not be present.

On success, the provider would then issue an id_token for the user. Entra ID uses the published OIDC metadata to verify that the token contains the expected claims, and does any other validation of the token that OIDC requires.

Claim | Value | Description
------|-------|------------
iss   |       | Issuer – must match the issuer from the provider’s discovery metadata.
aud   |       | Audience – the Entra ID client ID. See client_id in [Entra ID call to the external identity provider](#entra-id-call-to-the-external-identity-provider).
exp   |       | Expiration time – set as usual.
iat   |       | Issuing time – set as usual.
sub   |       | Subject – must match the sub from the id_token_hint sent to initiate this request.
nonce |       | The same nonce that was passed in the request.
acr   |       | The acr claims for the authentication request. This should match one of the values from the request sent to initiate this request. Only one acr claim should be returned. For the list of claims, see [Supported acr claims](#supported-acr-claims).
amr   |       | The amr claims for the authentication method used in authentication. This should be returned as an array and only one method claim should be returned.	For the list of claims, see [Supported amr claims](#supported-amr-claims).


##### Supported acr claims

Claim | Notes 
------|------
possessionorinherence | Authentication must take place with a possession or inherence based factor.
knowledgeorpossession | Authentication must take place with a knowledge or possession based factor.
knowledgeorinherence | Authentication must take place with a knowledge or inherence based factor.
knowledgeorpossessionorinherence | Authentication must take place with a knowledge or possession or inherence based factor.
knowledge | Authentication must take place with knowledge based factor.
possession | Authentication must take place with possession based factor.
inherence| Authentication must take place with inherence based factor.

##### Supported amr claims


Claim | Notes
------|------
face | Biometric with facial recognition
fido | FIDO2 was used
fpt | Biometric with fingerprint
hwk | Proof of possession of hardware-secured key
iris | Biometric with iris scan
otp | One time password
pop | Proof of possession
retina | Biometric of retina scan
sc | Smart card
sms | Confirmation by text to registered number
swk | Confirmation of presence of a software secured key
tel | Confirmation by telephone 
vbm | Biometric with voiceprint

Because Entra ID requires MFA to be satisfied to issue a token with MFA claims, only methods with a different type (something you have (possession), something you know (knowledge), something you are (inherence)), can be used to satisfy the second factor.

Entra ID validates the type mapping based on the following table.

| Claim Method | Type | Notes |
|--------------|------|-------|
|face |Inherence | Biometric with facial recognition |
|fido |Possession | FIDO2 was used. Some implementations may also require biometric but as possession is the primary security attribute, that is the method type that is mapped.|
|fpt |Inherence | Biometric with fingerprint |
|hwk | Possession | Proof of possession of hardware-secured key |
|iris | Inherence  | Biometric with iris scan |
|otp | Possession | One-time password |
|pop | Possession | Proof of possession |
|retina | Inherence | Biometric of retina scan |
|sc | Possession | Smart card |
|sms |Possession | Confirmation by SMS to registered number|
|swk | Possession | Proof of presence of a software secured key
|tel |Possession | Confirmation by telephone |
|vbm |Inherence | Biometric with voiceprint |


If no issues are found with the token, then Entra ID considers MFA to be satisfied, and issues a token to the end user. Otherwise, the end user’s request fails.

Failure is indicated by issuing error response parameters.

Parameter | Value | Description
----------|-------|-------------
Error |           | An ASCII error code, such as access_denied or temporarily_unavailable. |


Entra ID considers the request successful if the id_token parameter is present in the response, and if the token is valid. Otherwise, the request is considered unsuccessful. Entra ID fails the original authentication attempt due to requirement of the Conditional Access policy.

Entra ID abandons the state of the authentication attempt on its end approximately 10 minutes after the redirection has occurred to the provider.

## Entra ID error response handling

Services in Microsoft Azure platform use a correlationId to correlate calls across various internal and external systems. It serves as a common identifier of the whole operation (or flow) potentially involving multiple HTTP calls. When an error occurs during any of the operations, the response contains a field named Correlation Id.

When reaching out to Microsoft support or similar service, please provide the value of this CorrelationId as it helps to access the telemetry and logs faster.

For example:

ENTRA IDSTS70002: Error validating credentials. ENTRA IDSTS50012: External ID token from issuer 'https://sts.XXXXXXXXX.com/auth/realms/XXXXXXXXXmfa' failed signature verification. KeyID of token is 'Rk3vlP4vD3OMJzBvrig81pnvaMqA'
Trace ID: 01c2cd09-8997-45bf-bfe4-18fdf9d1a101
**Correlation ID**: 72826bb4-abb7-4221-b253-100f530b4b0a
Timestamp: 2023-07-24 16:51:34Z


## Custom controls and EAMs

In Entra ID, EAMs and Conditional Access custom controls can operate in parallel while customers prepare for and migrate to EAMs.

Customers who currently use an integration with an external provider by using custom controls can continue to use them, and any Conditional Access policies they configured to manage access. Admins are recommended to create a parallel set of Conditional Access policies during the migration period:

- The policies should use the **Require multifactor authentication** grant control instead of the custom control grant.  

   >[!NOTE]
   >Grant controls based on authentication strengths, including the built-in MFA strength, aren't satisfied by the EAM. Policies should only be configured with **Require multifactor authentication**. We're actively working to support EAMs with authentication strengths.

- The new policy can be tested first with a subset of users. The test group would be excluded from the policy that requires the custom controls, and included in the policy that requires MFA. Once the admin is comfortable that the policy that requires MFA is satisfied by the EAM, the admin can include all required users in the policy with the MFA grant, and the policy configured for custom controls can be moved to **Off**. 

## Integration support

If you have any issues when you build EAM integration with Entra ID, the Microsoft Customer Experience Engineering (CxE) Independent Solution Vendor (ISV) may be able to assist. To engage with the CxE ISV team, submit a [request for assistance](https://aka.ms/EAMProviderSupport).

## References

- [OAuth2.0 and OIDC specification](https://oauth.net/2/)

## Glossary

Term | Description
-----|------------
MFA  | Multifactor authentication.
EAM  | An external authentication method is an authentication method from a provider other than Entra ID that is used as part of authenticating a user.
OIDC | Open ID Connect is an authentication protocol based on OAuth 2.0.
600b719b-3766-4dc5-95a6-3c4a8dc31885 | An example of an appid integrated for an external authentication method.

## Next steps

For more information about how to configure an EAM in [Microsoft Entra admin center](https://entra.microsoft.com), see [Manage an external authentication method in Microsoft Entra ID (Preview)](how-to-authentication-external-method-manage.md).
