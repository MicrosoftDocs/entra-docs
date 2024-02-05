---
title: Tutorial - Using FaceCheck with Verified ID and unlocking high assurance verifications at scale (Preview)
description: In this tutorial, you learn how to use FaceCheck with Verified ID
ms.service: decentralized-identity
ms.subservice: verifiable-credentials
author: barclayn
manager: amycolannino
ms.author: barclayn
ms.topic: tutorial
ms.date: 10/06/2023
# Customer intent: As an enterprise, we want to enable customers to manage information about themselves by using verifiable credentials.

---

# Using Face Check with Verified ID and unlocking high assurance verifications at scale (Preview)

> [!IMPORTANT]
> Face Check is currently in PREVIEW.
> This information relates to a prerelease product that may be modified before it's released. 

## Prerequisites

- [Set up a tenant for Microsoft Entra Verified ID](./verifiable-credentials-configure-tenant-quick.md).

## What is Face Check?

Face Check is a privacy-respecting facial matching. It allows enterprises to perform high-assurance verifications securely, simply, and at scale. Face Check adds a critical layer of trust by performing facial matching between a user’s real-time selfie and a photo.The facial matching is powered by Azure AI services. By sharing only the match results and not any sensitive identity data, Face Check protects user privacy while allowing organizations to be sure the person claiming an identity is really them.

:::image type="content" source="media/using-facecheck/verify-confirm-review.png" alt-text="Screenshot of using Face Check.":::

## Get started with Face Check using MyAccount

You can easily get started using Face Check by using [MyAccount](https://myaccount.microsoft.com), which can issue `VerifiedEmployee` credentials, and a public test app that Microsoft provides. To get started, you need to perform the following steps:

1. Create a test user in your [Entra tenant](https://entra.microsoft.com/#view/Microsoft_AAD_UsersAndTenants/UserManagementMenuBlade/~/AllUsers/menuId/) and upload a photo of [yourself](https://support.microsoft.com/en-us/office/add-your-profile-photo-to-microsoft-365-2eaf93fd-b3f1-43b9-9cdc-bdcd548435b7#:~:text=1%20Find%20a%20photo%20you%20want%20to%20use,your%20initials%20or%20an%20icon%20...%20See%20More)
1. Go to [MyAccount](verifiable-credentials-configure-tenant-quick.md#myaccount-available-now-to-simplify-issuance-of-workplace-credentials), sign in as the test user and issue a `VerifiedEmployee` credential for the user.
1. Use the [public test app](https://aka.ms/verifiedfacecheck) to present your `VerifiedEmployee` credential using Face Check.

When the Microsoft Authenticator gets a presentation request including a Face Check, there's an extra item after the credential type the user is asked to share. When the user clicks on that item, the actual Face Check is performed and the user can then share the requested credential and the confidence score of the check with the public test app (relying party). You could review the results on the Test app.

## Get started with Face Check using Request Service API

Apps can use [Request Service API](get-started-request-api.md?tabs=http%2Cissuancerequest%2Cfacecheck#presentation-request-example) to create request for users to perform a Face Check against a `VerifiedEmployee` credential, State Issued Government ID or a custom digital credential with a trusted photo. For example, a help desk service can request a Face Check against a `VerifiedEmployee` credential to verify the identity quickly and securely to enable a wide variety of self-service scenarios including activating a Passkey or resetting a password. To reduce compliance risk, apps receive a confidence score for match against the photo from the desired credential, without gaining access to liveness data. 

### Issuing a Verified ID credential with a photo

Custom credential types using the [idTokenHint](how-to-use-quickstart.md) attestation flow can also issue a Verified ID credential containing a photo. The credential definition needs to have the display and rules definition for the photo claim. 

The [display definition](rules-and-display-definitions-model.md#displayclaims-type) for the photo claim should have the type set to `image/jpg;base64url` in order to let Microsoft Authenticator understand that it should be rendered as a photo correctly.

```json
{ 
  "claim": "vc.credentialSubject.photo", 
  "label": "User picture", 
  "type": "image/jpg;base64url" 
} 
```

When setting the actual claim value of the photo, it should be in format `UrlEncode(Base64Encode(JPEG image))`.

```JSON
{ 
  "outputClaim": "photo", 
  "required": false, 
  "inputClaim": "photo", 
  "indexed": false 
} 
```

### Presentation request including Face Check

The JSON payload to the [Request Service API](get-started-request-api.md?tabs=http%2Cissuancerequest%2Cfacecheck#presentation-request-example) for creating a presentation request needs to specify that a Face Check should be performed.
The claim containing the photo must be named and you may optionally specify your confidence threshold as an integer between 50-100. The default is 70.

```json
POST https://verifiedid.did.msidentity.com/v1.0/verifiableCredentials/createPresentationRequest
...
  "requestedCredentials": [ 
    { 
      "type": "VerifiedEmployee", 
      "acceptedIssuers": [ "did:web:yourdomain.com" ], 
      "configuration": { 
        "validation": { 
          "allowRevoked": false, 
          "validateLinkedDomain": true, 
          "faceCheck": { 
            "sourcePhotoClaimName": "photo", 
            "matchConfidenceThreshold": 70 
          } 
        }     
```
  
#### Successful Face Check presentation_verified callback event

The JSON payload for the `presentation_verified` has more data when a Face Check was successfully during a Verified ID credential presentation. The faceCheck section is added which contains a matchConfidenceScore. Note, that it isn't possible to request and receive the presentation receipt when the request includes faceCheck.

```json
  "verifiedCredentialsData": [ 
    { 
      "issuer": "did:web:yourdomain.com", 
      "type": [ "VerifiableCredential", "VerifiedEmployee" ], 
      "claims": { 
        ... 
      }, 
      ... 
      "faceCheck": { 
        "matchConfidenceScore": 86.314159,
        "sourcePhotoQuality": "HIGH"
      } 
    } 
  ], 
```
 
#### Failed Face Check callback event

When the confidence score is lower than the threshold, the presentation request is failed and a `presentation_error` is returned. The verifying application doesn't get the score returned.

```json
{ 
  "requestId": "...", 
  "requestStatus": "presentation_error", 
  "state": "...", 
  "error": { 
    "code": "claimValidationError", 
    "message": "Match confidence score failing to meet the threshold." 
  } 
} 
```

The Authenticator displays an error message informing the user that the confidence score failed to meet the threshold.

:::image type="content" source="media/using-facecheck/facecheck-low-score.png" alt-text="Screenshot of low confidence score in Face Check.":::

## Frequently asked questions for Face Check

### What is Face Check?

Face Check in Verified ID is an open standards-based solution for high-assurance verifications. Powered by Azure AI services, Face Check assesses facial matching between a user’s real-time selfie and the photo in their Verified ID. (supplied from a passport or driver’s license). Providing business confidence, the user accessing sensitive info is really who they are.

There's a clear distinction between facial verification, also referred to as facial comparison, and controversial facial recognition. Facial verification is a consent-based process for proving a person is who they claim to be. Facial recognition tools are controversial and are used for surveillance and investigation without a person’s knowledge by government agencies.

### What is the difference between Face Check and Face ID?

Face ID is a vision based biometric security option offer on Apple products for unlocking a device to access to a mobile app. Face Check is a Microsoft Entra Verified ID feature that also uses vision based AI technology, but compares the user to the presented Verified ID. Face Check determines if the user identity is valid across a wide range of online scenarios where high-assurance access is required such as high value business processes or access to sensitive company information. Both mechanisms require a user to face a camera in the process but operate in different ways.

### Is the Face Check biometric vision check performed on the mobile device?

No. The biometric check between the photo and the liveness data captured is performed in the cloud, using [Azure AI Vision Face API](/azure/ai-services/computer-vision/overview-identity). The user selfie capture during the process isn't shared with the requesting ID verifying site.

### What happens to the liveness data taken?

When the camera is turned on the mobile device, live footage is captured on the mobile device. This footage is then passed to Verified ID who uses it to invoke services of Azure AI services.

Neither the Microsoft Authenticator, nor Verified ID or Azure AI Services store or keep this data. Furthermore, the footage isn't shared with the verifier application either. The verifier application only gets the confidence score in return. In an AI based system the confidence score is the probability percentage answer for a query to the system. For this scenario the confidence score is the likelihood the Verified ID user photo matches user capture on the mobile device.
Data and privacy for Azure AI Services can be found [here](/legal/cognitive-services/face/data-privacy-security).

### Does Face Check Require MS Authenticator?

Yes. Currently to ensure security Face Check is limited to Verified ID usage with MS Authenticator. For non-Face Check scenarios, a Wallet SDK is available other Verified ID solutions. More info [here](using-wallet-library.md)

### What is the confidence percentage match and what does confidence mean?

Today we use a default confidence matching value when verifying the user on par with Windows Hello. A developer can override and adjust the required confidence score to their specific usage scenario. The higher the confidence score, the lower the false-acceptance-rate is, i.e. the probability of an imposter getting incorrectly accepted in the system. This in turn increases the false-reject-rate, i.e. the probability of an authorized user getting rejected by the biometric system, so a balance is always needed when setting a threshold based on the usage scenario. For example, setting the confidence threshold between 80% to 90% during photo match verification correlates to a very low false-acceptance-rate and is suitable for most security applications. Though we would still recommend you trial different values in your scenarios to determine a suitable threshold that provides a good balance between the expected security vs user-experience.

### What is Azure AI Vision Face API?

Azure AI is a suite of cloud services on the Azure Platform. The Azure AI Vision Face API offers services for face detection, face recognition, face match, and liveness check. Entra Verified ID uses face detection, face match, and face liveness check services when performing the FaceCheck. More information can be [here](/azure/ai-services/computer-vision/overview-identity).

### What is Face Liveness Check?

The Azure AI Vision Face API liveness check verifies that it's a real person in the live footage from the camera on the device. It can detect a wide variety of spoofing techniques  and this helps ensure that a static photo or even a 2D video of a user can't be used in place of their live self.

### How much does Face Check cost?

Face Check is offered free of cost during the Public Preview period and can used by any Verified ID project. Later in the year we will announce billing models.

### Are you iBeta Level 2 conformant?

The current preview isn't iBeta Level 2. There will be updates to be conformant before general availability later in the year.

### How fair is Azure AI Vision Face API?

Microsoft has conducted fairness testing of the Face API. The Azure AI Services team is continuously striving to ensure responsible and inclusive use of biometric AI. The Face API Fairness report is available [here](https://visionstudio-dev-8.azurewebsites.net/responsibleAI/face-fairness/information).

### What are the requirements for the photo in the Verified ID?

Photo Requirements:

1. Photo is clear and sharp, not blurry, pixelated, distorted, or damaged.
1. Photo isn't altered to remove face blemishes or face appearance.
1. Photo must be in an RGB color and no smaller than 200 pixels by 200 pixels and 1 KB.
1. Glasses, masks, hats, headphones, head coverings, and face coverings aren't allowed. Face should be free of any obstructions.
1. Facial jewelry is allowed provided they don't hide your face.
1. Only one face should be visible in the photo.
1. Face should be in neutral front facing pose with both eyes open, mouth closed, with no extreme facial expressions or head tilt present.
1. Face should be free of any shadows or red eyes. Retake photo if either of this occur.
1. Background should be uniform and plain, free of any shadows.
1. Face should be centered within the image and fill at least 50% of the image.
1. Recommended Face size is 200 pixels x 200 pixels. Face sizes larger than 200 pixels x 200 pixels don't result in better AI quality.

More information on how facial points are detected in the image can be found [here](/azure/cognitive-services/computer-vision/how-to/identity-detect-faces)

## Next steps

- Learn how to [configure your tenant for Microsoft Entra Verified ID](verifiable-credentials-configure-tenant-quick.md) and use MyAccount.
- Learn how to [issue Microsoft Entra Verified ID credentials from a web application](verifiable-credentials-configure-issuer.md).
- Learn how to [verify Microsoft Entra Verified ID credentials](verifiable-credentials-configure-verifier.md).

