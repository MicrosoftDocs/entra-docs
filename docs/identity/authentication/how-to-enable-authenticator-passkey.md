---
title: How to enable Microsoft Authenticator passkey sign in for Entra ID (preview)
description: Learn about how to enable Microsoft Authenticator passkey sign in for Entra ID

ms.service: entra-id
ms.subservice: authentication
ms.topic: how-to
ms.date: 03/06/2024

ms.author: justinha
author: justinha
manager: amycolannino
ms.reviewer: calui

# Customer intent: As a Microsoft Entra Administrator, I want to learn how to enable and enforce Microsoft Authenticator passkey sign in for end users.
---
# Enable Microsoft Authenticator passkey sign in (preview)

For enterprises that use passwords today and have a shared PC environment, passkeys provide a seamless way for workers to authenticate without entering a username or password. Passkeys provide improved security for workers because they can't be phished, stolen, or re-used.

This topic lists steps to enable and enforce Microsoft Authenticator passkey sign-in for Entra ID. First, you'll update the Authentication methods policy to allow end users to sign in with Authenticator passkey. Then you'll create a custom authentication strength to enforce passkey sign-in when users access a sensitive resource.

## Requirements

- [Microsoft Entra multifactor authentication (MFA)](howto-mfa-getstarted.md)
- Enable [Combined security information registration](concept-registration-mfa-sspr-combined.md)
- Android 14 and later or iOS 17 and later

To use security keys for logging in to web apps and services, you must have a browser that supports the WebAuthN protocol. 
These include Microsoft Edge, Chrome, Firefox, and Safari. For more information, see [Browser support of FIDO2 passwordless authentication](fido2-compatibility.md).

>[!NOTE]
>Passkeys (FIDO2) stored on computers and mobile devices along with registering and signing in via WebAuthn QR code is not yet supported by Entra ID.


## Enable Authenticator passkey in the admin center

To enable Authenticator passkey, you edit the **Passkey (FIDO2)** method policy, the same way you enable another passkey provider. The **Microsoft Authenticator** policy doesn't have an option to enable passkey. 

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Authentication Policy Administrator](~/identity/role-based-access-control/permissions-reference.md#authentication-policy-administrator).
1. Browse to **Protection** > **Authentication methods** > **Authentication method policy**.
1. Under the method **Passkey (FIDO2)**, click **All users**, or click **Add groups** to select specific groups. *Only security groups are supported*.
1. **Save** the configuration.

   >[!NOTE]
   >If you see an error when you try to save, the cause might be due to the number of users or groups being added. As a workaround, replace the users and groups you are trying to add with a single group, in the same operation, and then click **Save** again.

1. On the **Configure** tab, set **Enforce key restrictions** to **Yes**, set **Restrict specific keys** to **Allow**, and sslect **Microsoft Authenticator (preview)**. 
   
   :::image type="content" border="true" source="media/how-to-enable-authenticator-passkey/optional-settings.png" alt-text="Screenshot showing Microsoft Authenticator enabled for passkey.":::

The following list describes other optional settings:

**General**

- **Allow self-service set up** should remain set to **Yes**. If set to no, your users won't be able to register a passkey through MySecurityInfo, even if enabled by Authentication Methods policy.  
- **Enforce attestation** Should be set to **No** for preview. If set to **Yes**, the passkey metadata needs to be published and verified with the FIDO Alliance Metadata Service, and also pass Microsoft's additional set of validation testing. For more information, see [What is a Microsoft-compatible security key?](concept-authentication-passwordless.md#fido2-security-key-providers). Attestation support is planned for General Availability.

**Key Restriction Policy**

- **Enforce key restrictions** should be set to **Yes** only if your organization wants to only allow or disallow certain passkeys, which are identified by their Authenticator Attestation GUID (AAGUID). If you want to manually add the Authenticator app AAGUIDs, or specifically restrict only Android or iOS devices, you can manually enter their Authenticator AAGUID:

  - Authenticator for Android: de1e552d-db1d-4423-a619-566b625cdc84
  - Authenticator for iOS: 90a3ccdf-635c-4729-a248-9b709135078f

  >[!WARNING]
  >Key restrictions set the usability of specific passkeys for both registration and authentication. If you change key restrictions and remove an AAGUID that you previously allowed, users who previously registered an allowed method can no longer use it for sign-in. 


## Enable Authenticator passkey using Graph Explorer

In addition to using the Microsoft Entra admin center, you can also enable Authenticator passkey by using Graph Explorer. **Global Administrators** and **Authentication Policy Administrators** can update the Authentication Methods Policy to allow the AAGUIDs for Authenticator. 

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
       "isAttestationEnforced": false,
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

1. Make sure that the passkey (FIDO2) policy has been updated properly.

   ```json
   GET https://graph.microsoft.com/beta/authenticationMethodsPolicy/authenticationMethodConfigurations/FIDO2
   ```


## Disable a passkey 

To remove a passkey associated with a user account, delete the key from the user’s authentication method.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) and search for the user account that needs the passkey to be removed.
1. Select **Authentication methods** > right-click **passkey (FIDO2)** and click **Delete**. 

    ![View Authentication Method details](media/howto-authentication-passwordless-deployment/security-key-view-details.png)


## Enforce Authenticator passkey sign-in 

You can use either a built-in phishing-resistant authentication strength or create a custom authentication strength to make users sign in with a passkey when they access a sensitive resource. The following steps explain how to create a Conditional Access policy that 

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as a Conditional Access Administrator.
1. Browse to **Protection** > **Authentication methods** > **Authentication strengths**.
1. Select **New authentication strength**.
1. Provide a descriptive **Name** for your new authentication strength.
1. Optionally provide a **Description**.
1. Select **Passkeys (FIDO2)** and then click **Advanced options**.

   :::image type="content" border="true" source="media/concept-authentication-strengths/authentication-strength-custom.png" alt-text="Screenshot showing the creation of a custom authentication strength.":::

1. Set Enforce key restrictions to **Yes**.
1. Set Restrict specific keys to **Allow**.
1. Add AAGUIDs for Authenticator passkey:

   - de1e552d-db1d-4423-a619-566b625cdc84
   - 90a3ccdf-635c-4729-a248-9b709135078f

   :::image type="content" border="true" source="media/how-to-enable-authenticator-passkey/optional-settings.png" alt-text="Screenshot showing the AAGUIDs for Authenticator.":::

1. Choose **Next** and review the policy configuration.

## Known issues

### Administrator passkey provisioning

Administrator provisioning and de-provisioning of passkey isn't available.

### UPN changes

If a user's UPN changes, you can no longer modify a passkey to account for the change. If the user has a passkey, they need to sign in to MySecurityInfo, delete the old key, and add a new one.

## Next steps

[Support for passkey in Windows](/windows/security/identity-protection/passkeys)

