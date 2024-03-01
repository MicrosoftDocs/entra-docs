---
title:  Register Microsoft Authenticator passkey on Android in MySecurityInfo
description: User registration and management of passkey with Authenticator on Android device

services: active-directory
ms.service: active-directory
ms.subservice: authentication
ms.topic: how-to
ms.date: 02/21/2024

ms.author: justinha
author: justinha
manager: amycolannino
ms.reviewer: calui

ms.collection: M365-identity-device-management
# Customer intent: As an identity administrator, I want to understand how to .
---
# Register Microsoft Authenticator passkey on Android in MySecurityInfo

This article shows how to register a passkey with Microsoft Authenticator on your Android device in your security info in My Sign-Ins [Security info](https://mysignins.microsoft.com/security-info). Your device needs to run Android version 14 or later. 

1. Go to [Security info](https://mysignins.microsoft.com/security-info), and tap **+ Add sign-in method** > **Choose a method** > **Passkey in Microsoft Authenticator** > **Add**.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-android/add-passkey-authenticator.png" alt-text="Screenshot of how to add passkey in Microsoft Authenticator as a sign-in method.":::

1. Sign in with multifactor authentication (MFA) before you can add a passkey, then tap **Next**.   

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-android/set-up-passkey.png" alt-text="Screenshot that notifies user to sign in with a second factor before they add a passkey.":::

1. If necessary, download Microsoft Authenticator, then tap **Next**.   

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-android/organization.png" alt-text="Screenshot that notifies user that their organization requires them to add a passkey.":::

1. Choose **Android**.   

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-android/choose-device.png" alt-text="Screenshot that lets user choose iOS or Android.":::

1. Follow the steps to turn on Authenticator in the **Settings app**:
   1. On your Android device, open the **Settings app**.
   1. Open **Passwords and accounts**.
   1. Under **Additional providers**, turn on Authenticator. 
   1. After you turn on Authenticator, tap **Continue**.

      :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-android/turn-on-passkey-android.png" alt-text="Screenshot that notifies user to turn on Authenticator in Seetings app on their Android device.":::

1. Open a QR scanner app and tap **Next**.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-android/scan.png" alt-text="Screenshot that notifies user to open a QR scanner app.":::

1. The next screen lets you choose to **Save another way** when you create a passkey in Authenticator. Tap **I understand**.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-android/scan.png" alt-text="Screenshot that notifies user to save another way.":::
   
1. Chooose **iPhone, iPad, or Android device** and tap **Next**.   

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-android/choose-where-to-save.png" alt-text="Screenshot that lets user choose where to save their passkey.":::

1. Use the Camera app to scan the QR code, and then open the link.

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-android/scan-code.png" alt-text="Screenshot of QR code.":::

1. When prompted, sign in with a biometric option. If you can't use bioemtric, tap **Use screen lock**.

1. Your device should connect and sign you in. 

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-android/device-connected.png" alt-text="Screenshot that notifies user that device is connected.":::

1. After you are redirected to security info, you can change the default name for the new sign-in method. Click **Done** to save the new method.    

   :::image type="content" border="true" source="media/howto-authenticate-passwordless-passkey-android/success.png" alt-text="Screenshot where user can change friendly nme of the new sign-in method.":::
 
## FAQs

### What if I already have a passkey?

### I chose the wrong passkey provider. How can I retry?

### How can I delete a passkey?

Go to [Security info](https://mysignins.microsoft.com/security-info), find the passkey in the list of available sign-in methods, and click **Delete**.

