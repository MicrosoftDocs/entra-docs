---
title: Investigate risk Microsoft Entra ID Protection
description: Learn how to investigate risky users, detections, and sign-ins in Microsoft Entra ID Protection.

ms.service: entra-id-protection

ms.topic: how-to
ms.date: 08/09/2024

ms.author: joflore
author: MicrosoftGuyJFlo
manager: amycolannino
ms.reviewer: cokoopma
---
# How To: Investigate risk

Microsoft Entra ID Protection provides organizations with reporting they can use to investigate identity risks in their environment. These reports include risky users, risky sign-ins, risky workload identities, and risk detections. Investigation of events is key to better understanding and identifying any weak points in your security strategy. All these reports allow for downloading of events in .CSV format or integration with other security solutions like a dedicated Security Information and Event Management (SIEM) tool for further analysis. Organizations can also take advantage of Microsoft Defender and Microsoft Graph API integrations to aggregate data with other sources.

## Navigating the reports

The risk reports are found in the [Microsoft Entra admin center](https://entra.microsoft.com) under **Protection** > **Identity Protection**. You can navigate directly to the reports or view a summary of important insights in the dashboard view and navigate to the corresponding reports from there.

:::image type="content" source="media/howto-identity-protection-investigate-risk/view-high-risk-users-from-id-protection-dashboard.png" alt-text="Screenshot shoing the number of high risk users widget from the ID Protection dashboard.":::

Each report launches with a list of all detections for the period shown at the top of the report along with the option to filter and add or remove columns based on administrator preference. Administrators can also choose to download the data in .CSV or .JSON format.

When administrators select one or multiple entries, options to confirm or dismiss the risks appear at the top of the report. Selecting an individual risk event opens a pane with more details to assist with investigations.

![X]()

### Risky users report

The risky users report includes all users whose accounts are currently or were considered at risk of compromise. Risky users should be investigated and remediated to prevent unauthorized access to resources. We recommend starting with high risk users due to the high confidence of compromise. Learn more about what the levels signify: Risk levels https://learn.microsoft.com/en-us/entra/id-protection/concept-identity-protection-risks#risk-levels

#### Why is a user at risk?

A user becomes a risky user when:

- They have one or more risky sign-ins.
- There are one or more [risks](concept-identity-protection-risks.md) detected on the user's account, like leaked credentials. 

#### How to investigate risky users?

To view and investigate risky users, navigate to the Risky users report and use the filters to manage the results. There's an option at the top of the page to add other columns such as risk level, status, and risk detail.

![X]()

When administrators select an individual user, the Risky user details pane appears. Risky user details provide information like: user ID, office location, recent risky sign-in, detections not linked to a sign, and risk history. The Risk history tab shows the events that led to a user risk change in the last 90 days. This list includes risk detections that increased the user's risk. It can also include user or admin remediation actions that lowered the user's risk; for example, a user resetting their password or an admin dismissing the risk.

![X]()

If you have Copilot for Security, you have access to a summary in natural language including: why the user risk level was elevated, guidance on how to mitigate and respond, and links to other helpful items or documentation. https://learn.microsoft.com/en-us/entra/fundamentals/copilot-entra-risky-user-summarization

![X]()

With the information provided by the Risky users report, administrators can view:

- User risk that was remediated, dismissed, or is still currently at risk and needs investigation
- Details about detections
- Risky sign-ins associated to a given user
- Risk history

Administrators can then choose to take action on these events and choose to:

- Reset the user password, which revokes user's current sessions
- Confirm user compromise if the user risk is a true positive. ID Protection sets the user risk to high and adds a new detection, Admin confirmed user compromised.
- Confirm user safe if the user risk is a false positive. ID Protection moves the user risk to none.
- Dismiss user risk for benign positive user risk.
- Block user from signing in if attacker has access to password or ability to perform MFA
- Investigate further using Microsoft Defender for Identity by selecting a user and clicking on the ellipsis (...) in the top right hand corner of the Risky User Details pane. https://learn.microsoft.com/en-us/entra/id-protection/howto-identity-protection-investigate-risk#investigate-risk-with-microsoft-365-defender

![X]()

## Risky sign-ins report

The risky sign-ins report contains filterable data for up to the past 30 days (one month). ID Protection evaluates risk for all authentication flows, whether it's interactive or non-interactive. The Risky sign-ins report shows both interactive and non-interactive sign-ins. To modify this view, use the "sign-in type" filter.

![X]()

With the information provided by the Risky sign-ins report, administrators can view:

- Sign-ins that are at risk, confirmed compromised, confirmed safe, dismissed, or remediated.
- Real-time and aggregate risk levels associated with sign-in attempts.
- Detection types triggered
- Conditional Access policies applied
- MFA details
- Device information
- Application information
- Location information

Administrators can then choose to take action on these events and provide feedback. Administrators can choose to:

- Confirm sign-in or user risk as compromised if risk is a true positive.
- Confirm sign-in or user risk as safe if the risk is a false positive. Similar sign-ins shouldn't be considered risky in the future.
- Dismiss sign-in or user risk if risk is a benign true positive. Similar sign-ins should continue being evaluated for risk going forward. You might use this option during an internal security penetration test.

To learn more about when to take each of these actions visit How does Microsoft use my risk feedback? https://learn.microsoft.com/en-us/entra/id-protection/howto-identity-protection-risk-feedback#how-does-microsoft-use-my-risk-feedback

## Risk detections report

The Risk detections report contains filterable data for up to the past 90 days (three months).

![X]()

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
1. To reduce false positives, add corporate VPNs and IP address ranges to named locations.
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

![X]()

Once the risk is contained, more investigation might be required to mark the risk as safe, compromised or to dismiss it. To come to a confident conclusion, it might be necessary to: have a conversation with the user in question, review the sign-in logs, review the audit logs, or query risk logs in Log Analytics. The following outlines recommended actions during this phase of the investigation:

1. Check the logs and validate whether the activity is normal for the given user.
   1. Look at the user's past activities including the following properties to see if they're normal for the given user.
      1. Application
      1. Device - Is the device registered or compliant?
      1. Location - Is the user traveling to a different location or accessing devices from multiple locations?
      1. IP address
      1. User agent string
   1. If you have access to other security tools like Microsoft Sentinel, check for corresponding alerts that might indicate a larger issue.
   1. Organizations with access to Microsoft 365 Defender can follow a user risk event through other related alerts, incidents, and the MITRE ATT&CK chain.
      1. To navigate from the Risky users report, select the user in the Risky users report and select the ellipsis (...) in the toolbar then choose Investigate with Microsoft 365 Defender.
1. Reach out to the user to confirm if they recognize the sign-in; however, consider methods such as email or Teams might be compromised.
   1. Confirm the information you have such as:
      1. Timestamp
      1. Application
      1. Device
      1. Location
      1. IP address
1. Depending on the results of the investigation, mark the user or sign-in as confirmed compromised, confirmed safe, or dismiss the risk.
1. Enable or edit Risk-based Conditional Access policies to prevent similar attacks or to address any gaps in coverage.

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
   1. **Recommended action**: Confirm sign-in as safe
1. If you're able to confirm that the user recently traveled to the destination mentioned detailed in the alert:
   1. **Recommended action**: Confirm sign-in as safe
1. If you're able to confirm that the IP address range is from a sanctioned VPN.
   1. **Recommended action**: Confirm sign-in as safe and add the VPN IP address range to named locations in Microsoft Entra ID and Microsoft Defender for Cloud Apps.

#### Investigating anomalous token and token issuer anomaly detections

1. If you're able to confirm that the activity wasn't performed by a legitimate user using a combination of risk alert, location, application, IP address, User Agent, or other characteristics that are unexpected for the user:
   1. **Recommended action**: Mark the sign-in as compromised, and invoke a password reset if not already performed by self-remediation. Block the user if an attacker has access to reset password or perform.
   1. **Recommended action**: Set up Risk-based Conditional Access policy to require password reset, perform MFA, or block access for all high-risk sign-ins.
1. If you're able to confirm location, application, IP address, User Agent, or other characteristics are expected for the user and there aren't other indications of compromise:
   1. **Recommended action**: Allow the user to self-remediate with a Conditional Access risk policy or have an admin confirm sign-in as safe.
1. For further investigation of token based detections, see the article Token tactics: How to prevent, detect, and respond to cloud token theft and the Token theft investigation playbook.

#### Investigating suspicious browser detections

- Browser isn't commonly used by the user or activity within the browser doesn't match the users normally behavior.
   - **Recommended action**: Confirm the sign-in as compromised, and invoke a password reset if not already performed by self-remediation. Block the user if an attacker has access to reset password or perform MFA.
   - **Recommended action**: Set up Risk-based Conditional Access policy to require password reset, perform MFA, or block access for all high-risk sign-ins.

#### Investigating malicious IP address detections

1. If you're able to confirm that the activity wasn't performed by a legitimate user:
   1. **Recommended action**: Confirm the sign-in as compromised, and invoke a password reset if not already performed by self-remediation. Block the user if an attacker has access to reset password or perform MFA and reset password and revoke all tokens.
   1. **Recommended action**: Set up Risk-based Conditional Access policy to require password reset or perform MFA for all high-risk sign-ins.
1. If a user is known to use the IP address in the scope of their duties:
   1. **Recommended action**: Confirm sign-in as safe

#### Investigating password spray detections

1. If you're able to confirm that the activity wasn't performed by a legitimate user:
   1. **Recommended action**: Mark the sign-in as compromised, and invoke a password reset if not already performed by self-remediation. Block the user if an attacker has access to reset password or perform MFA and reset password and revoke all tokens.
1. If a user is known to use the IP address in the scope of their duties:
   1. **Recommended action**: Confirm sign-in safe
1. If you're able to confirm that the account isn't compromised and see no brute force or password spray indicators against the account.
   1. **Recommended action**: Allow the user to self-remediate with a Conditional Access risk policy or have an admin confirm sign-in as safe.

For further investigation of password spray risk detections, see the article Guidance for identifying and investigating password spray attacks.

#### Investigating leaked credentials detections

- If this detection identified a leaked credential for a user:
   - **Recommended action**: Confirm the user as compromised, and invoke a password reset if not already performed by self-remediation. Block the user if an attacker has access to reset password or perform MFA and reset password and revoke all tokens.

## Next steps

- [Remediate and unblock users](howto-identity-protection-remediate-unblock.md)
- [Policies available to mitigate risks](concept-identity-protection-policies.md)
- [Enable sign-in and user risk policies](howto-identity-protection-configure-risk-policies.md)
