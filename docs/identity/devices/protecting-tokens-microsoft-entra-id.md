---
title: Protecting Tokens in Microsoft Entra ID
description: To protect against token theft and replay attacks, explore the types of tokens used in Microsoft Entra and their role in authentication.
ms.service: entra-id
ms.subservice: devices
ms.topic: conceptual
ms.date: 04/24/2025

ms.author: jfields
author: jenniferf-skc
manager: femila
ms.reviewer: jbley 
---

# Protecting tokens in Microsoft Entra

This article is a continuation to [Understanding tokens in Microsoft Entra ID](concept-tokens-microsoft-entra-id.md). This article assumes you've read Understanding tokens in Microsoft Entra ID and provides concrete steps you can take to mitigate the risk of successful token theft/replay attacks in your environment.

The recommendations of this article span across multiple Microsoft technology solutions which have a range of licensing requirements.
Ensure that you've the proper licensing for:

- [Conditional Access](../conditional-access/overview.md#license-requirements)
- [Microsoft Entra Internet Access for Microsoft services](../../global-secure-access/overview-what-is-global-secure-access.md#licensing-overview)
- [Microsoft Entra ID Protection](../../id-protection/overview-identity-protection.md#license-requirements)
- [Token Protection](../conditional-access/concept-token-protection.md#requirements)
- [Microsoft Intune (minimum Plan 1)](/intune//intune-service/fundamentals/licenses#microsoft-intune-plan-1)
- [Microsoft Defender for Endpoint XDR](/defender-xdr/prerequisites#licensing-requirements)

## Defense-in-depth strategy against token theft

There are several capabilities you can enable to reduce your attack surface area and reduce the risk of successful token compromise. In the next sections we'll cover many Microsoft security capabilities that fall into one of three categories:

- **Minimize risk**: Harden or reduce the attack surface making successful token theft more difficult.
- **Detect + Mitigate**: Detect successful token theft and configure automatic mitigation if possible.
- **Protect against replay**: Block replay or reduce the impact of successful token theft. 

The following is a high-level summary capturing the key areas organizations should focus on as part of their token theft protection strategy.

:::image type="content" source="media/protecting-tokens-microsoft-entra-id/defense-against-attacks.png" alt-text="Diagram showing defense strategies against token theft.":::

## Token Theft – minimize risk

Preventing a successful token theft incident from occurring in the first place is the most effective way to protect your organization. Organizations should harden devices against device-based token exfiltration methods using Microsoft Defender for Endpoint and Microsoft Intune. Organizations should also deploy controls to prevent users from accessing malicious or risky destinations on the internet.

### Harden your devices

Perform the following configurations and deployments to harden all devices/endpoints as frontline of defense against malware-based token theft. Before you get started, ensure that your devices are enrolled with Intune, and that [Microsoft Defender for Endpoint](/defender-endpoint/mde-planning-guide) is deployed.

|Control | Windows 10/11 | macOS | Linux|
|------|------|------|------|
| [Enable Microsoft Defender Antivirus always-on protection](/defender-endpoint/configure-real-time-protection-microsoft-defender-antivirus) for real-time protection, behavior monitoring, and heuristics to identify malware based on known suspicious and malicious activities. | X | X  | X  |
| [Enable Microsoft Defender Antivirus cloud protection](/defender-endpoint/enable-cloud-protection-microsoft-defender-antivirus) to help protect against malware on your endpoints and across your network. | X | X | X |
| [Enable network protection in Microsoft Defender for Endpoint](/defender-endpoint/network-protection) to protect devices from certain Internet-based events by preventing connections to malicious or suspicious sites. | X | X | X |
| [Enable tamper protection in Microsoft Defender for Endpoint](/defender-endpoint/prevent-changes-to-security-settings-with-tamper-protection) to protect certain security settings, such as virus and threat protection, from being disabled or changed.  | X | X | - |
| [Create a device compliance policy in Intune](/intune/intune-service/protect/advanced-threat-protection-configure) that requires the machine risk level designation by Microsoft Defender for Endpoint as *low* or *clear* for compliance. | X| X | - |

Even with device hardening policies in place, organizations must [create a Conditional Access policy](../conditional-access/policy-all-users-device-compliance.md) that requires users to use a **compliant device** to access all resources. This ensures your devices have successfully deployed your device-hardening configurations and that users can't access applications and resources from unmanaged or insecure devices.

### Other configurations for Windows

-  [Configure Credential Guard](/windows/security/identity-protection/credential-guard/configure) to isolate the Local Security Authority, protecting against credential theft from memory. 
- Review your [Windows Enrollment Attestation](/intune/intune-service/enrollment/windows-enrollment-attestation) report. Validate your Windows devices meet your TPM requirements. Take corrective action on any device that fails the TPM attestation.

### Other configurations for macOS

- [Disable iCloud Keychain sync with Microsoft Intune](/intune/intune-service/configuration/device-restrictions-macos#settings-apply-to-all-enrollment-types-1) to prevent synchronization of Entra tokens that may be stored in Keychain.
- [Enable Microsoft Enterprise SSO plug-in for Apple devices](../../identity-platform/apple-sso-plugin.md) to enable Enterprise Apps to leverage the Primary Refresh Token (PRT) for authentication.
- [Configure Platform SSO for macOS devices](/intune/intune-service/configuration/platform-sso-macos) (secure enclave) to provide secure, phishing-resistant authentication to Mac devices using hardware-bound cryptographic keys. 


### Harden mobile devices

Mobile devices such as iOS and Android can be hardened using [mobile threat defense](/defender-business/mdb-mtd).
Mobile threat defense includes a range of capabilities that can protect against compromised devices, and web threats that can block malware from being installed in the first place, preventing token exfiltration (and other threats) early in the kill chain.

### Microsoft Defender XDR Attack Disruption

Adversary-in-the-middle (AiTM) is a covered scenario in Microsoft Defender XDR Attack disruption, which provides coordinated threat defense early in the kill chain of an attack. Deploy all Defender XDR workloads (Defender for Identity, Defender for Office, and Defender for Cloud Apps) and ensure Attack Disruption is configured in Microsoft Defender XDR by following all documented [pre-requisites and configurations](/defender-xdr/configure-attack-disruption). Attack disruption detects AiTM attacks at an early stage and disrupt the attack by applying mitigating security controls automatically to endpoints and identities.

### Harden against internet threats

Organizations who use Microsoft Edge should enable [Microsoft Defender SmartScreen](/deployedge/microsoft-edge-security-smartscreen).
Microsoft Defender SmartScreen provides an early warning system against websites that might engage in phishing attacks or attempt to distribute malware through a focused attack.

Microsoft Entra Internet Access provides more protection covering the entire Internet. Organizations can deploy Global Secure
Access (GSA) clients to managed devices to block malicious and/or unauthorized web content using [web content filtering](../../global-secure-access/how-to-configure-web-content-filtering.md).
This reduces the likelihood of users navigating to malicious websites which can lead to the installation of malware or otherwise compromising
the device. Administrators should, at minimum, block the *illegal software* category but should also review and consider blocking all [liability web categories](../../global-secure-access/reference-web-content-filtering-categories.md#liability).

### Restrict use of device code flow

Device code flow is particularly useful for devices that have limited input capabilities or lack a web browser. However, device code flow can be used as part of a phishing attack or to access corporate resources on unmanaged devices. You can configure the device code flow control along with other controls in your Conditional Access policies. For example, if device code flow is used for android-based conference room devices, you might choose to block device code flow everywhere except for android devices in a specific network location. 

You should only allow device code flow where necessary. Microsoft recommends blocking device code flow wherever possible.

[Learn more about Conditional Access Authentication flows](../conditional-access/concept-authentication-flows.md#device-code-flow).


## Token Theft - detect and mitigate

Organizations should actively monitor for successful or attempted token theft attacks. There are many alerts generated from various Microsoft products that can indicate potential token theft or account compromise. A high-level summary of these detections is listed below. For an in-depth guide on how to monitor for, detect, and respond to identified token theft using a SIEM, refer to the [Token theft playbook](/security/operations/token-theft-playbook).

### Conditional Access Policies

Organizations should configure the following Conditional Access policies:

- Require interactive reauthentication for sensitive operations (authentication context)
- Require interactive authentication for risky sign-ins
- Detect and remediate high-risk users

These Conditional Access policies provide more automated token theft remediation and/or address other threat vectors that could be used in token-based
attacks.

**Require interactive reauthentication for sensitive operations**

Organizations can configure certain actions with authentication contexts to trigger the evaluation of Conditional Access policies outside of the normal authentication flows. For example, a Conditional
Access policy can be configured to evaluate when an administrator activates a role in Privileged Identity Management (PIM) or when a user performs a specific action within an application. Administrators should
configure a Conditional Access policy that requires interactive phishing-resistant authentication (sign-in frequency set to every time) for authentication context actions deemed sensitive. If the attacker is
unable to reauthenticate, access is denied, preventing the stolen sign-in session from being used to complete the sensitive operation.

[Learn how to configure Authentication Context in Conditional Access](../conditional-access/concept-conditional-access-cloud-apps.md#authentication-context).

[Learn how to use Authentication Context in applications (developer guidance)](../../identity-platform/developer-guide-conditional-access-authentication-context.md).

**Require interactive authentication for risky sign-ins**

With Entra ID Identity Protection, enhanced by more detections from Microsoft Defender for Endpoint, Entra ID can detect suspicious sign-in attempts in real time. For instance, if an attacker steals and attempts to replay a refresh token, Entra ID Identity Protection may identify that the sign-in has unfamiliar properties and elevate the sign-in risk level for this event. Administrators should configure a Conditional Access policy that requires interactive phishing-resistant authentication (sign-in frequency set to every time) for medium or higher sign-in risk levels. If the attacker is unable to reauthenticate, access is denied, preventing the stolen sign-in session from being used to gain or extend unauthorized access.

[Learn how to configure Risk-Based Conditional Access policies](../../id-protection/howto-identity-protection-configure-risk-policies.md).

**Detect and remediate high-risk users**

With Entra ID Identity Protection, enhanced by more detections from Microsoft Defender for Endpoint, Entra ID generates a user risk score for every account, indicating the level of certainty regarding
whether the account has been compromised. If Entra ID or Microsoft Defender for Endpoint detects signs of successful token theft, it's
highly likely that the user’s risk score will be set to *High*. When this occurs, you can automatically block or remediate the account (for example, secure password change), preventing the adversary from further
exploiting any unauthorized access they may have achieved.

Applications that support continuous access evaluation automatically revoke access in near-real time when high user risk is detected, issuing a redirect back to Entra ID for reauthentication and
reauthorization.

[Learn how to configure Risk-Based Conditional Access policies](../../id-protection/howto-identity-protection-configure-risk-policies.md).

### Microsoft Defender XDR

Deploy Defender XDR workloads to alert on suspicious or anomalous behaviors surrounding token theft.

- Use [Defender for Office 365](https://www.microsoft.com/en-us/security/business/siem-and-xdr/microsoft-defender-office-365) to detect and block malicious emails, links, and files
- Use Microsoft Defender for Cloud Apps [connectors](/defender-cloud-apps/enable-instant-visibility-protection-and-governance-actions-for-your-apps), Microsoft 365 Defender raises AiTM-related alerts in multiple scenarios. For Entra ID customers using Microsoft Edge, attempts by attackers to replay session cookies to access cloud applications are detected by Defender for Cloud Apps connectors for [Office 365](/defender-cloud-apps/connect-office-365) and [Azure](/defender-cloud-apps/connect-azure). 

Microsoft Defender XDR when using Defender for Cloud Apps connectors and Defender for Endpoint can raise these alerts:

- Stolen session cookie was used
- Possible AiTM phishing attempt

### Other detections

[**Entra ID Protection risk detections**](../../id-protection/concept-identity-protection-risks.md)
- Anomalous Token
- Attacker in the Middle
- Unfamiliar sign-in properties

[**Microsoft Defender for Office 365 detections**](/defender-xdr/alert-policies#threat-management-alert-policies)
- Email messages containing malicious file removed after delivery 
- Email messages from a campaign removed after delivery 
- A potentially malicious URL click was detected
- A user clicked through to a potentially malicious URL 

[**Microsoft Defender for Cloud Apps anomaly detections**](/defender-cloud-apps/anomaly-detection-policy)

- Impossible travel activity
- Activity from infrequent country

[**Microsoft Defender XDR Business Email Compromise mitigation**](https://www.microsoft.com/en-us/security/blog/2023/06/08/detecting-and-mitigating-a-multi-stage-aitm-phishing-and-bec-campaign/)

- Business Email Compromise (BEC) related credential harvesting attack
- Suspicious phishing emails sent by BEC-related user

## Token Theft – protect against replay

If an adversary is able to successfully steal a token, organizations can enable certain capabilities to automatically reduce the
exposure of the stolen token from being replayed, thus defeating the attack. These capabilities include:

- Enforcing Token Protection in Conditional Access to secure sign-in sessions
- Enforcing access is only allowed via secure networks

### Enforce Token Protection

**Entra Primary Refresh Token**

For devices which are Entra-joined or Entra-registered, Entra ID generates a multi-application Refresh Token used for application SSO, also known as the [Primary Refresh Token (PRT)](concept-primary-refresh-token.md).

Primary Refresh Tokens (PRTs) are protected with a cryptographically secure tie between the PRT and the device (client secret) to which the PRT is issued. On Windows devices, the client secret is securely stored on platform-specific hardware such as Trusted Platform Modules (TPM). Today, non-Windows devices store the secret in software.

**Token Protection in Conditional Access**

Enforcing Token Protection in Conditional Access ensures that only refresh tokens which are cryptographically bound to the device are used. Bearer refresh tokens, which can be used from any device, are automatically rejected. This method provides the highest level of security for protecting sign-in sessions, as the token can only be used from the device it was originally issued to. At the time of publication of this post, Token Protection in Conditional Access is available for Windows native applications connecting to Microsoft Teams, SharePoint, and Exchange. We're continuously working to expand the scope of Token Protection by adding support for extra platforms, applications, and resources. For an updated list of supported apps and resources, please refer to this article. [Token protection in Microsoft Entra Conditional Access - Microsoft Entra ID \| Microsoft Learn](../conditional-access/concept-token-protection.md#requirements).

Organizations are encouraged to pilot and deploy Token Protection for all supported applications, devices, and platforms. Applications that don't support Token Protection should be safeguarded with other
policies such as network-based policies.

Check the following article to learn more and get deployment guidance:
[Learn how to configure Token Protection](../conditional-access/concept-token-protection.md).

> [!NOTE]
> Token Protection in Conditional Access requires the use of PRTs. Scenarios such as the use of unregistered devices aren't available as those devices don't have a PRT.

> [!NOTE]
> Entra Token Protection only applies to the user who signed into the device. For example, if you unlock a Windows device with a standard account but then access a resource authenticating under a different account, the latter identity can't be protected by Entra Token Protection as they don't have a valid PRT available.

### Implement network-based enforcements

While Entra Token Protection is the most secure method of protecting sign-in session tokens, it's limited in its scope of application coverage and only applies to the user who signed into the device. To further reduce the attack surface, organizations can implement network-based enforcement policies which can cover a broader range of applications, often covering all Enterprise apps. Network-based policies
can also cover additional identities beyond the user who is signed in to the device.

Network-based policies prevent sign-in session artifacts (such as refresh tokens) from being replayed outside of designated networks, effectively thwarting token theft and replay attacks that exfiltrate sign-in sessions beyond your organizational boundary. While internal threat vectors may still pose a risk due to their access to the same network, forcing threat actors to operate within your organizational
boundary significantly increases the likelihood of detecting and mitigating threats through other security controls.

Additionally, in certain scenarios such as with applications that support Continuous Access Evaluation, these measures can also be an effective way to mitigate token theft and replay of application session tokens such as access tokens.

**Protect Sign-in sessions with Global Secure Access**

Organizations should deploy Global Secure Access to establish a secure network connection between client devices and resources, also known as a compliant network. Administrators can then create a Conditional Access policy that mandates the use of a compliant network to access any Enterprise App integrated with Entra ID. This measure prevents the replay of sign-in session artifacts from devices not managed by the
organization.

**Protect Sign-in Sessions with traditional network controls**

As an alternative to Compliant network check, organizations can utilize traditional network solutions such as VPNs to protect sign-in sessions. Administrators can then create a location-based Conditional Access policy that restricts authentication attempts to specific egress IP addresses. However, organizations should consider the performance implications and costs associated with routing traffic through a corporate network. Therefore, Microsoft recommends using Global Secure Access, a fully secure, globally distributed Security Service Edge solution.

[Learn how to configure location-based Conditional Access policies with Entra ID](../conditional-access/policy-block-by-location.md).

**Protect App Sessions with network-based enforcements**

By creating a location-based Conditional Access policies restricting access to specific egress IP addresses, organizations can also protect
some of their app sessions. A subset of Microsoft Applications, such as SharePoint Online and Exchange Online, use the [Continuous Access Evaluation](../conditional-access/concept-continuous-access-evaluation.md) (CAE) protocol. CAE-aware apps evaluate network-based enforcements and revoke app session artifacts replayed outside of the trusted network in
near-real time. Organizations can further improve IP-based network enforcements by [configuring strict location policies with CAE](../conditional-access/concept-continuous-access-evaluation-strict-enforcement.md) to ensure that traffic for CAE-capable apps are only accessible from trusted networks.

For applications that aren't CAE-capable, organizations can protect their app sessions with controls available on the application side. For instance, some applications support IP-based enforcement at the application layer in addition to those enforced by the Identity Provider (IdP). The application then rejects the use of any app session artifact used outside the trusted network. Tunneling app-specific traffic via company-owned networks can be achieved through Source IP Anchoring with Global Secure Access, as well as other traditional network solutions such as VPNs.

[Learn about Source IP Anchoring with Global Secure Access](../../global-secure-access/source-ip-anchoring.md).

## Summary of token protection strategy

In summary, protecting tokens in Microsoft Entra involves a multi-layered defense-in-depth strategy to guard against token theft and replay attacks. This includes hardening devices against malware, leveraging device-based and risk-based Conditional Access, enforcing device-bound tokens, and implementing network-based enforcements. Additionally, organizations should deploy phishing-resistant multifactor authentication, monitor for suspicious sign-in attempts, and configure Conditional Access policies to require reauthentication for sensitive operations. By following these guidelines, organizations can significantly reduce the risk of unauthorized access and ensure the security of their sign-in sessions and app sessions.

## Next steps

- [Microsoft Entra Conditional Access: Token protection](../conditional-access/concept-token-protection.md)
