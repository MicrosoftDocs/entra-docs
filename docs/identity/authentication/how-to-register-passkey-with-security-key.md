---
title: Register a passkey (FIDO2) with a FIDO2 security key
description: User registration of a passkey (FIDO2) with a FIDO2 security key.

services: active-directory
ms.service: entra-id 
ms.subservice: authentication
ms.topic: how-to
ms.date: 08/05/2024

ms.author: justinha
author: justinha
manager: amycolannino
ms.reviewer: calui

ms.collection: M365-identity-device-management
# Customer intent: As an identity administrator, I want to understand... 

---
# Register a passkey (FIDO2)

This article shows how to register a passkey as an authentication method. 

## First-time registration

1. First-time users need to register a passkey (FIDO2) as an authentication method by navigating and completing the process from a browser at [My Security info](https://aka.ms/mysecurityinfo).
1. Tap **Add sign-in method** > **Choose a method** > **Passkey (preview)** > **Add**.
1. Sign in with multifactor authentication (MFA) before adding a passkey (FIDO2), then tap **Next**.

   :::image type="content" border="true" source="media/how-to-register-passkey-with-security-key/add-passkey.png" alt-text="Screenshot of the Add a passkey (FIDO2) option in My Security info.":::

1. Select where you want to save your passkey (FIDO2). 

   > [!NOTE]
   > Options displayed vary depending on your browser and device operating system. If the device where you started the registration process supports passkeys (FIDO2), you'll be asked to save the passkey to that device. Select **Use another device** or **More options** to display additional ways for you to save the passkey. 

   :::image type="content" border="true" source="media/how-to-register-passkey-with-security-key/choose-where-store-passkey.png" alt-text="Screenshot of the dialog where to save your passkey (FIDO2) in My Security info.":::

1. (Optional) If you previously set up a passkey (FIDO2) on a mobile device and selected the option to remember that device for quicker sign-in, the device name may appear as a selectable option. In this case, do the following steps: 

   1. Choose **Security key**.
   1. Follow the prompts to connect your security key and provide a PIN or biometric method. 
   1. Upon completion, you're redirected to the **My Security info** screen, where you can change the default name for the new sign-in method. 
   1. Select **Done** to finish registering the new method.

## Prompted registration

1. If your organization requires you to register a passkey (FIDO2), you’ll be prompted after sign-in to add a passkey (FIDO2).

   :::image type="content" border="true" source="media/how-to-register-passkey-with-security-key/inline-registration.png" alt-text="Screenshot of the Add a passkey (FIDO2) option for a more secure sign-in in My Security info.":::

1. Tap **Next**, then you're directed to `login.microsoft.com`. 
1. Select where you would like to save your passkey (FIDO2).

   > [!NOTE]
   > Options displayed vary depending on your browser and device operating system. If the device where you started the registration process supports passkeys (FIDO2), you'll be asked to save the passkey (FIDO2) to that device. Select **Use another device** or **More options** displays additional ways for you to save the passkey. 

   :::image type="content" border="true" source="media/how-to-register-passkey-with-security-key/choose-where-store-passkey.png" alt-text="Screenshot of the prompt where to store your passkey (FIDO2) in My Security info.":::

1. (Optional) If you previously set up a passkey (FIDO2) on a mobile device and selected the option to remember that device for quicker sign-in, the device name may appear as a selectable option. In this case, do the following steps: 

   1. Choose **Security key**.
   1. Follow the prompts to connect your security key and provide a PIN or biometric method. 
   1. Upon completion, you're redirected to the **My Security info** screen, where you can change the default name for the new sign-in method. 
   1. Select **Done** to finish registering the new method.

## Sign-in with your new passkey (FIDO2)

1. Navigate to `login.microsoftonline.com`.

   :::image type="content" border="true" source="media/how-to-register-passkey-with-security-key/sign-in-microsoft.png" alt-text="Screenshot of the sign in to Microsoft prompt.":::

1. Select **Sign-in options**.

   :::image type="content" border="true" source="media/how-to-register-passkey-with-security-key/sign-in-options.png" alt-text="Screenshot of the sign in options for Microsoft.":::

1. Choose **Face**, **Fingerprint**, **PIN**, or **Security key**.
1. A security window opens. Follow the remaining prompts to sign-in with the method that you selected. 

## Next steps

- [Choosing authentication methods for your organization](concept-authentication-methods.md)
- [Register security keys on behalf of users](how-to-enable-passkey-fido2.md)


