---
title: Enable passkeys in Authenticator for Microsoft Entra ID
description: Learn about how to enable passkeys in Microsoft Authenticator for Microsoft Entra ID.
ms.service: entra-id
ms.subservice: authentication
ms.topic: how-to
ms.date: 04/02/2025
ms.author: justinha
author: justinha
manager: femila
ms.reviewer: mjsantani
ms.custom: sfi-ga-nochange, sfi-image-nochange
# Customer intent: As a Microsoft Entra administrator, I want to learn how to enable and enforce passkeys in Microsoft Authenticator sign-in for users.
---
# Enable passkeys in Authenticator

This article lists steps to enable and enforce use of passkeys in Authenticator for Microsoft Entra ID. First, you update the Authentication methods policy to allow users to register and sign in with passkeys in Authenticator. Then you can use Conditional Access authentication strengths policies to enforce passkey sign-in when users access a sensitive resource.

## Requirements

- [Microsoft Entra multifactor authentication (MFA)](howto-mfa-getstarted.md).
- Android 14 and later or iOS 17 and later.
- For cross-device registration and authentication:
  - Both devices must have Bluetooth enabled.
  - Internet connectivity to these two endpoints must be allowed in your organization:
    - `https://cable.ua5v.com`
    - `https://cable.auth.com`

  > [!NOTE]
  > Users can't use cross-device registration if you enable attestation. 

To learn more about FIDO2 support, see [Support for FIDO2 authentication with Microsoft Entra ID](fido2-compatibility.md).

## Enable passkeys in Authenticator in the admin center

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Authentication Policy Administrator](~/identity/role-based-access-control/permissions-reference.md#authentication-policy-administrator).
1. Browse to **Entra ID** > **Authentication methods** > **Authentication method policy**.
1. Under the method **Passkey (FIDO2)**, select **All users** or **Add groups** to select specific groups. *Only security groups are supported*.
1. On the **Configure** tab:
   - Set **Allow self-service set up** to **Yes**. If it's set to **No**, users can't register a passkey by using [Security info](https://mysignins.microsoft.com/security-info), even if passkeys (FIDO2) are enabled by the Authentication methods policy.
   - Set **Enforce attestation** to **Yes** or **No**.

     When attestation is enabled in the passkey (FIDO2) policy, Microsoft Entra ID tries to verify the legitimacy of the passkey being created. When the user is registering a passkey in the Authenticator, attestation verifies that the legitimate Authenticator app created the passkey by using Apple and Google services. Here are more details:

     - **iOS**: Authenticator attestation uses the [iOS App Attest service](https://developer.apple.com/documentation/devicecheck/preparing-to-use-the-app-attest-service) to ensure the legitimacy of the Authenticator app before registering the passkey.
            
     - **Android**:
       - For Play Integrity attestation, Authenticator attestation uses the [Play Integrity API](https://developer.android.com/google/play/integrity/overview) to ensure the legitimacy of the Authenticator app before registering the passkey.
       - For Key attestation, Authenticator attestation uses [key attestation by Android](https://developer.android.com/privacy-and-security/security-key-attestation) to verify that the passkey being registered is hardware-backed.

     > [!NOTE]
     > For both iOS and Android, Authenticator attestation relies upon Apple and Google services to verify the authenticity of the Authenticator app. Heavy service usage can make passkey registration fail, and users might need to try again. If Apple and Google services are down, Authenticator attestation blocks registration that requires attestation until services are restored. To monitor the status of Google Play Integrity service, see [Google Play Status Dashboard](https://status.play.google.com/). To monitor the status of the iOS App Attest service, see [System Status](https://developer.apple.com/system-status/).
    
    > [!NOTE]
    > Users can only register attested passkeys directly in the Authenticator app. Cross-device registration flows don't support registration of attested passkeys.

   - **Key restrictions** set the usability of specific passkeys for both registration and authentication. You can set **Enforce key restrictions** to **No** to allow users to register any supported passkey, including passkey registration directly in the Authenticator app. If you set **Enforce key restrictions** to **Yes** and already have active passkey usage, you should collect and add the AAGUIDs of the passkeys being used today. 

     If you set **Restrict specific keys** to **Allow**, select **Microsoft Authenticator** to automatically add the Authenticator app AAGUIDs to the key restrictions list. You can also manually add the following AAGUIDs to allow users to register passkeys in Authenticator by signing in to the Authenticator app or by going through a guided flow on **Security info**:

     - **Authenticator for Android**: `de1e552d-db1d-4423-a619-566b625cdc84`
     - **Authenticator for iOS**: `90a3ccdf-635c-4729-a248-9b709135078f`
            
     If you change key restrictions and remove an AAGUID that you previously allowed, users who previously registered an allowed method can no longer use it for sign-in.

     > [!NOTE]
     > If you turn off key restrictions, make sure you clear the **Microsoft Authenticator** checkbox so that users aren't prompted to set up a passkey in the Authenticator app on [Security info](https://mysignins.microsoft.com/security-info).

   :::image type="content" border="true" source="media/how-to-enable-authenticator-passkey/optional-settings.png" alt-text="Screenshot that shows Authenticator enabled for passkey."lightbox="media/how-to-enable-authenticator-passkey/optional-settings.png":::

1. After you finish the configuration, select **Save**.

   If you see an error when you try to save, replace multiple groups with a single group in one operation, and then select **Save** again.

## Enable passkeys in Authenticator by using Graph Explorer

In addition to using the Microsoft Entra admin center, you can also enable passkeys in Authenticator by using Graph Explorer. If you're assigned at least the [Authentication Policy Administrator](../role-based-access-control/permissions-reference.md#authentication-policy-administrator) role, you can update the Authentication methods policy to allow the AAGUIDs for Authenticator.

To configure the policy by using Graph Explorer:

1. Sign in to [Graph Explorer](https://aka.ms/ge) and consent to the **Policy.Read.All** and **Policy.ReadWrite.AuthenticationMethod** permissions.

1. Retrieve the Authentication methods policy:

   ```json
   GET https://graph.microsoft.com/v1.0/authenticationMethodsPolicy/authenticationMethodConfigurations/FIDO2
   ```

1. To disable attestation enforcement and enforce key restrictions to allow only AAGUIDs for Authenticator, perform a `PATCH` operation by using the following request body:

   ```json
   PATCH https://graph.microsoft.com/v1.0/authenticationMethodsPolicy/authenticationMethodConfigurations/FIDO2
   
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
   GET https://graph.microsoft.com/v1.0/authenticationMethodsPolicy/authenticationMethodConfigurations/FIDO2
   ```

## Find AAGUIDs

Use the `GetRegisteredPasskeyAAGUIDsForAllUsers.ps1` Microsoft Graph PowerShell script to enumerate the AAGUIDs of all registered passkeys in the tenant.

Save the body of this script to a file called `GetRegisteredPasskeyAAGUIDsForAllUsers.ps1`.

```powershell
# Disconnect from Microsoft Graph
Disconnect-MgGraph

# Connect to Microsoft Graph with required scopes
Connect-MgGraph -Scope 'User.Read,UserAuthenticationMethod.Read,UserAuthenticationMethod.Read.All'

# Define the output file [If the script is run more than once, delete the file to avoid appending to it.]
$file = ".\AAGUIDs.txt"

# Initialize the file with a header
Set-Content -Path $file -Value '---'

# Retrieve all users
$UserArray = Get-MgBetaUser -All

# Iterate through each user
foreach ($user in $UserArray) {
    # Retrieve Passkey authentication methods for the user
    $fidos = Get-MgBetaUserAuthenticationFido2Method -UserId $user.Id

    if ($fidos -eq $null) {
        # Log and write to file if no Passkey methods are found
        Write-Host "User object ID $($user.Id) has no Passkey"
        Add-Content -Path $file -Value "User object ID $($user.Id) has no Passkey"
    } else {
        # Iterate through each Passkey method
        foreach ($fido in $fidos) {
            # Log and write to file the Passkey details
            Write-Host "- User object ID $($user.Id) has a Passkey with AAGUID $($fido.Aaguid) of Model type '$($fido.Model)'"
            Add-Content -Path $file -Value "- User object ID $($user.Id) has a Passkey with AAGUID $($fido.Aaguid) of Model type '$($fido.Model)'"
        }
    }

    # Log and write a separator to file
    Write-Host "==="
    Add-Content -Path $file -Value "==="
}
```

## Restrict Bluetooth usage to passkeys in Authenticator

Some organizations restrict Bluetooth usage, which includes the use of passkeys. In such cases, organizations can allow passkeys by permitting Bluetooth pairing exclusively with passkey-enabled FIDO2 authenticators. For more information about how to configure Bluetooth usage only for passkeys, see [Passkeys in Bluetooth-restricted environments](/windows/security/identity-protection/passkeys/?tabs=windows%2Cintune#passkeys-in-bluetooth-restricted-environments).

## Delete a passkey

If a user deletes a passkey in Authenticator, the passkey is also removed from the user's sign-in methods. An Authentication Policy Administrator can also follow these steps to delete a passkey from the user's authentication methods, but it won't remove the passkey from Authenticator.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com), and search for the user whose passkey must be removed.
1. Select **Authentication methods**, right-click **Passkey**, and select **Delete**.

   Unless the user initiated the passkey deletion themselves in Authenticator, they need to also remove the passkey in Authenticator on their device.

## Enforce sign-in with passkeys in Authenticator

To make users sign in with a passkey when they access a sensitive resource, use the built-in phishing-resistant authentication strength, or create a custom authentication strength by following these steps:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as a Conditional Access Administrator.
1. Browse to **Entra ID** > **Authentication methods** > **Authentication strengths**.
1. Select **New authentication strength**.
1. Provide a descriptive name for your new authentication strength.
1. Optionally, provide a description.
1. Select **Passkeys (FIDO2)**, and then select **Advanced options**.
1. Select **Phishing-resistant MFA strength** or add AAGUIDs for passkeys in Authenticator:

   - **Authenticator for Android**: `de1e552d-db1d-4423-a619-566b625cdc84`
   - **Authenticator for iOS**: `90a3ccdf-635c-4729-a248-9b709135078f`

1. Select **Next**, and review the policy configuration.

## Related content

- [Support for passkey in Windows](/windows/security/identity-protection/passkeys)
