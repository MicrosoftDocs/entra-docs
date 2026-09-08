---
title: Unified risk signals in Microsoft Entra ID Protection
description: Learn how unified risk signals correlate identity risk across Microsoft Entra ID Protection and Microsoft Defender to calculate compounded user risk.
ms.topic: concept-article
ms.date: 06/30/2026
ms.author: sarahlipsey
author: shlipsey3
ms.reviewer: sandeo
ms.custom: msecd-doc-authoring-scenarios
ai-usage: ai-assisted
---

# Unified risk signals in Microsoft Entra ID Protection

Microsoft Entra ID Protection enhances user risk assessment by aggregating correlated risk signals from Microsoft Entra ID Protection, Microsoft Defender, and other Microsoft security products. Instead of evaluating alerts in isolation, unified risk signals correlate identity-related signals across products and evaluate them together within the same time window. This compounded approach detects coordinated or stealthy attacks that individual alerts might miss.

As a result, users who previously appeared as medium risk based on isolated signals might be elevated to high risk when multiple related detections are combined. This improves detection of advanced or low-signal attacks and increases the number of high-risk users identified, which can automatically trigger your risk-based Conditional Access policies.

## Prerequisites

Unified risk signals require the following:

- **Microsoft Entra ID P2** — Enables user risk and sign-in risk detection, ID Protection policies, risk-based Conditional Access, and advanced identity analytics.
- **Microsoft 365 E5** (recommended) — Includes Microsoft Entra ID P2 plus Microsoft Defender for Endpoint, Microsoft Defender for Identity, Microsoft Defender for Office 365, and Microsoft Purview for full cross-product signal correlation.
- **Microsoft Defender for Identity** — Must be configured. Enabling unified risk signals without Microsoft Defender for Identity doesn't result in compounding of user risk.

### Required roles

| Role | Purpose |
| --- | --- |
| [Security Administrator](../identity/role-based-access-control/permissions-reference.md#security-administrator) | Manage ID Protection and risk policies |
| [Conditional Access Administrator](../identity/role-based-access-control/permissions-reference.md#conditional-access-administrator) | Configure enforcement based on risk |
| [Security Operator](../identity/role-based-access-control/permissions-reference.md#security-operator) or [Security Reader](../identity/role-based-access-control/permissions-reference.md#security-reader) | Investigate alerts and incidents |

## How compounded risk works

Enhanced user risk assessment evaluates user behavior as a whole, not individual alerts in isolation. The system collects risk signals from multiple sources, correlates them by user and time, and calculates a single compounded user risk score.

### Signal sources

Different Microsoft products contribute different types of suspicious behavior signals:

- **Microsoft Entra ID** — Strange sign-ins, multifactor authentication bypass, token reuse or misuse.
- **Microsoft Defender for Identity** — On-premises Active Directory attacks, lateral movement, credential theft techniques.
- **Microsoft Defender for Endpoint** — Device-level execution, malware, NTDS.dit access.
- **Microsoft Defender for Cloud Apps** — Suspicious OAuth apps, session anomalies, SaaS application activity.
- **Microsoft Purview** — Risky data access, insider or compliance-related concerns.

### Signal correlation

The system lines up signals by user and time. If the same user shows multiple unusual signals within a short time window, those signals are treated as connected. Each signal has a severity and confidence level. Low-confidence alerts stay low if they're alone, but become more serious when they occur alongside other signals.

The correlation uses four key factors:

- **Kill chain breadth** — Alerts spanning multiple attack stages (reconnaissance, credential access, lateral movement) indicate an attacker with intent, not an accident.
- **Alert variety** — Multiple different alert types from different products make a false positive unlikely.
- **Temporal convergence** — Alerts happening close together are more likely related than alerts spread over weeks.
- **Cross-product correlation** — Each product sees a partial view of reality. Correlating them closes gaps and reduces false assumptions.

### What changed compared to previous behavior

Previously, the system could reduce risk over time but couldn't increase a user's risk level solely based on the accumulation of nonhigh alerts. With unified risk signals, Microsoft Entra ID Protection can now elevate a user's risk to **High** based on multiple medium or low-confidence signals occurring together.

## Account sets and linked accounts

Microsoft Defender for Identity can contribute risk signals from **account sets**, not just the Microsoft Entra ID account itself. Account sets represent the same human identity across multiple accounts, such as:

- An on-premises Active Directory account
- A third-party identity provider account (for example, Okta)
- A privileged or legacy account in a different domain

If one of these linked accounts is under active attack, Microsoft Defender for Identity continues to detect suspicious activity and raise new Identity Risk signals for the account set. These signals are sent back to Microsoft Entra ID Protection and reaggregated into the user's overall risk score.

For linked Microsoft Entra accounts, unified risk uses the **maximum risk level** across all linked accounts.

> [!NOTE]
> Even if the Microsoft Entra ID account itself appears unchanged, the user's risk can reelevate repeatedly as long as the underlying attack against a linked account persists. For more information about how accounts are linked in Microsoft Defender, see [Link or unlink an account to an identity](/defender-for-identity/manage-related-identities-accounts).

## View compounded risk

### In Microsoft Entra ID Protection

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Security Reader](../identity/role-based-access-control/permissions-reference.md#security-reader).
1. Browse to **ID Protection** > **Risky users**.
1. Select a user marked as **High risk** to open the risky user details.
1. In the **Timeline**, look for the progression:
   - The user was initially flagged as **Medium** risk by an individual detection.
   - The user risk was elevated to **High** by **Unified risk signals**.
1. Select the **Risk detections** link associated with the high-risk event to view the risk detection details:
   - **Detection type**: Unified risk signals
   - **Risk level**: High (compounded)
   - **Risk detail**: Microsoft Entra ID Protection elevated the user risk

To see the link back to the user's account in Microsoft Defender, select **Add/remove columns** in the **User Detections** section and enable **Additional info**.

### In Microsoft Defender

1. From the risk detection details in Microsoft Entra, select the **Click here for more details** link in the **Additional info** section.
1. This opens the **Incidents and alerts** tab of the user's page in the Microsoft Defender portal (**Assets** > **Identities**).
1. Review the contributing signals and their service sources.
1. Select the **Risk score** tab to see the identity's overall risk score (0–100), the account sets linked to the identity, and the Microsoft Entra ID risk level for each account.
1. Select the **Overview** tab to see all alerts and incidents, the compounded risk, and contextual information like insider risk severity and blast radius.

For more information, see [Investigate identities in Microsoft Defender](/defender-xdr/investigate-users).

## Alert sync and risk decay

> [!IMPORTANT]
> There might be sync issues for some alerts due to the risk decay logic. This can result in alerts showing in Microsoft Entra or Microsoft Defender but not the other. This resolves itself once the alert is decayed on both sides within 24 hours.

Risk detection events stream to Microsoft Defender and Microsoft Sentinel with no changes to existing data flows. As unified risk signals roll out, you might notice an increase in **Blocked by Conditional Access** events. This indicates the system is correctly identifying and stopping coordinated attack activity that previously appeared benign when alerts were evaluated independently.

## Troubleshoot unified risk signals

### Dismissed risk keeps returning

When you dismiss a user's risk in Microsoft Entra but it keeps returning, the cause is typically ongoing attack activity against a **linked account** in Microsoft Defender. Even after dismissal, Microsoft Defender for Identity continues to detect suspicious activity on linked on-premises or third-party accounts and sends new signals back to Microsoft Entra ID Protection, which reaggregates them into the user's risk.

To resolve this:

1. Investigate the contributing signals in the Microsoft Defender portal. Browse to **Assets** > **Identities** and select the user. Review the **Incidents and alerts** tab to identify the source of ongoing signals.
1. Remediate the underlying attack on the linked account (for example, reset the on-premises AD password, disable the compromised account, or revoke sessions).
1. After the attack is resolved, the risk score drops automatically as signals stop and decay.

### Identify compounded risk events

Compounded risk events use the following values:

| Field | Value |
| --- | --- |
| Risk event type | `aiCompoundAccountRisk` |
| Risk detail | `aiElevatedAccountRisk` |
| Detection type | Unified risk signals |

## Real-world attack scenarios

The following table shows examples of how risk compounding improves detection accuracy:

| Scenario | Alerts detected | Without compounding | With compounding |
| --- | --- | --- | --- |
| Session cookie theft | Anomalous Token (Microsoft Entra) + Suspicious OAuth app (Microsoft Defender for Cloud Apps) | Medium risk (each alert evaluated separately) | **High risk** (cross-product correlation + kill chain breadth) |
| Multi-stage attack | Unfamiliar sign-in (Microsoft Entra ID) + Kerberoasting (Microsoft Defender for Identity) + NTDS.dit dump (Microsoft Defender for Endpoint) | Medium risk (no single high-confidence alert) | **High risk** (three kill chain stages + temporal convergence) |
| Adversary-in-the-middle (AiTM) phishing | Anonymous IP (Microsoft Entra ID) + User compromised via AiTM (Microsoft Defender for Office 365) | Medium risk (Microsoft Entra alert alone is low confidence) | **High risk** (Microsoft Defender alert confirms compromise) |

## Support boundaries

Unified risk signals span Microsoft Entra ID Protection and Microsoft Defender. Cases are triaged based on where the customer starts:

- **Starting from Microsoft Entra** (ID Protection, Conditional Access): Owned by the Identity Protection Service team.
- **Starting from Microsoft Defender**: Owned by the Defender support team, even if the risk calculation includes Microsoft Entra ID Protection signals.

When investigation confirms that user risk is driven by Microsoft Defender signals, including linked on-premises account activity, Microsoft Defender becomes the owning team for investigation and resolution.

## Related content

- [What are risk detections?](concept-identity-protection-risks.md)
- [Risky user report](concept-risky-user-report.md)
- [Remediate risks and unblock users](howto-identity-protection-remediate-unblock.md)
- [Investigate identities in Microsoft Defender](/defender-xdr/investigate-users)
- [Link or unlink an account to an identity in Microsoft Defender for Identity](/defender-for-identity/manage-related-identities-accounts)
- [Plan a deployment](how-to-deploy-identity-protection.md)
