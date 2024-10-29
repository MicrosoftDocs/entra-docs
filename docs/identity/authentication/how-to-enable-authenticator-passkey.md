---
title: How to enable passkeys in Microsoft Authenticator for Microsoft Entra ID 
description: Learn about how to enable passkeys in Microsoft Authenticator for Microsoft Entra ID.

ms.service: entra-id
ms.subservice: authentication
ms.topic: how-to
ms.date: 10/29/2024


ms.author: justinha
author: justinha
manager: amycolannino
ms.reviewer: mjsantani

# Customer intent: As a Microsoft Entra Administrator, I want to learn how to enable and enforce passkeys in Authenticator sign in for end users.
---
# Enable passkeys in Microsoft Authenticator 

This article lists steps to enable and enforce use of passkeys in Authenticator for Microsoft Entra ID. First, you update the Authentication methods policy to allow end users to register and sign in with passkeys in Authenticator. Then you can use Conditional Access authentication strengths policies to enforce passkey sign-in when users access a sensitive resource.

## Requirements

- [Microsoft Entra multifactor authentication (MFA)](howto-mfa-getstarted.md)
- Android 14 and later or iOS 17 and later
- An active internet connection on any device that is part of the passkey registration/authentication process. Connectivity to these two endpoints must be allowed in your organization to enable cross-device registration and authentication:
  - cable.ua5v.com
  - cable.auth.com
- For cross-device registration/authentication, both devices must have Bluetooth enabled

> [!NOTE]
> Users need to install the latest version of Authenticator for Android or iOS to use a passkey. 

To learn more about where you can use passkeys in Authenticator to sign in, see [Support for FIDO2 authentication with Microsoft Entra ID](fido2-compatibility.md).

## Enable passkeys in Authenticator in the admin center

An Authentication Policy Administrator needs to consent to allow Authenticator in the **Passkey (FIDO2) settings** of the Authentication methods policy. They need to explicitly allow the Authenticator Attestation GUIDs (AAGUIDs) for Microsoft Authenticator to enable users to register passkeys in the Authenticator app. There's no setting to enable passkeys in the **Microsoft Authenticator app** section of the Authentication Methods policy. 

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Authentication Policy Administrator](~/identity/role-based-access-control/permissions-reference.md#authentication-policy-administrator).
1. Browse to **Protection** > **Authentication methods** > **Authentication method policy**.
1. Under the method **Passkey (FIDO2)**, select **All users** or **Add groups** to select specific groups. *Only security groups are supported*.
1. On the **Configure** tab:
   - Set **Allow self-service set up** to **Yes**. If set to **No**, users can't register a passkey by using [Security info](https://mysignins.microsoft.com/security-info), even if passkeys (FIDO2) are enabled by the Authentication methods policy.  
   - Set **Enforce attestation** to **Yes**. 

     When attestation is enabled in the passkey (FIDO) policy, Microsoft Entra ID tries to verify the legitimacy of the passkey being created. When the user is registering a passkey in the Authenticator, attestation verifies that the legitimate Microsoft Authenticator app created the passkey by using Apple and Google services. Here’s more details: 

     - iOS: Authenticator attestation uses the [iOS App Attest service](https://developer.apple.com/documentation/devicecheck/preparing-to-use-the-app-attest-service) to ensure the legitimacy of the Authenticator app before registering the passkey.  
     
       >[!NOTE]
       >Support for registering passkeys in Authenticator when attestation is enforced is currently rolling out to iOS Authenticator app users. Support for registering attested passkeys in Authenticator on Android devices is available to all users in the latest version of the app.
       
     - Android: 
       - For Play Integrity attestation, Authenticator attestation uses the [Play Integrity API](https://developer.android.com/google/play/integrity/overview) to ensure the legitimacy of the Authenticator app before registering the passkey.  
       - For Key attestation, Authenticator attestation uses [key attestation by Android](https://developer.android.com/privacy-and-security/security-key-attestation) to verify that the passkey being registered is hardware-backed.     

     >[!NOTE]
     >For both iOS and Android, Authenticator attestation relies upon Apple and Google services to verify the authenticity of the Authenticator app. Heavy service usage can make passkey registration fail, and users may need to try again. If Apple and Google services are down, Authenticator attestation blocks registration that requires attestation until services are restored. To monitor the status of Google Play Integrity service, see [Google Play Status Dashboard](https://status.play.google.com/). To monitor the status of the iOS App Attest service, see [System Status](https://developer.apple.com/system-status/).

   - Key restrictions set the usability of specific passkeys for both registration and authentication. Set **Enforce key restrictions** to **Yes** to only allow or block certain passkeys, which are identified by their AAGUIDs. 
   
     This setting must be **Yes** and you need to add the Microsoft Authenticator AAGUIDs to allow users to register passkeys in the Authenticator, either by signing into the Authenticator app, or by adding **Passkey in Microsoft Authenticator** from their Security info. 

     [Security info](https://mysignins.microsoft.com/security-info) requires this setting to be set to **Yes** for users to be able to choose **Passkey in Authenticator** and go through a dedicated Authenticator passkey registration flow. If you choose **No**, users may still be able to add a passkey in Microsoft Authenticator by choosing the **Security key or passkey** method, depending upon their operating system and browser. However, we don't expect many users to discover and use that method.  
     
     If your organization doesn't currently enforce key restrictions and already has active passkey usage, you should collect the AAGUIDs of the keys being used today. Include those users and the Authenticator AAGUIDs to enable this preview. You can do this with an automated script that analyzes logs, such as registration details and sign-in logs.

     If you change key restrictions and remove an AAGUID that you previously allowed, users who previously registered an allowed method can no longer use it for sign-in. 

   - Set **Restrict specific keys** to **Allow**.
   - Select **Microsoft Authenticator** to automatically add the Authenticator app AAGUIDs to the key restriction list, or manually add the following AAGUIDs to allow users to register passkeys in the Authenticator by signing into the Authenticator app or by going through a guided flow on the Security info page:

     - **Authenticator for Android:** de1e552d-db1d-4423-a619-566b625cdc84
     - **Authenticator for iOS:** 90a3ccdf-635c-4729-a248-9b709135078f
   
     >[!NOTE]
     >If you turn off key retrictions, make sure you clear the **Microsoft Authenticator** checkbox so that users aren’t prompted to set up a passkey in the Authenticator app in [Security info](https://mysignins.microsoft.com/security-info).

   :::image type="content" border="true" source="media/how-to-enable-authenticator-passkey/optional-settings.png" alt-text="Screenshot showing Microsoft Authenticator enabled for passkey."lightbox="media/how-to-enable-authenticator-passkey/optional-settings.png":::

1. After you finish the configuration, select **Save**.

   >[!NOTE]
   >If you see an error when you try to save, replace multiple groups with a single group in one operation, and then click **Save** again.


## Enable passkeys in Authenticator using Graph Explorer

In addition to using the Microsoft Entra admin center, you can also enable passkeys in Authenticator by using Graph Explorer. Those assigned at least the [Authentication Policy Administrator](../role-based-access-control/permissions-reference.md#authentication-policy-administrator) role can update the Authentication methods policy to allow the AAGUIDs for Authenticator. 

To configure the policy by using Graph Explorer:

1. Sign in to [Graph Explorer](https://aka.ms/ge) and consent to the **Policy.Read.All** and **Policy.ReadWrite.AuthenticationMethod** permissions.

1. Retrieve the Authentication methods policy: 

   ```json
   GET https://graph.microsoft.com/beta/authenticationMethodsPolicy/authenticationMethodConfigurations/FIDO2
   ```

1. To disable attestation enforcement and enforce key restrictions to only allow AAGUIDs for Microsoft Authenticator, perform a PATCH operation using the following request body:

   ```json
   PATCH https://graph.microsoft.com/beta/authenticationMethodsPolicy/authenticationMethodConfigurations/FIDO2
   
   Request Body:
   {
       "@odata.type": "#microsoft.graph.fido2AuthenticationMethodConfiguration",
       "isAttestationEnforced": true,
       "keyRestrictions": {
           "isEnforced": true,
           "enforcementType": "allow",
           "aaGuids": [
               "90a3ccdf-635c-4729-a248-9b709135078f",
               "de1e552d-db1d-4423-a619-566b625cdc84"
   
               <insert previous AAGUIDs here to keep them stored in policy>
           ]
       }
   }
   ```

1. Make sure that the passkey (FIDO2) policy is updated properly.

   ```json
   GET https://graph.microsoft.com/beta/authenticationMethodsPolicy/authenticationMethodConfigurations/FIDO2
   ```


## Restrict Bluetooth usage to passkeys in Authenticator

Some organizations restrict Bluetooth usage, which includes the use of passkeys. In such cases, organizations can allow passkeys by permitting Bluetooth pairing exclusively with passkey-enabled FIDO2 authenticators. For more information about how to configure Bluetooth usage only for passkeys, see [Passkeys in Bluetooth-restricted environments](/windows/security/identity-protection/passkeys/?tabs=windows%2Cintune#passkeys-in-bluetooth-restricted-environments).

## Delete a passkey 

If a user deletes a passkey in Authenticator, the passkey is also removed from the user's sign-in methods. An Authentication Policy Administrator can also follow these steps to delete a passkey from the user’s authentication methods, but it won't remove the passkey from Authenticator.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) and search for the user whose passkey needs to be removed.
1. Select **Authentication methods** > right-click **FIDO2 security key** and select **Delete**. 

> [!NOTE]
> Unless the user initiated the passkey deletion themselves in Authenticator, they need to also remove the passkey in Authenticator on their device.

## Enforce sign-in with passkeys in Authenticator 

To make users sign in with a passkey when they access a sensitive resource, use the built-in phishing-resistant authentication strength, or create a custom authentication strength by following these steps:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as a Conditional Access Administrator.
1. Browse to **Protection** > **Authentication methods** > **Authentication strengths**.
1. Select **New authentication strength**.
1. Provide a descriptive **Name** for your new authentication strength.
1. Optionally provide a **Description**.
1. Select **Passkeys (FIDO2)** and then select **Advanced options**.
1. You can either select **Phishing-resistant MFA strength** or add AAGUIDs for passkeys in Authenticator:

   - **Authenticator for Android:** de1e552d-db1d-4423-a619-566b625cdc84
   - **Authenticator for iOS:** 90a3ccdf-635c-4729-a248-9b709135078f

1. Choose **Next** and review the policy configuration.

## Next steps

[Support for passkey in Windows](/windows/security/identity-protection/passkeys)

