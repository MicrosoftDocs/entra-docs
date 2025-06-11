---
title: Plan a phishing-resistant passwordless authentication deployment in Microsoft Entra ID
description: Detailed guidance to deploy passwordless and phishing-resistant authentication for organizations that use Microsoft Entra ID.

ms.service: entra-id 
ms.subservice: authentication
ms.topic: how-to
ms.date: 03/04/2025

ms.author: justinha
author: mepples21
manager: dougeby
ms.reviewer: miepping

ms.collection: M365-identity-device-management
# Customer intent: As an identity administrator, I want to understand how to plan phishing-resistant and passwordless authentication deployment in Microsoft Entra ID

---
# Plan a phishing-resistant passwordless authentication deployment in Microsoft Entra ID

When you deploy and operationalize phishing-resistant passwordless authentication in your environment, we recommend a user persona-based approach. Different phishing-resistant passwordless methods are more effective than others for certain user personas. This deployment guide helps you see which types of methods and rollout plans make sense for user personas in your environment. The phishing-resistant passwordless deployment approach commonly has 6 steps, which roughly flow in order, but don't have to be 100% completed before moving on to other steps:     

## Determine your user personas
Determine the user personas relevant for your organization. This step is critical to your project because different personas have different needs. Microsoft recommends you consider and evaluate at least 4 generic user personas in your organization.

User persona | Description
-----|------------
Information workers | <li>Examples include office productivity staff, such as in marketing, finance, or human resources.<li>Other types of information workers may be executives and other high-sensitivity workers who need special controls<li>Typically have a 1:1 relationship with their mobile and computing devices<li>May bring their own devices (BYOD), especially for mobile
Frontline workers | <li>Examples include retail store workers, factory workers, manufacturing workers<li>Typically work only on shared devices or kiosks<li>May not be allowed to carry mobile phones
IT Pros/DevOps workers | <li>Examples include IT admins for on-premises Active Directory, Microsoft Entra ID, or other privileged accounts. other examples would be DevOps workers or DevSecOps workers who manage and deploy automations.<li>Typically have multiple user accounts, including a "normal" user account, and one or more administrative accounts<li>Commonly use remote access protocols, such as Remote Desktop Protocol (RDP) and Secure Shell Protocol (SSH), to administer remote systems<li>May work on locked down devices with Bluetooth disabled<li>May use secondary accounts to run non-interactive automations and scripts
Highly regulated workers | <li>Examples include US federal government workers subject to [Executive Order 14028](https://www.microsoft.com/security/blog/2022/02/17/us-government-sets-forth-zero-trust-architecture-strategy-and-requirements/) requirements, state and local government workers, or workers subject to specific security regulations<li>Typically have a 1:1 relationship with their devices, but have specific regulatory controls that must be met on those devices and for authentication<li>Mobile phones may not be allowed in secure areas<li>May access air-gapped environments without internet connectivity<li>May work on locked down devices with Bluetooth disabled


Microsoft recommends that you broadly deploy phishing-resistant passwordless authentication across your organization. Traditionally, information workers are the easiest user persona to begin with. Don't delay rollout of secure credentials for information workers while you resolve issues that affect IT Pros. Take the approach of "*don’t let perfect be the enemy of good*" and deploy secure credentials as much as possible. As more users sign in using phishing-resistant passwordless credentials, you reduce the attack surface of your environment.

Microsoft recommends that you define your personas, and then place each persona into a Microsoft Entra ID group specifically for that user persona. These groups are used in later steps to [roll out credentials](~/identity/authentication/how-to-deploy-phishing-resistant-passwordless-authentication.md#drive-usage-of-phishing-resistant-credentials) to different types of users, and when you begin to [enforce the use of phishing-resistant passwordless credentials](~/identity/authentication/how-to-deploy-phishing-resistant-passwordless-authentication.md#enforce-phishing-resistant-methods-for-sign-in).

## Plan device readiness

Devices are an essential aspect of any successful phishing-resistant passwordless deployment, since one of the goals of phishing-resistant passwordless credentials is to protect credentials with the hardware of modern devices. First, become familiar with [FIDO2 supportability for Microsoft Entra ID](concept-fido2-compatibility.md).

Ensure that your devices are prepared for phishing-resistant passwordless by patching to the latest supported versions of each operating system. Microsoft recommends your devices are running these versions at a minimum:

- Windows 10 22H2 (for Windows Hello for Business)
- Windows 11 22H2 (for the best user experience when using passkeys)
- macOS 13 Ventura
- iOS 17
- Android 14

These versions provide the best support for natively integrated features like passkeys, Windows Hello for Business, and macOS Platform Credential. Older operating systems may require external authenticators, like FIDO2 security keys, to support phishing-resistant passwordless authentication.


## Register users for phishing-resistant credentials

Credential registration and bootstrapping are the first major end-user facing activities in your phishing-resistant passwordless deployment project. This section covers the rollout of **portable** and **local** credentials. 

Credentials | Description | Benefits
------------|-------------|----------
**Portable** | Can be used [across devices](how-to-sign-in-passkey-authenticator.md). You can use **portable** credentials to sign in to another device, or to register credentials on other devices. | The most important type of credential to register for most users, as they can be used across devices, and provide phishing-resistant authentication in many scenarios.
**Local** | You can use **local** credentials to authenticate on a device without needing to rely on external hardware, such as using Windows Hello for Business biometric recognition to sign into an app in Microsoft Edge browser on the same PC | They have two main benefits over the portable credentials:<li>They provide redundancy. If users lose their portable device, forget it at home, or have other issues, then the local credential provides them with a backup method to continue to work on their computing device.<li>They provide a great user experience. With a local credential, users don't need to pull phones out of their pocket, scan QR codes, or perform other tasks that slow down authentication and add friction. Locally available phishing-resistant credentials help users sign in more easily on the devices they regularly use.


- For *new users*, the registration and bootstrapping process takes a user with no existing enterprise credentials, and verifies their identity. It bootstraps them into their first portable credential, and uses that portable credential to bootstrap other local credentials on each of their computing devices. After registration, the admin may enforce phishing-resistant authentication for users in Microsoft Entra ID.
- For *existing users*, this phase gets users to register for phishing-resistant passwordless on their existing devices directly, or using existing MFA credentials to bootstrap phishing-resistant passwordless credentials. The end goal is the same as new users - most users should have at least one **portable** credential, and then **local** credentials on each computing device. If you're an admin who deploys phishing-resistant passwordless for existing users, then you may be able to skip ahead to the [Onboarding Step 2: Bootstrapping a Portable Credential section](#onboarding-step-2-bootstrap-a-portable-credential).

Before you start, Microsoft recommends enabling passkey and other credentials for enterprise users in the tenant. If users are motivated to self-register for strong credentials, it's beneficial to allow it. At a minimum, you should enable the [Passkey (FIDO2) policy](~/identity/authentication/how-to-enable-passkey-fido2.md) so that users can register for passkeys and security keys if they prefer them.

This section focuses on phases 1-3:

:::image type="content" border="true" source="media/how-to-deploy-phishing-resistant-passwordless-authentication/planning-phases.png" alt-text="Diagram that shows the first three phases of the planning process." lightbox="media/how-to-deploy-phishing-resistant-passwordless-authentication/planning-phases.png":::


Users should have at least two authentication methods registered. With another method registered, the user has a backup method available if something happens to their primary method, like when a device is lost or stolen. For example, it's a good practice for users to have passkeys registered both on their phone, and locally on their workstation in Windows Hello for Business.

>[!NOTE]
>It is always recommended that users have at least two authentication methods registered. This ensures the user has a backup method available if something happens to their primary method, such as in cases of device loss or theft. For example, it is a good practice for users to have passkeys registered both on their phone and locally on their workstation in Windows Hello for Business.

>[!NOTE] 
>This guidance is tailored for currently existing support for passkeys in Microsoft Entra ID, which includes device-bound passkeys in Microsoft Authenticator and device-bound passkeys on physical security keys. Microsoft Entra ID plans to add support for synced passkeys. For more information, see [Public preview: Expanding passkey support in Microsoft Entra ID](https://techcommunity.microsoft.com/t5/microsoft-entra-blog/public-preview-expanding-passkey-support-in-microsoft-entra-id/ba-p/4062702). This guide will be updated to include synced passkey guidance once available. For example, many organizations may benefit from relying on sync for phase 3 in the preceding diagram rather than bootstrapping entirely new credentials.

### Onboarding step 1: Identity verification

For remote users who haven't proven their identity, enterprise onboarding is a significant challenge. Without proper identity verification, an organization cannot be completely certain that they are onboarding the person that they intend to. Microsoft Entra Verified ID can provide high assurance identity verification. Organizations can work with an identity verification partner (IDV) to verify the identities of new remote users in the onboarding process. After processing a user’s government-issued ID, the IDV can provide a Verified ID that affirms the user's identity. The new user presents this identity-affirming Verified ID to the hiring organization to establish trust and confirm that the organization is onboarding the right person. Organizations can add Face Check with Microsoft Entra Verified ID which adds a facial matching layer to the verification, ensuring that the trusted user is presenting the identity-affirming Verified ID in that moment.

After verifying their identity through the proofing process, new hires are given a Temporary Access Pass (TAP) that they can use to bootstrap their first portable credential.

Refer to the following guides to enable Microsoft Entra Verified ID onboarding and TAP issuance:

- [Onboard new remote employees using ID verification](~/verified-id/remote-onboarding-new-employees-id-verification.md)
- [Using Face Check with Microsoft Entra Verified ID to unlock high assurance verifications at scale](~/verified-id/using-facecheck.md)
- [Enable the Temporary Access Pass policy](howto-authentication-temporary-access-pass.md#enable-the-temporary-access-pass-policy)

Refer to the following links for licensing details for Microsoft Entra Verified ID:

- [Face Check with Microsoft Entra Verified ID pricing](~/verified-id/verified-id-pricing.md)
- [Microsoft Entra Plans and Pricing](https://www.microsoft.com/security/business/microsoft-entra-pricing)

Some organizations might choose other methods than Microsoft Entra Verified ID to onboard users and issue them their first credential. Microsoft recommends those organizations still use TAPs, or another way that lets a user onboard without a password. For example, you can [provision FIDO2 security keys using Microsoft Graph API](how-to-enable-passkey-fido2.md#provision-fido2-security-keys-using-microsoft-graph-api-preview).

### Onboarding step 2: Bootstrap a portable credential

To bootstrap existing users to phishing-resistant passwordless credentials, first determine if your users are registered for traditional MFA already. Users with traditional MFA methods registered can be targeted with phishing-resistant passwordless registration policies. They can use their traditional MFA to register for their first portable phishing-resistant credential, and then move on to register for local credentials as needed.

For new users or users without MFA, go through a process to issue users a Temporary Access Pass (TAP). You can issue a TAP the same way you give new users their first credential, or by using Microsoft Entra Verified ID integrations. Once users have a TAP, they're ready to bootstrap their first phishing-resistant credential.

It's important for the user’s first passwordless credential to be a portable credential that can be used to authenticate on other computing devices. For example, passkeys can be used to authenticate locally on an iOS phone, but they can also be used to authenticate on a Windows PC using a cross-device authentication flow. This cross-device capability allows that portable passkey to be used to bootstrap Windows Hello for Business on the Windows PC.

It's also important that each device the user regularly works on has a locally available credential to give the user the smoothest user experience possible. Locally available credentials reduce the time needed to authenticate because users don’t need to use multiple devices, and there are fewer steps. Using the TAP from Step 1 to register a portable credential that can bootstrap these other credentials enables the user to use phishing-resistant credentials natively across the many devices they may possess.

The following table lists recommendations for different personas:

User Persona | Recommended portable credential | Alternative portable credentials
-------------|---------------------------------|---------------------------------
Information worker | Passkey (Authenticator app) | Security key, smart card
Frontline worker | Security key | Passkey (Authenticator app), smart card
IT pro/DevOps worker | Passkey (Authenticator app) | Security key, smart card
Highly regulated worker | Certificate (smart card) | Passkey (Authenticator app), security key

Use the following guidance to enable recommended and alternative portable credentials for the relevant user personas for your organization:

Method | Guidance
-------|---------
Passkeys | <li>Microsoft recommends that users sign in to Microsoft Authenticator directly to bootstrap a passkey in the app.<li>Users can use their TAP to sign into Microsoft Authenticator directly on their iOS or Android device.<li>Passkeys are disabled by default in Microsoft Entra ID. You can [enable passkeys in Authentication methods policy](how-to-enable-authenticator-passkey.md).<li>[Register passkeys in Authenticator on Android or iOS devices](how-to-register-passkey-authenticator.md).
Security keys | <li>Security keys are turned off by default in Microsoft Entra ID. You can [enable FIDO2 security keys in the Authentication methods policy](how-to-enable-passkey-fido2.md).<li>Consider registering keys on behalf of your users with the Microsoft Entra ID provisioning APIs. For more information, see [Provision FIDO2 security keys using Microsoft Graph API](how-to-enable-passkey-fido2.md#provision-fido2-security-keys-using-microsoft-graph-api-preview).
Smart card/certificate-based authentication (CBA) | <li>Certificate-based authentication is more complicated to configure than passkeys or other methods. Consider only using it if necessary.<li>[How to configure Microsoft Entra certificate-based authentication](how-to-certificate-based-authentication.md).<li>Make sure to configure your on-premises PKI and Microsoft Entra ID CBA policies so that users truly complete multifactor authentication to sign in. The configuration generally requires the smart card Policy Object Identifier (OID) and the necessary affinity binding settings. For more advanced CBA configurations, see [Understanding the authentication binding policy](concept-certificate-based-authentication-technical-deep-dive.md#understanding-the-authentication-binding-policy).


### Onboarding step 3: Bootstrap local credentials on computing devices

After users have registered a portable credential, they're ready to bootstrap other credentials on each computing device they regularly use in a 1:1 relationship, which benefits their day-to-day user experience. 
This type of credential is common for information workers and IT pros, but not for frontline workers who share devices. 
Users who only share devices should only use portable credentials.

Your organization needs to determine which type of credential is preferred for each user persona at this stage. Microsoft recommends:

User persona | Recommended local credential - Windows | Recommended local credential - macOS | Recommended local credential - iOS | Recommended local credential - Android | Recommended Local Credential - Linux
-------------|----------------------------------|-----------------------------|--------------------------------|--------------------------------|----------------------
Information worker | Windows Hello for Business | Platform Single Sign-on (SSO) Secure Enclave Key | Passkey (Authenticator app) | Passkey (Authenticator app) | N/A (use portable credential instead)
Frontline worker | N/A (use portable credential instead) | N/A (use portable credential instead) | N/A (use portable credential instead) | N/A (use portable credential instead) | N/A (use portable credential instead)
IT pro/DevOps worker | Windows Hello for Business | Platform SSO Secure Enclave Key | Passkey (Authenticator app) | Passkey (Authenticator app) | N/A (use portable credential instead)
Highly Regulated worker | Windows Hello for Business or CBA | Platform SSO Secure Enclave Key or CBA | Passkey (Authenticator app) or CBA | Passkey (Authenticator app) or CBA | N/A (use smart card instead) 


Use the following guidance to enable the recommended local credentials in your environment for the relevant user personas for your organization:

Method | Guidance
-------|---------
Windows Hello for Business | <li>Microsoft recommends using the Cloud Kerberos Trust method to deploy Windows Hello for Business. For more information, see the [Cloud Kerberos trust deployment guide](/windows/security/identity-protection/hello-for-business/deploy/hybrid-cloud-kerberos-trust?tabs=intune). The Cloud Kerberos Trust method applies to any environment where users are synced from on-premises Active Directory to Microsoft Entra ID. It helps synced users on PCs that are either Microsoft Entra joined or Microsoft Entra hybrid joined.<li>Windows Hello for Business should only be used when each user on a PC is signing into that PC as themselves. It shouldn't be used on kiosk devices that use a shared user account.<li>Windows Hello for Business supports up to 10 users per device. If your shared devices need to support more users, then use a portable credential instead, such as security keys.<li>Biometrics are optional, but recommended. For more information, see [Prepare users to provision and use Windows Hello for Business](/windows/security/identity-protection/hello-for-business/deploy/prepare-users).
Platform SSO Secure Enclave Key | <li>Platform SSO supports 3 different user authentication methods (Secure Enclave key, smart card, and password). Deploy the Secure Enclave key method to mirror your Windows Hello for Business on your Macs.<li>Platform SSO requires that Macs are enrolled in Mobile Device Management (MDM). For specific instructions for Intune, see [Configure Platform SSO for macOS devices in Microsoft Intune](/mem/intune/configuration/platform-sso-macos).<li>Refer to your MDM vendor’s documentation if you use another MDM service on your Macs.
Passkeys | <li>Microsoft recommends the same device registration option to bootstrap passkeys in Microsoft Authenticator (rather than the cross-device registration option). <li>Users use their TAP to sign into Microsoft Authenticator directly on their iOS or Android device.<li>Passkeys are disabled by default in Microsoft Entra ID, enable them in the Authentication methods policy. For more information, see [Enable passkeys in Microsoft Authenticator](how-to-enable-authenticator-passkey.md). <li>Register passkeys in Authenticator on Android or iOS devices.


### Persona-specific considerations

Each persona has its own challenges and considerations that commonly come up during phishing-resistant passwordless deployments. As you identify which personas you need to accommodate, you should factor these considerations into your deployment project planning. The following links have specific guidance for each persona:

- [Information workers](how-to-plan-persona-phishing-resistant-passwordless-authentication.md#information-workers)
- [Frontline workers](how-to-plan-persona-phishing-resistant-passwordless-authentication.md#frontline-workers)
- [IT pros/DevOps workers](how-to-plan-persona-phishing-resistant-passwordless-authentication.md#it-prosdevops-workers)
- [Highly regulated workers](how-to-plan-persona-phishing-resistant-passwordless-authentication.md#highly-regulated-workers)

## Drive usage of phishing-resistant credentials

This step covers how to make it easier for users to adopt phishing-resistant credentials. You should test your deployment strategy, plan for the rollout, and communicate the plan to end users. Then you can create reports and monitor progress before you enforce phishing-resistant credentials across your organization.   

### Test deployment strategy

Microsoft recommends that you test the deployment strategy created in the previous step with a set of test and pilot users. This phase should include the following steps:

- Create a list of test users and early adopters. These users should represent your different user personas, and not just IT Admins.
- Create a Microsoft Entra ID group, and add your test users to the group.
- Enable your [Authentication methods policies](~/identity/authentication/concept-authentication-methods-manage.md) in Microsoft Entra ID, and scope the test group to the methods that you enable.
- Measure the registration rollout for your pilot users by using the [Authentication Methods Activity](~/identity/authentication/howto-authentication-methods-activity.md) report.
- Create Conditional Access policies to enforce the use phishing-resistant passwordless credentials on each operating system type, and target your pilot group.
- Measure the success of the enforcement using [Azure Monitor and Workbooks](~/identity/monitoring-health/overview-workbooks.md).
- Gather feedback from users on the success of the rollout.

### Plan rollout strategy

Microsoft recommends driving usage based on which user personas are most ready for deployment. Typically, this means deploying for users in this order, but this may change depending on your organization:

1. Information workers
1. Frontline workers
1. IT pros/DevOps workers
1. Highly regulated workers

Use the following sections to create end user communications for each persona group, scope and rollout the passkeys registration feature, and user reporting and monitoring to track rollout progress.

### Driving readiness with the Phishing-Resistant Passwordless Workbook (Preview)

Organizations may optionally choose to export their Microsoft Entra ID sign-in logs to [Azure Monitor](~/identity/monitoring-health/howto-integrate-activity-logs-with-azure-monitor-logs.yml) for long-term retention, threat hunting, and other purposes. Microsoft has released a [workbook](~/identity/monitoring-health/overview-workbooks.md) that organizations with logs in Azure Monitor may use to help with various phases of a phishing-resistant passwordless deployment. The Phishing-Resistant Passwordless Workbook can be accessed here: [aka.ms/PasswordlessWorkbook](https://aka.ms/PasswordlessWorkbook). Choose the workbook titled ***Phishing-Resistant Passwordless Deployment (Preview)***:

:::image type="content" border="true" source="media/how-to-deploy-phishing-resistant-passwordless-authentication/workbook-gallery.png" alt-text="Screenshot of various workbooks in Microsoft Entra ID." lightbox="media/how-to-deploy-phishing-resistant-passwordless-authentication/workbook-gallery.png":::

The workbook has two primary sections:

1. Enrollment Readiness Phase
1. Enforcement Readiness Phase

#### Enrollment readiness phase

Use the Enrollment Readiness Phase tab to analyze sign-in logs in your tenant, determining which users are ready for registration and which users may be blocked from registration. For example, with the Enrollment Readiness Phase tab you can select iOS as the OS platform and then Authenticator App Passkey as the type of credential you would like to assess your readiness for. You can then click on the workbook visualizations to filter down to users who are expected to have registration issues and export the list:

:::image type="content" border="true" source="media/how-to-deploy-phishing-resistant-passwordless-authentication/workbook-ios-filter.png" alt-text="Screenshot of the Enrollment phase of the Phishing-Resistant Passwordless workbook." lightbox="media/how-to-deploy-phishing-resistant-passwordless-authentication/workbook-ios-filter.png":::

The Enrollment Readiness Phase tab of the workbook can help you evaluate readiness for the following OSes and credentials:

- Windows
    - Windows Hello for Business
    - FIDO2 Security Key
    - Authenticator App Passkey
    - Certificate-Based Authentication / Smart Card
- macOS
    - Platform SSO Secure Enclave Key
    - FIDO2 Security Key
    - Authenticator App Passkey
    - Certificate-Based Authentication / Smart Card
- iOS
    - FIDO2 Security Key
    - Authenticator App Passkey
    - Certificate-Based Authentication / Smart Card
- Android
    - FIDO2 Security Key
    - Authenticator App Passkey
    - Certificate-Based Authentication / Smart Card

Use each exported list to triage users who may have registration issues. Responses to registration issues should include assisting users in upgrading device OS versions, replacing aging devices, and choosing alternative credentials where the preferred option is not viable. For example, your organization may choose to provide physical FIDO2 security keys to Android 13 users who cannot use Passkeys in the Microsoft Authenticator app.

Similarly, use the enrollment readiness report to assist you in building out lists of users who are ready to begin enrollment communications and campaigns, in alignment with your overall [rollout strategy](#plan-rollout-strategy).

#### Enforcement readiness phase

The first step of the enforcement readiness phase is creating a Conditional Access policy in Report-Only mode. This policy will populate your sign-in logs with data regarding whether or not access would have been blocked if you were to put users/devices in scope for phishing-resistant enforcement. Create a new Conditional Access policy in your tenant with these settings:

Setting | Value
------- | -----
User/Group Assignment | All users, excluding break glass accounts
App Assignment | All resources
Grant Controls | Require Authentication Strength - Phishing-resistant MFA
Enable policy | Report-only

Create this policy as early as possible in your rollout, preferably before even beginning your enrollment campaigns. This will ensure that you have a good historical dataset of which users and sign-ins would have been blocked by the policy if it was enforced.

Next, use the workbook to analyze where user/device pairs are ready for enforcement. Download lists of users who are ready for enforcement and add them to groups created in alignment with your [enforcement policies](#recommended-enforcement-conditional-access-policies). Begin by selecting the read-only Conditional Access policy in the policy filter:

:::image type="content" border="true" source="media/how-to-deploy-phishing-resistant-passwordless-authentication/workbook-enforcement-policy-selection-1.png" alt-text="Screenshot of the Enforcement phase of the Phishing-Resistant Passwordless workbook with a report-only Conditional Access policy selected." lightbox="media/how-to-deploy-phishing-resistant-passwordless-authentication/workbook-enforcement-policy-selection-1.png":::

The report will provide you with a list of users who would have been able to successfully pass the phishing-resistant passwordless requirement on each device platform. Download each list and put the appropriate users in enforcement group that aligns to the device platform.

:::image type="content" border="true" source="media/how-to-deploy-phishing-resistant-passwordless-authentication/workbook-enforcement-user-lists-1.png" alt-text="Screenshot of the Enforcement phase of the Phishing-Resistant Passwordless workbook's list of users ready for enforcement." lightbox="media/how-to-deploy-phishing-resistant-passwordless-authentication/workbook-enforcement-user-lists-1.png":::

Repeat this process over time, until you reach the point where each enforcement group contains most or all users. Eventually, you should be able to enable the report-only policy to provide enforcement for all users and device platforms in the tenant. Once you have reached this completed state you can remove the individual enforcement policies for each device OS, reducing the number of Conditional Access policies needed.

##### Investigating users not ready for enforcement

Use the ***Further Data Analysis*** tab to investigate why certain users are not ready for enforcement on various platforms. Select the ***Policy Not Satisfied*** box to filter the data down to user sign-ins that would have been blocked by the report-only Conditional Access policy.

:::image type="content" border="true" source="media/how-to-deploy-phishing-resistant-passwordless-authentication/workbook-enforcement-further-data-analysis-1.png" alt-text="Screenshot of the Enforcement phase of the Phishing-Resistant Passwordless workbook's further data analysis tab." lightbox="media/how-to-deploy-phishing-resistant-passwordless-authentication/workbook-enforcement-further-data-analysis-1.png":::

Use the data provided by this report to determine which users would have been blocked, which device OSes they were on, what type of client apps they were using, and what resources they were trying to access. This data should help you target those users for various remediation or enrollment actions, so that they can be effectively moved into scope for enforcement.

### Plan end user communications

Microsoft provides communication templates for end users. The [authentication rollout material](https://www.microsoft.com/download/details.aspx?id=57600) includes customizable email templates to inform users about phishing-resistant passwordless authentication deployment. Use the following templates to communicate to your users so they understand the phishing-resistant passwordless deployment:

- [Passkeys for Helpdesk](https://download.microsoft.com/download/1/4/E/14E6151E-C40A-42FB-9F66-D8D374D13B40/Passkey_Helpdesk.docx)
- [Passkeys coming soon](https://download.microsoft.com/download/1/4/E/14E6151E-C40A-42FB-9F66-D8D374D13B40/Passkeys%20coming%20soon.docx)
- [Register for Authenticator App Passkey](https://download.microsoft.com/download/1/4/E/14E6151E-C40A-42FB-9F66-D8D374D13B40/Register%20for%20Authenticator%20App%20Passkey.docx)
- [Reminder to register for Authenticator App Passkey](https://download.microsoft.com/download/1/4/E/14E6151E-C40A-42FB-9F66-D8D374D13B40/Reminder%20to%20register%20for%20Authenticator%20App%20Passkey.docx)

Communications should be repeated multiple times to help catch as many users as possible. For example, your organization may choose to communicate the different phases and timelines with a pattern like this:

1. 60 days out from enforcement: message the value of phishing-resistant authentication methods and encourage users to proactively enroll
1. 45 days out from enforcement: repeat message
1. 30 days out from enforcement: message that in 30 days phishing-resistant enforcement will begin, encourage users to proactively enroll
1. 15 days out from enforcement: repeat message, inform them of how to contact the help desk
1. 7 days out from enforcement: repeat message, inform them of how to contact the help desk
1. 1 day out from enforcement: inform them enforcement will occur in 24 hours, inform them of how to contact the help desk

Microsoft recommends communicating to users through other channels beyond just email. Other options may include Microsoft Teams messages, break room posters, and champion programs where select employees are trained to advocate for the program to their peers.

### Reporting and monitoring

Use the previously covered [Phishing-Resistant Passwordless Workbook](#driving-readiness-with-the-phishing-resistant-passwordless-workbook-preview) to assist with monitoring and reporting on your rollout. Additionally use the reports discussed below, or rely on them if you cannot use the Phishing-Resistant Passwordless Workbook.

Microsoft Entra ID reports (such as [Authentication Methods Activity](howto-authentication-methods-activity.md) and [Sign-in event details for Microsoft Entra multifactor authentication](howto-mfa-reporting.md)) provide technical and business insights that can help you measure and drive adoption.

From the Authentication methods activity dashboard, you can view registration and usage.

- **Registration** shows the number of users capable of phishing-resistant passwordless authentication, and other authentication methods. You can see graphs that show which authentication methods users registered, and recent registration for each method.
- **Usage** shows which authentication methods were used for sign-in.

Business and technical application owners should own and receive reports based on organization requirements.

- Track phishing-resistant passwordless credentials rollout with Authentication Methods registration activity reports.
- Track user adoption of phishing-resistant passwordless credentials with Authentication Methods sign in activity reports and sign in logs.
- Use the [sign-in activity report](~/identity/monitoring-health/concept-sign-ins.md) to track the authentication methods used to sign in to the various applications. Select the user row; select **Authentication Details** to view authentication method and its corresponding sign-in activity.

Microsoft Entra ID adds entries to audit logs when these conditions occur:

- An administrator changes authentication methods.
- A user makes any kind of change to their credentials within Microsoft Entra ID.

Microsoft Entra ID retains most auditing data for 30 days. We recommend longer retention for auditing, trend analysis, and other business needs. 

Access auditing data in the Microsoft Entra admin center or API and download into your analysis systems. If you require longer retention, export and consume logs in a Security Information and Event Management (SIEM) tool, such as Microsoft Sentinel, Splunk, or Sumo Logic.

### Monitor help desk ticket volume

Your IT help desk can provide an invaluable signal on how well your deployment is progressing, so Microsoft recommends tracking your help desk ticket volume when executing a phishing-resistant passwordless deployment. 

As your help desk ticket volume increases you should slow down the pace of your deployments, user communications, and enforcement actions. As the ticket volume decreases you can ramp these activities back up. Using this approach requires that you maintain flexibility in your rollout plan. 

For example, you could execute your deployments and then enforcements in waves that have ranges of dates rather than specific dates:

1. June 1st-15th: Wave 1 cohort registration deployment and campaigns
1. June 16th-30th: Wave 2 cohort registration deployment and campaigns
1. July 1st-15th: Wave 3 cohort registration deployment and campaigns
1. July 16th-31st: Wave 1 cohort enforcement enabled
1. August 1st-15th: Wave 2 cohort enforcement enabled
1. August 16th-31st: Wave 3 cohort enforcement enabled

As you execute these different phases, you may need to slow down depending on the volume of help desk tickets opened and then resume when the volume has subsided. To execute on this strategy, Microsoft recommends that you create a Microsoft Entra ID security group for each wave, and add each group to your policies one at a time. This approach helps to avoid overwhelming your support teams.

## Enforce phishing-resistant methods for sign-in

This section focuses on phase 4.

:::image type="content" border="true" source="media/how-to-deploy-phishing-resistant-passwordless-authentication/enforcement-phase.png" alt-text="Diagram that highlights the enforcement phase of the deployment." lightbox="media/how-to-deploy-phishing-resistant-passwordless-authentication/enforcement-phase.png":::

The final phase of a phishing-resistant passwordless deployment is enforcing the use of phishing-resistant credentials. The primary mechanism for doing this in Microsoft Entra ID is [Conditional Access authentication strengths](concept-authentication-strengths.md#authentication-strengths). Microsoft recommends you approach enforcement for each persona based on a user/device pair methodology. For example, an enforcement rollout could follow this pattern:

1. Information workers on Windows and iOS
1. Information workers on macOS and Android
1. IT Pros on iOS and Android
1. FLWs on iOS and Android
1. FLWs on Windows and macOS
1. IT Pros on Windows and macOS

Microsoft recommends that you build a report of all your user/device pairs by using sign-in data from your tenant. You can use querying tools like [Azure Monitor and Workbooks](~/identity/monitoring-health/overview-workbooks.md). At minimum, try to identify all user/device pairs that match these categories.

Use the previously covered [Phishing-Resistant Passwordless Workbook](#driving-readiness-with-the-phishing-resistant-passwordless-workbook-preview) to assist with the enforcement phase, if possible.

For each user, create a list of which operating systems they regularly use for work. Map the list to the readiness for phishing-resistant sign-in enforcement for that user/device pair.

OS type | Ready for Enforcement | Not Ready for Enforcement
--------|-----------------------|--------------------------
Windows | 10+ | 8.1 and earlier, Windows Server
iOS | 17+ | 16 and earlier
Android | 14+ | 13 and earlier
macOS | 13+ (Ventura) | 12 and earlier
VDI| Depends<sup>1</sup> | Depends<sup>1</sup>
Other | Depends<sup>1</sup> | Depends<sup>1</sup>

<sup>1</sup>For each user/device pair where the device version isn't immediately ready for enforcement, determine how to address the need to enforce phishing-resistance. Consider the following options for older operating systems, virtual desktop infrastructure (VDI), and other operating systems such as Linux:

- Enforce phishing-resistance using external hardware – FIDO2 security keys
- Enforce phishing-resistance using external hardware – smart cards
- Enforce phishing-resistance using remote credentials, such as passkeys in the cross-device authentication flow
- Enforce phishing-resistance using remote credentials inside of RDP tunnels (especially for VDI)

The key task is to measure through data which users and personas are ready for enforcement on particular platforms. Begin your enforcement actions on user/device pairs that are ready for enforcement to "stop the bleeding," and reduce the amount of phishable authentication occurring in your environment. 

Then move on to other scenarios where the user/device pairs require readiness efforts. Work your way through the list of user/device pairs until you enforce phishing-resistant authentication across the board. 

Create a set of Microsoft Entra ID groups to roll out enforcement gradually. Reuse the groups from the [previous step](#monitor-help-desk-ticket-volume) if you used the wave-based rollout approach.

### Recommended enforcement Conditional Access policies

Target each group with a specific Conditional Access policy. This approach helps you roll out your enforcement controls gradually by user/device pair.

Policy | Group name targeted in the policy | Policy – Device platform condition | Policy – Grant control
-------|-----------------------------------|------------------------------------|-----------------------
1	| Windows phishing-resistant passwordless ready users | Windows | Require authentication strength – Phishing-resistant MFA
2	| macOS phishing-resistant passwordless ready users | macOS | Require authentication strength – Phishing-resistant MFA
3	| iOS phishing-resistant passwordless ready users | iOS | Require authentication strength – Phishing-resistant MFA
4	| Android phishing-resistant passwordless ready users | Android | Require authentication strength – Phishing-resistant MFA
5	| Other phishing-resistant passwordless ready users | Any except Windows, macOS, iOS, or Android | Require authentication strength – Phishing-resistant MFA

Add each user to each group as you determine whether their device and operating system is ready, or they don’t have a device of that type. At the end of the rollout, each user should be in one of the groups.

## Respond to risk for passwordless users

Microsoft Entra ID Protection helps organizations detect, investigate, and remediate identity-based risks. Microsoft Entra ID Protection provides important and useful detections for your users even after they switch to using phishing-resistant passwordless credentials. For example, some relevant detections for phishing-resistant users include:

- Activity from anonymous IP address
- Admin confirmed user compromised
- Anomalous Token
- Malicious IP address
- Microsoft Entra threat intelligence
- Suspicious browser
- Attacker in the middle
- Possible attempt to access Primary Refresh Token (PRT)
- And others: [Risk detections mapped to riskEventType](~/id-protection/concept-identity-protection-risks.md)

Microsoft recommends that Microsoft Entra ID Protection customers take the following actions to best protect their phishing-resistant passwordless users:

1. Review the Microsoft Entra ID Protection deployment guidance: [Plan an ID Protection deployment](~/id-protection/how-to-deploy-identity-protection.md)
1. Configure your risk logs to export to a SIEM
1. Investigate and act on any medium **user** risk
1. Configure a Conditional Access policy to block high risk **users**

After you deploy Microsoft Entra ID Protection, consider using [Conditional Access token protection](~/identity/conditional-access/concept-token-protection.md). As users sign in with phishing-resistant passwordless credentials, attacks and detections continue to evolve. For example, when user credentials can no longer be easily phished, attackers may move on to try to exfiltrate tokens from user devices. Token protection helps mitigate this risk by binding tokens to the hardware of the device they were issued to.

## Next steps

[Considerations for specific personas in a phishing-resistant passwordless authentication deployment in Microsoft Entra ID](how-to-plan-persona-phishing-resistant-passwordless-authentication.md)

[Considerations for Remote Desktop Connections in a phishing-resistant passwordless authentication deployment in Microsoft Entra ID](how-to-plan-rdp-phishing-resistant-passwordless-authentication.md)
