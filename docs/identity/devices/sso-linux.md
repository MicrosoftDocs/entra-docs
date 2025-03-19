---
# Required metadata
# For more information, see https://review.learn.microsoft.com/en-us/help/platform/learn-editor-add-metadata?branch=main
# For valid values of ms.service, ms.prod, and ms.topic, see https://review.learn.microsoft.com/en-us/help/platform/metadata-taxonomies?branch=main

title:       # Add a title for the browser tab
description: # Add a meaningful description for search results
author:      ploegert # GitHub alias
ms.author:   jploegert # Microsoft alias
ms.service:  # Add the ms.service or ms.prod value
# ms.prod:   # To use ms.prod, uncomment it and delete ms.service
ms.topic:    # Add the ms.topic value
ms.date:     03/18/2025
---

# Microsoft Single Sign-on to Linux


Microsoft Single Sign-on for Linux is powered by a component that can be installed onto a Linux device that integrates with Microsoft Entra Id to enable users to use their Microsoft Entra ID credentials to login to other apps without being prompted for credentials each time a resource is accessed. This feature provides benefits for admins by simplifying the sign-in process for users and reducing the number of passwords they need to remember. 

## Features

This feature empowers users on Linux desktop clients to register their devices with Entra Id, enroll into Intune management, and satisfy device-based conditional access policies when accessing their corporate resources.

- Azure AD registration & enrollment of Linux desktops

- Provide SSO capabilities for native & web applications (ex: Azure CLI, Edge Browser, Teams PWA, etc) to access M365/Azure protected resources

- It provides SSO for Microsoft Entra accounts across all applications that utilize MSAL.net or MSAL.python - enabling customers to leverage MSAL to integrate SSO into custom apps.

- Conditional Access policies protecting web applications via Microsoft Edge

- Standard compliance policies

- Support for Bash scripts for custom compliance policies

 

The Teams web application and a new PWA(Progressive Web App) for Linux will use the Conditional Access configuration, applied through Microsoft Intune Manager, to enable Linux users to access the Teams web application using Edge in a secure way. This helps organizations use an industry-leading, unified endpoint management solution for Teams from Linux endpoints with security and quality in mind.

There are several authentication methods that determine the end-user experience.

* **Platform Credential for macOS**: Provisions a secure enclave backed hardware-bound cryptographic key that is used for SSO across apps that use Microsoft Entra ID for authentication. The user’s local account password is not affected and is required to log on to the Mac.
* **Smart card**: The user signs in to the machine using an external smart card, or smart card-compatible hard token (for example, Yubikey). Once the device is unlocked, the smart card is used with Microsoft Entra ID to grant SSO across apps that use Microsoft Entra ID for authentication.
* **Password as authentication method**: Syncs the user’s Microsoft Entra ID password with the local account and enables SSO across apps that use Microsoft Entra ID for authentication.


## Requirements

To deploy Platform SSO for macOS, you need the meet following minimum requirements.

* A recommended minimum version of macOS 14 Sonoma. While macOS 13 Ventura is supported, we strongly recommend using macOS 14 Sonoma for the best experience.
* [Microsoft Authenticator](https://support.microsoft.com/account-billing/how-to-use-the-microsoft-authenticator-app-9783c865-0308-42fb-a519-8cf666fe0acc)

* Microsoft Intune [Company Portal app](/mem/intune/apps/apps-company-portal-macos) version 5.2404.0 or later installed. This version is required before users are targeted for PSSO.

## Configuration

You can find more information and instructions on how to configure in these articles:

- [Configure Platform SSO for macOS devices in Microsoft Intune](/mem/intune/configuration/platform-sso-macos)

## Deployment

For more information, see the following in Intune documentation:

- [Deployment guide: Manage Linux devices in Microsoft Intune](/mem/intune-service/fundamentals/deployment-guide-platform-linux)

- [Enrollment guide: Enroll Linux desktop devices in Microsoft Intune](/mem/intune-service/fundamentals/deployment-guide-enrollment-linux).

## Troubleshooting 

If you experience issues when implementing macOS Platform SSO, refer to our documentation on [macOS Platform single sign-on known issues and troubleshooting](troubleshoot-macos-platform-single-sign-on-extension.md)
