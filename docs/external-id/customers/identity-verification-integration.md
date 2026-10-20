---
title: Identity verification integration for Microsoft Entra External ID
description: Compare identity verification patterns for Microsoft Entra External ID apps, including Verified ID credentials, direct REST API claims, and OIDC federation.
author: rogulati
ms.author: rogulati
ms.service: entra-external-id
ms.topic: concept-article
ms.custom: msecd-doc-authoring-1026
ms.date: 10/20/2026
ai-usage: ai-generated

#customer intent: As an application developer, I want to choose an identity verification integration pattern so that I can meet my application's identity proofing, privacy, and credential reuse needs.
---

# Identity verification integration overview for Microsoft Entra External ID

Identity verification establishes who a person is, rather than only authenticating their account. Applications that use Microsoft Entra External ID can integrate with an identity verification (IDV) partner to verify a user's identity through government-issued document checks and biometric or liveness checks. These checks can support onboarding, account recovery, and high-risk transactions.

This article explains two REST API-based integration patterns that you orchestrate in your application. **Pattern 1a** uses Microsoft Entra Verified ID credentials. **Pattern 1b** returns verified claims directly to your application. The article also compares these approaches with **Pattern 2**, which uses OpenID Connect (OIDC) federation.

## Application-orchestrated identity verification

Your application manages the verification journey and decides how to use the result. Identity verification isn't a built-in proofing step that you enable in an External ID user flow. The partner performs the identity checks; External ID provides authentication for your application.

Choose Pattern 1a when user-held credentials, data minimization, and reuse across applications are priorities. Choose Pattern 1b when you need claims returned directly to your application and are prepared to manage the resulting personal data.

Live identity proofing can involve document capture, liveness checks, and processing by the partner. Your application needs to manage this longer-running interaction separately from synchronous custom authentication extension calls. Don't use a blocking extension call to wait for the user to complete identity proofing.

## Pattern 1a: IDV REST API integration with Verified ID APIs

Pattern 1a is the recommended approach when privacy and credential reuse matter. The IDV partner verifies the user and issues the attested claims as a Verified ID credential, such as `VerifiedIdentity`, to the user's **Microsoft Authenticator app**. Your application uses Verified ID REST APIs to request and verify a presentation of that credential.

### Proofing, issuance, and presentation

Proofing and credential presentation are separate parts of the experience:

- **Proofing and issuance:** If the user doesn't have the required credential, your application directs them to the partner's verification experience. After successful proofing, the partner starts credential issuance. The user adds the credential to Microsoft Authenticator through a QR code or deep link.
- **Presentation:** Your application requests the required credential through Verified ID. The user presents it from Microsoft Authenticator, and your application receives the verified claims from the presentation.
- **Reuse:** A user who already has an accepted credential can present it without repeating the partner's proofing process for each application.

The credential remains in the user's possession. Your application receives the claims the user presents, rather than receiving the proofing data directly from the partner. This supports data minimization, but presented claims can still contain personal data.

The partner's proofing experience and credential requirements depend on your agreement with that partner. Work with the partner to establish onboarding requirements and a direct billing contract. For the canonical issuer and verifier flows, see [Integrate Verified ID APIs](~/verified-id/integration-guidance.md).

### External tenant setup

For the External ID tenant configuration used with this pattern, see [Configure Microsoft Entra Verified ID in an external tenant](verified-id-setup-issuance-presentation.md). That article describes the supported setup method and external tenant limitations. The IDV partner is responsible for issuing the partner's identity credential; your application requests and verifies its presentation.

## Pattern 1b: IDV REST API integration with claims returned to the application

In Pattern 1b, your application calls the IDV partner's REST API to start verification and receive verified claims. The partner returns the claims directly to your application, which is the relying party. No Verified ID credential is issued to the user as part of this pattern, and Microsoft Authenticator isn't required.

This approach has fewer credential-handling components: your application starts a verification session, the partner proofs the user, and your application receives the result through the partner's API integration. Use the partner's documentation for the API contract and result-handling requirements.

The returned claims can contain personal data. Your application receives and holds that data, so data minimization, residency, and retention are part of your integration's privacy and compliance responsibilities. Unlike Pattern 1a, this pattern doesn't produce a user-held credential that the user can present to other relying parties.

As with Pattern 1a, you contract directly with the IDV partner.

## REST API pattern comparison

The main differences between the REST API patterns are where the attested claims are delivered, whether the user receives a reusable credential, and who handles the returned personal data.

| Consideration | IDV REST API with Verified ID APIs | IDV REST API with claims |
| --- | --- | --- |
| **Result of proofing** | A credential issued to the user's Microsoft Authenticator app | Verified claims returned directly to your application |
| **Application integration** | Verified ID REST APIs for credential presentation, with the partner's proofing experience | The partner's REST API |
| **User-held credential** | Yes | No |
| **Reuse across relying parties** | The user can present the credential to applications that accept it | No reusable credential is issued |
| **Personal data handling** | Your application receives the claims the user presents | Your application receives and holds the claims returned by the partner |
| **Microsoft Authenticator dependency** | Required for the credential experience described here | Not required |
| **Commercial relationship** | Direct contract with the IDV partner | Direct contract with the IDV partner |

## Pattern 2: OIDC federation

In Pattern 2, the IDV partner acts as an OIDC identity provider, and Microsoft Entra External ID federates with it. The partner performs identity verification in its own experience and returns identity claims in an OIDC ID token to External ID. Unlike Pattern 1b, your application doesn't call the partner's REST API to receive the verification result.

There are two separate relationships: your application uses External ID for authentication, and External ID uses the partner as an external identity provider. The partner issues its ID token to External ID, not directly to your application.

### Federation flow

The sign-in and verification experience spans your application, External ID, and the partner:

- **Application sign-in:** Your application starts sign-in with External ID. The user selects the IDV partner configured as an identity provider in the user flow.
- **Partner verification:** External ID redirects the user to the partner's OIDC authorization endpoint. The partner handles the verification experience, such as document and liveness checks, according to your agreement.
- **Federation response:** The partner returns an authorization code to External ID's registered redirect URI. External ID uses the code to obtain the partner's ID token, which contains the identity claims the partner supplies.
- **Application sign-in completion:** External ID completes its user flow and issues tokens for your application. The claims available to your application depend on External ID's supported claims mapping and token configuration; the partner's entire ID token isn't passed through to your application.

This direction matters: the IDV partner is the identity provider for External ID. Configuring External ID as the identity provider for a partner's own application is the opposite integration and doesn't establish this pattern.

### Partner requirements and claim handling

The partner must provide an OIDC service compatible with External ID's federation requirements. Configuration includes an OIDC discovery endpoint, issuer, client registration, supported client authentication method, scopes, and claims mapping. External ID supports the authorization code response type for this federation. A discovery endpoint establishes that a provider exposes OIDC metadata, but doesn't by itself establish compatibility with External ID.

An IDV provider might return identity attributes or proofing results as top-level ID token claims or within a `verified_claims` structure. External ID's documented [claims mapping](reference-oidc-claims-mapping-customers.md) covers specific standard claims and user attributes; it doesn't establish that arbitrary proofing-result claims or nested structures can be passed through to your application. Before relying on federation for identity proofing, confirm which partner claim represents the required proofing outcome, whether External ID supports the necessary mapping, and what your application actually receives. Successful federated sign-in alone doesn't establish that the required identity proofing occurred.

Don't assume that External ID can dynamically request specific proofing claims through the OIDC `claims` parameter. Provider documentation and discovery metadata can differ, and neither establishes end-to-end support through External ID. Validate the configured claim delivery with your selected partner, including whether it represents new proofing or an existing verification.

Don't treat `email_verified` or `phone_number_verified` alone as proof of government-issued identity verification. These claims describe verification of the email address or phone number. Agree with the partner on which claims establish the required proofing outcome and whether the journey performs new proofing or uses an existing verification.

### Tradeoffs and configuration

OIDC federation brings the partner's verification experience into the sign-in redirect flow. It requires the partner to operate a compatible OIDC identity provider; a REST-only service isn't sufficient. In this pattern, the result is delivered through federation, rather than by issuing a reusable Verified ID credential to Microsoft Authenticator.

You contract directly with the IDV partner. For the External ID setup procedure, see [Add OpenID Connect as an external identity provider](how-to-custom-oidc-federation-customers.md). Validate the end-to-end federation and claim handling with your selected partner before relying on the integration.

## Related content

- [Microsoft Entra Verified ID identity verification partners](~/verified-id/idv-partners.md)
- [Integrate Verified ID APIs](~/verified-id/integration-guidance.md)
- [Configure Microsoft Entra Verified ID in an external tenant](verified-id-setup-issuance-presentation.md)
