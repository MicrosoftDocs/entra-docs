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
ms.reviewer: timlarso
ms.custom: sfi-ga-nochange, sfi-image-nochange
# Customer intent: As a Microsoft Entra Administrator, I want to learn how end users can set up account recovery for Microsoft Entra ID.
---

# How end users can perform account recovery in Microsoft Entra ID

Users can recover their accounts in just a few simple steps. In this topic, we'll explore how users can discover and start the account recovery process and what users can expect during the Identity Verification process through an organization's configured provider.

:::image type="content" border="true" source="media/how-to-account-recovery-user-setup/recover-steps-1-5.png" alt-text="Initial steps to enter recovery.":::

## User steps

1. User attempts to sign in to an application such as Microsoft Teams or directly at [https://login.microsoftonline.com](https://login.microsoftonline.com).
2. The user is presented with an initial authentication method to sign-in with.
3. Unable to use this method, the user can then click **Other ways to sign-in** and is presented with additional sign-in options. 
4. As the user has lost all ability to sign-in with any registered authentication methods, they click **Recover your account**.

   :::image type="content" border="true" source="media/how-to-account-recovery-user-setup/sign-in.png" alt-text="Screenshot that shows how to sign in to set up account recovery."lightbox="media/how-to-account-recovery-user-setup/sign-in.png":::

5. The user is presented with an informational screen that explains the account recovery process and provides guidance to complete identity verification through the organization's configured external identity proofing service.
6. The user is redirected to the identity proofing service configured by their organization, and starts their identity proofing process.

   >[!NOTE]
   >The specific steps required for identity verification may vary depending on the identity verification partner configured by your organization.

7. Open the camera on your mobile device, and scan the QR code on the website of the identity proofing application. 
8. After the identity proofing application opens on your mobile device, select **Continue**.
9. Enter your name and email, agree to the terms of use for the app, and select **Continue**.
10. Choose your country/region, and the type of identity verification document you have, such as **Passport**.
11. Review how to take a clear document photo, and select **Continue** after you read each step.
12. After you take the photo, select **Submit photos**.
13. Review how to take a clear photo of your face, and select **Continue** after you read each step.
14. After you take the photo, the identity proofing application verifies your identity, and issues a Verifiable Credential.
15. On the **Success** page, select **Add Verifiable Credential**.
16. When you're prompted to open in Authenticator, select **Open**, and unlock Microsoft Authenticator.
17. On the **Add a Verified ID** page in Authenticator, select **Next**.
18. Sign in to the identity proofing application, and select **Start**.
19. The new Verifiable Credential is listed in Authenticator under **Verified IDs**, and Authenticator and the identity proofing application both show **Success**.

    :::image type="content" border="true" source="media/how-to-account-recovery-user-setup/create-passkey.png" alt-text="Screenshot that shows how to create a passkey for account recovery."lightbox="media/how-to-account-recovery-user-setup/create-passkey.png":::   


## Troublshooting

- When a profile is in the default Evaluation mode, the user sees the following screen after user verification passes with the IDV and Face Check. This experience is expected in Evaluation mode. An Authentication Policy Administrator needs to place users in Production mode before they can be issued a TAP. 

  :::image type="content" border="true" source="media/how-to-account-recovery-user-setup/profile-evaluation-mode.png" alt-text="Screenshot that shows the profile for a user is in Evaluation mode."lightbox="media/how-to-account-recovery-user-setup/profile-evaluation-mode.png":::   

- We also have a screen we show users when in Eval mode...and should so that somewhere that is "normal" and if the user admin wants to put some users into prod mode even during preview that's how they will get to the TAP screen. creen user will see if made it through IDV and Face Check, but account details didn't match or some other issue.

- If the user sees a red error message on the TAP screen and doesn't get a TAP issued, confirm that the claims ID info and Microsoft Graph match the real name. 

  :::image type="content" border="true" source="media/how-to-account-recovery-user-setup/mismatch.png" alt-text="Screenshot that shows a red error message on the TAP screen."lightbox="media/how-to-account-recovery-user-setup/mismatch.png":::   

## Related content

- [Overview of Microsoft Entra ID Account Recovery](concept-self-service-account-recovery.md) - Learn more about Microsoft Entra account recovery.












