---
title: Troubleshoot SMS and voice call problems with multifactor authentication (MFA)
description: Learn how to troubleshoot SMS and voice call problems with multifactor authentication (MFA).
ms.topic: how-to
ms.date: 02/25/2026
author: justinha
ms.reviewer: xueca
# Customer intent: As an authentication administrator, I want to learn how to troubleshoot SMS and voice call problems with multifactor authentication (MFA) for Microsoft Entra ID.
---
# Troubleshoot voice call and SMS problems with multifactor authentication (MFA)

This topic covers how to investigate and resolve problems with SMS or voice call sign-in methods for multifactor authentication (MFA).

This topic includes standardizes messages for support engineers and customers to begin and conclude investigation as well as conclusion of the investigation.

## FAQs

**Question:** Why didn't I receive a call or text message?  

**Answer:** Voice calls and SMS messages aren't reliable or guaranteed. In addition, voice call and SMS providers use other providers, who in turn use other providers. This practice increases the time required to investigate a problem. 

To help Microsoft support investigate provider related issues, you need to submit a Correlation ID and timestamp for the sign ins that need investigation. You can find the Correlation ID and timestamp for the sign in the sign-in logs. The sign-in logs must be 48 hours old or less. 

Microsoft support gives the Correlation ID and timestamp to the provider and asks for an investigation. The provider checks their logs. If they don't find a problem, they need to make a query to a downlevel partner, which can use other providers. As a result, investigation can take up to 4 weeks. 

As a workaround, use other methods, such as passkey (FIDO2) or Microsoft Authenticator.

## Related content

- [Voice call authentication method in Microsoft Entra ID](concept-authentication-phone-options.md)
- [Configure and enable users for SMS-based authentication using Microsoft Entra ID](howto-authentication-sms-signin.md)