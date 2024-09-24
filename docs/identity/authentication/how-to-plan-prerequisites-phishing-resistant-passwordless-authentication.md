---
title: Plan prerequistes for a phishing-resistant passwordless authentication deployment in Microsoft Entra ID
description: Detailed guidance for planning the prerequisites to deploy passwordless and phishing-resistant authentication for organizations that use Microsoft Entra ID.

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
# Prerequisites for a phishing-resistant passwordless authentication deployment in Microsoft Entra ID

Before you start your Microsoft Entra phishing-resistant passwordless deployment project, complete these prerequisites: 

- Review license requirements
- Review the roles needed to perform privileged actions
- Identify stakeholder teams that need to collaborate

## License requirements

Registration and passwordless sign in with Microsoft Entra doesn't require a license, but we recommend at least a Microsoft Entra ID P1 license for the full set of capabilities associated with a passwordless deployment. 
For example, a Microsoft Entra ID P1 license helps you enforce passwordless sign in through Conditional Access, and track deployment with an authentication method activity report. Refer to the licensing requirements guidance for features referenced in this guide for specific licensing requirements.

## Integrate apps with Microsoft Entra ID
Microsoft Entra ID is a cloud-based Identity and Access Management (IAM) service that integrates integrates with many types of applications, including Sotware-as-a-Service (SaaS) apps, line-of-business (LOB) apps, on-premises apps, and more. 
You need to integrate your applications with Microsoft Entra ID to get the most benefit from your investment in passwordless and phishing-resistant authentication. 

As you integrate more apps with Microsoft Entra ID, you can protect more of your environment with Conditional Access policies that enforce the use of phishing-resistant authentication methods. 
To learn more about how to integrate apps with Microsoft Entra ID, see [Five steps to integrate your apps with Microsoft Entra ID](~/fundamentals/five-steps-to-full-application-integration.md).

When you develop your own applications, follow the developer guidance for supporting passwordless and phishing-resistant authentication. 
For more information, see [Support passwordless authentication with FIDO2 keys in apps you develop](~/identity-platform/support-fido2-authentication.md).

 
## Required roles
The following table lists least privileged role requirements for phishing-resistant passwordless deployment. 
We recommend that you enable phishing-resistant passwordless authentication for all privileged accounts.

Microsoft Entra role                | Description
------------------------------------|---------------------------------------------
[User Administrator](~/identity/role-based-access-control/permissions-reference.md#user-administrator) | To implement combined registration experience
[Authentication Administrator](~/identity/role-based-access-control/permissions-reference.md#authentication-administrator) | To implement and manage authentication methods
[Authentication Policy Administrator](~/identity/role-based-access-control/permissions-reference.md#authentication-policy-administrator) | To implement and manage the Authentication methods policy
User                                | To configure Authenticator app on device; to enroll security key device for web or Windows 10/11 sign-in

## Customer stakeholder teams

To ensure success, make sure that you engage with the right stakeholders, and that they understand their roles before you begin your plan and rollout. The following table lists commonly recommended stakeholder teams.

Stakeholder team                    | Description
------------------------------------|------------------------------------------------
Identity and Access Management (IAM) | Manages day-to-day operations of the IAM system
Information Security Architecture	   | Plans and designs the organization’s information security practices
Information Security Operations	     | Runs and monitors information security practices for Information Security Architecture
Security Assurance and Audit         | Helps ensure IT processes are secure and compliant. They conduct regular audits, assess risks, and recommend security measures to mitigate identified vulnerabilities and enhance the overall security posture.
Help Desk and Support	               | Assists end users who encounter issues during deployments of new technologies and policies, or when issues occur 
End-User Communications	             | Messages changes to end users in preparation to aid in driving user-facing technology rollouts


## Next steps


[Plan a phishing-resistant passwordless authentication deployment in Microsoft Entra ID](how-to-plan-phishing-resistant-passwordless-authentication.md)
[Deploy a phishing-resistant passwordless authentication deployment in Microsoft Entra ID](how-to-deploy-phishing-resistant-passwordless-authentication.md)
[Considerations for specific personas in a phishing-resistant passwordless authentication deployment in Microsoft Entra ID](how-to-plan-persona-phishing-resistant-passwordless-authentication.md)
