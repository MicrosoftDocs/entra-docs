---
title: What happens when Microsoft-provided SMS and voice retire
description: Understand the SMS and voice retirement experience for users and administrators, including sign-in, password reset, NPS, and apps that don't support passkeys.
ms.topic: concept-article
ms.custom: msecd-doc-authoring-1026
ms.date: 11/13/2026
ai-usage: ai-generated
# Customer intent: As an IT administrator, I want to understand retirement behavior so that I can prepare users, authentication policies, and recovery paths before enforcement.
---

# What happens when Microsoft-provided SMS and voice retire

Microsoft-provided SMS and voice authentication retirement starts rolling out on **February 1, 2027**. What a user sees depends on their registered methods, the app they use, and whether your organization has migrated them to a telephony provider.

This article explains the user and admin experiences when retirement reaches your tenant. For preparation steps and the full timeline, see [Passkeys by default and retirement of Microsoft-provided SMS and voice authentication](concept-sms-voice-retirement.md).

> [!IMPORTANT]
> **Review draft, not ready for publication.** This article describes behavior from product specifications approved for this draft. Confirm the SSPR timing, final UI, and items in [Review before publication](#review-before-publication) before publishing.

## At a glance

The key distinction is whether the user has already registered an alternative authentication method **other than SMS or voice and can use it for the current sign-in**. A device-bound passkey on another device doesn't provide an alternative for a session where that passkey isn't available.

| User or scenario | What happens | What to do before retirement |
| --- | --- | --- |
| The user previously registered an authentication method other than SMS or voice and can use it for the current sign-in. | The user signs in with that previously registered method instead of Microsoft-provided SMS or voice. Retirement doesn't require them to register a passkey to continue. | Test the replacement method with the user's devices, apps, and policies. |
| SMS or voice is the user's only registered sign-in method. | **The user is blocked from completing sign-in until they register a passkey.** SMS or voice can only verify their identity for passkey registration; it doesn't let them bypass this requirement. | Register and test a passkey or another supported method before rollout reaches your tenant. |
| The user's only registered alternative to SMS or voice is a device-bound passkey that isn't available for the current sign-in. | The user verifies their identity with SMS or voice, then receives the blocking prompt to register a passkey they can use for this sign-in. | Test access from every device the user needs, not just the device holding their existing passkey. |
| The user has only SMS or voice registered, and their assigned passkey profiles don't allow any passkey they can register on the current device. | The user sees retirement guidance rather than a passkey registration path they can complete. See [Scenario 6](#scenario-6-the-passkey-profile-doesnt-allow-registration-on-the-current-device). | Test that the assigned profiles allow registration on every device the user needs. |
| The user has been migrated to a telephony provider through Microsoft Security Store. | The user can continue using SMS or voice in supported scenarios under your policies. The retirement doesn't require blocking passkey registration for those migrated users. | Configure the provider, migrate affected users, and test the complete experience. |
| The user relies on SMS or voice for self-service password reset (SSPR). | SSPR follows a separate transition from sign-in. A working sign-in method doesn't necessarily provide a working password-reset method. | Review the user's eligible recovery methods separately. |
| The user connects through the Network Policy Server (NPS) extension and RADIUS. | Microsoft-provided SMS and voice no longer complete multifactor authentication (MFA). NPS doesn't support passkeys or prompt users to register one. | Register and test a method supported by the connection, or configure and test a supported customer-managed telephony option. |
| A required custom authentication strength allows SMS or voice but not passkeys (FIDO2). | Registering a passkey doesn't satisfy that strength. Without another available, permitted method, the user remains blocked. | Review the policies that use the strength, allow passkeys (FIDO2), and test access under your security requirements. |
| The browser, device session, app, or protocol doesn't support passkeys. | The user can't complete passkey registration in an unsupported session. Registering a passkey elsewhere doesn't add support to that session. | Register and test a compatible alternative method, use a supported sign-in path, or configure supported customer-managed telephony. |

> [!NOTE]
> The previously registered alternative must be usable under your organization's policies and in the app or protocol the user needs. Being registered isn't enough if the method can't satisfy those requirements.

## When the changes apply

February 1 is the start of a rollout, not a single moment when every tenant changes.

| Audience | Sign-in retirement rollout starts |
| --- | --- |
| Users other than Global Administrators and external users, including internal guest users. | February 1, 2027. |
| Global Administrators and external users. | July 1, 2027. |

This retirement applies only to public cloud and Government Community Cloud (GCC) environments. Other cloud environments aren't in scope. Azure AD B2C and Microsoft Entra External ID tenant timelines are outside the scope of this article. See the [retirement FAQ](concept-sms-voice-retirement-faq.yml).

Microsoft can't provide the specific date when retirement behavior will reach each tenant. Prepare your organization before February 1, 2027, rather than waiting for a tenant-specific date. The separate rollout for Global Administrators and external users starts July 1, 2027.

The temporary opt-out applies to the **[passkeys-by-default rollout that began September 1, 2026](concept-sms-voice-retirement.md)**, including automatic passkey enablement and the Microsoft-managed registration campaign. It doesn't exempt your tenant from Microsoft-provided SMS and voice retirement. Retirement enforcement still applies when the applicable rollout reaches your tenant.

## What users see during sign-in

Except for Scenario 3, the following scenarios describe users who haven't been migrated to a telephony provider. The blocking registration experience applies when SMS or voice is the user's only registered sign-in method. It also applies when their only registered alternative is a device-bound passkey that isn't available for the current sign-in. Having a phone number registered doesn't, by itself, trigger the blocking prompt.

<a name='scenario-1-the-user-already-has-another-method'></a>
<a name='scenario-1-the-user-previously-registered-an-authentication-method-other-than-sms-or-voice'></a>

### Scenario 1: The user can use a previously registered method other than SMS or voice

This scenario applies when the user has already registered an alternative authentication method **other than SMS or voice and can use it for this sign-in**. Registering both SMS and voice doesn't meet this condition. Neither does a device-bound passkey that isn't available in the current session; see [Scenario 5](#scenario-5-the-users-only-alternative-is-a-device-bound-passkey-on-another-device).

When retirement reaches the tenant, Microsoft-provided SMS and voice are no longer available for normal sign-in. The user completes sign-in with their previously registered alternative, provided it is supported for that sign-in and allowed by policy.

For example, a user who has already registered and tested an authenticator verification code can use that method where supported. The user doesn't have to register a passkey as a condition of continuing this sign-in.

The following five screens show an example from left to right. The user enters their email address and password, then receives a prompt to enter a code from Microsoft Authenticator. If they select **Other ways to sign in**, they initially see **Use a verification code** and a **Show more options** link. Only after selecting **Show more options** do they see the retired SMS and voice options. Both are disabled and display **This option is no longer supported. Contact your help desk for support.** The user can still use their previously registered authenticator verification code to finish signing in.

Select the image to enlarge the five-screen sequence.

:::image type="complex" source="media/concept-sms-voice-retirement-experience/scenario-1-authenticator-code-flow.png" alt-text="Screenshot of five sign-in screens showing an authenticator code prompt and retired SMS and voice options under Show more options." lightbox="media/concept-sms-voice-retirement-experience/scenario-1-authenticator-code-flow.png" border="true":::
The screens run from left to right: email address, password, Microsoft Authenticator code prompt, other sign-in methods, and expanded options. The code prompt includes Other ways to sign in. The next screen shows Use a verification code and Show more options. Expanding the options reveals disabled Text and Call entries, each stating that the option is no longer supported and to contact the help desk for support. Use a verification code remains available.
:::image-end:::

### Scenario 2: SMS or voice is the user's only method

**The user is blocked from completing sign-in until they register a passkey.** The flow works as follows:

1. The user starts signing in.
1. The user uses SMS or voice to verify their identity. This verification is the proof-up step for registration, not continued access to SMS or voice for normal sign-in.
1. The user receives a blocking prompt to register a passkey.
1. The user completes passkey registration on a supported device and browser.
1. The user continues signing in and uses the passkey for future supported sign-ins.

The **Telephony Retirement Profile** initially allows all passkey types supported by the user's device and browser. Administrators can edit this profile or change the user's profile assignments after retirement. **Registration always respects the user's assigned passkey profiles**, including in the blocking retirement prompt. For example, a user scoped only to a device-bound-only profile can register only a device-bound passkey. For details about the admin experience and policy configuration, see [Passkey settings and the retirement profile](#passkey-settings-and-the-retirement-profile).

The blocking prompt doesn't offer registration of a different authentication method. The user can't skip it and continue to the app.

Closing the page or restarting sign-in doesn't remove the block. The user can verify their identity again using SMS or voice, but **sign-in remains blocked until they complete passkey registration**.

The following screens show an SMS-only example. The user enters their username and password, selects **Send code**, and enters the code sent to their phone. This verifies their identity for passkey registration; it doesn't let them continue to the app with SMS. The **Text messages are no longer supported** screen prompts them to select **Create a passkey**. The selected setup screens show **Let's name your passkey** and the **Passkey created** confirmation with a **Done** button.

The eight screens are labeled **1-8**, from left to right. Screen **5** is the SMS retirement prompt. Between screens **5** and **6**, the user registers the passkey; screen **6** shows **Let's name your passkey**. Screens **7** and **8** both show the registration-complete confirmation. Select the image to enlarge the sequence.

:::image type="complex" source="media/concept-sms-voice-retirement-experience/scenario-2-sms-only-passkey-flow.png" alt-text="Screenshot of eight screens showing SMS identity verification, the retirement prompt, passkey naming, and registration confirmation." lightbox="media/concept-sms-voice-retirement-experience/scenario-2-sms-only-passkey-flow.png" border="true":::
From left to right, screen 1 shows username entry, 2 shows password entry, 3 offers Send code, and 4 accepts the SMS verification code. Screen 5 states Text messages are no longer supported and offers Create a passkey. A Register the passkey callout between screens 5 and 6 represents the setup screens not shown. Screen 6 shows Let's name your passkey with a name field and Next button. Screens 7 and 8 each show Passkey created with a Done button. SMS verifies the user's identity for registration, but sign-in remains blocked until passkey registration is complete.
:::image-end:::

> [!IMPORTANT]
> Don't wait for this prompt if your organization plans to use a different authentication method. Complete that migration before the applicable retirement rollout begins.

This verification step isn't a general exception for password reset, NPS/RADIUS, or apps that can't display the passkey registration experience.

### Scenario 3: The user has been migrated to a telephony provider

If your organization needs to retain SMS or voice, configure a supported telephony provider through Microsoft Security Store and migrate the users who need those methods.

Users migrated before their retirement date can continue using SMS or voice in supported scenarios under your policies. They don't receive the blocking retirement prompt solely because they use that provider.

Configuring a provider without completing user migration isn't sufficient. Test delivery and sign-in for the intended users before rollout.

For setup guidance, see [Choose a telephony provider for SMS and voice authentication](concept-phone-providers.md).

For users migrated to your telephony provider (CYOT), the usual SMS verification flow is unchanged. The following screens show the user entering their username and password, selecting **Text** on **Verify your identity**, and entering the text message code to complete sign-in. **Call** remains available as another verification option. This flow doesn't require the user to register a passkey because of retirement.

Select the image to enlarge the four-screen sequence.

:::image type="complex" source="media/concept-sms-voice-retirement-experience/scenario-3-telephony-provider-sms-verification-flow.png" alt-text="Screenshot of four screens showing the unchanged SMS verification flow for a user migrated to a telephony provider." lightbox="media/concept-sms-voice-retirement-experience/scenario-3-telephony-provider-sms-verification-flow.png" border="true":::
From left to right, the user enters their username and password. Verify your identity offers Text and Call. The user selects Text, enters the code sent to their phone, and selects Sign in. The code entry screen also offers a call with a code. For a user migrated to a telephony provider, SMS remains available for sign-in without the blocking retirement passkey-registration prompt.
:::image-end:::

### Scenario 4: The user can't register or use a passkey

Some browser and device sessions don't support passkeys. Microsoft Entra ID detects when the current session doesn't support passkey registration. For users whose only registered MFA methods are SMS or voice, the **Verify your identity** screen shows disabled **Text** and **Call** options. Both display **This option is no longer supported. Try adding a passkey on another device at aka.ms/addpasskey or contact your help desk for support.**

**SMS and voice remain supported for accessing [My Sign-Ins](https://aka.ms/mysignins) to register another authentication method.** Users can verify their identity with their existing SMS or voice registration even when they can't complete passkey registration. This registration path prevents users from being locked out of method registration; it doesn't restore SMS or voice for normal application sign-in.

The guidance screen doesn't let the user skip registration and continue signing in to the application. The user needs a registered alternative that works in the affected session and meets the organization's policies, or a supported customer-managed telephony option.

The following screens show the user entering their username and password, then receiving this retirement guidance. The screen points to [aka.ms/addpasskey](https://aka.ms/addpasskey) for passkey setup on another device. The separate [My Sign-Ins](https://aka.ms/mysignins) recovery path described in this scenario lets users register another authentication method.

Select the image to enlarge the three-screen sequence.

:::image type="complex" source="media/concept-sms-voice-retirement-experience/scenario-4-retirement-guidance-flow.png" alt-text="Screenshot of three sign-in screens with disabled SMS and voice options and guidance to add a passkey on another device." lightbox="media/concept-sms-voice-retirement-experience/scenario-4-retirement-guidance-flow.png" border="true":::
From left to right, the user enters their username and password, then sees Verify your identity. Text and Call are disabled. Each option states that it is no longer supported and advises adding a passkey on another device at aka.ms/addpasskey or contacting the help desk for support. This screen doesn't offer a way to continue to the application with SMS or voice.
:::image-end:::

Registering a passkey on another browser or device doesn't make the original session support passkeys. A user might be able to use a passkey in one environment but still need another method in a different environment.

Before retirement, review every browser and device combination affected users need, using the [passkey compatibility matrix](concept-fido2-compatibility.md). Register and test an alternative supported by those sessions, such as:

- Microsoft Authenticator push notifications.
- [Passwordless phone sign-in with Microsoft Authenticator](howto-authentication-passwordless-phone.md).
- Time-based one-time passwords (TOTP), such as verification codes from Microsoft Authenticator.

The method must be supported in the affected session, enabled for the user, and allowed by applicable Conditional Access policies and authentication strengths. Installing Microsoft Authenticator alone isn't enough; the user needs to complete the relevant registration and setup.

If SMS or voice is still required, configure a supported [customer-managed telephony provider](concept-phone-providers.md) and complete migration for the affected users. Before retirement, test the same browser and device combinations the users need. Customer-managed telephony provides a separate SMS or voice path; it doesn't add passkey support.

If a user reaches this screen, direct them to [My Sign-Ins](https://aka.ms/mysignins) and have them use their existing SMS or voice registration to verify their identity and register another method. If they can't complete registration or still can't sign in, contact your support team. Don't tell them to skip registration or assume another SMS code allows them to continue to the application. Confirm the replacement method works with their actual session and access policies, not just their primary browser.

<!-- TODO: Confirm error-specific retry behavior and helpdesk actions if the user can't register another method through My Sign-Ins. -->

### Scenario 5: The user's only alternative is a device-bound passkey on another device

The user has SMS or voice registered, but their only other registered authentication method is a device-bound passkey. If that passkey isn't available for the current sign-in, its registration alone doesn't prevent the blocking passkey prompt.

For example, a user has Windows Hello for Business on their Windows device and SMS registered. After retirement reaches the tenant, they sign in on an iPhone where that Windows Hello for Business credential isn't available. They have no other registered method they can use for that sign-in.

The user uses SMS or voice to verify their identity, then receives the **blocking prompt to register a passkey** they can use for this sign-in. They need to complete passkey registration before continuing. SMS or voice supports this identity verification step; it doesn't restore normal SMS or voice sign-in.

This differs from an unsupported registration session: the iPhone example has a passkey registration path allowed by the user's assigned profiles, but the user's existing device-bound credential isn't available there. If the current session doesn't support passkey registration, the user instead sees the retirement guidance described in [Scenario 4](#scenario-4-the-user-cant-register-or-use-a-passkey). If the assigned profiles don't allow any passkey the user can register on that device, see [Scenario 6](#scenario-6-the-passkey-profile-doesnt-allow-registration-on-the-current-device).

The following selected screens show the user entering their username and password, choosing **Text**, and entering the SMS code to verify their identity. The **Text messages are no longer supported** screen then prompts them to select **Create a passkey**. The selected setup screens show **Let's name your passkey** followed by **Passkey created** and a **Done** button. SMS supports the identity verification step, not continued sign-in to the app.

The seven screens are labeled **1-7**, from left to right. Screen **5** is the SMS retirement prompt. Between screens **5** and **6**, the user registers the passkey; screen **6** shows **Let's name your passkey**. Screen **7** shows the registration-complete confirmation. Select the image to enlarge the sequence.

:::image type="complex" source="media/concept-sms-voice-retirement-experience/scenario-5-sms-passkey-registration-flow.png" alt-text="Screenshot of seven screens showing SMS verification and required passkey registration when the existing passkey isn't available." lightbox="media/concept-sms-voice-retirement-experience/scenario-5-sms-passkey-registration-flow.png" border="true":::
Screen 1 shows username entry and 2 shows password entry. Screen 3 offers Text and Call; 4 accepts the SMS code for identity verification. Screen 5 states Text messages are no longer supported and offers Create a passkey. A Register the passkey callout between screens 5 and 6 represents the setup screens not shown. Screen 6 shows Let's name your passkey with a name field and Next button. Screen 7 confirms Passkey created with a Done button. The user needs to complete passkey registration before continuing sign-in.
:::image-end:::

## Custom authentication strengths can prevent passkey sign-in

A passkey registration doesn't override Conditional Access. If a policy requires a custom authentication strength that allows SMS or voice but excludes passkeys (FIDO2), registering a passkey doesn't satisfy that policy. Users without another available method that meets the strength remain blocked and need administrator assistance.

| Required custom authentication strength | Effect on passkey sign-in |
| --- | --- |
| Allows passkeys (FIDO2). | A passkey is permitted by the strength, subject to all other applicable policies and requirements. |
| Doesn't allow passkeys (FIDO2). | A passkey doesn't satisfy the strength, even after successful registration. The user needs another available, permitted method or an administrator to update the policy. |

Before retirement, review custom authentication strengths that allow SMS or voice but don't allow passkeys (FIDO2). Identify the Conditional Access policies that require each strength and the users and resources they cover. Finding an affected strength doesn't mean every user in the organization is affected.

In the Microsoft Entra admin center, affected strengths are under **Entra ID** > **Authentication methods** > **Authentication strengths**. Add passkeys (FIDO2) as an allowed method and save the changes, after reviewing your security and compliance requirements. For configuration guidance, see [Overview of Conditional Access authentication strengths](concept-authentication-strengths.md).

Test with representative users under the affected policies. Verify both passkey registration and access to protected resources. Tell affected users and your helpdesk what to do if registration succeeds but sign-in remains blocked.

## What changes in My Sign-Ins

When sign-in retirement reaches the tenant, the product specification describes these changes for Microsoft-provided SMS and voice registrations:

- Existing SMS and voice registrations appear disabled or greyed out.
- Users can't edit or replace the phone number for those registrations.
- Users can't add SMS or voice as a new authentication method.
- SMS and voice are removed or disabled in **Add sign-in method**.

These restrictions prevent adding or editing phone registrations. They don't prevent users from using an existing SMS or voice registration to access [My Sign-Ins](https://aka.ms/mysignins) and register another method when passkey registration isn't supported. See [Scenario 4: The user can't register or use a passkey](#scenario-4-the-user-cant-register-or-use-a-passkey).

An existing phone registration can still be usable for SSPR during the separate grace period described in [What happens to SSPR](#what-happens-to-sspr). Don't interpret a disabled registration in [My Sign-Ins](https://aka.ms/mysignins) as proof that the SSPR grace period has ended.

## What administrators see

The admin experience protects the identity verification and passkey registration path while your organization completes migration. An enabled SMS or voice setting after retirement doesn't mean the method remains available for normal Microsoft-provided sign-in.

### SMS and voice policy settings

When retirement reaches a tenant without a configured telephony provider:

- SMS and voice stay enabled where they were already enabled, to support identity verification and the blocking passkey registration flow.
- The **Enable and Target** group-targeting controls become read-only. You can't add or remove included or excluded groups while this lock applies.
- You can turn a method on or off.
- A retirement banner explains the restrictions and links to migration guidance.

> [!WARNING]
> Before turning SMS or voice off, make sure affected users have a working replacement method. Also check password-reset coverage. Turning off a method isn't a substitute for migrating its users.

:::image type="complex" source="media/concept-sms-voice-retirement-experience/sms-settings-read-only-targeting.png" alt-text="Screenshot of SMS settings with a retirement banner, an available Enable switch, and read-only group-targeting controls." lightbox="media/concept-sms-voice-retirement-experience/sms-settings-read-only-targeting.png" border="true":::
The SMS settings page displays a banner stating that Microsoft-provided SMS and voice authentication is retiring. The banner says administrators can turn the method on or off, but targeting is read-only and no groups can be added. It links to retirement guidance, passkey registration, and customer-owned telecom setup. The Enable switch is on and available. A lock message states that groups can't be added or removed. The Add group control and existing group settings are disabled.
:::image-end:::

*Targeting is read-only, but an administrator can turn the method off.*

<a name='passkey-settings-and-the-system-managed-profile'></a>

### Passkey settings and the retirement profile

At retirement enforcement, a one-time migration turns on passkeys and creates the **Telephony Retirement Profile** from the groups targeted by SMS and voice. This enables users who relied only on those methods to register a passkey at their next sign-in.

The profile:

- Includes the groups targeted by SMS or voice and initially allows all passkey types.
- Accounts for source exclusions without removing intentional, existing passkey targeting.
- Coexists with administrator-created passkey profiles rather than replacing them.
- Can be edited, reassigned, or deleted by an administrator. Passkeys can also be turned off.

The profile name isn't the name of a new Microsoft Entra group. It represents policy targeting, not a list of every affected individual user.

Targeting is captured once when retirement reaches the tenant; the migration doesn't update it again. Turning SMS and voice off or configuring a provider doesn't automatically delete the profile or recalculate that targeting.

**The user's assigned passkey profiles are the source of truth for what they can register.** Changing those assignments doesn't remove the blocking retirement prompt for a user whose only registered methods are SMS or voice. The prompt still requires passkey registration, but registration follows the profiles currently assigned to that user, not necessarily the original **Telephony Retirement Profile**.

Passkeys provide a modern, phishing-resistant authentication method based on the Web Authentication API (WebAuthn) and FIDO2 standards. During web registration, the browser uses [WebAuthn](https://developer.mozilla.org/en-US/docs/Web/API/Web_Authentication_API) to work with the user's device or authenticator to create the passkey. The retirement prompt starts registration; it doesn't replace this browser-and-device process or bypass the user's assigned passkey profiles.

More restrictive profiles can make registration more complicated because they narrow the passkeys users can register. A passkey must meet the requirements of a profile assigned to the user and be supported by the user's device and browser. Test registration with the intended profiles, devices, and browsers before changing assignments for affected users.

> [!WARNING]
> Administrators can edit these settings at their own risk. Turning off passkeys or deleting the **Telephony Retirement Profile** can lock some affected users out of their accounts. Before changing the profile or its assignments, verify that those users still have a working sign-in and registration path.

In the following example, **Sales** and **Field operations** were included in the SMS policy shown earlier. The migration enables them for passkeys and assigns both groups to the **Telephony Retirement Profile**. The existing **Chickens** group keeps its separate **device bound** profile.

The retirement profile assignment is additive, even for groups already assigned to another passkey profile. For example, if **Sales** or **Field operations** was assigned to the **device bound** profile before retirement, the migration also adds that group to the **Telephony Retirement Profile**. The group remains scoped to both profiles after retirement; the existing assignment isn't replaced.

:::image type="complex" source="media/concept-sms-voice-retirement-experience/passkey-retirement-profile-group-targeting-preview.png" alt-text="Screenshot of enabled passkeys, editable controls, and Sales and Field operations assigned to the Telephony Retirement Profile." lightbox="media/concept-sms-voice-retirement-experience/passkey-retirement-profile-group-targeting.png" border="true":::
The Passkey (FIDO2) settings page shows Enable set to On. Under Include, Sales and Field operations are assigned to Telephony Retirement Profile. Chickens retains the device bound profile. Add target, profile selectors, delete controls, and Save are available. The retirement banner explains the one-time migration, says administrators can edit, reassign, or delete the profile or turn passkeys off, and warns that turning passkeys off or deleting the profile can lock some users out.
:::image-end:::

*The retirement profile keeps the previously SMS-targeted Sales and Field operations groups eligible for passkey registration.*

The **Configure** tab shows the migration-created profile alongside existing profiles. Its settings and delete control are available to administrators.

:::image type="complex" source="media/concept-sms-voice-retirement-experience/passkey-retirement-profile-configuration-preview.png" alt-text="Screenshot of the editable Telephony Retirement Profile and a lockout warning if passkeys are disabled or the profile is deleted." lightbox="media/concept-sms-voice-retirement-experience/passkey-retirement-profile-configuration.png" border="true":::
The Configure tab lists Default passkey profile, Telephony Retirement Profile, and device bound. A description identifies Telephony Retirement Profile as created by a one-time migration from the groups targeted by SMS and voice. It allows Device-bound and Synced passkeys, with Enforce attestation and Key restrictions both set to No. Its settings and delete control are available. The retirement banner repeats the warning that turning off passkeys or deleting the profile can lock some users out of their accounts.
:::image-end:::

*Administrators can edit or delete the retirement profile, but doing so can put affected users at risk of account lockout.*

#### Scenario 6: The passkey profile doesn't allow registration on the current device

After retirement, an administrator changes a user's passkey profile assignments. For example, the user is scoped only to a profile whose AAGUID allowlist permits a Microsoft Entra passkey on Windows that can't be registered on an iPhone. The administrator removes the user's assignment to the broader **Telephony Retirement Profile**, so that profile no longer allows other passkey types for this user.

The user has only SMS registered and then signs in on an iPhone. Although the iPhone supports other passkeys, the assigned profile doesn't allow a passkey the user can register there. **The retirement flow respects the profile's restrictions; it doesn't let the user register a different, disallowed passkey.**

The user sees the same retirement-guidance sequence as in [Scenario 4](#scenario-4-the-user-cant-register-or-use-a-passkey): username entry, password entry, and **Verify your identity** with disabled **Text** and **Call** options. The guidance points to passkey setup on another device or the help desk. SMS doesn't let the user bypass the restriction and continue to the app.

Select the image to enlarge the same three-screen sequence used in Scenario 4.

:::image type="complex" source="media/concept-sms-voice-retirement-experience/scenario-4-retirement-guidance-flow.png" alt-text="Screenshot of disabled SMS and voice sign-in options with guidance to add a passkey on another device or contact the help desk." lightbox="media/concept-sms-voice-retirement-experience/scenario-4-retirement-guidance-flow.png" border="true":::
From left to right, the user enters their username and password, then sees Verify your identity. Text and Call are disabled. Each option advises adding a passkey on another device at aka.ms/addpasskey or contacting the help desk. This is the same guidance shown in Scenario 4, used here when the assigned passkey profile doesn't allow registration on the current device.
:::image-end:::

Unlike Scenario 5, this user has no permitted passkey registration path on the iPhone. Review the assigned profiles and test a registration and sign-in path that meets your requirements on the user's actual devices. For alternative-method recovery guidance, see [Scenario 4](#scenario-4-the-user-cant-register-or-use-a-passkey).

### When settings become editable again

The following table summarizes the planned admin experience after retirement reaches the tenant. Retirement-locked SMS and voice group targeting remains read-only until you configure a telephony provider (CYOT), even if you turn both methods off. Passkey settings and the retirement profile remain editable.

| Tenant state | SMS and voice settings | Passkey settings |
| --- | --- | --- |
| No provider; SMS or voice is still enabled. | Group targeting is read-only. Method switches remain available to turn methods on or off. | Passkey settings and the retirement profile are editable. Changing them can put users at risk of account lockout. |
| Both SMS and voice are turned off; no provider. | Group targeting remains read-only. Method switches remain available to turn methods on or off. | Passkey settings remain editable. Turning SMS and voice off doesn't automatically delete the retirement profile. |
| A telephony provider is configured. | Method switches and group targeting are editable. Complete user migration and test delivery. | Passkey settings remain editable. Configuring a provider doesn't automatically delete the retirement profile. |

Tenants that don't have SMS or voice enabled when retirement reaches them don't receive these retirement targeting locks or the new retirement profile.

### Registration campaign versus retirement enforcement

The registration campaign [encourages early passkey registration](concept-sms-voice-retirement.md). It is separate from retirement enforcement.

> [!NOTE]
> **Retirement enforcement uses a completely separate nudge from the registration campaign. Registration campaign settings don't control or disable this retirement prompt.** The campaign can show a snoozable reminder even to users who have another registered sign-in method. The separate retirement prompt **blocks sign-in until passkey registration is complete** for SMS/voice-only users. It also applies when the user's only alternative is a device-bound passkey unavailable for the current sign-in. Registration through this prompt still respects the user's assigned passkey profiles.

Changing campaign settings or using the temporary opt-out doesn't remove retirement enforcement.

## What happens to SSPR

Sign-in and self-service password reset are separate. A user can retain sign-in access and still lose the ability to reset a forgotten password.

**Registering a passkey during sign-in doesn't automatically make the user eligible for SSPR.** Review recovery methods and policy independently.

### SSPR has a separate grace period

The approved source specification describes a **tenant-specific 50-day SSPR grace period**:

| Stage | Sign-in | SSPR |
| --- | --- | --- |
| Before the applicable sign-in rollout reaches the tenant. | Existing behavior applies. | Existing effective recovery policy applies. |
| Sign-in retirement reaches the tenant. | Normal Microsoft-provided SMS and voice sign-in ends. Users in the blocking scenarios described above verify their identity, then register a passkey before continuing sign-in. | The applicable 50-day grace period starts. Existing SMS and voice recovery continues under effective policy. |
| The applicable SSPR grace period ends after 50 days. | Sign-in retirement remains in effect. | Microsoft-provided SMS and voice no longer count as recovery methods. Users need sufficient eligible alternatives or a supported provider-backed recovery path. |

Global Administrators and external users have a separate grace period tied to the rollout beginning July 1, 2027. Their SSPR timer doesn't start with the regular-user rollout.

Don't calculate one universal SSPR cutoff from February 1. The start depends on when the applicable rollout reaches the tenant.

### Registration and refresh prompts change before the grace period ends

When sign-in retirement reaches the tenant:

- SSPR no longer interrupts sign-in to ask users to register or update SMS or voice.
- SMS and voice aren't considered when deciding whether to show an SSPR registration interrupt.
- SMS and voice refresh prompts stop.
- Registration and refresh prompts continue for other eligible methods.
- If SMS or voice is the only method the user could register, that SSPR registration interrupt isn't shown.

These changes start with sign-in retirement, not at the end of the 50-day grace period. Prepare alternative recovery registrations proactively rather than waiting for a phone-registration prompt.

### What users see when the grace period ends

At <https://aka.ms/sspr>, Microsoft-provided SMS and voice are removed from the available recovery options.

| Remaining recovery coverage | User experience |
| --- | --- |
| The user has enough eligible methods for your policy. | The user sees the remaining eligible methods and continues the existing reset flow. |
| The user doesn't have enough eligible methods. | The user sees the existing insufficient-registered-methods error and is directed to contact an administrator. |
| The user has a supported provider-backed SMS or voice recovery path. | The separate provider-backed recovery path remains available under its effective configuration. |

For a one-method policy, the user needs at least one eligible method after Microsoft-provided SMS and voice are removed. For a two-method policy, the user needs two eligible methods.

Don't count every registration as an independent recovery method. For example, Microsoft Authenticator and OATH methods don't necessarily count separately toward a two-method requirement. Review the rules in [How Microsoft Entra self-service password reset works](concept-sspr-howitworks.md).

### Password change after secure sign-in is a separate option

The retirement doesn't automatically enable [password change after secure sign-in](concept-sspr-howitworks.md?tabs=secure-sign-in) or rewrite your recovery policies. An administrator must enable this option for users in their tenant.

This feature lets eligible users change their cloud password from **Security info** in [My Sign-Ins](https://aka.ms/mysignins) without entering their current password, after signing in with a supported passwordless method such as a passkey. It's separate from SSPR and doesn't require SSPR registration.

The source specification describes a banner at the SSPR entry point for tenants where this feature is enabled. It doesn't automatically redirect **Forgot my password** to [My Sign-Ins](https://aka.ms/mysignins).

## What happens to NPS and RADIUS

When the applicable retirement rollout reaches your tenant, Microsoft-provided SMS and voice no longer complete MFA for NPS-protected connections. This includes Azure VPN Gateway point-to-site RADIUS connections, Remote Desktop Gateway, and other VPN deployments that use NPS with Microsoft Entra MFA.

**NPS doesn't support passkey authentication or present a passkey-registration prompt.** Registering a passkey elsewhere doesn't restore access to an NPS-protected connection. A user can have working browser sign-in with a passkey and still rely on SMS or voice for their VPN connection.

Users without another available, supported MFA method or a configured customer-managed telephony option can't complete the connection and need administrator assistance.

### Alternative methods depend on the connection

Select a method supported by the client, authentication protocol, and NPS extension configuration. TOTP isn't an alternative for every deployment.

| Connection | Supported alternative guidance |
| --- | --- |
| Azure VPN Gateway point-to-site RADIUS with NPS. | Use a supported method such as Microsoft Authenticator push notifications. The documented integration doesn't support methods that require code entry in the VPN client, including TOTP. See [Azure VPN Gateway RADIUS authentication with NPS for MFA](/azure/vpn-gateway/vpn-gateway-radius-mfa-nsp). |
| Remote Desktop Gateway with NPS. | Use Microsoft Authenticator Approve/Deny push notifications. The gateway doesn't provide a verification-code entry experience, so TOTP isn't supported for this flow. See [Remote Desktop Gateway with the NPS extension](howto-mfa-nps-extension-rdg.md). |
| Other VPN deployments with NPS. | Use Microsoft Authenticator push notifications, or TOTP only where the client and authentication protocol support it. See [NPS extension for VPN authentication](howto-mfa-nps-extension-vpn.md). |

NPS doesn't support Authenticator number matching. For deployments that require Approve/Deny push notifications, review the [NPS configuration guidance](howto-mfa-nps-extension.md#determine-which-authentication-methods-your-users-can-use) so users aren't directed to an unsupported TOTP challenge.

Complete alternative-method registration outside the NPS connection flow. Don't rely on VPN or Remote Desktop sign-in to enroll users. Test each actual connection type with representative users; successful browser sign-in alone doesn't validate NPS access.

### Customer-managed telephony for NPS

If SMS or voice is still required, configure a supported [customer-managed telephony provider](concept-phone-providers.md) for the affected users when available for your tenant. Complete migration and test the NPS-protected connections before retirement reaches your tenant.

Customer-managed telephony doesn't change the methods supported by the client. Validate the provider, deployment, and connection together rather than assuming every telephony option works with every NPS flow.

<!-- TODO: Confirm final NPS failure text with the NPS owners and align existing NPS documentation that lists Microsoft-provided SMS or voice before publication. -->

## Apps and protocols that don't support passkeys

Passkey support is a property of the complete sign-in path, not just your tenant. Check the app, protocol, browser or broker, device, and tenant policy together.

An app can lack passkey support even if the user can sign in to Microsoft Entra ID with a passkey in a supported browser. Likewise, a client that can't display the registration experience can't complete that experience inside its existing flow.

| Situation | Preparation |
| --- | --- |
| A supported passkey sign-in path exists, but the current client doesn't use it. | Update or reconfigure the app or client to use that supported path, then test it. |
| The app or protocol supports another nontelephony method. | Register and test that method before retirement. It must also satisfy your organization's policies. |
| A supported scenario requires SMS or voice. | Configure a supported customer-managed telephony provider, migrate users, and test the actual connection. For NPS-specific restrictions, see [What happens to NPS and RADIUS](#what-happens-to-nps-and-radius). |
| No compatible method or supported sign-in path is available. | Change the access solution before retirement. Otherwise, users who depend on the retired method won't have a working path. |

Registering a passkey on another device can prepare a user for supported passkey sign-ins. It doesn't repair an incompatible protocol or guarantee access to the original app.

Don't weaken Conditional Access or turn off MFA as a retirement workaround. Test a replacement path that meets your security requirements.

<!-- TODO: Confirm any additional app/protocol scenarios and their exact failure behavior. The supplied sources cover unsupported browser/device sessions and NPS, but don't establish a complete protocol list, error text, or automatic redirects. -->

## Prepare your organization

Complete the following before the applicable retirement rollout starts:

1. **Find affected users and applications.** Identify SMS/voice-only users and users whose only alternative is a device-bound passkey unavailable on another device they need. Check whether registered alternatives work in each required sign-in environment. Include NPS/RADIUS and apps that don't support passkeys.
1. **Choose a sign-in path for each scenario.** Prefer passkeys where supported. Where necessary, register another supported method or migrate eligible scenarios to a telephony provider.
1. **Review custom authentication strengths.** Identify policies that allow SMS or voice but exclude passkeys (FIDO2). Update affected strengths and test that replacement methods meet your security requirements.
1. **Check recovery separately.** Identify users who won't meet SSPR requirements after Microsoft-provided phone methods stop counting. Don't assume passkey migration fixes recovery.
1. **Complete registration and testing.** Test the user's actual device, application, policies, and recovery path.
1. **Review admin changes.** Understand which settings lock at enforcement and what happens if you turn SMS or voice off.
1. **Prepare your helpdesk.** Provide instructions for failed passkey setup, unsupported clients, NPS verification problems, and insufficient SSPR methods.
1. **Communicate dates and actions.** Distinguish the February and July populations and each tenant's separate SSPR transition.

Use the [retirement overview](concept-sms-voice-retirement.md) for migration steps and the [authentication methods activity report](howto-authentication-methods-activity.md) to support your readiness review.

<a name='troubleshoot-common-questions'></a>

## Frequently asked questions

The following answers explain common retirement scenarios and the policy changes to consider.

| Question | Explanation and next step |
| --- | --- |
| Why is a user with another method being asked to register a passkey? | Check whether the method is registered, usable, and allowed for that sign-in. If the only alternative is a device-bound passkey unavailable in the current session, the user still receives the blocking retirement prompt. Distinguish that prompt from the snoozable registration campaign. |
| Why are SMS and voice still enabled in the admin center? | Existing settings support identity verification for passkey registration, including when a user restarts after closing the registration page. They don't preserve normal Microsoft-provided SMS and voice sign-in. |
| Why can't I change SMS or voice targeting? | Retirement locks targeting until you configure a telephony provider (CYOT). Turning both methods off doesn't unlock targeting. Review the [admin settings table](#when-settings-become-editable-again). |
| Why does a migrated user still appear in a passkey profile? | Turning SMS and voice off or configuring a provider doesn't automatically delete the Telephony Retirement Profile or update its targeting. Administrators can edit or delete it, but must first verify that affected users retain a working sign-in and registration path. |
| Why can a user sign in but not reset their password? | Sign-in and SSPR eligibility are independent. Check the remaining eligible recovery methods and the policy's method requirement. |
| Why is a user still blocked after registering a passkey? | Check whether a required custom authentication strength excludes passkeys (FIDO2) and whether the original browser or device session supports passkeys. Registration doesn't override policy or add compatibility. |
| Why doesn't a registered passkey fix a VPN connection? | NPS doesn't support passkeys or passkey registration. Register and test a supported alternative outside the NPS flow, or configure and test supported customer-managed telephony. |

### What if I want my users to register only a specific type of passkey?

**Use passkey profiles to control which types users can register. The blocking retirement prompt always respects the user's assigned profiles.** The **Telephony Retirement Profile** initially allows all passkey types, but administrators can edit it or change the user's profile assignments after retirement.

For example, after retirement, you can scope a user only to a device-bound-only profile and remove their assignment to the **Telephony Retirement Profile**. If that user still has only SMS or voice registered and their current device supports registration under that profile, they still receive the blocking retirement prompt, but they can register **only a device-bound passkey**. The prompt doesn't override the assigned profile to allow other types.

Review all passkey profiles assigned to the affected users, including the **Telephony Retirement Profile**. Profile assignments are additive: a profile restricted to your chosen type doesn't override another assigned profile that allows other passkey types. Before removing or changing an assignment, verify that users retain a working sign-in and registration path.

More restrictions can make registration more complicated. Make sure users have a device or authenticator that supports an allowed passkey type and can complete setup in their browser. The retirement prompt doesn't bypass those requirements. If no allowed passkey can be registered on the current device, the user sees the retirement guidance shown in [Scenario 6](#scenario-6-the-passkey-profile-doesnt-allow-registration-on-the-current-device).

If affected users can't complete registration and need immediate sign-in relief, configure a supported [telephony provider (CYOT)](concept-phone-providers.md) and complete their migration. This restores SMS or voice sign-in for those migrated users in supported scenarios.

### What if another registration campaign or Conditional Access prompt applies?

Within the SMS/voice-only retirement flow, **the blocking retirement prompt takes precedence over other prompts**, including a registration campaign for Microsoft Authenticator or a prompt from a Conditional Access policy. Another prompt doesn't replace the retirement passkey registration requirement or let the user skip it.

This precedence is about the prompt shown to the user, not a policy bypass. Passkey registration still respects the user's assigned profiles, and completing registration doesn't override Conditional Access requirements for access to the application. See [Custom authentication strengths can prevent passkey sign-in](#custom-authentication-strengths-can-prevent-passkey-sign-in).

## Review before publication

This section is for the documentation and product reviewers. The following bullets are independent verification items, not sequential procedure steps. Resolve them and remove all review notes before publishing.

- Confirm the 50-day SSPR grace period and timing rules. The three newly supplied sources don't cover SSPR, so its existing guidance still needs source confirmation.
- Confirm final admin labels, banners, passkey profile behavior, and the registration campaign's editable controls.
- Confirm method-management behavior for users migrated to a telephony provider.
- Confirm final screen text, helpdesk recovery actions, and error-specific retries. For unsupported browser/device sessions, the supplied screen points to aka.ms/addpasskey on another device or the help desk. Preserve the separate, author-confirmed My Sign-Ins recovery path for registering another method.
- Confirm final NPS error text and any additional unsupported-protocol scenarios without inventing error codes or redirect promises. Preserve the deployment-specific TOTP restrictions and supported customer-managed telephony option.
- Align the retirement overview and FAQ with the more detailed SSPR timing and identity verification behavior described here.
- Confirm password change after secure sign-in availability and links.

## Related content

- [SMS and voice retirement overview](concept-sms-voice-retirement.md).
- [SMS and voice retirement FAQ](concept-sms-voice-retirement-faq.yml).
- [Passkey compatibility matrix](concept-fido2-compatibility.md).
- [Enable passkeys for your organization](how-to-authentication-passkeys-fido2.md).
- [Choose a telephony provider](concept-phone-providers.md).
- [How self-service password reset works](concept-sspr-howitworks.md).
- [NPS extension for Microsoft Entra multifactor authentication](howto-mfa-nps-extension.md).
