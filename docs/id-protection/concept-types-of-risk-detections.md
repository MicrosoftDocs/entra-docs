---
title: What are risk detections?
description: Learn about risk detections and risk levels, including the difference between real-time and offline detections. 

ms.service: entra-id-protection

ms.topic: conceptual
ms.date: 07/16/2025

author: shlipsey3
ms.author: sarahlipsey
manager: pmwongera 
ms.reviewer: cokoopma

---

# What are risk detections?

Microsoft Entra ID Protection provides organizations with information about suspicious activity in their tenant and allows you to respond quickly to prevent further risk occurring. Risk detections are a powerful resource that can include any suspicious or anomalous activity related to user accounts and service principals in the directory. ID Protection risk detections can be linked to an individual user or sign-in event and contribute to the overall user risk score found in the [Risky Users report](howto-identity-protection-investigate-risk.md#risky-users-report). 

User risk detections might flag a legitimate user account as at risk, when a potential threat actor gains access to an account by compromising their credentials or when anomalous user activity is detected. Sign-in risk detections represent the probability that a given authentication request isn't the authorized owner of the account. Having the ability to identify risk at the user and sign-in level is critical for customers to be empowered to secure their tenant.

> [!NOTE]
> For the full list of risk detections, how they're calculated, and their license requirements, see [**Risk detection and event types**](concept-identity-protection-risks.md).

## Risk levels

ID Protection categorizes risk into three tiers: low, medium, and high. Risk levels are calculated by our machine learning algorithms and represent how confident Microsoft is that one or more of the user's credentials are known by an unauthorized entity.

Detections can fire at more than one risk level, depending on the confidence level. For example, [Unfamiliar sign-in properties](concept-identity-protection-risks.md#unfamiliar-sign-in-properties) might fire at high, medium, or low based on the level of familiarity with the sign-in properties. Other detections, like [Leaked Credentials](concept-identity-protection-risks.md#leaked-credentials) and [Verified Threat Actor IP](concept-identity-protection-risks.md#verified-threat-actor-ip) are always delivered as high risk because we found proof of the leaked credential or the threat actor.

Risk level is important when deciding which detections to [prioritize, investigate, and remediate](howto-identity-protection-investigate-risk.md#investigation-and-risk-remediation-framework). The risk level helps you prioritize your investigation and remediation efforts.

Risk levels also play a key role in [configuring risk-based Conditional Access policies](howto-identity-protection-configure-risk-policies.md#choosing-acceptable-risk-levels), as each policy can be set to trigger for low, medium, high, or no risk detected. Based on the risk tolerance of your organization, you can create Conditional Access policies that require MFA or password reset when ID Protection detects a certain risk level for one of your users. These policies can guide the user to self-remediate to resolve the risk.

> [!IMPORTANT] 
> **Low** level risk detections and users persist in the product for six months, after which they're automatically aged out to provide a cleaner investigation experience. **Medium** and **high** risk levels persist until remediated or dismissed.

A risk detection with risk level of:

- **High** signifies that Microsoft is highly confident that the account is compromised. Signals such as threat intelligence and known attack patterns factor into the confidence level of the risk detection.
- **Medium** indicates that one or more moderate-severity anomalies were detected, but there's less confidence that the account is compromised. Sign-in patterns, behaviors, and other signals factor into the confidence level of the risk detection.
- **Low** signifies that anomalies are present in the sign-in or a user's credential, but we're less confident the account hasn't been compromised. Sign-in patterns before and during the sign-in are used to determine if there's a pattern or if the sign-in is an anomaly.

## Real-time and offline detections

ID Protection utilizes techniques to increase the precision of user and sign-in risk detections by calculating some risks in real-time or offline after authentication. Detecting risk in real-time at sign-in gives the advantage of identifying risk early so that users can self-remediate during sign-in and admins can quickly investigate the potential compromise. Conditional Access policies triggered during sign-in can stop a bad actor before they gain access to the account.

Detections calculated offline can provide more insight into how the threat actor gained access to the account and the effect on the legitimate user. Some detections can be triggered both offline and during sign-in, which increases confidence in compromise detection.

Detections triggered in real-time take 5-10 minutes to surface details in the reports. Offline detections take up to 48 hours to surface in the reports, as it takes time to evaluate properties of the potential risk. It's important to remember that risk levels can change, because some risk detections are calculated offline after sign-in.

| Detection type | Sign-in risk | User risk |
|----------------|--------------|-----------|
| **Real-time**      | Suspicious sign-in is detected and can be remediated in real-time through a Conditional Access policy, such as to require MFA. | User risk is detected and can be remediated through a Conditional Access policy, such as to force a secure password change in real-time. |
| **Offline**        | Sign-in risk is identified after sign-in. If not remediated this risk might escalate into user risk if more risks are detected and aggregated into user risk. | User is deemed risky after sign-in. If Conditional Access policy is configured, the user is blocked until they perform self-service password reset the next time they authenticate. |

> [!NOTE]
> Our system might determine that the risk event that contributed to the user risk score was either: 
> 
> - A false positive, or
> - The user risk was [remediated by policy](howto-identity-protection-remediate-unblock.md) (by either completing multifactor authentication or a secure password change).
> 
> Our system dismisses the risk state and sets the risk detail to **AI confirmed sign-in safe**, so the risk state no longer contributes to the user's overall risk.

### Time detection

On risk-detailed data, **Time Detection** records the exact moment a risk is identified during a user's sign-in, which allows for real-time risk assessment and immediate policy application to safeguard the user and organization. **Detection last updated** shows the latest update to a risk detection, which could be due to new information, risk level changes, or administrative actions, and ensures up-to-date risk management.

These fields are essential for real-time monitoring, threat response, and maintaining secure access to organizational resources.

### Locations 

Location in risk detections is determined using IP address lookup. Sign-ins from trusted [named locations](../identity/conditional-access/location-condition.md#trusted-locations) improve the accuracy of Microsoft Entra ID Protection's risk calculation, lowering a user's sign-in risk when they authenticate from a location marked as trusted.

> [!NOTE]
> Looking for the **Risk detections mapped to riskEventType** table? It moved to the new [**Risk detection and event types**](concept-identity-protection-risks.md) article.

## Related content

- [Learn about risk-based access policies](concept-identity-protection-policies.md)
- [Learn how to investigate risk](howto-identity-protection-investigate-risk.md)
- [Review all risk event types](concept-identity-protection-risks.md)