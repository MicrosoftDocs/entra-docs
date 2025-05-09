---
title: Risks detections and risk levels
description: Learn about risk detections and risk levels, including the difference between real-time and offline detections. 

ms.service: entra-id-protection

ms.topic: conceptual
ms.date: 05/08/2025

author: shlipsey3
ms.author: sarahlipsey
manager: femila
ms.reviewer: cokoopma

---

# Risk detections and risk levels

Microsoft Entra ID Protection provides organizations with information about suspicious activity in their tenant and allows you to respond quickly to prevent further risk occurring. Risk detections are a powerful resource that can include any suspicious or anomalous activity related to a user account in the directory. ID Protection risk detections can be linked to an individual user or sign-in event and contribute to the overall user risk score found in the [Risky Users report](howto-identity-protection-investigate-risk.md#risky-users-report). 

User risk detections might flag a legitimate user account as at risk, when a potential threat actor gains access to an account by compromising their credentials or when anomalous user activity is detected. Sign-in risk detections represent the probability that a given authentication request isn't the authorized owner of the account. Having the ability to identify risk at the user and sign-in level is critical for customers to be empowered to secure their tenant.

## Risk levels

ID Protection categorizes risk into three tiers: low, medium, and high. Risk levels calculated by our machine learning algorithms and represent how confident Microsoft is that one or more of the user's credentials are known by an unauthorized entity.

Detections can fire at more than one risk level, depending on the number or severity of the anomalies detected. For example, [Unfamiliar sign-in properties](reference-risk-event-types.md#unfamiliar-sign-in-properties) might fire at high, medium, or low based on the confidence in the signals. Other detections, like [Leaked Credentials](reference-risk-event-types.md#leaked-credentials) and [Verified Threat Actor IP](reference-risk-event-types.md#verified-threat-actor-ip) are always delivered as high risk. 

This risk level is important when deciding which detections to [prioritize, investigate, and remediate](howto-identity-protection-investigate-risk.md#investigation-and-risk-remediation-framework). Risk levels also play a key role in [configuring risk-based Conditional Access policies](howto-identity-protection-configure-risk-policies.md#choosing-acceptable-risk-levels), as each policy can be set to trigger for low, medium, high, or no risk detected.

Based on the risk tolerance of your organization, you can create Conditional Access policies that require MFA or password reset when ID Protection detects a certain risk level for one of your users. These policies can guide the user to self-remediate to resolve the risk.

### Low risk

A risk detection with risk level **Low** signifies that anomalies are present in the sign-in or a user's credential, but we're less confident that these anomalies mean the account is compromised.

This type of risk detection often means a change in sign-in behavior, such as an isolated use of a VPN or suddenly signing in from a new location. Sign-in patterns before and after the risk detection are used to determine if there's a pattern or if the sign-in is an anomaly.

Low risks can be considered as an "as information" risk detection. There's no immediate action required, but it's still important to know about.

> [!IMPORTANT] 
> All "low" level risk detections and users persist in the product for six months, after which they're  automatically aged out to provide a cleaner investigation experience. Medium and high risk levels persist until remediated or dismissed.

### Medium risk

A risk detection with risk level **Medium** indicates that one or more moderate-severity anomalies were detected, but there's less confidence that the account is compromised.

These risk detections might include a combination of low risk detections, as opposed to an isolated event. Sign-in behavior is also considered, so if the pattern before and after the risk detection is consistent, the risk detection might be classified as medium.

Medium risks should be investigated, but they might not require immediate action. Monitor offline detections (covered in the next section) that might change the risk level.

### High risk

A risk detection with risk level **High** signifies that Microsoft is highly confident that the account is compromised. 

These risk detections require immediate action, either through user self-remediation or administrative intervention. Signals such as threat intelligence and known attack patterns factor into the confidence level of the risk detection.

High risk sign-in and users must be investigated and remediated. If risk-based Conditional Access policies are in place, the user might be blocked, required to perform multifactor authentication, or granted access after a secure password reset. 

## Real-time and offline detections

ID Protection utilizes techniques to increase the precision of user and sign-in risk detections by calculating some risks in real-time or offline after authentication. Detecting risk in real-time at sign-in gives the advantage of identifying risk early so that customers can quickly investigate the potential compromise. On detections that calculate risk offline, they can provide more insight as to how the threat actor gained access to the account and the effect on the legitimate user. Some detections can be triggered both offline and during sign-in, which increases confidence in being precise on the compromise. 

Detections triggered in real-time take 5-10 minutes to surface details in the reports. Offline detections take up to 48 hours to surface in the reports, as it takes time to evaluate properties of the potential risk. 

> [!NOTE]
> Our system might detect that the risk event that contributed to the risk user risk score was either: 
> 
> - A false positive
> - The user risk was [remediated by policy](howto-identity-protection-remediate-unblock.md) by either: 
>    - Completing multifactor authentication
>    - Secure password change
> 
> Our system dismisses the risk state and a risk detail of **AI confirmed sign-in safe** appears, so the risk state no longer contributes to the user’s overall risk.

On risk-detailed data, **Time Detection** records the exact moment a risk is identified during a user's sign-in, which allows for real-time risk assessment and immediate policy application to safeguard the user and organization. **Detection last updated** shows the latest update to a risk detection, which could be due to new information, risk level changes, or administrative actions, and ensures up-to-date risk management.

These fields are essential for real-time monitoring, threat response, and maintaining secure access to organizational resources.

### Locations 

Location in risk detections is determined using IP address lookup. Sign-ins from trusted [named locations](../identity/conditional-access/location-condition.md#trusted-locations) improve the accuracy of Microsoft Entra ID Protection's risk calculation, lowering a user's sign-in risk when they authenticate from a location marked as trusted.

## Related content

- [Learn about risk-based access policies](concept-identity-protection-policies.md)
- [Learn how to investigate risk](howto-identity-protection-investigate-risk.md)
- [FAQs](id-protection-faq.yml)