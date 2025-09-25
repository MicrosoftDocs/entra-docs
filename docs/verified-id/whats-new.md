---
title: What's new for Microsoft Entra Verified ID
description: Recent updates for Microsoft Entra Verified ID
author: barclayn
manager: femila
ms.service: entra-verified-id
ms.topic: whats-new
ms.date: 04/30/2025
ms.custom: references_regions
ms.author: barclayn

#Customer intent: As a Microsoft Entra Verified ID issuer, verifier or developer, I want to know what's new in the product so that I can make full use of the functionality as it becomes available.

---

# What's new in Microsoft Entra Verified ID

This article lists the latest features, improvements, and changes in the Microsoft Entra Verified ID service.

## January 2025

- Instructions for [upgrading signing key](signing-key-upgrade.md) to become FIPS compliant.

## October 2024

- FAQ section now contains information for [network hardening](verifiable-credentials-faq.md#network-hardening-for-callback-events) for Request Service API callbacks.

## September 2024

- Support for [did:web:path](did-web-path.md) can be enabled for your Microsoft Entra tenant upon request.

## August 2024

- [FaceCheck](using-facecheck.md) is generally available starting August 12.

## June 2024

- [FaceCheck](using-facecheck.md) introducing the Face Check Addon as an incremental update to the Face Check public preview. Face Check is a premium feature within Microsoft Entra Verified ID free to use during the public preview period ending on August 12.

## April 2024

- [Quick setup](verifiable-credentials-configure-tenant-quick.md) Generally available, it enables an admin to onboard Microsoft Entra Verified ID in a Microsoft Entra tenant with just one select of a button.

## March 2024

- Starting February 2024, Verified ID [supports NIST compliant P-256 curve](verifiable-credentials-standards.md#supported-algorithms).
- [Wallet Library 1.0.1](using-wallet-library.md#prerequisites) supports P-256.

## February 2024

- New concept article on [Verified helpdesk](helpdesk-with-verified-id.md) on how to identity of callers seeking help using Microsoft Entra Verified ID.
- Override of [expirationDate](issuance-request-api.md#issuance-request-payload) on issuance for idTokenHint attestation flow requires that the contract needs to have the flag [allowOverrideValidityOnIssuance](admin-api.md#contract-type) set to true.

## January 2024

- [FaceCheck](using-facecheck.md) is now in public preview. It allows enterprises to perform high-assurance verifications by performing facial matching between a user’s real-time selfie and a photo in the Verified ID credential. FaceCheck is offered free of cost during the Public Preview period and can be used by any Verified ID project. 

## December 2023

- [Request Service API](issuance-request-api.md#issuance-request-payload) now supports the issuing application to set the expiry date of the credential during and issuance request when the attestation is using the [idTokenHint flow](how-to-use-quickstart.md).
- The option of selecting `did:ion` as a trust system is removed. The only trust system available is `did:web`.

## November 2023

[Request Service API](presentation-request-api.md#constraints-type) now supports claims constraints when making presentation requests. Claims constraints can be used to specify constraints on the Verified ID credential that the verifier is asking to be presented. Available constraints are direct match, contains, and startsWith.

## October 2023

- [Quick setup](verifiable-credentials-configure-tenant-quick.md) introduced as preview which enables an admin to onboard a Microsoft Entra tenant with just one select of a button.
- [MyAccount available now to simplify issuance of Workplace Credentials](verifiable-credentials-configure-tenant-quick.md#myaccount-available-now-to-simplify-issuance-of-workplace-credentials)
- [Advanced setup](verifiable-credentials-configure-tenant.md) still available as an option to `Quick setup`.

## September 2023

Verified ID is retiring old Request Service API endpoints that were available before Verified ID was General Available. These APIs shouldn't have been used since GA in August 2022, but if they are used in your app, you need to migrate. The API endpoints being retired are:

```http
POST https://verifiedid.did.msidentity.com/v1.0/:tenant/verifiablecredentials/request
GET https://verifiedid.did.msidentity.com/v1.0/:tenant/verifiablecredentials/request/:requestId
POST https://verifiedid.did.msidentity.com/v1.0/:tenant/verifiablecredentials/present
POST https://verifiedid.did.msidentity.com/v1.0/:tenant/verifiablecredentials/issuance
```

The first API was for creating an issuance or presentation request. The second API was for retrieving a request and the last two APIs was for a wallet completing issuance or presentation. The API endpoints are:

```http
POST https://verifiedid.did.msidentity.com/v1.0/verifiablecredentials/createPresentationRequest
POST https://verifiedid.did.msidentity.com/v1.0/verifiablecredentials/createIssuanceRequest
GET https://verifiedid.did.msidentity.com/v1.0/verifiablecredentials/presentationRequests/:requestId
POST https://verifiedid.did.msidentity.com/v1.0/verifiablecredentials/completeIssuance
POST https://verifiedid.did.msidentity.com/v1.0/verifiablecredentials/verifyPresentation
```

The `/request` API is split into two depending on if you are creating an issuance or presentation request.

The retired API endpoints don't work since October 2023.

## August 2023

The `presentation_verified` callback from the Request Service API now returns when a Verified ID credential was issued and when it expires. Business rules can use these values to see the time window of when the presented Verified ID credential is valid. An example of this is that it expires in an hour while the business required in needs to be valid until the end of the day.

## June 2023

Tutorial for getting started with the Wallet Library demo on Android and iOS available [here](using-wallet-library.md).

## May 2023

- Wallet Library was announced at Build 2023 in session [Reduce fraud and improve engagement using Digital Wallets](https://www.youtube.com/watch?v=wtEzFqtsq8U). The Wallet Library enables customers to add verifiable credentials technology to their own mobile apps. The libraries are available for [Android](https://github.com/microsoft/entra-verifiedid-wallet-library-android/tree/dev) and [iOS](https://github.com/microsoft/entra-verifiedid-wallet-library-ios/tree/dev).

## April 2023

Instructions for setting up place of work verification on LinkedIn available [here](linkedin-employment-verification.md).

## March 2023

- Admin API now supports [application access tokens](admin-api.md#authentication) and in addition to user bearer tokens.
- Introducing the Microsoft Entra Verified ID [Services partner gallery](services-partners.md) listing trusted partners that can help accelerate your Microsoft Entra Verified ID implementation.
- Improvements to our Administrator onboarding experience in the [Admin portal](verifiable-credentials-configure-tenant.md#register-decentralized-id-and-verify-domain-ownership) based on customer feedback.
- Updates to our samples in [GitHub](https://github.com/Azure-Samples/active-directory-verifiable-credentials) showcasing how to dynamically display VC claims.

## February 2023

- *Public preview* - Entitlement Management customers can now create access packages that use Microsoft Entra Verified ID [learn more](~/id-governance/entitlement-management-verified-id-settings.md)

- The Request Service API can now do revocation check for verifiable credentials presented that was issued with [StatusList2021](https://www.w3.org/TR/vc-status-list/) or the [RevocationList2020](https://w3c-ccg.github.io/vc-status-rl-2020/) status list types.

## January 2023

- Microsoft Authenticator user experience improvements on pin code, verifiable credential overview, and verifiable credentials requirements.

## November 2022

- Microsoft Entra Verified ID now reports events in the [audit log](~/identity/monitoring-health/concept-audit-logs.md). Only management changes made via the Admin API are currently logged. Issuance or presentations of verifiable credentials aren't reported in the audit log. The log entries have a service name of `Verified ID` and the activity is `Create authority`, `Update contract`, etc.  

## September 2022

- The Request Service API now has [granular app permissions](verifiable-credentials-configure-tenant.md?#grant-permissions-to-get-access-tokens) and you can grant **VerifiableCredential.Create.IssueRequest** and **VerifiableCredential.Create.PresentRequest** separately to segregate duties of issuance and presentation to separate application. 
- [IDV Partner Gallery](partner-gallery.md) now available in the documentation guiding you how to integrate with Microsoft's Identity Verification partners.
- How-to guide for implementing the [presentation attestation flow](how-to-use-quickstart-presentation.md) that requires presenting a verifiable credential during issuance.

## August 2022

Microsoft Entra Verified ID is now generally available (GA) as the new member of the Microsoft Entra portfolio! [read more](https://techcommunity.microsoft.com/t5/microsoft-entra-azure-ad-blog/microsoft-entra-verified-id-now-generally-available/ba-p/3295506) 

### Known issues

- Tenants that [opt-out](verifiable-credentials-faq.md#how-do-i-reset-the-microsoft-entra-verified-id-service) without issuing any Verifiable Credential gets a `Specified resource does not exist` error from the Admin API and/or the Microsoft Entra admin center. A fix for this issue should be available by August 20, 2022.

## July 2022

- The Request Service APIs have a **new hostname** `verifiedid.did.msidentity.com`. The `beta.did.msidentity` and the `beta.eu.did.msidentity` continue to work, but you should change your application and configuration. Also, you no longer need to specify `.eu.` for an EU tenant.
- The Request Service APIs have **new endpoints** and **updated JSON payloads**. For issuance, see [Issuance API specification](issuance-request-api.md#issuance-request-payload) and for presentation, see [Presentation API specification](presentation-request-api.md#presentation-request-payload). The old endpoints and JSON payloads continue to work, but you should change your applications to use the new endpoints and payloads.
- Request Service API **[Error codes](error-codes.md)** have been **updated** 
- The **[Admin API](admin-api.md)** is made **public** and is documented. The Azure portal is using the Admin API and with this REST API you can automate the onboarding or your tenant and creation of credential contracts.
- Find issuers and credentials to verify via the [Microsoft Entra Verified ID Network](how-use-vcnetwork.md).
- For migrating your Azure Storage based credentials to become Managed Credentials there's a PowerShell script in the [GitHub samples repo](https://github.com/Azure-Samples/active-directory-verifiable-credentials/tree/contractmigration/scripts/contractmigration) for the task.

- We also made the following updates to our Plan and design docs:
  - (updated) [architecture planning overview](introduction-to-verifiable-credentials-architecture.md).
  - (updated) [Plan your issuance solution](plan-issuance-solution.md).
  - (updated) [Plan your verification solution](plan-verification-solution.md).

## June 2022

- We're adding support for the [did:web](https://w3c-ccg.github.io/did-method-web/) method. Any new tenant that starts using the Verifiable Credentials Service after June 14, 2022 will have Web as a new, default, trust system when [onboarding](verifiable-credentials-configure-tenant.md#set-up-verified-id). VC Administrators can still choose to use ION when setting a tenant. If you want to use did:web instead of ION or viceversa, you need to [reconfigure your tenant](verifiable-credentials-faq.md#how-do-i-reset-the-microsoft-entra-verified-id-service).
- We're rolling out several features to improve the overall experience of creating verifiable credentials in the Microsoft Entra Verified ID platform:
  - Introducing Managed Credentials, which are verifiable credentials that no longer use Azure Storage to store the [display & rules JSON definitions](rules-and-display-definitions-model.md). Their display and rule definitions are different from earlier versions.
  - Create Managed Credentials using the [new quickstart experience](how-to-use-quickstart.md).
  - Administrators can create a Verified Employee Managed Credential using the [new quick start](how-to-use-quickstart-verifiedemployee.md). The Verified Employee is a verifiable credential of type verifiedEmployee that is based on a predefined set of claims from your tenant's directory.


- We made the following updates to our docs:
  - (new) [Current supported open standards for Microsoft Entra Verified ID](verifiable-credentials-standards.md).
  - (new) [How to create verifiable credentials for ID token hint](how-to-use-quickstart.md).
  - (new) [How to create verifiable credentials for ID token](how-to-use-quickstart-idtoken.md).
  - (new) [How to create verifiable credentials for self-asserted claims](how-to-use-quickstart-selfissued.md). 
  - (new) [Rules and Display definition model specification](rules-and-display-definitions-model.md).
  - (new) [Creating a tenant for development](how-to-create-a-free-developer-account.md).

## May 2022

We're expanding our service to all Microsoft Entra ID customers! Verifiable credentials are now available to everyone with a Microsoft Entra ID subscription (Free and Premium). Existing tenants that configured the Verifiable Credentials service prior to May 4, 2022 must make a small change to avoid service disruptions.

## April 2022

Starting next month, we're rolling out exciting changes to the subscription requirements for the Verifiable Credentials service. Administrators must perform a small configuration change before **May 4, 2022** to avoid service disruptions.

>[!IMPORTANT]
> If changes aren't applied before **May 4, 2022**, you will experience errors on issuance and presentation for your application or service using the Microsoft Entra Verified ID Service.

## March 2022

- Microsoft Entra Verified ID customers can now change the [domain linked](how-to-dnsbind.md) to their DID easily from the Azure portal.
- We made updates to Microsoft Authenticator that change the interaction between the Issuer of a verifiable credential and the user presenting the verifiable credential. This update forces all Verifiable Credentials to be reissued in Microsoft Authenticator for iOS. [More information](whats-new.md?#microsoft-authenticator-did-generation-update)

## February 2022

We're rolling out some breaking changes to our service. These updates require Microsoft Entra Verified ID service reconfiguration. End-users need to have their verifiable credentials reissued.

- The Microsoft Entra Verified ID service can now store and handle data processing in the Azure European region.
- Microsoft Entra Verified ID customers can take advantage of enhancements to credential revocation. These changes add a higher degree of privacy through the implementation of the [W3C Status List 2021](https://w3c-ccg.github.io/vc-status-list-2021/) standard.
- We made updates to Microsoft Authenticator that change the interaction between the Issuer of a verifiable credential and the user presenting the verifiable credential. This update forces all Verifiable Credentials to be reissued in Microsoft Authenticator for Android. [More information](whats-new.md?#microsoft-authenticator-did-generation-update)


### Microsoft Entra Verified ID available in Europe

Since the beginning of the Microsoft Entra Verified ID service public preview, the service has only been available in our Azure North America region. Now, the service is also available in our Azure Europe region.

- New customers with Microsoft Entra European tenants now have their Verifiable Credentials data located and processed in our Azure Europe region.
- Customers with Microsoft Entra ID tenants setup in Europe who start using the Microsoft Entra Verified ID service after February 15, 2022, have their data automatically processed in Europe. There's no need to take any further actions.
- Customers with Microsoft Entra ID tenants setup in Europe that started using the Microsoft Entra Verified ID service before February 15, 2022, are required to reconfigure the service on their tenants before March 31, 2022.

Take the following steps to configure the Verifiable Credentials service in Europe:

1. [Check the location](verifiable-credentials-faq.md#how-can-i-check-my-microsoft-entra-tenants-region) of your Microsoft Entra ID to make sure is in Europe.
1. [Reconfigure the Verifiable Credentials service](verifiable-credentials-faq.md#how-do-i-reset-the-microsoft-entra-verified-id-service) in your tenant.


#### Are there any changes to the way that we use the Request API as a result of this move?

Applications that use the Microsoft Entra Verified ID service must use the Request API endpoint that corresponds to their Microsoft Entra tenant's region.  

| **Tenant region** | **Request API endpoint POST** |
|------------|-------------------|
| Europe | `https://beta.eu.did.msidentity.com/v1.0/{tenantID}/verifiablecredentials/request` |
| Non-EU | `https://beta.did.msidentity.com/v1.0/{tenantID}/verifiablecredentials/request`  |

To confirm which endpoint you should use, we recommend checking your Microsoft Entra tenant's region as described previously. If the Microsoft Entra tenant is in the EU, you should use the Europe endpoint.  

### Microsoft Authenticator DID Generation Update

We're making protocol updates in Microsoft Authenticator to support Single Long Form DID, thus deprecating the use of pairwise. With this update, your DID in Microsoft Authenticator is used for every issuer and relaying party exchange. Holders of verifiable credentials using Microsoft Authenticator must get their verifiable credentials reissued as any previous credentials aren't going to continue working.

## December 2021

- We added [Postman collections](https://github.com/Azure-Samples/active-directory-verifiable-credentials/tree/main/Postman) to our samples as a quick start to start using the Request Service REST API.
- New sample added that demonstrates the integration of [Microsoft Entra Verified ID with Microsoft Entra B2C](https://github.com/Azure-Samples/active-directory-verifiable-credentials/tree/main/B2C).
- Sample for setting up the Microsoft Entra Verified ID services using [PowerShell and an ARM template](https://github.com/Azure-Samples/active-directory-verifiable-credentials/tree/main/ARM).
- Sample Verifiable Credential configuration files to show sample cards for [ID Token](https://github.com/Azure-Samples/active-directory-verifiable-credentials/tree/main/CredentialFiles/IDToken), [IDTokenHit](https://github.com/Azure-Samples/active-directory-verifiable-credentials/tree/main/CredentialFiles/IDTokenHint) and [Self-attested](https://github.com/Azure-Samples/active-directory-verifiable-credentials/tree/main/CredentialFiles/IDTokenHint) claims.

## November 2021

- We made updates to the Request Service REST API for [issuance](issuance-request-api.md?#callback-type) and [presentation](presentation-request-api.md?#callback-type). Callback types enforcing rules so that URL endpoints for callbacks are reachable.
- UX updates to the Microsoft Authenticator verifiable credentials experience: Animations on card selection from the wallet.

## October 2021

You can now use [Request Service REST API](get-started-request-api.md) to build applications that can issue and verify credentials from any programming language. This new REST API provides an improved abstraction layer and integration to the Microsoft Entra Verified ID Service.

## April 2021

You can now issue [verifiable credentials](decentralized-identifier-overview.md) in Microsoft Entra. This service is useful when you need to present proof of employment, education, or any other claim. The holder of such a credential can decide when, and with whom, to share their credentials. Each credential is signed by using cryptographic keys associated with the decentralized identity that the user owns and controls.
