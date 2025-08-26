---
title: Frontline worker management
description: Learn about frontline worker management capabilities that are provided through the My Staff portal.
ms.service: entra
ms.subservice: fundamentals
ms.topic: article
ms.date: 03/19/2025
ms.author: cmulligan
author: csmulligan
manager: dougeby
ms.reviewer: stevebal
ms.custom: sfi-image-nochange
#Customer Intent: As a manager of frontline workers, I want an intuitive portal so that I can easily onboard new workers and provision shared devices.
---

# Frontline worker management

Frontline workers account for over 80 percent of the global workforce. Yet because of high scale, rapid turnover, and fragmented processes, frontline workers often lack the tools to make their demanding jobs a little easier. Frontline worker management brings digital transformation to the entire frontline workforce. The workforce might include managers, frontline workers, operations, and IT.

Frontline worker management empowers the frontline workforce by making the following activities easier to accomplish:

- Streamlining common IT tasks with My Staff
- Easy onboarding of frontline workers through simplified authentication
- Seamless provisioning of shared devices and secure sign-out of frontline workers

## Delegated user management through My Staff

Microsoft Entra ID in the My Staff portal enables delegation of user management. Frontline managers can save valuable time and reduce risks using the [My Staff portal](~/identity/role-based-access-control/my-staff-configure.md). When an administrator enables simplified password resets and phone management directly from the store or factory floor, managers can grant access to employees without routing the request through the help-desk, IT, or operations.

:::image type="content" source="media/concept-fundamentals-frontline-worker/delegated-user-management.png" alt-text="Screenshot of delegated user management in the My Staff portal.":::

## Accelerated onboarding with simplified authentication

Frontline workers often need quick and easy access to tools and information. Microsoft Entra ID provides accelerated onboarding with simplified authentication to meet this need. Frontline workers can use SMS sign-in or QR code sign-in to access their devices and applications easily.

### SMS authentication

My Staff also enables frontline managers to register their team members' phone numbers for [SMS sign-in](~/identity/authentication/howto-authentication-sms-signin.md). In many verticals, frontline workers maintain a local username and password combination, a solution that is often cumbersome, expensive, and error-prone. When IT enables authentication using SMS sign-in, frontline workers can sign in with [single sign-on (SSO)](~/identity/enterprise-apps/what-is-single-sign-on.md) for Microsoft Teams and other applications using just their phone number and a one-time passcode (OTP) sent via SMS. Single sign-on makes signing in for frontline workers simple and secure, delivering quick access to the apps they need most.

:::image type="content" source="media/concept-fundamentals-frontline-worker/sms-signin.png" alt-text="Screenshot of SMS sign-in.":::

### QR code authentication (preview)

QR code authentication provides a fast and cost-effective way to sign in, improving productivity and offering a seamless experience for frontline workers. This method uses a QR code and a user-defined 8-digit PIN. You use the QR code and PIN together to sign in to a device or application.

The QR code includes a User Principal Name (UPN), tenant ID, and a secret key. You set the PIN, which replaces the default temporary PIN assigned by the administrator. The PIN works only with the QR code and not with other identifiers like UPN or phone numbers. You also can't use the QR code without the PIN.

:::image type="content" source="media/concept-fundamentals-frontline-worker/qr-code-plus-pin.png" alt-text="Screenshot of a QR code plus PIN.":::

The QR code authentication method offers two main advantages for frontline workers compared to traditional methods:

- Faster sign-in: QR code authentication eliminates the need for usernames and passwords, which benefits users who are less tech-savvy or have accessibility challenges. Scanning a QR code reduces login time by about two seconds, enhancing worker productivity. It also decreases IT tickets related to forgotten usernames, as users don't need to remember them for sign-in.

- Cost-effective: Printing QR codes is cheaper than providing hardware keys and workers can attach the QR code to a badge or wearable. Organizations prefer this method because frontline workers often hold temporary positions and may not return, reducing the risk of investment loss in costly devices.

Learn more about [QR code authentication](/entra/identity/authentication/concept-authentication-qr-code) and how to [enable it](/entra/identity/authentication/how-to-authentication-qr-code) for your organization.

## Shared devices for frontline workers

Frontline managers can also use Managed Home Screen (MHS) application to allow workers to have access to a specific set of applications on their Intune-enrolled Android dedicated devices. The dedicated devices are enrolled with [Microsoft Entra shared device mode](~/identity-platform/msal-shared-devices.md). When configured in multiapp kiosk mode in the Microsoft Intune admin center, MHS is automatically launched as the default home screen on the device and appears to the end user as the *only* home screen. To learn more, see how to [configure the Microsoft Managed Home Screen app for Android Enterprise](/mem/intune/apps/app-configuration-managed-home-screen-app).

### Secure sign-out of frontline workers from shared devices

Frontline workers in many companies use shared devices to do inventory management and sales transactions. Sharing devices reduces the IT burden of provisioning and tracking them individually. With shared device sign-out, it's easy for a frontline worker to securely sign out of all apps on any shared device before handing it back to a hub or passing it off to a teammate on the next shift. Frontline workers can use Microsoft Teams to view their assigned tasks. Once a worker signs out of a shared device, Intune and Microsoft Entra ID clear all of the company data so the device can safely be handed off to the next associate. You can choose to integrate this capability into all your line of business [iOS](/entra/msal/objc/shared-devices-ios) and [Android](~/identity-platform/msal-android-shared-devices.md) apps using the [Microsoft Authentication Library](~/identity-platform/msal-overview.md).

:::image type="content" source="media/concept-fundamentals-frontline-worker/shared-device-signout.png" alt-text="Screenshot of shared device sign-out.":::

## Next steps

- For more information on delegated user management, see [My Staff user documentation](https://support.microsoft.com/account-billing/manage-front-line-users-with-my-staff-c65b9673-7e1c-4ad6-812b-1a31ce4460bd).
- To learn more about the frontline worker persona, see [this article](/entra/identity/authentication/how-to-plan-persona-phishing-resistant-passwordless-authentication#frontline-workers).
