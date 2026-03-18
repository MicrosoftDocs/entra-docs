---
title: How to enable passkey (FIDO2) profiles in Microsoft Entra ID
description: Learn how to enable passkey (FIDO2) profiles in Microsoft Entra ID.
ms.topic: how-to
ms.date: 03/08/2026
author: hanki71
ms.reviewer: kimhana
ms.custom: sfi-ga-nochange, sfi-image-nochange
# Customer intent: As a Microsoft Entra Administrator, I want to learn how to enable passkey (FIDO2) profiles in Microsoft Entra ID.
---
# How to enable passkey (FIDO2) profiles in Microsoft Entra ID 

Passkey profiles enable granular group-based configurations for passkey (FIDO2) authentication. Instead of a single tenant-wide setting, you can define specific requirements such as attestation, passkey type (device-bound or synced), or Authenticator Attestation GUID (AAGUID) restrictions. You can apply requirements in separate passkey profiles for different user groups, such as admins versus frontline staff.

> [!NOTE]
> An Authentication Policy Administrator needs to configure a passkey profile to enable synced passkeys. For more information, see [How to enable synced passkeys (FIDO2) in Microsoft Entra ID](how-to-authentication-synced-passkeys.md).

## What are passkey profiles?

A passkey profile is a named set of policy rules that governs how users in targeted groups can register and authenticate with passkeys (FIDO2). Profiles support advanced controls such as:

| Option | Configuration |
|--------|---------------|
| Enforce attestation | Enabled, Disabled |
| Passkey types | Device-bound, Synced |
| Target specific authenticators | Allow or block specific authenticators by their AAGUID. For more information, see [Authenticator Attestation GUID](how-to-enable-passkey-fido2.md#passkey-fido2-authenticator-attestation-guid-aaguid). |

## Prerequisites

- Devices must support passkey (FIDO2) authentication. For Windows devices that are joined to Microsoft Entra ID, the best experience is on Windows 10 version 1903 or higher. Hybrid-joined devices must run Windows 10 version 2004 or higher.
- If a passkey profile for both device-bound and synced passkeys targets Microsoft Authenticator, users need to run Microsoft Authenticator iOS version 6.8.37 or Android version 6.2507.4749.
- Policy size limit:
  - The Authentication methods policy supports a size limit of 20 KB. You can't save more passkey profiles after the size limit is reached. To check the size, use the [Get authenticationMethodsPolicy Microsoft Graph API](/graph/api/authenticationmethodspolicy-get) to retrieve the JSON for the Authentication methods policy. Save the output as a .txt file, then right-click and select **Properties** to view the file size.
  - Reference sizes:
    - Base passkey policy without changes: 1.44 KB
    - Target with 1 applied passkey profile: 0.23 KB
    - Target with 5 applied passkey profiles: 0.4 KB
    - Passkey profile with no AAGUIDs: 0.4 KB
    - Passkey profile with 10 AAGUIDs: 0.3 KB
- Users must complete multifactor authentication (MFA) within the past five minutes before they can register a passkey (FIDO2).
- Users need an authenticator that supports Microsoft Entra ID's attestation requirements. For more information, see [Microsoft Entra ID attestation for FIDO2 security key vendors](concept-fido2-hardware-vendor.md).

## Enable passkey profiles 

> [!NOTE]
> When you enable passkey profiles, your global passkey (FIDO2) policy settings automatically transfer to a **Default passkey profile**. Up to three passkey profiles, including the **Default passkey profile**, are supported. Support for more passkey profiles is in development.

1. Sign in to the Microsoft Entra admin center as at least an [Authentication Policy Administrator](/entra/identity/role-based-access-control/permissions-reference#authentication-policy-administrator).
1. Browse to **Entra ID** > **Security** > **Authentication methods** > **Policies**.
1. Select **Passkey (FIDO2)**. Select the link in the banner text to opt-in to using passkeys profiles. 

   > [!NOTE]
   > After you opt in to enable passkeys, you can't opt out. 

   :::image type="content" border="true" source="media/how-to-authentication-passkey-profiles/passkey-settings.png" alt-text="Screenshot that shows how to enable passkey profiles." lightbox="media/how-to-authentication-passkey-profiles/passkey-settings.png":::

1. On the **Configure** tab, set **Allow self-service set up** to **Yes**. If set to **No**, users can't register a passkey by using [Security info](https://mysignins.microsoft.com/security-info), even if passkeys (FIDO2) are enabled by the Authentication methods policy. This setting is a global policy; it's not on the profile level.

1. Select the **Default passkey profile**. 

   :::image type="content" border="true" source="media/how-to-authentication-passkey-profiles/default-passkey-profile.png" alt-text="Screenshot that shows the default passkey profile." lightbox="media/how-to-authentication-passkey-profiles/default-passkey-profile.png":::
   
   For **Passkey types**, select the types of passkeys that you want to allow.

   :::image type="content" border="true" source="media/how-to-authentication-passkey-profiles/edit-passkey-profile.png" alt-text="Screenshot that shows how to edit the default passkey profile." lightbox="media/how-to-authentication-passkey-profiles/edit-passkey-profile.png":::

1. Select **Save**.

## Create a new passkey profile

1. On the **Configure** tab, select **+ Add passkey profile**.

1. Fill in the profile details.

   :::image type="content" border="true" source="media/how-to-authentication-passkey-profiles/add-passkey-profile.png" alt-text="Screenshot that shows how to add a passkey profile." lightbox="media/how-to-authentication-passkey-profiles/add-passkey-profile.png":::

   The following table explains the impact if you enforce attestation. For other vendor attestation requirements, see [Microsoft Entra ID attestation for FIDO2 security key vendors](concept-fido2-hardware-vendor.md).

     >[!WARNING]
     >- If you set **Enforce attestation** to **No**, users can register any type of passkey. Set **Enforce attestation** to **Yes** to ensure that users can only register device-bound passkeys.
     >
     >- Attestation enforcement governs whether a passkey (FIDO2) is allowed only during registration. Users who register a passkey (FIDO2) without attestation aren't blocked from sign-in if **Enforce attestation** is set to **Yes** later.
     
   The next table describes profile target options. 

   Target | Description
   --------|------------
   Passkey types | You can allow device-bound passkeys, and synced passkeys if **Enforce attestation** is set to **No**.
   Target specific AAGUIDs | You can allow or block certain security key models or passkey providers, identified by their AAGUID, to control which authenticators users can use to register and sign in with passkeys.<br>If you remove an AAGUID that you previously allowed, users who registered that passkey (FIDO2) as an allowed method can no longer use it for sign-in.

1. Select **Save**.


## Apply a passkey profile to a targeted group

1. Select **Enable and Target**.
1. Select **Add target**, and then choose **All users** or **Select targets** to choose specific groups.

   :::image type="content" border="true" source="media/how-to-authentication-passkey-profiles/add-target.png" alt-text="Screenshot that shows how to add a target for a passkey profile." lightbox="media/how-to-authentication-passkey-profiles/add-target.png":::

1. Select the passkey profiles that you want to assign to a specific target.

   :::image type="content" border="true" source="media/how-to-authentication-passkey-profiles/select-passkey-profile.png" alt-text="Screenshot that shows how to select a passkey profile." lightbox="media/how-to-authentication-passkey-profiles/select-passkey-profile.png":::

   > [!NOTE]
   > A target group (for example, Engineering) can be scoped for multiple passkey profiles. When a user is scoped for multiple passkey profiles, registration and authentication with a passkey are allowed if the passkey fully satisfies the requirements of at least one of the scoped passkey profiles. There's no particular order to the check. If a user is a member of an excluded group in the **Passkeys (FIDO2)** authentication method policy, they're blocked from FIDO2 passkey registration or sign-in entirely, and this takes precedence over them being in any **Included** groups.

## Delete a passkey profile

1. Select **Configure**.
1. Select the delete icon next to the passkey profile that you want to delete, and then select **Save**.

   > [!NOTE]
   > You can delete a profile only if it's not assigned to a group of users in **Enable and target**. If the delete icon is unavailable, first remove any targets that are assigned that profile.

   :::image type="content" border="true" source="media/how-to-authentication-passkey-profiles/delete-passkey-profile.png" alt-text="Screenshot that shows how to delete a passkey profile." lightbox="media/how-to-authentication-passkey-profiles/delete-passkey-profile.png":::

## Examples of use cases for passkey profiles

> [!NOTE]
> If a passkey profile for both device-bound and synced passkeys targets Microsoft Authenticator, users need to run Microsoft Authenticator iOS version 6.8.37 or Android version 6.2507.4749.

### Special consideration for high-privileged accounts

Passkey profile | Target groups | Passkey types | Attestation enforcement | Key restrictions
----------------|---------------|---------------|-------------------------|-----------------
All device-bound passkeys (attestation enforced) | IT admins<br>Executives<br>Engineering | Device-bound | Enabled | Disabled
All synced or device-bound passkeys | HR<br>Sales | Device-bound, Synced | Disabled | Disabled


### Targeted rollout of passkeys in Microsoft Authenticator 

Passkey profile | Target groups | Passkey types | Attestation enforcement | Key restrictions
----------------|---------------|---------------|-------------------------|-----------------
All device-bound passkeys (excluding Microsoft Authenticator) | All users | Device-bound | Enabled | Enabled<br>- Behavior: Block<br>- AAGUIDs: Microsoft Authenticator for iOS, Microsoft Authenticator for Android 
Passkeys in Microsoft Authenticator | Pilot group 1<br>Pilot group 2 | Device-bound | Enabled | Enabled<br>- Behavior: Allow<br>- AAGUIDs: Microsoft Authenticator for iOS, Microsoft Authenticator for Android

## Known issues

### Security key provisioning

Administrator provisioning of security keys is in preview. See [Microsoft Graph and custom clients to provision FIDO2 security keys on behalf of users](https://aka.ms/passkeyprovision).

### Guest users 

Registration of passkey (FIDO2) credentials isn't supported for internal or external guest users, including B2B collaboration users in the resource tenant.

### UPN changes

If a user's UPN changes, you can no longer modify passkeys (FIDO2) to account for the change. If the user has a passkey (FIDO2), they need to sign in to [Security info](https://mysignins.microsoft.com/security-info), delete the old passkey (FIDO2), and add a new one.

## Related content

[How to enable synced passkeys (FIDO2) in Microsoft Entra ID](how-to-authentication-synced-passkeys.md)
