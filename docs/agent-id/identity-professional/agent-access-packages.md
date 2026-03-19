---
title: Access Packages for Agent Identities in Microsoft Entra
titleSuffix: Microsoft Entra Agent ID
description: This article explains how access packages provide governance for agent identity access to resources.
ms.date: 3/17/2026
ms.custom: agent-id-ignite
ms.topic: concept-article

#customer-intent: As an IT admin, I want to configure access packages for agent identities so that I can ensure their access is intentional, auditable, and time-bound.
---

# Access packages for Agent identities

Microsoft Entra entitlement management provides access packages as a governance mechanism. Access packages ensure that agent access assignments are intentional, auditable, and time-bound. Access packages represent a structured approach to managing agent identity permissions, contrasting with ad-hoc permission assignments that might lack appropriate governance controls. Access packages enable standardized access for many AI Agents with the same access needs, for example, a fleet of customer support AI Agents. Through access packages, organizations can establish consistent governance practices for agent identity, agent user, and service principal access to resources. For more information, see [Governing agent identities](/entra/id-governance/agent-id-governance-overview).

## License requirements

[!INCLUDE [entra-agent-id-license](../../includes/entra-agent-id-license-note.md)]

## Prerequisites

Before creating an access package, confirm the following prerequisites are met in your organization:

1. Agents are using Microsoft Entra Agent ID agent identities, or service principals, for authorization to access resources.
1. The authorization necessary is one of:
   - Agents need their identity to be assigned OAuth *application permissions* for a target resource, such as Microsoft Graph or an application, to be able to access a target resource's APIs.
   - Agents need their identity to be assigned as members of groups.
   - Agents need their identity to be assigned to directory roles. The allowable roles are listed in [Microsoft Entra roles allowed for agents](authorization-agent-id.md#microsoft-entra-roles-allowed-for-agents).
2. You have an entitlement management catalog suitable to hold those resources. The access package that you'll be creating, and any resources included in it, are added to the catalog. For more information, see [create a catalog](/entra/id-governance/entitlement-management-catalog-create).

   > [!NOTE]
   > If you'll be adding OAuth API permissions or directory roles to the access package as resource roles, then the catalog will be [marked as privileged](/entra/id-governance/entitlement-management-catalog-create#What-changes-for-privileged-catalogs) when they are added to the access package.

## Create an access package for agent identities (Preview)

To use access packages for agents, the IT admin first configures a new access package with the relevant resources, including Entra roles, group memberships, and OAuth permission grants to application APIs. Then the admin configures in the access package the required policy settings. These settings define who can get access, who can request access, approvals, access expiration, and extension.

As agent identities and service principals can't be added through access packages to application roles, SAP roles, or SharePoint Online site roles, do not re-use an access package which contains any of those resource roles. Instead, create a new access package.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Identity Governance Administrator](../../identity/role-based-access-control/permissions-reference.md#identity-governance-administrator).

    > [!TIP]
    > If you'll be adding OAuth API permissions or directory roles to the access package as resource roles, then you will need to be a Global Administrator.
1. Browse to **ID Governance** > **Entitlement management** > **Access packages**.

1. Select **New access package**.

1. On the **Basics** tab, you give the access package a name, and description and specify which catalog to create the access package in. In the **Catalog** dropdown list, select the catalog where you want to put the access package.

1. Select **Next: Resource roles**. On the **Resource roles** tab, you select the resource roles to include in the access package. Access packages for agent identities can have security group memberships, directory roles, or API permissions as resource roles. For more information, see [add a group](/entra/id-governance/entitlement-management-access-package-resources#add-a-group-or-team-resource-role), [add a Microsoft Entra role](/entra/id-governance/entitlement-management-access-package-resources#add-a-microsoft-entra-role-assignment), and [add an API permission](/entra/id-governance/entitlement-management-access-package-resources#add-an-api-permission-preview). Do not add application roles, SAP roles, or SharePoint Online site roles to an access package for agent identities.

    > [!TIP]
    > If you're not sure which resource roles to include, you can skip adding them while creating the access package, and then [add them](/entra/id-governance/entitlement-management-access-package-resources) later.

1. Select **Next: Requests**. On the **Requests** tab, you create the first policy to specify who can request the access package. in the **Who can get access** section, select **For users, service principals, and agent identities in your directory**. In **Select specific scope**, select the option of **All agents (preview)**.

   > [!NOTE]
   > If your agents are using service principals rather than Microsoft Entra agent identities, then also create an access package assignment policy with the option **All Service principals (preview)** to allow service principals in your directory to be able to request this access package.

1. Determine how many approval stages are needed. Set the **How many stages** toggle to **1** for single-stage approval, **2** for two-stage approval, or **3** for three-stage approval. Then configure approval stages and who the approvers should be. For more information, see [single stage approval](/entra/id-governance/entitlement-management-access-package-create#single-stage-approval).

1. Once you have specified each approval stage, select **Next: Requestor Information**.

1. Select **Next: Lifecycle**. Specify how long an access package assignment should remain before it expires.

1. Select **Next: Rules**.

1. Select **Next: Review + create**. On the **Review + create** tab, you can review your settings and check for any validation errors.

1. Select **Create** to create the access package and its initial policy.

In addition to using the Microsoft Entra Admin Center, you can also create an access package programmatically, through Microsoft Graph, and through the PowerShell cmdlets for Microsoft Graph. For more information, see [Create an access package programmatically](/entra/id-governance/entitlement-management-access-package-create#create-an-access-package-programmatically).

## Access request and approval process

Agents can then be assigned access packages through three different request pathways.

- The agent itself, if using a srevice principal, can programmatically request an access package when needed for its operations, by creating an [accessPackageAssignmentRequest](/graph/api/entitlementmanagement-post-assignmentrequests?tabs=http).
- The agent identity's sponsor can request access on behalf of the agent ID, providing human oversight in the access request process. For more information, see [Request an access package on behalf of an agent identity (Preview)](/entra/id-governance/entitlement-management-request-behalf#request-an-access-package-on-behalf-of-an-agent-identity-preview).
- An administrator can [directly assign the agent identity or agent user to the access package](/entra/id-governance/entitlement-management-access-package-assignments#directly-assign-an-identity).

After submission, the access request is routed to designated approvers based on the access package policy configuration.

## Access assignment lifecycle

Once an approver accepts the access package assignment request, the agent identity receives time-bound access to the specified resources. The access is granted according to the resource roles defined in the access package. This establishes a clear start and end date for the access the agent might need.

If the assignment is to an agent identity, and a sponsor is set on the agent identity, as the expiry date approaches, the sponsor receives notifications about the pending expiration. The sponsor then has two options: they can request an extension of the access package (if permitted by policy), or they can allow the access package assignment to expire.

If the sponsor requests an extension, this request can trigger a new approval cycle, where approvers again confirm whether continued access is appropriate. If the sponsor takes no action, the access package assignment automatically expires on its end date, and the agent identity loses access to the target resources.

## Related content

- [Governing agent identities](/entra/id-governance/agent-id-governance-overview)
- [Create an access package in entitlement management](/entra/id-governance/entitlement-management-access-package-create)
- [Conditional access for agent identities](/entra/identity/conditional-access/agent-id)
