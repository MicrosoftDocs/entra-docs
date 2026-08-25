---
title: Authentication transfer as a condition to secure mobile users
description: Learn how authentication transfer connects users to apps across desktop and mobile devices, including supported apps, end-user experience, limitations, and troubleshooting.
ai-usage: ai-assisted
ms.topic: concept-article
ms.date: 04/22/2026
ms.reviewer: anjusingh, ludwignick
---
# Conditional Access: Authentication transfer (preview)

Authentication transfer is an authentication flow that simplifies cross-device sign-in from PC to mobile for Microsoft apps. Users can use a QR code in an authenticated Microsoft app on their PC to sign in to the same app on a mobile device without reentering credentials. Authentication transfer increases user engagement by connecting users on multiple platforms.

> [!NOTE]
> Authentication transfer is currently in preview. For more information about previews, see [Universal License Terms For Online Services](https://www.microsoft.com/licensing/terms/product/ForOnlineServices/all).

:::image type="content" source="media/concept-authentication-transfer/authentication-transfer-in-policy-example.png" alt-text="Screenshot that shows an example Conditional Access policy that uses authentication transfer with a block control." lightbox="media/concept-authentication-transfer/authentication-transfer-in-policy-example.png":::

## Prerequisites

- A Microsoft Entra ID P1 license is required for each user subject to Conditional Access policies that manage authentication transfer. For more information about licensing, see [Plan a Conditional Access deployment](plan-conditional-access.md).
- To create or modify Conditional Access policies that manage authentication transfer, sign in as at least a [Conditional Access Administrator](../role-based-access-control/permissions-reference.md#conditional-access-administrator).
- Authentication transfer is enabled by default for all users. No initial configuration is required for users to use the feature.

## How authentication transfer works

Authentication transfer lets you transfer authentication claims from one device to another, such as from a desktop PC to a mobile device. The following steps describe the flow:

1. A user signs in to a supported Microsoft app on their PC and completes any required authentication, including multifactor authentication (MFA).
1. The app displays a QR code that the user can scan with their mobile device.
1. The user scans the QR code using a supported Microsoft app on their mobile device.
1. Microsoft Entra ID evaluates all applicable Conditional Access policies for the target mobile app.
1. If the policies are satisfied, the authentication claims transfer to the mobile device and the user is signed in automatically.
1. If the policies aren't satisfied, the transfer fails and the user is prompted to sign in manually on the mobile device.

Authentication transfer only transfers authentication claims. Device-related claims, like device compliance state, don't transfer to the target device. The mobile device must independently satisfy any device-based Conditional Access requirements.

When a user performs authentication transfer, the session is considered [protocol tracked](concept-authentication-flows.md#protocol-tracking). Protocol tracking means that the session state persists through subsequent token refreshes. Subsequent sign-in attempts within the same session might be subject to authentication flows policy enforcement, even if they don't use authentication transfer.

## Supported apps

Authentication transfer is available for Microsoft apps that support the cross-device QR code flow. For example, users might see a QR code in the desktop version of Outlook that, when scanned on their mobile device, transfers their authenticated state to the mobile version of Outlook. Support varies by app and version. Check the relevant Microsoft app documentation to confirm whether it supports authentication transfer.

> [!IMPORTANT]
> Authentication transfer isn't supported for non-Microsoft apps.

## End-user experience

The authentication transfer experience is designed to reduce friction for users who work across multiple devices.

**On the desktop (source device):**

- The user is signed in to a supported Microsoft app on their PC.
- A QR code appears within the app, offering to transfer the session to a mobile device.

**On the mobile device (target device):**

- The user opens a supported Microsoft app and scans the QR code.
- If all Conditional Access policies are satisfied, the user is signed in automatically without reentering credentials or completing MFA again.
- If any Conditional Access policy isn't satisfied for the mobile device, the user is prompted to sign in manually. The user might need to complete MFA or meet other requirements on the mobile device.

## Authentication transfer and Conditional Access

During authentication transfer, all Microsoft Entra Conditional Access policies are evaluated. Understanding how policies interact with authentication transfer helps you secure your organization while maintaining user productivity.

**Authentication claims transfer, device claims don't:**

- Authentication transfer only transfers authentication claims. It doesn't transfer device-related claims like compliance state or managed status.
- If a Conditional Access policy requires device compliance or a managed device, the mobile device must meet those requirements independently.

**MFA isn't required again if already completed:**

- If users complete MFA on their PC, they don't need to perform MFA again on their mobile device during authentication transfer.

**Conditional Access policies are evaluated before transfer:**

- Conditional Access policies are evaluated before authentication transfer completes. If a policy isn't met for the mobile device, the user is prompted to sign in manually.

**Non-Microsoft MDM bypass:**

- Authentication transfer bypasses non-Microsoft mobile device management (MDM) solutions when transferring authentication to mobile devices. This bypass means that organizations relying on non-Microsoft MDM solutions to enforce access controls might have a security gap during authentication transfer. If your organization uses a non-Microsoft MDM solution, consider [blocking authentication transfer](policy-block-authentication-flows.md#authentication-transfer-policies) for affected users or apps.

**Primary Refresh Token (PRT) reauthentication:**

- Users must reauthenticate on their PC to initiate authentication transfer, even if they have protected session tokens like the Primary Refresh Token. After reauthentication on the PC, users don't need to reauthenticate on the mobile app.

## Known limitations

Review the following limitations before you enable or manage authentication transfer in your organization:

- **Device claims don't transfer.** Only authentication claims transfer to the mobile device. Device compliance, managed state, and other device-related claims must be satisfied independently on the mobile device.
- **Non-Microsoft MDM bypass.** Authentication transfer bypasses non-Microsoft MDM solutions. Organizations that depend on non-Microsoft MDM for mobile access control should evaluate the security implications. For more information, see the [Zero Trust guidance on blocking authentication transfer](../../fundamentals/zero-trust-protect-identities.md#authentication-transfer-is-blocked).
- **Microsoft apps only.** Authentication transfer is only available for Microsoft apps. Non-Microsoft apps don't support this flow.
- **Protocol tracking.** After a user performs authentication transfer, the session is [protocol tracked](concept-authentication-flows.md#protocol-tracking). Other sign-in attempts within the same session might be subject to authentication flows policies, even if they use a different authentication flow.
- **PRT reauthentication required.** Users must reauthenticate on their PC to start authentication transfer, even with an existing Primary Refresh Token session.

## Security considerations

Microsoft recommends that organizations evaluate whether authentication transfer is necessary for their users. The [Zero Trust guidance for protecting identities](../../fundamentals/zero-trust-protect-identities.md#authentication-transfer-is-blocked) recommends blocking authentication transfer as a security best practice.

Blocking authentication transfer helps protect against token theft and replay attacks by preventing the use of device tokens to silently authenticate on other devices. When authentication transfer is enabled, a threat actor who gains access to one device could potentially access resources on nonapproved devices, bypassing standard authentication and device compliance checks.

Consider the following recommendations:

- **Block authentication transfer** unless you have a documented business need for cross-device sign-in. Use a Conditional Access policy to [block authentication transfer](policy-block-authentication-flows.md#authentication-transfer-policies).
- **Use report-only mode** first to understand how authentication transfer is used in your organization before enforcing a block.
- **Exclude emergency access accounts** from any policy that blocks authentication transfer.

## Authentication transfer in sign-in logs

Admins can check the [Microsoft Entra sign-in logs](../monitoring-health/concept-sign-ins.md) to see if users are using authentication transfer to sign in. Authentication transfer events appear back to back, with the first event showing a QR code as the authentication method.

To check the protocol tracking state of a sign-in, select the sign-in event and find the **Original transfer method** property in the **Basic info** portion of the **Activity details: sign-ins** pane. For a session in which authentication transfer was performed, the **Original transfer method** is set to **Authentication transfer**.

## Manage authentication transfer for specific users and apps

Authentication transfer is enabled by default for all users. Admins manage authentication transfer using Conditional Access policies and the [authentication flows](concept-authentication-flows.md) condition. This condition restricts authentication transfer to specific users, apps, or disables the functionality entirely.

Authentication transfer checks all applicable Conditional Access policies before signing the user into a mobile app. If the required conditions aren't met, the user is prompted to sign in on the mobile app.

To create a policy that uses the authentication transfer condition, see [Block authentication transfer with Conditional Access policy](policy-block-authentication-flows.md#authentication-transfer-policies).

## Troubleshooting

Use the following steps to troubleshoot issues with authentication transfer.

**Authentication transfer fails for a user:**

1. Check the [sign-in logs](../monitoring-health/concept-sign-ins.md) for authentication transfer events. Look for the QR code authentication method entry.
1. Select the sign-in event and navigate to the **Conditional Access** tab to identify which policies were evaluated and whether any blocked the transfer.
1. Verify that the target mobile device meets all Conditional Access requirements, including device compliance and location policies.

**Unexpected blocks after using authentication transfer:**

1. Check if the sign-in is blocked by a [protocol tracking](concept-authentication-flows.md#protocol-tracking) state from a previous authentication transfer or device code flow session.
1. In the sign-in logs, select the blocked sign-in and check the **Original transfer method** property in the **Basic info** section. If it shows **Authentication transfer** or **Device code flow**, the session was protocol tracked.
1. If your authentication flows policy applies to all applications, you might see the error code `AADSTS530036`. This error indicates the refresh token is invalid due to authentication flow checks by Conditional Access.

**Users can't initiate authentication transfer:**

- If a Conditional Access policy manages authentication transfer for the user, verify the user has a Microsoft Entra ID P1 license assigned.
- Verify no Conditional Access policy blocks authentication transfer for the user's group or target app.
- Confirm the user is using a supported Microsoft app on both the source and target devices.

For more information about troubleshooting authentication flows, see [Troubleshooting unexpected blocks](concept-authentication-flows.md#troubleshooting-unexpected-blocks).

## Related content

- [Block authentication transfer with Conditional Access policy](policy-block-authentication-flows.md#authentication-transfer-policies)
- [Conditional Access: Authentication flows](concept-authentication-flows.md)
- [Conditional Access: Conditions](concept-conditional-access-conditions.md)
- [Plan a Conditional Access deployment](plan-conditional-access.md)
- [Zero Trust guidance: Protect identities](../../fundamentals/zero-trust-protect-identities.md#authentication-transfer-is-blocked)
