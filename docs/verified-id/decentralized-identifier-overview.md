---
title: Introduction to Microsoft Entra Verified ID
description: An overview Microsoft Entra Verified ID.
author: barclayn
manager: femila
ms.service: entra-verified-id
ms.topic: overview
ms.date: 01/17/2025
ms.author: barclayn
ms.reviewer: 
---

# Introduction to Microsoft Entra Verified ID

In today's world, our digital and physical lives are becoming increasingly intertwined with the apps, services, and devices we use. This digital revolution opened a world of possibilities, allowing us to connect with countless companies and individuals in ways that were once unimaginable. 

This increased connectivity introduces a greater risk of identity theft and data breaches. These breaches can be devastating to our personal and professional lives. Microsoft actively collaborates with various organizations and standards bodies to create a Decentralized Identity solution that puts individuals in control of their own digital identities. Decentralized identity technologies provide a secure and private way to manage identity data without relying on centralized authorities or intermediaries.

## Why we need decentralized identity

Today we use our digital identity at work, at home, and across every app, service, and device we use. This identity is made up of everything we say, do, and experience in our lives—purchasing tickets for an event, checking into a hotel, or even ordering lunch. Currently, our identity and all our digital interactions are dependent on third parties, in some cases, even without our knowledge.

Every day users grant apps and devices access to their data. A great deal of effort would be required for them to keep track of who has access to which pieces of information. On the enterprise front, collaboration with consumers and partners requires high-touch orchestration to securely exchange data in a way that maintains privacy and security for all involved.

We believe a standards-based Decentralized Identity system can unlock a new set of experiences that give users and organizations greater control over their data—and deliver a higher degree of trust and security for apps, devices, and service providers.

## Lead with open standards

Microsoft is actively collaborating with members of the Decentralized Identity Foundation (DIF), the W3C Credentials Community Group, and the wider identity community. The following standards are implemented in our services.

* [W3C Decentralized Identifiers](https://www.w3.org/TR/did-core/)
* [W3C Verifiable Credentials](https://www.w3.org/TR/vc-data-model/)
* [DIF Sidetree](https://identity.foundation/sidetree/spec/)
* [DIF Well Known DID Configuration](https://identity.foundation/specs/did-configuration/)
* [DIF DID-SIOP](https://identity.foundation/did-siop/)
* [DIF Presentation Exchange](https://identity.foundation/presentation-exchange/)


## What are DIDs?

Before we can understand DIDs, it helps to compare them with other identity systems. Email addresses and social network IDs are human-friendly aliases that  for collaboration but are now overloaded to serve as the control points for data access across many scenarios beyond collaboration. This situation creates a potential problem, because access to these IDs could be removed at any time.
Decentralized Identifiers (DIDs) are different. DIDs are user-generated, self-owned, globally unique identifiers rooted in decentralized trust systems. They possess unique characteristics, like greater assurance of immutability, censorship resistance, and tamper evasiveness. These attributes are critical for any ID system intended to provide self-ownership and user control.

Microsoft’s verifiable credential solution uses decentralized credentials (DIDs) to cryptographically sign as proof that a relying party (verifier) is attesting to information proving their ownership of a verifiable credential. A basic understanding of DIDs is recommended for anyone creating a verifiable credential solution based on the Microsoft offering.

## What are Verifiable Credentials?

We use IDs in our daily lives. We have drivers licenses that we use as evidence of our ability to operate a car. Universities issue diplomas that prove we attained a level of education. We use passports to prove who we are to authorities as we arrive at foreign destinations. The data model describes how we could handle these types of scenarios when working over the internet but in a secure manner that respects users' privacy. You can get additional information in The [Verifiable Credentials Data Model 1.0](https://www.w3.org/TR/vc-data-model/).

In short, verifiable credentials are data objects consisting of claims made by the issuer attesting information about a subject. 
The schema identifies these claims. Claims include the DID of the issuer and the subject. The issuer's DID produces a digital signature as evidence of their attestation to this information


## How does Decentralized Identity work?

We need a new form of identity. We need an identity that brings together technologies and standards to deliver key identity attributes like self-ownership and censorship resistance. These capabilities are difficult to achieve using existing systems.

To deliver on these promises, we need a technical foundation made up of seven key innovations. One key innovation is user owned identifiers, a user agent to manage keys associated with such identifiers, and encrypted, user-controlled datastores.

:::image type="content" source="media/decentralized-identifier-overview/microsoft-did-system.png" alt-text="Diagram of a Microsoft verifiable credential environment.":::

**1. W3C Decentralized Identifiers (DIDs)**.
IDs users create, own, and control independently of any organization or government. DIDs are globally unique identifiers linked to Decentralized Public Key Infrastructure (DPKI) metadata composed of JSON documents that contain public key material, authentication descriptors, and service endpoints.

**2. Trust System**.
In order to be able to resolve DID documents, DIDs are typically recorded on an underlying network of some kind that represents a trust system. Microsoft currently supports DID:Web trust system. DID:Web is a permission based model that allows trust using a web domain’s existing reputation. DID:Web is in support status General Available.

**3. DID User Agent/Wallet: Microsoft Authenticator App**.
Enables real people to use decentralized identities and Verifiable Credentials. Microsoft Authenticator creates DIDs, facilitates issuance and presentation requests for verifiable credentials and manages the backup of your DID's seed through an encrypted wallet file.

**4. Microsoft Resolver**.
An API that looks up and resolves DIDs using the ```did:web```method and returns the DID Document Object (DDO). The DDO includes DPKI metadata associated with the DID such as public keys and service endpoints. 

**5. Microsoft Entra Verified ID Service**.
An issuance and verification service in Azure and a REST API for [W3C Verifiable Credentials](https://www.w3.org/TR/vc-data-model/) that are signed with the ```did:web``` method. They enable identity owners to generate, present, and verify claims. This service forms the basis of trust between users of the systems.

## A sample scenario

The scenario we use to explain how verifiable credentials work involves:

- Woodgrove Inc. a company.
- Proseware, a company that offers Woodgrove employees discounts.
- Alice, an employee at Woodgrove, Inc. who wants to get a discount from Proseware



Today, Alice provides a username and password to sign in Woodgrove’s networked environment. Woodgrove is deploying a verifiable credential solution to provide a more manageable way for Alice to prove her employment status at Woodgrove. Proseware accepts verifiable credentials issued by Woodgrove as proof of employment that can give access to corporate discounts as part of their corporate discount program.

Alice requests Woodgrove Inc for a proof of employment verifiable credential. Woodgrove Inc attests Alice's identity and issues a signed verifiable credential that Alice can accept and store in her digital wallet application. Alice can now present this verifiable credential as a proof of employment on the Proseware site. After a successful credential presentation, Alice qualifies for Proseware discounts. The transaction is logged in Alice's wallet application. Log entries help Alice track where and to whom she presented her proof of employment verifiable credential.

:::image type="content" source="media/decentralized-identifier-overview/did-overview.png" alt-text="Diagram of a DID deployment example.":::

## Roles in a verifiable credential solution 

There are three primary actors in the verifiable credential solution. In the following diagram:

- In **Step 1**, the **user** requests a verifiable credential from an issuer.
- In **Step 2**, the **issuer** of the credential attests that the proof the user provided is accurate and creates a verifiable credential signed with their DID for which the user’s DID is the subject.
- In **Step 3**, the user signs a verifiable presentation (VP) with their DID and sends it to the **verifier.** The verifier then validates the credential by matching it against the public key placed in the DPKI.

The roles in this scenario are:

:::image type="content" source="media/decentralized-identifier-overview/issuer-user-verifier.png" alt-text="Diagram showing the roles in a verifiable credential environment.":::

### Issuer

The issuer is an organization that creates an issuance solution requesting information from a user. The information is used to verify the user’s identity. For example, Woodgrove, Inc. has an issuance solution that enables them to create and distribute verifiable credentials (VCs) to all their employees. The employee uses the Authenticator app to sign in with their username and password, which passes an ID token to the issuing service. Once Woodgrove, Inc. validates the ID token submitted, the issuance solution creates a VC that includes claims about the employee and is signed with Woodgrove, Inc. DID. The employee now has an employer signed verifiable credential which includes the employee's DID as the subject DID.

### User

The user is the person or entity that is requesting a VC. For example, Alice is a new Woodgrove employee and was previously issued her proof of employment verifiable credential. When Alice needs to provide proof of employment to get a discount at Proseware, she can grant access to the credential in her Authenticator app by signing a verifiable presentation that proves Alice is the owner of the DID. Proseware is able to validate Woodgrove issued  credentials and Alice's verifiable credential ownership.

### Verifier

The verifier is a company or entity who needs to verify claims from one or more issuers they trust. For example, Proseware trusts Woodgrove, Inc. does an adequate job of verifying their employees’ identity and issuing authentic and valid VCs. When Alice tries to order the equipment she needs for her job, Proseware uses open standards such as Self-Issued OpenID Provider (SIOP) and Presentation Exchange to request credentials from the User proving they are an employee of Woodgrove, Inc. For example, Proseware might provide Alice a link to a website with a QR code she scans with her phone camera. This initiates the request for a specific VC, which Authenticator will analyze and give Alice the ability to approve the request to prove her employment to Proseware. Proseware can use the verifiable credentials service API or SDK, to verify the authenticity of the verifiable presentation. Based on the information provided by Alice they give Alice the discount. If other companies and organizations know that Woodgrove, Inc. issues VCs to their employees, they can also create a verifier solution and use the Woodgrove, Inc. verifiable credential to provide special offers reserved for Woodgrove, Inc. employees.

> [!NOTE]
> The verifier can use open standards to perform the presentation and verification, or [configure their own Microsoft Entra tenant](verifiable-credentials-configure-tenant.md) to let the Microsoft Entra Verified ID service perform most of the work.

## Next steps

Now that you know about DIDs and verifiable credentials try them yourself by following our get started article or one of our articles providing more detail on verifiable credential concepts.

- [Get started with verifiable credentials](verifiable-credentials-configure-tenant.md)
- [How to customize your credentials](credential-design.md)
- [Verifiable credentials FAQ](verifiable-credentials-faq.md)
