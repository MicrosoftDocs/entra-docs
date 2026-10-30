---
title: Plan for resiliency and high availability
description: Plan CYOT resiliency with multi-region Azure Functions, Azure Front Door, a secondary telecom provider, and failover and recovery testing.
ms.topic: concept-article
ms.date: 10/30/2026
ai-usage: ai-assisted

# Customer intent: As an identity administrator, I want to plan and test regional and telecom provider resiliency for my CYOT integration.
---

<a id="plan-telephony-reliability-and-recovery"></a>
<a id="plan-for-resiliency-when-using-your-own-telecom-provider"></a>

# Plan for resiliency and high availability

SMS and voice authentication sit on the critical path to your applications. When users rely on a phone code for multifactor authentication (MFA) or self-service password reset (SSPR), the availability of that code determines whether they can sign in.

With Choose Your Own Telephony Provider (CYOT), the delivery path includes components your organization owns: the Azure Function in your subscription and your telecom provider. Design these components for resiliency so authentication stays available through regional outages and provider incidents.

<a id="establish-an-operational-baseline"></a>

## Understand your delivery path

| Component | Managed by | What it does |
|---|---|---|
| Microsoft Entra ID | Microsoft | Generates and validates the code, and sends the request to your endpoint. |
| Endpoint and Azure Function | Your organization | Receives the request in your Azure subscription and sends it to your provider. |
| Telecom provider | Your provider | Delivers the SMS message or voice call to the user's phone. |

The guided setup creates one Azure Function in a single region, connected to one telecom provider. This setup works well for evaluation and many production workloads. To protect against a regional outage or a provider incident, extend it with the options in this article.

> [!IMPORTANT]
> Your organization manages the availability and recovery of the Azure resources and provider integration in your subscription. Test your resiliency design before you rely on it for production authentication.

> [!NOTE]
> The multi-region and secondary-provider designs in this article are sample-only guidance. They aren't part of the standard deployment. Your organization is responsible for validating and maintaining these customizations.

<a id="evaluate-advanced-designs-separately"></a>

## Choose a resiliency approach

Start with your requirements: which disruptions you must withstand, how quickly authentication must recover, and the sign-in availability your organization requires. Then choose the approach that meets them.

| Approach | Protects against | When to use it |
|---|---|---|
| Single region, one provider (default setup) | Function App instance failures within the region | Evaluation, and production workloads that can tolerate a regional outage |
| Multi-region with Azure Front Door | Regional outages | Production workloads that require authentication during a regional disruption |
| Secondary telecom provider | Provider-specific incidents | When your primary provider alone doesn't meet your availability or coverage requirements |
| Multi-region and secondary provider | Regional outages and provider incidents | Organizations with the highest availability requirements |

<a id="plan-for-regional-resiliency"></a>

## Deploy across multiple regions

A multi-region deployment uses Azure Front Door to expose one endpoint backed by Function Apps in two or more regions. Microsoft Entra ID calls the Front Door endpoint, and Front Door routes each request to a healthy region. Set it up manually after you validate a single-region deployment, because the setup script in [Set up SMS and voice with your own telecom provider by using APIs](how-to-set-up-sms-voice-api.md) deploys one region at a time.

When you plan a multi-region deployment:

- **Size each region for the full workload.** If one region is unavailable, the remaining regions must handle all authentication traffic.
- Use the same code, settings, and encryption key in every region, and coordinate certificate renewal across regions.
- **Expect failover to take time.** Some requests can fail while Front Door detects an unhealthy region and shifts traffic.
- **Plan for added cost.** Each region adds its own Function App plan, storage, Key Vault, and monitoring, plus Front Door. For estimates, see [Estimate telecom-provider and Azure hosting costs](https://github.com/Azure-Samples/ExternalPhoneProvider-AzureFunction-Sample/blob/main/docs/COST-CALCULATOR.md).
- Adding regions improves availability, not delivery speed. SMS and voice delivery time depends mostly on your provider and carriers.

For architecture, region and capacity planning, and step-by-step setup, see [Azure Front Door multi-region deployment](https://github.com/Azure-Samples/ExternalPhoneProvider-AzureFunction-Sample/blob/main/docs/FRONTDOOR.md).

<a id="plan-for-telecom-provider-resiliency"></a>
<a id="handle-uncertain-send-outcomes"></a>
<a id="use-provider-fallback-carefully"></a>

## Add a secondary telecom provider

A multi-region deployment still relies on your telecom provider. Confirm that your provider's availability commitments, redundancy, and disaster recovery meet your requirements in the countries you serve.

If one provider isn't enough, you can implement fallback to a secondary provider in your Azure Function. To avoid sending a user two codes, use the secondary provider only when the primary provider confirms it didn't accept the request. Don't resend after a timeout or unknown result, because the primary provider might already have sent the code.

For the fallback design, see [Secondary-provider design](https://github.com/Azure-Samples/ExternalPhoneProvider-AzureFunction-Sample/blob/main/docs/MULTI-PROVIDER-IMPLEMENTATION.md).

<a id="own-certificate-and-credential-changes"></a>
<a id="prepare-a-recovery-runbook"></a>
<a id="test-your-resiliency-plan"></a>

## Test failover and recovery

Before production use, test your design in a nonproduction environment:

- Take one region or provider offline, and confirm that traffic moves to the healthy one and that it handles the full workload.
- Confirm that timeouts and unknown provider results don't trigger a second send.
- Restore the failed component, and confirm that traffic returns without errors or duplicate messages.
- Confirm that users complete SMS and voice authentication after each failover and recovery, and measure recovery time against your targets.

Evaluation mode doesn't call your provider. Repeat your tests after any change to code, routing, configuration, or your provider integration.

To monitor each region and provider, see [Monitor and troubleshoot SMS and voice with your own telecom provider](troubleshoot-voice-call-sms.md#monitor-and-troubleshoot-your-own-telephony-provider).

## Related content

- [CYOT sample documentation](https://github.com/Azure-Samples/ExternalPhoneProvider-AzureFunction-Sample/tree/main/docs).
- [Azure Front Door multi-region deployment](https://github.com/Azure-Samples/ExternalPhoneProvider-AzureFunction-Sample/blob/main/docs/FRONTDOOR.md).
- [Secondary-provider design](https://github.com/Azure-Samples/ExternalPhoneProvider-AzureFunction-Sample/blob/main/docs/MULTI-PROVIDER-IMPLEMENTATION.md).
- [Reliability in Azure Functions](/azure/reliability/reliability-functions).
- [Set up SMS and voice with your own telecom provider by using APIs](how-to-set-up-sms-voice-api.md).
- [Prevent telephony fraud when using your own telecom provider](choose-your-own-telephony-fraud-costs.md).
- [Monitor and troubleshoot SMS and voice with your own telecom provider](troubleshoot-voice-call-sms.md#monitor-and-troubleshoot-your-own-telephony-provider).
- [CYOT sample documentation (epp-packages-193-1)](https://github.com/Azure-Samples/ExternalPhoneProvider-AzureFunction-Sample/tree/epp-packages-193-1/docs).
- [Optional multi-region onboarding with Azure Front Door (epp-packages-193-1)][sample-regions].
- [Multi-provider implementation (epp-packages-193-1)][sample-fallback].

[sample-regions]: https://github.com/Azure-Samples/ExternalPhoneProvider-AzureFunction-Sample/blob/epp-packages-193-1/docs/FRONTDOOR.md
[sample-fallback]: https://github.com/Azure-Samples/ExternalPhoneProvider-AzureFunction-Sample/blob/epp-packages-193-1/docs/MULTI-PROVIDER-IMPLEMENTATION.md
