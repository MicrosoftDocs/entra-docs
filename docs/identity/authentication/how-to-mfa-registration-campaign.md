---
title: Run a Registration Campaign to Set Up a Passkey or Microsoft Authenticator
description: Learn how to run a registration campaign in Microsoft Entra ID to nudge users toward passkeys or Microsoft Authenticator for stronger sign-in security.
ms.topic: how-to
ms.date: 05/20/2026
ms.reviewer: marisanchez
ai-usage: ai-assisted
ms.custom: sfi-ga-nochange, sfi-image-nochange, msecd-doc-authoring-1012
#Customer intent: As an identity administrator, I want to encourage users to set up a passkey or Microsoft Authenticator in Microsoft Entra ID to improve and secure user sign-in events.
---

# Run a registration campaign to set up a passkey or Microsoft Authenticator

You can nudge users to set up a passkey or Microsoft Authenticator during sign-in. Users go through their regular sign-in, perform multifactor authentication (MFA) as usual, and are then prompted to set up the targeted authentication method. You can include or exclude users or groups to control who gets nudged and create targeted campaigns to move users from less secure authentication methods to passkeys or Authenticator.

Registration campaigns support two authentication methods:

- **Passkey (FIDO2)**: Nudges users to register a passkey, which includes both synced passkeys and device-bound passkeys.
- **Authenticator**: Nudges users to download and set up Authenticator for push notifications.

A registration campaign can target only one authentication method at a time. You can't run campaigns for both Authenticator and passkeys simultaneously in the same tenant.

You can also define how many days a user can postpone, or "snooze," the nudge. If a user taps **Skip for now** to postpone setup, they get nudged again on the next MFA attempt after the snooze duration elapses. You can decide whether the user can snooze indefinitely or up to three times (after which registration is required).

As users go through their regular sign-in, Microsoft Entra Conditional Access policies that govern security information registration apply before the user is nudged to set up an authentication method. For example, if a Conditional Access policy requires that security information updates can occur only on an internal network. Users aren't prompted unless they're on the internal network.

## Prerequisites

- Optionally, you can determine the number of users who registered each authentication method before you configure the registration campaign. See [Authentication methods activity report](howto-authentication-methods-activity.md#registration-details).
- You must enable multifactor authentication, but there are no license requirements.
- You can choose from two authentication campaigns:
  - **Authenticator campaigns**: Users can't already have Authenticator set up for push notifications on their account. Enable users for Authenticator in the authentication methods policy. **Authentication mode** must be set to **Any** or **Push**. If the mode is set to **Passwordless**, users aren't eligible for the nudge. For more information, see [Enable passwordless sign-in with Authenticator](howto-authentication-passwordless-phone.md).
  - **Passkey campaigns**: The passkey (FIDO2) authentication method must be enabled in the authentication methods policy. In addition, the **Allow self-service setup** toggle must be enabled in the passkey (FIDO2) method configuration. For more information, see [Enable passkeys](how-to-enable-passkey-fido2.md).

## User experience

### Authenticator campaign

When you're targeted for an Authenticator registration campaign, you experience the following flow:

1. You need to complete MFA.

1. If you're enabled for Authenticator push notifications and it isn't set up, you're prompted to set up Authenticator to improve your sign-in experience.

   Other security features, such as passwordless passkey, self-service password reset, or security defaults, might also prompt you for setup.

    :::image type="content" source="./media/how-to-mfa-registration-campaign/user-prompt.png" alt-text="Screenshot that shows the registration campaign prompt asking the user to set up Authenticator.":::

1. Select **Next** and step through Authenticator setup.

1. If you don't want to set up Authenticator, you can select **Skip for now** to snooze the prompt for up to 14 days, which can be set by an admin. Users with free and trial subscriptions can snooze the prompt up to three times.

    :::image type="content" source="./media/how-to-mfa-registration-campaign/snooze.png" alt-text="Screenshot that shows the Skip for now option to snooze the registration campaign prompt.":::

### Passkey campaign

When you're targeted for a passkey registration campaign, you experience the following flow:

1. You need to complete MFA.

1. If passkey registration is enabled for your account and a passkey isn't registered, you're prompted to set up a passkey.

   > [!NOTE]
   > The passkey nudge evaluation determines whether you have a local passkey for your current device and browser combination. If you already have a local passkey for that experience, you aren't nudged. The nudge evaluation is based on each device-and-browser combination that you use, rather than for your user account. For more information about which passkey types satisfy the nudge on each platform, see the [Passkey nudge evaluation by platform](#passkey-nudge-evaluation-by-platform) section.

1. If you don't want to set up a passkey, select **Skip for now** to snooze the prompt.

1. If you encounter an error during passkey registration, you see an error screen with a skip option. Skips from the error screen don't count toward your limited skip count, so registration errors don't block your sign-in.

## Enable the registration campaign policy by using the Microsoft Entra admin center

To enable a registration campaign in the Microsoft Entra admin center, follow these steps:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Authentication Policy Administrator](~/identity/role-based-access-control/permissions-reference.md#authentication-policy-administrator).
1. Browse to **Entra ID** > **Authentication methods** > **Registration campaign**, and select **Edit**.
1. For **State**:

   - Select **Enabled** to enable the registration campaign for all users. When the state is set to **Enabled**, you can configure the target authentication method, snooze duration, limited number of snoozes, and include/exclude targets.
   - Select **Microsoft managed** to enable the registration campaign with Microsoft-recommended defaults. When **Microsoft managed** is selected, the target authentication method, snooze duration, and limited number of snoozes are set automatically and can't be configured. You can still configure include/exclude targets. For more information, see [Protecting authentication methods in Microsoft Entra ID](concept-authentication-default-enablement.md).

    > [!NOTE]
    > When the state is set to **Microsoft managed**, Microsoft determines the optimal campaign settings based on best practices for your tenant. The following changes are incrementally rolled out to tenants:
    >
    >   - **Targeted authentication method** changes from Authenticator to passkeys (FIDO2).
    >  - **Days allowed to snooze** changes to one day. This setting is no longer configurable.
    >   - **Limited number of snoozes** changes to **Disabled** (unlimited snoozes). This setting is no longer configurable.
    >   - **User targeting** changes from voice call or text message users to all MFA capable users.
    >
    >   If your tenant targets specific AAGUIDs in the passkey (FIDO2) policy, the targeted authentication method doesn't update to passkeys under Microsoft managed mode. You can still switch to **Enabled** and configure passkey targeting manually. After the changes take effect, targeted users receive passkey registration nudges during sign-in after they finish MFA.
    >
    >   If you want passkeys enabled but don't want the registration campaign to target passkeys, you can switch the state to **Enabled** and target Authenticator. You can also set the state to **Disabled**. For more information about how Microsoft managed values are set, see [Microsoft managed values](concept-authentication-default-enablement.md).
        
   If the registration campaign state is set to **Enabled**, you can configure the experience for users by using **Limited number of snoozes**:
   - If **Limited number of snoozes** is set to **Enabled**, users can skip the interrupt prompt three times, after which they're forced to register the targeted authentication method.
   - If **Limited number of snoozes** is set to **Disabled**, users can snooze an unlimited number of times and avoid registration.

   > [!NOTE]
   > When **Limited number of snoozes** is set to **Enabled**, the snooze count is tracked per user and persists across campaign restarts or configuration changes (including targeted method updates). This setting ensures a consistent and predictable registration experience.

   **Days allowed to snooze** sets the period between two successive interrupt prompts. For example, if the period is set to three days, users who skipped registration don't get prompted again until after three days.

1. For **Authentication method**, select the method to target:

   - **Microsoft Authenticator**: Nudges users to set up Authenticator.
   - **Passkey**: Nudges users to register a passkey (includes both synced passkeys and device-bound passkeys).

1. Select any users or groups to exclude from the registration campaign, and then select **Save**.

   :::image type="content" source="./media/how-to-mfa-registration-campaign/enabled-passkey-campaign.png" alt-text="Screenshot that shows the Registration campaign page in the Microsoft Entra admin center showing an enabled passkey campaign with authentication method, snooze settings, and include/exclude targets." lightbox="./media/how-to-mfa-registration-campaign/enabled-passkey-campaign.png" border="true":::

## Enable the registration campaign policy by using Graph Explorer

In addition to using the Microsoft Entra admin center, you can enable the registration campaign policy by using Graph Explorer. You must use the authentication methods policy Graph APIs. Users who are assigned at least the [Authentication Policy Administrator](../role-based-access-control/permissions-reference.md#authentication-policy-administrator) role can update the policy.

To configure the policy by using Graph Explorer:

1. Sign in to Graph Explorer and ensure that you consented to the **Policy.Read.All** and **Policy.ReadWrite.AuthenticationMethod** permissions to open the permissions pane.

   ![Screenshot that shows Graph Explorer showing the permissions pane with Policy.Read.All and Policy.ReadWrite.AuthenticationMethod consented.](./media/how-to-nudge-authenticator-app/permissions.png)

1. Retrieve the authentication methods policy:

   ```json
   GET https://graph.microsoft.com/v1.0/policies/authenticationmethodspolicy
   ```

1. Update the `registrationEnforcement` and `authenticationMethodsRegistrationCampaign` section of the policy to enable the nudge on a user or group.

   ![Screenshot that shows the Graph Explorer API response showing the registrationEnforcement section of the authentication methods policy.](media/how-to-mfa-registration-campaign/response.png)

   To update the policy, perform a `PATCH` on the authentication methods policy with only the updated `registrationEnforcement` section:

   ```json
   PATCH https://graph.microsoft.com/v1.0/policies/authenticationmethodspolicy
   ```

The following table lists `authenticationMethodsRegistrationCampaign` properties.

|Name|Possible values|Description|
|------|-----------------|-------------|
|`snoozeDurationInDays`|Range: 0 to 14|Defines the number of days before the user is nudged again.<br>If the value is `0`, the user is nudged during every MFA attempt.<br>Default: One day|
|`enforceRegistrationAfterAllowedSnoozes`|`true`<br>`false`|Dictates whether a user is required to perform setup after three snoozes.<br>If `true`, the user is required to register.<br>If `false`, the user can snooze indefinitely.<br>Default: `true`|
|`state`|`enabled`<br>`disabled`<br>`default`|Allows you to enable or disable the feature.<br>Default value is used when the configuration isn't explicitly set and uses the Microsoft Entra ID default value for this setting.<br>Change state to `enabled` (for all users) or `disabled` as needed.|
|`excludeTargets`|Doesn't apply|Allows you to exclude different users and groups that you want omitted from the feature. If a user is in an excluded group and an included group, the user is excluded from the feature.|
|`includeTargets`|Doesn't apply|Allows you to include different users and groups that you want the feature to target.|

The following table lists `includeTargets` properties.

| Name | Possible values | Description |
|------|-----------------|-------------|
| `targetType`| `user`<br>`group` | The kind of entity targeted. |
| `ID` | A globally unique identifier (GUID) | The ID of the user or group targeted. |
| `targetedAuthenticationMethod` | `microsoftAuthenticator`<br>`fido2` | The authentication method that the user is nudged to register. Use `microsoftAuthenticator` to nudge users to set up Authenticator, or use `fido2` to nudge users to register a passkey. |

The following table lists `excludeTargets` properties.

| Name       | Possible values   | Description                           |
|------------|-------------------|---------------------------------------|
| `targetType` | `user`<br>`group` | The kind of entity targeted.          |
| `ID`         | A string          | The ID of the user or group targeted. |

### Examples

You can use the following sample JSON bodies to get started:

- Include all users and target Authenticator.
  
  If you want to include all users in your tenant and nudge them to set up Authenticator, update the following JSON example with the relevant globally unique identifiers (GUIDs) of your users and groups. Then paste it in Graph Explorer and run `PATCH` on the endpoint.

  ```json
  {
  "registrationEnforcement": {
          "authenticationMethodsRegistrationCampaign": {
              "snoozeDurationInDays": 1,
              "enforceRegistrationAfterAllowedSnoozes": true,
              "state": "enabled",
              "excludeTargets": [],
              "includeTargets": [
                  {
                      "id": "all_users",
                      "targetType": "group",
                      "targetedAuthenticationMethod": "microsoftAuthenticator"
                  }
              ]
          }
      }
  }
  ```

- Include all users and target passkeys.
  
  If you want to include all users in your tenant and nudge them to register a passkey, update the following JSON example. Then paste it in Graph Explorer and run `PATCH` on the endpoint.

  ```json
  {
  "registrationEnforcement": {
          "authenticationMethodsRegistrationCampaign": {
              "snoozeDurationInDays": 1,
              "enforceRegistrationAfterAllowedSnoozes": true,
              "state": "enabled",
              "excludeTargets": [],
              "includeTargets": [
                  {
                      "id": "all_users",
                      "targetType": "group",
                      "targetedAuthenticationMethod": "fido2"
                  }
              ]
          }
      }
  }
  ```

- Include specific users or groups of users.

  If you want to include certain users or groups in your tenant, update the following JSON example with the relevant GUIDs of your users and groups. Then paste the JSON in Graph Explorer and run `PATCH` on the endpoint.

  ```json
  {
  "registrationEnforcement": {
        "authenticationMethodsRegistrationCampaign": {
            "snoozeDurationInDays": 1,
            "enforceRegistrationAfterAllowedSnoozes": true,
            "state": "enabled",
            "excludeTargets": [],
            "includeTargets": [
                {
                    "id": "*********PLEASE ENTER GUID***********",
                    "targetType": "group",
                    "targetedAuthenticationMethod": "microsoftAuthenticator"
                },
                {
                    "id": "*********PLEASE ENTER GUID***********",
                    "targetType": "user",
                    "targetedAuthenticationMethod": "microsoftAuthenticator"
                }
            ]
        }
    }
  }  
  ```

- Include and exclude specific users or groups.

  If you want to include and exclude certain users or groups in your tenant, update the following JSON example with the relevant GUIDs of your users and groups. Then paste it in Graph Explorer and run `PATCH` on the endpoint.

  ```json
  {
  "registrationEnforcement": {
          "authenticationMethodsRegistrationCampaign": {
              "snoozeDurationInDays": 1,
              "enforceRegistrationAfterAllowedSnoozes": true,
              "state": "enabled",
              "excludeTargets": [
                  {
                      "id": "*********PLEASE ENTER GUID***********",
                      "targetType": "group"
                  },
                {
                      "id": "*********PLEASE ENTER GUID***********",
                      "targetType": "user"
                  }
              ],
              "includeTargets": [
                  {
                      "id": "*********PLEASE ENTER GUID***********",
                      "targetType": "group",
                      "targetedAuthenticationMethod": "microsoftAuthenticator"
                  },
                  {
                      "id": "*********PLEASE ENTER GUID***********",
                      "targetType": "user",
                      "targetedAuthenticationMethod": "microsoftAuthenticator"
                  }
              ]
          }
      }
  }
  ```

### Identify user GUIDs for the JSON request body

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Authentication Policy Administrator](~/identity/role-based-access-control/permissions-reference.md#authentication-policy-administrator).
1. In the **Manage** pane, select **Users**.
1. On the **Users** page, identify the specific user that you want to target.
1. When you select the specific user, you see their object ID, which is the user's GUID.

   ![Screenshot that shows the user properties page showing the Object ID field.](./media/how-to-nudge-authenticator-app/object-id.png)

### Identify group GUIDs for the JSON request body

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Authentication Policy Administrator](~/identity/role-based-access-control/permissions-reference.md#authentication-policy-administrator).
1. In the **Manage** pane, select **Groups**.
1. On the **Groups** page, identify the specific group that you want to target.
1. Select the group to get the object ID.

   ![Screenshot that shows the group properties page showing the Object ID field.](./media/how-to-nudge-authenticator-app/group.png)

<!-- comment out PS until ready

### PowerShell

1. Install the module.
1. Ensure that you pass the right roles:
   
   ```powershell
   Connect-MgGraph -Scopes "User.Read.All","Group.ReadWrite.All"
   ```

1. Select the beta profile.
1. Call `Update-MgPolicyAuthenticationMethod`.

-->

## Limitations

The passkey nudge is evaluated on a per-user basis under Microsoft managed mode. When a user signs in and is scoped into the registration campaign, their passkey profile is checked for restrictions. Users don't see a nudge when MFA is finished if their passkey profile has any of the following restrictions:

- Synced only
- Device-bound only
- Attestation enforced
- AAGUID restrictions

## Passkey nudge evaluation by platform

The registration campaign evaluates whether a user has a local passkey for their current device and browser combination. The following table describes which platform passkey types suppress the nudge on each OS and browser combination. A user needs at least one matching passkey type for the nudge to be suppressed on that device and browser.

For example, if a user has a Windows Hello for Business credential and signs in on Windows with Chrome, the nudge is suppressed. But if the same user signs in on a Mac with Chrome, they're nudged because that credential doesn't apply to that platform.

| Credential | Windows + Chrome | Windows + Other | Mac + Chrome | Mac + Other | iOS | Android |
|---|---|---|---|---|---|---|
| Windows Hello for Business | ✔️ | ✔️ | — | — | — | — |
| Microsoft Entra passkey on Windows | ✔️ | ✔️ | — | — | — | — |
| Google Password Manager | ✔️ | — | ✔️ | — | — | ✔️ |
| iCloud Keychain (including Managed) | — | — | ✔️ | ✔️ | ✔️ | — |
| Mac Platform single sign-on (SSO) | — | — | ✔️ | ✔️ | — | — |
| Samsung Pass | — | — | — | — | — | ✔️ |
| Any nonplatform provider (such as security keys or authenticator apps) | ✔️ | ✔️ | ✔️ | ✔️ | ✔️ | ✔️ |

> [!NOTE]
> Linux users aren't nudged. FIDO2 passkeys aren't available on Linux.

## Frequently asked questions

#### Can users be nudged within an application?

Yes. Registration campaigns support embedded browser views in certain applications. The campaign doesn't nudge users in out-of-the-box experiences or in browser views embedded in Windows settings.

#### Can users be nudged within an SSO session?

The nudge doesn't trigger if the user is already signed in with SSO.

#### Can users be nudged on a mobile device?

It depends on the registration campaign:

- Microsoft Authenticator registration campaigns aren't supported on mobile devices.
- Passkey registration campaigns are supported on mobile devices, including:

    - Browser-based experiences on mobile devices.
    - Native iOS mobile apps. Native Android mobile app support isn't currently available.

#### How long does the campaign run?

You can enable the campaign for as long as you want. Whenever you want to be finished running the campaign, use the admin center or APIs to disable the campaign.

#### Can each group of users have a different snooze duration?

No. The snooze duration for the prompt is a tenant-wide setting and applies to all groups in scope.

#### Can users be nudged to set up passwordless phone sign-in?

The registration campaign feature supports nudging users to set up MFA by using Authenticator or to register a passkey. Passwordless phone sign-in isn't a targeted method for registration campaigns.

#### Does a user who signs in with a non-Microsoft authenticator app see the nudge?

Yes. If a user is enabled for the registration campaign and the targeted authentication method isn't set up (Authenticator for push notifications or a passkey), the user is nudged.

#### Does a user who has Authenticator set up only for time-based one-time password codes see the nudge?

Yes. If a user is enabled for an Authenticator registration campaign and Authenticator isn't set up for push notifications, the user is nudged to set up push notification with Authenticator.

#### Does a user who already has a passkey see the nudge?

The passkey nudge evaluates whether a user has a local passkey for their current device and browser combination. If the user already has a local passkey for that experience, they aren't nudged. For this reason, a user might be nudged on one device but not another. For platform-specific information, see the [Passkey nudge evaluation by platform](#passkey-nudge-evaluation-by-platform) section.

#### Can I run registration campaigns for both Authenticator and passkeys at the same time?

No. A registration campaign can target only one authentication method at a time. You can target either Authenticator or passkeys, but not both simultaneously in the same tenant.

#### If a user just went through MFA registration, are they nudged in the same sign-in session?

No. To provide a good user experience, users aren't nudged to set up Authenticator in the same session in which they registered other authentication methods.

#### Can I nudge my users to register another authentication method?

Yes. Registration campaigns support nudging users to set up Authenticator or to register a passkey (FIDO2). Select the targeted authentication method when you configure the campaign.

#### Is there a way for me to hide the snooze option and force my users to set up Authenticator?

Set **Limited number of snoozes** to **Enabled** so that users can postpone the app setup for up to three times, after which setup is required.

#### Can I nudge my users if I'm not using Microsoft Entra MFA?

No. The nudge works only for users who are doing MFA by using Microsoft Entra MFA.

#### Are Guest/B2B users in my tenant nudged?

They're nudged if they're included in a registration campaign for Authenticator. They're not nudged if they're included in a registration campaign for passkeys because passkey support for guest users isn't currently available.

#### What if the user closes the browser?

Closing the browser is the same as snoozing. If setup is required for a user after they snoozed three times, the user is nudged when they next sign in.

#### Why don't some users see a nudge when there's a Conditional Access policy for "Register security information"?

A nudge doesn't appear if a user is in scope for a Conditional Access policy that blocks access to the **Register security information** page.

#### Do users see a nudge when a terms-of-use screen appears during sign-in?

A nudge doesn't appear if a [terms of use](~/identity/conditional-access/terms-of-use.md) screen appears during sign-in.

#### Do users see a nudge when Conditional Access custom controls are applicable to the sign-in?

A nudge doesn't appear if a user is redirected during sign-in because of [Conditional Access custom controls](~/identity/conditional-access/controls.md) settings.

## Related content

- [Enable passwordless sign-in with Authenticator](howto-authentication-passwordless-phone.md)
- [Enable passkeys (FIDO2)](how-to-enable-passkey-fido2.md)
- [Protect authentication methods in Microsoft Entra ID](concept-authentication-default-enablement.md)
