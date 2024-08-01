---
title: What is Microsoft Entra ID?
description: Learn about Microsoft Entra ID, including terminology, available licenses, and a list of associated features.
author: barclayn
manager: amycolannino

ms.service: entra
ms.subservice: fundamentals
ms.topic: overview
ms.date: 03/29/2024
ms.author: barclayn
ms.custom: it-pro
ms.collection: M365-identity-device-management
# Customer intent: As a new administrator, I want to understand what Microsoft Entra ID is, which license is right for me, and what features are available.
---

# What is Microsoft Entra ID?

Microsoft Entra ID is a cloud-based identity and access management service that your employees can use to access external resources. Example resources include Microsoft 365, the Azure portal, and thousands of other SaaS applications. 

Microsoft Entra ID also helps them access internal resources like apps on your corporate intranet, and any cloud apps developed for your own organization. To learn how to create a tenant, see [Quickstart: Create a new tenant in Microsoft Entra ID](./create-new-tenant.md).

To learn the differences between Active Directory and Microsoft Entra ID, see [Compare Active Directory to Microsoft Entra ID](compare.md). You can also refer to [Microsoft Cloud for Enterprise Architects Series](/microsoft-365/solutions/cloud-architecture-models) posters to better understand the core identity services in Azure like Microsoft Entra ID and Microsoft-365.

<a name='who-uses-azure-ad'></a>

## Who uses Microsoft Entra ID?

Microsoft Entra ID provides different benefits to members of your organization based on their role:

- **IT admins** use Microsoft Entra ID to control access to apps and app resources, based on business requirements. For example, as an IT admin, you can use Microsoft Entra ID to require multifactor authentication when accessing important organizational resources. You could also use Microsoft Entra ID to automate user provisioning between your existing Windows Server AD and your cloud apps, including Microsoft 365. Finally, Microsoft Entra ID gives you powerful tools to automatically help protect user identities and credentials and to meet your access governance requirements. To get started, sign up for a [free 30-day Microsoft Entra ID P1 or P2 trial](https://azure.microsoft.com/trial/get-started-active-directory/).

- **App developers** can use Microsoft Entra ID as a standards-based authentication provider that helps them add single sign-on (SSO) to apps that works with a user's existing credentials. Developers can also use Microsoft Entra APIs to build personalized experiences using organizational data. To get started, sign up for a [free 30-day Microsoft Entra ID P1 or P2 trial](https://azure.microsoft.com/trial/get-started-active-directory/). For more information, you can also see [Microsoft Entra ID for developers](~/identity-platform/index.yml).

- **Microsoft 365, Office 365, Azure, or Dynamics CRM Online subscribers** already use Microsoft Entra ID as every Microsoft 365, Office 365, Azure, and Dynamics CRM Online tenant is automatically a Microsoft Entra tenant. You can immediately start managing access to your integrated cloud apps.

<a name='what-are-the-azure-ad-licenses'></a>

## What are the Microsoft Entra ID licenses?

Microsoft Online business services, such as Microsoft 365 or Microsoft Azure, use Microsoft Entra ID for sign-in activities and to help protect your identities. If you subscribe to any Microsoft Online business service, you automatically get access to [Microsoft Entra ID Free](https://www.microsoft.com/security/business/identity-access/azure-active-directory-pricing).

To enhance your Microsoft Entra implementation, you can also add paid features by upgrading to Microsoft Entra ID P1 or P2 licenses, or adding on licenses for products such as Microsoft Entra ID Governance. You can also license Microsoft Entra paid licenses are built on top of your existing free directory. The licenses provide self-service, enhanced monitoring, security reporting, and secure access for your mobile users.

>[!Note]
>For the pricing options of these licenses, see [Microsoft Entra pricing](https://www.microsoft.com/security/business/identity-access-management/azure-ad-pricing).
>
>For more information about Microsoft Entra pricing, contact the [Microsoft Entra Forum](https://azure.microsoft.com/support/community/?product=active-directory).

- **Microsoft Entra ID Free.** Provides user and group management, on-premises directory synchronization, basic reports, self-service password change for cloud users, and single sign-on across Azure, Microsoft 365, and many popular SaaS apps.

- **Microsoft Entra ID P1.** In addition to the Free features, P1 also lets your hybrid users access both on-premises and cloud resources. It also supports advanced administration, such as dynamic groups, self-service group management, Microsoft Identity Manager, and cloud write-back capabilities, which allow self-service password reset for your on-premises users.

- **Microsoft Entra ID P2.** In addition to the Free and P1 features, P2 also offers [Microsoft Entra ID Protection](~/id-protection/overview-identity-protection.md) to help provide risk-based Conditional Access to your apps and critical company data and [Privileged Identity Management](~/id-governance/privileged-identity-management/pim-getting-started.md) to help discover, restrict, and monitor administrators and their access to resources and to provide just-in-time access when needed.

In addition to Microsoft Entra ID licenses, you can enable additional identity management capabilities with licenses for other Microsoft Entra products, including:

- **Microsoft Entra ID Governance.** [Microsoft Entra ID Governance](~/id-governance/identity-governance-overview.md) is an advanced set of [identity governance capabilities](~/id-governance/licensing-fundamentals.md) for Microsoft Entra ID P1 and P2 customers.

- **Microsoft Entra Permissions Management.** [Microsoft Entra Permissions Management](/entra/permissions-management/) is a cloud infrastructure entitlement management (CIEM) solution that provides comprehensive visibility into permissions assigned to all identities (users and workloads), actions, and resources across cloud infrastructures Microsoft Azure, Amazon Web Services (AWS), and Google Cloud Platform (GCP).

- **"Pay as you go" feature licenses.** You can also get licenses for features such as Microsoft Entra Domain Services, and Microsoft Entra Business-to-Customer (B2C). B2C can help you provide identity and access management solutions for your customer-facing apps. For more information, see [Azure Active Directory B2C documentation](/azure/active-directory-b2c/).

For more information on the Microsoft Entra product family, see [Microsoft Entra](https://www.microsoft.com/security/business/microsoft-entra).

For more information about associating an Azure subscription to Microsoft Entra ID, see [Associate or add an Azure subscription to Microsoft Entra ID](./how-subscriptions-associated-directory.yml). For more information about assigning licenses to your users, see [How to: Assign or remove Microsoft Entra ID licenses](license-users-groups.yml).

<a name='which-features-work-in-azure-ad'></a>

## Which features work in Microsoft Entra ID?

After you choose your Microsoft Entra ID license, you'll get access to some or all of the following features:

|Category|Description|
|-------|-----------|
|Application management|Manage your cloud and on-premises apps using Application Proxy, single sign-on, the My Apps portal, and Software as a Service (SaaS) apps. For more information, see [How to provide secure remote access to on-premises applications](/entra/identity/app-proxy) and [Application Management documentation](~/identity/enterprise-apps/index.yml).|
|Authentication|Manage Microsoft Entra self-service password reset, Multifactor Authentication, custom banned password list, and smart lockout. For more information, see [Microsoft Entra authentication documentation](~/identity/authentication/index.yml).|
|Microsoft Entra ID for developers|Build apps that sign in all Microsoft identities, get tokens to call Microsoft Graph, other Microsoft APIs, or custom APIs. For more information, see [Microsoft identity platform (Microsoft Entra ID for developers)](~/identity-platform/index.yml).|
|Business-to-Business (B2B)|Manage your guest users and external partners, while maintaining control over your own corporate data. For more information, see [Microsoft Entra B2B documentation](~/external-id/index.yml).|
|Business-to-Customer (B2C)|Customize and control how users sign up, sign in, and manage their profiles when using your apps. For more information, see [Azure Active Directory B2C documentation](/azure/active-directory-b2c/).|
|Conditional Access|Manage access to your cloud apps. For more information, see [Microsoft Entra Conditional Access documentation](~/identity/conditional-access/index.yml).|
|Device Management|Manage how your cloud or on-premises devices access your corporate data. For more information, see [Microsoft Entra Device Management documentation](~/identity/devices/index.yml).|
|Domain services|Join Azure virtual machines to a domain without using domain controllers. For more information, see [Microsoft Entra Domain Services documentation](~/identity/domain-services/index.yml).|
|Enterprise users|Manage license assignments, access to apps, and set up delegates using groups and administrator roles. For more information, see [Microsoft Entra user management documentation](~/identity/users/index.yml).|
|Hybrid identity|Use Microsoft Entra Connect and Connect Health to provide a single user identity for authentication and authorization to all resources, regardless of location (cloud or on-premises). For more information, see [Hybrid identity documentation](~/identity/hybrid/index.yml).|
|Identity governance|Microsoft Entra ID P2 includes basic capabilities for privileged identity management (PIM), access reviews and entitlement management. Microsoft Entra ID Governance customers can manage their organization's identities and access through comprehensive employee, business partner, vendor, service, and app controls. For more information, see [Microsoft Entra ID Governance documentation](~/id-governance/identity-governance-overview.md) and [features by license](~/id-governance/licensing-fundamentals.md#features-by-license).|
|Identity protection|Detect potential vulnerabilities affecting your organization's identities, configure policies to respond to suspicious actions, and then take appropriate action to resolve them. For more information, see [Microsoft Entra ID Protection](~/id-protection/index.yml).|
|Managed identities for Azure resources|Provide your Azure services with an automatically managed identity in Microsoft Entra ID that can authenticate any Microsoft Entra-supported authentication service, including Key Vault. For more information, see [What is managed identities for Azure resources?](~/identity/managed-identities-azure-resources/overview.md).|
|Privileged identity management (PIM)|Manage, control, and monitor access within your organization. This feature includes access to resources in Microsoft Entra ID and Azure, and other Microsoft Online Services, like Microsoft 365 or Intune. For more information, see [Microsoft Entra Privileged Identity Management](~/id-governance/privileged-identity-management/index.yml).|
|Monitoring and health|Gain insights into the security and usage patterns in your environment. For more information, see [Microsoft Entra monitoring and health](~/identity/monitoring-health/index.yml).|
| Workload identities| Give an identity to your software workload (such as an application, service, script, or container) to authenticate and access other services and resources. For more information, see [workload identities faqs](~/workload-id/workload-identities-faqs.md).

## Terminology

To better understand Microsoft Entra ID and its documentation, we recommend reviewing the following terms.

|Term or concept|Description|
|---------------|-----------|
|Identity| A thing that can get authenticated. An identity can be a user with a username and password. Identities also include applications or other servers that might require authentication through secret keys or certificates.|
|Account| An identity that has data associated with it. You can’t have an account without an identity.|
|Microsoft Entra account| An identity created through Microsoft Entra ID or another Microsoft cloud service, such as Microsoft 365. Identities are stored in Microsoft Entra ID and accessible to your organization's cloud service subscriptions. This account is also sometimes called a Work or school account.|
|Account Administrator|This classic subscription administrator role is conceptually the billing owner of a subscription. This role enables you to manage all subscriptions in an account. For more information, see [Azure roles, Microsoft Entra roles, and classic subscription administrator roles](/azure/role-based-access-control/rbac-and-directory-admin-roles).|
|Service Administrator|This classic subscription administrator role enables you to manage all Azure resources, including access. This role has the equivalent access of a user who is assigned the Owner role at the subscription scope. For more information, see [Azure roles, Microsoft Entra roles, and classic subscription administrator roles](/azure/role-based-access-control/rbac-and-directory-admin-roles).|
|Owner|This role helps you manage all Azure resources, including access. This role is built on a newer authorization system called Azure role-based access control (Azure RBAC) that provides fine-grained access management to Azure resources. For more information, see [Azure roles, Microsoft Entra roles, and classic subscription administrator roles](/azure/role-based-access-control/rbac-and-directory-admin-roles).|
|Microsoft Entra Global Administrator|This administrator role is automatically assigned to whomever created the Microsoft Entra tenant. You can have multiple Global Administrators, but anyone with at least [Privileged Role Administrator](../identity/role-based-access-control/permissions-reference.md#privileged-role-administrator) can assign administrator roles to users. For more information about the various administrator roles, see [Administrator role permissions in Microsoft Entra ID](~/identity/role-based-access-control/permissions-reference.md).|
|Azure subscription| Used to pay for Azure cloud services. You can have many subscriptions and they're linked to a credit card.|
|Tenant| A dedicated and trusted instance of Microsoft Entra ID. The tenant is automatically created when your organization signs up for a Microsoft cloud service subscription. These subscriptions include Microsoft Azure, Microsoft Intune, or Microsoft 365. This tenant represents a single organization and is intended for managing your employees, business apps, and other internal resources. For this reason, it's considered a workforce tenant configuration. By contrast, you can create a tenant in an *external* configuration, which is used in customer identity and access management (CIAM) solutions for your consumer-facing apps (learn more about [Microsoft Entra External ID](~/external-id/customers/overview-customers-ciam.md)).|
|Single tenant| Azure tenants that access other services in a dedicated environment are considered single tenant.|
|Multitenant| Azure tenants that access other services in a shared environment, across multiple organizations, are considered multitenant.|
|Microsoft Entra directory|Each Azure tenant has a dedicated and trusted Microsoft Entra directory. The Microsoft Entra directory includes the tenant's users, groups, and apps and is used to perform identity and access management functions for tenant resources.|
|Custom domain|Every new Microsoft Entra directory comes with an initial domain name, for example `domainname.onmicrosoft.com`. In addition to that initial name, you can also add your organization's domain names. Your organization's domain names include the names you use to do business and your users use to access your organization's resources, to the list. Adding custom domain names helps you to create user names that are familiar to your users, such as alain@contoso.com.|
|Microsoft account (also called, MSA)|Personal accounts that provide access to your consumer-oriented Microsoft products and cloud services. These products and services include Outlook, OneDrive, Xbox LIVE, or Microsoft 365. Your Microsoft account is created and stored in the Microsoft consumer identity account system that's run by Microsoft.|

## Next steps

- [Sign up for Microsoft Entra ID P1 or P2](./get-started-premium.md)

- [Associate an Azure subscription to your Microsoft Entra ID](./how-subscriptions-associated-directory.yml)

- [Microsoft Entra ID P2 feature deployment checklist](./concept-secure-remote-workers.md)
