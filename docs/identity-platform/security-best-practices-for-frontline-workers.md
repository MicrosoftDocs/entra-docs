---
title: Best practices to protect frontline workers
description: Learn about the best practices and general guidance for protecting frontline workers in an organization
author: Dickson-Mwendia
manager: CelesteDG
ms.author: dmwendia
ms.custom: template-concept
ms.date: 02/12/2025
ms.reviewer: akgoel, henrymbugua
ms.service: identity-platform

ms.topic: concept-article

#Customer intent: As an IT administrator, I want to implement best practices for protecting frontline workers' access to corporate resources so that I can ensure their work and personal data remain secure while optimizing their productivity across various devices and access scenarios.
---

# Best Practices to Protect Frontline Workers

Frontline workers are the backbone of every organization. They keep warehouses stocked, ensure machines run smoothly, organize store locations, and serve as the first contact point for customers. We depend on them to deliver consistent quality at an accelerated pace while managing personal safety risks, increased theft, and ongoing supply chain disruptions.  

An increasing set of organizations are enabling their information workers (IWs) and frontline workers (FLWs) to collaborate in the same cloud-based applications, such as SharePoint, Teams, etc. Because those cloud-based applications are available on the Internet, the organizations need to consider how to secure the environment, including protecting against remote account break-ins.  

For their information workers, many organizations want to empower their users to work more securely anywhere and anytime, on any device as described in [Microsoft’s Zero Trust best practices](/security/business/zero-trust). However, many frontline workers don't fall into the model of needing anywhere/anytime/any-device access. Instead, the majority of the frontline workers fall into the model of needing two types of access: 

- **Work access (on-shift)**: While at work, an FLW could require access to sensitive applications. 

- **Home access (off-shift)**: At home i.e. away from the worksite, an FLW in general isn't expected to perform work duties and mostly requires access to non-sensitive work applications for off-shift communication, signing up for shifts, or reviewing basic training material. In some cases, they could also require access to sensitive personal resources like paystub or W2.   

This article shares the best practices for protecting FLWs across various home/work access scenarios.  

## Best practices for protecting FLW across various home or work access scenarios

:::image type="content" source="./media/security-practices-for-frontline-workers/front-line-workers-scenarios.png" alt-text="Screenshot that shows possible scenarios when working with frontline workers.":::

| **Device Types**            | **Description**           |
|-----------------------------|---------------------------|
| **Shared devices**          | Shared devices are company-owned devices that are shared between employees across tasks, shifts, or locations.                                          |
| **BYOD (bring-your-own-device)** | Some organizations use a bring-your-own-device model where frontline workers use their own mobile devices to access business apps.                    |
| **Company-owned single user** |A company-owned single user device is associated with a single user and is intended for work, not personal use. Though less frequent, if using this device model for frontline workers, we recommend following anywhere/anytime/any-device best practices as described in  [Microsoft’s Zero Trust best practices](/security/business/zero-trust). |

| **Security Controls**     | **Description**             |
|---------------------------|-----------------------------|
| **Mobile Device Management (MDM) Managed** | To secure devices and the data they access, admins are recommended to manage them using an MDM like Microsoft [Intune](/mem/intune/fundamentals/manage-devices).                                                                 |
| **Shared Device Mode (SDM) Enabled**       | SDM is a Microsoft Entra ID feature that allows organizations to configure an iOS, iPadOS or Android device so that it can be easily shared by multiple employees. Employees can pick a device from the pool and perform a single gesture (sign-in) to make it theirs"during their shift. They sign in once and get single-signed on to all SDM supported apps. At the end of their shift, they can perform another gesture to sign out globally on the device from all supported apps, with all their personal and company information removed so they can return it to the device pool and prevent other users from seeing their information. We strongly recommend enabling SDM on your shared devices. For more information about SDM, check [Overview of shared device mode](msal-shared-devices.md). 

Note: SDM is supported by third-party MDMs in addition to Microsoft Intune. MDMs supporting SDM on Android are listed here. If your MDM is not listed, please reach out to your MDM.  
 |
| **Application Protection Policies**       | Intune App Protection Policies (APP) ensure organizational data remains safe within managed apps. For enhanced security, set up Entra ID Conditional Access policies.                                      |
| **Inactivity screen lock**                | Configure inactivity screen lock and auto sign-out on shared devices to prevent local attacks by malicious co-workers. On BYOD, configure screen lockout capabilities on iOS and Android.                 |
| **Device Compliance**                     | Ensure devices meet compliance requirements (e.g., OS version, not jailbroken) via MDM, and use Device Compliance Conditional Access policies to grant or block access to resources.                       |
| **Interactive User Authentication**       | Choose Entra ID authentication methods to ensure only authorized users access resources. Use the most secure methods available.                |

### Access Scenarios

- **Work access (on-shift):**  
  For work access, stricter controls should be applied to all device types. The best practice is to allow access only via MDM-managed and compliant devices, with another user validation through interactive authentication such as MFA.  

  Specific recommendations:
  - Enable **Intune App SDK** and Entra ID Conditional Access policies.
  - Configure **inactivity screen lock** or auto sign-out on shared devices.
  - Enable **Shared Device Mode (SDM)** to secure user data on shared devices.

- **Home access (off-shift):**  
  At home, FLWs only need access to non-sensitive business applications. Use interactive MFA and inactivity screen locks for security. For sensitive applications, follow Zero Trust best practices.

> **Note:** Though many organizations follow FLW home/work access model, some organizations may have internal policies that were designed with enabling “anywhere, anytime, any device” access for all employees, and cannot exclude employees like FLWs that only need specialized access. Such organizations need to apply the same policies on FLWs as Information Workers and would thus follow anywhere/anytime/any-device best practices as described in Microsoft’s Zero Trust best practices even for their FLWs. 

## Get started with the best practices to secure front-line workers

To apply the best practices for your FLWs, take the following steps

1. **Map your frontline worker scenario** to one of the scenarios listed in this article.
1. **Review the applicable security controls**:
   - Device management using an MDM like Microsoft [Intune](/mem/intune/fundamentals/manage-devices)
   - Implement Shared Device Mode
   - Enforce application protection policies and Entra ID Conditional Access policies
   - Take advantage of inactivity screen lock capabilities offered by launcher apps like Managed Home Screen and by operating systems - iOS and Android
   - Check whether devices comply with security requirements as per Device Compliance Conditional Access policies
   - Enable interactive user authentication via Microsoft Entra ID authentication methods
1. **Apply the controls** as per the best practices recommended for your scenario.

## Related Content
 - [Microsoft’s Zero Trust best practices](/security/business/zero-trust)
 - 

