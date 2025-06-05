---
title: Microsoft Entra configuration recommendations for HITRUST controls
description: Guidance on navigating details and recommendations for services and features to align with HITRUST controls
ms.service: entra
ms.subservice: standards
ms.topic: how-to
author: jricketts
ms.author: jricketts
manager: martinco
ms.reviewer: martinco
ms.date: 03/19/2024
ms.custom: it-pro
---

# Microsoft Entra configuration recommendations for HITRUST controls 

This article’s guidance helps you navigate details and provides recommendations of services and features in Microsoft Entra ID to support alignment with HITRUST controls. Use the information to help understand the Health Information Trust Alliance (HITRUST) framework, and support your responsibility of ensuring your organization is compliant with the Health Insurance Portability and Accountability Act of 1996 (HIPAA). Assessments involve working with certified HITRUST assessors who are knowledgeable about the framework and are required to help guide you through the process and understand the requirements. 

**Acronyms**

The following table lists the acronyms and their spelling in this article. 

| Acronym | Spelling |
| - | - |
|CE|Covered Entity|
|CSF|Common Security Framework|
|HIPAA|Health Insurance Portability and Accountability Act of 1996|
|HSR|HIPAA Security Rule|
|HITRUST|Health Information Trust Alliance|
|IAM|Identity and access management|
|IdP|Identity provider|
|ISO|International Organization for Standardization|
|ISMS|Information security management system|
|JEA|Just enough access|
|JML|Join, move, leave|
|MFA|Microsoft Entra multifactor authentication|
|NIST|National Institute of Standards and Technology, US Dept. of Commerce|
|PHI| Protected health information|
|PIM|Privileged Identity Management|
|SSO|Single sign-on|
|TAP|Temporary access pass|


## Health Information Trust Alliance

The HITRUST organization established the Common Security Framework (CSF) to standardize and streamline security and privacy requirements for organizations in the healthcare industry. HITRUST CSF was founded in 2007 to address the complex regulatory environment, security challenges, and privacy concerns that organizations face when handling personal data and protected health information (PHI) data. The CSF consists of 14 control categories comprising 49 control objectives, and 156 control specifics. It was built on the primary principles of International Organization for Standardization (ISO) 27001 and ISO 27002.  

The HITRUST MyCSF tool is available in [Azure Marketplace](https://azuremarketplace.microsoft.com/marketplace/apps/hitrust1666274640786.hitrust?exp=ubp8&tab=Overview). Use it to manage information security risks, data governance, to comply with information protection regulations, also adhere to national and international standards and best practices. 

> [!NOTE]
> ISO 27001 is a management standard that specifies the requirements for an information security management system (ISMS). ISO 27002 is a set of best practices to select and implement security controls in the ISO 27001 framework.

## HIPAA Security Rule

The [HIPAA Security Rule (HSR)](https://www.hhs.gov/hipaa/for-professionals/security/index.html#:~:text=The%20HIPAA%20Security%20Rule%20establishes,maintained%20by%20a%20covered%20entity.) establishes standards to protect an individual’s electronic personal health information created, received, used, or maintained by a Covered Entity (CE), which is a health plan, health care clearinghouse, or healthcare provider. The U.S. Department of Health and Human Services (HHS) manages the HSR. HHS requires administrative, physical, and technical safeguards to ensure the confidentiality, integrity, and security of electronic PHI. 

## HITRUST and HIPAA

HITRUST developed the CSF, which includes security and privacy standards to support healthcare regulations. CSF controls and best practices simplify the task of consolidating sources to ensure compliance with federal legislation, HIPAA security, and privacy rules. HITRUST CSF is a certifiable security and privacy framework with controls and requirements to demonstrate HIPAA compliance. Healthcare organizations widely adopted the framework. Use the following table to learn about controls.

| Control category | Control category name |
| - | - |
|0|Information Security Management Program |
|1|Access Control|
|2|Human Resource Security|
|3|Risk Management|
|4|Security Policy|
|5|Organization of Information Security|
|6|Compliance|
|7|Asset Management|
|8|Physical and Environmental Security|
|9|Communications and Operations Management |
|10|Information Systems Acquisition, Development and Maintenance |
|11|Information Security Incident Management |
|12|Business Continuity Management |
|13|Privacy Practices|

Learn more on [Microsoft Azure platform is HITRUST CSF certified](https://azure.microsoft.com/blog/microsoft-azure-achieves-hitrust-csf-certification/), which includes identity and access management: 

* [Microsoft Entra ID](~/fundamentals/whatis.md), formerly known as Azure Active Directory
* Rights management with [Microsoft Purview](https://techcommunity.microsoft.com/t5/healthcare-and-life-sciences/microsoft-purview-compliance-score-part-3-hitrust/ba-p/3614103)
* [Microsoft Entra multifactor authentication (MFA)](~/identity/authentication/concept-mfa-howitworks.md)

## Access control categories and recommendations

The following table has the access control category for identity and access management (IAM), and Microsoft Entra recommendations to help meet the control category requirements. Details are from the HITRUST [MyCSF v11](https://hitrustalliance.net/mycsf), which refers to the HIPAA security rule, added to the corresponding control.   

| HITRUST control, objective, and HSR | Microsoft Entra guidance and recommendation |
| - | - |
|**CSF Control V11**<br>01.b User Registration<br><br>**Control category**<br>Access Control – User Registration and De-Registration<br><br>**Control specification**<br>The organization uses a formal user registration and deregistration process to enable assignment of access rights.<br><br>**Objective name**<br>Authorized Access to Information Systems<br><br>**HIPAA Security Rule**<br>§ 164.308(a)(3)(ii)(A)<br>§ 164.308(a)(4)(i)<br>§ 164.308(a)(3)(ii)(B)<br>§ 164.308(a)(4)(ii)(C)<br>§ 164.308(a)(4)(ii)(B)<br>§ 164.308(a)(5)(ii)(D)<br>§ 164.312(a)(2)(i)<br>§ 164.312(a)(2)(ii)<br>§ 164.312(d) |[Microsoft Entra ID](~/fundamentals/whatis.md) is an identity platform for verification, [authentication](~/identity/authentication/overview-authentication.md), and credential management when an identity signs in to their device, application, or server. It’s a cloud-based identity and access management service with single sign-on (SSO), MFA, and [Conditional Access](~/identity/conditional-access/overview.md) to guard against security attacks. Authentication ensures only authorized identities gain access to resources and data.<br><br>[Lifecycle workflows](~/id-governance/understanding-lifecycle-workflows.md) enable identity governance to automate the joiner, mover, leaver (JML) lifecycle. It centralizes the workflow process by using the built-in templates or you create custom workflows. This practice helps reduce, or potentially remove, manual tasks for organizational JML strategy requirements. On the Azure portal, navigate to **ID Governance** in the Microsoft Entra ID menu to review or configure tasks for your organizational requirements.<br><br>[Microsoft Entra Connect](~/identity/hybrid/connect/how-to-connect-install-roadmap.md) integrates on-premises directories with Microsoft Entra ID, supporting the use of single identities to access on-premises applications and cloud services such as Microsoft 365. It orchestrates synchronization between Active Directory (AD) and Microsoft Entra ID. To get started with Microsoft Entra Connect, review the prerequisites. Note the server requirements and how to prepare your Microsoft Entra tenant for management.<br><br>[Microsoft Entra Connect Sync](~/identity/hybrid/cloud-sync/tutorial-pilot-aadc-aadccp.md) is a provisioning agent managed on the cloud, which supports synchronization to Microsoft Entra ID from a multi-forest disconnected AD environment. Use the lightweight agents with Microsoft Entra Connect. We recommend password hash sync to help reduce the number of passwords and protect against leaked credential detection.|
|**CSF Control V11**<br>01.c Privilege Management<br><br>**Control category**<br>Access Control – Privileged Accounts<br><br>**Control specification**<br>The organization ensures authorized user accounts are registered, tracked, and periodically validated to prevent unauthorized access to information systems<br><br>**Objective name**<br>Authorized Access to Information Systems<br><br>**HIPAA Security Rule**<br>§ 164.308(a)(1)(i)<br>§ 164.308(a)(1)(ii)(B)<br>§ 164.308(a)(2)<br>§ 164.308(a)(3)(ii)(B)<br>§ 164.308(a)(3)(ii)(A)<br>§ 164.308(a)(4)(i)<br>§ 164.308(a)(4)(ii)(B)<br>§ 164.308(a)(4)(ii)(C)<br>§ 164.310(a)(2)(ii)<br>§ 164.310(a)(1)<br>§ 164.310(a)(2)(iii)<br>§ 164.312(a)(1)|[Privileged Identity Management (PIM)](~/id-governance/privileged-identity-management/pim-configure.md) is a service in Microsoft Entra ID to manage, control and monitor access to important resources in an organization. It minimizes the number of people with access to secure information to help prevent malicious actors from getting access.<br><br>PIM has time and approval-based access, to mitigate the risks of excessive, unnecessary, or misused access permissions. It helps identify and analyze privileged accounts to ensure you provide just enough access (JEA) for a user to perform their role.<br><br>[Monitoring and generating alerts](~/id-governance/privileged-identity-management/pim-how-to-configure-security-alerts.md) prevent suspicious activities, listing the users and roles that trigger the alert, while reducing the risk of unauthorized access. Customize alerts for your organizational security strategy.<br><br>[Access reviews](~/id-governance/access-reviews-overview.md) enable organizations to manage role assignments and group membership efficiently. Maintain security and compliance by evaluating which accounts have access and ensure access is revoked when needed, thus minimizing the risks from excessive or outdated permissions. |
|**CSF Control V11**<br>0.1d User Password Management<br><br>**Control category**<br>Access Control - Procedures<br><br>**Control specification**<br>To ensure authorized user accounts are registered, tracked, and periodically validated to prevent unauthorized access to information systems.<br><br>**Objective name**<br>Authorized Access to Information Systems<br><br>**HIPAA Security Rule**<br>§164.308(a)(5)(ii)(D)|[Password management](/azure/security/fundamentals/identity-management-best-practices) is a critical aspect of security infrastructure. Align with best practices to create a robust security posture, Microsoft Entra ID helps facilitate with a comprehensive strategy support: [SSO](~/identity/enterprise-apps/add-application-portal-setup-sso.md) and [MFA](~/identity/authentication/concept-mfa-howitworks.md) also [passwordless authentication](~/identity/authentication/concept-authentication-passwordless.md), such as FIDO2 security keys and Windows Hello for Business (WHfB) mitigate user risk and streamline the user authentication experience.<br><br>Microsoft Entra Password Protection detects, and blocks, known weak passwords. It incorporates password [policies](~/identity/authentication/tutorial-configure-custom-password-protection.md) and has the flexibility to define a custom password list and build a password management strategy to safeguard password use.<br><br>HITRUST password length and strength requirements align with the National Institute of Standards and Technology [NIST 800-63B](https://pages.nist.gov/800-63-3/sp800-63b.html), which includes a minimum of eight characters for a password, or 15 characters for accounts with the most privileged access. Complexity measures include at least one number and/or special character and at least one upper- and lower-case letter for privileged accounts.|
|**CSF Control V11**<br>01.p Secure Log-on Procedures<br><br>**Control category**<br>Access Control – Secure Logon<br><br>**Control specification**<br>The organization controls access to information assets using a secure logon procedure.<br><br>**Objective name**<br>Operating System Access Control<br><br>**HIPAA Security Rule**<br>§ 164.308(a)(5)(i)<br>§ 164.308(a)(5)(ii)(C)<br>§ 164.308(a)(5)(ii)(D)|Secure sign-in is the process to authenticate an identity securely when they attempt to access a system.<br><br>**The control focuses on the [operating system](/azure/governance/policy/samples/hipaa-hitrust-9-2), Microsoft Entra services help strengthen the secure sign in.**<br><br>[Conditional Access](~/identity/conditional-access/overview.md) policies help organizations restrict access to approved applications, resources, and ensure devices are secure. Microsoft Entra ID analyzes the signals from Conditional Access [policies](~/identity/conditional-access/concept-conditional-access-policies.md) from the identity, location, or device to automate the decision and enforce organizational policies for access to resources and data.<br><br>[Role-based access control (RBAC)](~/identity/role-based-access-control/custom-overview.md) helps you manage access and managed resources in your organization. RBAC helps implement the principle of least privilege, ensuring users have the permissions they need to perform their tasks. This action minimizes the risk of accidental or intentional misconfiguration.<br><br>As noted for control 0.1d User Password Management, passwordless authentication uses biometrics because they are difficult to forge, thus providing more secure authentication. |
|**CSF Control V11**<br>01.q User Identification and Authentication<br><br>**Control category**<br>N/A<br><br>**Control specification**<br>All users shall have a unique identifier (user ID) for their personal use only, and an authentication technique shall be implemented to substantiate the claimed identity of a user.<br><br>**Objective name**<br>N/A<br><br>**HIPAA Security Rule**<br>§ 164.308(a)(5)(ii)(D)<br>§ 164.310(a)(1)<br>§ 164.312(a)(2)(i)<br>§ 164.312(d)|Use [account provisioning](~/identity/hybrid/what-is-provisioning.md) in Microsoft Entra ID to create, update, and manage user accounts. Each user and object are assigned a unique identifier (UID) referred to as the object ID. The UID is a globally unique identifier automatically generated when a user or object is created.<br><br>Microsoft Entra ID supports [automated user provisioning](~/identity/app-provisioning/plan-cloud-hr-provision.md) for systems and [applications](~/identity/app-provisioning/plan-auto-user-provisioning.md). Automated provisioning creates new accounts in the right systems when people join a team in an organization. Automated deprovisioning deactivates accounts when people leave. |
|**CSF Control V11**<br>01.u Limitation of Connection Time<br><br>**Control category**<br>Access Control - Secure Logon<br><br>**Control specification**<br>The organization controls access to information assets using a secure logon procedure.<br><br>**Objective name**<br>Operating System Access Control<br><br>**HIPAA Security Rule**<br>§ 164.312(a)(2)(iii)|**The control focuses on the [operating system](/azure/governance/policy/samples/hipaa-hitrust-9-2), Microsoft Entra services help strengthen the secure sign in.**<br><br>Secure sign-in is the process to authenticate an identity securely when they attempt to access a system.<br><br>Microsoft Entra authenticates users and has security features with information about the user and the resource. The information includes the access token, refresh token, and ID token. Configure in accordance with your organizational requirements for application access. Use this guidance predominantly for mobile and desktop clients.<br><br>Conditional Access policies support configuration settings for web browser [restriction of authenticated sessions](~/identity/conditional-access/howto-conditional-access-session-lifetime.md).<br><br>Microsoft Entra ID has integrations across operating systems, to provide a better user experience and support for passwordless authentication methods listed:<br><br>[Platform SSO for macOS](/mem/intune/configuration/use-enterprise-sso-plug-in-ios-ipados-macos?pivots=all) extends the SSO capabilities for macOS. Users sign in to a Mac using passwordless credentials, or password management validated by Microsoft Entra ID.<br><br>[Windows passwordless experience](/windows/security/identity-protection/passwordless-experience/?branch=main&preserve-view=true) promotes an authentication experience without passwords on Microsoft Entra joined devices. Using passwordless authentication reduces vulnerabilities and risks associated with traditional password-based authentication, such as phishing attacks, password reuse, and key logger interception of passwords.<br><br>[Web sign-in for Windows](/windows/security/identity-protection/web-sign-in/?tabs=intune&branch=main) is a credential provider that expands the capabilities of web sign-in in Windows 11, covering Windows Hello for Business, temporary access pass (TAP), and federated identities.<br><br>Azure Virtual Desktop supports [SSO and passwordless authentication](/azure/virtual-desktop/authentication). With SSO, you can use passwordless authentication and third-party identity providers (IdPs) that federate with Microsoft Entra ID to sign in to your Azure Virtual Desktop resources. It has an SSO experience when authenticating to the session host. It configures the session to provide SSO to Microsoft Entra resources in the session. |

## Next steps

[Configure Microsoft Entra HIPAA access control safeguards](hipaa-access-controls.md)
