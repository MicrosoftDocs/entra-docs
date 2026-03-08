---
title: Integrate Verified ID APIs
description: Learn how you can implement Microsoft Entra Verified ID in your solutions.
ms.topic: how-to
ms.date: 11/04/2025
---

# Integrate Verified ID APIs

Integrating with Microsoft Entra Verified ID APIs enables organizations to deliver secure, privacy-respecting identity verification experiences at scale. This technical integration pattern provides a clear blueprint for partners and developers to connect their identity verification workflows with Verified ID, ensuring interoperability, compliance, and a seamless user journey.
This document walks you through the essential steps, architectural considerations, and best practices for implementing Verified ID in your solutions—helping you build integrations that are robust, scalable, and future-ready.

The diagram shows a low-level workflow of how all parties interact with each other in a remote onboarding scenario. This integration pattern could be used as a reference. 

:::image type="content" source="media/integration-guidance/identity-verification-integration.png" alt-text="Screenshot of the IDV integration pattern." lightbox="media/integration-guidance/identity-verification-integration.png":::

The following section covers a set of steps that IDVs can use for setting up issuance flows and by customers for verifying IDV Verified IDs.

## Issuer flow
Identity Verification (IDV) partners are Independent Software vendors (ISVs) who can use Verified ID Request Service REST API to issue Verified IDs. The steps required by an IDV to function as an issuer are as follows:

1.	Set up Microsoft Entra Verified ID Service: using [Quick setup](verifiable-credentials-configure-tenant-quick.md) or [Advanced setup instructions](verifiable-credentials-configure-tenant.md).
    >[!Note]
    >For a multi-tenant model, IDV should explore setting up dedicated authorities if there is a 1:1 relationship required with the customer. Refer to the [Admin API](admin-api.md) section of the docs for creating authorities. 

2.	Set up a credential definition that defines what type of credentials you'll issue from the service – [Custom Credential](credential-design.md). Based on the scenario, select between ID token (for Open ID connect attestations from providers) or ID token hint (ISVs to use REST APIs to get the required attestations), self issued (user provided input), presentation or multiple attestations.

3.	Make sure to publish the credential in the Verified ID network if this credential is for general purpose consumption. If this credential was created for a specific customer, then skip this step. To publish the credential in the Verified ID network, select **Issue a credential** option under Manage and then select **Publish credential to Verified ID network** checkbox. You could also use [Admin APIs](admin-api.md) to set **“availableInVcDirectory"** to true for the credential.

4.	The IDV must configure an offer or customer jumpstart URL for the user journey and integrate it in customer’s relying party application. Refer *step 5* in the diagram as an example.

5.	The end user starts the journey on the relying party application – in the example above, Contoso’s onboarding portal asks the user to prove their identity. If the user already has the required Verified ID for onboarding, they'll follow steps 1 through 4 in the diagram. If the user doesn’t have the required Verified ID, user has to launch the IDV offer URL from onboarding application to initiate the identity verification process. 
    The IDV and customer relying party need to build this redirection model. The IDV needs to identify that the user is coming to the IDV portal from a registered organization and isn't a SPAM request. The relying party needs to generate a “one-time” use url with a JWT token, for example: ```https://idvpartner.com/contoso/?token=jwt_token```

    Note that the JWT token is signed with customer's relying party private key and the public key is shared with the IDV via an endpoint or via a scheduled process. The IDV needs to ensure that for the kickstart journey, it uses attributes from the JWT like org ID, request ID, mscv ID, and expiry. Note that [mscv](https://github.com/microsoft/CorrelationVector) is preferred for end-to-end troubleshooting. An example of the JWT could be as follows:

    Header: Algorithm and Token type 
    ```json
    { 
        "alg": "RS256", 
        "typ": "JWT" 
    } 
    ```
    PAYLOAD: DATA 
    ```json
    { 
        "OrgId": "", 
        "RequestId": "", 
        "exp": 1684986555,
        "redirectUrl": "https://customerRPurl"
    }
    ```

6.	Upon successful completion, IDV kicks off Verified ID issuance flow and issues a Verified ID. At this point, user is presented with a deep link or QR code to **Add Card** in Microsoft Authenticator application. The IDV website receives a successful issuance callback from Verified ID service.
    >[!Note]
    > IDV partner must provide or build the required web experience where the identity of the user can be proofed in any way necessary as agreed between the relying party application and IDV partner. When the process is completed a list of values are collected according to the Verified ID Credential Type. These values (as “claims” parameter) are passed as part of the Verified ID issuance request API call. If the IDV is building this journey on a webapp, IDV needs to render it as a QR code or deep link.  For further details, refer to [Specify the Request Service REST API issuance request](issuance-request-api.md).

7.	IDV redirects the user back to the customer’s relying party application. 

8.	For the remainder of the steps in the diagram (that is, from steps 14 to 16), user is asked to present  Verified ID with FaceCheck. On successful presentation, user is onboarded to the system.

>[!Note]
> The customer must work with the IDV partner to set up the required IDV onboarding steps, which include organization onboarding, billing contracts, and other prerequisites.  

## Verifier flow

Application developers can use Verified ID issued by IDVs for the verification flows in their applications. Refer [planning a verification solution](plan-verification-solution.md) document for planning details. The steps required to setup verification are as follows:
1.	Set up Microsoft Entra Verified ID Service: using [Quick setup](verifiable-credentials-configure-tenant-quick.md) or [Advanced setup instructions](verifiable-credentials-configure-tenant.md).
2.	If you have details like **VCType** and **did** from the IDV partner, then you can use the payload reference from [Presentation Request API](presentation-request-api.md) section to verify Verified IDs issued by Identity verification partners (IDVs). 
3. Customers can also generate the presentation request API payload using the following steps:
	1. Go to **Microsoft Entra admin center** -> **Verified ID**.
	2. Select **Create Verification Request** tab

    :::image type="content" source="media/integration-guidance/verifiable-credentials-network-verifier.png" alt-text="Screenshot of create a verification request.":::

    3.	Choose **Select first user**.
    4.	Look for the respective **IDV** in the Search/select issuers drop-down menu by typing their name for example *woodgrove.com*.
    5.	Select the credential type that your application requires from the IDV for verification. This is also referred as *VCType* in Presentation Request API payload.
    6.	Select **Add** and then select **Review**.
    7.	Download the request body and Copy/paste POST API request URL.
    8.	Developers now have the request URL and body from their tenant admin and can follow these steps to update your application or website. To request Verified IDs from your users, include the request URL and body in your application or website.
    >[!Note]
    >Refer to Microsoft Entra Verified ID GitHub repository for sample applications [https://aka.ms/vcsample](https://aka.ms/vcsample).

    9.	Be sure to replace the values for the URL, state, and api-key with your respective values.
    10.	[Grant permissions](verifiable-credentials-configure-tenant.md#grant-permissions-to-get-access-tokens) to your app to obtain access token for the Verified ID service request service principal.

To test the user flow, you could always deploy one of the sample applications in your Azure App service environment, using [sample apps](https://aka.ms/vcsample) documentation.


## Next steps
Select a partner in the tables mentioned to learn how to integrate their solution with your application. Learn more:

- Microsoft Entra Verified ID demo website: https://aka.ms/vcdemo
- [GitHub samples](https://aka.ms/vcsample)
- Identity Challenge Demo with FaceCheck: https://aka.ms/facecheckdemo
- Specification for the Microsoft correlation vector [mscv](https://github.com/microsoft/CorrelationVector): this is a protocol for tracing and correlation of events through a distributed system based on a lightweight vector clock.
