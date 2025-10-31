---
title: How End Users Can Set Up Account Recovery for Microsoft Entra ID
description: How end users can set up account recovery for Microsoft Entra ID.
ms.service: entra-id
ms.subservice: authentication
ms.topic: how-to
ms.date: 10/30/2025
ms.author: justinha
author: justinha
manager: dougeby
ms.reviewer: tilarso
ms.custom: sfi-ga-nochange, sfi-image-nochange
# Customer intent: As a Microsoft Entra Administrator, I want to learn how end users can set up account recovery for Microsoft Entra ID.
---

# How end users can perform account recovery in Microsoft Entra ID

Users can recover their accounts in just a few simple steps. Below we'll explore how users can discover and start the account recovery process and what users can expect during the Identity Verification process through an organizations configured provider. 

:::image type="content" border="true" source="media/how-to-account-recovery-user-setup/recover-steps-1-5.png" alt-text="Initial steps to enter recovery.":::

1. User attempts to sign in to an application such as Microsoft Teams or directly at [https://login.microsoftonline.com](https://login.microsoftonline.com).
2. The user is presented with an initial authentication method to sign-in with.
3. Unable to use this method, the user can then click **Other ways to sign-in** and is presented with additional sign-in options. 
4. As the user has lost all ability to sign-in with any registered authentication methods, they click **Recover your account**.
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

## Related content

- To learn more about Microsoft Entra account recovery, see [Microsoft Security Store](/security/store/).
