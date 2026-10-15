---
title: Risk-based anti-bot verification (CAPTCHA) for telephony-based sign-in
description: Learn about risk-based anti-bot verification before Microsoft Entra ID sends SMS messages or places voice calls for telephony-based sign-in.
ms.topic: concept-article
ms.date: 10/14/2026
ai-usage: ai-assisted
# Customer intent: As an authentication administrator, I want to understand why users might see anti-bot verification before SMS or voice authentication and how to prepare my organization.
---

# Risk-based anti-bot verification (CAPTCHA) for telephony-based sign-in

Microsoft Entra ID uses safeguards to help reduce automated abuse of telephony-based sign-in. In some cases, users might be asked to complete a risk-based anti-bot verification step, such as a CAPTCHA, before Microsoft sends an SMS message or places a voice call for sign-in. This safeguard helps protect against telephony fraud, such as International Revenue Share Fraud (IRSF).

For more information about telephony fraud and how Microsoft helps limit the impact of fraudulent activity, see [Understanding telephony fraud risk](concept-mfa-telephony-fraud.md).

## What anti-bot verification is

The provider for this CAPTCHA experience is Arkose Labs. The challenge opens in a dialog during the authentication flow. The interaction helps confirm that the request is being made by a person before Microsoft sends an SMS message or places a voice call.

The experience is risk-based and uses client behavior signals, so not every user or authentication attempt is affected. Microsoft doesn't publish the risk criteria or implementation details that determine when anti-bot verification is shown.

## What users experience

When anti-bot verification is required, the user must complete the verification step before Microsoft sends the SMS message or places the voice call. If the user can't complete the verification step, they should try again or use another available authentication method. If the CAPTCHA dialog doesn't load, your organization might need to allow the Arkose Labs domains. For more information, see [Network requirements](#network-requirements).

Help desk teams should communicate that:

- SMS and voice authentication aren't removed by this safeguard.
- A user might need to complete an anti-bot verification step before receiving an SMS message or voice call.
- If the verification step doesn't load, the issue might be related to network or firewall restrictions. For more information, see [Network requirements](#network-requirements).
- Users should use another available non-telephony authentication method when possible. Non-telephony methods are more secure, aren't subject to this safeguard, and might provide a better user experience.

## Network requirements

Anti-bot verification can depend on resources that are loaded during the authentication flow. If an organization uses restrictive firewalls, proxies, or web filtering, users might be blocked from completing verification if the required endpoints aren't allowed.

To allow the Arkose Labs verification challenge to load and complete during authentication, configure the firewall, proxy, or secure web gateway to permit outbound HTTPS traffic on TCP port 443 from users' devices to:

- `*.arkoselabs.com`
- `arkoselabs.com`

Use your product's wildcard-domain or fully qualified domain name (FQDN) allowlist syntax so the rule covers all subdomains. Some products don't match the base domain with a wildcard entry, so add both domains.

Also make sure that:

- DNS filtering and web-content/category filtering policies don't block these domains, and that your allow rule takes priority over category-based blocks.
- These domains are excluded from TLS/SSL inspection (HTTPS decryption), which can stop the challenge from loading or validating.

## Prepare users and help desks

To prepare for risk-based anti-bot verification:

- Tell users that some SMS and voice authentication attempts might require anti-bot verification before Microsoft sends an SMS message or places a voice call.
- Make sure help desk teams know that the verification step is expected when risk-based safeguards apply.
- Review network requirements when the verification experience doesn't load.
- Encourage users to register and use phishing-resistant authentication methods where possible, such as passkeys.

## Related content

- [SMS-based user sign-in for Microsoft Entra ID](howto-authentication-sms-signin.md)
- [Voice call authentication method](concept-authentication-phone-options.md)
- [Understanding telephony fraud risk for Microsoft Entra multifactor authentication](concept-mfa-telephony-fraud.md)
- [Troubleshoot MFA voice call and SMS problems](troubleshoot-voice-call-sms.md)
- [Passkeys in Microsoft Entra ID](concept-authentication-passkeys-fido2.md)
