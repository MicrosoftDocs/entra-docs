---
title: Plan a phishing-resistant passwordless authentication deployment in Microsoft Entra ID
description: Detailed guidance for deploying passwordless and phishing-resistant authentication for organizations that use Microsoft Entra ID.

ms.service: entra-id 
ms.subservice: authentication
ms.topic: how-to
ms.date: 09/19/2024

ms.author: justinha
author: justinha
manager: amycolannino
ms.reviewer: miepping

ms.collection: M365-identity-device-management
# Customer intent: As an identity administrator, I want to understand how to plan phishing-resistant and passwordless authentication deployment in Microsoft Entra ID

---
# Plan a phishing-resistant passwordless authentication deployment in Microsoft Entra ID

Passwords are the primary attack vector for modern adversaries, and a source of friction for users and administrators. 
As part of an overall [Zero Trust security strategy](https://www.microsoft.com/en-us/security/business/zero-trust), Microsoft recommends [moving to phishing-resistant passwordless](https://www.microsoft.com/security/business/solutions/passwordless-authentication) in your authentication solution. 
This guide helps you select, prepare, and deploy the right phishing-resistant passwordless credentials for your organization. 
Use this guide to plan and execute your phishing-resistant passwordless project.

Features like multifactor authentication (MFA) are a great way to secure your organization. 
But users often get frustrated with the extra security layer on top of their need to remember passwords. 
Phishing-resistant passwordless authentication methods are more convenient. 

For example, an analysis of Microsoft consumer accounts shows that sign-in with a password can take up to 9 seconds on average, but passkeys only take around 3 seconds in most cases.
The speed and ease of passkey sign-in is even greater when compared with traditional password and MFA sign in. 
Passkey users don’t need to remember their password, or wait around for SMS messages.

Phishing-resistant passwordless methods also have extra security baked in. 
They automatically count as MFA by using something that the user has (a physical device or security key) and something the user knows or is, like a biometric or PIN. 
And unlike traditional MFA, phishing-resistant passwordless methods deflect phishing attacks against your users by using hardware-backed credentials that can’t be easily compromised. 

Microsoft Entra ID offers the following phishing-resistant passwordless authentication options:

- Passkeys (FIDO2)
  - Windows Hello for Business
  - Platform credential for macOS (preview)
  - Microsoft Authenticator app passkeys (preview)
  - FIDO2 security keys
  - Other passkeys and providers, such as iCloud
- Certificate-based authentication/smartcards

:::image type="content" border="true" source="media/how-to-deploy-phishing-resistant-authentication/methods.png" alt-text="Diagram that shows the relative convenience and security of different sign-in methods.":::

## Prerequisites

Before you start your Microsoft Entra phishing-resistant passwordless deployment project, complete these prerequisites: 

- Review license requirements
- Review the roles needed to perform privileged actions
- Identify stakeholder teams that need to collaborate

### License requirements

Registration and passwordless sign in with Microsoft Entra doesn't require a license, but we recommend at least a Microsoft Entra ID P1 license for the full set of capabilities associated with a passwordless deployment. 
For example, a Microsoft Entra ID P1 license helps you enforce passwordless sign in through Conditional Access, and track deployment with an authentication method activity report. Refer to the licensing requirements guidance for features referenced in this guide for specific licensing requirements.
 
### Required roles
The following table lists least privileged role requirements for phishing-resistant passwordless deployment. 
We recommend that you enable phishing-resistant passwordless authentication for all privileged accounts.

Microsoft Entra role                | Description
------------------------------------|---------------------------------------------
[User Administrator](~/identity/role-based-access-control/permissions-reference#user-administrator.md) | To implement combined registration experience
[Authentication Administrator](~/identity/role-based-access-control/permissions-reference#authentication-administrator.md) | To implement and manage authentication methods
[Authentication Policy Administrator](~/identity/role-based-access-control/permissions-reference#authentication-policy-administrator.md) | To implement and manage the Authentication methods policy
User                                | To configure Authenticator app on device; to enroll security key device for web or Windows 10/11 sign-in

### Customer stakeholder teams

To ensure success, make sure that you engage with the right stakeholders, and that they understand their roles before you begin your plan and rollout. The following table lists commonly recommended stakeholder teams.

Stakeholder team                    | Description
------------------------------------|------------------------------------------------
Identity and Access Management (IAM) | Manages day-to-day operations of the IAM system
Information Security Architecture	   | Plans and designs the organization’s information security practices
Information Security Operations	     | Runs and monitors information security practices for Information Security Architecture
Security Assurance and Audit         | Helps ensure IT processes are secure and compliant. They conduct regular audits, assess risks, and recommend security measures to mitigate identified vulnerabilities and enhance the overall security posture.
Help Desk and Support	               | Assists end users who encounter issues during deployments of new technologies and policies, or when issues occur 
End-User Communications	             | Messages changes to end users in preparation to aid in driving user-facing technology rollouts

## Deployment approach

### Planning phase
When you deploy and operationalize phishing-resistant passwordless authentication in your environment, we recommend a user persona-based approach because different phishing-resistant passwordless methods are more effective than others for certain user personas. 
This deployment guide helps you see which types of methods and rollout plans make sense for user personas in your environment.
The phishing-resistant passwordless deployment approach commonly has 7 steps, which roughly flow in order:     

#### Step 1: Presence in Microsoft Entra ID
Microsoft Entra ID is a cloud-based Identity and Access Management (IAM) service that workers and students can use to access external resources. 
For example, they can access resources like Microsoft 365, the Azure portal, and thousands of other Sotware-as-a-Service (SaaS) applications. 

A Microsoft Entra ID tenant is required for cloud-based phishing-resistant passwordless deployments on the Microsoft platform. 
You must have a Microsoft Entra ID tenant or create one to begin your passwordless deployment with Microsoft phishing-resistant passwordless methods. 
To learn more about Microsoft Entra ID, see [What is Microsoft Entra ID?](~/fundamentals/whatis.md).

#### Step 2: Update apps to support modern authentication
Microsoft Entra ID integrates with many types of applications, including SaaS apps, line-of-business (LOB) apps, on-premises apps, and more. 
You need to integrate your applications with Microsoft Entra ID to get the most benefit from your investment in passwordless and phishing-resistant authentication. 
As you integrate more apps with Microsoft Entra ID, you can protect more of your environment with Conditional Access policies that enforce the use of phishing-resistant authentication methods. 
To learn more about how to integrate apps with Microsoft Entra ID, see [Five steps to integrate your apps with Microsoft Entra ID](~/fundamentals/five-steps-to-full-application-integration.md).

When you develop your own applications, follow the developer guidance for supporting passwordless and phishing-resistant authentication. 
For more information, see [Support passwordless authentication with FIDO2 keys in apps you develop](~/identity-platform/support-fido2-authentication.md).

#### Step 3: Determine your user personas
Determining the user personas relevant for your organization is a critical step in the phishing-resistant passwordless deployment journey, as different personas will have different needs. There are at least 4 generic user personas that Microsoft recommends considering and evaluating if you have in your organization:
•	Information Workers
o	Examples include office productivity staff, such as marketing, finance, or HR workers.
o	Additional sub-types of Information Workers may be executives or other high sensitivity workers, who may need special controls
o	Typically have a 1:1 relationship with their mobile and computing devices
o	May use BYOD devices, especially for mobile
•	Frontline Workers
o	Examples include retail store workers, factory workers, manufacturing workers
o	Typically work only on shared devices or kiosks
o	May not be allowed to carry mobile phones
•	IT Pros / DevOps Workers
o	Examples include IT admins with on-premises Active Directory, Microsoft Entra ID, or other privileged accounts. Additional examples would be DevOps workers or DevSecOps workers who manage and deploy automations.
o	Typically have multiple user accounts, including a “normal” user account and one or more administrative accounts
o	Commonly use remote access protocols, such as RDP and SSH, to administer remote systems
o	May work on locked down devices with Bluetooth disabled
o	May use secondary accounts to run non-interactive automations and scripts
•	Highly Regulated Workers
o	Examples include US Federal Government workers subject to Executive Order 14028 requirements, state and local government workers, or workers subject to specific security regulations, 
o	Typically have a 1:1 relationship with their devices, but have very specific regulatory controls that must be met on those devices and for authentication
o	Mobile phones may not be allowed in secure areas
o	May access air-gapped environments without internet connectivity
o	May work on locked down devices with Bluetooth disabled
Microsoft recommends that you focus on deploying phishing-resistant passwordless as broadly in your organization as possible, which is traditionally easiest with Information Workers. You should not hold off on deploying secure credentials for Information Workers while you work through issues specific to IT Pros – take a “don’t let perfect be the enemy of good” approach and deploy as much as possible. The more users you have using phishing-resistant passwordless, the smaller the attack surface will be for your environment.
Microsoft recommends that you define your personas and then place each persona into an Entra ID group specific to that user persona. These groups will be used in later steps in this guide when rolling out credentials to different types of users and when you begin enforcing the use of phishing-resistant passwordless credentials.

#### Step 4: Device readiness
Devices are an essential aspect of any successful phishing-resistant passwordless deployment, since one of the goals of phishing-resistant passwordless credentials is to protect credentials with the hardware of modern devices. First, familiarize yourself with the FIDO2 supportability documentation for Microsoft Entra ID: Support for FIDO2 authentication with Microsoft Entra ID
Ensure that your devices are prepared for phishing-resistant passwordless by patching to the latest supported versions of each operating system. Microsoft recommends your devices are running these versions at a minimum:
•	Windows 10 20H1 (for Windows Hello for Business)
•	Windows 11 23H2 (for the best user experience when using passkeys)
•	macOS 13 Ventura
•	iOS 17
•	Android 14
These versions provide the best support for natively integrated features like passkeys, Windows Hello for Business, and macOS Platform Credential. Older operating systems may require external authenticators, like FIDO2 security keys, to support phishing-resistant passwordless authentication.

### Deployment phase

#### Step 5: Credential Registration and Bootstrapping
Credential registration and bootstrapping is the first major end-user facing activity in your phishing-resistant passwordless deployment project. This section will cover the rollout of portable and local credentials. Portable credentials are credentials that can be used in cross-device flows, such as to sign in on another device or to register additional credentials on more devices. Local credentials are used to authenticate on a device without needing to rely on external hardware, such as using the Windows Hello for Business biometric recognition to sign into an app in Microsoft Edge browser on the same PC.
•	Portable credentials are the most important type of credential users should register, as they can be used across multiple devices and provide phishing-resistant authentication in many scenarios.
•	Local credentials have two main benefits beyond those of the portable credentials:
o	They provide redundancy – if users lose their portable device, forget it at home, or have other issues then the local credential provides them with a backup method to maintain productivity on their computing device.
o	They provide a great user experience – the local credential benefits the user experience by reducing the need for users to pull phones out of their pocket, scan QR codes, or perform other tasks that slow down authentication and add friction. Locally available phishing-resistant credentials make user authentication easier and smoother on users’ regularly used devices.

•	For new users, the registration and bootstrapping phase involves taking a user with no existing enterprise credentials, verifying their identity, bootstrapping them into their first portable credential, using that portable credential to bootstrap other local credentials on each of their computing devices, and finally enforcing that they use phishing-resistant authentication in Microsoft Entra ID.
•	For existing users, this phase involves getting users to register for phishing-resistant passwordless on their existing devices directly or using existing MFA credentials to bootstrap phishing-resistant passwordless credentials. The end goal is the same as new users, most users should have at least one portable credential and then local credentials on each computing device.
Before starting, Microsoft recommends enabling passkey and other credentials for use by enterprise users in the tenant. If users are motivated to self-register for strong credentials, it is beneficial to allow them to do so. At a minimum, it's recommended to enable the Passkey (FIDO2) policy so that users can register for passkeys and security keys if they would like.
In this section we will focus on Phases 1-3:


Note that it is always recommended that users have at least two credentials registered. This ensures the user has a backup credential available if something happens to their other credentials, such as in cases of device loss or theft. For example, it is a good practice for users to have passkeys registered both on their phone and locally on their workstation in Windows Hello for Business.
NOTE: This guidance is tailored for currently existing support for passkeys in Microsoft Entra ID, which includes device-bound passkeys in the Microsoft Authenticator App and device-bound passkeys on physical security keys. Microsoft Entra ID plans to add support for syncable passkeys in the future (see more here: https://techcommunity.microsoft.com/t5/microsoft-entra-blog/public-preview-expanding-passkey-support-in-microsoft-entra-id/ba-p/4062702). This guide will evolve to include syncable passkey guidance once available. For example, many organizations may benefit from relying on sync for Phase 3 in the diagram above rather than bootstrapping entirely new credentials.

Onboarding Step 1: Identity Verification
Enterprises onboarding remote users face significant challenges onboarding users who aren't yet identity proofed. Microsoft Entra Verified ID can help customers wanting high assurance id verification because it can use government issued ID based attestations as a way to establish user identity trust. In this phase, users will be directed to an identity verification partner service where they will go through a proofing process determined by the organization and the chosen verification partner service. At the end of this process, users will be given a Temporary Access Pass that they can use to bootstrap their first portable credential in Step 2.
Refer to the following guides to enable verified ID onboarding and TAP issuance: 
•	Onboard new remote employees using ID verification
•	Enable the Temporary Access Pass policy
Note: Microsoft Entra Verified ID is part of the Entra Suite license.
Not all organizations will choose to use Verified IDs for onboarding. Organizations may rely on other methods to onboard users and issue them their first credential. Microsoft recommends that these organizations still leverage Temporary Access Pass or other alternatives like FIDO2 provisioning APIs, as these options still allow for user onboarding without passwords as an interim step:
•	Enable the Temporary Access Pass policy
•	Provision FIDO2 security keys using Microsoft Graph API (preview)
Onboarding Step 2: Bootstrapping a Portable Credential
Once users possess a Temporary Access Pass (TAP), they are ready to bootstrap their first phishing-resistant credential. It's important for the user’s first credential to be a portable credential that can be used to authenticate on other computing devices. For example, passkeys can be used to authenticate locally on an iOS phone, but they can also be used to authenticate on a Windows PC using a cross-device authentication flow. This cross-device capability allows that portable passkey to be used to bootstrap Windows Hello for Business on the Windows PC. It is important that each device the user regularly works on has a locally available credential in order to give the user the smoothest user experience possible – locally available credentials reduce the time needed to authenticate because users don’t need to use multiple devices and there are fewer steps. Using the TAP from Step 1 to register a portable credential that can bootstrap these other credentials enables the user to use phishing-resistant credentials natively across the many devices they may possess.
Your organization will need to determine which type of credential is preferred for each user persona at this stage. Microsoft recommends:
User Persona	Recommended Portable Credential	Alternative Portable Credentials

Information Worker	Passkey (Authenticator App)	Security key, smart card
Frontline Worker	Security key
Passkey (Authenticator App), smart card
IT Pro / DevOps Worker	Passkey (Authenticator App)	Security key, smart card
Highly Regulated Worker	Certificate (smart card)
Passkey (Authenticator App), security key

Refer to the following tips and guides to enable the recommended portable credentials in your environment for the relevant user personas for your organization:
•	Passkeys
o	Microsoft recommends that users sign in to the Microsoft Authenticator app directly to bootstrap a passkey in the app.
o	Users will use their TAP to sign into Microsoft Authenticator directly on their iOS or Android device.
o	Passkeys are disabled by default in Microsoft Entra ID, enable them via policy: Enable passkeys in Microsoft Authenticator
o	Register passkeys in Authenticator on Android or iOS devices
•	Security keys
o	Security keys are turned off by default in Microsoft Entra ID, enable them via policy: Enable passkeys (FIDO2) for your organization
o	Consider registering keys on behalf of your users with the Microsoft Entra ID provisioning APIs: Microsoft Entra ID FIDO2 provisioning APIs
•	Smart card / Certificate-Based Authentication (CBA)
o	Certificate-based authentication is more complicated to configure than passkeys or other methods, consider only using it if required
o	How to configure Microsoft Entra certificate-based authentication
o	Make sure to configure your on-premises PKI and Microsoft Entra ID CBA policies so that users truly must do multi-factor authentication to sign in. This generally means requiring the smart card Policy OID and configuring the necessary affinity binding settings. Review advanced CBA configuration documentation here: Understanding the authentication binding policy
Onboarding Step 3: Bootstrapping Local Credentials on Computing Devices
After users have registered a portable credential, they are ready to bootstrap additional credentials on each of the computing devices they leverage regularly in a 1:1 relationship, which benefits their day-to-day user experience. This type of credential is common for Information Workers, IT Pros, but not Frontline Workers who use shared devices. Users who exclusively use shared devices should generally only use portable credentials.
Your organization will need to determine which type of credential is preferred for each user persona at this stage. Microsoft recommends:
User Persona
Recommended Local Credential - Windows	Recommended Local Credential - macOS	Recommended Local Credential - iOS	Recommended Local Credential - Android	Recommended Local Credential - Linux
Information Worker	Windows Hello for Business
Platform SSO Secure Enclave Key	Passkey (Authenticator App)
Passkey (Authenticator App)	N/A (use portable credential instead)
Frontline Worker
N/A (use portable credential instead)	N/A (use portable credential instead)	N/A (use portable credential instead)	N/A (use portable credential instead)	N/A (use portable credential instead)
IT Pro / DevOps Worker	Windows Hello for Business	Platform SSO Secure Enclave Key	Passkey (Authenticator App)	Passkey (Authenticator App)	N/A (use portable credential instead)
Highly Regulated Worker
Windows Hello for Business or CBA
Platform SSO Secure Enclave Key or CBA
Passkey (Authenticator App) or CBA
Passkey (Authenticator App) or CBA
N/A (use smart card instead)

Refer to the following tips and guides to enable the recommended local credentials in your environment for the relevant user personas for your organization:
•	Windows Hello for Business
o	Microsoft recommends using the Cloud Kerberos Trust method to deploy Windows Hello for Business: Cloud Kerberos trust deployment guide. Cloud Kerberos Trust is applicable to any environment where users are synced from on-premises Active Directory to Microsoft Entra ID. It is beneficial for these synced users on both Entra Joined and Entra Hybrid Joined PCs.
o	Windows Hello for Business should only be used when each user on a PC is signing into that PC as themselves, it should not be used on kiosk devices that use a shared user account.
o	Windows Hello for Business supports up to 10 users per device. If your shared devices need to support more users then switch to using a portable credential instead, such as security keys
o	Biometrics are optional, but recommended: Prepare users to provision and use Windows Hello for Business
•	Platform SSO Secure Enclave Key
o	Platform SSO supports 3 different user authentication methods (Secure Enclave key, smart card, and password). Deploy the Secure Enclave key method to mirror your Windows Hello for Business on your Macs.
o	Platform SSO requires that Macs are enrolled in MDM. Intune-specific instructions are available here: Configure Platform SSO for macOS devices in Microsoft Intune
o	Refer to your MDM vendor’s documentation if you use a non-Intune MDM service on your Macs
•	Passkeys
o	Microsoft recommends that you leverage the same device registration option for bootstrapping passkeys in Microsoft Authenticator (as opposed to the cross device registration option).
o	Users will use their TAP to sign into Microsoft Authenticator directly on their iOS or Android device.
o	Passkeys are disabled by default in Microsoft Entra ID, enable them via policy: Enable passkeys in Microsoft Authenticator
o	Register passkeys in Authenticator on Android or iOS devices
Persona-Specific Considerations
Each persona has its own challenges and considerations that commonly come up during phishing-resistant passwordless deployments. As you identify which personas you need to accommodate, you should factor these considerations into your deployment project planning. Below are links to specific guidance for each persona:
•	Information Workers
•	Frontline Workers
•	IT Pros / DevOps Workers
•	Highly Regulated Workers

#### Step 6: Drive usage of phishing-resistant passwordless credentials
Test Deployment Strategy
Microsoft recommends that you test the deployment strategy created in the previous step with a set of test and pilot users. This phase should include the following steps:
•	Create a list of test users and early adopters. These users should be representative of your different user personas, and not just IT Admins
•	Create a Microsoft Entra ID group and add your test users to the group
•	Enable your authentication methods policies in Microsoft Entra ID and scope the test group to those methods
•	Measure the registration rollout for your pilot users by using the Authentication Methods Activity report
•	Create Conditional Access policies to enforce the use phishing-resistant passwordless credentials on each operating system type and target your pilot group
•	Measure the success of the enforcement using Azure Monitor and Workbooks
•	Gather feedback from users on the success of the rollout
Plan Rollout Strategy
Microsoft recommends driving usage based on which user personas are most ready for deployment. Typically, this means deploying for users in this order, but this may change depending on your organization:
1.	Information Workers
2.	Frontline Workers
3.	IT Pros / DevOps Workers
4.	Highly Regulated Workers
Use the following sections to create end user communications for each persona group, scope and rollout the passkeys registration feature, and user reporting and monitoring to track rollout progress.
Plan end user communications
Microsoft provides communication templates for end users. The authentication rollout material includes customizable posters and email templates to inform users about phishing-resistant passwordless authentication deployment. Use the communicate templates below to you’re your users understand the phishing-resistant passwordless deployment:
•	Passwordless sign-in with Microsoft Authenticator
•	Register the password reset verification method for a work or school account
•	Reset your work or school password using security info
•	Set up a security key as your verification method
•	Sign in to your accounts using the Microsoft Authenticator app
•	Sign in to your work or school account using your two-step verification method
•	Work or school account sign-in blocked by tenant restrictions
Communications should be repeated multiple times to help catch as many users as possible. For example, your organization may choose to communicate the different phases and timelines with a pattern like this:
1.	60 days out from enforcement: message the value of phishing-resistant authentication methods and encourage users to proactively enroll
2.	45 days out from enforcement: repeat message
3.	30 days out from enforcement: message that in 30 days phishing-resistant enforcement will begin, encourage users to proactively enroll
4.	15 days out from enforcement: repeat message, inform them of how to contact the help desk
5.	7 days out from enforcement: repeat message, inform them of how to contact the help desk
6.	1 day out from enforcement: inform them enforcement will occur in 24 hours, inform them of how to contact the help desk
Microsoft recommends communicating to users through different channels than just email. Other options may include Microsoft Teams messages, break room posters, and champion programs where select employees are trained to advocate for the program to their peers.
Reporting and monitoring
Microsoft Entra ID reports (such as Authentication Methods Activity and Sign-in event details for Microsoft Entra multifactor authentication) provide technical and business insights that can help you measure and drive adoption.
From the Authentication methods activity dashboard, you can view registration and usage.
•	Registration shows the number of users capable of phishing-resistant passwordless authentication and other authentication methods. Graphs include users registered by authentication method and recent registration by authentication method.
•	Usage shows the sign-ins by authentication method.
We recommend that your business and technical application owners assume ownership of and consume reports based on organization requirements.
•	Track phishing-resistant passwordless credentials rollout with Authentication Methods registration activity reports.
•	Track user adoption of phishing-resistant passwordless credentials with Authentication Methods sign in activity reports and sign in logs.
•	Use the sign-in activity report to track the authentication methods used to sign in to the various applications. Select the user row; select Authentication Details to view authentication method and its corresponding sign-in activity.
Microsoft Entra ID adds entries to audit logs when these conditions occur:
•	An administrator changes authentication methods.
•	A user makes any kind of change to their credentials within Microsoft Entra ID.
Microsoft Entra ID retains most auditing data for thirty days. We recommend longer retention for auditing, trend analysis, and other business needs. Access auditing data in the Microsoft Entra admin center or API and download into your analysis systems. If you require longer retention, export and consume logs in a SIEM tool such as Microsoft Sentinel, Splunk, or Sumo Logic.

Monitoring Help Desk Ticket Volume
Your IT help desk can provide an invaluable signal on how well your deployment is progressing, so Microsoft recommends tracking your help desk ticket volume when executing a phishing-resistant passwordless deployment. As your help desk ticket volume increases you should slow down the pace of your deployments, user communications, and enforcement actions. As the ticket volume decreases you can ramp these activities back up. Using this approach requires that you maintain flexibility in your rollout plan. For example, you could execute your deployments and then enforcements in waves that have ranges of dates rather than specific dates:
1.	June 1st-15th: Wave 1 cohort registration deployment and campaigns
2.	June 16th-30th: Wave 2 cohort registration deployment and campaigns
3.	July 1st-15th: Wave 3 cohort registration deployment and campaigns
4.	July 16th-31st: Wave 1 cohort enforcement enabled
5.	August 1st-15th: Wave 2 cohort enforcement enabled
6.	August 16th-31st: Wave 3 cohort enforcement enabled
As you execute these different phases you may need to slow down depending on the volume of help desk tickets opened and then resume when the volume has subsided. To execute on this strategy, Microsoft recommends that you create a Microsoft Entra ID security group for each Wave and add each group to your policies one at a time – this will help you avoid overwhelming your support teams.

#### Step 7: Phishing-resistance enforcement
This section focuses on phase 4.

