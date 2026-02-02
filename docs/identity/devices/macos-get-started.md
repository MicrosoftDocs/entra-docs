---
title: Add Your Work or School Account to a macOS Device
description: Learn how to add your work or school account to a macOS device for seamless access to organizational resources, enhanced security, and device management.
author: owinfreyATL
ms.author: owinfrey
ms.service: entra-id
ms.subservice: devices
ms.topic: how-to #Required; leave this attribute/value as-is
ms.date: 01/22/2026


---



# Add Your Work or School Account to a macOS Device

Adding a work or school account to macOS is a straightforward process that enhances your access to organizational resources and services. This article provides an overview and answers to some Frequently Asked Questions (FAQs) about adding a work or school account to your macOS device using browsers such as Microsoft Edge or Google Chrome.

> [!IMPORTANT]
> This feature only works with browser-based scenarios. When you use browsers like Microsoft Edge or Google Chrome to access organizational resources, you are prompted to add your work or school account to your macOS device. This doesn't apply to standalone desktop applications.

## Overview

When you add a work or school account to your device through a browser, you're prompted with a page, called the Microsoft Entra account registration page. The content of the page depends on whether your organization implemented a device management solution:

- In the standard flow, you add your work or school account through a browser like Microsoft Edge or Google Chrome. This process involves entering your organization account's credentials and possibly completing multifactor authentication
    :::image type="content" source="media/macos-get-started/macos-sign-in.png" alt-text="Screenshot of signing in on macOS device.":::
- If your organization uses a device management solution, the process includes additional steps to ensure that your device complies with corporate policies. This setup ensures that your device meets security requirements, such as encryption and data protection, and allows IT administrators to manage and secure your device remotely.



## Frequently Asked Questions

### What is the Microsoft Entra account registration page?

The Microsoft Entra account registration page is shown when you're trying to access protected resources through a browser. The page is where you decide if you want to add your account to the device. When a browser like Microsoft Edge or Google Chrome tries to access a protected resource, you see the Microsoft Entra account registration page requesting you to add your account to the device. Adding your account to the device gives you the ability to seamlessly sign in to all your browser-based apps. It also provides you with more security features.

### What does selecting "Yes" in the Microsoft Entra account registration page do?

Your account becomes accessible to web applications accessed through browsers that use your work or school account for sign-in. In many cases, these applications automatically use your work or school account without requiring any interaction, so you don't need to enter your credentials when you access them.

This device is also registered in your organization's directory. Once this device is registered, basic information about the device is exposed to other users in your organization.

> [!NOTE]
> Background activity that utilizes your work or school account often occurs on your device to provide various services. This activity can originate from applications, services, and scheduled tasks.

### What information can my organization see when I add my account to the device?
The following information about your device is exposed in your organization's directory. Other users in your organization might be able to see:

- Name of your device
- If your device is enabled
- Operating system and version number
- Join Type. For example: Microsoft Entra registered
- Device Owner's name
- Device Management Configuration
- Security settings management
- Device Compliance status
- Device Registration Date
- Last Active

### What is device management?

A device management solution lets the IT department of your organization manage security settings and applications on your personal or corporate device. It's how organizations make sure only devices that are up to date and configured with required security policies are able to access apps and resources.

### What can my administrator do if I enroll in device management?

Once enrolled in device management, an administrator can perform various operations, including:

- Install applications on devices
- Restrict access to specific operating systems
- Deploy and update software
- Configure device settings
- Enforce security policies
- Block personal devices
- Remove data from lost or stolen devices
- Secure and protect data on devices

### Why am I seeing the Microsoft Entra account registration page?

All organizational accounts are prompted to add their user account to the device when signing in through a browser. This solution offers convenience and more security. This page is where you decide if you want to add your account to the device or not. If your administrator requires device management, you get to decide if you want to enroll in device management on this page as well.

### What are the benefits of signing in through browsers on my device?

You're automatically signed in to web applications accessed through browsers with your organization's account. You're being compliant with your organization's policies, and you get more security features.

### Do my choices here apply to other devices I'm signed in to?

No, your choices on the Microsoft Entra account registration page apply to this device only.

### What is the difference between a desktop app and website?

- A desktop app is a software program that you access directly on the computer and it runs locally on the computer.

- A website is a combination of pages that you access via a browser, and it runs both in the cloud and inside your browser. A website has links to help you navigate through multiple pages.

## Administrator reference

[Conditional Access policies](../conditional-access/overview.md) are used by administrators to protect resources.

Applications configured to work with [Windows Web Account Manager](../../identity-platform/scenario-desktop-acquire-token-wam.md) authentication broker provide you with SSO and [other security features](../conditional-access/concept-token-protection.md).

All Microsoft Entra customers are prompted to sign in using Web Account Manager if the app and operating system support it.

Learn more about [device management with Microsoft Intune](/intune/intune-service/fundamentals/what-is-device-management).

## See also

- [macOS Platform Single Sign-on overview (preview)](../devices/macos-psso.md)