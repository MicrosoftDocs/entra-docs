---
title: Microsoft Entra Multifactor Authentication Server Mobile App Web Service
description: Configure MFA server to send push notifications to users with the Microsoft Authenticator App.


ms.service: entra-id
ms.subservice: authentication
ms.topic: how-to
ms.date: 01/14/2025
ms.author: justinha
author: justinha
manager: amycolannino
ms.reviewer: jpettere
---
# Enable mobile app authentication with Microsoft Entra Multifactor Authentication Server

The Microsoft Authenticator app offers an extra out-of-band verification option. Instead of placing an automated phone call or SMS to the user during login, Microsoft Entra Multifactor Authentication pushes a notification to the Authenticator app on the user's smartphone or tablet. The user simply taps **Verify** (or enters a PIN and taps "Authenticate") in the app to complete their sign-in.

Using a mobile app for two-step verification is preferred when phone reception is unreliable. If you use the app as an OATH token generator, it doesn't require any network or internet connection.

> [!IMPORTANT]
> In September 2022, Microsoft announced deprecation of Azure Multi-Factor Authentication Server. Beginning September 30, 2024, Azure Multi-Factor Authentication Server deployments will no longer service multifactor authentication requests, which could cause authentications to fail for your organization. To ensure uninterrupted authentication services and to remain in a supported state, organizations should [migrate their users’ authentication data](how-to-migrate-mfa-server-to-mfa-user-authentication.md) to the cloud-based Microsoft Entra Multifactor Authentication service by using the latest Migration Utility included in the most recent [Microsoft Entra Multifactor Authentication Server update](https://www.microsoft.com/download/details.aspx?id=55849). For more information, see [Microsoft Entra Multifactor Authentication Server Migration](how-to-migrate-mfa-server-to-azure-mfa.md).  

> To get started with cloud-based MFA, see [Tutorial: Secure user sign-in events with Microsoft Entra Multifactor Authentication](tutorial-enable-azure-mfa.md).


> [!IMPORTANT]
> If you have installed Microsoft Entra Multifactor Authentication Server v8.x or higher, most of the steps below are not required. Mobile app authentication can be set up by following the steps under [Configure the mobile app](#configure-the-mobile-app-settings-in-mfa-server).

## Requirements

To use the Authenticator app, you must be running Microsoft Entra Multifactor Authentication Server v8.x or higher

## Configure the mobile app settings in MFA Server

1. In the MFA Server console, select the **User Portal** icon. If users are allowed to control their authentication methods, check **Mobile App** on the Settings tab, under **Allow users to select method**. Without this feature enabled, end users are required to contact your Help Desk to complete activation for the Mobile App.
2. Check the **Allow users to activate Mobile App** box.
3. Check the **Allow User Enrollment** box.
4. Click the **Mobile App** icon.
5. Populate the **Account name** field with the company or organization name to display in the mobile application for this account.
   ![MFA Server configuration Mobile App settings](./media/howto-mfaserver-deploy-mobileapp/mobile.png)

## Next steps

- [Advanced scenarios with Microsoft Entra Multifactor Authentication Server and third-party VPNs](howto-mfaserver-nps-vpn.md).
