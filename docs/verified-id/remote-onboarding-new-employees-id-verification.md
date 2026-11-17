---
title: Remote onboarding with Microsoft Entra Verified ID overview
description: Compare built-in identity verification with Lifecycle Workflows and a custom onboarding portal that uses Microsoft Entra Verified ID REST APIs.
author: rogulati
ms.author: rogulati
services: decentralized-identity
ms.service: entra-verified-id
ms.topic: concept-article
ms.date: 11/03/2026
ms.custom: msecd-doc-authoring-1026
ai-usage: ai-assisted
#customer intent: As an identity administrator or solution architect, I want to choose an identity verification onboarding pattern so that I can use Lifecycle Workflows or build a custom onboarding experience.
---

# Remote onboarding with Microsoft Entra Verified ID overview

<a name="overview"></a>

Remote onboarding with Microsoft Entra Verified ID uses government-issued, ID-based attestations to help establish trust with users who aren't yet inside your organization's trust boundary.

Choose between two onboarding patterns. If your organization uses Lifecycle Workflows in Microsoft Entra ID Governance, use the built-in identity-verification templates and tasks. If you have your own onboarding portal or solution and need to customize the experience, integrate with the Verified ID REST APIs.

## Pattern 1: Built-in identity verification tasks with Lifecycle Workflows

Use this pattern to configure onboarding through the Pre-hire and New-hire identity-verification templates and tasks in Lifecycle Workflows, rather than implement the verification journey in a custom portal.

The pattern connects pre-hire identity verification with new-hire credential registration. An ID verification profile defines the verification journey, and the workflow uses that profile for its identity-verification tasks.

For this pattern, use an identity verification (IDV) partner offer with **Security Store-based integration**. The [IDV partner gallery](https://aka.ms/verifiedidisv) lists Security Store integration partners separately from Verified ID API-based integration partners. Review the relevant integration type when selecting a provider.

For configuration and the complete user journey, see [Onboard users with identity verification (Preview)](~/id-governance/how-to-onboard-users-with-identity-verification.md). That guide covers:

- Pre-hire and new-hire workflow configuration.
- Inline passkey registration and the alternative that uses a Temporary Access Pass (TAP) with Conditional Access-protected registration.
- Device, passkey-policy, and guest-account eligibility considerations.

<a name="when-to-use-this-pattern"></a>

## Pattern 2: Custom onboarding portal with Verified ID REST APIs

Use this pattern if you have your own onboarding portal or solution and want to customize the experience by using Microsoft Entra Verified ID REST APIs. Your application coordinates identity verification, credential presentation, user matching, and the remaining onboarding logic.

For this pattern, select a provider that supports **Verified ID API-based integration** from the [IDV partner gallery](https://aka.ms/verifiedidisv), and follow that partner's integration guidance. Don't assume that a partner supports both integration types just because it appears in the gallery.

<a name="solution"></a>

### Custom-portal example

The following employee-onboarding example assumes a human resources (HR) system with API support for querying records and matching user profiles. The new hire's account is already provisioned in Microsoft Entra ID, and the organization uses TAP as part of its passwordless onboarding.

A backend job sends the new hire a link to their onboarding process. [Lifecycle Workflows](~/id-governance/what-are-lifecycle-workflows.md) can trigger this invitation, but the custom portal still implements the API-based flow described here.

| Stage | Custom-portal behavior |
|-------|------------------------|
| **Invitation** | The backend sends an employee-specific link. The new hire opens it, and the onboarding portal validates the link. |
| **Identity verification and issuance** | The portal redirects the new hire to the IDV partner to complete verification and receive a Verified ID in their wallet. |
| **Credential presentation** | The new hire returns to the onboarding portal and presents the Verified ID. The portal uses the Verified ID service to request presentation and receive the credential claims. |
| **Account matching** | The application validates the claims against the HR record and locates the new hire's Microsoft Entra account. |
| **TAP generation** | The application uses Microsoft Graph to [generate a TAP](/graph/api/resources/temporaryaccesspassauthenticationmethod?view=graph-rest-1.0&preserve-view=true), then presents it to the new hire to continue onboarding. |

The sequence diagram shows this custom-portal example, not the built-in Lifecycle Workflows templates.

:::image type="complex" source="media/remote-onboarding-new-employees-id-verification/high-level-flow-diagram.png" alt-text="Sequence diagram of custom-portal identity verification, HR matching, and TAP generation in Microsoft Entra ID." lightbox="media/remote-onboarding-new-employees-id-verification/high-level-flow-diagram.png":::
The participants are the new hire (browser and Microsoft Authenticator), the IDV partner as issuer (partner portal and Verified ID service), and the organization as verifier (onboarding portal, Verified ID service, HR system, and Microsoft Entra ID).

The browser opens the invitation, and the onboarding portal validates the link before redirecting the new hire to the IDV partner. The new hire submits a selfie and documents through the browser. The partner portal creates an issuance request with an ID token hint. Microsoft Authenticator consumes the request, accepts the credential, and receives it from the Verified ID service.

The partner redirects the new hire to the onboarding portal. The new hire selects the presentation link, and the portal creates a presentation request with the Verified ID service. Microsoft Authenticator consumes the request, and the new hire consents to present the credential. The service returns the presentation response to the onboarding portal. The portal validates the user record against the credential claims through the HR system, calls Microsoft Graph to generate a TAP in Microsoft Entra ID, and presents the TAP to the new hire so onboarding can continue.
:::image-end:::

<a name="issues-and-considerations"></a>

### Custom-portal design considerations

These considerations apply to the custom application and HR matching in Pattern 2.

- **Invitation links:** Make each link specific to one remote employee, valid for only a short period, and invalid after the flow finishes. Correlate it with a unique HR record identifier.
- **Account validation:** Precreate the Microsoft Entra account and use it as part of the portal's request validation.
- **Name differences:** HR records and government-issued documents can contain different names, such as "Jim" and "James." Ask candidates to use the name on their government-issued documents at the beginning of the HR process to simplify validation.
- **Matching attributes:** Design validation around attributes likely to match the HR record exactly. In addition to first and last name, examples include street address, date of birth, nationality, and a national or regional identification number, where applicable.
- **Human review:** Plan a fallback for ambiguous or nonconclusive matches, such as a phone call with the user.
- **Regional coverage:** Multinational organizations might need different identity verification partners for different user regions.
- **Auditing:** Treat the initial user interaction as untrusted. Generate detailed audit logs for requests processed by the onboarding portal. Don't log TAP values, invitation links, or unnecessary credential claims.

<a name="additional-resources"></a>

## Related content

- [Onboard users with identity verification (Preview)](~/id-governance/how-to-onboard-users-with-identity-verification.md)
- [Get started with the Verified ID REST APIs](get-started-request-api.md)
- [Plan your Microsoft Entra Verified ID verification solution](plan-verification-solution.md#account-onboarding)
