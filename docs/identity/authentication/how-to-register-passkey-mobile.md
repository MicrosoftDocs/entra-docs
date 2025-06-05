---
title: Register a passkey using a mobile device
description: Registration and management of passkey using a mobile device.
services: active-directory
ms.service: entra-id
ms.subservice: authentication
ms.topic: how-to
ms.date: 03/04/2025
ms.author: justinha
author: justinha
manager: femila
ms.reviewer: calui, tilarso
ms.collection: M365-identity-device-management
ms.custom: sfi-image-nochange
# Customer intent: As an identity administrator, I want to understand how users will register a passkey using a mobile device or with a security key. 
---
# Register a passkey using a mobile device

This article shows how to register a security key with your iOS or Android device. 

You can also register passkeys in Microsoft Authenticator on your mobile device. With an Authenticator passkey, you can have seamless single sign-on (SSO) to other Microsoft native apps, like Teams or Outlook. For more information, see [How to enable passkeys in Microsoft Authenticator](how-to-enable-authenticator-passkey.md).

## [**iOS**](#tab/iOS)

### Register a passkey with iOS 

1. Using your iOS device, open a web browser and sign-in to [Security info](https://mysignins.microsoft.com/security-info).
   
1. Tap **+ Add sign-in method**.

   :::image type="content" border="true" source="media/how-to-register-passkey-mobile/passkey-ios-add-method.png" alt-text="Screenshot of the Security Info screen showing add methods.":::

1. Select **Passkey**.

   :::image type="content" border="true" source="media/how-to-register-passkey-mobile/passkey-ios-my-security-list.png" alt-text="Screenshot of the drop-down list of options in security info.":::

1. Tap **Add**. 
   
   :::image type="content" border="true" source="media/how-to-register-passkey-mobile/passkey-ios-dropdown.png" alt-text="Screenshot of the Security Info screen Add Sign-in Method option.":::

1. Sign in with multifactor authentication (MFA) before adding a passkey.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-ios/passkey-ios-2fa-authorization.png" alt-text="Screenshot of the two-factor authentication requirement to set up a passkey.":::

1. Select **Next**. 

   :::image type="content" border="true" source="media/how-to-register-passkey-mobile/passkey-ios-start.png" alt-text="Screenshot of starting passkey registration.":::

1. Your device opens a security window. Choose **Other Options**. 

   :::image type="content" border="true" source="media/how-to-register-passkey-mobile/passkey-ios-save-another-way.png" alt-text="Screenshot of where to save a passkey on iOS.":::

1. Select **Security key**. 

   > [!NOTE]
   > Depending on the screen size and orientation of your iOS device, you may need to scroll down to see this option. 

   :::image type="content" border="true" source="media/how-to-register-passkey-mobile/passkey-ios-select-security-key.png" alt-text="Screenshot of selecting to use a security key with iOS.":::

1. Connect your security key to your iOS device. 

    :::image type="content" border="true" source="media/how-to-register-passkey-mobile/passkey-ios-connect.png" alt-text="Screenshot asking to connect your security key to your iOS device.":::

1. Provide your PIN or biometric.

   > [!NOTE]
   > If a PIN isn't configured for this security key, you need to first enroll a PIN before you continue registration. 

   :::image type="content" border="true" source="media/how-to-register-passkey-mobile/passkey-ios-confirm-pin.png" alt-text="Screenshot asking to provide your pin for the security key connected to an iOS device.":::

1. Reinsert or reconnect your security key to your iOS device.  

   :::image type="content" border="true" source="media/how-to-register-passkey-mobile/passkey-ios-reconnect.png" alt-text="Screenshot asking to confirm your pin for the security key connected to an iOS device.":::
    
1. Upon completion, you're redirected back to [Security info](https://mysignins.microsoft.com/security-info) and asked to rename your passkey. Name the passkey something memorable to you and select **Done**. 

   :::image type="content" border="true" source="media/how-to-register-passkey-mobile/passkey-ios-finish.png" alt-text="Screenshot showing final passkey registration step on iOS.":::

## [**Android**](#tab/Android)

### Register a security key with Android 

1. Using your Android device, open a web browser and sign-in to [Security info](https://mysignins.microsoft.com/security-info).
   
1. Tap **+ Add sign-in method**.

   :::image type="content" border="true" source="media/how-to-register-passkey-mobile/passkey-android-add-method.png" alt-text="Screenshot of the Security Info screen showing add methods.":::

1. Select **Passkey**.

   :::image type="content" border="true" source="media/how-to-register-passkey-mobile/passkey-android-my-security-list.png" alt-text="Screenshot of the drop-down list of options in security info.":::

1. Tap **Add**.

   :::image type="content" border="true" source="media/how-to-register-passkey-mobile/passkey-android-dropdown.png" alt-text="Screenshot of the Security Info screen Add Sign-in Method option.":::

1. Sign in with multifactor authentication (MFA) before adding a passkey.

   :::image type="content" border="true" source="media/how-to-register-passkey-mobile/passkey-android-mfa.png" alt-text="Screenshot of the two-factor authentication requirement to set up a passkey.":::

1. Select **Next**.  

   :::image type="content" border="true" source="media/how-to-register-passkey-mobile/passkey-android-start.png" alt-text="Screenshot of starting passkey registration.":::

1. A security window opens on your device asking where you want to create your passkey. 

1. Select **Save another way**.

   > [!NOTE]
   > Options displayed vary depending on the manufacturer and Android OS version of your device. For example, this option may appear as **Use a different device**. 

   :::image type="content" border="true" source="media/how-to-register-passkey-mobile/passkey-android-save-another-way.png" alt-text="Screenshot of passkey selection on android device.":::

1. You may see various options, depending on the number of Google accounts or passkey managers enabled on your device. Select **Another device** to continue. 

   :::image type="content" border="true" source="media/how-to-register-passkey-mobile/passkey-android-more-options.png" alt-text="Screenshot of passkey more options on Android device.":::


1. Select **USB security key**. 

   :::image type="content" border="true" source="media/how-to-register-passkey-mobile/passkey-android-another-device.png" alt-text="Screenshot of option to select a USB security key.":::

1. Connect your security key to your Android device. 

   :::image type="content" border="true" source="media/how-to-register-passkey-mobile/passkey-android-connect-key.png" alt-text="Screenshot of passkey connection to android.":::

1. Provide your PIN or biometric.
     
   > [!NOTE]
   > If a PIN isn't configured for this security key, you need to first enroll a PIN before you continue registration. 

   :::image type="content" border="true" source="media/how-to-register-passkey-mobile/passkey-android-confirm-pin.png" alt-text="Screenshot of prompt to provide PIN or biometric.":::

1. You may be asked to confirm your PIN or biometric again before proceeding. 

1. Upon completion, you're redirected back to [Security info](https://mysignins.microsoft.com/security-info) and asked to rename your passkey. Name the passkey something memorable to you and select **Done**. 

   :::image type="content" border="true" source="media/how-to-register-passkey-mobile/passkey-android-finish.png" alt-text="Screenshot showing final passkey registration step on Android.":::

---

## Related content

- [Choosing authentication methods for your organization](concept-authentication-methods.md)
