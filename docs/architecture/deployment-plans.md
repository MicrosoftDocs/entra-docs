---
title: Microsoft Entra deployment plans
description: Guidance on Microsoft Entra deployment, such as authentication, devices, hybrid scenarios, governance, and more.
author: gargi-sinha
manager: martinco
ms.service: entra
ms.subservice: architecture
ms.topic: article
ms.date: 02/07/2024
ms.author: gasinh
---

# Microsoft Entra deployment plans

Azure Active Directory is now [Microsoft Entra ID](~/fundamentals/whatis.md), which can safeguard your organization with cloud identity and access management. The solution connects employees, customers, and partners to their apps, devices, and data.

Use this article's guidance to help build your plan to deploy Microsoft Entra ID. Learn about plan-building basics and then use the following sections for authentication deployment, apps and devices, hybrid scenarios, user identity, and more.

## Stakeholders and roles

When beginning your deployment plans, include your key stakeholders. Identify and document stakeholders, affected roles, and the areas of ownership and responsibilities that enable an effective deployment. Titles and roles differ from one organization to another, however the ownership areas are similar. See the following table for common and influential roles that affect any deployment plan.

|Role |Responsibility |
|-|-|
|Sponsor|An enterprise senior leader with authority to approve or assign budget and resources. The sponsor is the connection between managers and the executive team.|
|End users|The people for whom the service is implemented. Users can participate in a pilot program.|
|IT Support Manager|Provides input on the supportability of proposed changes |
|Identity architect |Defines how the change aligns with identity management infrastructure|
|Application business owner |Owns the affected applications, which might include access management. Provides input on the user experience.|
|Security owner|Confirms the change plan meets security requirements|
|Compliance Manager|Ensures compliance with corporate, industry, or governmental requirements|

### RACI

Responsible, Accountable, Consulted, and Informed (responsible/accountable/consulted/informed (RACI)) is a model for the participation by various roles to complete tasks or deliverables for a project or business process. Use this model to help ensure the roles in your organization understand deployment responsibilities.

- **Responsible** - The people accountable for the correct completion of the task.
  - There is at least one Responsible role, although you can delegate others to help deliver the work.
- **Accountable** - The one ultimately answerable for the correctness and completion of the deliverable or task. The Accountable role ensures task prerequisites are met and delegates work to responsible roles. The Accountable role approves work that Responsible provides. Assign one Accountable for each task or deliverable.
- **Consulted** - The Consulted role provides guidance, typically a subject matter expert (SME).
- **Informed** - The people kept up to date on progress, generally upon completion of a task or deliverable.

## Authentication deployment

Use the following list to plan for authentication deployment.

- **Microsoft Entra multifactor authentication (MFA)** - Using admin-approved authentication methods, multifactor authentication helps safeguard access to your data and applications while meeting the demand for easy sign-in:
  - See the video, [How to configure and enforce multifactor authentication in your tenant](https://www.youtube.com/watch?v=qNndxl7gqVM)
  - See, [Plan a multifactor authentication deployment](~/identity/authentication/howto-mfa-getstarted.md)
- **Conditional Access** - Implement automated access-control decisions for users to access cloud apps, based on conditions:
  - See, [What is Conditional Access?](~/identity/conditional-access/overview.md)
  - See, [Plan a Conditional Access deployment](~/identity/conditional-access/plan-conditional-access.md)
- **Microsoft Entra self-service password reset (SSPR)** - Help users reset a password without administrator intervention:
  - See, [Passwordless authentication options for Microsoft Entra ID](~/identity/authentication/concept-authentication-passwordless.md)
    
  - See, [Plan a Microsoft Entra self-service password-reset deployment](~/identity/authentication/concept-sspr-deploy.md)
    
- **Passwordless authentication** - Implement passwordless authentication using the Microsoft Authenticator app or FIDO2 Security keys:
  - See, [Enable passwordless sign-in with Microsoft Authenticator](~/identity/authentication/howto-authentication-passwordless-phone.md)
  - See, [Plan a passwordless authentication deployment in Microsoft Entra ID](~/identity/authentication/howto-authentication-passwordless-deployment.md)

## Applications and devices

Use the following list to help deploy applications and devices.

- **Single sign-on (SSO)** - Enable user access to apps and resources with one sign-in, without reentering credentials:
  - See, [What is SSO in Microsoft Entra ID?](~/identity/enterprise-apps/what-is-single-sign-on.md)
  - See, [Plan a SSO deployment](~/identity/enterprise-apps/plan-sso-deployment.md)
- **My Apps portal** - Discover and access applications. Enable user productivity with self-service, for instance request access to groups, or manage access to resources on behalf of others.
  - See, [My Apps portal overview](~/identity/enterprise-apps/myapps-overview.md)
- **Devices** - Evaluate device integration methods with Microsoft Entra ID, choose the implementation plan, and more.
  - See, [Plan your Microsoft Entra device deployment](~/identity/devices/plan-device-deployment.md)

## Hybrid scenarios

The following list describes features and services in hybrid scenarios.

- **Active Directory Federation Services (AD FS)** - Migrate user authentication from federation to cloud with pass-through authentication or password hash sync:
  - See, [What is federation with Microsoft Entra ID?](~/identity/hybrid/connect/whatis-fed.md)
  - See, [Migrate from federation to cloud authentication](~/identity/hybrid/connect/migrate-from-federation-to-cloud-authentication.md)
- **Microsoft Entra application proxy** - Enable employees to be productive from a device. Learn about software as a service (SaaS) apps in the cloud and corporate apps on-premises. Microsoft Entra application proxy enables access without virtual private networks (VPNs) or demilitarized zones (DMZs):
  - See, [Remote access to on-premises applications through Microsoft Entra application proxy](~/identity/app-proxy/overview-what-is-app-proxy.md)
  - See, [Plan a Microsoft Entra application proxy deployment](~/identity/app-proxy/conceptual-deployment-plan.md)
- **Seamless single sign-on (Seamless SSO)** - Use Seamless SSO for user sign-in, on corporate devices connected to a corporate network. Users don't need passwords to sign in to Microsoft Entra ID, and usually don't need to enter usernames. Authorized users access cloud-based apps without extra on-premises components:
  - See, [Microsoft Entra SSO: Quickstart](~/identity/hybrid/connect/how-to-connect-sso-quick-start.md)
  - See, [Microsoft Entra seamless SSO: Technical deep dive](~/identity/hybrid/connect/how-to-connect-sso-how-it-works.md)

## Users

- **User identities** - Learn about automation to create, maintain, and remove user identities in cloud apps, such as Dropbox, Salesforce, ServiceNow, and more.
  - See, [Plan an automatic user provisioning deployment in Microsoft Entra ID](~/identity/app-provisioning/plan-auto-user-provisioning.md)
- **Microsoft Entra ID Governance** - Create identity governance and enhance business processes that rely on identity data. With HR products, such as Workday or Successfactors, manage employee and contingent-staff identity lifecycle with rules. These rules map Joiner-Mover-Leaver (JLM) processes, such as New Hire, Terminate, Transfer, to IT actions such as Create, Enable, Disable. See the following section for more.
  - See, [Plan cloud HR application to Microsoft Entra user provisioning](~/identity/app-provisioning/plan-cloud-hr-provision.md)
- **Microsoft Entra B2B collaboration** - Improve external-user collaboration with secure access to applications:
  - See, [B2B collaboration overview](~/external-id/what-is-b2b.md)
  - See, [Plan a Microsoft Entra B2B collaboration deployment](secure-external-access-resources.md)

## Identity Governance and reporting

[Microsoft Entra ID Governance](~/id-governance/identity-governance-overview.md) enables organizations to improve productivity, strengthen security and more easily meet compliance and regulatory requirements. Use Microsoft Entra ID Governance to ensure the right people have the right access to the right resources. Improve identity and access process automation, delegation to business groups, and increased visibility. Use the following list to learn about identity governance and reporting.

Learn more:

- [Secure access for a connected world—meet Microsoft Entra](https://www.microsoft.com/en-us/security/blog/?p=114039)
- [Govern access for applications in your environment](~/id-governance/identity-governance-applications-prepare.md)

- **Privileged Identity Management (PIM)** - Manage privileged administrative roles across Microsoft Entra ID, Azure resources, and other Microsoft online services. Use it for just-in-time (JIT) access (JIT), request approval workflows, and integrated access reviews to help prevent malicious activities:
  - See, [Start using Privileged Identity Management](~/id-governance/privileged-identity-management/pim-getting-started.md)
  - See, [Plan a Privileged Identity Management deployment](~/id-governance/privileged-identity-management/pim-deployment-plan.md)
- **Reporting and monitoring** - The Microsoft Entra reporting and monitoring solution design has dependencies and constraints: legal, security, operations, environment, and processes.
  - See, [Microsoft Entra reporting and monitoring deployment dependencies](~/identity/monitoring-health/plan-monitoring-and-reporting.md)
- **Access reviews** - Understand and manage access to resources:
  - See, [What are access reviews?](~/id-governance/access-reviews-overview.md)
  - See, [Plan a Microsoft Entra access reviews deployment](~/id-governance/deploy-access-reviews.md)

## Best practices for a pilot

Before making a change for larger groups, or everyone, use pilots to test with a small group. Ensure each use case in your organization is tested.

### Pilot: Phase 1

In your first phase, target IT, usability, and other users who can test and provide feedback. Use this feedback to gain insights on potential issues for support staff, and to develop communications and instructions you send to all users.

### Pilot: Phase 2

Widen the pilot to larger groups of users by using dynamic membership, or by manually adding users to the targeted groups.

Learn more: [Dynamic membership rules for groups in Microsoft Entra ID](~/identity/users/groups-dynamic-membership.md)
