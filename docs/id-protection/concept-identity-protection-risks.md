---
title: What are risk detections?
description: Explore the full list of risk detections and their corresponding risk event types, along with a description of each risk event type.

ms.service: entra-id-protection

ms.topic: article
ms.date: 09/11/2025

author: shlipsey3
ms.author: sarahlipsey
manager: pmwongera 
ms.reviewer: cokoopma
---

# What are risk detections?

Microsoft Entra ID Protection can provide a broad range of risk detections that can be used to identify suspicious activity in your organization. The tables included in this article summarize the list of sign-in and user risk detections, including the license requirements or if the detection happens in real-time or offline. Further details about each risk detection can be found following the tables.

- Full details on most risk detections require Microsoft Entra ID P2.
    - Customers without Microsoft Entra ID P2 licenses receive detections titled **Additional risk detected** without risk detection details.
    - For more information, see the [license requirements](overview-identity-protection.md#license-requirements). 
- For information on workload identity risk detections, see [Securing workload identities](/entra/id-protection/concept-workload-identity-risk).

> [!NOTE]
> For details on real-time vs offline detections and risk levels, see [**Risk detection types and levels**](concept-risk-detection-types.md).

## Sign-in risk detections mapped to riskEventType 

Select a risk detection from the list to view the description of the risk detection, how it works, and the license requirements. In the table, *Premium* indicates the detection requires at least a Microsoft Entra ID P2 license. *Nonpremium* indicates the detection is available with Microsoft Entra ID Free. The `riskEventType` column indicates the value that appears in Microsoft Graph API queries.

| Sign-in risk detection | Detection type | Type | riskEventType |
| --- | --- | --- | --- |
| [Activity from anonymous IP address](#activity-from-anonymous-ip-address) | Offline | Premium | riskyIPAddress |
| [Additional risk detected (sign-in)](#additional-risk-detected-sign-in) | Real-time or Offline | Nonpremium | generic ^ |
| [Admin confirmed user compromised](#admin-confirmed-user-compromised) | Offline | Nonpremium | adminConfirmedUserCompromised |
| [Anomalous Token (sign-in)](#anomalous-token-sign-in) | Real-time or Offline | Premium | anomalousToken | 
| [Anonymous IP address](#anonymous-ip-address) | Real-time | Nonpremium | anonymizedIPAddress |
| [Atypical travel](#atypical-travel) | Offline | Premium | unlikelyTravel |
| [Impossible travel](#impossible-travel) | Offline | Premium | mcasImpossibleTravel |
| [Malicious IP address](#malicious-ip-address) | Offline | Premium | maliciousIPAddress |
| [Mass Access to Sensitive Files](#mass-access-to-sensitive-files) | Offline | Premium | mcasFinSuspiciousFileAccess |
| [Microsoft Entra threat intelligence (sign-in)](#microsoft-entra-threat-intelligence-sign-in) | Real-time or Offline | Nonpremium | investigationsThreatIntelligence |
| [New country](#new-country) | Offline | Premium | newCountry |
| [Password spray](#password-spray) | Real-time or Offline | Premium | passwordSpray |
| [Suspicious browser](#suspicious-browser) | Offline | Premium | suspiciousBrowser |
| [Suspicious inbox forwarding](#suspicious-inbox-forwarding) | Offline | Premium | suspiciousInboxForwarding |
| [Suspicious inbox manipulation rules](#suspicious-inbox-manipulation-rules) | Offline | Premium | mcasSuspiciousInboxManipulationRules |
| [Token issuer anomaly](#token-issuer-anomaly) | Offline | Premium | tokenIssuerAnomaly |
| [Unfamiliar sign-in properties](#unfamiliar-sign-in-properties) | Real-time | Premium | unfamiliarFeatures |
| [Verified threat actor IP](#verified-threat-actor-ip) | Real-time | Premium | nationStateIP |

^ The riskEventType for **Additional risk detected** detection is *generic* for tenants with Microsoft Entra ID Free or Microsoft Entra ID P1. We detected something risky, but the details aren't available without a Microsoft Entra ID P2 license.

## User risk detections mapped to riskEventType 

Select a risk detection from the list to view the description of the risk detection, how it works, and the license requirements.

| User risk detection | Detection type | Type | riskEventType |
| --- | --- | --- | --- |
| [Additional risk detected (user)](#additional-risk-detected-user) | Real-time or Offline | Nonpremium | generic ^ |
| [Anomalous Token (user)](#anomalous-token-user) | Real-time or Offline | Premium | anomalousToken | 
| [Anomalous user activity](#anomalous-user-activity) | Offline | Premium | anomalousUserActivity |
| [Attacker in the Middle](#attacker-in-the-middle) | Offline | Premium | attackerinTheMiddle |
| [Leaked credentials](#leaked-credentials) | Offline | Nonpremium | leakedCredentials |
| [Microsoft Entra threat intelligence (user)](#microsoft-entra-threat-intelligence-user) | Real-time or Offline | Nonpremium | investigationsThreatIntelligence |
| [Possible attempt to access Primary Refresh Token (PRT)](#possible-attempt-to-access-primary-refresh-token-prt) | Offline | Premium | attemptedPrtAccess |
| [Suspicious API Traffic](#suspicious-api-traffic) | Offline | Premium | suspiciousAPITraffic |
| [Suspicious sending patterns](#suspicious-sending-patterns) | Offline | Premium | suspiciousSendingPatterns |
| [User reported suspicious activity](#user-reported-suspicious-activity) | Offline | Premium | userReportedSuspiciousActivity |

^ The riskEventType for **Additional risk detected** detection is *generic* for tenants with Microsoft Entra ID Free or Microsoft Entra ID P1. We detected something risky, but the details aren't available without a Microsoft Entra ID P2 license.

## Sign-in risk detections 

### Activity from anonymous IP address 

This detection is discovered using information provided by [Microsoft Defender for Cloud Apps](/defender-cloud-apps/anomaly-detection-policy#activity-from-anonymous-ip-addresses). This detection identifies that users were active from an IP address identified as an anonymous proxy IP address. 

- Calculated offline
- License requirement:
    - Microsoft Entra ID P2 and a standalone license for Microsoft Defender for Cloud Apps
    - Microsoft 365 E5 with Enterprise Mobility + Security E5

### Additional risk detected (sign-in) 

This detection indicates that one of the premium detections was triggered. Since premium detections are only visible to Microsoft Entra ID P2 customers, they are labeled as **Additional risk detected** for users without Microsoft Entra ID P2 licenses. 

- Calculated in real-time or offline
- License requirement: Microsoft Entra ID Free or Microsoft Entra ID P1

### Admin confirmed user compromised 

This detection indicates an administrator selected **Confirm user compromised** in the risky users UI or using riskyUsers API. To see which administrator confirmed this user compromised, check the user's risk history (via UI or API). 

- Calculated offline
- License requirement: Microsoft Entra ID Free or Microsoft Entra ID P1

### Anomalous token (sign-in)
<a name='anomalous-token'></a>

This detection indicates abnormal characteristics in the token, such as an unusual lifetime or a token played from an unfamiliar location. This detection covers "Session Tokens" and "Refresh Tokens." If the location, application, IP address, User Agent, or other characteristics are unexpected for the user, the administrator should consider this risk as an indicator of potential token replay. 

Anomalous token was historically tuned to incur more noise than other detections. Recent improvements to the detection have reduced the noise; however, there's still a higher than normal chance that some of the sessions flagged by this detection are false positives at low and medium risk levels. 

- Calculated in real-time or offline
- License requirement: Microsoft Entra ID P2
- [Tips for investigating anomalous token detections.](howto-identity-protection-investigate-risk.md#investigating-anomalous-token-and-token-issuer-anomaly-detections)

### Anonymous IP address 

This risk detection type indicates sign-ins from an anonymous IP address (for example, Tor browser or anonymous VPN). These IP addresses are typically used by actors who want to hide their sign-in information (IP address, location, device, and so on) for potentially malicious intent. 

- Calculated in real-time
- License requirement: Microsoft Entra ID Free or Microsoft Entra ID P1

### Atypical travel 

This risk detection type identifies two sign-ins originating from geographically distant locations, where at least one of the locations might also be atypical for the user, given past behavior. The algorithm takes into account multiple factors including the time between the two sign-ins and the time it would take for the user to travel from the first location to the second. This risk might indicate that a different user is using the same credentials. 

The algorithm ignores obvious "false positives" contributing to the impossible travel conditions, such as VPNs and locations regularly used by other users in the organization. The system has an initial learning period of the earliest of 14 days or 10 logins, during which it learns a new user's sign-in behavior. 

- Calculated offline
- License requirement: Microsoft Entra ID P2
- [Tips for investigating atypical travel detections.](howto-identity-protection-investigate-risk.md#investigating-atypical-travel-detections)

### Impossible travel 

This detection is discovered using information provided by [Microsoft Defender for Cloud Apps](/defender-cloud-apps/anomaly-detection-policy#impossible-travel). This detection identifies user activities (in a single or multiple sessions) originating from geographically distant locations within a time period shorter than the time it takes to travel from the first location to the second. This risk might indicate that a different user is using the same credentials. 

- Calculated offline
- License requirement: 
    - Microsoft Entra ID P2 and a standalone license for Microsoft Defender for Cloud Apps
    - Microsoft 365 E5 with Enterprise Mobility + Security E5

### Malicious IP address 

This detection indicates sign-in from a malicious IP address. An IP address is considered malicious based on high failure rates because of invalid credentials received from the IP address or other IP reputation sources. In some instances, this detection triggers on previous malicious activity.

- Calculated offline
- License requirement: Microsoft Entra ID P2
- [Tips for investigating malicious IP address detections.](howto-identity-protection-investigate-risk.md#investigating-malicious-ip-address-detections)

### Mass access to sensitive files 

This detection is discovered using information provided by [Microsoft Defender for Cloud Apps](/defender-cloud-apps/investigate-anomaly-alerts#unusual-file-access-by-user). This detection looks at your environment and triggers alerts when users access multiple files from Microsoft SharePoint Online or Microsoft OneDrive. An alert is triggered only if the number of accessed files is uncommon for the user and the files might contain sensitive information. 

- Calculated offline
- License requirement:
    - Microsoft Entra ID P2 and a standalone license for Microsoft Defender for Cloud Apps
    - Microsoft 365 E5 with Enterprise Mobility + Security E5

### Microsoft Entra threat intelligence (sign-in) 

Microsoft Entra threat intelligence indicates user activity that is unusual for the user or consistent with known attack patterns. This detection is based on Microsoft's internal and external threat intelligence sources. These detections show up as "Microsoft Entra threat intelligence" in logs and ID Protection reports.

- Calculated in real-time or offline
- License requirement: Microsoft Entra ID Free or Microsoft Entra ID P1
- [Tips for investigating Microsoft Entra threat intelligence detections.](howto-identity-protection-investigate-risk.md#microsoft-entra-threat-intelligence)

### New country 

This detection is discovered using information provided by [Microsoft Defender for Cloud Apps](/defender-cloud-apps/anomaly-detection-policy#activity-from-infrequent-country). This detection considers past activity locations to determine new and infrequent locations. The anomaly detection engine stores information about previous locations used by users in the organization. 

- Calculated offline
- License requirement:
    - Microsoft Entra ID P2 and a standalone license for Microsoft Defender for Cloud Apps
    - Microsoft 365 E5 with Enterprise Mobility + Security E5

### Password spray 

A password spray attack is where multiple identities are attacked using common passwords in a unified brute force manner. The risk detection is triggered when an account's password is valid and has an attempted sign in. This detection signals that the user's password was correctly identified through a password spray attack, not that the attacker was able to access any resources.

- Calculated in real-time or offline
- License requirement: Microsoft Entra ID P2
- [Tips for investigating password spray detections.](howto-identity-protection-investigate-risk.md#investigating-password-spray-detections)

### Suspicious browser	 

Suspicious browser detection indicates anomalous behavior based on suspicious sign-in activity across multiple tenants from different countries/regions in the same browser. 

- Calculated offline
- License requirement: Microsoft Entra ID P2
- [Tips for investigating suspicious browser detections.](howto-identity-protection-investigate-risk.md#investigating-suspicious-browser-detections)

### Suspicious inbox forwarding 

This detection is discovered using information provided by [Microsoft Defender for Cloud Apps](/defender-cloud-apps/anomaly-detection-policy#suspicious-inbox-forwarding). This detection looks for suspicious email forwarding rules, for example, if a user created an inbox rule that forwards a copy of all emails to an external address. 

- Calculated offline
- License requirement:
    - Microsoft Entra ID P2 and a standalone license for Microsoft Defender for Cloud Apps
    - Microsoft 365 E5 with Enterprise Mobility + Security E5

### Suspicious inbox manipulation rules 

This detection is discovered using information provided by [Microsoft Defender for Cloud Apps](/defender-cloud-apps/anomaly-detection-policy#suspicious-inbox-manipulation-rules). This detection looks at your environment and triggers alerts when suspicious rules that delete or move messages or folders are set on a user's inbox. This detection might indicate: a user's account is compromised, messages are being intentionally hidden, and the mailbox is being used to distribute spam or malware in your organization. 

- Calculated offline
- License requirement: 
    - Microsoft Entra ID P2 and a standalone license for Microsoft Defender for Cloud Apps
    - Microsoft 365 E5 with Enterprise Mobility + Security E5

### Token issuer anomaly 

This risk detection indicates the SAML token issuer for the associated SAML token is potentially compromised. The claims included in the token are unusual or match known attacker patterns. 

- Calculated offline
- License requirement: Microsoft Entra ID P2
- [Tips for investigating token issuer anomaly detections.](howto-identity-protection-investigate-risk.md#investigating-anomalous-token-and-token-issuer-anomaly-detections)

### Unfamiliar sign-in properties 

This risk detection type considers past sign-in history to look for anomalous sign-ins. The system stores information about previous sign-ins, and triggers a risk detection when a sign-in occurs with properties that are unfamiliar to the user. These properties can include IP, ASN, location, device, browser, and tenant IP subnet. Newly created users are in a "learning mode" period where the unfamiliar sign-in properties risk detection is turned off while our algorithms learn the user's behavior. The learning mode duration is dynamic and depends on how much time it takes the algorithm to gather enough information about the user's sign-in patterns. The minimum duration is five days. A user can go back into learning mode after a long period of inactivity. 

We also run this detection for basic authentication (or legacy protocols). Because these protocols don't have modern properties such as client ID, there's limited data to reduce false positives. We recommend our customers to move to modern authentication. 

Unfamiliar sign-in properties can be detected on both interactive and non-interactive sign-ins. When this detection is detected on non-interactive sign-ins, it deserves increased scrutiny due to the risk of token replay attacks. 

Selecting an unfamiliar sign-in properties risk allows you to see more info showing more detail about why this risk triggered.

- Calculated in real-time
- License requirement: Microsoft Entra ID P2

### Verified threat actor IP 

Calculated in real-time. This risk detection type indicates sign-in activity that is consistent with known IP addresses associated with nation state actors or cyber crime groups, based on data from the Microsoft Threat Intelligence Center (MSTIC). 

- Calculated in real-time
- License requirement: Microsoft Entra ID P2

## User risk detections 

### Additional risk detected (user) 

This detection indicates that one of the premium detections was detected. Since the premium detections are visible only to Microsoft Entra ID P2 customers, they're titled **Additional risk detected** for customers without Microsoft Entra ID P2 licenses. 

- Calculated in real-time or offline
- License requirement: Microsoft Entra ID Free or Microsoft Entra ID P1

### Anomalous token (user)

This detection indicates abnormal characteristics in the token, such as an unusual lifetime or a token played from an unfamiliar location. This detection covers "Session Tokens" and "Refresh Tokens." If the location, application, IP address, User Agent, or other characteristics are unexpected for the user, the administrator should consider this risk as an indicator of potential token replay. 

Anomalous token was historically tuned to incur more noise than other detections. Recent improvements to the detection have reduced the noise; however, there's still a higher than normal chance that some of the sessions flagged by this detection are false positives at low and medium risk levels.

- Calculated in real-time or offline
- License requirement: Microsoft Entra ID P2
- [Tips for investigating anomalous token detections.](howto-identity-protection-investigate-risk.md#investigating-anomalous-token-and-token-issuer-anomaly-detections)

### Anomalous user activity 

This risk detection baselines normal administrative user behavior in Microsoft Entra ID, and spots anomalous patterns of behavior like suspicious changes to the directory. The detection is triggered against the administrator making the change or the object that was changed. 

- Calculated offline
- License requirement: Microsoft Entra ID P2

### Attacker in the Middle 

Also referred to as Adversary in the Middle, this high precision detection is triggered when an authentication session is linked to a malicious reverse proxy. In this kind of attack, the adversary can intercept the user's credentials, including tokens issued to the user. The Microsoft Security Research team uses Microsoft 365 Defender for Office to capture the identified risk and raises the user to **High** risk. We recommend administrators manually investigate the user when this detection is triggered to ensure the risk is cleared. Clearing this risk might require secure password reset or revocation of existing sessions.

- Calculated offline
- License requirement:
    - Microsoft Entra ID P2 and a standalone license for Microsoft Defender for Cloud Apps
    - Microsoft 365 E5 with Enterprise Mobility + Security E5

### Leaked credentials 

This risk detection type indicates that the user's valid credentials leaked. When cybercriminals compromise valid passwords of legitimate users, they often share these gathered credentials. This sharing is typically done by posting publicly on the dark web, paste sites, or by trading and selling the credentials on the black market. When the Microsoft leaked credentials service acquires user credentials from the dark web, paste sites, or other sources, they're checked against Microsoft Entra users' current valid credentials to find valid matches. For more information about leaked credentials, see [FAQs](id-protection-faq.yml). 

- Calculated offline
- License requirement: Microsoft Entra ID Free or Microsoft Entra ID P1
- [Tips for investigating leaked credentials detections.](howto-identity-protection-investigate-risk.md#investigating-leaked-credentials-detections)

### Microsoft Entra threat intelligence (user) 

This risk detection type indicates user activity that is unusual for the user or consistent with known attack patterns. This detection is based on Microsoft's internal and external threat intelligence sources. 

- Calculated offline
- License requirement: Microsoft Entra ID Free or Microsoft Entra ID P1
- [Tips for investigating Microsoft Entra threat intelligence detections.](howto-identity-protection-investigate-risk.md#microsoft-entra-threat-intelligence)

### Possible attempt to access Primary Refresh Token (PRT) 

This risk detection type is discovered using information provided by Microsoft Defender for Endpoint (MDE). A Primary Refresh Token (PRT) is a key artifact of Microsoft Entra authentication on Windows 10, Windows Server 2016, and later versions, iOS, and Android devices. A PRT is a JSON Web Token (JWT) issued to Microsoft first-party token brokers to enable single sign-on (SSO) across the applications used on those devices. Attackers can attempt to access this resource to move laterally into an organization or perform credential theft. This detection moves users to high risk and only fires in organizations that deploy MDE. This detection is high risk and we recommend prompt remediation of these users. It appears infrequently in most organizations due to its low volume.  

- Calculated offline
- License requirement:
    - Microsoft Entra ID P2 and a standalone license for Microsoft Defender for Cloud Apps
    - Microsoft 365 E5 with Enterprise Mobility + Security E5

### Suspicious API traffic 

This risk detection is reported when abnormal GraphAPI traffic or directory enumeration is observed. Suspicious API traffic might suggest that a user is compromised and conducting reconnaissance in the environment. 

- Calculated offline
- License requirement: Microsoft Entra ID P2

### Suspicious sending patterns 

This risk detection type is discovered using information provided by [Microsoft Defender for Office 365 (MDO)](/defender-office-365/air-about). This alert is generated when someone in your organization sent suspicious email and is either at risk of being or is restricted from sending email. This detection moves users to medium risk and only fires in organizations that deploy MDO. This detection is low-volume and is seen infrequently in most organizations. 

- Calculated offline
- License requirement:
    - Microsoft Entra ID P2 and a standalone license for Microsoft Defender for Cloud Apps
    - Microsoft 365 E5 with Enterprise Mobility + Security E5

### User reported suspicious activity 

This risk detection is reported when a user denies a multifactor authentication (MFA) prompt and reports it as suspicious activity. An MFA prompt not initiated by a user might mean their credentials are compromised. 

- Calculated offline
- License requirement: Microsoft Entra ID P2
