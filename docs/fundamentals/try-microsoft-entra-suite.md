---
title: Try Microsoft Entra Suite for free
description: Make the most of your Microsoft Entra Suite trial. Try out some of the key productivity and security capabilities.
author: barclayn
manager: amycolannino

ms.service: entra
ms.subservice: fundamentals
ms.topic: overview
ms.date: 08/08/2024
ms.author: barclayn
ms.custom: it-pro
ms.collection: M365-identity-device-management
# Customer intent: As a new administrator, I want to try the Microsoft Entra Suite, to determine which license is right for me and what features are available.
---

# Trial user guide: Microsoft Entra Suite

Welcome to the Microsoft Entra Suite trial user guide. Make the most of your free trial by discovering the robust and comprehensive capabilities of [Microsoft Entra](what-is-entra.md).

## What is the Microsoft Entra Suite? 

[Microsoft Entra Suite](https://microsoft.com/security/blog/2024/07/11/simplified-zero-trust-security-with-the-microsoft-entra-suite-and-unified-security-operations-platform-now-generally-available/) is the product SKU for identity and network access solutions from Microsoft. It delivers a complete cloud-based solution for workforce access. 

With Microsoft Entra Suite, you can protect and verify any identity, provide secure access from anywhere to any app or resource (cloud or on-premises), keep users and organizations safe by filtering out malicious content, and ensure that only the right identities have access to your organization's apps and resources.

:::image type="content" border="true" source="./media/entra-suite-trial/entra-suite-trial.png" alt-text="Screenshot of the Microsoft Entra Suite zero trust strategy steps.":::

## Trial licensing prerequisites

- Microsoft Entra ID P1
- Any product that includes Microsoft Entra ID P1 (for example, Microsoft 365 Business Premium/E3/F1/F3 or Enterprise Mobility + Security E3)

When you start a trial or purchase Microsoft Entra Suite, your first step is to determine which licensing option is best suited for your organization. For more information see [What are the Microsoft Entra ID licenses?](whatis.md#what-are-the-microsoft-entra-id-licenses)

## What's included in the Microsoft Entra Suite trial? 

The Microsoft Entra Suite includes the following features: 

[**Microsoft Entra ID Protection**](~/id-protection/overview-identity-protection.md): Blocks identity takeover in real time by analyzing user and sign-in patterns based on integrated risk scores from various sources. Protects against identity-based attacks, such as phishing, infected devices, and leaked credentials. 

[**Microsoft Entra ID Governance**](~/id-governance/identity-governance-overview.md): Manages user identities, access rights, and entitlements across IT environments to ensure proper access controls, mitigate risk, and maintain compliance with regulatory requirements. 

[**Microsoft Entra Internet Access**](~/global-secure-access/concept-internet-access.md): Secures global access to all Internet, SaaS, and Microsoft 365 apps and resources while protecting organizations against internet threats, malicious network traffic, and unsafe or non-compliant content with an identity-centric Secure Web Gateway (SWG). 

[**Microsoft Entra Private Access**](~/global-secure-access/concept-private-access.md): Removes the risk and operational complexity of legacy VPNs while boosting user productivity. Quickly and securely connects remote users from any device and any global network to private apps—on-premises, across clouds, and anywhere in between. 

[**Microsoft Entra Verified ID**](~/verified-id/decentralized-identifier-overview.md): Issues and verifies workplace credentials, citizenship, education status, certifications, or any unique identity attributes in a global ecosystem designed for more secure interaction between people, organizations, and devices.

### Microsoft Entra Suite feature guides

To help you get the most out of your Microsoft Entra Suite trial, we recommend you review the following how-to guides to help ensure a more secure environment for your organization:

- [Deploy identify protection](~/id-protection/how-to-deploy-identity-protection.md): Deploy security controls to enhance identification and protection of risky users.  
- [Enact access reviews](~/id-governance/deploy-access-reviews.md): Conduct an access review to ensure appropriate system access within your enterprise. 
- [Utilize internet access provisions](~/architecture/sse-deployment-guide-internet-access.md): Protect internet traffic with secure web gateways.
- [Enable private access gateways](~/architecture/sse-deployment-guide-private-access.md): Depreciate costly VPN systems through Quick Access.
- [Onboard customer workflow portal](~/id-governance/tutorial-onboard-custom-workflow-portal.md): Automate employee onboarding with lifecycle workflows. 

## Customer scenarios for using the Microsoft Entra Suite trial 

The following deployment scenarios provide detailed guidance on how to combine and test all five Microsoft Entra Suite products. Each scenario below includes a link to the step-by-step instructions available on *learn.microsoft.com*.  

To get the most out of your trial, get started by walking through the following user scenarios. 

1. [Scenario: Automate user onboarding and lifecycle with access to all apps](#scenario-1-automate-user-onboarding-and-lifecycle-with-access-to-all-apps)
1. [Scenario: Modernize remote access to on-premises apps with MFA per app](#scenario-2-modernize-remote-access-to-on-premises-apps-with-mfa-per-app) 
1. [Scenario: Secure internet access based on business needs](#scenario-3-secure-internet-access-based-on-business-needs) 

During your Microsoft Entra Suite’s trial period, be sure to take advantage of the *better together* security strategy by implementing automated user onboarding and lifecycle management, modernizing from traditional VPN to on-premises resources with multifactor authentication (MFA) all the way down to the app level, and securing internet access based on the rules of your business.  

The following table shows which of the five Microsoft Entra Suite products are covered in each scenario.

| Customer scenario     | Entra ID Governance | Entra ID Protection | Entra Verified ID | Entra Internet Access | Entra Private Access |
|------------------------|---------------------|---------------------|-------------------|-----------------------|----------------------|
|1 – Automate user onboarding and lifecycle with access to all apps | Included            | Included            | Included          |                       | Included             |
|2 - Modernize traditional VPN to on-premises resources with MFA per app  | Included            | Included            |                   |                       | Included             |
|3 - Secure internet access based on business rules  | Included            | Included            |                   | Included              |                      |

### Scenario 1: Automate user onboarding and lifecycle with access to all apps 

The workforce and guest onboarding, identity, and access lifecycle governance scenario describes these goals: 

- Provide remote employees with secure and seamless access to necessary apps and resources. 
- Collaborate with external users by providing them with access to relevant apps and resources. 

The step-by-step guidance focuses on Microsoft Entra Verified ID, Microsoft Entra ID Governance, Microsoft Entra ID Protection, and Conditional Access (CA). For more information, see [Microsoft Entra deployment scenario - Workforce and guest lifecycle](~/architecture/deployment-scenario-workforce-guest.md). 

### Scenario 2: Modernize remote access to on-premises apps with MFA per app 

The modernize remote access to on-premises apps with MFA per app scenarios describe these goals: 

- Upgrade existing VPN to a scalable cloud-based solution that helps to move towards Secure Access Service Edge (SASE). 
- Resolve issues where business application access relies on corporate network connectivity. 

The step-by-step guidance focuses on Microsoft Entra Private Access, Microsoft Entra ID Protection, and Microsoft Entra ID Governance. For more information, see [Microsoft Entra deployment scenario - Modernize remote access](~/architecture/deployment-scenario-remote-access.md).  

### Scenario 3: Secure internet access based on business needs 

The secure internet access based on business needs scenario describes these goals: 

- Augment existing strict default internet access policies with more Internet access control. 

- Allow users to request access to prohibited sites in My Access. The approval process adds users to a group that grants them access. Examples include marketing department access to social networking sites and security department access to high-risk internet destinations while investigating incidents. 

The step-by-step guidance focuses on Microsoft Entra Internet Access, Microsoft Entra ID Governance, Conditional Access, and Global Secure Access. For more information, see [Microsoft Entra deployment scenario - Secure internet access](~/architecture/deployment-scenario-internet-access.md).  

## Additional resources 

- [Microsoft Entra Suite now generally available - Microsoft Community Hub](https://techcommunity.microsoft.com/t5/microsoft-entra-blog/microsoft-entra-suite-now-generally-available/ba-p/2520427) 
- [Microsoft Entra licensing - Microsoft Entra | Microsoft Learn](licensing.md) 
- [The Microsoft Entra Suite and unified security operations platform are now generally available | Microsoft Security Blog](https://www.microsoft.com/security/blog/2024/07/11/simplified-zero-trust-security-with-the-microsoft-entra-suite-and-unified-security-operations-platform-now-generally-available) 