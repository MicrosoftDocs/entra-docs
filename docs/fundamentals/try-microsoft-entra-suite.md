---
title: Try Microsoft Entra Suite for free
description: Make the most of your Microsoft Entra Suite trial. Try out some of the key productivity and security capabilities.
author: barclayn
manager: amycolannino

ms.service: entra
ms.subservice: fundamentals
ms.topic: overview
ms.date: 08/22/2024
ms.author: barclayn
ms.custom: it-pro
ms.collection: M365-identity-device-management
# Customer intent: As a new administrator, I want to try the Microsoft Entra Suite, to determine which license is right for me and what products are relevant to my organization's needs.
---

# Trial user guide: Microsoft Entra Suite

Welcome to the Microsoft Entra Suite trial user guide. Make the most of your free trial by discovering the robust and comprehensive capabilities of [Microsoft Entra](what-is-entra.md).

> [!Tip]
> Save this trial user guide to your browser favorites. When links in the trial user guide take you away from this location, it'll be easier to return to this guide to continue.

## What is the Microsoft Entra Suite? 

[Microsoft Entra Suite](licensing.md) is the solution to deliver unified Zero Trust user access, enabling your employees to securely access any cloud and on-premises application. The suite does this by providing least privilege access across public and private networks, inside and outside your corporate perimeter. By combining network access, identity protection, governance, and identity verification solutions, the Microsoft Entra Suite extends conditional access across identities and network controls, filters out malicious content, and ensures least privilege access for a simple and consistent user experience, whether employees are in the office or remote.

## Trial licensing prerequisites

- Microsoft Entra ID P1
- Any package that includes Microsoft Entra ID P1 or Microsoft Entra ID P2 (for example, ME3 or ME5)

When you start a trial or purchase Microsoft Entra Suite, your first step is to determine which licensing option is best suited for your organization. Special pricing is available for Microsoft Entra ID P2/E5 customers. For more information about pricing, see [Microsoft Entra plans & pricing](https://www.microsoft.com/security/business/microsoft-entra-pricing).

## What is included in the Microsoft Entra Suite trial? 

The Microsoft Entra Suite includes these products: 

[**Microsoft Entra Private Access**](~/global-secure-access/concept-private-access.md): Removes the risk and operational complexity of legacy VPNs while boosting user productivity. Quickly and securely connects remote users from any device and any global network to private apps—on-premises, across clouds, and anywhere in between. 

[**Microsoft Entra Internet Access**](~/global-secure-access/concept-internet-access.md): Secures global access to all internet, SaaS, and Microsoft 365 apps and resources while protecting organizations against internet threats, malicious network traffic, and unsafe or noncompliant content with an identity-centric Secure Web Gateway (SWG). 

[**Microsoft Entra ID Governance**](~/id-governance/identity-governance-overview.md): Manages user identities, access rights, and entitlements across IT environments to ensure proper access controls, mitigate risk, and maintain compliance with regulatory requirements. 

[**Microsoft Entra ID Protection**](~/id-protection/overview-identity-protection.md): Blocks identity takeover in real time by analyzing user and sign-in patterns based on integrated risk scores from various sources. Protects against identity-based attacks, such as phishing, infected devices, and leaked credentials. 

[**Microsoft Entra Verified ID**](~/verified-id/decentralized-identifier-overview.md): Validate users with secure verification methods to ensure secure identity authentication scenarios like user onboarding, securing access to sensitive resources, and account recovery processes.

## Microsoft Entra Suite product guides

To help you get the most out of your Microsoft Entra Suite trial, we recommend you review the following how-to guides to help ensure a more secure environment for your organization. 

The following how-to guides are expanded upon in this section: 

- [Step 1: Deploy identify protection](#step-1-deploy-identity-protection): Deploy security controls to enhance identification and protection of risky users.  
- [Step 2: Enact access reviews](#step-2-enact-access-reviews): Conduct an access review to ensure appropriate system access within your enterprise. 
- [Step 3: Secure access to the internet](#step-3-secure-access-to-the-internet): Protect internet traffic with secure web gateways.
- [Step 4: Enable private access gateways](#step-4-enable-private-access-gateways): Depreciate costly VPN systems with Quick Access.
- [Step 5: Onboard customers with a workflow portal](#step-5-onboard-customers-with-a-workflow-portal): Automate employee onboarding with lifecycle workflows. 

:::image type="content" border="true" source="./media/entra-suite-trial/entra-suite-trial.png" alt-text="Screenshot of the Microsoft Entra Suite zero trust strategy steps.":::

The following sections include process steps to walk you through each product. Each of these steps is fully documented in a separate how-to guide that you can access by clicking the link at the end of each step.  

### Step 1: Deploy identity protection 

Microsoft Entra ID Protection detects identity-based risks, reports them, and allows administrators to investigate and remediate these risks to keep organizations safe and secure. Risk data can be further fed into tools like conditional access to make access decisions or fed to a security information and event management (SIEM) tool for further analysis and investigation.

1. Review existing reports
1. Plan for conditional access risk policies
1. Configure your policies 
1. Monitoring and continuous operational needs

To view the complete how-to guide, see [Plan a Microsoft Entra ID Protection deployment](~/id-protection/how-to-deploy-identity-protection.md).

### Step 2: Enact access reviews

Microsoft Entra access reviews are a Microsoft Entra ID Governance capability that help your organization keep the Enterprise more secure by managing its resource access lifecycle. The other capabilities are entitlement management, Privileged Identity Management (PIM), lifecycle workflows, provisioning, and terms of use.

1. Plan access reviews for access packages, groups, and applications 
1. Plan review of Microsoft Entra ID and Azure resource roles 
1. Deploy access reviews 
1. Use the Access Reviews API 
1. Monitor access reviews 

To view the complete how-to guide, see [Plan a Microsoft Entra access reviews deployment](~/id-governance/deploy-access-reviews.md).

### Step 3: Secure access to the internet 

Microsoft Entra Internet Access protects enterprise users and managed devices from malicious internet traffic and malware infection concerns all companies. Using the Secure Web Gateway functionality enables you to block traffic based on web categories, and a fully qualified domain name (FQDN), by integrating with Microsoft Entra Conditional Access.

1. Deploy and test Microsoft Entra Internet Access 
1. Create a baseline policy applying to all internet traffic routed through the service 
1. Block a group from accessing websites based on category
1. Block a group from accessing websites based on FQDN 
1. Allow a user to access a blocked website 

To view the complete how-to guide, see [Deployment guide for Microsoft Entra Internet Access](~/architecture/sse-deployment-guide-internet-access.md).

### Step 4: Enable private access gateways 

Microsoft Entra Private Access converges network and identity access controls so you can secure access to any app or resource from any location, device, or identity. It enables and orchestrates access policy management for employees, business partners, and digital workloads. 

1. Deploy and test Microsoft Entra Private Access 
1. Apply Microsoft Entra Conditional Access 
1. Control access by multiple users to multiple apps 

To view the complete how-to guide, see [Deployment guide for Microsoft Entra Private Access](~/architecture/sse-deployment-guide-private-access.md).

### Step 5: Onboard customers with a workflow portal 

The Microsoft Entra admin portal enables you to automate prehire tasks with Lifecycle workflows through an HR provisioning process. Provisioning creates an identity in a target system based on certain conditions. Deprovisioning removes the identity from the target system, when conditions are no longer met. These processes are part of identity lifecycle management.

1. Create a workflow using prehire template 
1. Run the workflow 
1. Check tasks and workflow status 
1. Enable the workflow schedule 

To view the complete how-to guide, see [Automate employee onboarding tasks with Microsoft Entra](~/id-governance/tutorial-onboard-custom-workflow-portal.md).

## Customer scenarios for using the Microsoft Entra Suite trial 

The following deployment scenarios provide detailed guidance on how to combine and test all five Microsoft Entra Suite products. Each scenario in this section includes separate step-by-step instructions that you can access by clicking the link at the end of each scenario.

To get the most out of your trial, get started by walking through the following user scenarios. 

- [Scenario 1: Automate user onboarding and lifecycle with access to all apps](#scenario-1-automate-user-onboarding-and-lifecycle-with-access-to-all-apps)
- [Scenario 2: Modernize remote access to on-premises apps with MFA per app](#scenario-2-modernize-remote-access-to-on-premises-apps-with-mfa-per-app) 
- [Scenario 3: Secure internet access based on business needs](#scenario-3-secure-internet-access-based-on-business-needs) 

During your Microsoft Entra Suite’s trial period, be sure you take advantage of the better together security strategy by implementing automated user onboarding and lifecycle management, modernizing from traditional VPN to on-premises resources with multifactor authentication (MFA) all the way down to the app level, and securing internet access based on the rules of your business.  

The following table shows which of the five Microsoft Entra Suite products are covered in each scenario.

| Customer scenario     | Microsoft Entra Private Access | Microsoft Entra Internet Access | Microsoft Entra ID Governance | Microsoft Entra ID Protection | Microsoft Entra Verified ID |
|------------------------|---------------------|---------------------|-------------------|-----------------------|----------------------|
|1 – Automate user onboarding and lifecycle with access to all apps |             | Included            | Included          | Included     | Included          |
|2 – Modernize traditional VPN to on-premises resources with MFA per app  |           | Included            | Included                  | Included                    |             |
|3 – Secure internet access based on business rules  | Included            |                 | Included                   | Included              |                      |

### Scenario 1: Automate user onboarding and lifecycle with access to all apps 

The workforce and guest onboarding, identity, and access lifecycle governance scenario describes these goals: 

- Provide remote employees with secure and seamless access to necessary apps and resources. 
- Collaborate with external users by providing them with access to relevant apps and resources. 

The step-by-step guidance focuses on Microsoft Entra Verified ID, Microsoft Entra ID Governance, Microsoft Entra ID Protection, and Microsoft Entra Conditional Access. For more information, see [Microsoft Entra deployment scenario - Workforce and guest lifecycle](~/architecture/deployment-scenario-workforce-guest.md). 

### Scenario 2: Modernize remote access to on-premises apps with MFA per app 

The modernized remote access to on-premises apps with MFA per app scenarios describe these goals: 

- Upgrade existing VPN to a scalable cloud-based solution that helps to move towards Secure Access Service Microsoft Edge (SASE). 
- Resolve issues where business application access relies on corporate network connectivity. 

The step-by-step guidance focuses on Microsoft Entra Private Access, Microsoft Entra ID Protection, and Microsoft Entra ID Governance. For more information, see [Microsoft Entra deployment scenario - Modernize remote access](~/architecture/deployment-scenario-remote-access.md).  

### Scenario 3: Secure internet access based on business needs 

The secure internet access based on business needs scenario describes these goals: 

- Augment existing strict default internet access policies with Microsoft Entra Internet Access control. 

- Allow users to request access to prohibited sites in My Access. The approval process adds users to a group that grants them access. Examples include marketing department access to social networking sites and security department access to high-risk internet destinations while investigating incidents. 

The step-by-step guidance focuses on Microsoft Entra Internet Access, Microsoft Entra ID Governance, Microsoft Entra Conditional Access, and Global Secure Access. For more information, see [Microsoft Entra deployment scenario - Secure internet access](~/architecture/deployment-scenario-internet-access.md).  

## Related content 

- [Microsoft Entra Suite now generally available - Microsoft Community Hub](https://techcommunity.microsoft.com/t5/microsoft-entra-blog/microsoft-entra-suite-now-generally-available/ba-p/2520427)
- [Microsoft Entra plans & pricing](https://www.microsoft.com/security/business/microsoft-entra-pricing)
- [Learn how to simplify your Zero Trust strategy with the Microsoft Entra Suite](https://info.microsoft.com/ww-ondemand-zero-trust-in-the-age-of-ai.html?lcid=en-us/?ocid=cmmvobsb34b)
- [Simplified Zero Trust security with the Microsoft Entra Suite](https://microsoft.com/security/blog/2024/07/11/simplified-zero-trust-security-with-the-microsoft-entra-suite-and-unified-security-operations-platform-now-generally-available)