---
title: Access Packages for Agent Identities in Microsoft Entra ID
titleSuffix: Microsoft Entra Agent ID
description: This article explains how access packages provide governance for agent identity access to resources.
ms.date: 11/04/2025
ms.custom: agent-id-ignite
ms.topic: concept-article

#customer-intent: As an IT admin, I want to configure access packages for agent identities so that I can ensure their access is intentional, auditable, and time-bound.
---

# Access packages for Agent identities in Microsoft Entra ID

Microsoft Entra entitlement management provides access packages as a governance mechanism. Access packages ensure that agent access assignments are intentional, auditable, and time-bound. Access packages represent a structured approach to managing agent identity permissions, contrasting with ad-hoc permission assignments that might lack appropriate governance controls. Access packages enable standardized access for many AI Agents with the same access needs, for example, a fleet of customer support AI Agents. Through access packages, organizations can establish consistent governance practices for agent identity, agent user, and service principal access to resources. For more information, see [Governing agent identities](/entra/id-governance/agent-id-governance-overview).

## Prerequisites

[!INCLUDE [entra-agent-id-license](../../includes/entra-agent-id-license-note.md)]

## Create an access package

To use access packages for agents, the IT admin first configures a new access package with the relevant resources, including Entra roles, group memberships, and OAuth permission grants to applications. Then the admin configures in the access package the required policy settings. These settings define who can get access, who can request access, approvals, access expiration, and extension. When creating an access package assignment policy, in the **Who can get access** section, select **For users, service principals, and agent identities in your directory**, and then select the option of **All agents (preview)**.

> [!NOTE]
> If your agents are using service principals rather than Microsoft Entra agent identities, then also create an access package assignment policy with the option **All Service principals (preview)** to allow service principals in your directory to be able to request this access package.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Identity Governance Administrator](../identity/role-based-access-control/permissions-reference.md#identity-governance-administrator).

    > [!TIP]
    > If you will be adding OAuth permissions or directory roles to the access package as resource roles, then you will need to be a Global Administrator.
1. Browse to **ID Governance** > **Entitlement management** > **Access package**.

1. Select **New access package**. On the **Basics** tab, you give the access package a name and specify which catalog to create the access package in.

1. Enter a display name and description for the access package. Users see this information when they submit a request for the access package.

1. In the **Catalog** dropdown list, select the catalog where you want to put the access package. For example, you might have a catalog owner who manages all the marketing resources that can be requested. In this case, you could select the marketing catalog.

    You see only catalogs that you have permission to create access packages in. To create an access package in an existing catalog, you must be at least an Identity Governance Administrator. Or you must be a catalog owner or access package manager in that catalog.

    If you're at least an Identity Governance Administrator, or catalog creator, and you want to create your access package in a new catalog that's not listed, select **Create new catalog**. Enter the catalog name and description, and then select **Create**.

    The access package that you're creating, and any resources included in it, are added to the new catalog. Later, you can add more catalog owners or add attributes to the resources that you put in the catalog. To learn more about how to edit the attributes list for a specific catalog resource and the prerequisite roles, read [Add resource attributes in the catalog](entitlement-management-catalog-create.md#add-resource-attributes-in-the-catalog).

   > [!NOTE]
   > If you will be adding OAuth permissions or directory roles to the access package as resource roles, then the catalog will be marked as privileged.


1. Select **Next: Resource roles**.

In addition to using the Microsoft Entra Admin Center, you can also create an access package programmatically, through Microsoft Graph and through the PowerShell cmdlets for Microsoft Graph. For more information, see [Create an access package programatically](/entra/id-governance/entitlement-management-access-package-create.md#create-an-access-package-programatically).


## Access request and approval process

Agents can then be assigned access packages through three different request pathways.

- The agent identity itself can programmatically request an access package when needed for its operations, by creating an [accessPackageAssignmentRequest](/graph/api/entitlementmanagement-post-assignmentrequests?tabs=http).
- The agent's sponsor can request access on behalf of the agent ID, providing human oversight in the access request process. For more information, see [Request an access package on behalf of an agent identity (Preview)](/entra/id-governance/entitlement-management-request-behalf#request-an-access-package-on-behalf-of-an-agent-identity-preview).
- An administrator can [directly assign the agent identity or agent user to the access package](/entra/id-governance/entitlement-management-access-package-assignments#directly-assign-an-identity).

After submission, the access request is routed to designated approvers based on the access package configuration.

## Access assignment lifecycle

Once an approver accepts the access package assignment request, the agent identity receives time-bound access to the specified resources. The access is granted according to the resource roles defined in the access package. This package establishes a clear start and end date for the access the agent might need.

If a sponsor is set on the agent identity, as the expiry date approaches, the sponsor receives notifications about the pending expiration. The sponsor then has two options: they can request an extension of the access package (if permitted by policy), or they can allow the access package assignment to expire.

If the sponsor requests an extension, this request can trigger a new approval cycle, where approvers again confirm whether continued access is appropriate. If the sponsor takes no action, the access package assignment automatically expires on its end date, and the agent identity loses access to the target resources.

## Related content

- [Governing agent identities](/entra/id-governance/agent-id-governance-overview)
- [Create an access package in entitlement management](/entra/id-governance/entitlement-management-access-package-create)
- [Conditional access for agent identities](/entra/identity/conditional-access/agent-id)
