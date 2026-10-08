---
# Required metadata
# For more information, see https://learn.microsoft.com/en-us/help/platform/learn-editor-add-metadata
# For valid values of ms.service, ms.prod, and ms.topic, see https://learn.microsoft.com/en-us/help/platform/metadata-taxonomies

title: Manage preferences for Microsoft Single Sign-on for macOS
description: This article helps users understand what preferences are within the Microsoft Single Sign-On for macOS app, and what each setting does
author:      ploegert # GitHub alias
ms.author:   jploegert # Microsoft alias
ms.service: entra-id
ms.topic: ui-reference
ms.date:     06/30/2026
manager: asteen
---
# Manage preferences Entra Id for macOS

Select your preferences for single sign-on and in-app data collection in Microsoft Single Sign-on for macOS. To access your preferences:

1. Open Microsoft single sign on for macOS the app.

1. Go to the menu bar and select **Advanced**.

## Single sign-on

Single sign-on (SSO) configures your work or school account so that you only have to authenticate once to access all cloud-based work apps and services. Preferences include:

* **Register device**: Register your device to enable SSO and gain access to protected resources. This setting is only available on devices enabled for platform SSO.

* **Deregister**: Remove device registration and disable SSO. To access protected resources again on this device, you must reregister. This setting is only available on devices enabled for platform SSO.

* **Remove account from this device**: Remove your work or school account and any SSO authentication tokens from the device.

To opt out of SSO on your Mac, select the checkbox next to **Don't ask me to sign in with single sign-on for this device**.

## Send usage data to Microsoft

This setting enables Microsoft to collect data about your Intune Company Portal usage. When the checkbox is selected, your in-app performance and usage data are automatically anonymized and shared with Microsoft to help improve the reliability and performance of our products. Your organization doesn't have control over the collection of this data and cannot change your preference.

To turn off data collection in Company Portal, deselect the checkbox next to **Allow Microsoft to collect usage data**.

## Advanced logging

Select the checkbox next to **Turn on advanced logging** to turn on verbose logging, which is used for troubleshooting, for Microsoft Single Sign-on for macOS and MSAL.  Microsoft Single Sign-on for macOS logs certificate usage and network responses when advanced logging is turned on. Advanced logging is turned off by default. Keep this setting turned off unless otherwise instructed by your organization's IT administrator.

## Next steps

Still need help? Contact your IT support person. 