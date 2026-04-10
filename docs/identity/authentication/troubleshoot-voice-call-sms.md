---
title: Troubleshoot MFA voice call and SMS problems
description: Learn how to troubleshoot voice call and SMS problems with MFA, understand telecom delivery, and help Microsoft Support investigate delivery issues.
ms.topic: how-to
ms.date: 04/09/2026
ms.custom: msecd-doc-authoring-108
author: justinha
ms.reviewer: xueca
# Customer intent: As an authentication administrator, I want to troubleshoot voice call and SMS problems with multifactor authentication (MFA) for Microsoft Entra ID.
---
# Troubleshoot MFA voice call and SMS problems

This article explains how to investigate and resolve problems with voice call or SMS sign-in methods for multifactor authentication (MFA). It explains how telecom delivery works behind the scenes, what Microsoft can and cannot see, and what to expect during an investigation.

## How global telecom delivery works

Microsoft works with primary telecom providers that have global reach. These providers rely on their own networks of suppliers, who control the routes for SMS and voice calls through local end-carrier networks. This chain represents thousands of individual carriers and routes around the globe.

Microsoft maintains robust processes to help ensure the successful delivery of every SMS and voice MFA request. However, once a request leaves the Microsoft network, delivery is delegated to external telecom providers. These providers often share the same end routes and carriers in a given destination country, but may operate under different contractual agreements or traffic priorities. As a result, routing a request through a different provider doesn't always resolve the issue—the new request may follow the same downstream path and encounter the same obstacle.

## The journey of an SMS or voice MFA request

When you sign in and an MFA challenge is triggered, Microsoft is able to confirm the following steps given a Correlation ID and timestamp:

1. **Request received.** Microsoft receives the MFA request and constructs the payload for the SMS or voice request with the expected Microsoft or company branding.
1. **Provider selected.** Microsoft sends the request to a selection of external third-party telecom providers matching your country code.
1. **Channel matched.** The request is routed through the correct channel (SMS or voice) per your request and policy requirements.
1. **Delivery confirmed.** The provider confirms receipt of the telecom request and marks it as successfully delivered with no alterations.

After step 4, the request enters external telecom networks where Microsoft doesn't have direct visibility. Problems that occur beyond this point require collaboration with the provider to investigate.

## What can go wrong after delivery to the provider

After the request reaches an external telecom provider, two types of problems can occur.

### The call or message is dropped or blocked

The provider should confirm this to Microsoft. Common causes include:

- **Device-level configuration.** Even when all steps to send the message are correct, the device itself could refuse the call or route it to voicemail. Microsoft automatically retries these failures across different providers.
- **Carrier-level blocking.** The carrier might block the call or message due to international automated fraud detection systems.
- **Regional availability issues.** In rare cases, the message is dropped due to availability issues in a specific country. Microsoft and its providers have robust retry and reroute mechanisms for these scenarios and post automated outage communications when the impact is broadly reported.

### The call or message is altered by a downstream carrier

Because the provider already confirmed delivery, Microsoft can only see a successful delivery per its specification. In these cases:

- The customer should provide evidence that the message received on their device didn't appear with the expected branding or channel.
- Microsoft collaborates with the provider to understand the end-carrier behavior taken on behalf of the request.
- The provider will likely correct the route for the affected country code or phone number to avoid carriers that aren't honoring the original message contract.

## What to expect during an investigation

Due to the complexity and visibility constraints described previously, telecom delivery investigations involve coordination across multiple companies and stakeholders.

### Timeline

Investigations into downstream customer-reported delivery issues can take 4–6 weeks. The provider checks their logs and, if no issue is found locally, queries downstream partners who may use additional providers.

### Root cause analysis (RCA) policy

Microsoft doesn't publish RCAs for issues that originate with external telecom providers. Carriers often don't share root cause details with Microsoft due to international visibility and competitive agreements.

## Help with the investigation

To help Microsoft Support investigate provider-related issues:

- **Submit a Correlation ID and timestamp** for the sign-ins that need investigation. You can find these in the [sign-in logs](~/identity/monitoring-health/concept-sign-ins.md). The Correlation ID returns all Request IDs associated with the sign-in.

  :::image type="content" source="media/troubleshoot-voice-call-sms/sign-in-log-correlation-id.png" alt-text="Screenshot that shows the Date and Correlation ID fields in the sign-in logs in the Microsoft Entra admin center." lightbox="media/troubleshoot-voice-call-sms/sign-in-log-correlation-id.png":::

- **Provide fresh samples.** End carriers often require Correlation IDs from the last 48–72 hours. Older requests may not propagate to the final end carrier in time for investigation. You may be asked to provide multiple samples.
- **Provide evidence of altered messages.** If the message you received didn't appear with the expected branding or channel, share a screenshot or description of what you received.

## Move to modern, phishing-resistant authentication

> [!IMPORTANT]
> Microsoft is committed to helping organizations adopt modern, phishing-resistant authentication methods. While telecom-based MFA provides an important layer of security, methods like passkeys, the Microsoft Authenticator app, and Windows Hello for Business offer stronger protection against interception and social engineering attacks. These methods also avoid the delivery variability inherent in global telecom networks. Microsoft recommends transitioning to these more secure alternatives:
>
> - [Microsoft Authenticator](concept-authentication-authenticator-app.md)
> - [Passkeys (FIDO2)](concept-authentication-passwordless.md#fido2-security-keys)
> - [Windows Hello for Business](/windows/security/identity-protection/hello-for-business/)

## Related content

- [Voice call authentication method in Microsoft Entra ID](concept-authentication-phone-options.md)
- [Configure and enable users for SMS-based authentication using Microsoft Entra ID](howto-authentication-sms-signin.md)