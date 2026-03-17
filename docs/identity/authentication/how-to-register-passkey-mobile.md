---
title: Register a passkey using a mobile device
description: Registration and management of passkey using a mobile device.
services: active-directory
ms.topic: how-to
ms.date: 03/04/2025
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
1. Select **Passkey**.
1. Tap **Add**. 
1. Sign in with multifactor authentication (MFA) before adding a passkey.
1. Select **Next**. 
1. Your device opens a security window. Choose **Other Options**. 

1. Select **Security key**. 

   > [!NOTE]
   > Depending on the screen size and orientation of your iOS device, you may need to scroll down to see this option. 

1. Connect your security key to your iOS device. 
1. Provide your PIN or biometric.

   > [!NOTE]
   > If a PIN isn't configured for this security key, you need to first enroll a PIN before you continue registration. 

1. Reinsert or reconnect your security key to your iOS device.  
    
1. Upon completion, you're redirected back to [Security info](https://mysignins.microsoft.com/security-info) and asked to rename your passkey. Name the passkey something memorable to you and select **Done**. 

## [**Android**](#tab/Android)

### Register a security key with Android 

1. Using your Android device, open a web browser and sign-in to [Security info](https://mysignins.microsoft.com/security-info).
1. Tap **+ Add sign-in method**.
1. Select **Passkey**.
1. Tap **Add**.
1. Sign in with multifactor authentication (MFA) before adding a passkey.
1. Select **Next**.  
1. A security window opens on your device asking where you want to create your passkey. 
1. Select **Save another way**.

   > [!NOTE]
   > Options displayed vary depending on the manufacturer and Android OS version of your device. For example, this option may appear as **Use a different device**. 

1. You may see various options, depending on the number of Google accounts or passkey managers enabled on your device. Select **Another device** to continue. 
1. Select **USB security key**. 
1. Connect your security key to your Android device. 
1. Provide your PIN or biometric.
     
   > [!NOTE]
   > If a PIN isn't configured for this security key, you need to first enroll a PIN before you continue registration. 

1. You may be asked to confirm your PIN or biometric again before proceeding. 
1. Upon completion, you're redirected back to [Security info](https://mysignins.microsoft.com/security-info) and asked to rename your passkey. Name the passkey something memorable to you and select **Done**. 

---

## Related content

- [Choosing authentication methods for your organization](concept-authentication-methods.md)
