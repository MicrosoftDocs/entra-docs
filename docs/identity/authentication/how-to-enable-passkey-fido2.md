---
title: Enable Passkey (FIDO2)
description: Enable passwordless sign-in to Microsoft Entra ID using passkeys (FIDO2)

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

For enterprises that use passwords today, passkeys (FIDO2) provide a seamless way for workers to authenticate without entering a username or password. Passkeys provide improved productivity for workers, and have better security.

This document focuses on enabling passkey-based passwordless authentication. At the end of this article, you'll be able to sign in to your Microsoft Entra account using a passkey stored on a FIDO2 security key or in the Microsoft Authenticator app.

## Requirements

- [Microsoft Entra multifactor authentication (MFA)](howto-mfa-getstarted.md)
- Compatible [FIDO2 security keys](concept-authentication-passwordless.md#fido2-security-keys)

Passkeys are supported across major scenarios on Windows, macOS, Android, and iOS. For more information on supported scenarios, see [Browser support of FIDO2 passwordless authentication](fido2-compatibility.md).

>[!NOTE]
>Entra ID supports only device-bound passkeys. Support for synced passkeys is coming soon.

## Prepare devices

For devices that are joined to Microsoft Entra ID, the best experience is on Windows 10 version 1903 or higher.

Hybrid-joined devices must run Windows 10 version 2004 or higher.

## Enable passkey (FIDO2) authentication method

### Enable the combined registration experience

Registration features for passkey authentication methods rely on combined MFA/SSPR registration. [Learn more about combined registration](howto-registration-mfa-sspr-combined.md). 

### Enable passkey (FIDO2) authentication method

[!INCLUDE [portal updates](~/includes/portal-update.md)]

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Authentication Policy Administrator](~/identity/role-based-access-control/permissions-reference.md#authentication-policy-administrator).
1. Browse to **Protection** > **Authentication methods** > **Authentication method policy**.
1. Under the method **Passkey (FIDO2)**, click **All users**, or click **Add groups** to select specific groups. *Only security groups are supported*.
1. **Save** the configuration.

   >[!NOTE]
   >If you see an error when you try to save, the cause might be due to the number of users or groups being added. As a workaround, replace the users and groups you are trying to add with a single group, in the same operation, and then click **Save** again.


### Passkey optional settings 

There are some optional settings on the **Configure** tab to help manage how passkeys can be used for sign-in.  

:::image type="content" border="true" source="media/howto-authentication-passwordless-security-key/optional-settings.png" alt-text="Screenshot of FIDO2 security key options.":::

- **Allow self-service set up** should remain set to **Yes**. If set to no, your users won't be able to register a passkey through MySecurityInfo, even if enabled by Authentication Methods policy.  
- **Enforce attestation** should be set to **Yes** if your organization wants to be assured that a FIDO2 security key model or passkey provider is genuine and comes from the legitimate vendor.
    - For FIDO2 security keys, we require security key metadata to be published and verified with the FIDO Alliance Metadata Service, and also pass Microsoft's additional set of validation testing. For more information, see [What is a Microsoft-compatible security key?](concept-authentication-passwordless.md#fido2-security-key-providers)
    - For passkeys in Microsoft Authenticator, we do not currently support attestation.

  >[!WARNING]
  >Attestation enforcement governs whether a passkey is allowed during registration only. Users who are able to register a passkey without attestation will not be blocked during sign-in if **Enforce attestation** is set to **Yes** at a later time.

**Key Restriction Policy**

- **Enforce key restrictions** should be set to **Yes** only if your organization wants to only allow or disallow certain security key models or passkey providers, which are identified by their Authenticator Attestation GUID (AAGUID). You can work with your security key vendor or passkey provider to determine the AAGUID of a device. If the passkey is already registered, you can find the AAGUID by viewing the authentication method details of the passkey for the user. 

  >[!WARNING]
  >Key restrictions set the usability of specific models or providers for both registration and authentication. If you change key restrictions and remove an AAGUID that you previously allowed, users who previously registered an allowed method can no longer use it for sign-in. 

## Passkey Authenticator Attestation GUID (AAGUID)

The FIDO2 specification requires each security key vendor to provide an Authenticator Attestation GUID (AAGUID) during registration. An AAGUID is a 128-bit identifier indicating the key type, such as the make and model. Passkey providers on desktop and mobile devices are also expected to provide an AAGUID during registration.

>[!NOTE]
>The vendor must ensure that the AAGUID is identical across all substantially identical security keys or passkey providers made by that vendor, and different (with high probability) from the AAGUIDs of all other types of security keys or passkey providers. To ensure this, the AAGUID for a given security key model or passkey provider should be randomly generated. For more information, see [Web Authentication: An API for accessing Public Key Credentials - Level 2 (w3.org)](https://w3c.github.io/webauthn/).

There are two ways to get your AAGUID. You can either ask your security key or passkey provider vendor, or view the authentication method details of the key per user.

![View AAGUID for passkey](media/howto-authentication-passwordless-deployment/security-key-aaguid-details.png)

## Disable a key 

To remove a passkey associated with a user account, delete the key from the user’s authentication method.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) and search for the user account from which the passkey is to be removed.
1. Select **Authentication methods** > right-click **Passkey (device-bound)** and click **Delete**. 

    ![View Authentication Method details](media/howto-authentication-passwordless-deployment/security-key-view-details.png)

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

If a user's UPN changes, you can no longer modify passkeys to account for the change. The solution for a user with a passkey is to sign in to MySecurityInfo, delete the old passkey, and add a new one.

## Next steps

[Passkey Windows 10 sign in](howto-authentication-passwordless-security-key-windows.md)

[Native app and browser support of passkey (FIDO2) passwordless authentication](fido2-compatibility.md)

[Enable FIDO2 authentication to on-premises resources](howto-authentication-passwordless-security-key-on-premises.md)

[Learn more about device registration](~/identity/devices/overview.md)

[Learn more about Microsoft Entra multifactor authentication](~/identity/authentication/howto-mfa-getstarted.md)
