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

For information about how to validate the tokens issued by Entra ID, see [Validating and ID token](https://docs.microsoft.com/en-us/azure/active-directory/develop/id-tokens#validating-an-id_token). There are no special steps for the consumers of our discovery metadata. 

Microsoft’s [token validation library](https://github.com/AzureAD/azure-activedirectory-identitymodel-extensions-for-dotnet/wiki) has all the details on the specifics of token validation that have either been documented or can be ascertained from browsing the source code. For a sample, see [Azure Samples](https://github.com/Azure-Samples/active-directory-dotnet-webapi-manual-jwt-validation).

Once validation succeeds, you can work with the claims payload to get details of the user and the tenant they belong to.

## Entra ID call to the external identity provider

Entra ID will use the [OIDC implicit flow](http://openid.net/specs/openid-connect-core-1_0.html#ImplicitFlowAuth) to communicate with the external identity provider. Using this flow, communication with the provider will be done exclusively via the provider's authorization endpoint. To let the provider know the user for whom Entra ID is making the request, Entra ID will pass a token in through the [id_token_hint](http://openid.net/specs/openid-connect-core-1_0.html#AuthRequest) parameter.

This call will be made through a POST request, as the list of parameters passed to the provider is large and this prevents the use of browsers that limit the length of a GET request.

The Authentication request parameters are listed in the following table.


