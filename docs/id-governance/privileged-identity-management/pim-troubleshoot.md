---
title: Troubleshoot resource access denied in Privileged Identity Management
description: Learn how to troubleshoot system errors with roles in Microsoft Entra Privileged Identity Management (PIM).

author: billmath
manager: pmwongera
ms.service: entra-id-governance
ms.topic: troubleshooting
ms.subservice: privileged-identity-management
ms.date: 12/30/2024
ms.author: billmath
ms.reviewer: shaunliu

---

# Troubleshoot access to Azure resources denied in Privileged Identity Management

If you are experiencing issues with Privileged Identity Management (PIM) in Microsoft Entra ID, the information included in this article can help you resolve these issues.

## Access to Azure resources denied

### Problem

As an active owner or user access administrator for an Azure resource, you're able to see your resource inside Privileged Identity Management but can't perform any actions such as making an eligible assignment or viewing a list of role assignments from the resource overview page. Any of these actions results in an authorization error.

### Cause

This issue can occur when the User Access Administrator role for the PIM service principal was accidentally removed from the subscription. For the Privileged Identity Management service to access Azure resources, the MS-PIM service principal should always have the [User Access Administrator role](/azure/role-based-access-control/built-in-roles#user-access-administrator) role assigned.

### Resolution

Assign the User Access Administrator role to the Privileged identity Management service principal name (MS–PIM) at the subscription level. This assignment should allow the Privileged identity Management service to access the Azure resources. The role can be assigned on a management group level or at the subscription level, depending on your requirements. For more information service principals, see [Assign an application to a role](~/identity-platform/howto-create-service-principal-portal.md#assign-a-role-to-the-application).

## Next steps

- [License requirements to use Privileged Identity Management](~/id-governance/licensing-fundamentals.md)
- [Securing privileged access for hybrid and cloud deployments in Microsoft Entra ID](~/identity/role-based-access-control/security-planning.md?toc=/azure/active-directory/privileged-identity-management/toc.json)
- [Deploy Privileged Identity Management](pim-deployment-plan.md)
