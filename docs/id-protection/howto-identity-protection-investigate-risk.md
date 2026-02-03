---
title: Investigate risk with Microsoft Entra ID Protection
description: Learn how to investigate risky users, detections, and sign-ins in Microsoft Entra ID Protection.
ms.service: entra-id-protection
ms.topic: how-to
ms.date: 01/07/2026
author: shlipsey3
ms.author: sarahlipsey
ms.reviewer: cokoopma
ms.custom: sfi-image-nochange
---
# How to investigate risk

Microsoft Entra ID Protection provides several [risk reports](concept-risk-reports.md) that can be used to investigate identity risks in your environment. Investigation of events is key to better understanding and identifying any weak points in your security strategy. ID Protection reports can be archived for storage or integrated with Security Information and Event Management (SIEM) tools for further analysis. Organizations can also take advantage of Microsoft Defender, Microsoft Sentinel, and Microsoft Graph API integrations to aggregate data with other sources.

There are many ways to investigate risk in your environment and even more details to consider during your investigation. This article provides a framework to help you get started and outlines some of the most common scenarios and recommended actions.

## Prerequisites

- [Microsoft Entra ID P2 or Microsoft Entra Suite license](overview-identity-protection.md) is required for full access to Microsoft Entra ID Protection features.
- [Global Reader](../identity/role-based-access-control/permissions-reference.md#global-reader) is the least privileged role required to **view the risk reports**.
- [Reports Reader](../identity/role-based-access-control/permissions-reference.md#reports-reader) is the least privileged role required to **view the sign-in and audit logs**.

## Initial triage

When starting the initial triage, we recommend the following actions:

1. Review the [ID Protection dashboard](id-protection-dashboard.md) to visualize number of attacks, number of high risk users, and other important metrics based on detections in your environment.

1. Review the [risk reports](concept-risk-reports.md) to examine the details of any recent risky users, sign-ins, or detections.

1. Review the [Impact analysis workbook](workbook-risk-based-policy-impact.md) to understand the scenarios where risk is evident in your environment and what risk-based access policies should be enabled to manage high-risk users and sign-ins.

1. Review the [sign-in logs](../identity/monitoring-health/concept-sign-ins.md) to identify similar activities with the same characteristics. This activity could be an indication of more compromised accounts.
   1. If there are common characteristics, like IP address, geography, success/failure, etc., consider blocking them with a Conditional Access policy.
   1. Review which resources might be compromised, including potential data downloads or administrative modifications.
   1. Enable [self-remediation policies through Conditional Access](howto-identity-protection-configure-risk-policies.md).

1. With [Insider Risk Management through Microsoft Purview](/purview/insider-risk-management), you can check to see if the user performed other risky activities, such as downloading a large volume of files from a new location. This behavior is a strong indication of a possible compromise.

If you suspect an attacker can impersonate the user, you should require the user to reset their password and perform MFA or block the user and revoke all refresh and access tokens.

## Investigation and risk remediation framework

Organizations can use the following framework to investigate suspicious activity. When risk is detected, the recommended first step is self-remediation, if it's an option. Self-remediation can take place through self-service password reset or through remediation flow of a [risk-based Conditional Access policy](howto-identity-protection-configure-risk-policies.md).

If self-remediation isn't an option, an administrator needs to remediate the risk. Remediation is done by invoking a password reset, requiring user to reregister for MFA, blocking the user, or revoking user sessions. The following flow chart shows the recommended flow once a risk is detected:

:::image type="content" source="media/howto-identity-protection-investigate-risk/risk-remediation-flow.png" alt-text="Diagram showing the risk remediation flow." lightbox="media/howto-identity-protection-investigate-risk/risk-remediation-flow.png":::

Once the risk is contained, more investigation might be required to mark the risk as safe, compromised, or to dismiss it.

1. Check the sign-in logs and validate whether the activity is normal for the given user.
   1. Look at the user's past activities including the following properties to see if they're normal for the given user.
      - Application - Is the app commonly used by the user?
      - Device - Is the device registered or compliant?
      - Location - Is the user traveling to a different location or accessing devices from multiple locations?
      - IP address
      - **User agent string**

1. Investigate using other security tools, where available.
   - If you have [Microsoft Sentinel](/azure/sentinel/overview), check for corresponding alerts that might indicate a larger issue.
   - If you have [Microsoft Defender XDR](/defender-for-identity/understanding-security-alerts), you can follow a user risk event through other related alerts and incidents.
   - The MITRE ATT&CK chain through Microsoft Sentinel in Microsoft Defender XDR might also provide insights. In the [Microsoft Defender portal](https://security.microsoft.com), browse to **Incidents & alerts** > **Alerts** > and set the **Product name** filter to **AAD Identity Protection** to find alerts from Microsoft Entra ID Protection.
 
1. Contact the user to confirm if they recognize the sign-in; however, keep in mind that email or Teams might be compromised.
   1. Confirm the information you have such as:
      - Timestamp
      - Application
      - Device
      - Location
      - IP address
1. Depending on the results of the investigation, mark the user or sign-in as confirmed compromised, confirmed safe, or dismiss the risk.
1. [Set up risk-based Conditional Access policies](howto-identity-protection-configure-risk-policies.md#enable-policies) to prevent similar attacks or to address any gaps in coverage.

## Investigate specific detections

Certain risk detections require specific investigation steps. The following sections outline some of the most common risk detections and recommended actions.

### Microsoft Entra threat intelligence

To investigate a Microsoft Entra threat intelligence risk detection, follow these steps based on the information provided in the "additional info" field of the Risk Detection Details pane:

- If the sign-in was from a suspicious IP Address:
   1. Confirm if the IP address shows suspicious behavior in your environment.
   1. Does the IP generate a high number of failures for a user or set of users in your directory?
   1. Is the traffic of the IP coming from an unexpected protocol or application, for example Exchange legacy protocols?
   1. If the IP address corresponds to a cloud service provider, rule out that there are no legitimate enterprise applications running from the same IP.

- Account was the victim of a password spray attack
   1. Validate that no other users in your directory are targets of the same attack.
   1. Determine if other users have sign-ins with similar atypical patterns seen in the detected sign-in within the same time frame. Password spray attacks might display unusual patterns in:
      - User agent string
      - Application
      - Protocol
      - Ranges of IPs/ASNs
      - Time and frequency of sign-ins

- Detection was triggered by a real-time rule
   1. Validate that no other users in your directory are targets of the same attack. This information can be found using the TI_RI_#### number assigned to the rule.
   1. Real-time rules protect against novel attacks identified by Microsoft's threat intelligence. If multiple users in your directory were targets of the same attack, investigate unusual patterns in other attributes of the sign in.

### Atypical travel detections

- If you confirm the activity was *not* performed by a legitimate user:
   1. Mark the sign-in as compromised, and invoke a password reset if not already performed by self-remediation.
   1. Block the user if attacker has access to reset password or perform MFA and reset password.
- If a user is known to use the IP address in the scope of their duties, confirm sign-in as safe.
- If you confirm that the user recently traveled to the destination mentioned detailed in the alert, confirm sign-in as safe.
- If you confirm that the IP address range is from a sanctioned VPN, confirm sign-in as safe and add the VPN IP address range to named locations in Microsoft Entra ID and Microsoft Defender for Cloud Apps.

### Anomalous token and token issuer anomaly detections

- If you confirm that the activity was *not* performed by a legitimate user using a combination of risk alert, location, application, IP address, User Agent, or other characteristics that are unexpected for the user:
   1. Mark the sign-in as compromised, and invoke a password reset if not already performed by self-remediation.
   1. Block the user if an attacker has access to reset password or perform.
   1. [Set up risk-based Conditional Access policies](howto-identity-protection-configure-risk-policies.md#enable-policies) to require password reset, perform MFA, or block access for all high-risk sign-ins.

- If you confirm location, application, IP address, User Agent, or other characteristics are expected for the user and there aren't other indications of compromise, allow the user to self-remediate with a risk-based Conditional Access policy or have an admin confirm sign-in as safe.

For further investigation of token based detections, see the blog post [Token tactics: How to prevent, detect, and respond to cloud token theft](https://www.microsoft.com/security/blog/2022/11/16/token-tactics-how-to-prevent-detect-and-respond-to-cloud-token-theft) the [Token theft investigation playbook](/security/operations/token-theft-playbook).

### Suspicious browser detections

This detection indicates the user doesn't commonly use the browser or activity within the browser doesn't match the user's normal behavior.

- Confirm the sign-in as compromised, and invoke a password reset if not already performed by self-remediation. Block the user if an attacker has access to reset password or perform MFA.
- [Set up risk-based Conditional Access policies](howto-identity-protection-configure-risk-policies.md#enable-policies) to require password reset, perform MFA, or block access for all high-risk sign-ins.

### Malicious IP address detections

- If you confirm that the activity was *not* performed by a legitimate user:
   1. Confirm the sign-in as compromised, and invoke a password reset if not already performed by self-remediation.
   1. Block the user if an attacker has access to reset password or perform MFA and reset password and revoke all tokens.
   1. [Set up risk-based Conditional Access policies](howto-identity-protection-configure-risk-policies.md#enable-policies) to require password reset or perform MFA for all high-risk sign-ins.

- If you confirm the user *does* use the IP address in the scope of their duties, confirm the sign-in as safe.

### Password spray detections

- If you confirm that the activity was *not* performed by a legitimate user:
   1. Mark the sign-in as compromised, and invoke a password reset if not already performed by self-remediation.
   1. Block the user if an attacker has access to reset password or perform MFA and reset password and revoke all tokens.

- If you confirm the user *does* use the IP address in the scope of their duties, confirm the sign-in as safe.

- If you confirm that the account isn't compromised and see no brute force or password spray indicators against the account:
   1. Allow the user to self-remediate with a risk-based Conditional Access policy or have an admin confirm sign-in as safe.
   1. Ensure you have [Microsoft Entra smart lockout](../identity/authentication/howto-password-smart-lockout.md) configured appropriately to avoid unnecessary account lockouts.

For further investigation of password spray risk detections, see the article [Password spray investigation](/security/operations/incident-response-playbook-password-spray).

### Leaked credentials detections

If this detection identified a leaked credential for a user:
1. Confirm the user as compromised, and invoke a password reset if not already performed by self-remediation.
1. Block the user if an attacker has access to reset password or perform MFA and reset password and revoke all tokens.

## Mitigate future risks

- Add corporate VPNs and IP address ranges to [named locations](../identity/conditional-access/concept-assignment-network.md) in your Conditional Access policies to reduce false positives.
- Consider creating a known traveler database for updated organizational travel reporting and use it to cross-reference travel activity.
- [Provide feedback in ID Protection](howto-identity-protection-risk-feedback.md) to improve detection accuracy and reduce false positives. 

## Next steps

- [Remediate and unblock users](howto-identity-protection-remediate-unblock.md)
- [Policies available to mitigate risks](concept-identity-protection-policies.md)
- [Enable sign-in and user risk policies](howto-identity-protection-configure-risk-policies.md)