---
title: Mark an app as publisher verified
description: Describes how to mark an app as publisher verified. When an application is marked as publisher verified, it means that the publisher (application developer) verified the authenticity of their organization using a Cloud Partner Program (CPP) account that completed the verification process and associated this CPP account with that application registration.
author: rwike77
manager: CelesteDG
ms.author: ryanwi
ms.custom: 
ms.date: 05/31/2024
ms.reviewer: 
ms.service: identity-platform

ms.topic: how-to
#Customer intent: As a developer integrating my app with the Microsoft identity platform, I want to complete the publisher verification process for my app registration, so that users can see that my app is publisher verified and trust its authenticity.
---

# Mark your app as publisher verified

When an app registration has a verified publisher, it means that the publisher of the app has [verified](/partner-center/verification-responses) their identity using their Microsoft AI Cloud Partner Program account and has associated this account with their app registration. This article describes how to complete the [publisher verification](publisher-verification-overview.md) process.

## Quickstart
If you're already enrolled in the [Microsoft AI Cloud Partner Program](/partner-center/intro-to-cloud-partner-program-membership) and have met the [prerequisites](publisher-verification-overview.md#requirements), you can get started right away: 

1. Sign into the [App Registration portal](https://aka.ms/PublisherVerificationPreview) using [multifactor authentication](~/identity/authentication/concept-mfa-licensing.md)

1. Choose an app and select **Branding & properties**. 

1. Select **Add Partner ID to verify publisher** and review the listed requirements.

1. Enter your Partner One ID and select **Verify and save**.

For more details on specific benefits, requirements, and frequently asked questions see the [overview](publisher-verification-overview.md).

## Mark your app as publisher verified
Make sure you meet the [prerequisites](publisher-verification-overview.md#requirements), then follow these steps to mark your app as Publisher Verified.  

1. Sign in using [multifactor authentication](~/identity/authentication/concept-mfa-licensing.md) to an organizational (Microsoft Entra) account authorized to make changes to the app you want to mark as Publisher Verified and on the Microsoft AI Cloud Partner Program Account in Partner Center.

    - The Microsoft Entra user must have one of the following [roles](~/identity/role-based-access-control/permissions-reference.md): Application Administrator or Cloud Application Administrator. 

   - The user in Partner Center must have the following [roles](/partner-center/permissions-overview): Microsoft AI Cloud Partner Program Admin or Accounts Admin. 
      
1. Navigate to the **App registrations** blade:  

1. Select on an app you would like to mark as Publisher Verified and open the **Branding & properties** blade. 

1. Ensure the app’s [publisher domain](howto-configure-publisher-domain.md) is set. 

1. Ensure that either the publisher domain or a DNS-verified [custom domain](~/fundamentals/add-custom-domain.yml) on the tenant matches the domain of the email address used during the verification process for your CPP account.

1. Select **Add Partner ID to verify publisher** near the bottom of the page. 

1. Enter the **Partner ID** for: 

- A valid Cloud Partner Program account that has completed the verification process.  

    - The Partner global account (PGA) for your organization. 

1. Select **Verify and save**. 

1. Wait for the request to process, this may take a few minutes. 

1. If the verification was successful, the publisher verification window closes, returning you to the **Branding & properties** blade. You see a blue verified badge next to your verified **Publisher display name**. 

1. Users who get prompted to consent to your app start seeing the badge soon after you've gone through the process successfully, although it may take some time for updates to replicate throughout the system. 

1. Test this functionality by signing into your application and ensuring the verified badge shows up on the consent screen. If you're signed in as a user who has already granted consent to the app, you can use the *prompt=consent* query parameter to force a consent prompt. This parameter should be used for testing only, and never hard-coded into your app's requests.

1. Repeat these steps as needed for any more apps you would like the badge to be displayed for. You can use Microsoft Graph to do this more quickly in bulk, and PowerShell cmdlets are available soon. See [Making Microsoft API Graph calls](troubleshoot-publisher-verification.md#making-microsoft-graph-api-calls) for more info. 

That’s it! Let us know if you have any feedback about the process, the results, or the feature in general. 

## Next steps
If you run into problems, read the [troubleshooting information](troubleshoot-publisher-verification.md).
