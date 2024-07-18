---
title: Tutorial - Using Face Check (Preview) with Entra Verified ID and unlocking high assurance verifications at scale
description: In this tutorial, you learn how to use Face Check with Entra Verified ID
ms.service: entra-verified-id

author: barclayn
manager: amycolannino
ms.author: barclayn
ms.topic: tutorial
ms.date: 10/06/2023
# Customer intent: As an enterprise, we want to enable customers to manage information about themselves by using verifiable credentials.

---

# Using Face Check (Preview) with Entra Verified ID and unlocking high assurance verifications at scale


Face Check is a privacy-respecting facial matching. It allows enterprises to perform high-assurance verifications securely, simply, and at scale. Face Check adds a critical layer of trust by performing facial matching between a user’s real-time selfie and a photo. The facial matching is powered by Azure AI services. By sharing only the match results and not any sensitive identity data, Face Check protects user privacy while allowing organizations to be sure the person claiming an identity is really them.

:::image type="content" source="media/using-facecheck/verify-confirm-review.png" alt-text="Screenshot of using Face Check.":::

## Prerequisites
Face Check is a premium feature within Verified ID. You need to enable the Face Check Add-on in your Entra Verified ID setup before doing Face Check verifications.

> [!IMPORTANT]
> The Face Check Add-on can only be enable from the Entra portal. Admin API support for this feature. 

- If this is the first time using Entra Verified ID, [set up your tenant](./verifiable-credentials-configure-tenant-quick.md).
- [Associate or add an Azure subscription to your Microsoft Entra tenant](/entra/fundamentals/how-subscriptions-associated-directory)
- Make sure the user setting up Face Check has [Contributor role for the Azure subscription](/azure/role-based-access-control/built-in-roles/general#contributor)

### Setting up the Face Check with Entra Verified ID
1. In the Verified ID overview page, scroll down to the new Add-ons section and `Enable` the Face Check add-on.

:::image type="content" source="media/using-facecheck/face-check-add-on.png" alt-text="Screenshot of the Face Check add-on.":::

1. In the Link a subscription step, select a Subscription, a Resource group, and the Resource location. Then select `Validate`. If there are no subscriptions listed, see [What if I can't find a subscription?](using-facecheck.md#what-if-i-cant-find-a-subscription)

:::image type="content" source="media/using-facecheck/face-check-subscription-linking.png" alt-text="Screenshot subscription linking for Face Check.":::

1. Once validated you can `Enable` the add-on.

:::image type="content" source="media/using-facecheck/face-check-add-on-enabled.png" alt-text="Screenshot Face Check add-on enabled.":::

Now you can start using Face Check in your enterprise applications.

## Get started with Face Check using MyAccount

You can easily get started using Face Check by using [MyAccount](https://myaccount.microsoft.com), which can issue `VerifiedEmployee` credentials, and a public test app that Microsoft provides. To get started, you need to perform the following steps:

1. Create a test user in your [Microsoft Entra tenant](https://entra.microsoft.com/#view/Microsoft_AAD_UsersAndTenants/UserManagementMenuBlade/~/AllUsers/menuId/) and upload a photo of [yourself](https://support.microsoft.com/office/add-your-profile-photo-to-microsoft-365-2eaf93fd-b3f1-43b9-9cdc-bdcd548435b7#:~:text=1%20Find%20a%20photo%20you%20want%20to%20use,your%20initials%20or%20an%20icon%20...%20See%20More)
1. Go to [MyAccount](verifiable-credentials-configure-tenant-quick.md#myaccount-available-now-to-simplify-issuance-of-workplace-credentials), sign in as the test user and issue a `VerifiedEmployee` credential for the user.
1. Use the [public test app](https://aka.ms/vcempver) to present your `VerifiedEmployee` credential using Face Check.

When the Microsoft Authenticator gets a presentation request including a Face Check, there's an extra item after the credential type the user is asked to share. When the user selects on that item, the actual Face Check is performed and the user can then share the requested credential and the confidence score of the check with the public test app (relying party). You could review the results on the Test app.

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
// POST https://verifiedid.did.msidentity.com/v1.0/verifiableCredentials/createPresentationRequest
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

## Frequently asked questions for Face Check with Microsoft Entra Verified ID

### What is Face Check?

Microsoft Entra Verified ID is a managed verifiable credential service that lets organizations build unique user-owned identity scenarios through a network of identity credential issuers, verifiers, and presenters.

Face Check with Microsoft Entra Verified ID is a premium feature within Verified ID used for privacy-respecting facial matching. It allows enterprises to perform high-assurance verifications securely, simply, and at scale. Face Check adds a critical layer of trust by performing facial matching between a user’s real-time selfie and a photo. The facial matching is powered by Azure AI services.


### What is the difference between Face Check and Face ID?

Face ID is a vision based biometric security option offer on Apple products for unlocking a device to access to a mobile app. Face Check is a Microsoft Entra Verified ID feature that also uses vision based AI technology, but compares the user to the presented Verified ID. Face Check determines the user identity across a wide range of online scenarios where high-assurance access is required. Some examples of that are high value business processes or access to sensitive company information. Both mechanisms require a user to face a camera in the process but operate in different ways.

### Is the Face Check biometric vision check performed on the mobile device?

 No. The biometric check between the photo and the liveness data captured is performed in the cloud, using [Azure AI Vision Face API](/azure/ai-services/computer-vision/overview-identity). The user selfie capture during the process isn't shared with the requesting ID verifying site.

### What is Face Liveness Check?

Face Check with Microsoft Entra Verified ID uses Azure AI Vision Face API liveness check to verify that it's a real person in the selfie footage from the camera on the user’s device. This check helps ensure that a static photo or a 2D video of a user can't be used in place of their live self.

### What happens to the liveness data taken?

When the camera is turned on the mobile device, live footage is captured on the mobile device. This footage is then passed to Verified ID who uses it to invoke services of Azure AI services.

Data isn't stored by or kept by any of the services Microsoft Authenticator, Verified ID, or Azure AI. Furthermore, the footage isn't shared with the verifier application either. The verifier application only gets the confidence score in return. In an AI based system the confidence score is the probability percentage answer for a query to the system. For this scenario the confidence score is the likelihood the Verified ID user photo matches user capture on the mobile device.
Data and privacy for Azure AI Services can be found [here](/legal/cognitive-services/face/data-privacy-security).

### How much does Face Check cost?
For the latest information about usage billing and pricing, see [Microsoft Entra pricing](https://www.microsoft.com/security/business/identity-access-management/azure-ad-pricing).

## Frequently asked questions for Face Check Developers 
### Does Face Check Require MS Authenticator?

Yes. Face Check is limited to Verified ID usage with MS Authenticator. This limitation is in place to prevent injection attack on Face Check. For non-Face Check scenarios, a Wallet SDK is available other Verified ID solutions. More info [here](using-wallet-library.md)

### What is the confidence percentage match and what does confidence mean?

Face Check uses the same default confidence matching threshold as Windows Hello for Business. Developers can adjust it up or down depending on their specific usage scenario. The higher the confidence score, the more likely the match result isn't a false positive.

### What is Azure AI Vision Face API?

Azure AI is a suite of cloud services on the Azure Platform. The Azure AI Vision Face API offers services for face detection, face recognition, face match, and liveness check. Microsoft Entra Verified ID uses face detection, face match, and face liveness check services when performing the FaceCheck. More information can be [here](/azure/ai-services/computer-vision/overview-identity).

### How fair is Azure AI Vision Face API?

Microsoft has conducted fairness testing of the Face API. The Azure AI services team is continuously striving to ensure responsible and inclusive use of AI.
View the [Face API Fairness report](https://visionstudio-dev-8.azurewebsites.net/responsibleAI/face-fairness/information).

### What if I can't find a subscription?
If no subscriptions are available in the Link a subscription pane, here are some possible reasons:

You don't have the appropriate permissions. Be sure to sign in with an Azure account that's assigned at least the Contributor role within the subscription or a resource group within the subscription.

A subscription exists, but it isn't associated with your directory yet. You can [associate an existing subscription to your tenant](/entra/fundamentals/how-subscriptions-associated-directory) and then repeat the steps for linking it to your tenant.

No subscription exists. In the Link a subscription pane, you can create a subscription by selecting the link if you don't already have a subscription you may create one here. After you create a new subscription, you'll need to [create a resource group](/azure/azure-resource-manager/management/manage-resource-groups-portal) in the new subscription, and then repeat the steps for linking it to your tenant.

### Are you iBeta Level 2 conformant?

Yes. Azure Face API AI and Face Check are iBeta Level 2 conformant to be resistant to various presentation styles of attack to impersonate a user. [Learn more](https://www.ibeta.com/iso-30107-3-presentation-attack-detection-confirmation-letters/) about iBeta’s ISO Presentation Attack Detection testing.

### How fair is Azure AI Vision Face API?

Microsoft conducted fairness testing of the Face API. The Azure AI Services team is continuously striving to ensure responsible and inclusive use of biometric AI. The Face API Fairness report is available [here](https://visionstudio-dev-8.azurewebsites.net/responsibleAI/face-fairness/information).

### What are the requirements for the photo in the Verified ID?

The photo should be clear and sharp in quality and no smaller than 200 pixels x 200 pixels. The face should be centered within the image and unobstructed from view.
More information on how facial points are detected in the image can be found here.

More information on how facial points are detected in the image can be found [here](/azure/cognitive-services/computer-vision/how-to/identity-detect-faces)

## Next steps

- Learn how to [configure your tenant for Microsoft Entra Verified ID](verifiable-credentials-configure-tenant-quick.md) and use MyAccount.
- Learn how to [issue Microsoft Entra Verified ID credentials from a web application](verifiable-credentials-configure-issuer.md).
- Learn how to [verify Microsoft Entra Verified ID credentials](verifiable-credentials-configure-verifier.md).
