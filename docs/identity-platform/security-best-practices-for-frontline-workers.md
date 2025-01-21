---
title: Best practices to protect frontline workers
description: Learn about the best practices and general guidance for protecting frontline workers in an organization
author: Dickson-Mwendia
manager: CelesteDG
ms.author: dmwendia
ms.custom: template-concept
ms.date: 01/21/2025
ms.reviewer: akgoel,
ms.service: identity-platform

ms.topic: concept-article

#Customer intent: As an IT administrator, I want to implement best practices for protecting frontline workers' access to corporate resources so that I can ensure their work and personal data remain secure while optimizing their productivity across various devices and access scenarios.
---

# Best Practices to Protect Frontline Workers


Frontline worker is an individual who works directly with customers, clients, or other recipients of services. Whether they help shoppers find groceries, tutor kids in math, perform life-saving surgeries, repair HVAC units, or deliver packages, frontline workers are often the first human connection the public makes with a company. Across every industry, frontline workers make up a large segment of the workforce. The role includes retail associates, factory workers, field and service technicians, healthcare personnel, and many more.

An increasing set of organizations are enabling their information workers (IWs) and frontline workers (FLWs) to collaborate in the same cloud-based applications, such as Office365, Teams, etc. Because those cloud-based applications are available on the Internet, organizations need to consider how to secure the environment, including protecting against remote account break-ins.

For their information workers, many organizations want to "empower their users to work more securely anywhere and anytime, on any device" as described in Microsoft’s Zero Trust best practices. However, many frontline workers don't fall into the model of needing anywhere/anytime/any-device access. Instead, most frontline workers fall into the model of needing two types of access:

- **Work access (on-shift):** While at work, an FLW could require access to sensitive applications.
- **Home access (off-shift):** At home, that is, away from the worksite, an FLW is not expected to perform work duties and mostly requires access to nonsensitive work applications for off-shift communication, signing up for shifts, or reviewing basic training material. In some cases, they could also require access to sensitive personal resources like paystubs or W2.

This article shares the best practices for protecting FLWs across various home/work access scenarios.

## Best Practices for Protecting FLW Across Various Home/Work Access Scenarios

### Device Types and Descriptions

| **Device Types**           | **Description**                                                                                                                                         |
|-----------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Shared devices**          | Shared devices are company-owned devices that are shared between employees across tasks, shifts, or locations.                                          |
| **BYOD (bring-your-own-device)** | Some organizations use a bring-your-own-device model where frontline workers use their own mobile devices to access business apps.                     |
| **Company-owned single user** | A company-owned single-user device is associated with a single user and is intended for work, not personal use. If using this model, follow Microsoft’s Zero Trust best practices. |

### Security Controls and Descriptions

| **Security Controls**          | **Description**                                                                                                                                                                                                 |
|--------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Mobile Device Management (MDM) Managed** | To secure devices and the data they access, admins are recommended to manage them via MDM like Microsoft Intune.                                                                 |
| **Shared Device Mode (SDM) Enabled**       | SDM is a Microsoft Entra ID feature that allows shared devices to be configured for multiple employees. Employees can sign in and out globally, removing personal and company information between shifts. |
| **Application Protection Policies**       | Intune App Protection Policies (APP) ensure organizational data remains safe within managed apps. For enhanced security, set up Entra ID Conditional Access policies.                                      |
| **Inactivity screen lock**                | Configure inactivity screen lock and auto sign-out on shared devices to prevent local attacks by malicious co-workers. On BYOD, configure screen lockout capabilities on iOS and Android.                 |
| **Device Compliance**                     | Ensure devices meet compliance requirements (e.g., OS version, not jailbroken) via MDM, and use Device Compliance Conditional Access policies to grant or block access to resources.                       |
| **Interactive User Authentication**       | Choose Entra ID authentication methods to ensure only authorized users access resources. Use the most secure methods available.                                                                           |

### Access Scenarios

- **Work access (on-shift):**  
  For work access, stricter controls should be applied to all device types. The best practice is to allow access only via MDM-managed and compliant devices, with another user validation through interactive authentication such as MFA.  

  Specific recommendations:
  - Enable **Intune App SDK** and Entra ID Conditional Access policies.
  - Configure **inactivity screen lock** or auto sign-out on shared devices.
  - Enable **Shared Device Mode (SDM)** to secure user data on shared devices.

- **Home access (off-shift):**  
  At home, FLWs only need access to non-sensitive business applications. Use interactive MFA and inactivity screen locks for security. For sensitive applications, follow Zero Trust best practices.

> **Note:** Some organizations may apply anywhere/anytime/any-device policies to all employees, including FLWs. These organizations should follow Microsoft’s Zero Trust best practices for all scenarios.

## Next Steps

1. **Map your frontline worker scenario** to one of the listed scenarios in this document.
2. **Review the applicable security controls**:
   - Device management via MDM like Microsoft Intune
   - Shared Device Mode
   - App Protection Policies and Entra ID Conditional Access policies
   - Inactivity screen lock
   - Device Compliance checks via Device Compliance Conditional Access policies
   - Interactive user authentication via Entra ID authentication methods
3. **Apply the controls** as per the best practices recommended for your scenario.
