---
title: Setting up LinkedIn workplace verification
description: A design pattern describing how to configure employment verification using LinkedIn
services: decentralized-identity
author: barclayn
manager: amycolannino
ms.service: entra-verified-id

ms.topic: conceptual
ms.date: 10/03/2023
ms.author: barclayn
---

# Setting up place of work verification on LinkedIn (Preview)

> [!IMPORTANT]
> Place of work verification on LinkedIn is in public preview. Currently, customers with 10K seats of more are prioritized.

If your organization wants its employees to get their place of work verified on LinkedIn, you need to follow these few steps:

1. Set up your Microsoft Entra Verified ID service by following the [quick setup instructions](verifiable-credentials-configure-tenant-quick.md).
1. The quick setup creates the VerifiedEmployee credential type automatically. But if you did set up Verified ID using the [manual setup instructions](verifiable-credentials-configure-tenant.md), then you need to manually [create](how-to-use-quickstart-verifiedemployee.md#create-a-verified-employee-credential) a Verified ID Employee credential.
1. Use [MyAccount](verifiable-credentials-configure-tenant-quick.md#myaccount-available-now-to-simplify-issuance-of-workplace-credentials) to issue your VerifiedEmployee credentials.
1. Send your Verified ID setup details along with your organization DID (decentralized identity), your LinkedIn profile, and LinkedIn company page to [ownyouridentity@microsoft.com](mailto:ownyouridentity@microsoft.com). We'll review your submission and follow up with next steps if accepted.

>[!IMPORTANT]
> The form requires that you provide your Microsoft account manager as the contact. The app version required is Android **4.1.813** or newer, or iOS we require **9.27.2173** or newer. Keep in mind that inside the app, the version number shows **9.27.2336**, but in the App store the version number would be **9.1.312** or higher.

>[!NOTE]
> Review LinkedIn's documentation for information on [verifications on LinkedIn profiles.](https://www.linkedin.com/help/linkedin/answer/a1359065).

## Deploying custom Webapp

If you prefer to deploy your own app to issue VerifiedEmployee credentials instead of using [MyAccount](https://myaccount.microsoft.com), then follow these instructions.

Deploying this custom webapp from [GitHub](https://github.com/Azure-Samples/VerifiedEmployeeIssuance) allows an administrator to have control over who can get verified and change which information is shared with LinkedIn.
There are two reasons to deploy the custom webapp for LinkedIn Employment verification.

1. You need control over who can get verified on LinkedIn. The webapp allows you to use user assignments to grant access.
1. You want more control over the issuance of the Verified Employee ID. By default, the Employee Verified ID contains a few claims:

   - ```firstname```
   - ```lastname```
   - ```displayname```
   - ```jobtitle```
   - ```upn```
   - ```email```
   - ```photo```

>[!NOTE]
>The web app can be modified to remove claims, for example, you may choose to remove the photo claim.

Installation instructions for the Webapp can be found in the [GitHub repository.](https://github.com/Azure-Samples/VerifiedEmployeeIssuance/blob/main/ReadmeFiles/Deployment.md)

## Architecture overview

Once the administrator configures the company page on LinkedIn, employees can get verified. The following are the high-level steps for the LinkedIn integration:

1. User starts the LinkedIn mobile app. 
1. The mobile app retrieves information from the LinkedIn backend and checks if the company is enabled for employment verification and it retrieves a URL to the custom Webapp.
1. If the company is enabled, the user can tap on the verify employment link, and the user is sent to either [MyAccount](https://myaccount.microsoft.com) or the custom webapp in a web view.
1. The user needs to provide their corporate credentials to sign in.
1. MyAccount or the custom webapp retrieves the user profile from Microsoft Graph including, ```firstname```, ```lastname```, ```displayname```, ```jobtitle```, ```upn```, ```email```, and ```photo``` and call the Microsoft Entra Verified ID service with the profile information.
1. The Microsoft Entra Verified ID service creates a verifiable credentials issuance request and returns the URL of that specific request.
1. MyAccount or the custom webapp redirects back to the LinkedIn app with this specific URL.
1. LinkedIn app wallet communicates with the Microsoft Entra Verified ID services to get the Verified Employment credential issued in their wallet, which is part of the LinkedIn mobile app.
1. The LinkedIn app then verifies the received verifiable credential.
1. If the verification is completed, they change the status to 'verified' in their backend system and is visible to other users of LinkedIn.

The diagram shows the dataflow of the entire solution.

   :::image type="content" source="media/linkedin-employment-verification/linkedin-employee-verification.png" alt-text="Diagram showing a high-level flow.":::

## Frequently asked questions

### Can I use Microsoft Authenticator to store my Employee Verified ID and use it to get verified on LinkedIn?

Currently the solution works through the embedded webview. We're working with LinkedIn to improve the experience in Microsoft authenticator or any compatible custom wallet to verify employment in the future.

### How do users sign-in?

[MyAccount](https://myaccount.microsoft.com) or the custom webapp is protected using Microsoft Entra ID. Users sign-in according to the administrator's policy, either with passwordless, regular username and password, with or without MFA, etc. With that there's proof a user is allowed to get issued a verified employee ID.

### What happens when an employee leaves the organization?

Nothing by default. You can choose the revoke the Verified Employee ID but currently LinkedIn isn't checking for that status.

### What happens when my Verified Employee ID expires?

LinkedIn asks you again to get verified, if you don’t, the verified checkmark is removed from your profile.

### Can former employees use this feature to get verified?

Currently this option only verifies current employment.
