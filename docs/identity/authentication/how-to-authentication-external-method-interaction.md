---
title: Entra ID interaction with provider
description: Learn about Entra ID interaction with provider


ms.service: entra-id
ms.subservice: authentication
ms.topic: conceptual
ms.date: 02/27/2024

ms.author: justinha
author: justinha
manager: amycolannino
ms.reviewer: gregkmsft, msgustavosa
---
# Entra ID interaction with provider

## Discovery of provider metadata 

An external identity provider will need to provide an [OIDC Discovery endpoint](http://openid.net/specs/openid-connect-discovery-1_0.html#ProviderConfig). This endpoint will be used to retrieve additional configuration data. The *full* URL, including .*well-known*/*oidc-configuration*, must be included in the Discovery URL configured when creating the external authentication method. The endpoint will return a Provider Metadata [JSON document](http://openid.net/specs/openid-connect-discovery-1_0.html#ProviderMetadata) hosted there. The endpoint must also return the valid content-length header.

The following table lists the data that should be present in the metadata of the provider. The JSON metadata document may contain additional information in addition to these fields that are required for this extensibility scenario.
The OIDC document specifying the values for Provider Metadata can be found at [Provider Metadata](http://openid.net/specs/openid-connect-discovery-1_0.html#ProviderMetadata).


Metadata value	       | Value  | Comments
-----------------------|--------|----------
Issuer                 |        | This URL should match both the host url used for discovery and the iss claim in the tokens issued by the provider’s service.
authorization_endpoint |        | The endpoint that Entra ID will communicate with for authorization. This endpoint must be present as one of the reply Urls for the allowed apps.
jwks_uri               |        | This tells us where Entra ID can find the public keys needed to verify the signatures issued by the provider. <br>NOTE: The JWK x5c parameter must be present to provide X.509 representations of keys provided.
scopes_supported       | openid | Other values may be included as well but not required.
response_types_supported | id_token | Other values may be included as well but not required.
subject_types_supported	 |  |
id_token_signing_alg_values_supported | | Microsoft supports RS256
claim_types_supported | normal | This property is optional but if present, it should include the normal value; other values may be included as well.


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

### Provider’s metadata caching

To prevent Entra ID from making a discovery call each time it talks to an external identity provider, Entra ID will cache the provider’s metadata returned, including the keys, for performance reasons. 

This cache is refreshed every 24 hrs. (1 day). The suggested flow for the provider to rollover their keys is as follows: 

1. Publish the **Existing Cert** and **New Cert** in the "jwks_uri".
1. Keep signing with **Existing Cert**, until Entra ID cache is refreshed/expired/updated (every 2 days).
1. Switch to signing with **New Cert**.

We do not publish schedules for key rollovers. The dependent service must be prepared to handle both immediate and periodic rollovers. We suggest using a dedicated library built for this purpose, like [azure-activedirectory-identitymodel-extensions-for-dotnet](https://github.com/AzureAD/azure-activedirectory-identitymodel-extensions-for-dotnet). For more information, see [Signing key rollover in Entra ID](/azure/active-directory/develop/active-directory-signing-key-rollover).

### Discovery of Entra ID metadata

Equivalent to Entra ID using the discovery process to retrieve the public keys necessary to verify the signatures of the tokens issued by providers, those providers also need to retrieve the public keys of Entra ID for validating the tokens issued by Entra ID.

Entra ID’s metadata discovery endpoints:

- Public Azure: `https://login.microsoftonline.com/common/v2.0/.well-known/openid-configuration`
- Azure for US Government: `https://login.microsoftonline.us/common/v2.0/.well-known/openid-configuration`
- Azure China 21Vianet: 


Using the public key identifier from the token ([the “kid” from JWS](https://tools.ietf.org/html/rfc7515#section-4.1.4)), one can determine which of the keys retrieved from the jwks_uri property should be used for validating the Entra ID token signature.

### Validating tokens issued by Entra ID

For information about how to validate the tokens issued by Entra ID, see [Validating and ID token](https://docs.microsoft.com/azure/active-directory/develop/id-tokens#validating-an-id_token). There are no special steps for the consumers of our discovery metadata. 

Microsoft’s [token validation library](https://github.com/AzureAD/azure-activedirectory-identitymodel-extensions-for-dotnet/wiki) has all the details on the specifics of token validation that have either been documented or can be ascertained from browsing the source code. For a sample, see [Azure Samples](https://github.com/Azure-Samples/active-directory-dotnet-webapi-manual-jwt-validation).

Once validation succeeds, you can work with the claims payload to get details of the user and the tenant they belong to.

## Entra ID call to the external identity provider

Entra ID will use the [OIDC implicit flow](http://openid.net/specs/openid-connect-core-1_0.html#ImplicitFlowAuth) to communicate with the external identity provider. Using this flow, communication with the provider will be done exclusively via the provider's authorization endpoint. To let the provider know the user for whom Entra ID is making the request, Entra ID will pass a token in through the [id_token_hint](http://openid.net/specs/openid-connect-core-1_0.html#AuthRequest) parameter.

This call will be made through a POST request, as the list of parameters passed to the provider is large and this prevents the use of browsers that limit the length of a GET request.

The Authentication request parameters are listed in the following table.

| Authentication Query Parameter | Value  | Description |
|--------------------------------|--------|-------------|
|scope                           | openid |             |
|response_type                   | Id_token |The value used for the implicit flow. |
|response_mode                   | form_post | We’ll use form post to avoid issues with large URLs. We expect all the parameters to be sent in the body of the request.|
|client_id                       |        | The client id given to Entra ID by the external identity provider, such as "ABCD". For more information, see [External authentication method description]().|



| Authentication Query Parameter | Value  | Description |
|--------------------------------|--------|-------------|
|redirect_url                    |        | The redirection URI to which the response (id_token_hint) will be sent by the external identity provider.
For example:<br> |


| Authentication Query Parameter | Value  | Description |
|--------------------------------|--------|-------------|
| nonce |               | A random string generated by Entra ID – can be the session id. If provided, it would need to be returned in the response back to Entra ID. |
| state	|               | If passed in, the provider should return this in its response. Entra ID will use this to keep context about the call. |
| id_token_hint |        | This will be a token issued by Entra ID for the end user and passed in for the benefit of the provider. |
|claims	|                | A JSON blob containing the claims requested. See section on [claims request parameter](http://openid.net/specs/openid-connect-core-1_0.html#ClaimsParameter) from OIDC documentation for details on the format of this parameter.<br>

Here is an example of this (decoded) for an authentication where external authentication method will satisfy MFA:<br>
```json
{
  "id_token": {
    "acr": {
      "essential": true,
      "values":["possessionorinherence"]
    },
    "amr": {
      "essential": true,
      "values": [face", "fido", "fpt", "hwk", "iris", "otp", "pop", "retina", "sc", "sms", "swk", "tel", "vbm"]
    }
  }
}
```
<br>
This is provided to help the provider know what claims Entra ID expects from it.  <br>
The combination of the acr and amr values are used by Entra ID to validate that the authentication method used for second factor satisfies the MFA requirement that it differs in ‘type’ from what was completed for first factor with Entra ID.|
|client-request-id |  A GUID value | This can be logged by the provider as it can be useful during troubleshooting and logging.|

>[!NOTE]
>Other parameters in the request that aren't listed in the previous table should be ignored by the provider.

### Default Id_token_hint claims

This section describes the required content of the token passed as id_token_hint in the request made to the provider. The token may contain other claims in addition to those listed in the following table.

| Claim |Value | Description |
|-------|------|-------------|
|iss    |       | Identifies the security token service (STS) that constructs and returns the token, and the Entra ID tenant in which the user was authenticated.
<br>
Your app should use the GUID portion of the claim to restrict the set of tenants that can sign in to the app, if applicable.
<br>
Issuer should match the issuer URL from the signed-in user’s tenant’s OIDC discovery JSON metadata.|
| aud   |        |     Audience – this should be set to the external identity provider’s client id for Entra ID.|
|exp    |        | Expiration time – this will be set to expire a short time after the issuing time (sufficient to avoid time skew issues). This is done because this token is not meant for authentication, so there is no reason for its validity to outlast the request by much. |
|iat    |        | Issuing time – Set as usual.|
|tid    |        | Tenant Id – for advertising the tenant to the provider. Represents the Entra ID tenant that the user is from. |
|oid    |        | The immutable identifier for an object in the Microsoft identity platform, in this case, a user account. It can also be used to perform authorization checks safely and as a key in database tables. This ID uniquely identifies the user across applications - two different applications signing in the same user will receive the same value in the oid claim. Thus, oid can be used when making queries to Microsoft online services, such as Microsoft Graph. |
| preferred_username |        | Provides a human readable value that identifies the subject of the token. This value is not guaranteed to be unique within a tenant and is designed to be used only for display purposes. |
| sub  |            | Subject identifier for the end-User at the Issuer. The principal about which the token asserts information, such as the user of an app. This value is immutable and cannot be reassigned or reused. It can be used to perform authorization checks safely, such as when the token is used to access a resource, and can be used as a key in database tables. Because the subject is always present in the tokens that Entra ID issues, we recommend using this value in a general-purpose authorization system.<br>
The subject is, however, a pairwise identifier - it is unique to a particular application ID. *Therefore, if a single user signs into two different apps using two different client IDs, those apps will receive two different values for the subject claim*. This may or may not be desired depending on your architecture and privacy requirements.<br>
See also the **oid** claim (which does remain the same across apps within a tenant).| 

To prevent the token for being used for anything else other than a hint, it will be issued as expired. The token will be signed, and can be verified using the published Entra ID discovery metadata.

### Email and upn claims

If a provider needs *upn* or *email* claims for discovery, then you can configure these optional claims for id_token. For more information, see [Optional claims](/azure/active-directory/develop/optional-claims). If requested, *email* will always be returned. If *upn* is requested, it will be returned for user accounts that are members of the directory, but not for guest accounts.

>[!NOTE]
>The email claim isn't guaranteed to be unique and using email in identification or authorization is an anti-pattern. Unique claims should be used to link accounts. For more information, see [Migrate away from using email claims for user identification or authorization](https://learn.microsoft.com/azure/active-directory/develop/migrate-off-email-claim-authorization).

### Recommended use of claims
Microsoft recommends associating accounts on the provider side with the account in Azure AD via the oid and tid claims.  These two claims are guaranteed to be unique for the account in the tenant. 

### Example of an id_token_hint

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

Here are examples of an id_token_hint when the claims for upn and email have been configured by the provider.

An example of an id_token_hint for a directory member:

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
  "upn": "testuser2@contoso.com"
  "oid": "951ddb04-b16d-45f3-bbf7-b0fa18fa7aee",
  "tid": "14c2f153-90a7-4689-9db7-9543bf084dad"
  }.


```

An example of the id_token hint for a guest user in the tenant is provided below. Note that upn claim is not returned.

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
  "email": "externaltestuser@hotmail.com",
  "oid": "951ddb04-b16d-45f3-bbf7-b0fa18fa7aee",
  "tid": "14c2f153-90a7-4689-9db7-9543bf084dad"
  }.


```

### Suggested actions for external identity providers

The following are the steps that we suggest the external identity provider to carry out at their end. The list isn't exhaustive and the provider is encouraged to carry out additional validation activities as they see fit. 

1. From the request:
   - Ensure that the redirect_uri is one of the published ones provided in section 3.3.2.
   - Ensure that the client_id has a value that they assigned to Entra ID, such as *ABCD*.
   - The provider should first [validate](https://docs.microsoft.com/azure/active-directory/develop/id-tokens#validating-an-id_token) the id_token_hint that is presented to it by Entra ID.
1. From the claims in the id_token_hint:
   - They can (optionally) make a call to [Microsoft Graph](https://graph.microsoft.com/) to fetch additional details about this user. The **oid** and **tid** claims in the id_token_hint will be useful in this regard. See section 0 for details about the claims provided in the id_token_hint.
1. Then carry out whatever additional authentication and authorization activity that the provider’s product is built to do.
1. Depending upon the result of user’s actions and other factors, the provider would then construct and send a response back to Entra ID as explained in section  3.3.2.6 below.

###	Entra ID processing of the provider response

The provider will POST a response back to the **redirect_uri**.

The following parameters should be provided on a successful response:

Parameter	Value	Description
id_token		The token issued by the external identity provider.
state		The same state that was passed in the request, if any. Otherwise, this should not be present.

On success, the provider would then issue an id_token for the user. Entra ID would use the published OIDC metadata to verify that the token contains the expected claims as well as do all the other validation of the token that OIDC requires.

Claim	Value	Description
iss		Issuer – must match the issuer from the provider’s discovery metadata.
aud		Audience – the Entra ID client id. See ClientId in 3.2.2 above.
exp		Expiration time – set as usual.
iat		Issuing time – set as usual.
sub		Subject – must match the sub from the id_token_hint sent to initiate this request
nonce		The same nonce that was passed in the request, if any. Otherwise, this should not be present.
acr		The acr claims for the authentication request. This should match one of the values from the request sent to initiate this request. Only one acr claim should be returned. For the list of claims, see [Supported acr claims](#supported-acr-claims).



amr		The amr claims for the authentication method used in authentication.  Only one method claim should be returned.	For the list of claims, see [Supported amr claims](#supported-amr-claims).


#### Supported acr claims

Claim | Notes 
------|------
possessionorinherence | Authentication must take place with a possession or inherence based factor.
knowledgeorpossession | Authentication must take place with a knowledge or possession based factor.
knowledgeorinherence | Authentication must take place with a knowledge or inherence based factor.
knowledgeorpossessionorinherence | Authentication must take place with a knowledge or possession or inherence based factor.
knowledge | Authentication must take place with knowledge based factor.
possession | Authentication must take place with possession based factor.
inherence| Authentication must take place with inherence based factor.

#### Supported amr claims


Claim | Notes
------|------
face | Biometric via facial recognition
fido | FIDO2 was used
fpt   | Biometric via fingerprint
hwk   | Proof of possession of hardware-secured key
iris  | Biometric via iris scan
otp | One time password
pop | Proof of possession
retina | biometric of retina scan
sc | smart card
sms | Confirmation by sms to registered number
swk	 |  of presence of a software secured key
tel | Confirmation by telephone 
vbm | Biometric via voiceprint

Because Entra ID requires MFA to be satisfied to issue a token with MFA claims, only methods with a different type (something you have (possession), something you know (knowledge), something you are (inherence)), can be used to satisfy the second factor.

Entra ID will validate the type mapping based on the following table.

| Claim Method | Type | Notes |
|--------------|------|-------|
|face          |Inherence | Biometric via facial recognition |
|fido |Possession | FIDO2 was used. Some implementations may also require biometric but as possession is the primary security attribute, that is the method type that is mapped.|
|fpt |Inherence | Biometric via fingerprint |
|hwk  | Possession | Proof of possession of hardware-secured key |
|iris | Inherence  | Biometric via iris scan |
| otp | Possession | One-time password |
|pop | Possession | Proof of possession |
|retina | Inherence | Biometric of retina scan |
|sc | Possession | smart card |
|sms |Possession |Confirmation by SMS to registered number|
| swk | Possession | Proof of presence of a software secured key
|tel |Possession |Confirmation by telephone |
|vbm |Inherence |Biometric via voiceprint |


If no issues are found with the token, then Entra ID should consider MFA having been satisfied and issue a token to the end user. Otherwise, it should fail the end user’s request.

Failure is indicated by issuing Error Response parameters.

Parameter | Value | Description
----------|-------|-------------
Error |           | An ASCII error code, such as access_denied or temporarily_unavailable. |


Entra ID will consider the request successful if the id_token parameter is present in the response and if the token is valid. Otherwise, the request will be considered unsuccessful and Entra ID will fail the original authentication attempt due to policy requirement as dictated by the conditional access policy.

Entra ID will abandon the state of the authentication attempt on its end approximately 10 minutes after the redirection has occurred to the provider.

### Transition period for acr and amr claims integration

The initial preview support for external authentication methods replicated the values of the amr claim in the acr claim, and no values were provided by Entra ID in the amr claim. The provider needed to provide the same value in the amr and acr claims in the id token returned to Entra ID.  

This guide provides the updated approach for preview, where:

1. acr claim values align with the method type-based factor (inherence, possession, knowledge or the conjoined versions).
1. Values the methods accepted for satisfying the authentication are included in the amr claim in the request.

A transition period supporting providers and customers initial preview testing will be enabled to give providers time to update their integration.  During this transition period the following approach will be used:

1. acr claim values will include the same values of the current integration and the method-type based values (e.g possessionorinherence) that will be used moving forward.

1. The acceptable values for the amr claim will be included in the request from Entra ID.

During this transition time, providers can return an acr value in the id_token that is either the method type-based value (possessionorinherence) or a method value. If the method value is returned, then the amr and acr values must match.


Phase	acr values from Entra ID	amr values from Entra ID	acr values accepted by Entra ID	amr values accepted by Entra ID
Current behavior	Values matching the acceptable methods for authentication	None	One value from the list emitted by Entra ID.  Value must match what is returned in amr claim, appropriate for the method the user performed for authentication.	One value from the list of values emitted by Entra ID in the acr.  Value must match what is returned in acr claim, matching the method the user performed for authentication.
Transition	Method type-based values (possession, inherence, possessionorinherence), as well as the list of value matching acceptable methods	Values that will be accepted for satisfying authentication.  During this period, this list will match the method values included in the acr claim Entra ID populates.	One value from the acr values needs to be returned appropriate for the authentication the user performed.  If a method-value is returned, it must match the value that is returned in amr.	One value from the list of values set by Entra ID as part of the request in the amr or acr, matching the method the user performed for authentication.
Final behavior	Method type-based values (possession, inherence, possessionorinherence) 	Values matching the acceptable methods for authentication	One of the acr values set by Entra ID, matching the “type” of method the user performed for authentication.	One value from the list of values set by Entra ID as part of the request in the amr, matching the method the user performed for authentication.
