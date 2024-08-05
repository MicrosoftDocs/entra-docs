---
title: Shared device mode overview
description: Learn how Microsoft Entra ID's shared device mode feature enables device sharing for your frontline workers.
author: henrymbuguakiarie
manager: CelesteDG
ms.author: henrymbugua
ms.custom:
ms.date: 08/02/2024
ms.reviewer: brianmel, akgoel, dmwendia
ms.service: identity-platform

ms.topic: concept-article
#Customer intent: As a developer building applications for frontline workers, I want to understand how to enable shared device mode in my apps using Microsoft Entra ID, so that I can provide a secure and optimized experience for users on shared Android and iOS devices.
---

# Overview of shared device mode

Shared Device Mode (SDM) is a Microsoft Entra ID feature that enables organizations to configure an iOS, iPadOS, or Android device for shared use among multiple employees, a common practice in frontline worker environments. With SDM, employees sign in once to access their data across all supported applications, without accessing other employees’ data. When employees sign out after completing their shift or task, they're automatically signed out of the device and all supported apps, making it ready for the next user.

## Why Shared Device Mode?

Most applications optimize their experience for single users because mobile devices running iOS, iPadOS, or Android are designed for individual use. Part of the optimized experience means enabling single sign-on (SSO) across applications and keeping users signed in on their devices. 

To allow employees to use an organization's apps across shared devices, developers should facilitate a streamlined and secure user experience. Employees should be able to pick a device from the shared pool and sign in with a single gesture, making the device "theirs" during their shift. At the end of their shift, employees can perform another gesture to globally sign out of the device before returning it to the shared device pool. This removes all personal and company information from the device, ensuring the next user can't access their data. 

Enabling Shared Device Mode provides several benefits for multi-user and guest Windows devices, including:

- **Single sign-on:** Allow users to sign into one of the apps that support shared device mode and gain seamless authentication across all other SDM supported apps without having to reenter their credentials. An exemption is users on First Run Experience (FRE) screens on shared devices. 
- **Single sign out:** Enable users to sign out of the device without needing to sign out individually from each SDM supported app. Signing out assures users that their data won’t be shown to subsequent device users, provided apps ensure cleaning up of any cached user data and App Protection Policies are applied.
- **Security via Conditional Access policies support:** Provide admins the ability to target specific conditional access policies on shared devices, ensuring that employees only have access to company data when their shared device meets internal compliance standards.

## Supported and unsupported scenarios

Microsoft Entra ID introduced the **Shared Device Mode** feature to support multiple scenarios such as: 

- A user signs in to a Shared Device Mode supported app (Line of business app, third-party launcher app, or Microsoft app) on an Android or iOS/iPadOS device using Microsoft Entra ID credentials and is automatically signed-on to all Shared Device Mode supported apps on the device.
- A User signs out of a Shared Device Mode supported app (Line of business, third-party launcher, or Microsoft app) on an Android or iOS/iPadOS device and is logged out of all SDM supported apps on the device.
- If an admin sets up a Conditional Access policy with the grant that requires devices to be enrolled in mobile device management (MDM) and compliant, the user can only sign in to an SDM-supported app if the device is compliant.

**Note:** If a user signs into an app that doesn't support shared device mode, they don't receive the benefits of single sign-on and single sign out.

## Enable Shared Device Mode

To take advantage of the shared device mode feature, cloud device admins and app developers work together:

**Device administrators** prepare the devices to be shared by setting up the devices in shared device mode manually or via a mobile device management (MDM) provider like Microsoft Intune. The preferred option is using an MDM as it allows the device setup in shared device mode at scale via zero-touch provisioning. The MDM is configured to push the Microsoft Authenticator app to the device with shared device mode turned on. On iOS devices, MDM also enables the Microsoft Enterprise SSO plug-in that is required for shared device mode. For details on how to set up a device in shared device mode via Intune, see [Set up Intune enrollment of Android Enterprise dedicated devices](/mem/intune/enrollment/android-kiosk-enroll) and [Set up enrollment for devices in shared device mode](/mem/intune/enrollment/automated-device-enrollment-shared-device-mode).

Manual setup is a useful tool for pilot programs and small-scale deployments. It requires the Cloud Device Administrator access and needs to be done on each device. 
    
You can also set up devices in shared device mode using an Intune compliance partner. The list of third-party MDMs that support shared device mode on Android can be found in [Third-party MDMs that support shared device mode](/entra/identity-platform/msal-android-shared-devices#third-party-mdms-that-support-shared-device-mode).

**Application developers** add shared device mode to [single account public client application](single-multi-account.md#single-account-public-client-application) using the Microsoft Authentication Library (MSAL). MSAL allows the apps to modify their behavior based on the signals on the state of the device and user on the device. For example, the application checks the state of the user on the device every time the app is used and clears the previous user's data if the user has changed. On a user change, the application should ensure both the previous user's data is cleared and that any cached data being displayed in the application is removed.

Application developers can also integrate with the [Intune App SDK](/mem/intune/developer/app-sdk) to support all data loss prevention scenarios, which is highly recommended. You use the Intune App SDK to support [Intune App Protection Policies](/mem/intune/apps/app-protection-policy) in your apps. Microsoft recommends integrating with Intune's [selective wipe](/mem/intune/developer/app-sdk-android-phase5#selective-wipe) capabilities and [deregistering the user on iOS](/mem/intune/developer/app-sdk-ios-phase1#deregister-user-accounts) during sign out.

Supporting shared device mode should be considered a feature upgrade for the application and can help increase its adoption in environments where the same device is shared among multiple users. For Microsoft applications that support shared device mode, you don't need to make any further changes other than installing them on a shared device mode enabled device. 

## Related content

Microsoft Entra ID supports shared device mode in iOS and Android platforms. For more information, see:

- [Supporting shared device mode for iOS](/entra/msal/objc/shared-devices-ios)
- [Supporting shared device mode for Android](msal-android-shared-devices.md)
