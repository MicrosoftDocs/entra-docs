---
title: What is Microsoft Entra?
description: Introduction to the Microsoft Entra product family including links to get started.
ai-usage: ai-assisted
ms.topic: overview
ms.date: 04/08/2026
# Customer intent: As a new customer, I want an overview of all Microsoft Entra products including links to get started.
#Customer Intent: As an IT admin, I want to understand what Microsoft Entra is so that I can evaluate its identity and access management capabilities for my organization.
---
# What is Microsoft Entra?

Microsoft Entra is a family of identity and network access products that helps organizations implement a [Zero Trust](/security/zero-trust/zero-trust-overview) security strategy. Use Microsoft Entra to verify identities, validate access conditions, check permissions, encrypt connection channels, and monitor for compromise across your environment.

## Microsoft Entra product family

The Microsoft Entra product family spans identity, access, governance, and security. It covers secure end-to-end access for employees, customers, partners, and workloads across any cloud environment.

:::image type="content" source="./media/what-is-entra/entra-product-family.png" alt-text="Diagram of Microsoft Entra products across four maturity stages.":::

### Establish Zero Trust access controls

#### Microsoft Entra ID

[Microsoft Entra ID](./what-is-entra.md) is the foundational product of Microsoft Entra. It's a cloud-based identity and access management service that provides authentication, policy enforcement, and protection for users, devices, apps, and resources. Every new Microsoft Entra directory includes an initial domain name, like `contoso.onmicrosoft.com`. You can also add your organization's custom domain names.

If you're a **Microsoft 365, Azure, or Dynamics CRM Online subscriber**, you're already using Microsoft Entra ID — every tenant is automatically a Microsoft Entra tenant. You can start managing access to your integrated cloud apps right away.

#### Microsoft Entra Domain Services

[Microsoft Entra Domain Services](~/identity/domain-services/overview.md) provides managed domain services like group policy, LDAP, and Kerberos/NTLM authentication. It's designed for legacy applications in the cloud that can't use modern authentication methods.

> **Scenario:** An organization with services that need Kerberos authentication can create a managed domain where Microsoft deploys and maintains the core service components.

### Secure access for employees

#### Microsoft Entra Private Access

[Microsoft Entra Private Access](~/global-secure-access/overview-what-is-global-secure-access.md#microsoft-entra-private-access) secures access to all private apps and resources, including corporate networks and multicloud environments. Remote users can connect to internal resources from any device and network without a VPN.

**For example**, an employee can securely access a corporate network printer while working from home or a cafe.

#### Microsoft Entra Internet Access

[Microsoft Entra Internet Access](~/global-secure-access/overview-what-is-global-secure-access.md#microsoft-entra-internet-access) secures access to all internet resources, including SaaS apps and Microsoft 365 apps and resources.

> **Scenario:** Enable web content filtering to regulate access to websites based on content categories and domain names.

#### Microsoft Entra ID Governance

[Microsoft Entra ID Governance](~/id-governance/identity-governance-overview.md) simplifies identity and permissions management by automating access requests, assignments, and reviews. It also helps protect critical assets through identity lifecycle management.

**For example**, administrators can automatically assign user accounts, groups, and licenses to new employees and remove those assignments when employees leave the company.

#### Microsoft Entra ID Protection

[Microsoft Entra ID Protection](~/id-protection/overview-identity-protection.md) detects and reports identity-based risks. Administrators can investigate and automatically remediate risks using tools like [risk-based Conditional Access policies](../id-protection/concept-identity-protection-policies.md).

> **Scenario:** Create risk-based Conditional Access policies that require multifactor authentication when the sign-in risk level is medium or high.

#### Microsoft Entra Verified ID

[Microsoft Entra Verified ID](~/verified-id/decentralized-identifier-overview.md) is a credential verification service based on open [decentralized identity (DID) standards](~/verified-id/verifiable-credentials-standards.md). Organizations can issue verifiable credentials — digital signatures that prove the validity of information — to users, who store the credentials on their personal devices and present them when needed.

**For example**, a recent college graduate can ask the university to issue a digital diploma to their DID, then present it to a potential employer who can independently verify the issuer, issuance time, and status.

### Secure access for customers and partners

#### Microsoft Entra External ID

[Microsoft Entra External ID](~/external-id/external-identities-overview.md) lets external identities safely access business resources and consumer apps. It provides secure methods for collaborating with business partners and guests on internal apps, and for managing customer identity and access management (CIAM) in consumer-facing applications.

> **Scenario:** Set up self-service registration for customers to sign in to a web application using one-time passcodes or social accounts from Google or Facebook.

### Secure access in any cloud

#### Microsoft Entra Workload ID

[Microsoft Entra Workload ID](~/workload-id/workload-identities-overview.md) is the identity and access management solution for workload identities — applications, services, and containers that require authentication and authorization policies. It lets organizations secure access to resources using adaptive policies and custom security attributes.

**For example**, GitHub Actions need a workload identity to access Azure subscriptions to automate, customize, and execute software development workflows.

## Prepare your environment

Before deploying Microsoft Entra, configure your infrastructure and processes according to security best practices and standards. The following articles provide architectural, deployment, and operational guidance:

- [Architecture](~/architecture/architecture.md)
- [Deployment plans](~/architecture/deployment-plans.md)
- [Operations reference](~/architecture/ops-guide-intro.md)
- [Operations guide](~/architecture/security-operations-introduction.md)
- [Recommended security configurations](configure-security.md)

### License Microsoft Entra features

The features of Microsoft Entra are licensed in multiple ways. These licenses include Microsoft Entra ID Free, Microsoft Entra ID P1, Microsoft Entra ID P2, Microsoft Entra Suite, Microsoft Entra External ID, Microsoft Entra Workload ID, Microsoft Entra ID Governance, and other standalone products. Microsoft Entra is also part of licenses like [Microsoft 365](https://www.microsoft.com/microsoft-365/enterprise/microsoft365-plans-and-pricing) and [Enterprise Mobility + Security](https://www.microsoft.com/microsoft-365/enterprise-mobility-security/compare-plans-and-pricing). For more information about licensing and available options, see the article [Microsoft Entra licensing](licensing.md) or the [Microsoft Entra pricing page](https://www.microsoft.com/security/business/microsoft-entra-pricing).

## Manage and develop with Microsoft Entra

Administrators can use the [Microsoft Entra admin center](#microsoft-entra-admin-center) and [Microsoft Graph API](#microsoft-graph-api) to manage identity and network access resources. Developers can use the [Microsoft identity platform](#microsoft-identity-platform) to build identity-aware applications.

### Microsoft Entra admin center

The [Microsoft Entra admin center](https://entra.microsoft.com/) is a web-based portal for configuring and managing Microsoft Entra products from a single interface.

To learn more, see [Overview of Microsoft Entra admin center](./entra-admin-center.md).

### Microsoft Graph API

The [Microsoft Graph API](/graph/api/overview) automates administrative tasks like license deployments and user lifecycle management.

To learn more, see [Manage Microsoft Entra using Microsoft Graph](/graph/api/resources/identity-network-access-overview).

### Microsoft identity platform

The [Microsoft identity platform](~/identity-platform/v2-overview.md) enables developers to build authentication experiences for web, desktop, and mobile applications using open-source libraries and standard-compliant authentication services.

To start developing, see [Getting started](~/identity-platform/v2-overview.md#getting-started).

## Next steps

- [Microsoft Entra licensing](licensing.md) — Detailed licensing information for all Microsoft Entra products.
- [Identity and access fundamentals](identity-fundamental-concepts.md) — Understand core identity concepts.
- Sign up for a [free 30-day Microsoft Entra ID P1 or P2 trial](https://azure.microsoft.com/trial/get-started-active-directory/).
- [Compare Active Directory and Microsoft Entra ID](compare.md).
- Get started with [Microsoft Entra ID for developers](~/identity-platform/index.yml).
- Find definitions in the [Microsoft identity platform glossary](/entra/identity-platform/developer-glossary#tenant).
