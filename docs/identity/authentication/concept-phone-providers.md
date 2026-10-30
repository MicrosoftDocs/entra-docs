---
title: Choose your own telephony provider for SMS and voice authentication
description: Learn how CYOT works, available telecom providers, and how to plan setup, fraud protection, resiliency, and costs.
ms.topic: concept-article
ms.date: 10/30/2026
ai-usage: ai-assisted

# Customer intent: As an identity administrator, I want to understand Choose Your Own Telephony Provider so that I can plan continued use of SMS or voice authentication.
---

<a id="choose-a-telephony-provider-for-sms-and-voice-authentication"></a>

# Choose your own telephony provider for SMS and voice authentication

Choose Your Own Telephony Provider (CYOT) lets your organization use a supported telecom provider to deliver SMS and voice authentication for Microsoft Entra ID.

With CYOT, Microsoft Entra continues to manage the authentication experience, including one-time passcode (OTP) generation and validation, while SMS messages and voice calls are delivered through the telecom provider that your organization selects and configures.

CYOT gives your organization more control over telecom provider selection, geographic coverage, pricing, and telecom delivery.

> [!IMPORTANT]
> Microsoft recommends phishing-resistant authentication methods, such as [passkeys](concept-authentication-passkeys-fido2.md), instead of SMS or voice. Use a telephony provider only for user populations that have a business, regulatory, or technical requirement for telephony-based authentication.

<a id="how-choose-your-own-telephony-provider-works"></a>

## How CYOT works

When SMS or voice authentication is required:

1. Microsoft Entra initiates the authentication request.
1. Microsoft Entra sends the request to the CYOT integration deployed in your Azure subscription.
1. The integration sends the request to your configured telecom provider.
1. Your telecom provider delivers the SMS message or voice call to the user.
1. Microsoft Entra completes the authentication flow.

The Azure Function deployed in your subscription connects Microsoft Entra with your telecom provider.

:::image type="content" source="media/concept-phone-providers/cyot-integration.jpeg" alt-text="Simplified CYOT architecture diagram showing Microsoft Entra connected to a telecom provider through an Azure Function in your Azure subscription." lightbox="media/concept-phone-providers/cyot-integration.jpeg":::

## Available telephony providers

Select a supported telecom provider based on your organization's coverage, pricing, and other requirements.

Review pricing and other commercial details for the available provider offers:

- Soprano: [Per-user offer](https://securitystore.microsoft.com/solutions/sopranodesignlimited1620113206416.soprano_entraid_per_user) or [per-transaction offer](https://securitystore.microsoft.com/solutions/sopranodesignlimited1620113206416.soprano_entraid_per_transaction) in [Microsoft Security Store](https://securitystore.microsoft.com/).
- Telesign: [Telesign Verify for Microsoft Entra](https://securitystore.microsoft.com/solutions/telesigncorporation1779799505747.telesign-verify-cyot-azure) in [Microsoft Security Store](https://securitystore.microsoft.com/).
- Infobip (coming soon).

> [!NOTE]
> Provider availability, coverage, pricing, and commercial terms can vary. Review the provider's [Microsoft Security Store](https://securitystore.microsoft.com/) listing for the latest information before purchasing.

## Understand your responsibilities

With CYOT, your organization owns the Azure resources deployed in your subscription and your telecom provider account, so you keep full control over how they run. The guided deployment sets up the integration for you, and your team manages the Azure Function and provider account from there.

| Owner | Responsibilities |
|---|---|
| Microsoft | Microsoft Entra authentication and the handoff to your endpoint. |
| Customer | Deploying and operating the integration, managing the telecom provider account, and configuring fraud controls. |
| Telephony provider | SMS and voice delivery, and offering fraud controls. |

## Get started with CYOT

At a high level, setting up CYOT involves:

1. **Subscribe to a telecom provider.** Review the available provider offers in [Microsoft Security Store](https://securitystore.microsoft.com/) and purchase the offer that meets your organization's requirements.
1. **Set up the provider integration.** Deploy the integration in your Azure subscription and connect it to your provider.
1. **Create an SMS or voice profile.** Route SMS or voice authentication through your provider.
1. **Evaluate.** Validate the integration while Microsoft continues to deliver messages, so users aren't affected.
1. **Roll out.** Move traffic to your provider gradually, validating at each stage.

For detailed instructions, see [Set up SMS and voice with your own telecom provider by using APIs](how-to-set-up-sms-voice-api.md).

<a id="plan-your-choose-your-own-telephony-provider-deployment"></a>

## Plan your deployment

Before moving production authentication traffic to CYOT, consider fraud protection, resiliency, and costs based on your organization's requirements.

### Prevent telephony fraud

Work with your telecom provider to configure the fraud protection, destination, usage, and spending controls appropriate for your organization's traffic and risk requirements.

See [Prevent telephony fraud when using your own telecom provider](choose-your-own-telephony-fraud-costs.md).

### Plan for resiliency

Plan the availability and recovery of the Azure resources and telecom provider used by your CYOT integration.

Organizations with additional availability requirements can implement cross-region resiliency and, where appropriate, configure provider redundancy.

See [Plan for resiliency when using your own telecom provider](choose-your-own-telephony-reliability.md).

### Understand costs

CYOT can involve two separate categories of costs:

- Telecom provider costs for SMS and voice delivery through your selected provider.
- Azure costs for the Azure Function and supporting resources deployed in your subscription.

Review both before moving production authentication traffic to CYOT.

See [Estimate telecom-provider and Azure hosting costs](phone-providers-faq.yml#how-much-does-choose-your-own-telephony-provider-cost).

## Troubleshoot CYOT

To diagnose SMS or voice issues, identify whether the issue is in Microsoft Entra authentication and configuration, your CYOT integration, or telecom provider delivery.

See [Troubleshoot SMS and voice with your own telecom provider](troubleshoot-voice-call-sms.md#monitor-and-troubleshoot-your-own-telephony-provider) for diagnostic guidance and information about where to get support.

<a id="next-steps"></a>

## Related content

- [Set up SMS and voice with your own telecom provider by using APIs](how-to-set-up-sms-voice-api.md).
- [Prevent telephony fraud when using your own telecom provider](choose-your-own-telephony-fraud-costs.md).
- [Plan for resiliency when using your own telecom provider](choose-your-own-telephony-reliability.md).
- [Troubleshoot SMS and voice with your own telecom provider](troubleshoot-voice-call-sms.md#monitor-and-troubleshoot-your-own-telephony-provider).
- [Estimate telecom-provider and Azure hosting costs](phone-providers-faq.yml#how-much-does-choose-your-own-telephony-provider-cost).
- [Passkeys by default and retirement of Microsoft-provided SMS and voice authentication](concept-sms-voice-retirement.md).
- [SMS-based authentication for Microsoft Entra ID](howto-authentication-sms-signin.md).
