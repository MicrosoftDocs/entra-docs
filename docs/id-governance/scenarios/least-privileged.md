---
title: 'Understanding least privilege with Microsoft Entra ID Governance'
description: This article describes the concept of least privilege and how it relates with Microsoft Entra ID Governance.
ms.service: entra-id-governance
ms.subservice:

author: billmath
manager: femila


ms.topic: conceptual
ms.date: 04/09/2025
ms.author: billmath
---

# The principle of least privilege with Microsoft Entra ID Governance

One concept that needs to be addressed before under taking an identity governance strategy is the principle of least privilege (POLP). Least privilege is a principle in identity governance that involves assigning users and groups only the minimum level of access and permissions necessary to perform their duties. The idea is to restrict access rights so that a user or group can complete their work, but also minimizing unnecessary privileges that could potentially be exploited by attackers or lead to security breaches.

In regards to Microsoft Entra ID Governance, applying the principle of least privilege helps enhance security and mitigate risks. This approach ensures that users and groups are granted access only to the resources, data, and actions that are relevant to their roles and responsibilities, and nothing beyond that.

## Key concepts of the principle of least privilege

- **Access to only required resources:** Users are given access to information and resources only if they have a genuine need for them to perform their tasks. This prevents unauthorized access to sensitive data and minimizes the potential impact of a security breach. Automating user provisioning helps reduce unnecessary granting of access rights. [Lifecycle workflows](../what-are-lifecycle-workflows.md) is an identity governance feature that enables organizations to manage Microsoft Entra users by automating basic lifecycle processes.

- **Role-Based Access Control (RBAC):** Access rights are determined based on the specific roles or job functions of users. Each role is assigned the minimum permissions necessary to fulfill its responsibilities. [Microsoft Entra role-based access control](../../identity/role-based-access-control/custom-overview.md) manages access to Microsoft Entra resources.

- **Just-In-Time Privilege:** Access rights are granted only for the duration of time that they're needed and are revoked when they're no longer required. This reduces the window of opportunity for attackers to exploit excessive privileges. [Privileged Identity Management (PIM)](../../id-governance/privileged-identity-management/pim-configure.md) is a service in Microsoft Entra ID that enables you to manage, control, and monitor access to important resources in your organization and can provide just-in-time access.

- **Regular Auditing and Review:** Periodic reviews of user access and permissions are conducted to ensure that users still require the access they have been granted. This helps to identify and rectify any deviations from the least privilege principle. [Access reviews in Microsoft Entra ID](../access-reviews-overview.md), part of Microsoft Entra, enable organizations to efficiently manage group memberships, access to enterprise applications, and role assignments. User's access can be reviewed regularly to make sure only the right people have continued access.

- **Default Deny:** The default stance is to deny access, and access is explicitly granted only for approved purposes. This contrasts with a "default allow" approach, which can result in granting unnecessary privileges. [Entitlement management](../entitlement-management-overview.md) is an identity governance feature that enables organizations to manage identity and access lifecycle at scale, by automating access request workflows, access assignments, reviews, and expiration.

By following the principle of least privilege, your organization can reduce the risk of security issues, and ensure that access controls are aligned with business needs.

## Least privileged roles for managing in Identity Governance features

It's a best practice to use the least privileged role to perform administrative tasks in Identity Governance. We recommend that you use Microsoft Entra PIM to activate a role as needed to perform these tasks. The following are the least privileged [directory roles](~/identity/role-based-access-control/permissions-reference.md) to configure Identity Governance features:

| Feature | Least privileged role |
| ------- | --------------------- |
| Entitlement management | Identity Governance Administrator |
| Access reviews | User Administrator (with the exception of access reviews of Azure or Microsoft Entra roles, which require Privileged Role Administrator) |
| Lifecycle Workflows | Lifecycle Workflows Administrator |
| Privileged Identity Management | Privileged Role Administrator |
| Terms of use | Security Administrator or Conditional Access Administrator |

>[!NOTE]
>The least privileged role for Entitlement management has changed from the User Administrator role to the Identity Governance Administrator role.


