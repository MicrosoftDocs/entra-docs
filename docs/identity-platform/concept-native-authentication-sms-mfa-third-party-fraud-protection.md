---
title: Third-party fraud protection for native authentication with SMS MFA
description: Learn how third-party fraud protection integrates with native authentication flows to assess risk and protect SMS-based multifactor authentication from account takeover threats.
author: henrymbuguakiarie
manager: pmwongera
ms.author: henrymbugua
ms.date: 02/19/2026
ms.service: identity-platform
ms.topic: concept-article
#Customer intent: As a software developer, I want to understand how third-party fraud protection integrates with native authentication flows to assess risk and protect SMS-based multifactor authentication from account takeover threats.
---

# Secure SMS MFA in native authentication with third‑party fraud protection

Native authentication allows you to have full control over the design of your mobile and desktop application sign-in experience. While this model provides flexibility and control over the user experience, it also introduces fraud prevention risks, especially for SMS-based multifactor authentication (MFA).

This article explains the fraud risks associated with native authentication, then provides guidance for integrating third-party fraud protection solutions to secure native authentication applications.

## Fraud risk in native authentication

Microsoft Entra provides baseline fraud protections for native authentication application, including:

- Regional blocking for known high‑fraud regions
- Basic throttling of SMS one‑time passcode (OTP) requests
- A phone number reputation signal

Native authentication applications that use SMS‑based MFA remain exposed to extra risks, including:

- **International Revenue Share Fraud (IRSF)** which occurs when attackers artificially inflate SMS traffic to premium‑rate international destinations in order to extract revenue through telecom termination and revenue‑sharing mechanisms.
- **Account takeover (ATO)** which occurs when attackers use automated, scripted techniques to initiate sign‑in attempts with valid‑looking credentials, causing the system to issue SMS verification challenges as if the activity were legitimate.

In browser‑delegated authentication flows, Microsoft Entra mitigates these risks by using rich device telemetry and CAPTCHA challenges. Native authentication applications don't use the Microsoft‑hosted, browser‑delegated sign‑in experience, so the risk profiling doesn't benefit from rich device telemetry. Because of this, native authentication scenarios that use SMS by default are less protected by extensive risk profiling than browser-delegated flows. Customers are therefore recommended to set up additional risk detection and protection using third party providers.

To effectively mitigate fraud in native authentication scenarios that use SMS:

- Native authentication applications owners must implement extra fraud detection and mitigation
- Fraud decisions must occur before SMS one‑time passcodes (OTPs) are sent
- Third‑party fraud providers assess risk using device, behavioral, and network signals collected outside of Microsoft Entra

## Recommended fraud prevention architecture

Microsoft recommends a high-level architecture for securing native authentication applications that user SMS-based MFA consisting of the native authentication applications, third-party fraud protection provider, web application firewall (WAF), and Microsoft Entra.

The third-party fraud protection provider evaluates risk before an SMS MFA challenge is issued. By incorporating external risk signals, such as device intelligence and phone number reputation, the system can block high-risk sign-in attempts earlier and reduce exposure to fraud.

| Component | Notes | 
| --- |  --- |
| **Native applications**   | The native application integrates a third-party fraud detection SDK. The applications collect limited, privacy‑preserving device and behavioral signals using the third‑party provider’s tooling and associate those signals with the current authentication session|
|  **Third‑party fraud protection provider**  |  The third‑party fraud provider evaluates the signals collected from the native application and determines the risk level of the authentication attempt. Based on the evaluation, one of the following outcomes occurs:<br> - **Low or acceptable risk**: The authentication flow proceeds, and the SMS one-time passcode (OTP) is issued. <br> - **High risk requiring extra verification**: Device possession is verified before allowing the flow to continue.<br> - **High risk with failed evaluation**: The sign-in attempt is blocked immediately, and no SMS challenge is sent. <br> You can use third‑party fraud providers such as [Human security](https://www.humansecurity.com/) and [Prove](https://www.prove.com/). |
|  **Web application firewall (WAF)**  |  The WAF is a customer‑managed enforcement layer that sits in front of Microsoft Entra endpoints. The WAF consumes the fraud decision from the third‑party provider and enforces it consistently. Microsoft doesn't configure or operate the WAF; its behavior, including fail‑open or fail‑closed policies, is owned by the customer.|
|  **Microsoft Entra**   |  Microsoft Entra processes only those requests that have passed upstream fraud checks. It doesn't receive raw device telemetry or third‑party risk scores. It issues SMS OTPs only after upstream approval and relies on its built‑in controls, such as throttling, regional restrictions, and phone number reputation signals to provide protection. |

### Sign-in flow protection example

This diagram shows how a native application integrates third‑party fraud protection into an SMS‑based MFA sign‑in flow. The native app coordinates with Microsoft Entra, a web application firewall (WAF), and an external fraud provider to evaluate risk before an SMS OTP is sent. By gating SMS MFA on real‑time risk signals, the flow helps block high‑risk sign‑in attempts while allowing legitimate users to complete authentication.

:::image type="content" source="./media/reference-native-auth-api/native-app-sms-mfa-third-party-fraud-protection-flow.svg" alt-text="Diagram of End-to-end native authentication flow showing how third-party risk evaluation gates SMS-based MFA before a sign-in completes or is blocked.":::

Key aspects of the sign‑in flow shown in the diagram:

- The native application orchestrates the sign‑in flow and triggers fraud risk evaluation when SMS‑based MFA is required.
- Microsoft Entra drives the authentication state and determines when MFA is needed, but defers SMS OTP delivery until fraud checks complete.
- The web application firewall (WAF) intercepts `/challenge` requests and evaluates fraud risk by consulting a third‑party provider before forwarding allowed requests to ESTS to send the OTP.
- The third‑party fraud provider evaluates risk using device, phone number, and network signals collected outside Microsoft Entra.
- SMS OTPs are sent only when the assessed risk is acceptable; high‑risk sign‑in attempts are blocked before SMS delivery.

## Related content

- [Native authentication overview](concept-native-authentication.md)
