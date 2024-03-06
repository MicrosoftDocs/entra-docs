---
title: Passwordless security key sign-in
description: Enable passwordless security key sign-in to Microsoft Entra ID using FIDO2 security keys

ms.service: entra-id
ms.subservice: authentication
ms.topic: how-to
ms.date: 03/05/2024

ms.author: justinha
author: justinha
manager: amycolannino
ms.reviewer: calui, tilarso

# Customer intent: As a Microsoft Entra Administrator, I want to learn how to enable and enforce passkeys sign in for end users.

---
# Enable passkey (FIDO2) sign-in 

For enterprises that use passwords today and have a shared PC environment, passkeys provide a seamless way for workers to authenticate without entering a username or password. Passkeys provide improved productivity for workers, and have better security.

This document focuses on enabling passkeys, such as FIDO2 security keys in your organization. At the end of this article, you'll be able to sign in to web-based applications with your Microsoft Entra account using a passkey.

## Requirements

- [Microsoft Entra multifactor authentication (MFA)](howto-mfa-getstarted.md)
- Compatible [FIDO2 security keys](concept-authentication-passwordless.md#fido2-security-keys)
- WebAuthN requires Windows 10 version 1903 or higher

To use security keys for logging in to web apps and services, you must have a browser that supports the WebAuthN protocol. 
These include Microsoft Edge, Chrome, Firefox, and Safari. For more information, see [Browser support of FIDO2 passwordless authentication](fido2-compatibility.md).

>[!NOTE]
>Entra ID supports only device-bound passkeys. Support for synced passkeys is coming soon.

## Prepare devices

For devices that are joined to Microsoft Entra ID, the best experience is on Windows 10 version 1903 or higher.

Hybrid-joined devices must run Windows 10 version 2004 or higher.

## Enable the passkey (FIDO2) authentication method

### Enable the combined registration experience

Registration features for passkey authentication methods rely on combined MFA/SSPR registration. [Learn more about combined registration](howto-registration-mfa-sspr-combined.md). 

### Enable the passkey (FIDO2) authentication method

[!INCLUDE [portal updates](~/includes/portal-update.md)]

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Authentication Policy Administrator](~/identity/role-based-access-control/permissions-reference.md#authentication-policy-administrator).
1. Browse to **Protection** > **Authentication methods** > **Authentication method policy**.
1. Under the method **Passkey (FIDO2)**, click **All users**, or click **Add groups** to select specific groups. *Only security groups are supported*.
1. **Save** the configuration.

   >[!NOTE]
   >If you see an error when you try to save, the cause might be due to the number of users or groups being added. As a workaround, replace the users and groups you are trying to add with a single group, in the same operation, and then click **Save** again.


### Passkey (FIDO2) optional settings 

There are some optional settings on the **Configure** tab to help manage how security keys can be used for sign-in.  

![Screenshot of FIDO2 security key options](media/howto-authentication-passwordless-security-key/optional-settings.png) 

- **Allow self-service set up** should remain set to **Yes**. If set to no, your users won't be able to register a passkeys through My Security-Info, even if enabled by Authentication Methods policy.  
- **Enforce attestation** setting to **Yes** requires the passkey metadata to be published and verified with the FIDO Alliance Metadata Service, and also pass Microsoft's additional set of validation testing. For more information, see [What is a Microsoft-compatible security key?](concept-authentication-passwordless.md#fido2-security-key-providers)

**Key Restriction Policy**

- **Enforce key restrictions** should be set to **Yes** only if your organization wants to only allow or disallow certain passkeys, which are identified by their Authenticator Attestation GUID (AAGUID). You can work with your passkey or physical security key provider to determine the AAGUID of a device. If the passkey is already registered, you can find the AAGUID by viewing the authentication method details of the passkey for the user. 

  >[!WARNING]
  >Key restrictions set the usability of specific passkey methods for both registration and authentication. If you change key restrictions and remove an AAGUID that you previously allowed, users who previously registered an allowed method can no longer use it for sign-in. 

## Disable a passkey 

To remove a passkey associated with a user account, delete the key from the user’s authentication method.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) and search for the user account from which the passkey is to be removed.
1. Select **Authentication methods** > right-click **Passkey (FIDO2)** and click **Delete**. 

    ![View Authentication Method details](media/howto-authentication-passwordless-deployment/security-key-view-details.png)

## Security key Authenticator Attestation GUID (AAGUID)

The FIDO2 specification requires each security key provider to provide an Authenticator Attestation GUID (AAGUID) during attestation. An AAGUID is a 128-bit identifier indicating the key type, such as the make and model. 

>[!NOTE]
>The manufacturer must ensure that the AAGUID is identical across all substantially identical keys made by that manufacturer, and different (with high probability) from the AAGUIDs of all other types of keys. To ensure, the AAGUID for a given type of security key should be randomly generated. For more information, see [Web Authentication: An API for accessing Public Key Credentials - Level 2 (w3.org)](https://w3c.github.io/webauthn/).

There are two ways to get your AAGUID. You can either ask your passkey / security key provider or view the authentication method details of the key per user.

![View AAGUID for security key](media/howto-authentication-passwordless-deployment/security-key-aaguid-details.png)


## Troubleshooting and feedback

If you'd like to share feedback or encounter issues with this feature, share via the Windows Feedback Hub app using the following steps:

1. Launch **Feedback Hub** and make sure you're signed in.
1. Submit feedback under the following categorization:
   - Category: Security and Privacy
   - Subcategory: FIDO
1. To capture logs, use the option to **Recreate my Problem**.

## Known issues

### Security key provisioning

Administrator provisioning and de-provisioning of security keys isn't available.


### UPN changes

If a user's UPN changes, you can no longer modify FIDO2 security keys to account for the change. The solution for a user with a FIDO2 security key is to sign in to MySecurityInfo, delete the old key, and add a new one.

## Next steps

[FIDO2 security key Windows 10 sign in](howto-authentication-passwordless-security-key-windows.md)

[Enable FIDO2 authentication to on-premises resources](howto-authentication-passwordless-security-key-on-premises.md)

[Learn more about device registration](~/identity/devices/overview.md)

[Learn more about Microsoft Entra multifactor authentication](~/identity/authentication/howto-mfa-getstarted.md)
