---
title: Set up a governance relationship
description: Learn how to set up a governance relationship between tenants in Microsoft Entra tenant governance.
author: barclayn
ms.author: barclayn
ms.service: entra-id-governance
ms.topic: how-to
ms.date: 03/10/2026
---

<!-- source: How to set up a governance relationship.docx -->

# Set up a governance relationship

Governance relationships enable centralized, cross-tenant administration and multi-tenant application management. A governance relationship is a directional relationship between two tenants: one tenant acts as the *governing tenant*, and the other acts as the *governed tenant*.

You can establish a governance relationship between any two Microsoft Entra tenants using the three-step handshake process, and two-step handshake if tenants meet certain criteria. This article walks you through both options.

## Prerequisites
- Review role requirements in [Tenant governance roles](https://aka.ms/TenantGovernance/Roles).

- Review license requirements for sending governance requests in [Tenant governance licensing](https://aka.ms/TenantGovernance/Licensing).

- A governance policy template must be created in the governing tenant before initiating the handshake process.

- If you're using the three-step handshake, governance invitations must be enabled in the governing tenant.

## Create a governance policy template
Before you can set up a governance relationship, you must create a governance policy template in the governing tenant. The policy template defines the type of relationship and the level of access the governing tenant has over the governed tenant. Templates can be reused across distinct relationships.

1. Sign in to the governing tenant as an administrator.

1. Navigate to Templates.

1. Create a new policy template and configure the following options as needed:

   - **Delegated administration**: Select one or more Microsoft Entra built-in roles and assign them to a role assignable security group in the governing tenant. Members of this group can use their governing tenant credentials to sign in to the governed tenant without needing an account in the governed tenant. Each group can have multiple role assignments, and each policy template can have multiple groups defined.

   - **Multi-tenant application management**: Select a custom, multi-tenant application. A service principal with the same permissions is created in the governed tenant when the relationship is established.

## Set up a governance relationship using a three-step handshake
Use the three-step handshake when there is no pre-existing billing signal or active relationship between the two tenants.

### Step 1: Enable governance invitations in the governing tenant
An administrator in the governing tenant must enable governance invitations to receive invitations from other tenants. By default, this tenant-level setting is disabled.

1. Sign in to the governing tenant as an administrator.

1. Navigate to the tenant governance settings.

1. Enable the invitations setting to allow governance invitations. We recommend that you disable this setting after you have received the invitation.

### Step 2: Send a governance invitation from the governed tenant
1. Sign in to the future governed tenant as an administrator.

1. Navigate to Governing tenants > Sent invitations.

1. Send a governance invitation to the future governing tenant. The future governing tenant receives an email notification that an invitation has been received.

> [!NOTE]

> Governance invitations are valid for 30 days.

### Step 3: Send a governance request from the governing tenant
1. Sign in to the governing tenant as an administrator.

1. Navigate to Governed tenants > Received invitations.

1. Review the received governance invitation.

1. Send a governance request to the governed tenant, selecting the appropriate governance policy template. The future governed tenant receives an email notification that a request is pending.

> [!NOTE]

> Governance requests are valid for 14 days.

### Step 4: Accept the governance request in the governed tenant
1. Sign in to the governed tenant as an administrator.

1. Navigate to Governing tenants > Received requests.

1. Select a request id to review the governance request.

1. Accept the governance request to create the governance relationship. The governing tenant receives an email notification that the request has been accepted and a relationship has been created.

## Set up a governance relationship using a two-step handshake
Use the two-step handshake when either of the following conditions is met:

- The target tenant has been identified as a related tenant with a Billing signal.

- There's an existing, active governance relationship between the two tenants, and you're seeking to establish another relationship between them.

### Step 1: Send a governance request from the governing tenant
1. Sign in to the governing tenant as an administrator.

1. Navigate to Governed tenants > Send governance request.

1. Send a governance request to the governed tenant, selecting the appropriate governance policy template.

> [!NOTE]

> Governance requests are valid for 14 days.

### Step 2: Accept the governance request in the governed tenant
1. Sign in to the governed tenant as an administrator.

1. Navigate to Governing tenants > Received requests.

1. Review the governance request.

1. Accept the governance request to create the governance relationship.

## Verify the governance relationship
When a governance relationship is successfully created, the following resources are provisioned:

- A governance relationship object in both the governing and governed tenants.

- In the governed tenant:

  - If delegated administration is configured, the partner-specific configuration for cross tenant access is updated and cross tenant role assignments are created.

  - If multi-tenant application management is configured, the corresponding service principal and its permissions are created.

## Related content
- [Update a governance relationship](how-to-update-governance-relationship.md)

- [Terminate a governance relationship](how-to-terminate-governance-relationship.md)

- [Use delegated administration](how-to-delegated-administration.md)
