---
title: What is Microsoft Entra?
description: Introduction to the Microsoft Entra product family including links to get started.
author: barclayn
manager: pmwongera
ms.service: entra
ms.subservice: fundamentals
ms.topic: overview
ms.date: 08/15/2025
ms.author: barclayn

# Customer intent: As a new customer, I want an overview of all Microsoft Entra products including links to get started.
---
# What is Microsoft Entra?

Microsoft Entra is a family of identity and network access products. It enables organizations to implement a [Zero Trust](/security/zero-trust/zero-trust-overview) security strategy and create a [trust fabric](https://www.microsoft.com/security/blog/2024/05/08/how-implementing-a-trust-fabric-strengthens-identity-and-network/) that verifies identities, validates access conditions, checks permissions, encrypts connection channels, and monitors for compromise.

## Microsoft Entra product family

The Microsoft Entra product family covers four maturity stages of secure end-to-end access for any trustworthy identity. These stages include establishing Zero Trust access controls, and securing access for employees, customers, partners, and any cloud environment.

:::image type="content" source="./media/what-is-entra/entra-product-family.png" alt-text="Diagram of Microsoft Entra products across four maturity stages.":::

### Establish Zero Trust access controls

#### Microsoft Entra ID

[Microsoft Entra ID](./whatis.md) is the foundational product of Microsoft Entra. It is a cloud-based identity and access management service that provides the essential identity, authentication, policy, and protection to secure users, devices, apps, and resources. Every new Microsoft Entra directory comes with an initial domain name, like `contoso.onmicrosoft.com`. In addition to that initial name, you can also add your organization's domain names.

**Microsoft 365, Azure, or Dynamics CRM Online subscribers** already use Microsoft Entra ID as every Microsoft 365, Office 365, Azure, and Dynamics CRM Online tenant is automatically a Microsoft Entra tenant. You can immediately start managing access to your integrated cloud apps.

#### Microsoft Entra Domain Services

[Microsoft Entra Domain Services](~/identity/domain-services/overview.md) provides managed domain services such as group policy, lightweight directory access protocol (LDAP), and Kerberos/NTLM authentication. It enables organizations to run legacy applications in the cloud that can't use modern authentication methods.

**For example**, organizations with services that require access to Kerberos authentication can create a managed domain where the core service components are deployed and maintained by Microsoft. 

### Secure access for employees

#### Microsoft Entra Private Access

[Microsoft Entra Private Access](~/global-secure-access/overview-what-is-global-secure-access.md#microsoft-entra-private-access) secures access to all private apps and resources, including corporate networks and multicloud environments. It enables remote users to connect to internal resources from any device and network without a virtual private network (VPN).

**For example**, an employee can securely access a corporate network printer while working from home or even a cafe.

#### Microsoft Entra Internet Access

[Microsoft Entra Internet Access](~/global-secure-access/overview-what-is-global-secure-access.md#microsoft-entra-internet-access) secures access to all internet resources including software as a service (SaaS) apps, and Microsoft 365 apps and resources. It enables organizations to continuously monitor and adjust user access in real time if permissions or risk levels change.

**For example**, organizations can enable web content filtering to regulate access to websites based on content categories and domain names.

#### Microsoft Entra ID Governance

[Microsoft Entra ID Governance](~/id-governance/identity-governance-overview.md) makes identity and permissions easier to manage by automating access requests, assignments, and reviews. Additionally, it helps protect critical assets through identity lifecycle management.

**For example**, administrators can automatically assign user accounts, groups, and licenses to new employees, and remove those assignments from employees that are no longer with the company.

#### Microsoft Entra ID Protection

[Microsoft Entra ID Protection](~/id-protection/overview-identity-protection.md) detects and reports identity-based risks. It enables administrators to investigate and automatically remediate risks using tools like [risk-based Conditional Access policies](../id-protection/concept-identity-protection-policies.md).

**For example**, organizations can create risk-based Conditional Access policies that require multifactor authentication when the sign-in risk level is reported as medium or high.

#### Microsoft Entra Verified ID

In addition to identities that are used for authentication, there are decentralized identities (DIDs) used for information verification.

[Microsoft Entra Verified ID](~/verified-id/decentralized-identifier-overview.md) is a credential verification service based on open [DID standards](~/verified-id/verifiable-credentials-standards.md). It enables organizations to issue a verifiable credential (digital signature proving the validity of information) to a user who stores the credential on their personal device. After they receive the verifiable credential, the user can present it to a company or organization that wants to verify something about their identity.

**For example**, a recent college graduate can ask the university to issue a digital copy of their diploma to their DID. They can then choose to present the diploma to a potential employer who can independently verify the issuer of the diploma, the time of issuance, and its status.

### Secure access for customers and partners

#### Microsoft Entra External ID

[Microsoft Entra External ID](~/external-id/external-identities-overview.md) enables external identities to safely access business resources and consumer apps. It offers secure methods for collaborating with business partners and guests on internal apps and resources, as well as managing customer identity and access management (CIAM) for your consumer-facing applications.

**For example**, organizations can set up self-service registration for customers to sign-in to a web application using methods such as one-time passcodes, or social accounts from Google or Facebook.

### Secure access in any cloud

#### Microsoft Entra Workload ID

In addition to human and device identities, workload identities such as applications, services, and containers require authentication and authorization policies. 

[Microsoft Entra Workload ID](~/workload-id/workload-identities-overview.md) is the identity and access management solution for workload identities. It enables organizations to secure access to resources using adaptive policies and custom security attributes for apps.

**For example**, GitHub Actions need a workload identity to access Azure subscriptions to automate, customize, and execute software development workflows.

## Getting ready for Microsoft Entra

Before organizations deploy Microsoft Entra, they should configure their infrastructure and processes according to security best practices and standards. The following articles provide the architectural, deployment, and operational guidance to successfully integrate Microsoft Entra.

* [Architecture](~/architecture/architecture.md)
* [Deployment plans](~/architecture/deployment-plans.md)
* [Operations reference](~/architecture/ops-guide-intro.md)
* [Operations guide](~/architecture/security-operations-introduction.md)

## Licensing Microsoft Entra features

The features of Microsoft Entra are licensed in multiple ways. These licenses include Microsoft Entra ID Free, Microsoft Entra ID P1, Microsoft Entra ID P2, Microsoft Entra Suite, Microsoft Entra External ID, Microsoft Entra Workload ID, Microsoft Entra ID Governance, and other standalone products. For more information about licensing and available options, see the article [Microsoft Entra licensing](licensing.md) or the [Microsoft Entra pricing page](https://www.microsoft.com/security/business/microsoft-entra-pricing).

## Working with Microsoft Entra

After organizations deploy Microsoft Entra, administrators can use the **Microsoft Entra admin center** and **Microsoft Graph API** to manage the identity and network access resources, and developers can use the **Microsoft identity platform** to build identity and access applications. 

### Microsoft Entra admin center

The [Microsoft Entra admin center](https://entra.microsoft.com/) is a web-based portal for administrators to configure and manage Microsoft Entra products using a single user interface.

To learn more, see [Overview of Microsoft Entra admin center](./entra-admin-center.md).

### Microsoft Graph API

In addition to the Microsoft Entra admin center, the [Microsoft Graph API](/graph/api/overview) can be used to automate administrative tasks, including license deployments, and user lifecycle management.

To learn more, see [Manage Microsoft Entra using Microsoft Graph](/graph/api/resources/identity-network-access-overview).

### Microsoft identity platform

The [Microsoft identity platform](~/identity-platform/v2-overview.md) enables developers to build authentication experiences for web, desktop, and mobile applications using open-source libraries and standard-compliant authentication services.

To start developing, see [Getting started](~/identity-platform/v2-overview.md#getting-started).

## Related content

- Sign up for a [free 30-day Microsoft Entra ID P1 or P2 trial](https://azure.microsoft.com/trial/get-started-active-directory/).
- Learn the differences between Active Directory and Microsoft Entra ID, see [Compare Active Directory to Microsoft Entra ID](compare.md).
- Learn how to get started with [Microsoft Entra ID for developers](~/identity-platform/index.yml).
