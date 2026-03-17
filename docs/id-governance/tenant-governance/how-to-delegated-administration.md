---
title: Use cross-tenant delegated administration (preview)
description: Learn how to use cross-tenant delegated administration to sign in to and manage governed tenants using your governing tenant credentials
author: barclayn
ms.author: barclayn
ms.service: entra-id-governance
ms.topic: how-to
ms.date: 03/10/2026
---

# Use cross-tenant delegated administration (preview)

[!INCLUDE [entra-tenant-governance-preview-note](~/includes/entra-tenant-governance-preview-note.md)]

This article describes how to sign in to a governed tenant as a delegated administrator and manage delegated administration roles.

Cross-tenant delegated administration enables administrators in a governing tenant to sign in to and manage governed tenants using their governing tenant credentials. This capability doesn't require a local or B2B account in each governed tenant. It uses granular delegated admin privileges (GDAP) technology to provide centralized, least-privileged, cross-tenant access.

## Prerequisites

- An active governance relationship between the governing tenant and the governed tenant, with delegated administration configured in the governance policy template. For more information, see [GDAP supported workloads](/partner-center/customers/gdap-supported-workloads).

- The administrator must belong to a security group in the governing tenant that the governance relationship specifies.

## Sign in to a governed tenant as a delegated administrator

After the governance relationship is active and GDAP role assignments are in place, members of the configured security group can sign in to the governed tenant.

1. Confirm that your account is a member of a security group in the governing tenant that is assigned roles in the governance policy template.

1. Open a supported admin portal URL and append the domain or tenant ID of the governed tenant. For a list of supported portals and workloads, see [GDAP supported workloads](/partner-center/customers/gdap-supported-workloads). For example:

   `https://entra.microsoft.com/{governed-tenant-domain-or-id}`

1. Sign in with your governing tenant credentials.

1. After successful sign-in, perform administrative tasks in the governed tenant based on the roles assigned to your security group.

   > [!IMPORTANT]
   > Due to privacy requirements, your user information appears different from a regular user:
   > - Your display name appears as `user_{your user object ID in the governing tenant without dashes}`.
   > - Sign-in logs and audit logs in the governed tenant show your display name as `{Governing tenant name} Technician`.

## Update delegated administration roles

To add or change the roles available to delegated administrators, update the governance policy template and send a new governance request.

1. In the governing tenant, update the governance policy template to add or modify the Microsoft Entra built-in roles and security group assignments.

   > [!NOTE]
   > Updating the template increments its version number by one.

1. Send a new governance request to the governed tenant using the updated policy template.

1. An administrator in the governed tenant reviews and accepts the request to apply the updated roles.

## Related content

- [Monitor governing tenant admin activity](how-to-monitor-governing-activity.md)
- [Set up a governance relationship](how-to-setup-governance-relationship.md)
- [Governance policy templates](governance-policy-templates.md)
- [Terminate a governance relationship](how-to-terminate-governance-relationship.md)
