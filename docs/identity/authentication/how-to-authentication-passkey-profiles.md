---
title: How to Enable Passkey (FIDO2) Profiles in Microsoft Entra ID (Preview)
description: Learn how to enable passkey (FIDO2) profiles in Microsoft Entra ID.
ms.service: entra-id
ms.subservice: authentication
ms.topic: how-to
ms.date: 10/31/2025
ms.author: justinha
author: hanki71
manager: dougeby
ms.reviewer: kimhana
ms.custom: sfi-ga-nochange, sfi-image-nochange
# Customer intent: As a Microsoft Entra Administrator, I want to learn how to enable passkey (FIDO2) profiles in Microsoft Entra ID.
---
# How to enable passkey (FIDO2) profiles in Microsoft Entra ID (preview)

Passkey profiles enable granular group-based configurations for passkey FIDO2 authentication. Instead of a single tenant-wide setting, you can define specific requirements such as attestation, passkey type (device-bound or synced), or Authenticator Attestation GUID (AAGUID) restrictions. You can apply requirements in separate passkey profiles for different user groups, such as admins versus frontline staff.

>[!Note] 
>An Authentication Policy Administrator needs to configure a passkey profile (preview) to enable synced passkeys (preview). For more infomation, see [How to enable synced passkeys (FIDO2) in Microsoft Entra ID (preview)](how-to-authentication-synced-passkeys.md).

## What are passkey profiles?

A passkey profile is a named set of policy rules that governs how users in targeted groups can register and authenticate with passkeys (FIDO2). Profiles support advanced controls such as:

- Enforce attestation: Enabled, Disabled
- Target types: Device-bound, Synced
- Target specific authenticators: Allow or block specific authenticators by their AAGUID. For more information, see [Authenticator Attestation GUID](how-to-enable-passkey-fido2.md#passkey-fido2-authenticator-attestation-guid-aaguid).

## Before you begin

- Users must complete multifactor authentication (MFA) within the past five minutes before they can register a passkey (FIDO2).
- Users need an authenticator that supports Microsoft Entra ID's attestation requirements. For more information, see [Microsoft Entra ID attestation for FIDO2 security key vendors](concept-fido2-hardware-vendor.md).
- Devices must support passkey (FIDO2) authentication. For Windows devices that are joined to Microsoft Entra ID, the best experience is on Windows 10 version 1903 or higher. Hybrid-joined devices must run Windows 10 version 2004 or higher.
- Passkey profiles require Microsoft Authenticator iOS version 6.8.37 to be installed by end user client devices.
- Policy size limit:
  - The Authentication methods policy supports a size limit of 20KB. You can't save more passkey profiles after the size limit is reached. To check the size, use the [Get authenticationMethodsPolicy Microsoft Graph API](/graph/api/authenticationmethodspolicy-get) to retrieve the JSON for the Authentication methods policy. Save the output as a .txt file, then right-click and select **Properties** to view the file size.
  - Reference sizes:
    - Base passkey policy without changes: 1.44 KB
    - Target with 1 applied passkey profile: 0.23 KB
    - Target with 5 applied passkey profiles: 0.4 KB
    - Passkey profile with no AAGUIDs: 0.4 KB
    - Passkey profile with 10 AAGUIDs: 0.3 KB

## Enable passkey profiles (preview)

>[!NOTE]
>Upon opting-in to passkey profiles (preview), your global passkey (FIDO2) policy settings will be automatically transferred to a "Default passkey profile". A maximum of 3 passkey profiles, including the Default passkey profile are supported. Support for additional passkey profiles will come soon.

1. Sign in to the Microsoft Entra admin center as at least an [Authentication Policy Administrator](/entra/identity/role-based-access-control/permissions-reference#authentication-policy-administrator).
1. Browse to **Entra ID** > **Security** > **Authentication methods** > **Policies**.
1. Under the method Passkey (FIDO2), click **Opt-in to public preview** on the public preview banner to see the passkey profiles (preview) admin UX

   :::image type="content" border="true" source="media/how-to-authentication-passkey-profiles/passkey-settings.png" alt-text="Screenshot that shows how to opt in to preview."lightbox="media/how-to-authentication-passkey-profiles/passkey-settings.png":::

   >[!NOTE]
   >If you had Passkey (FIDO2) policy settings, they're automatically transferred to a Default passkey profile. Previous user targets are also automatically transferred to the new **Enable and target** tab.

1. To complete opting-in, click on the Default passkey profile and save your selections for Target Types. Your selection allows device-bound passkeys, synced passkeys, or both. 

   :::image type="content" border="true" source="media/how-to-authentication-passkey-profiles/default-passkey-profile.png" alt-text="Screenshot that shows the default passkey profile."lightbox="media/how-to-authentication-passkey-profiles/default-passkey-profile.png":::

   :::image type="content" border="true" source="media/how-to-authentication-passkey-profiles/edit-passkey-profile.png" alt-text="Screenshot that shows how to edit the default passkey profile."lightbox="media/how-to-authentication-passkey-profiles/edit-passkey-profile.png":::

For more information about how to use Graph Explorer to enable passkey profiles, see API docs.

## Create a new passkey profile

1. On the **Configure** tab, click **+ Add passkey profile**.

   :::image type="content" border="true" source="media/how-to-authentication-passkey-profiles/edit-passkey-profile.png" alt-text="Screenshot that shows how to edit the default passkey profile."lightbox="media/how-to-authentication-passkey-profiles/edit-passkey-profile.png":::

1. Fill out the profile details. The following table explains the impact of choosing to enforce attestation.

   Enforce attestation | Description 
   --------|-------------------
   Yes     | Your organization wants assurance that a FIDO2 security key model or passkey provider is genuine and comes from the legitimate vendor.<br>Metadata for FIDO2 security keys needs to be published and verified with the FIDO Alliance Metadata Service, and also pass another set of validation testing by Microsoft. For more information, see [Microsoft Entra ID attestation for FIDO2 security key vendors](concept-fido2-hardware-vendor.md).<br>You can't assign Synced passkeys to a group.<br>Selected users can only register device-bound passkeys. Attestation enforcement governs whether a passkey (FIDO2) is allowed only during registration; attestation isn't enforced during sign-in.<br>Passkeys in Microsoft Authenticator support attestation. For more information, see [How passkey attestation works with Authenticator](concept-authentication-authenticator-app.md#how-passkey-attestation-works-with-authenticator).
   No      | Your organization wants to allow selected users to register any type of passkey.<br>There's no assurance of the passkey type (device-bound vs synced) of the security key model or passkey provider.<br>There's no assurance of authenticity of the passkey even if **Enforce key restrictions** is set to **Yes**.<br>Users who register a passkey (FIDO2) without attestation aren't blocked from sign-in if **Enforce attestation** is set to **Yes** later.<br>

   **Enforce key restrictions** should be set to **Yes** only if your organization wants to only allow or disallow certain security key models or passkey providers, which are identified by their AAGUID. You can work with your security key vendor to determine the AAGUID of the passkey. If the passkey is already registered, you can find the AAGUID by viewing the authentication method details of the passkey for the user.
       
   >[!Warning] 
   >Key restrictions set the usability of specific models or providers for both registration and authentication. If you change key restrictions and remove an AAGUID that you previously allowed, users who previously registered an allowed method can no longer use it for sign-in.

1.	After you finish the configuration, select **Save**.

For more information about how to use Graph Explorer to create a new passkey profile, see API docs.

## Apply a passkey profile to a targeted group

1. Select **Enable and Target**.
1. Select **Add target** and select either **All users** or **Select targets** to select groups. 

   :::image type="content" border="true" source="media/how-to-authentication-passkey-profiles/add-target.png" alt-text="Screenshot that shows how to add a target for a passkey profile."lightbox="media/how-to-authentication-passkey-profiles/add-target.png":::

1. Select which passkey profiles you want assigned to a specific target.

   :::image type="content" border="true" source="media/how-to-authentication-passkey-profiles/select-passkey-profile.png" alt-text="Screenshot that shows how to select a passkey profile."lightbox="media/how-to-authentication-passkey-profiles/select-passkey-profile.png":::

   >[!NOTE]
   >A target group (for example, Engineering) can be scoped for multiple passkey profiles. When a user is scoped for multiple passkey profiles, registration and authentication with a passkey is allowed if it fully satisfies the requirement of one of the scoped passkey profiles. There's no particular order to the check. If a user is a member of an excluded group in the **Passkeys (FIDO2)** authentication method policy, they're blocked from FIDO2 passkey registration or sign-in. **Excluded** groups take precedence over **Included** groups.

For more information about how to use Graph Explorer to apply a passkey profile to a targeted group, see API docs.

## Delete a passkey profile

1. Select **Configure**.
1. Select the trash can to the right of the passkey profile you want to delete.

   >[!Note] 
   >You can only delete a profile if it's not assigned to a group of users in **Enable and target**. If the trash can is gray, first remove any targets that are assigned that profile.

   :::image type="content" border="true" source="media/how-to-authentication-passkey-profiles/delete-passkey-profile.png" alt-text="Screenshot that shows how to delete a passkey profile."lightbox="media/how-to-authentication-passkey-profiles/delete-passkey-profile.png":::

## Examples of use cases for passkey profiles

>[!NOTE] 
>At least Microsoft Authenticator iOS v6.8.37 or Android v. 6.2507.4749 are needed to work with passkey profiles.

###  Special consideration for high-privileged accounts

Passkey profile | Target groups | Passkey types | Attestation enforcement | Key Restrictions
----------------|---------------|---------------|-------------------------|-----------------
All device-bound passkeys (attestation enforced) | IT admins<br>Executives<br>Engineering | Device-bound | Enabled | Disabled
All synced or device-bound passkeys | HR<br>Sales | Device-bound, Synced |  Disabled |  Disabled 


### Targeted rollout of passkeys in Microsoft Authenticator 

Passkey profile | Target groups | Passkey types | Attestation enforcement | Key restrictions
----------------|---------------|---------------|-------------------------|-----------------
All device-bound passkeys (excluding Microsoft Authenticator) | All users | Device-bound | Enabled | Enabled<br>- Behavior: Block<br>- AAGUIDs: Microsoft Authenticator for iOS, Microsoft Authenticator for Android 
Passkeys in Microsoft Authenticator | Pilot group 1<br>Pilot group 2 | Device-bound | Enabled | Enabled<br>Behavior: Allow<br>- AAGUIDs: Microsoft Authenticator for iOS, Microsoft Authenticator for Android


## Related content

[How to enable synced passkeys (FIDO2) in Microsoft Entra ID (preview)](how-to-authentication-synced-passkeys.md)
