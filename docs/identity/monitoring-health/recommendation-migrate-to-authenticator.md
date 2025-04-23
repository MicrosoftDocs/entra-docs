---
title: Recommendation to migrate to Microsoft authenticator
description: Learn the importance of migrating your users to the Microsoft authenticator app in Microsoft Entra ID.

author: shlipsey3
manager: femila
ms.service: entra-id
ms.topic: how-to
ms.subservice: monitoring-health
ms.date: 04/09/2025
ms.author: sarahlipsey
ms.reviewer: deawari

# Customer intent: As an IT admin, I want to make sure that my users are using the most secure multi-factor authentication method available in Microsoft Entra ID.
---

# Microsoft Entra recommendation: Migrate to Microsoft Authenticator (preview)

[Microsoft Entra recommendations](overview-recommendations.md) is a feature that provides you with personalized insights and actionable guidance to align your tenant with recommended best practices.

This article covers the recommendation to migrate users to the Microsoft Authenticator app, which is currently a preview recommendation. This recommendation is called `useAuthenticatorApp` in the recommendations API in Microsoft Graph.

## Description

Multifactor authentication (MFA) is a key component to improve the security posture of your Microsoft Entra tenant. While SMS text and voice calls were once commonly used for multifactor authentication, they're becoming increasingly less secure. You also don't want to overwhelm your users with lots of MFA methods and messages.

One way to ease the burden on your users is to migrate anyone using SMS or voice call for MFA to use the Microsoft Authenticator app. This strategy also increases the security of their authentication methods.

This recommendation appears if Microsoft Entra ID detects that your tenant has users authenticating using SMS or voice instead of the Microsoft Authenticator app in the past week.

## Value 

Push notifications through the Microsoft Authenticator app provide the least intrusive MFA experience for users. This method is the most reliable and secure option because it relies on a data connection rather than telephony.

The verification code option enables MFA even in isolated environments without data or cellular signals, where SMS and Voice calls might not work.

The Microsoft Authenticator app is available for Android and iOS. Microsoft Authenticator can serve as a traditional MFA factor (one-time passcodes, push notification) and when your organization is ready for Password-less, the Microsoft Authenticator app can be used to sign in to Microsoft Entra ID without a password.

## Action plan

1. Ensure that notification through mobile app and/or verification code from mobile app are available to users as authentication methods. How to Configure Verification Options

2. Educate users on how to add a work or school account. 

## Related content

- [Review the Microsoft Entra recommendations overview](overview-recommendations.md)
- [Learn how to use Microsoft Entra recommendations](howto-use-recommendations.md)
- [Explore the Microsoft Graph API properties for recommendations](/graph/api/resources/recommendation)
