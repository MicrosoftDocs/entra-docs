---
title: Investigate risk Microsoft Entra ID Protection
description: Learn how to investigate risky users, detections, and sign-ins in Microsoft Entra ID Protection.
ms.service: entra-id-protection
ms.topic: how-to
ms.date: 08/09/2024
author: shlipsey3
ms.author: sarahlipsey
manager: femila
ms.reviewer: cokoopma
ms.custom: sfi-image-nochange
---
# How To: Investigate risk

Microsoft Entra ID Protection provides organizations with reporting they can use to investigate identity risks in their environment. These reports include risky users, risky sign-ins, risky workload identities, and risk detections. Investigation of events is key to better understanding and identifying any weak points in your security strategy. All these reports allow for downloading of events in .CSV format or integration with other security solutions like a dedicated Security Information and Event Management (SIEM) tool for further analysis. Organizations can also take advantage of Microsoft Defender and Microsoft Graph API integrations to aggregate data with other sources.

## Navigating the reports

The risk reports are found in the [Microsoft Entra admin center](https://entra.microsoft.com) under **ID Protection**. You can navigate directly to the reports or view a summary of important insights in the dashboard view and navigate to the corresponding reports from there.

:::image type="content" source="media/howto-identity-protection-investigate-risk/view-high-risk-users-from-id-protection-dashboard.png" alt-text="Screenshot showing the number of high risk users widget from the ID Protection dashboard.":::

Each report launches with a list of all detections for the period shown at the top of the report. Administrators can optionally filter and add or remove columns based on their preference. Administrators can download the data in .CSV or .JSON format for further processing.

When administrators select one or multiple entries, options to confirm or dismiss the risks appear at the top of the report. Selecting an individual risk event opens a pane with more details to assist with investigations.

:::image type="content" source="media/howto-identity-protection-investigate-risk/risky-users-report-heading.png" alt-text="Screenshot of the heading of the Risky users report showing the options available to administrators." lightbox="media/howto-identity-protection-investigate-risk/risky-users-report-heading.png":::

### Risky users report

The risky users report includes all users whose accounts are currently or were considered at risk of compromise. Risky users should be investigated and remediated to prevent unauthorized access to resources. We recommend starting with high risk users due to the high confidence of compromise. [Learn more about what the levels signify](concept-identity-protection-risks.md#risk-levels)

#### Why is a user at risk?

A user becomes a risky user when:

- They have one or more risky sign-ins.
- They have one or more [risks](concept-identity-protection-risks.md) detected on their account, like leaked credentials. 

#### How to investigate risky users?

To view and investigate risky users, navigate to the Risky users report and use the filters to manage the results. There's an option at the top of the page to add other columns such as risk level, status, and risk detail.

:::image type="content" source="media/howto-identity-protection-investigate-risk/risky-users-report.png" alt-text="Screenshot of the Risky users report showing examples of users at risk." lightbox="media/howto-identity-protection-investigate-risk/risky-users-report.png":::

When administrators select an individual user, the Risky user details pane appears. Risky user details provide information like: user ID, office location, recent risky sign-in, detections not linked to a sign, and risk history. The Risk history tab shows the events that led to a user risk change in the last 90 days. This list includes risk detections that increased the user's risk. It can also include user or admin remediation actions that lowered the user's risk; for example, a user resetting their password or an admin dismissing the risk.

:::image type="content" source="media/howto-identity-protection-investigate-risk/risky-users-report-risky-user-details.png" alt-text="Screenshot showing the Risky User Details flyout with samples of Risk history." lightbox="media/howto-identity-protection-investigate-risk/risky-users-report-risky-user-details.png":::

If you have Copilot for Security, you have access to a [summary in natural language](../fundamentals/copilot-entra-risky-user-summarization.md) including: why the user risk level was elevated, guidance on how to mitigate and respond, and links to other helpful items or documentation. 

:::image type="content" source="media/howto-identity-protection-investigate-risk/risky-users-report-risky-user-details-copilot-summary.png" alt-text="Screenshot showing the summary of risk provided by Copilot in the Risky User Details flyout." lightbox="media/howto-identity-protection-investigate-risk/risky-users-report-risky-user-details-copilot-summary.png":::

With the information provided by the Risky users report, administrators can view:

- User risk that was remediated, dismissed, or is still currently at risk and needs investigation
- Details about detections
- Risky sign-ins associated to a given user
- Risk history

[!INCLUDE [id-protection-admin-action-user](../includes/id-protection-admin-action-user.md)]

:::image type="content" source="media/howto-identity-protection-investigate-risk/risky-users-report-risky-user-details-defender-investigate.png" alt-text="Screenshot showing the Risky User Details flyout and the additional actions an administrator might take." lightbox="media/howto-identity-protection-investigate-risk/risky-users-report-risky-user-details-defender-investigate.png":::

## Risky sign-ins report

The risky sign-ins report contains filterable data for up to the past 30 days (one month). ID Protection evaluates risk for all authentication flows, whether it's interactive or non-interactive. The Risky sign-ins report shows both interactive and non-interactive sign-ins. To modify this view, use the "sign-in type" filter.

:::image type="content" source="media/howto-identity-protection-investigate-risk/risky-sign-ins-report.png" alt-text="Screenshot showing the Risky sign-ins report." lightbox="media/howto-identity-protection-investigate-risk/risky-sign-ins-report.png":::

With the information provided by the Risky sign-ins report, administrators can view:

- Sign-ins that are at risk, confirmed compromised, confirmed safe, dismissed, or remediated.
- Real-time and aggregate risk levels associated with sign-in attempts.
- Detection types triggered
- Conditional Access policies applied
- MFA details
- Device information
- Application information
- Location information

[!INCLUDE [id-protection-admin-action-sign-in](../includes/id-protection-admin-action-sign-in.md)]

To learn more about when to take each of these actions, see [How does Microsoft use my risk feedback](howto-identity-protection-risk-feedback.md#how-does-microsoft-use-my-risk-feedback)

## Risk detections report

The Risk detections report contains filterable data for up to the past 90 days (three months).

:::image type="content" source="media/howto-identity-protection-investigate-risk/risk-detections-report.png" alt-text="Screenshot showing the Risk detections report." lightbox="media/howto-identity-protection-investigate-risk/risk-detections-report.png":::

With the information provided by the Risk detections report, administrators can find:

- Information about each risk detection
- Attack type based on MITRE ATT&CK framework
- Other risks triggered at the same time
- Sign-in attempt location
- Link out to more detail from Microsoft Defender for Cloud Apps.

Administrators can then choose to return to the user's risk or sign-ins report to take actions based on information gathered.

> [!NOTE]
> Our system might detect that the risk event that contributed to the user risk score was a false positive or the user risk was remediated with policy enforcement such as completing an MFA prompt or secure password change. Therefore, our system will dismiss the risk state and a risk detail of “AI confirmed sign-in safe” will surface and it will no longer contribute to the user's risk.

## Initial triage

When starting the initial triage, we recommend the following actions:

1. Review the ID Protection dashboard to visualize number of attacks, number of high risk users and other important metrics based on detections in your environment.
1. Review the Impact analysis workbook to understand the scenarios where risk is evident in your environment and risk-based access policies should be enabled to manage high-risk users and sign-ins.
1. Add corporate VPNs and IP address ranges to named locations to reduce false positives.
1. Consider creating a known traveler database for updated organizational travel reporting and use it to cross-reference travel activity.
1. Review the logs to identify similar activities with the same characteristics. This activity could be an indication of more compromised accounts.
   1. If there are common characteristics, like IP address, geography, success/failure, etc., consider blocking them with a Conditional Access policy.
   1. Review which resources might be compromised, including potential data downloads or administrative modifications.
   1. Enable self-remediation policies through Conditional Access
1. Check to see if the user performed other risky activities, such as downloading a large volume of files from a new location. This behavior is a strong indication of a possible compromise.

If you suspect an attacker can impersonate the user, you should require the user to reset their password and perform MFA or block the user and revoke all refresh and access tokens.

## Investigation and risk remediation framework

Organizations can use the following framework to begin their investigation into any suspicious activity. The recommended first step is self-remediation, if it's an option. Self-remediation can take place through self-service password reset or through remediation flow of a risk-based Conditional Access policy.

If self-remediation isn't an option, an administrator needs to remediate the risk. Remediation is done by invoking a password reset, requiring user to reregister for MFA, blocking the user, or revoking user sessions depending on the scenario. The following flow chart shows the recommended flow once a risk is detected:

:::image type="content" source="media/howto-identity-protection-investigate-risk/risk-remediation-flow.png" alt-text="Diagram showing the risk remediation flow." lightbox="media/howto-identity-protection-investigate-risk/risk-remediation-flow.png":::

Once the risk is contained, more investigation might be required to mark the risk as safe, compromised or to dismiss it. To come to a confident conclusion, it might be necessary to: have a conversation with the user in question, review the sign-in logs, review the audit logs, or query risk logs in Log Analytics. The following outlines recommended actions during this phase of the investigation:

1. Check the logs and validate whether the activity is normal for the given user.
   1. Look at the user's past activities including the following properties to see if they're normal for the given user.
      1. Application
      1. Device - Is the device registered or compliant?
      1. Location - Is the user traveling to a different location or accessing devices from multiple locations?
      1. IP address
      1. User agent string
   1. If you have access to other security tools like [Microsoft Sentinel](/azure/sentinel/overview), check for corresponding alerts that might indicate a larger issue.
   1. Organizations with access to [Microsoft 365 Defender](/defender-for-identity/understanding-security-alerts) can follow a user risk event through other related alerts, incidents, and the MITRE ATT&CK chain.
      1. To navigate from the Risky users report, select the user in the Risky users report and select the ellipsis (...) in the toolbar then choose Investigate with Microsoft 365 Defender.
1. Reach out to the user to confirm if they recognize the sign-in; however, consider methods such as email or Teams might be compromised.
   1. Confirm the information you have such as:
      1. Timestamp
      1. Application
      1. Device
      1. Location
      1. IP address
1. Depending on the results of the investigation, mark the user or sign-in as confirmed compromised, confirmed safe, or dismiss the risk.
1. [Set up risk-based Conditional Access policies](howto-identity-protection-configure-risk-policies.md#enable-policies) to prevent similar attacks or to address any gaps in coverage.

### Investigate specific detections

#### Microsoft Entra threat intelligence

To investigate a Microsoft Entra Threat Intelligence risk detection, follow these steps based on the information provided in the "additional info" field of the Risk Detection Details pane:

1. Sign-in was from a suspicious IP Address:
   1. Confirm if the IP address shows suspicious behavior in your environment.
   1. Does the IP generate a high number of failures for a user or set of users in your directory?
   1. Is the traffic of the IP coming from an unexpected protocol or application, for example Exchange legacy protocols?
   1. If the IP address corresponds to a cloud service provider, rule out that there are no legitimate enterprise applications running from the same IP.
1. This account was the victim of a password spray attack:
   1. Validate that no other users in your directory are targets of the same attack.
   1. Do other users have sign-ins with similar atypical patterns seen in the detected sign-in within the same time frame? Password spray attacks might display unusual patterns in:
      1. User agent string
      1. Application
      1. Protocol
      1. Ranges of IPs/ASNs
      1. Time and frequency of sign-ins
1. This detection was triggered by a real-time rule:
   1. Validate that no other users in your directory are targets of the same attack. This information can be found using the TI_RI_#### number assigned to the rule.
   1. Real-time rules protect against novel attacks identified by Microsoft's threat intelligence. If multiple users in your directory were targets of the same attack, investigate unusual patterns in other attributes of the sign in.

#### Investigating atypical travel detections

1. If you're able to confirm the activity wasn't performed by a legitimate user:
   1. **Recommended action**: Mark the sign-in as compromised, and invoke a password reset if not already performed by self-remediation. Block user if attacker has access to reset password or perform MFA and reset password.
1. If a user is known to use the IP address in the scope of their duties:
   1. **Recommended action**: Confirm sign-in as safe.
1. If you're able to confirm that the user recently traveled to the destination mentioned detailed in the alert:
   1. **Recommended action**: Confirm sign-in as safe.
1. If you're able to confirm that the IP address range is from a sanctioned VPN.
   1. **Recommended action**: Confirm sign-in as safe and add the VPN IP address range to named locations in Microsoft Entra ID and Microsoft Defender for Cloud Apps.

#### Investigating anomalous token and token issuer anomaly detections

1. If you're able to confirm that the activity wasn't performed by a legitimate user using a combination of risk alert, location, application, IP address, User Agent, or other characteristics that are unexpected for the user:
   1. **Recommended action**: Mark the sign-in as compromised, and invoke a password reset if not already performed by self-remediation. Block the user if an attacker has access to reset password or perform.
   1. **Recommended action**: [Set up risk-based Conditional Access policies](howto-identity-protection-configure-risk-policies.md#enable-policies) to require password reset, perform MFA, or block access for all high-risk sign-ins.
1. If you're able to confirm location, application, IP address, User Agent, or other characteristics are expected for the user and there aren't other indications of compromise:
   1. **Recommended action**: Allow the user to self-remediate with a risk-based Conditional Access policy or have an admin confirm sign-in as safe.
1. For further investigation of token based detections, see the blog post [Token tactics: How to prevent, detect, and respond to cloud token theft](https://www.microsoft.com/security/blog/2022/11/16/token-tactics-how-to-prevent-detect-and-respond-to-cloud-token-theft) the [Token theft investigation playbook](/security/operations/token-theft-playbook).

#### Investigating suspicious browser detections

- Browser isn't commonly used by the user or activity within the browser doesn't match the users normally behavior.
   - **Recommended action**: Confirm the sign-in as compromised, and invoke a password reset if not already performed by self-remediation. Block the user if an attacker has access to reset password or perform MFA.
   - **Recommended action**: [Set up risk-based Conditional Access policies](howto-identity-protection-configure-risk-policies.md#enable-policies) to require password reset, perform MFA, or block access for all high-risk sign-ins.

#### Investigating malicious IP address detections

1. If you're able to confirm that the activity wasn't performed by a legitimate user:
   1. **Recommended action**: Confirm the sign-in as compromised, and invoke a password reset if not already performed by self-remediation. Block the user if an attacker has access to reset password or perform MFA and reset password and revoke all tokens.
   1. **Recommended action**: [Set up risk-based Conditional Access policies](howto-identity-protection-configure-risk-policies.md#enable-policies) to require password reset or perform MFA for all high-risk sign-ins.
1. If a user is known to use the IP address in the scope of their duties:
   1. **Recommended action**: Confirm sign-in as safe.

#### Investigating password spray detections

1. If you're able to confirm that the activity wasn't performed by a legitimate user:
   1. **Recommended action**: Mark the sign-in as compromised, and invoke a password reset if not already performed by self-remediation. Block the user if an attacker has access to reset password or perform MFA and reset password and revoke all tokens.
1. If a user is known to use the IP address in the scope of their duties:
   1. **Recommended action**: Confirm sign-in safe.
1. If you're able to confirm that the account isn't compromised and see no brute force or password spray indicators against the account.
   1. **Recommended action**: Allow the user to self-remediate with a risk-based Conditional Access policy or have an admin confirm sign-in as safe.
1. Ensure you have [Microsoft Entra smart lockout](../identity/authentication/howto-password-smart-lockout.md) configured appropriately to avoid unnecessary account lockouts.

For further investigation of password spray risk detections, see the article [Password spray investigation](/security/operations/incident-response-playbook-password-spray).

#### Investigating leaked credentials detections

- If this detection identified a leaked credential for a user:
   - **Recommended action**: Confirm the user as compromised, and invoke a password reset if not already performed by self-remediation. Block the user if an attacker has access to reset password or perform MFA and reset password and revoke all tokens.

## Next steps

- [Remediate and unblock users](howto-identity-protection-remediate-unblock.md)
- [Policies available to mitigate risks](concept-identity-protection-policies.md)
- [Enable sign-in and user risk policies](howto-identity-protection-configure-risk-policies.md)
