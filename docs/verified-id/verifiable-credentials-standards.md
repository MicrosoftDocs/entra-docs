---
title: Microsoft Entra Verified ID-supported standards
description: This article outlines current and upcoming standards

author: barclayn
manager: amycolannino
ms.service: entra-verified-id

ms.topic: how-to
ms.date: 10/31/2023
ms.author: barclayn
# Customer intent: As a developer, I'm looking for information about the open standards that are supported by Microsoft Entra Verified ID.
---

# Microsoft Entra Verified ID-supported standards

Microsoft is actively collaborating with members of the Decentralized Identity Foundation (DIF), the W3C Credentials Community Group, and the wider identity community. We’re working with these groups to identify and develop critical standards, and we implement the open standards in our services.

In this article, you find the currently supported open standards for Microsoft Entra Verified ID.

## Standards bodies

- [OpenID Foundation (OIDF)](https://openid.net/foundation/)
- [Decentralized Identity Foundation (DIF)](https://identity.foundation/)
- [World Wide Web Consortium (W3C)](https://www.w3.org/)
- [Internet Engineering Task Force (IETF)](https://www.ietf.org/)

## Supported standards

Microsoft Entra Verified ID supports the following open standards:

| Technology stack component | Open standard | Standard body |
|:------|:-----|:-----|
| Data model | [Verifiable Credentials Data Model v1.1](https://www.w3.org/TR/vc-data-model) | W3C VC WG |
| Credential format | [JSON Web Token VC (JWT-VC)](https://www.w3.org/TR/vc-data-model/#json-web-token) - encoded as JSON and signed as a JWS ([RFC7515](https://datatracker.ietf.org/doc/html/rfc7515)) | W3C VC WG /IETF |
| Entity identifier (issuer, verifier) | [did:web](https://github.com/w3c-ccg/did-method-web) | W3C CCG |
| User authentication | [Self-Issued OpenID Provider v2](https://openid.net/specs/openid-connect-self-issued-v2-1_0.html)| OIDF |
| Presentation | [OpenID for Verifiable Credentials](https://openid.net/sg/openid4vc/) | OIDF|
| Issuance | [OpenID for Verifiable Credentials Issuance](https://openid.net/specs/openid-4-verifiable-credential-issuance-1_0-11.html) | OIDF|
| Query language | [Presentation Exchange v2.0.0](https://identity.foundation/presentation-exchange/spec/v2.0.0/)| DIF |
| Trust in DID (decentralized identifier) owner | [Well Known DID Configuration](https://identity.foundation/.well-known/resources/did-configuration)| DIF |
| Revocation |[Verifiable Credential Status List](https://www.w3.org/TR/2023/WD-vc-status-list-20230427/)| W3C CCG |

## Supported algorithms

Microsoft Entra Verified ID supports the following key types for the JSON Web Signature (JWS) signature verification:

|Key type|JWT algorithm|
|--------|-------------|
|secp256k1|ES256K|
|Ed25519|EdDSA|
|EC|P-256|

Starting February 2024, Verified ID support NIST compliant P-256 curve.

For the quick setup customers, the newly issued credentials use P-256 curve as default and any previously issued credentials continue to work until they expire. Existing authorities automatically migrate to using P-256 for any future issuances.

For the advanced setup customers, Verified ID credentials issued be signed with P-256 curve by default for any new authorities. For existing authorities, there is no change to already issued or newly issued credentials.

## Interoperability

Microsoft is collaborating with organization members of Decentralized Identity Foundation (DIF), the W3C Credentials Community Group, and the wider identity community. Our collaboration efforts aim to build a Verifiable Credentials Interoperability profile to support standards-based issuance, revocation, presentation, and wallet portability.

Today, we have a working JWT verifiable credentials presentation profile that supports the interoperable presentation of verifiable credentials between wallets and verifiers/resource providers. Join us at the DIF Claims and Credentials working group, [aka.ms/vcinterop](https://aka.ms/vcinterop) and [aka.ms/vcinteroppresentation](https://aka.ms/vcinteroppresentation).

## Next steps

- [Get started with verifiable credentials](verifiable-credentials-configure-tenant.md)
