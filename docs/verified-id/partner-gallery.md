---
title: Identity Proofing and Verification (IDV) Partner gallery for Microsoft Entra Verified ID
description: Learn how to integrate with our IDV partners to tailor your end-user experience to your needs.
ms.service: entra-verified-id
author: barclayn
manager: femila
ms.topic: how-to
ms.date: 04/30/2025
ms.author: barclayn
---

# Microsoft Entra Verified ID Identity Verification partners

Our Identity Verification (IDV) partner network extends Microsoft Entra Verified IDs capabilities to help you build seamless end-user experiences. With Verified ID, you can integrate with IDV partners to enable scenarios like remote onboarding with government ID checks using identity verification and proofing services.
The diagram below shows a low-level workflow of how all parties interact with each other in a remote onboarding scenario. This integration pattern could be used as a reference. 

:::image type="content" source="media/partner-gallery/vid-idv-integration.jpg" alt-text="Screenshot of the IDV integration pattern.":::

The following section covers a set of steps that could be used by IDVs for setting up issuance flows and by customers for verifying Verified IDs issued by IDVs.

## Issuer ISV (IDV) flow

These are Identity Verification (IDV) ISVs who can use Verified ID Request Service REST API to issue Verified IDs. The steps required by an IDV to function as an issuer are as follows:

1.	Set up Microsoft Entra Verified ID Service: using [Quick setup](verifiable-credentials-configure-tenant-quick.md) or [Advanced setup instructions](verifiable-credentials-configure-tenant.md).

> [!Note]
> For a multi-tenant model, IDV should explore setting up dedicated authorities if there is a 1:1 relationship required with the customer. Please refer to the [Admin API](admin-api.md) section of the docs for creating authorities. 

2.	Set up a credential definition that defines what type of credential(s) you will issue from the service – [Custom Credential](credential-design.md). There are multiple attestations flows that are supported by Verified ID. Based on the scenario and attestation requirements, select between ID token (for Open ID connect attestations from providers) or ID token hint (ISV’s to use REST APIs to get the required attestations), self issued (user provided input), presentation or multiple attestations.

3.	Make sure to publish the credential in the Verified ID network if this credential is for general purpose consumption. If this credential was created for a specific customer, then skip this step.  To publish the credential in the Verified ID network, select the **Issue a credential** option under Manage and then select the **Publish credential to Verified ID network** checkbox. You could also use [Admin APIs](admin-api.md) to set **“availableInVcDirectory"** to true for the credential.

4.	IDV must configure an offer or customer jumpstart URL for the user journey and integrate it in the customer's relying party application. Refer to *step 5* in the above diagram as an example.

5.	The end user starts the journey on the relying party application – in the example above, Contoso’s onboarding portal asks the user to prove their identity. If the user already has the required Verified ID for onboarding, they will follow steps 1 through 4 in the diagram above. If the user doesn’t have the required Verified ID, user has to launch the IDV offer URL from onboarding application to initiate the identity verification process. The IDV and customer relying party need to build this re-direction model. The IDV needs to identify that the user is coming to the IDV portal from a registered organization and is not a SPAM request. The relying party needs to generate a "one-time" use url with a JWT token, for example: `https://idvpartner.com/contoso/?token=jwt_token`

    The JWT token is signed with customer's relying party private key and the public key is shared with the IDV via an endpoint or via a scheduled process. The IDV needs to ensure that for the kickstart journey, it uses attributes from the JWT like org id, request id/mscv ID and expiry. Please note [mscv](https://github.com/microsoft/CorrelationVector) is preferred for end-to-end troubleshooting. An example of the JWT could be as follows:

    Header: Algorithm and Token type 
    ```json
    { 
        “alg”: “RS256”, 
        “typ”: “JWT” 
    } 
    ```
    PAYLOAD: DATA 
    ```json
    { 
        "OrgId": "", 
        "RequestId": "", 
        "exp": 1684986555,
        "redirectUrl": https://customerRPurl
    }
    ```

6.	Upon successful completion, IDV kicks off Verified ID issuance flow and issues a Verified ID. At this point, user is presented with a deep link or QR code to **Add Card** in Microsoft Authenticator application. The IDV website receives a successful issuance callback from Verified ID service.
   
    >[!Note]
    >
    >IDV partner must provide or build the required web experience where the identity of the user can be proofed in any way necessary as agreed between the relying party application and IDV partner. When the process is completed a list of values are collected according to the Verified ID Credential Type. These values (as “claims” parameter) are passed as part of the Verified ID issuance request API call. If the IDV is building this journey on a webapp, IDV needs to render it as a QR code or deep link.  For further details, refer [Specify the Request Service REST API issuance request](issuance-request-api.md)

8.	IDV redirects the user back to the customer’s relying party application. 

9.	For the remainder of the steps in the diagram above (i.e. from steps 14 till 16), user is asked to present  Verified ID with FaceCheck. On successful presentation, user is onboarded to the system.

>[!Note]
>Steps mentioned above are just technical integrations steps. Customer must work with IDV partner to setup the required IDV onboarding steps that include organization onboarding, billing contracts and other required pre-requisites.  

## Verifier flow

Application developers can use Verified ID issued by IDVs for the verification flows in their applications. Refer [planning a verification solution](plan-verification-solution.md) document for planning details. The steps required to setup verification are as follows:
1.	Set up Microsoft Entra Verified ID Service: using [Quick setup](verifiable-credentials-configure-tenant-quick.md) or [Advanced setup instructions](verifiable-credentials-configure-tenant.md).
2.	If you have details like **VCType** and **did** from the IDV partner, then you can use the payload reference from [Presentation Request API](presentation-request-api.md) section to verify Verified ID’s issued by Identity verification partners (IDVs). 
3. Customers can also generate the presentation request API payload using the following steps:
	1. Go to **Microsoft Entra admin center** -> **Verified ID**.
	2. Select **Create Verification Request** tab

    :::image type="content" source="media/partner-gallery/vcnetwork-verifier.png" alt-text="Screenshot of create a verification request.":::

    3.	Choose **Select first user**.
    4.	Look for the respective **IDV** in the Search/select issuers drop-down menu by typing their name for example *woodgrove.com*.
    5.	Select the credential type that your application requires from the IDV for verification. This is also referred as *VCType* in Presentation Request API payload.
    6.	Select **Add** and then select **Review**.
    7.	Download the request body and Copy/paste POST API request URL.
    8.	Developers now have the request URL and body from their tenant admin and can follow these steps to update your application or website. To request Verified IDs from your users, include the request URL and body in your application or website.
    >[!Note]
    >Refer Microsoft Entra Verified ID GitHub repository for sample applications [https://aka.ms/vcsample](https://aka.ms/vcsample)

    9.	Be sure to replace the values for the URL, state, and api-key with your respective values.
    10.	[Grant permissions](verifiable-credentials-configure-tenant.md#grant-permissions-to-get-access-tokens) to your app to obtain access token for the Verified ID service request service principal.

To test the user flow, you could always deploy one of the sample applications in your Azure App service environment, using [sample apps](https://aka.ms/vcsample) documentation.

## Partner list

The following table showcases the list of Verified ID  IDV partners. If you are an IDV partner seeking to get listed in this gallery, please submit your solution details using the self-submission form: [https://aka.ms/VIDCertifiedPartnerForm](https://aka.ms/VIDCertifiedPartnerForm).

| IDV partner | Description | Integration walkthroughs |
|:-------------------------|:--------------|:--------------|
|:::image type="content" source="media/partner-gallery/au10tix.png" alt-text="Screenshot of au10tix logo."::: | [AU10TIX](https://www.au10tix.com/solutions/verifiable-credentials/) improves Verifiability While Protecting Privacy For Businesses, Employees, Contractors, Vendors, And Customers. | [Configure Verified ID by AU10TIX as your Identity Verification Partner](https://aka.ms/au10tixvc). |
| :::image type="content" source="media/partner-gallery/lexisnexis.png" alt-text="Screenshot of a LexisNexis logo."::: | [LexisNexis](https://solutions.risk.lexisnexis.com/did-microsoft) risk solutions Verifiable credentials enable faster onboarding for employees, students, citizens, or others to access services. | [Configure Verified ID by LexisNexis Risk Solutions as your Identity Verification Partner](https://aka.ms/lexisnexisvc). |
| :::image type="content" source="media/partner-gallery/vu-logo.png" alt-text="Screenshot of a Vu logo."::: | [Vu](https://www.vusecurity.com/es/products/digital-identity) verifiable credentials with just a selfie and your ID.| [Configure Verified ID by VU Identity Card as your Identity Verification Partner](partner-vu.md) |
| :::image type="content" source="media/partner-gallery/onfido.jpeg" alt-text="Screenshot of an Onfido logo."::: | Start issuing and accepting verifiable credentials in minutes. With verifiable credentials and Onfido you can verify a person’s identity while respecting privacy. Digitally validate information on a person’s ID or their biometrics.| * |
| :::image type="content" source="media/partner-gallery/jumio.jpeg" alt-text="Screenshot of a Jumio logo."::: | [Jumio](https://www.jumio.com/microsoft-verifiable-credentials/) is helping to support a new form of digital identity by Microsoft based on verifiable credentials and decentralized identifiers standards to let consumers verify once and use everywhere.| * |
| :::image type="content" source="media/partner-gallery/idemia.png" alt-text="Screenshot of an Idemia logo."::: | [Idemia](https://na.idemia.com/identity/verifiable-credentials/) Integration with Verified ID enables “Verify once, use everywhere” functionality.| [Configure Verified ID by IDEMIA as your identity verification partner](idemia.md) |
| :::image type="content" source="media/partner-gallery/clear.jpeg" alt-text="Screenshot of a Clear logo."::: | [Clear](https://ir.clearme.com/news-events/press-releases/detail/25/clear-collaborates-with-microsoft-to-create-more-secure) Collaborates with Microsoft to Create More Secure Digital Experience Through Verification Credential.| * |

\* -  no documentation available yet

## Next steps

Select a partner in the tables mentioned to learn how to integrate their solution with your application. Learn more

* Entra Verified ID demo website for reference: [https://aka.ms/vcdemo](https://aka.ms/vcdemo)
* GitHub samples: [https://aka.ms/vcsample](https://aka.ms/vcsample)
* Identity Challenge Demo with FaceCheck: [https://aka.ms/facecheckdemo](https://aka.ms/facecheckdemo) 
* Specification for the Microsoft correlation vector [mscv](https://github.com/microsoft/CorrelationVector): this is a protocol for tracing and correlation of events through a distributed system based on a lightweight vector clock.

