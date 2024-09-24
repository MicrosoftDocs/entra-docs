---
title: Planning phases for a phishing-resistant passwordless authentication deployment in Microsoft Entra ID
description: Detailed guidance for the planning phases of a passwordless and phishing-resistant authentication deployment for an organizations that use Microsoft Entra ID.

ms.service: entra-id 
ms.subservice: authentication
ms.topic: how-to
ms.date: 09/24/2024

ms.author: justinha
author: mepples21
manager: amycolannino
ms.reviewer: miepping

ms.collection: M365-identity-device-management
# Customer intent: As an identity administrator, I want to understand how to plan phishing-resistant and passwordless authentication deployment in Microsoft Entra ID

---
# Plan a phishing-resistant passwordless authentication deployment in Microsoft Entra ID

When you deploy and operationalize phishing-resistant passwordless authentication in your environment, we recommend a user persona-based approach because different phishing-resistant passwordless methods are more effective than others for certain user personas. 
This deployment guide helps you see which types of methods and rollout plans make sense for user personas in your environment.
The phishing-resistant passwordless deployment approach commonly has 5 steps, which roughly flow in order:     

## Step 1: Determine your user personas
Determine the user personas relevant for your organization. This step is critical to your project because different personas have different needs. Microsoft recommends you consider and evaluate at least 4 generic user personas in your organization.

User persona | Description
-----|------------
Information workers | Examples include office productivity staff, such as iin marketing, finance, or human resources.</br>Other types of information workers may be executives and other high-sensitivity workers who need special controls</br>Typically have a 1:1 relationship with their mobile and computing devices</br>May bring their own devices (BYOD), especially for mobile
Frontline workers | Examples include retail store workers, factory workers, manufacturing workers</br>Typically work only on shared devices or kiosks</br>May not be allowed to carry mobile phones
IT Pros/DevOps workers | Examples include IT admins for on-premises Active Directory, Microsoft Entra ID, or other privileged accounts. other examples would be DevOps workers or DevSecOps workers who manage and deploy automations.</br>Typically have multiple user accounts, including a "normal" user account, and one or more administrative accounts</br>Commonly use remote access protocols, such as Remote Desktop Protocol (RDP) and Secure Shell Protocol (SSH), to administer remote systems</br>May work on locked down devices with Bluetooth disabled</br>May use secondary accounts to run non-interactive automations and scripts
Highly regulated workers | Examples include US federal government workers subject to [Executive Order 14028](https://www.microsoft.com/en-us/security/blog/2022/02/17/us-government-sets-forth-zero-trust-architecture-strategy-and-requirements/) requirements, state and local government workers, or workers subject to specific security regulations</br>Typically have a 1:1 relationship with their devices, but have very specific regulatory controls that must be met on those devices and for authentication</br>Mobile phones may not be allowed in secure areas</br>May access air-gapped environments without internet connectivity</br>May work on locked down devices with Bluetooth disabled


Microsoft recommends that you broadly deploy phishing-resistant passwordless across your organization. 
Traditionally, information workers are the easist user persona to begin with. 
Don't delay rollout of secure credentials for information workers while you resolve issues that affect IT Pros. 
Take the approcah of "*don’t let perfect be the enemy of good*" and deploy secure credentials as much as possible. 
As more users sign in using phishing-resistant passwordless credentials, you reduce the attack surface of your environment.

Microsoft recommends that you define your personas, and then place each persona into a MIcrosoft Entra ID group specifically for that user persona. 
These groups are used in later steps to roll out credentials to different types of users, and when you begin to enforce the use of phishing-resistant passwordless credentials.


## Step 2: Plan device readiness

Devices are an essential aspect of any successful phishing-resistant passwordless deployment, since one of the goals of phishing-resistant passwordless credentials is to protect credentials with the hardware of modern devices. 
First, become familiar with [FIDO2 supportability for Microsoft Entra ID](concept-fido2-compatibility.md). 
Ensure that your devices are prepared for phishing-resistant passwordless by patching to the latest supported versions of each operating system. 
Microsoft recommends your devices are running these versions at a minimum:

- Windows 10 20H1 (for Windows Hello for Business)
- Windows 11 23H2 (for the best user experience when using passkeys)
- macOS 13 Ventura
- iOS 17
- Android 14

These versions provide the best support for natively integrated features like passkeys, Windows Hello for Business, and macOS Platform Credential. 
Older operating systems may require external authenticators, like FIDO2 security keys, to support phishing-resistant passwordless authentication.

## Next steps

[Deploy a phishing-resistant passwordless authentication deployment in Microsoft Entra ID](how-to-deploy-phishing-resistant-passwordless-authentication.md)
[Considerations for specific personas in a phishing-resistant passwordless authentication deployment in Microsoft Entra ID](how-to-plan-persona-phishing-resistant-passwordless-authentication.md)
