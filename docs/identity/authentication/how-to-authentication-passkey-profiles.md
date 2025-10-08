---
title: How to enable passkey (FIDO2) profiles in Microsoft Entra ID
description: Learn how to enable passkey (FIDO2) profiles in Microsoft Entra ID.
ms.service: entra-id
ms.subservice: authentication
ms.topic: how-to
ms.date: 10/07/2025
ms.author: justinha
author: hanki77
manager: dougeby
ms.reviewer: kimhana
ms.custom: sfi-ga-nochange, sfi-image-nochange
# Customer intent: As a Microsoft Entra Administrator, I want to learn how to enable passkey (FIDO2) profiles in Microsoft Entra ID.
---
# How to enable passkey (FIDO2) profiles in Microsoft Entra ID

Passkey profiles enable granular group-based configurations for FIDO2 (passkey) authentication. Instead of a single tenant-wide setting, you can define specific requirements such as attestation, passkey type (device-bound or synced), and AAGUID restrictions, and apply them to different user groups (for example, admins versus frontline staff).
! Note: Passkey profiles (preview) is a pre-requisite for enabling synced passkeys (preview). See [synced passkeys documentation]

## What are passkey profiles?

A passkey profile is a named set of policy rules that governs how users in targeted groups can register and authenticate with passkeys (FIDO2). Profiles support advanced controls such as:

- Enforce attestation
- Target types (device-bound, synced)
- Target specific passkeys: allow or block specific authenticators by their AAGUID. For more information, see [Authenticator Attestation GUID](https://learn.microsoft.com/entra/identity/authentication/how-to-enable-passkey-fido2#passkey-fido2-authenticator-attestation-guid-aaguid).

## Before you begin

- Users must complete multifactor authentication (MFA) within the past five minutes before they can register a passkey (FIDO2).
- Users need a passkey (FIDO2) that is eligible for attestation with Microsoft Entra ID, or Microsoft Authenticator. For more information, see [Microsoft Entra ID attestation for FIDO2 security key vendors](concept-fido2-hardware-vendor.md).
- Devices must support passkey (FIDO2) authentication. For Windows devices that are joined to Microsoft Entra ID, the best experience is on Windows 10 version 1903 or higher. Hybrid-joined devices must run Windows 10 version 2004 or higher.
- Passkey profiles require Microsoft Authenticator version X to be installed by end user client devices.
- Policy size limit:
  - Currently, the Authentication methods policy supports a size limit of 20KB. You can't save more passkey profiles after the size limit is reached. To check the size, use the [Get authenticationMethodsPolicy Microsoft Graph API](/graph/api/authenticationmethodspolicy-get) to retrieve the JSON for the Authentication methods policy. Save the output as a .txt file, then right-click and select **Properties** to view the file size.
  - Reference sizes:
    - Base passkey policy without changes: 1.44 KB
    - Target with 1 applied passkey profile: 0.23 KB
    - Target with 5 applied passkey profiles: 0.4 KB
    - Passkey profile with no AAGUIDs: 0.4 KB
    - Passkey profile with 10 AAGUIDs: 0.3 KB

## Enable passkey profiles (preview)

>[!NOTE]
>A maximum of 3 passkey profiles, including the Default passkey profile are supported. We’re investing in support for more passkey profiles. 

1. Sign in to the Microsoft Entra admin center as at least an [Authentication Policy Administrator](/entra/identity/role-based-access-control/permissions-reference#authentication-policy-administrator).
1. Browse to **Entra ID** > **Authentication methods** > **Authentication method policy**.
1. Under the method Passkey (FIDO2), click **Opt-in to public preview** on the public preview banner to see the passkey profiles (preview) admin UX

   :::image type="content" border="true" source="media/how-to-authentication-passkey-profiles/passkey-settings.png" alt-text="Screenshot that shows how to opt in to preview."lightbox="media/how-to-authentication-passkey-profiles/passkey-settings.png":::

   >[!NOTE]
   >If you had previous Passkey (FIDO2) policy settings, they will be automatically transferred to a Default passkey profile. Any previous user targets will also be automatically transferred to the new **Enable and target** tab.

1. To complete opting-in, click on the Default passkey profile and save your selections for Target Types. Your selection will allow device-bound passkeys, synced passkeys, or both. 

   :::image type="content" border="true" source="media/how-to-authentication-passkey-profiles/default-passkey-profile.png" alt-text="Screenshot that shows the default passkey profile."lightbox="media/how-to-authentication-passkey-profiles/default-passkey-profile.png":::

   :::image type="content" border="true" source="media/how-to-authentication-passkey-profiles/edit-passkey-profile.png" alt-text="Screenshot that shows how to edit the default passkey profile."lightbox="media/how-to-authentication-passkey-profiles/edit-passkey-profile.png":::

For more information about how to use Graph Explorer to enable passkey profiles, see API docs.

## Create a new passkey profile

1. On the **Configure** tab, click **+ Add passkey profile**.

   :::image type="content" border="true" source="media/how-to-authentication-passkey-profiles/edit-passkey-profile.png" alt-text="Screenshot that shows how to edit the default passkey profile."lightbox="media/how-to-authentication-passkey-profiles/edit-passkey-profile.png":::

1. Fill out the profile details:

   - Set **Enforce attestation** to **Yes** if your organization wants to be assured that a FIDO2 security key model or passkey provider is genuine and comes from the legitimate vendor.
     - Metadata for FIDO2 security keys needs to be published and verified with the FIDO Alliance Metadata Service, and also pass another set of validation testing by Microsoft. For more information, see [Microsoft Entra ID attestation for FIDO2 security key vendors](concept-fido2-hardware-vendor.md).
     - Passkeys in Microsoft Authenticator also support attestation. For more information, see [How passkey attestation works with Authenticator](concept-authentication-authenticator-app.md#how-passkey-attestation-works-with-authenticator).
     Warning
     - If you set **Enforce attestation** to **No**, users can register any type of passkey. Set **Enforce attestation** to **Yes** to ensure that users can only register device-bound passkeys.
     - Attestation enforcement governs whether a passkey (FIDO2) is allowed only during registration. Users who register a passkey (FIDO2) without attestation aren't blocked from sign-in if **Enforce attestation** is set to **Yes** later.
   - Set Target types to allow either device-bound passkeys, synced passkeys or both. 

     Warning: 
     Synced passkeys do not support attestation. Therefore, you cannot select target type of Synced passkeys if Enforce attestation is set to Yes. 

     Note: 
     When target type is selected but attestation is not enforced, we cannot guarantee the passkey type (device-bound vs synced) of the security key model or passkey provider. 

   - Target specific passkeys
     - Restriction Policy
       - **Enforce key restrictions** should be set to **Yes** only if your organization wants to only allow or disallow certain security key models or passkey providers, which are identified by their AAGUID. You can work with your security key vendor to determine the AAGUID of the passkey. If the passkey is already registered, you can find the AAGUID by viewing the authentication method details of the passkey for the user.
       
       Warning: Key restrictions set the usability of specific models or providers for both registration and authentication. If you change key restrictions and remove an AAGUID that you previously allowed, users who previously registered an allowed method can no longer use it for sign-in.

       Note: When AAGUID key restrictions are enforced but attestation is not enforced, we cannot guarantee the authenticity of the security key model or passkey provider. 

5.	After you finish the configuration, select **Save**.

For more information about how to use Graph Explorer to create a new passkey profile, see API docs.

## Apply a passkey profile to a targeted group

1. Navigate to the Enable and Target tab
1. Select **Add target** and select either **All users** or **Select targets** to select groups. 

   :::image type="content" border="true" source="media/how-to-authentication-passkey-profiles/add-target.png" alt-text="Screenshot that shows how to add a target for a passkey profile."lightbox="media/how-to-authentication-passkey-profiles/add-target.png":::

   >[!NOTE] 
   >You can have both an **All users** target and selected groups as targets at the same time.

1. Select which passkey profiles you want assigned to a specific target.

   :::image type="content" border="true" source="media/how-to-authentication-passkey-profiles/select-passkey-profile.png" alt-text="Screenshot that shows how to select a passkey profile."lightbox="media/how-to-authentication-passkey-profiles/select-passkey-profile.png":::

   >[!NOTE]
   >A target group (e.g. Engineering) can be scoped for multiple passkey profiles. When a user is scoped for multiple passkey profiles, we allow the registration and usage of a passkey if it fully satisfies the requirement of one of the scoped passkey profiles. You can think of it as Entra looping through each passkey profile to see if there is a match with the given passkey. If there is no match at all, then we will deny the passkey. There is no particular order to this logic. If a user is in a group added to the Passkeys (FIDO2) exclude list, they will be blocked from registering or authenticating with any FIDO2 passkeys. The exception list takes precedence over any passkey profile targeting.

For more information about how to use Graph Explorer to apply a passkey profile to a targeted group, see API docs.

## Delete a passkey profile

1. Select **Configure**.
1. Select the trash can to the right of the passkey profile you want to delete.

   >[!Note] 
   >You can only delete a profile if it's not assigned to a group of users in **Enable and target**. If the trash can is gray, first remove any users who are assigned that profile.

   :::image type="content" border="true" source="media/how-to-authentication-passkey-profiles/delete-passkey-profile.png" alt-text="Screenshot that shows how to delete a passkey profile."lightbox="media/how-to-authentication-passkey-profiles/delete-passkey-profile.png":::

## Examples of use cases for passkey profiles

>[!NOTE] 
>At least Authenticator app version X is needed to work with passkey profiles.

###  Special consideration for high-privileged accounts

Passkey profile | Target groups | Passkey types | Attestation enforcement | Key Restrictions
----------------|---------------|---------------|-------------------------|-----------------
All device-bound passkeys (attestation enforced) | IT admins<br>Executives<br>Engineering | Device-bound | Enabled | Disabled
All synced or device-bound passkeys | Pilot group 1<br>Pilot group 2 | Device-bound, Synced |  Disabled |  Disabled 


### Targeted rollout of Passkeys in Microsoft Authenticator 

Passkey profile | Target groups | Passkey types | Attestation enforcement | Key Restrictions
----------------|---------------|---------------|-------------------------|-----------------
All device-bound passkeys (excluding Microsoft Authenticator) | All users | Device-bound | Enabled | Enabled<br>- Behavior: Block<br>- AAGUIDs: Microsoft Authenticator for iOS, Microsoft Authenticator for Android 
Passkeys in Microsoft Authenticator | Pilot group 1<br>Pilot group 2 | Device-bound | Enabled | Enabled<br>Behavior: Allow<br>- AAGUIDs: Microsoft Authenticator for iOS, Microsoft Authenticator for Android


## Related content