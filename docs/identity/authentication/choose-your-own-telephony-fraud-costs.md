---
title: Protect against telephony fraud with your own telecom provider
description: Configure provider fraud protections, destination and spending controls, secure your CYOT integration, monitor unusual activity, and respond to suspected fraud.
ms.topic: how-to
ms.date: 10/30/2026
ai-usage: ai-assisted

# Customer intent: As an identity administrator, I want to prevent telephony fraud and configure appropriate protections for my CYOT integration.
---

# Protect against telephony fraud with your own telecom provider

<a id="prevent-telephony-fraud-and-manage-costs"></a>
<a id="prevent-telephony-fraud-when-using-your-own-telecom-provider"></a>

With Choose Your Own Telephony Provider (CYOT), SMS and voice traffic runs through your own telecom provider account. You control the fraud protections, allowed destinations, and spending limits that match your organization's traffic and risk profile.

> [!IMPORTANT]
> Set up your provider's fraud and spending controls before you move production traffic to CYOT.

<a id="understand-the-shared-responsibility-model"></a>

## Shared responsibility

| Owner | Responsibility |
|---|---|
| Microsoft | Protects code generation and validation in Microsoft Entra ID, and the handoff to your endpoint. |
| Your organization | Manages the provider account, secures the integration, and configures fraud controls. |
| Telecom provider | Delivers SMS and voice, and offers fraud, destination, and spending controls. |

<a id="confirm-provider-controls"></a>
<a id="distinguish-alerts-from-spending-caps"></a>
<a id="configure-fraud-protections-with-your-telecom-provider"></a>

## Configure fraud protections with your provider

Work with your provider to turn on the controls available for your account:

- **Fraud protection:** Turn on the provider's detection for suspicious SMS and voice traffic.
- **Destination restrictions:** Allow only the countries and regions where your users are.
- **Channel restrictions:** Turn on only the channels you use.
- **Spending controls:** Set usage limits and budget alerts.
- **Notifications:** Turn on alerts for unusual activity.

> [!NOTE]
> Controls and defaults vary by provider. Ask your provider which protections are on by default and which you need to configure.

<a id="secure-your-cyot-integration"></a>

## Keep your integration secure

The setup script configures authentication and request validation for your Azure Function. Keep these settings in place, including when you customize the Function.

Your organization is responsible for renewing and rotating the integration's application credentials and certificates.

## Monitor for unusual activity

Review SMS and voice volume in your provider's usage reports. A sudden increase in volume, or traffic to destinations you don't expect, can signal fraud.

<a id="prepare-for-abuse-or-unexpected-spending"></a>
<a id="respond-to-suspected-telephony-fraud"></a>

## Respond to suspected fraud

1. Contact your telecom provider to review the affected traffic.
1. Restrict the affected destinations, channels, or usage with your provider's controls.
1. Investigate the requests using the Microsoft Entra audit logs, the Function App logs, and your provider's records.
1. Update your protections before you restore traffic.

<a id="check-operational-readiness"></a>

## Get support

| Issue | Contact |
|---|---|
| Fraud, provider account restrictions, delivery, or charges | Your telecom provider. Find contact details in the provider's [Microsoft Security Store](https://securitystore.microsoft.com/) listing. |
| Microsoft Entra authentication, code validation, or the handoff to your endpoint | Microsoft Support. See [Find help and get support for Microsoft Entra](/entra/fundamentals/how-to-get-support). |

<a id="estimate-provider-and-azure-charges-separately"></a>

## Related content

- [Set up SMS and voice with your own telecom provider by using APIs](how-to-set-up-sms-voice-api.md).
- [Monitor and troubleshoot SMS and voice with your own telecom provider](choose-your-own-telephony-troubleshoot.md#monitor-and-troubleshoot-your-own-telephony-provider).
- [Plan for resiliency and high availability](choose-your-own-telephony-reliability.md).
- [Estimate telecom provider and Azure hosting costs](phone-providers-faq.yml#how-much-does-choose-your-own-telephony-provider-cost).
- [Security Store](/security/store/what-is-security-store).
