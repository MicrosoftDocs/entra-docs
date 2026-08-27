---
title: Choose a telephony provider for SMS and voice authentication
description: Learn about Choose Your Own Telephony Provider for SMS and voice authentication in Microsoft Entra ID.
ms.topic: concept-article
ms.date: 08/05/2026
ai-usage: ai-generated

# Customer intent: As an identity administrator, I want to understand Choose Your Own Telephony Provider so that I can plan continued use of SMS or voice authentication.
---

# Choose a telephony provider for SMS and voice authentication

Microsoft Entra ID will support Choose Your Own Telephony Provider, which lets organizations continue using SMS or voice authentication with a supported telephony provider. You select a telephony provider through the Microsoft Security Store and manage the provider relationship for your organization.

Microsoft recommends phishing-resistant authentication methods, such as [passkeys](concept-authentication-passkeys-fido2.md), instead of SMS or voice. Use a telephony provider only for user populations that have a business, regulatory, or technical requirement for telephony-based authentication.

> [!IMPORTANT]
> Choose Your Own Telephony Provider isn't available to configure yet. Provider information becomes available beginning September 18, 2026, and configuration becomes available beginning October 30, 2026.

## How Choose Your Own Telephony Provider works

Your selected telephony provider delivers the SMS messages or voice calls that users need to complete authentication. Microsoft Entra ID continues to enforce your authentication method policies and coordinates the authentication experience.

Your organization is responsible for selecting a telephony provider, reviewing its regional coverage and terms, completing the provider agreement, configuring the provider for Microsoft Entra ID, and monitoring the service.

For the full transition schedule, see [Passkeys by default and retirement of Microsoft-provided SMS and voice authentication](concept-sms-voice-retirement.md).

## Plan your Choose Your Own Telephony Provider deployment

Before you select a provider:

- Identify the users who have a documented requirement for SMS or voice authentication.
- Confirm that a phishing-resistant method doesn't meet the requirement.
- Compare supported telephony providers based on geographic coverage, supported delivery channels, pricing, support, security, and compliance capabilities.
- Review procurement, privacy, and regulatory requirements with the appropriate teams in your organization.

## Next steps

- [Review frequently asked questions about telephony providers](phone-providers-faq.yml).
- [Prepare for the retirement of Microsoft-provided SMS and voice authentication](concept-sms-voice-retirement.md).
- [Plan a passkey deployment](how-to-deploy-phishing-resistant-passwordless-authentication.md).
- [Review voice call authentication](concept-authentication-phone-options.md).
