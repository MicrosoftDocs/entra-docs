---
title: Microsoft Entra admin center
description: Overview of the Microsoft Entra admin center interface for configuring and managing Microsoft Entra products.
ms.topic: overview
ms.date: 04/06/2026
ai-usage: ai-assisted
ms.custom: sfi-image-nochange
#Customer intent: As a user, I want an overview of the products and features available in the Microsoft Entra admin center and then be able to easily navigate to learn more about those products and features. 
---

# What is the Microsoft Entra admin center?


## Overview

The [Microsoft Entra admin center](https://entra.microsoft.com/) is a web-based portal that provides a unified administrative experience for configuring and managing Microsoft Entra products in a centralized location. From the admin center, administrators can manage users and groups, configure authentication methods, create Conditional Access policies, monitor identity security posture, and govern access across the organization.

The admin center brings together the following Microsoft Entra product areas, each accessible from the left-hand navigation menu:

- **[Entra ID](#entra-id)** — Manage users, groups, devices, applications, roles, and authentication methods.
- **[ID Protection](#id-protection)** — Monitor and respond to identity-based risks with risk policies and reports.
- **[Identity Governance](#identity-governance)** — Control access lifecycle with entitlement management, access reviews, and lifecycle workflows.
- **[Verified ID](#verified-id)** — Issue and manage verifiable credentials.
- **[Global Secure Access](#global-secure-access)** — Secure access to apps and resources with Private Access and Internet Access.

## Explore the Microsoft Entra admin center

The Microsoft Entra admin center is organized by product. Access the products through the search bar or left-hand menu. You can also use the search bar at the top of the page to find specific settings, features, or documentation.

**Home** includes at-a-glance information about your tenant, recent activities, and other helpful resources, including shortcuts and deployment guides. The home page provides quick access to:

- **Tenant overview** — View your tenant name, ID, and license information.
- **Recommended actions** — Personalized [recommendations](~/identity/monitoring-health/overview-recommendations.md) to help improve the security and health of your tenant.
- **Deployment guides** — Step-by-step guidance for deploying Microsoft Entra features.
- **Recent activity** — Quick access to recently visited pages and recent changes.
 
:::image type="content" source="./media/entra-admin-center/entra-admin-center-home.png" alt-text="Screenshot of the Microsoft Entra admin center overview home page.":::

The following sections provide a high-level overview of the product interfaces and links to learn more about the features.

### Entra ID

**Entra ID** gives administrators and developers access to [Microsoft Entra ID](./what-is-entra.md) and [Microsoft Entra External ID](~/external-id/external-identities-overview.md) solutions, including tenants, users, groups, devices, applications, roles, and licensing.

:::image type="content" source="./media/entra-admin-center/entra-admin-identity.png" alt-text="Screenshot of the Microsoft Entra admin center Identity menu.":::

For more information about configuring and managing Microsoft Entra ID solutions, see the following documentation:

* [Users and groups](~/identity/users/directory-overview-user-model.md)
* [Devices](~/identity/devices/overview.md)
* [Enterprise applications](~/identity/enterprise-apps/what-is-application-management.md)
* [App registrations](~/identity-platform/application-model.md)
* [Roles and admins](~/identity/role-based-access-control/custom-overview.md)
* [External identities](~/external-id/external-identities-overview.md)
* [Conditional Access](~/identity/conditional-access/overview.md)
* [Multifactor authentication](~/identity/authentication/concept-mfa-howitworks.md)
* [Identity secure score](~/identity/monitoring-health/concept-identity-secure-score.md)
* [Authentication methods](~/identity/authentication/overview-authentication.md)
* [Password reset](~/identity/authentication/concept-sspr-howitworks.md)
* [Custom security attributes](~/fundamentals/custom-security-attributes-overview.md)

### ID Protection

**ID Protection** gives administrators and developers access to [Microsoft Entra ID Protection](~/id-protection/overview-identity-protection.md) solutions, including the protection dashboard, risk-based access policies, risky users report, multifactor authentication, and password reset.

:::image type="content" source="./media/entra-admin-center/entra-admin-protection.png" alt-text="Screenshot of the Microsoft Entra admin center Protection menu.":::

For more information about configuring and managing Microsoft Entra ID Protection solutions, see the following documentation:

* [Identity Protection dashboard](~/id-protection/id-protection-dashboard.md)
* [Risk-based access policies](~/id-protection/concept-identity-protection-policies.md)
* [Risky users](~/id-protection/howto-identity-protection-investigate-risk.md)
* [Risky workload identities](~/id-protection/concept-workload-identity-risk.md)

### Identity governance

**Identity Governance** gives administrators and developers access to [Microsoft Entra ID Governance](~/id-governance/identity-governance-overview.md) solutions, including entitlement management, access reviews, and lifecycle workflows.

:::image type="content" source="./media/entra-admin-center/entra-admin-identity-governance.png" alt-text="Screenshot of the Microsoft Entra admin center Identity governance menu.":::

For more information about configuring and managing Microsoft Entra ID Governance solutions, see the following documentation:

* [Identity Governance dashboard](~/id-governance/governance-dashboard.md)
* [Entitlement management](~/id-governance/entitlement-management-overview.md)
* [Access reviews](~/id-governance/access-reviews-overview.md)
* [Privileged Identity Management](~/id-governance/privileged-identity-management/pim-configure.md)
* [Lifecycle workflows](~/id-governance/what-are-lifecycle-workflows.md)
* [Custom task extensions for Lifecycle workflows](~/id-governance/lifecycle-workflow-extensibility.md)

### Verified ID

**Verified ID** gives administrators and developers access to [Microsoft Entra Verified ID](~/verified-id/decentralized-identifier-overview.md) solutions, including credentials and organization settings.

:::image type="content" source="./media/entra-admin-center/entra-admin-verified-id.png" alt-text="Screenshot of the Microsoft Entra admin center Verified ID menu.":::

For more information about configuring and managing Microsoft Entra Verified ID solutions, see the following documentation:

* [Credentials](~/verified-id/verifiable-credentials-configure-tenant-quick.md)

### Global Secure Access

**Global Secure Access** gives administrators and developers access to [Microsoft Entra Private Access](~/global-secure-access/overview-what-is-global-secure-access.md#microsoft-entra-private-access) and [Microsoft Entra Internet Access](~/global-secure-access/overview-what-is-global-secure-access.md#microsoft-entra-internet-access) solutions, including the Global Secure Access dashboard, clients, connectors, and monitoring.

:::image type="content" source="./media/entra-admin-center/entra-admin-global-secure-access.png" alt-text="Screenshot of the Microsoft Entra admin center Global Secure Access menu.":::

For more information about configuring and managing Global Secure Access solutions, see the following documentation:

* [Global Secure Access dashboard](~/global-secure-access/concept-traffic-dashboard.md)
* [Global Secure Access client](~/global-secure-access/concept-clients.md)
* [Traffic forwarding](~/global-secure-access/concept-traffic-forwarding.md)
* [Remote networks](~/global-secure-access/concept-remote-network-connectivity.md)
* [Logs and monitoring](~/global-secure-access/concept-global-secure-access-logs-monitoring.md)

## Common admin tasks

The following table lists common administrative tasks you can perform from the Microsoft Entra admin center, with links to detailed guidance for each task.

| Task | Description | Learn more |
|------|-------------|------------|
| Create or delete users | Add new members or guests to your organization, or remove existing users. | [Create or delete users](./how-to-create-delete-users.yml) |
| Manage groups | Create and manage groups to organize users for access management and licensing. | [Manage groups and group membership](./how-to-manage-groups.yml) |
| Assign roles | Delegate administrative responsibilities using built-in or custom roles. | [Overview of role-based access control](~/identity/role-based-access-control/custom-overview.md) |
| Manage applications | Register and configure applications for single sign-on and API access. | [What is application management?](~/identity/enterprise-apps/what-is-application-management.md) |
| Create a Conditional Access policy | Define access controls based on conditions such as user, device, location, and risk. | [What is Conditional Access?](~/identity/conditional-access/overview.md) |
| Review identity secure score | Check your tenant's security posture and follow recommendations to improve it. | [What is Identity Secure Score?](~/identity/monitoring-health/concept-identity-secure-score.md) |
| Set up multifactor authentication | Require users to verify their identity with more than one authentication method. | [How it works: Microsoft Entra multifactor authentication](~/identity/authentication/concept-mfa-howitworks.md) |
| Configure self-service password reset | Allow users to reset their own passwords without contacting an administrator. | [How it works: Microsoft Entra self-service password reset](~/identity/authentication/concept-sspr-howitworks.md) |

## Need help?

**Diagnose & solve problems** provides troubleshooting resources to fix common problems, and the option to contact the support team by opening a **New support request**.

:::image type="content" source="./media/entra-admin-center/entra-admin-diagnose-and-solve.png" alt-text="Screenshot of the Microsoft Entra admin center Diagnose & solve menu.":::

:::image type="content" source="./media/entra-admin-center/entra-admin-learn-and-support.png" alt-text="Screenshot of the Microsoft Entra admin center Learn & support menu.":::


## Related content

* [What is Microsoft Entra?](./what-is-entra.md)
* [Create or delete users](./how-to-create-delete-users.yml)
* [Manage groups and group membership](./how-to-manage-groups.yml)
* [Overview of role-based access control](~/identity/role-based-access-control/custom-overview.md)
* [What is Conditional Access?](~/identity/conditional-access/overview.md)
* [What is Identity Secure Score?](~/identity/monitoring-health/concept-identity-secure-score.md)
* [Manage Microsoft Entra using Microsoft Graph](/graph/api/resources/identity-network-access-overview)
* [Find your tenant](./how-to-find-tenant.md)
* [Create a new tenant](./create-new-tenant.md)
