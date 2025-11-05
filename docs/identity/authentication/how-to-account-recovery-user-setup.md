---
title: How End Users Can Set Up Account Recovery for Microsoft Entra ID
description: How end users can set up account recovery for Microsoft Entra ID.
ms.service: entra-id
ms.subservice: authentication
ms.topic: how-to
ms.date: 11/03/2025
ms.author: justinha
author: justinha
manager: dougeby
ms.reviewer: tilarso
ms.custom: sfi-ga-nochange, sfi-image-nochange
# Customer intent: As a Microsoft Entra Administrator, I want to learn how end users can set up account recovery for Microsoft Entra ID.
---

# How end users can perform account recovery in Microsoft Entra ID

Users can recover their accounts in just a few simple steps. In this topic, we'll explore how users can discover and start the account recovery process and what users can expect during the Identity Verification process through an organization's configured provider.

## User steps

1. Start by attempting to sign in to an application such as Microsoft Teams or directly at [https://login.microsoftonline.com](https://login.microsoftonline.com).
2. You will be presented with an initial authentication method to sign-in with.
3. As you are unable to use this method, select **Other ways to sign-in**. You will be presented with additional sign-in options. 
4. Unable to sign in with any methods, click **Recover your account**.

   :::image type="content" border="true" source="media/how-to-account-recovery-user-setup/sign-in.png" alt-text="Screenshot that shows how to sign in to set up account recovery."lightbox="media/how-to-account-recovery-user-setup/sign-in.png":::

5. You will be presented with an informational screen that explains the account recovery process and provides guidance to complete identity verification through the organization's configured external identity proofing service.
6. You then will be redirected to the identity proofing service configured by your organization, and starts the identity proofing process.

   >[!NOTE]
   >The specific steps required for identity verification may vary depending on the identity verification partner configured by your organization.
   >Below are common steps which a provider may present to a user. 

7. Open the camera on your mobile device, and scan the QR code on the website of the identity proofing application. 
8. After the identity proofing application or page opens on your mobile device, select **Continue**.
9. Enter your name and email, agree to the terms of use for the app, and select **Continue**.
10. Choose your country/region, and the type of identity verification document you have, such as a **Passport** or **Drivers License**.
11. Review how to take a clear document photo, and select **Continue** after you read each step.
12. After you take the photo, select **Submit photos**.
13. Review how to take a clear photo of your face, and select **Continue** after you read each step
14. After you take the photo, the identity proofing application or page verifies your identity, and will issue a Verifiable Credential into your Microsoft Authenticator app.

    >[!Note]
    > This may be presented by the provider as an option such as **Add Verifiable Credential** or **Open in Authenticator**.
    
15. When you're prompted,  **Open** and unlock Microsoft Authenticator.
16. You'll then be asked to complete a quick Face Check before your account ownership can be validated. 
17. Once completed, you'll be shown a screen with a Temporary Access Pass, Copy this code and click **sign in**. 
18. Finally, you'll be redirected to the My Security Info page where you can register a new authentication method and fully regain access. 

    :::image type="content" border="true" source="media/how-to-account-recovery-user-setup/create-passkey.png" alt-text="Screenshot that shows how to create a passkey for account recovery."lightbox="media/how-to-account-recovery-user-setup/create-passkey.png":::   

## Troubleshooting

- When a profile is in the default Evaluation mode, the user sees the following screen after user verification passes with the IDV and Face Check. This experience is expected in Evaluation mode. An Authentication Policy Administrator needs to place users in Production mode before they can be issued a TAP. 

  :::image type="content" border="true" source="media/how-to-account-recovery-user-setup/policy-evaluation-mode.png" alt-text="Screenshot that shows the profile for a user is in Evaluation mode."lightbox="media/how-to-account-recovery-user-setup/policy-evaluation-mode.png":::   

- If the user sees a red error message on the TAP screen and doesn't get a TAP issued, confirm that the claims ID info and Microsoft Graph match the real name. 

  :::image type="content" border="true" source="media/how-to-account-recovery-user-setup/mismatch.png" alt-text="Screenshot that shows a red error message on the TAP screen."lightbox="media/how-to-account-recovery-user-setup/mismatch.png":::   

## Related content

- [Overview of Microsoft Entra ID Account Recovery](concept-self-service-account-recovery.md) - Learn more about Microsoft Entra account recovery.











