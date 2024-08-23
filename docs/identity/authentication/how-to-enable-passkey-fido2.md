---
title: Enable passkeys for your organization (preview)
description: Enable passwordless sign-in to Microsoft Entra ID using passkeys (FIDO2).

ms.service: entra-id
ms.subservice: authentication
ms.topic: how-to
ms.date: 08/23/2024

ms.author: justinha
author: justinha
manager: amycolannino
ms.reviewer: calui, tilarso

# Customer intent: As a Microsoft Entra Administrator, I want to learn how to enable and enforce passkeys sign in for end users.

---
# Enable passkeys (FIDO2) for your organization

For enterprises that use passwords today, passkeys (FIDO2) provide a seamless way for workers to authenticate without entering a username or password. Passkeys (FIDO2) provide improved productivity for workers, and have better security.

This article lists requirements and steps to enable passkeys in your organization. After completing these steps, users in your organization can then register and sign in to their Microsoft Entra account using a passkey stored on a FIDO2 security key or in Microsoft Authenticator.

For more information about enabling passkeys in Microsoft Authenticator, see [How to enable passkeys in Microsoft Authenticator](how-to-enable-authenticator-passkey.md).

For more information about passkey authentication, see [Support for FIDO2 authentication with Microsoft Entra ID](~/identity/authentication/concept-fido2-compatibility.md).

> [!NOTE]
> Microsoft Entra ID currently supports device-bound passkeys stored on FIDO2 security keys and in Microsoft Authenticator. Microsoft is committed to securing customers and users with passkeys. We are investing in both synced and device-bound passkeys for work accounts.

## Requirements

- [Microsoft Entra multifactor authentication (MFA)](howto-mfa-getstarted.md).
- [FIDO2 security keys eligible for attestation with Microsoft Entra ID](/entra/identity/authentication/concept-fido2-hardware-vendor) or Microsoft Authenticator.
- Devices that support passkey (FIDO2) authentication. For Windows devices that are joined to Microsoft Entra ID, the best experience is on Windows 10 version 1903 or higher. Hybrid-joined devices must run Windows 10 version 2004 or higher.

Passkeys (FIDO2) are supported across major scenarios on Windows, macOS, Android, and iOS. For more information on supported scenarios, see [Support for FIDO2 authentication in Microsoft Entra ID](fido2-compatibility.md).

## Passkey (FIDO2) Authenticator Attestation GUID (AAGUID)

The FIDO2 specification requires each security key vendor to provide an Authenticator Attestation GUID (AAGUID) during registration. An AAGUID is a 128-bit identifier indicating the key type, such as the make and model. Passkey (FIDO2) providers on desktop and mobile devices are also expected to provide an AAGUID during registration.

>[!NOTE]
>The vendor must ensure that the AAGUID is identical across all substantially identical security keys or passkey (FIDO2) providers made by that vendor, and different (with high probability) from the AAGUIDs of all other types of security keys or passkey (FIDO2) providers. To ensure this, the AAGUID for a given security key model or passkey (FIDO2) provider should be randomly generated. For more information, see [Web Authentication: An API for accessing Public Key Credentials - Level 2 (w3.org)](https://w3c.github.io/webauthn/).

You can work with your security key vendor to determine the AAGUID of the passkey (FIDO2), or see [FIDO2 security keys eligible for attestation with Microsoft Entra ID](~/identity/authentication/concept-fido2-hardware-vendor.md#fido2-security-keys-eligible-for-attestation-with-microsoft-entra-id). If the passkey (FIDO2) is already registered, you can find the AAGUID by viewing the authentication method details of the passkey (FIDO2) for the user.

![Screenshot of View AAGUID for passkey.](media/howto-authentication-passwordless-deployment/security-key-aaguid-details.png)

## Enable passkey (FIDO2) authentication method 

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Authentication Policy Administrator](~/identity/role-based-access-control/permissions-reference.md#authentication-policy-administrator).
1. Browse to **Protection** > **Authentication methods** > **Authentication method policy**.
1. Under the method **Passkey (FIDO2)**, set the toggle to **Enable**. Select **All users** or **Add groups** to select specific groups. *Only security groups are supported*.
1. On the **Configure** tab, set:

   - **Allow self-service set up** to **Yes**. If set to **No**, users can't register a passkey by using [Security info](https://mysignins.microsoft.com/security-info), even if passkeys (FIDO2) are enabled by the Authentication methods policy.  
   - **Enforce attestation** should be set to **Yes** if your organization wants to be assured that a FIDO2 security key model or passkey provider is genuine and comes from the legitimate vendor.
       - For FIDO2 security keys, we require security key metadata to be published and verified with the FIDO Alliance Metadata Service, and also pass Microsoft's another set of validation testing. For more information, see [Become a Microsoft-compatible FIDO2 security key vendor](/entra/identity/authentication/concept-fido2-hardware-vendor).
       - For passkeys in Microsoft Authenticator, attestation support is planned for General Availability.

     >[!WARNING]
     >Attestation enforcement governs whether a passkey (FIDO2) is allowed only during registration. Users who register a passkey (FIDO2) without attestation aren't blocked from sign-in if **Enforce attestation** is set to **Yes** later.

      - **Enforce key restrictions** to **Yes** to only allow or block certain passkeys (FIDO2), which are identified by their AAGUIDs. This setting must be **Yes** and add the Microsoft Authenticator AAGUIDs listed below to allow users to register passkeys in the Authenticator by signing into the Authenticator app or by going through a guided flow on the Security info page. 

        [Security info](https://mysignins.microsoft.com/security-info) doesn't require this setting be **Yes** to add a passkey in Authenticator. If you choose **No**, users may still be able to add a passkey in Microsoft Authenticator by going through the security key/passkey WebAuthn registration flow depending upon their operating system and browser. However, this is a flow we don't expect most users to stumble on and users will not be provided any instructions on how to set up the Authenticator app through this flow. 

        Key restrictions set the usability of specific passkeys (FIDO2) for both registration and authentication. If you change key restrictions and remove an AAGUID that you previously allowed, users who previously registered an allowed method can no longer use it for sign-in. 
     
        If your organization doesn't currently enforce key restrictions and already has active passkey (FIDO2) usage, you should collect the AAGUIDs of the keys being used today. Add them to the Allow list, along with the Authenticator AAGUIDs, to enable this preview. This task can be done with an automated script that analyzes logs, such as registration details and sign-in logs.

      - **Restrict specific keys** to **Allow** if you plan to allow passkeys in Microsoft Authenticator.
      - Select **Microsoft Authenticator (Preview)** to automatically add the Authenticator app AAGUIDs to the key restriction list, or manually add the following AAGUIDs to allow users to register passkeys in the Authenticator by signing into the Authenticator app or by going through a guided flow on the Security info page:

        - **Authenticator for Android:** de1e552d-db1d-4423-a619-566b625cdc84
        - **Authenticator for iOS:** 90a3ccdf-635c-4729-a248-9b709135078f
   
     >[!NOTE]
     >If you turn off key retrictions, make sure you clear the **Microsoft Authenticator (Preview)** checkbox so that users aren’t prompted to set up a passkey in the Authenticator app in [Security info](https://mysignins.microsoft.com/security-info).

     Two more AAGUIDs may be listed. 
     They are `b6879edc-2a86-4bde-9c62-c1cac4a8f8e5` and `257fa02a-18f3-4e34-8174-95d454c2e9ad`. 
     These AAGUIDs appear in advance of an upcoming feature. 
     You can remove them from the list of allowed AAGUIDs. 

   :::image type="content" border="true" source="media/how-to-enable-authenticator-passkey/optional-settings.png" alt-text="Screenshot showing Microsoft Authenticator enabled for passkey."lightbox="media/how-to-enable-authenticator-passkey/optional-settings.png":::

1. After you finish the configuration, select **Save**.

   >[!NOTE]
   >If you see an error when you try to save, replace multiple groups with a single group in one operation, and then click **Save** again.


## Provision FIDO2 security keys using Microsoft Graph API (preview)

Currently in preview, administrators can use [Microsoft Graph and custom clients to provision FIDO2 security keys on behalf of users](https://aka.ms/passkeyprovision). Provisioning requires the [Authentication Administrator role](/entra/identity/role-based-access-control/permissions-reference#authentication-administrator) or a client application with UserAuthenticationMethod.ReadWrite.All permission. The provisioning improvements include:

- The ability to request WebAuthn **creation Options** from Microsoft Entra ID
- The ability to register the provisioned security key directly with Microsoft Entra ID

With these new APIs, organizations can build their own clients to provision passkey (FIDO2) credentials on security keys on behalf of a user. To simplify this process, three main steps are required. 

1. **Request** creationOptions for a user: Microsoft Entra ID returns the necessary data for your client to provision a passkey (FIDO2) credential. This includes information such as user information, relying party ID, credential policy requirements, algorithms, registration challenge and more. 
2. **Provision** the passkey (FIDO2) credential with the creation Options: Use the `creationOptions` and a client that supports the Client to Authenticator Protocol (CTAP) to provision the credential. During this step, you need to insert you will need to insert the security key and set a PIN.
3. **Register** the provisioned credential with Microsoft Entra ID: Use the formatted output from the provisioning process to provide Microsoft Entra ID the necessary data to register the passkey (FIDO2) credential for the targeted user. 

:::image type="content" border="true" source="media/how-to-enable-passkey-fido2/provision.png" alt-text="Conceptual diagram that shows the steps required to provision passkeys (FIDO2)." :::

## Enable passkeys (FIDO2) using Microsoft Graph API

In addition to using the Microsoft Entra admin center, you can also enable passkeys (FIDO2) by using the Microsoft Graph API. To enable passkeys (FIDO2), you need to update the Authentication methods policy as at least an [Authentication Policy Administrator](../role-based-access-control/permissions-reference.md#authentication-policy-administrator). 

To configure the policy using Graph Explorer:

1. Sign in to [Graph Explorer](https://aka.ms/ge) and consent to the **Policy.Read.All** and **Policy.ReadWrite.AuthenticationMethod** permissions.

1. Retrieve the Authentication methods policy: 

   ```json
   GET https://graph.microsoft.com/beta/authenticationMethodsPolicy/authenticationMethodConfigurations/FIDO2
   ```

1. To disable attestation enforcement and enforce key restrictions to only allow the AAGUID for RSA DS100 for example, perform a PATCH operation using the following request body:

   ```json
   PATCH https://graph.microsoft.com/beta/authenticationMethodsPolicy/authenticationMethodConfigurations/FIDO2
   
   Request Body:
   {
       "@odata.type": "#microsoft.graph.fido2AuthenticationMethodConfiguration",
       "isAttestationEnforced": false,
       "keyRestrictions": {
           "isEnforced": true,
           "enforcementType": "allow",
           "aaGuids": [
               "7e3f3d30-3557-4442-bdae-139312178b39",
   
               <insert previous AAGUIDs here to keep them stored in policy>
           ]
       }
   }
   ```

1. Make sure that the passkey (FIDO2) policy is updated properly.

   ```json
   GET https://graph.microsoft.com/beta/authenticationMethodsPolicy/authenticationMethodConfigurations/FIDO2
   ```


## Delete a passkey (FIDO2)

To remove a passkey (FIDO2) associated with a user account, delete it from the user's authentication method.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) and search for the user whose passkey (FIDO2) needs to be removed.
1. Select **Authentication methods** > right-click **Passkey (device-bound)** and select **Delete**. 

    ![Screenshot of View Authentication Method details.](media/howto-authentication-passwordless-deployment/security-key-view-details.png)

## Enforce passkey (FIDO2) sign-in

To make users sign in with a passkey (FIDO2) when they access a sensitive resource, you can: 

- Use a built-in phishing-resistant authentication strength 

  Or
  
- Create a custom authentication strength

The following steps show how to create a custom authentication strength Conditional Access policy that allows passkey (FIDO2) sign-in for only a specific security key model or passkey (FIDO2) provider. For a list of FIDO2 providers, see [FIDO2 security keys eligible for attestation with Microsoft Entra ID](/entra/identity/authentication/concept-fido2-hardware-vendor).

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Conditional Access Administrator](../role-based-access-control/permissions-reference.md#conditional-access-administrator).
1. Browse to **Protection** > **Authentication methods** > **Authentication strengths**.
1. Select **New authentication strength**.
1. Provide a **Name** for your new authentication strength.
1. Optionally provide a **Description**.
1. Select **Passkeys (FIDO2)**.
1. Optionally, if you want to restrict by specific AAGUID(s), select **Advanced options** then **Add AAGUID**. Enter the AAGUID(s) that you allow. Select **Save**.
1. Choose **Next** and review the policy configuration.

## Known issues

### B2B collaboration users 

Registration of passkey (FIDO2) credentials isn't supported for B2B collaboration users in the resource tenant.

### UPN changes

If a user's UPN changes, you can no longer modify passkeys (FIDO2) to account for the change. If the user has a passkey (FIDO2), they need to sign in to [Security info](https://mysignins.microsoft.com/security-info), delete the old passkey (FIDO2), and add a new one.

## Next steps

[Native app and browser support of passkey (FIDO2) passwordless authentication](fido2-compatibility.md)

[FIDO2 security key Windows 10 sign in](howto-authentication-passwordless-security-key-windows.md)

[Enable FIDO2 authentication to on-premises resources](howto-authentication-passwordless-security-key-on-premises.md)

[Register security keys on behalf of users](how-to-enable-passkey-fido2.md)

[Learn more about device registration](~/identity/devices/overview.md)

[Learn more about Microsoft Entra multifactor authentication](~/identity/authentication/howto-mfa-getstarted.md)
