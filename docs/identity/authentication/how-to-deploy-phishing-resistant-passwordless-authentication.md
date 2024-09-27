---
title: Deploy a phishing-resistant passwordless authentication deployment in Microsoft Entra ID
description: Detailed guidance to deploy passwordless and phishing-resistant authentication for organizations that use Microsoft Entra ID.

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
# Deploy a phishing-resistant passwordless authentication deployment in Microsoft Entra ID

This topic covers the deployment steps for a phishing-resistant passwordless authentication deployment in Microsoft Entra ID. Before you proceed, make sure you complete the planning steps for the deployment. For more information, see [Plan a phishing-resistant passwordless authentication deployment in Microsoft Entra ID](how-to-deploy-phishing-resistant-passwordless-authentication-overview.md).

## Register users for phishing-resistant credentials

Credential registration and bootstrapping is the first major end-user facing activity in your phishing-resistant passwordless deployment project. 
This section covers the rollout of **portable** and **local** credentials. 

Credentials | Description | Benefits
------------|-------------|----------
**Portable** | Can be used [across devices](how-to-sign-in-passkey-authenticator.md). You can use **portable** credentials to sign in to another device, or to register credentials on other devices. | The most important type of credential to register, as they can be used across devices, and provide phishing-resistant authentication in many scenarios.
**Local** | used to authenticate on a device without needing to rely on external hardware, such as using the Windows Hello for Business biometric recognition to sign into an app in Microsoft Edge browser on the same PC | They have two main benefits beyond those of the portable credentials:<br>They provide redundancy. If users lose their portable device, forget it at home, or have other issues, then the local credential provides them with a backup method to continue to work on their computing device.<br>They provide a great user experience. With a local credential, users don't need to pull phones out of their pocket, scan QR codes, or perform other tasks that slow down authentication and add friction. Locally available phishing-resistant credentials helps users sign in more easily on the devices they regularly use.


- For *new users*, registration and bootstrapping takes a user with no existing enterprise credentials, verifies their identity, bootstraps them into their first portable credential, and then use that portable credential to bootstrap other local credentials on each of their computing devices. Finally, you enforce phishing-resistant authentication for users in Microsoft Entra ID.
- For *existing users*, this phase gets users to register for phishing-resistant passwordless on their existing devices directly, or use existing MFA credentials to bootstrap phishing-resistant passwordless credentials. The end goal is the same as new users. Most users should have at least one portable credential, and then local credentials on each computing device.

Before you start, Microsoft recommends enabling passkey and other credentials for enterprise users in the tenant. 
If users are motivated to self-register for strong credentials, it's beneficial to allow it. 
At a minimum, it's recommended to enable the **Passkey (FIDO2)** policy so that users can register for passkeys and security keys if they prefer them.

This section focuses on phases 1-3:

:::image type="content" border="true" source="media/how-to-deploy-phishing-resistant-passwordless-authentication/planning-phases.png" alt-text="Diagram that shows the first three phases of the planning process.":::


Users should have at least two authentication methods registered. This ensures the user has a backup method available if something happens to their primary method, like when a device is lost or stolen. For example, it's a good practice for users to have passkeys registered both on their phone, and locally on their workstation in Windows Hello for Business.

>[!NOTE] 
>This guidance is tailored for currently existing support for passkeys in Microsoft Entra ID, which includes device-bound passkeys in Microsoft Authenticator and device-bound passkeys on physical security keys. Microsoft Entra ID plans to add support for syncable passkeys. For more information, see [Public preview: Expanding passkey support in Microsoft Entra ID](https://techcommunity.microsoft.com/t5/microsoft-entra-blog/public-preview-expanding-passkey-support-in-microsoft-entra-id/ba-p/4062702). This guide will be updated to include syncable passkey guidance once available. For example, many organizations may benefit from relying on sync for phase 3 in the preceding diagram rather than bootstrapping entirely new credentials.

### Onboarding step 1: Identity verification

For remote users who haven't proven their identity, enterprise onboarding is a significant challenge. 
Microsoft Entra Verified ID can help customers who want high assurance ID verification. 
It can use attenstations based on government-issued ID as a way to establish user identity trust. 

In this phase, users are directed to an identity verification partner service. 
They go through a proofing process determined by the organization and the verification partner service they choose. 
At the end of this process, users are given a Temporary Access Pass (TAP) that they can use to bootstrap their first portable credential.

Refer to the following guides to enable verified ID onboarding and TAP issuance: 

- [Onboard new remote employees using ID verification](~/verified-id/remote-onboarding-new-employees-id-verification.md)
- [Enable the Temporary Access Pass policy](howto-authentication-temporary-access-pass.md#enable-the-temporary-access-pass-policy)

>[!Note]
>Microsoft Entra Verified ID is part of the Entra Suite license.

Some organizations might choose other methods than Verified IDs to onboard users and issue them their first credential. 
Microsoft recommends those organizations still use TAP, or another way that lets a user onboard without a password. For example, you can [provision FIDO2 security keys using Microsoft Graph API (preview)](how-to-enable-passkey-fido2.md#provision-fido2-security-keys-using-microsoft-graph-api-preview).


### Onboarding step 2: Bootstrap a portable credential

Once users possess a TAP, they are ready to bootstrap their first phishing-resistant credential. 
It's important for the user’s first credential to be a portable credential that can be used to authenticate on other computing devices. 

For example, a user can sign in with a passkey locally on their iOS phone. 
They can use the same passkey on their phone to sign in to a Windows PC by using cross-device authentication. 
Cross-device authentication allows that passkey to be used as a portable credential to bootstrap Windows Hello for Business on the Windows PC. 

It's important that each of the user's regular devices has local credentials. 
Local credentials give the user the smoothest possible sign-in experience. 
They are simpler and faster because users don’t need to use multiple devices and there are fewer steps. 

Using the TAP from step 1 to register a portable credential that can bootstrap these other credentials enables the user to use phishing-resistant credentials natively across any device they possess.

Your organization needs to determine which type of credential is preferred for each user persona at this stage. 
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
Passkeys | - Microsoft recommends that users sign in to Microsoft Authenticator directly to bootstrap a passkey in the app.<br>- Users will use their TAP to sign into Microsoft Authenticator directly on their iOS or Android device.<br>- Passkeys are disabled by default in Microsoft Entra ID. You can [enable passkeys in Authentication methods policy](how-to-enable-authenticator-passkey.md).<br>- [Register passkeys in Authenticator on Android or iOS devices](how-to-register-passkey-authenticator.md).
Security keys | - Security keys are turned off by default in Microsoft Entra ID. You can [enable FIDO2 security keys in the Authentication methods policy](how-to-enable-passkey-fido2.md).<br>- Consider registering keys on behalf of your users with the Microsoft Entra ID provisioning APIs. For more information, see [Provision FIDO2 security keys using Microsoft Graph API (preview)](how-to-enable-passkey-fido2.md#provision-fido2-security-keys-using-microsoft-graph-api-preview).
Smart card/certificate-based authentication (CBA) | - Certificate-based authentication is more complicated to configure than passkeys or other methods. Consider only using it if required.<br>- [How to configure Microsoft Entra certificate-based authentication](how-to-certificate-based-authentication.md).<br>- Make sure to configure your on-premises PKI and Microsoft Entra ID CBA policies so that users truly complete multifactor authentication to sign in. The configuration generally requires the smart card Policy OID and the necessary affinity binding settings. For more advanced CBA configurations, see [Understanding the authentication binding policy](concept-certificate-based-authentication-technical-deep-dive.md#understanding-the-authentication-binding-policy).


### Onboarding step 3: Bootstrap local credentials on computing devices

After users have registered a portable credential, they are ready to bootstrap other credentials on each computing device they regularly use in a 1:1 relationship, which benefits their day-to-day user experience. 
This type of credential is common for information workers and IT pros, but not for frontline workers who share devices. 
Users who only share devices should generally only use portable credentials.

Your organization needs to determine which type of credential is preferred for each user persona at this stage. Microsoft recommends:

User persona | Recommended local credential - Windows | Recommended local credential - macOS | Recommended local credential - iOS | Recommended local credential - Android | Recommended Local Credential - Linux
-------------|----------------------------------|-----------------------------|--------------------------------|--------------------------------|----------------------
Information worker | Windows Hello for Business | Platform SSO Secure Enclave Key | Passkey (Authenticator app) | Passkey (Authenticator app) | N/A (use portable credential instead)
Frontline worker | N/A (use portable credential instead) | N/A (use portable credential instead) | N/A (use portable credential instead) | N/A (use portable credential instead) | N/A (use portable credential instead)
IT pro/DevOps worker | Windows Hello for Business | Platform SSO Secure Enclave Key | Passkey (Authenticator app) | Passkey (Authenticator app) | N/A (use portable credential instead)
Highly Regulated worker | Windows Hello for Business or CBA | Platform SSO Secure Enclave Key or CBA | Passkey (Authenticator app) or CBA | Passkey (Authenticator app) or CBA | N/A (use smart card instead) 


Use the following guidance to enable the recommended local credentials in your environment for the relevant user personas for your organization:

Method | Guidance
-------|---------
Windows Hello for Business | - Microsoft recommends using the Cloud Kerberos Trust method to deploy Windows Hello for Business. For more information, see the [Cloud Kerberos trust deployment guide](/windows/security/identity-protection/hello-for-business/deploy/hybrid-cloud-kerberos-trust?tabs=intune). Cloud Kerberos Trust is applicable to any environment where users are synced from on-premises Active Directory to Microsoft Entra ID. It is beneficial for these synced users on both Entra Joined and Entra Hybrid Joined PCs.<br>- Windows Hello for Business should only be used when each user on a PC is signing into that PC as themselves, it should not be used on kiosk devices that use a shared user account.<br>- Windows Hello for Business supports up to 10 users per device. If your shared devices need to support more users then switch to using a portable credential instead, such as security keys.<br>- Biometrics are optional, but recommended. For more information, see [Prepare users to provision and use Windows Hello for Business](/windows/security/identity-protection/hello-for-business/deploy/prepare-users).
Platform SSO Secure Enclave Key | - Platform SSO supports 3 different user authentication methods (Secure Enclave key, smart card, and password). Deploy the Secure Enclave key method to mirror your Windows Hello for Business on your Macs.<br>- Platform SSO requires that Macs are enrolled in Mobile Device Management (MDM). For specifc instructions for Intune, see [Configure Platform SSO for macOS devices in Microsoft Intune](/mem/intune/configuration/platform-sso-macos).<br>- Refer to your MDM vendor’s documentation if you use another MDM service on your Macs.
Passkeys | - Microsoft recommends the same device registration option to bootstrap passkeys in Microsoft Authenticator (rather than the cross-device registration option). <br>- Users use their TAP to sign into Microsoft Authenticator directly on their iOS or Android device.<br>- Passkeys are disabled by default in Microsoft Entra ID, enable them in the Authentication methods policy. For more information, see [Enable passkeys in Microsoft Authenticator](how-to-enable-authenticator-passkey.md). <br>- Register passkeys in Authenticator on Android or iOS devices.


### Persona-specific considerations

Each persona has its own challenges and considerations that commonly come up during phishing-resistant passwordless deployments. As you identify which personas you need to accommodate, you should factor these considerations into your deployment project planning. The following links have specific guidance for each persona:

- [Information workers](how-to-plan-persona-phishing-resistant-passwordless-authentication.md#information-workers)
- [Frontline workers](how-to-plan-persona-phishing-resistant-passwordless-authentication.md#frontline-workers)
- [IT pros/DevOps workers](how-to-plan-persona-phishing-resistant-passwordless-authentication.md#it-prosdevops-workers)
- [Highly regulated workers](how-to-plan-persona-phishing-resistant-passwordless-authentication.md#highly-regulated-workers)

## Drive usage of phishing-resistant credentials

This step covers how to make it easier for users to adopt phishing-resistant credentials. 
You should test your deployment strategy, plan for the rollout, and communicate the plan to end users. 
Then you can create reports and monitor progress before you enforce phishing-resistant credentials across your organization.   

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

### Plan end user communications
Microsoft provides communication templates for end users. The [authentication rollout material](https://www.microsoft.com/download/details.aspx?id=57600) includes customizable posters and email templates to inform users about phishing-resistant passwordless authentication deployment. Use the communicate templates below to you’re your users understand the phishing-resistant passwordless deployment:

- [Passwordless sign-in with Microsoft Authenticator](howto-authentication-passwordless-phone.md)
- [Register the password reset verification method for a work or school account](https://support.microsoft.com/account-billing/register-the-password-reset-verification-method-for-a-work-or-school-account-47a55d4a-05b0-4f67-9a63-f39a43dbe20a)
- [Reset your work or school password using security info](https://support.microsoft.com/en-us/account-billing/reset-your-work-or-school-password-using-security-info-23dde81f-08bb-4776-ba72-e6b72b9dda9e)
- [Set up a security key as your verification method](https://support.microsoft.com/en-us/account-billing/set-up-a-security-key-as-your-verification-method-2911cacd-efa5-4593-ae22-e09ae14c6698)
- [Sign in to your accounts using the Microsoft Authenticator app](https://support.microsoft.com/en-us/account-billing/sign-in-to-your-accounts-using-the-microsoft-authenticator-app-582bdc07-4566-4c97-a7aa-56058122714c)
- [Sign in to your work or school account using your two-step verification method](https://support.microsoft.com/en-us/account-billing/sign-in-to-your-work-or-school-account-using-your-two-step-verification-method-c7293464-ef5e-4705-a24b-c4a3ec0d6cf9)
- [Work or school account sign-in blocked by tenant restrictions](https://support.microsoft.com/en-us/account-billing/work-or-school-account-sign-in-blocked-by-tenant-restrictions-8a9d5d06-28c4-4c79-bc50-1167abbf516b)

Communications should be repeated multiple times to help catch as many users as possible. 
For example, your organization may choose to communicate the different phases and timelines with a pattern like this:

1. 60 days out from enforcement: message the value of phishing-resistant authentication methods and encourage users to proactively enroll
1. 45 days out from enforcement: repeat message
1. 30 days out from enforcement: message that in 30 days phishing-resistant enforcement will begin, encourage users to proactively enroll
1. 15 days out from enforcement: repeat message, inform them of how to contact the help desk
1. 7 days out from enforcement: repeat message, inform them of how to contact the help desk
1. 1 day out from enforcement: inform them enforcement will occur in 24 hours, inform them of how to contact the help desk

Microsoft recommends communicating to users through other channels beyond email. 
Other options may include Microsoft Teams messages, break room posters, and champion programs where select employees are trained to advocate for the program to their peers.

### Reporting and monitoring
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

Microsoft Entra ID retains most auditing data for 30 days. 
We recommend longer retention for auditing, trend analysis, and other business needs. 

Access auditing data in the Microsoft Entra admin center or API and download into your analysis systems. 
If you require longer retention, export and consume logs in a Security Information and Event Management (SIEM) tool, such as Microsoft Sentinel, Splunk, or Sumo Logic.

### Monitoring help desk ticket volume
Your IT help desk can provide an invaluable signal on how well your deployment is progressing, so Microsoft recommends tracking your help desk ticket volume when executing a phishing-resistant passwordless deployment. 

As your help desk ticket volume increases you should slow down the pace of your deployments, user communications, and enforcement actions. 
As the ticket volume decreases you can ramp these activities back up. 
Using this approach requires that you maintain flexibility in your rollout plan. 

For example, you could execute your deployments and then enforcements in waves that have ranges of dates rather than specific dates:

1. June 1st-15th: Wave 1 cohort registration deployment and campaigns
1. June 16th-30th: Wave 2 cohort registration deployment and campaigns
1. July 1st-15th: Wave 3 cohort registration deployment and campaigns
1. July 16th-31st: Wave 1 cohort enforcement enabled
1. August 1st-15th: Wave 2 cohort enforcement enabled
1. August 16th-31st: Wave 3 cohort enforcement enabled

As you execute these different phases, you may need to slow down depending on the volume of help desk tickets opened and then resume when the volume has subsided. 
To execute on this strategy, Microsoft recommends that you create a Microsoft Entra ID security group for each wave, and add each group to your policies one at a time. 
This approach helps to avoid overwhelming your support teams.

## Enforce phishing-resistant methods for sign-in

This section focuses on phase 4.

:::image type="content" border="true" source="media/how-to-deploy-phishing-resistant-passwordless-authentication/enforcement-phase.png" alt-text="Diagram that highlights the enforcement phase of the deployment.":::

The final phase of a phishing-resistant passwordless deployment is enforcing the use of phishing-resistant credentials. The primary mechanism for doing this in Microsoft Entra ID is [Conditional Access authentication strengths](concept-authentication-strengths.md#authentication-strengths). Microsoft recommends you approach enforcement for each persona based on a user/device pair methodology. For example, an enforcement rollout could follow this pattern:

1. Information workers on Windows and iOS
1. Information workers on macOS and Android
1. IT Pros on iOS and Android
1. FLWs on iOS and Android
1. FLWs on Windows and macOS
1. IT Pros on Windows and macOS

Microsoft recommends that you build a report of all your user/device pairs by using sign-in data from your tenant. 
You can use querying tools like [Azure Monitor and Workbooks](~/identity/monitoring-health/overview-workbooks.md). 
At minimum, try to identify all user/device pairs that match these categories. 

For each user, create a list of which operating systems they regularly use for work. 
Map the list to the readiness for phishing-resistant sign-in enforcement for that user/device pair.

OS type | Ready for Enforcement | Not Ready for Enforcement
--------|-----------------------|--------------------------
Windows | 10+ | 8.1 and earlier, Windows Server
iOS | 17+ | 16 and earlier
Android | 14+ | 13 and earlier
macOS | 13+ (Ventura) | 12 and earlier
VDI| Depends* | Depends*
Other | Depends* | Depends*

For each user/device pair where the device version is not immediately ready for enforcement, you will need to determine how you will address the need to enforce phishing-resistance. The following options should be considered for older operating systems, virtual desktop infrastructure (VDI), and other operating systems such as Linux:

- Enforce phishing-resistance using external hardware – FIDO2 security keys
- Enforce phishing-resistance using external hardware – smart cards
- Enforce phishing-resistance using remote credentials, such as passkeys in the cross-device authentication flow
- Enforce phishing-resistance using remote credentials inside of RDP tunnels (especially for VDI)

The key task to perform is measuring through data which users and personas are ready for enforcement on particular platforms. 
Begin your enforcement actions on user/device pairs that are ready for enforcement to "stop the bleeding" and reduce the amount of phishable authentication occurring in your environment. 

Then move on to other scenarios where the user/device pairs require readiness efforts. 
Work your way through the list of user/device pairs until you have enforced phishing-resistant authentication across the board. 

Create a set of Entra ID groups to roll out enforcement gradually. 
Reuse the groups from the [previous step](#monitoring-help-desk-ticket-volume) if you used the wave-based rollout approach. 

Each group will be targeted by a specific Conditional Access policy. 
This approach helps you roll out your enforcement controls gradually by user/device pair.

Policy | Group name targeted in the policy | Policy – Device platform condition | Policy – Grant control
-------|-----------------------------------|------------------------------------|-----------------------
1	| Windows phishing-resistant passwordless ready users | Windows | Require authentication strength – Phishing-resistant MFA
2	| macOS phishing-resistant passwordless ready users | macOS | Require authentication strength – Phishing-resistant MFA
3	| iOS phishing-resistant passwordless ready users | iOS | Require authentication strength – Phishing-resistant MFA
4	| Android phishing-resistant passwordless ready users | Android | Require authentication strength – Phishing-resistant MFA
5	| Other phishing-resistant passwordless ready users | Any except Windows, macOS, iOS, or Android | Require authentication strength – Phishing-resistant MFA


Add each user to each group as you determine whether their device and operating system is ready, or they don’t have a device of that type. 
At the end of the rollout, each user should be in one of the groups.

## Next steps

[Considerations for specific personas in a phishing-resistant passwordless authentication deployment in Microsoft Entra ID](how-to-plan-persona-phishing-resistant-passwordless-authentication.md)

