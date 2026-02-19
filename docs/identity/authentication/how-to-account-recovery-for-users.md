---
title: How End Users Can Set Up Account Recovery for Microsoft Entra ID
description: How end users can set up account recovery for Microsoft Entra ID.
ms.topic: how-to
ms.date: 11/07/2025
ms.reviewer: tilarso
ms.custom: sfi-ga-nochange, sfi-image-nochange
# Customer intent: As a Microsoft Entra Administrator, I want to learn how end users can set up account recovery for Microsoft Entra ID.
---

# How end users can perform account recovery in Microsoft Entra ID

Users can recover their accounts in just a few simple steps. In this topic, we'll explore how users can discover and start the account recovery process and what users can expect during the Identity Verification process through an organization's configured provider.

## User steps

1. Start by attempting to sign in to an application such as Microsoft Teams or directly at [https://login.microsoftonline.com](https://login.microsoftonline.com).
1. You're presented with an initial authentication method to sign in with.
1. As you're unable to use this method, select **Other ways to sign in**. You're presented with additional sign-in options. 
1. If you're unable to sign in with any methods, click **Recover your account**.

   :::image type="content" border="true" source="media/how-to-account-recovery-for-users/sign-in.png" alt-text="Screenshot that shows how to sign in to set up account recovery." lightbox="media/how-to-account-recovery-for-users/sign-in.png":::

1. You're presented with an informational screen that explains the account recovery process and provides guidance to complete identity verification through the organization's configured external identity proofing service.
1. You're redirected to the identity proofing service configured by your organization, and you start the identity proofing process.

   >[!NOTE]
   >The specific steps required for identity verification may vary depending on the identity verification partner configured by your organization.
   >Below are common steps which a provider may present to a user. 

1. Open the camera on your mobile device, and scan the QR code on the website of the identity proofing application. 
1. After the identity proofing application or page opens on your mobile device, select **Continue**.
1. Enter your name and email, agree to the terms of use for the app, and select **Continue**.
1. Choose your country/region, and the type of identity verification document you have, such as a **Passport** or **Driver's License**.
1. Review how to take a clear document photo, and select **Continue** after you read each step.
1. After you take the photo, select **Submit photos**.
1. Review how to take a clear photo of your face, and select **Continue** after you read each step.
1. After you take the photo, the identity proofing application or page verifies your identity, and will issue a Verifiable Credential into your Microsoft Authenticator app.

    >[!Note]
    > This may be presented by the provider as an option such as **Add a Verified ID** or **Open in Authenticator**.
    
1. When you're prompted, select **Open** and unlock Microsoft Authenticator.
1. You're asked to complete a quick Face Check before your account ownership can be validated. 
1. Once completed, you get a Temporary Access Pass. Copy this code and click **Sign in**. 
1. Finally, you're redirected to [Security info](https://mysignins.microsoft.com/security-info), where you can register a new authentication method and fully regain access. 

    :::image type="content" border="true" source="media/how-to-account-recovery-for-users/create-passkey.png" alt-text="Screenshot that shows how to create a passkey for account recovery."lightbox="media/how-to-account-recovery-for-users/create-passkey.png":::   


## Troubleshooting

### User can't recover their account in Evaluation mode

When a profile is in the default Evaluation mode, the user sees the following screen after user verification passes with the IDV and Face Check. This experience is expected in Evaluation mode. An Authentication Policy Administrator needs to place users in Production mode before they can be issued a TAP. 

:::image type="content" border="true" source="media/how-to-account-recovery-for-users/policy-evaluation-mode.png" alt-text="Screenshot that shows the profile for a user is in Evaluation mode." lightbox="media/how-to-account-recovery-for-users/policy-evaluation-mode.png":::   

### User not issued a TAP

If the user sees a red error message on the TAP screen and doesn't get a TAP issued, confirm that the claims ID info and Microsoft Graph match the real name. 

:::image type="content" border="true" source="media/how-to-account-recovery-for-users/mismatch.png" alt-text="Screenshot that shows a red error message on the TAP screen." lightbox="media/how-to-account-recovery-for-users/mismatch.png":::   


### User might not see the Recover your account option when they choose other ways to sign in 

Account recovery is designed for actively used accounts that have prior authentication events. After you enable or change the scope of account recovery, users might need to complete an initial authentication before the recovery option is made available. If evaluating recovery with a test account, ensure the user authenticates first before attempting account recovery. 

If you still don't see the **Recover your account** when you sign in later, make sure that the group you include in the account recovery profile (for example, Engineering) has all the users you want to allow for self-service recovery in it. If they aren't part of the selected group, then they won't be offered the recovery task during login.

:::image type="content" border="true" source="media/how-to-account-recovery-for-users/choose-way-to-sign-in.png" alt-text="Screenshot that shows how to choose another way to sign in." lightbox="media/how-to-account-recovery-for-users/choose-way-to-sign-in.png":::   

### User might get an error stating requests can't be completed at the start of recovery
 
This happens when the identity verification provider set up in account recovery is unavailable or there are issues with the Security Store. Admins should review the account recovery configuration and Security Store status for the provider.

:::image type="content" border="true" source="media/how-to-account-recovery-for-users/try-again-later.png" alt-text="Screenshot that shows an error and to try again." lightbox="media/how-to-account-recovery-for-users/try-again-later.png":::   

### Identity verification provider errors
During the document verification, IDV might have trouble reading the photo image of a government document or driver's license upload or selfie. Overhead lights or glare from a window can make it difficult to photograph plastic cards and still see all the data for the IDV to process.

The identity verification provider commonly does their own facial biometric checks against the photo in the ID you uploaded.

Sometimes changing the lighting environment or using a different available government document can help.

:::image type="content" border="true" source="media/how-to-account-recovery-for-users/mismatch.png" alt-text="Screenshot that shows a red error message on the TAP screen." lightbox="media/how-to-account-recovery-for-users/mismatch.png":::   

### Errors when completing Face Check

Face Check's performance can be influenced by the user's lighting conditions and background during capture. In the event of a failure, the event log allows administrators to review the confidence score achieved by Face Check. For improved results, users are advised to conduct Face Check in darker environments, away from bright windows and lights. 

Face Check includes an active mode designed to adapt to excessively bright settings; this mode utilizes user posture cues to enhance accuracy under challenging lighting conditions. 

:::image type="content" border="true" source="media/how-to-account-recovery-for-users/errors.png" alt-text="Screenshot that shows common errors during account recovery." lightbox="media/how-to-account-recovery-for-users/errors.png":::   

As part of account recovery, the photo in the presented Verified ID is matched against the active Face Check. The photo in the Verified ID may be problematic if it's too blurry or low quality, though it's usually fine since it comes from a government document and identity verification provider process. Check the Verified ID photo in the Microsoft Authenticator wallet to ensure it's clear enough for accurate face comparison.

:::image type="content" border="true" source="media/how-to-account-recovery-for-users/photo.png" alt-text="Screenshot that shows photo match." lightbox="media/how-to-account-recovery-for-users/photo.png"::: 

### Temporary Access Pass code issues following Identity Verification document validation

After the user has shared their Verified ID with Microsoft Entra, we attempt an account validation and match against the verified claims in the ID issued by your Identity Verification Provider. This error may be present when account ownership couldn't be confirmed—often due to mismatches between the first and last names in the user's profile and those on the ID. Differences such as "John" versus "Jonathan", or complex surnames, might cause these issues. Admins can resolve this during the preview by updating profile information. Another possible cause is improper Temporary Access Pass issuance group configuration for users in recovery. Check the Authentication methods policy and confirm that users in scope for recovery are also enabled for the Temporary Access Pass method. 
 
### Passkey not issued
     
Once the user is fully verified and is redirected to MySignIns to register a new credential, any passkey registration failures should be evaluated through review of audit logs. For more guidance, see [How to register passkeys (FIDO2)](how-to-register-passkey.md). 

For synced passkeys, ensure the device's operating system is updated, as these passkeys are native to the operating system. If no new authentication method is registered before the Temporary Access Pass expires, the user must restart account recovery to get a new Temporary Access Pass.

:::image type="content" border="true" source="media/how-to-account-recovery-for-users/passkey-not-registered.png" alt-text="Screenshot that shows an error when a passkey isn't registered." lightbox="media/how-to-account-recovery-for-users/passkey-not-registered.png":::   

## Related content

- [Overview of Microsoft Entra account recovery](concept-account-recovery-overview.md) - Learn more about Microsoft Entra account recovery.
