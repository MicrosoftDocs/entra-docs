---
title: Best practices to protect frontline workers
description: Learn about the best practices and general guidance for protecting frontline workers in an organization
author: Dickson-Mwendia
manager: CelesteDG
ms.author: dmwendia
ms.custom: template-concept
ms.date: 02/14/2025
ms.reviewer: akgoel
ms.service: identity-platform
ms.topic: concept-article

#Customer intent: As an IT administrator, I want to implement the best practices for protecting frontline workers' access to corporate resources so that I can ensure their work and personal data remain secure while optimizing their productivity across various devices and access scenarios.
---

# Best practices to protect frontline workers

Frontline workers are the backbone of every organization. They keep warehouses stocked, ensure machines run smoothly, organize store locations, and serve as the first contact point for customers. We depend on them to deliver consistent quality at an accelerated pace while managing personal safety risks, increased theft, and ongoing supply chain disruptions.  

An increasing set of organizations are enabling their information workers (IWs) and frontline workers (FLWs) to collaborate in the same cloud-based applications, such as SharePoint, Teams, etc. Because those cloud-based applications are available on the Internet, the organizations need to consider how to secure the environment, including protecting against remote account break-ins.  

For their information workers, many organizations want to empower their users to work more securely anywhere and anytime, on any device as described in [Microsoft’s Zero Trust best practices](https://www.microsoft.com/security/business/zero-trust). However, many frontline workers don't fall into the model of needing anywhere/anytime/any-device access. Instead, most the frontline workers fall into the model of needing two types of access: 

- **Work access (on-shift)**: While at work, a frontline worker could require access to sensitive applications. 

- **Home access (off-shift)**: While at home or away from the worksite, most frontline workers aren't expected to perform work duties. However, they might require access to non-sensitive work applications for off-shift communication, signing up for shifts, or reviewing training material. In some cases, they could also require access to sensitive personal resources such as paystub or W2.   

This article outlines the best practices for protecting frontline workers across various home or work access scenarios. To fully grasp these security tips, it's important to first understand the various types of devices frontline workers use in different settings. 

## Device types used in frontline worker environments

There are three main device types used by frontline workers in most scenarios:

- **Shared devices:** These are company-owned devices that are shared between employees across tasks, shifts, or locations. 

- **Bring Your Own Device (BYOD):** Some organizations use a bring-your-own-device model where frontline workers use their personal devices to access business apps.

- **Company-owned single user devices:** These devices are assigned to a specific employee for work purposes only, not for personal use. Although this device model is less frequent, we recommend that organizations using it for their frontline workers to follow the anywhere/anytime/any-device best practices as described in [Microsoft’s Zero Trust best practices](https://www.microsoft.com/security/business/zero-trust). 

## Security controls for frontline worker environments

The following security controls are recommended to secure frontline workers across various settings:

| **Security Controls**     | **Description**             |
|---------------------------|-----------------------------|
| **Mobile Device Management (MDM) Managed** | To secure devices and the data they access, admins are recommended to manage them using an MDM like Microsoft [Intune](/mem/intune/fundamentals/manage-devices).                                   |
| **Shared Device Mode (SDM) enabled**       | [Shared device mode](msal-shared-devices.md) is a feature that allows organizations to configure an iOS, iPadOS, or Android device for multiple employees to share. Employees can pick a device from the shared pool, sign in once, and they automatically gain access to all SDM-supported apps through single sign-on (SSO). When their shift ends, they sign out globally on the device, which removes their personal and company information from all SDM-supported applications. They can then return their device to the pool, while ensuring a secure handoff to the next worker as other users can't see or access their information. <br/>  We recommend enabling SDM on your shared devices. In addition to Microsoft Intune, check out other [third-party MDMs that support Microsoft Entra shared device mode](msal-android-shared-devices.md#third-party-mdms-that-support-shared-device-mode).|
| **Application protection policies**       | Intune [App Protection Policies (APP)](/mem/intune/apps/app-protection-policy) ensure organizational data remains safe within managed apps. For enhanced security, set up [Microsoft Entra Conditional Access policies](/entra/identity/conditional-access/howto-policy-approved-app-or-app-protection#require-approved-client-apps-or-app-protection-policy-with-mobile-devices) to ensure your apps are secured with an app protection policy before granting access to users.                                |
| **Inactivity screen lock**                | Configure inactivity screen lock and auto sign-out functionalities using launcher apps like [Managed Home Screen](/mem/intune/apps/app-configuration-managed-home-screen-app) to protect shared corporate devices from unauthorized access by malicious coworkers with physical access.<br/>  On BYOD, configure screen lockout capabilities on [iOS](https://support.apple.com/guide/iphone/keep-the-iphone-display-on-longer-iph7117338a8/ios#:~:text=Change%20when%20iPhone%20automatically%20locks,choose%20a%20length%20of%20time.) and [Android](https://support.google.com/android/answer/9079129?hl=en) to prevent local attacks.  | 
| **Device compliance**   | Deploying Microsoft Intune or a supported third-party MDM enables organizations to enforce compliance requirements for devices. Administrators can set policies to ensure devices meet security standards such as requiring a minimum OS version, preventing use of jailbroken or rooted devices, and more.  <br/>  When configured, the MDM sends policy compliance information to Microsoft Entra ID. This data is used by Device Compliance Conditional Access policy to determine whether to grant or block access to resources, ensuring that only users with compliant devices can access organizational resources.|
| **Interactive user authentication**       | Interactive user authentication ensures that only authorized users can access resources when they sign in to a device, application, or service. Admins should choose the [Microsoft Entra ID authentication methods](/entra/identity/authentication/concept-authentication-methods) that meet or exceed their organization's security, usability, and availability standards.|   

### Access scenarios for frontline workers

#### Work access (on-shift)

While at work, a frontline worker could be given access to sensitive applications from a secured or public location or network. Such a scenario requires stricter controls on all device types, including shared, BYOD, and company owned single user devices. 

The recommended best practice is to allow access only from MDM-managed and compliant devices. This enables the identity system to silently verify the first key aspect of device compliance before proceeding with interactive user authentication, preferably MFA, to enhance security before granting access. Other recommendations to secure users and prevent data-loss scenarios include:

 - Integrate with the [Intune App SDK](/mem/intune/developer/app-sdk) and setup [Microsoft Entra Conditional Access policy](/entra/identity/conditional-access/howto-policy-approved-app-or-app-protection#require-approved-client-apps-or-app-protection-policy-with-mobile-devices). Additionally, enable Intune's [selective wipe](/mem/intune/developer/app-sdk-android-phase5#selective-wipe) capabilities and [deregister the user on iOS](/mem/intune/developer/app-sdk-ios#deregister-user-accounts) during a sign-out.
 - Configure inactivity screen lock or auto sign-out on shared devices using launcher apps like [Managed Home Screen](/mem/intune/apps/app-configuration-managed-home-screen-app). In a BYOD scenario, use screen lockout capabilities on [iOS](https://support.apple.com/guide/iphone/keep-the-iphone-display-on-longer-iph7117338a8/ios#:~:text=Change%20when%20iPhone%20automatically%20locks,choose%20a%20length%20of%20time.) and [Android](https://support.google.com/android/answer/9079129?hl=en). 
 - Enable Shared Device Mode (SDM) to secure user data on shared devices and improve authentication experiences for frontline workers using the devices. 

#### Home access (off-shift) 

At home, frontline workers should have restricted access to non-sensitive business applications needed for limited off-shift communication or reviewing basic training material. Some organizations might also allow access to sensitive personal data like paystubs. For these scenarios, we recommend the following security best practices:

- Enable interactive multifactor authentication 
- Apply inactivity screen lock and [App Protection Policies](/mem/intune/apps/app-protection-policy). 
- Follow the anywhere/anytime/any-device best practices as described in [Microsoft's Zero Trust best practices](https://www.microsoft.com/security/business/zero-trust) in scenarios where your organization needs to provide access to sensitive applications to frontline workers while off-shift.

> [!NOTE] 
> Although many organizations follow the frontline workers home or work access model, some organizations might have internal policies that enable employees to access any device from anywhere and at any time. Such organizations need to apply the same policies on frontline workers as information workers and would thus follow anywhere/anytime/any-device best practices as described in [Microsoft's Zero Trust best practices](https://www.microsoft.com/security/business/zero-trust). 

## Best practices for protecting frontline workers

The following image provides a summary of the recommended best practices for securing frontline workers in across the various home or work access scenarios described in the previous sections.

:::image type="content" source="./media/security-practices-for-frontline-workers/frontline-workers-scenarios.png" alt-text="Screenshot that shows possible scenarios when working with frontline workers." lightbox="./media/security-practices-for-frontline-workers/frontline-workers-scenarios-expanded.png":::

## Get started with the best practices for securing frontline workers

To apply the best practices for your frontline workers, take the following steps

1. **Map your frontline worker scenario** to one of the scenarios listed in this article.
1. **Review the applicable security controls**:
   - Device management using an MDM like [Microsoft Intune](/mem/intune/fundamentals/manage-devices).
   - Implement [Shared Device Mode](msal-shared-devices.md).
   - Enforce application protection policies and [Microsoft Entra Conditional Access](/entra/identity/conditional-access/) policies.
   - Take advantage of inactivity screen lock capabilities offered by launcher apps like Managed Home Screen and by operating systems - iOS and Android.
   - Check whether devices comply with security requirements as per [Device Compliance Conditional Access](/entra/identity/conditional-access/howto-conditional-access-policy-compliant-device).
   - Enable interactive user [authentication using Microsoft Entra ID](/entra/identity/authentication/concept-authentication-methods).
   
1. **Apply the controls** as per the best practices recommended for your scenario.

## Related content
 - [Overview of Microsoft Entra Shared device mode](msal-shared-devices.md)
 - [Microsoft’s Zero Trust best practices](https://www.microsoft.com/security/business/zero-trust)
 - [Microsoft Entra Conditional Access policies](/entra/identity/conditional-access/)
