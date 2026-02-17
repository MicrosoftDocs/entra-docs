---
title:  Register a Passkey (FIDO2) 
description: Registration and management of a passkey (FIDO2).

services: active-directory
ms.topic: how-to
ms.date: 11/10/2025
ms.reviewer: kimhana

ms.collection: M365-identity-device-management
# Customer intent: As an identity administrator, I want to understand how users will register a passkey using a browser or with a security key. 

---
# Register a passkey (FIDO2)

This article shows how users can register a passkey (FIDO2) by using the **Passkey** flow. For registration on a mobile device, see [Register a passkey using a mobile device](how-to-register-passkey-mobile.md).

>[!NOTE]
>Looking to provide passkeys (FIDO2) on behalf of users? Use our [APIs](https://aka.ms/passkeyprovision).

For more information about enabling passkeys in Microsoft Authenticator, see [How to enable passkeys in Microsoft Authenticator](how-to-enable-authenticator-passkey.md).

## Manual registration 

1. Users can register a passkey (FIDO2) as an authentication method by navigating and completing the process from a browser at [Security info](https://aka.ms/mysecurityinfo).
1. Tap **Add sign-in method** > **Choose a method** > **Passkey** > **Add**.
1. Sign in with multifactor authentication (MFA) before adding a passkey, then tap **Next**.
   1. If you don't have at least one MFA method registered, you must add one.
   1. An Authentication Policy Administrator can also issue a [Temporary Access Pass](howto-authentication-temporary-access-pass.md) to allow a user to strongly authenticate and register a passkey.
 
   :::image type="content" border="true" source="media/how-to-register-passkey-android-or-ios/add-passkey.png" alt-text="Screenshot of the Add a passkey on your iOS or Android device option.":::

1. A security dialog opens on your device and asks where to save your passkey. 

   > [!NOTE]
   > Options displayed vary depending on your browser and device operating system. If the device where you started the registration process supports passkeys, you'll be asked to save the passkey to that device. Select **Use another device** or **More options** to display additional ways for you to save the passkey.


1. If your organization allows saving a passkey to a security key:
   1. Choose **Security Key**.
   1. Follow the guidance and insert or connect your security key when requested.
   1. You're prompted to create or enter a PIN for your security key, then perform the required gesture for the key.
   1. Upon completion, review any additional information from the security dialog, then tap Ok or Continue.

1. After you're redirected to Security info, you can change the default name for the new sign-in method. 
1. Tap **Done** to finish registering the new method.

## Next steps

- [Choosing authentication methods for your organization](concept-authentication-methods.md)

