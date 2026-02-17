---
title: Identity Proofing and Verification (IDV) Partner gallery for Microsoft Entra Verified ID
description: Learn how to integrate with our IDV partners to tailor your end-user experience to your needs.
ms.topic: how-to
ms.date: 12/16/2025
---

# Microsoft Entra Verified ID Identity Verification partners

Our Identity Verification (IDV) partner network extends Microsoft Entra Verified ID capabilities to help you build seamless end-user experiences. With Verified ID, you can integrate with IDV partners to enable scenarios like remote onboarding, secure access to resources and Account recovery with Government ID checks using identity verification and proofing services.

## IDV integrations

Verified ID supports two types of IDV integrations:

- **Security store based integration**: simple click to configure offers that can be purchased, subscribed and transacted via Security Store in Microsoft Entra ID Account Recovery and Microsoft Entra ID Governance Access Packages in-product experience. This pattern of integration doesn't require any custom billing contracts and customers can select the partner offers from the respective Microsoft Entra in-product feature page for Government ID checks with IDV partners. 
- **Verified ID API based integration**:  Microsoft Entra Verified ID offers REST APIs that customers and partners can use for using identity verification and proofing services integration from IDV Partners. This pattern requires customer to set up billing contracts directly with the IDV partner and the use of REST APIs for integration. The integration guidance page covers step by step process and flows for issuer and verifier integrations. 


## Partners

The following table showcases the list of Verified ID IDV partners. If you're an IDV partner seeking to get listed in this gallery, submit your solution details using the self-submission form: [https://aka.ms/VIDCertifiedPartnerForm](https://aka.ms/VIDCertifiedPartnerForm).


### Security store integration partners

| Partner | Partner offers | VerifiedIdentity Manifest uri | Description |
|---------|----------------------|-------------------------------|-------------|
| AU10TIX | [AU10TIX offer](https://securitystore.microsoft.com/solutions/au10tix1662380672540.au10tixverifiedid) | [VerifiedIdentity](https://verifiedid.did.msidentity.com/v1.0/tenants/7e3c5dae-db64-4f71-8eed-e9608f62da12/verifiableCredentials/contracts/370f04a8-c259-5ef7-b61a-a4302ddb2a78/manifest) | AU10TIX improves Verifiability While Protecting Privacy For Businesses, Employees, Contractors, Vendors, And Customers. |
| IDEMIA | [IDEMIA offer](https://securitystore.microsoft.com/solutions/idemia.idemia-id-one-trust-vc) | [VerifiedIdentity](https://verifiedid.did.msidentity.com/v1.0/tenants/927eef35-435d-482f-be37-477c1a5164d4/verifiableCredentials/contracts/07b489b6-b20d-55af-2b38-62a7562ccde9/manifest) | IDEMIA Integration with Microsoft Entra Verified ID enables "Verify once, use everywhere" functionality. |
| TrueCredential (LexisNexis) | [TrueCredential offer](https://securitystore.microsoft.com/solutions/whoiamai1647469237981.truecredential) | [VerifiedIdentity](https://verifiedid.did.msidentity.com/v1.0/tenants/1dd3b364-3147-4083-96ac-e66b1e1f7b5f/verifiableCredentials/contracts/ac0bf718-61fe-2d72-f7ef-3131699bc9ed/manifest) | TrueCredential is a secure identity verification solution powered by LexisNexis Risk Solutions, leveraging Microsoft Entra Verified ID to deliver trusted, decentralized credentials. |


### Verified ID API based integration partners

| Partner | Partner offers | Description |
|---------|----------------------|-------------|
| 1Kosmos | [1Kosmos deployment guide](https://docs.1kosmos.com/productdocs/docs/verifiable-credentials/1Kosmos-entra-verified-id/) | 1Kosmos and Microsoft Entra Verified ID unite to deliver trusted, privacy-preserving identity verification that empowers secure, passwordless access across ecosystems. |
| AU10TIX | [AU10TIX documentation](https://info.au10tix.com/hubfs/PDFs/AU10TIX-Verified-ID-Deployment-Guide.pdf) | AU10TIX improves Verifiability While Protecting Privacy For Businesses, Employees, Contractors, Vendors, And Customers. |
| CLEAR | [CLEAR documentation](https://ir.clearme.com/news-events/press-releases/detail/25/clear-collaborates-with-microsoft-to-create-more-secure) | CLEAR Collaborates with Microsoft to Create More Secure Digital Experience Through Verification Credential. |
| Entrust (formerly Onfido) | [Entrust documentation](https://www.entrust.com/blog/2025/11/verify-every-user-and-empower-your-workforce-with-entrust-and-microsoft-entra-verified-id) | Entrust integrates high-assurance, phishing-resistant identity verification with Microsoft Entra Verified ID to unlock trusted user-owned credentials, enabling advanced security and a seamless, frictionless user experience. |
| ID Dataweb | [ID Dataweb deployment guide](https://docs.iddataweb.com/docs/microsoft) | ID Dataweb offers secure and low friction identity verification processes to ensure the validity of your Microsoft Entra Verified ID credential. Easy to integrate, easy for your users, secure for your enterprise. |
| IDEMIA | [IDEMIA documentation](https://na.idemia.com/identity/verifiable-credentials/) | IDEMIA Integration with Microsoft Entra Verified ID enables "Verify once, use everywhere" functionality. |
| Jumio | [Jumio deployment guide](https://www.jumio.com/microsoft-verifiable-credentials/) | Jumio is helping to support a new form of digital identity by Microsoft based on verifiable credentials and decentralized identifiers standards to let consumers verify once and use everywhere. |
| LexisNexis | [LexisNexis documentation](https://solutions.risk.lexisnexis.com/did-microsoft) | LexisNexis risk solutions Verifiable credentials enable faster onboarding for employees, students, citizens, or others to access services. |
| Persona | [Persona deployment guide](https://help.withpersona.com/articles/2sjBNj9gDT6ea7kShXVb5q/) | Persona integrates with Microsoft Entra Verified ID to unlock identity verification processes, enabling trusted user-owned credentials and frictionless onboarding. |
| Transmit Security | [Transmit Security deployment guide](https://developer.transmitsecurity.com/guides/verify/integrate_idv_with_endtraid/) | Mosaic by Transmit Security integrates with Microsoft Entra Verified ID to deliver seamless, secure, and accurate identity verification through verifiable credentials. |
| Vu | [Vu documentation](https://www.vusecurity.com/es/products/digital-identity) | Vu verifiable credentials with just a selfie and your ID. |
| ZealID | [ZealID deployment guide](https://developer.zealid.com/docs/zealid-vc) | ZealID Verified Credential Wallet powered by Microsoft Entra Verified ID completes the full cycle of identification and signing for various workflows. |


## Next steps

Select a partner in the tables mentioned to learn how to integrate their solution with your application. Learn more

* Microsoft Entra Verified ID demo website: [https://aka.ms/vcdemo](https://aka.ms/vcdemo)
* GitHub samples: [https://aka.ms/vcsample](https://aka.ms/vcsample)
* Identity Challenge Demo with FaceCheck: [https://aka.ms/facecheckdemo](https://aka.ms/facecheckdemo) 
* Specification for the Microsoft correlation vector [mscv](https://github.com/microsoft/CorrelationVector): this is a protocol for tracing and correlation of events through a distributed system based on a lightweight vector clock.
