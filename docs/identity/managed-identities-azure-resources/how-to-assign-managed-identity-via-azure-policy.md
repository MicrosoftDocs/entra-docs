---
title: Use Azure Policy to assign managed identities (preview)
description: Documentation for the Azure Policy that can be used to assign managed identities to Azure resources.

author: rwike77
manager: CelesteDG
editor: barclayn
ms.service: entra-id
ms.subservice: managed-identities
ms.topic: how-to
ms.date: 05/23/2022
ms.author: ryanwi

---

# Use Azure Policy to assign managed identities (preview)

[Azure Policy](/azure/governance/policy/overview) helps enforce organizational standards and assess compliance at scale. Through its compliance dashboard, Azure policy provides an aggregated view that helps administrators evaluate the overall state of the environment. You can drill down to the per-resource, per-policy granularity. It also helps bring your resources to compliance through bulk remediation for existing resources and automatic remediation for new resources. Common use cases for Azure Policy include implementing governance for:

- Resource consistency
- Regulatory compliance
- Security
- Cost
- Management

Policy definitions for these common use cases are already available in your Azure environment to help you get started.

Azure Monitoring Agents require a [managed identity](overview.md) on the monitored Azure Virtual Machines (VMs). This document describes the behavior of a built-in Azure Policy provided by Microsoft that helps ensure a managed identity, needed for these scenarios, is assigned to VMs at scale.

While using system-assigned managed identity is possible, when used at scale (for example, for all VMs in a subscription) it results in a substantial number of identities created (and deleted) in Microsoft Entra ID. To avoid this churn of identities, it's recommended to use user-assigned managed identities, which can be created once and shared across multiple VMs.

## Policy definition and details

- [Policy for Virtual Machines](https://portal.azure.com/#blade/Microsoft_Azure_Policy/PolicyDetailBlade/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicyDefinitions%2Fd367bd60-64ca-4364-98ea-276775bddd94)
- [Policy for Virtual Machine Scale Sets](https://portal.azure.com/#blade/Microsoft_Azure_Policy/PolicyDetailBlade/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicyDefinitions%2F516187d4-ef64-4a1b-ad6b-a7348502976c)

When executed, the policy takes the following actions:

1. Create, if not existing, a new built-in user-assigned managed identity in the subscription and each Azure region based on the VMs that are in the policy's scope.
2. Once created, put a lock on the user-assigned managed identity so that it won't be accidentally deleted.
3. Assign the built-in user-assigned managed identity to Virtual Machines from the subscription and region based on the VMs that are in the policy's scope.
> [!NOTE]
> If the Virtual Machine has exactly 1 user-assigned managed identity already assigned, then the policy skips this VM to assign the built-in identity. This ensures the policy assignment doesn't break applications that depend on [the default behavior of the token endpoint on IMDS.](managed-identities-faq.md#what-identity-will-imds-default-to-if-i-dont-specify-the-identity-in-the-request)

There are two scenarios to use the policy:

- Let the policy create and use a “built-in” user-assigned managed identity.
- Bring your own user-assigned managed identity.

The policy takes the following input parameters:

- Bring-Your-Own-UAMI? - Should the policy create, if not existing, a new user-assigned managed identity?
  - If set to true, then you must specify:
    - Name of the managed identity.
    - Resource group containing the managed identity.
  - If set to false, then no additional input is needed.
    - The policy will create the required user-assigned managed identity called “built-in-identity” in a resource group called “built-in-identity-rg".
- Restrict-Bring-Your-Own-UAMI-To-Subscription? - When the Bring-Your-Own-UAMI parameter is set to true, should the policy utilize a centralized user-assigned managed identity or utilize an identity for each subscription?
  - If set to true, then no additional input is needed.
    - The policy will use a user-assigned managed identity per subscription.
  - If set to false, the policy will utilize a single centralized user-assigned managed identity that will be applied across all the subscriptions covered by the policy assignment. You must specify:
    - User Assigned Managed Identity Resource Id

## Using the policy
### Creating the policy assignment

You can assign the policy definition to different scopes in Azure – at the management group subscription or a specific resource group. As policies need to be enforced all the time, the assignment operation uses a managed identity associated with the policy-assignment object. The policy assignment object supports both system-assigned and user-assigned managed identity.
For example, Joe can create a user-assigned managed identity called PolicyAssignmentMI. The built-in policy creates a user-assigned managed identity in each subscription and in each region with resources that are in the policy assignment's scope. The user-assigned managed identities created by the policy have the following resourceId format:

> /subscriptions/your-subscription-id/resourceGroups/built-in-identity-rg/providers/Microsoft.ManagedIdentity/userAssignedIdentities/built-in-identity-{location}

For example:
> /subscriptions/aaaa0a0a-bb1b-cc2c-dd3d-eeeeee4e4e4e/resourceGroups/built-in-identity-rg/providers/Microsoft.ManagedIdentity/userAssignedIdentities/built-in-identity-eastus

### Required authorization

For PolicyAssignmentMI managed identity to assign the built-in policy across the specified scope, it needs the following permissions, expressed as an Azure RBAC (Azure role-based access control) Role Assignment:

| Principal| Role / Action | Scope | Purpose |
|----|----|----------------|----|
|PolicyAssignmentMI |Managed Identity Operator | /subscription/subscription-id/resourceGroups/built-in-identity <br> OR <br>Bring-your-own-User-assigned-Managed identity |Required to assign the built-in identity to VMs.|
|PolicyAssignmentMI |Contributor | /subscription/subscription-id> |Required to create the resource-group that holds the built-in managed identity in the subscription.|
|PolicyAssignmentMI |Managed Identity Contributor | /subscription/subscription-id/resourceGroups/built-in-identity |Required to create a new user-assigned managed identity.|
|PolicyAssignmentMI |User Access Administrator | /subscription/subscription-id/resourceGroups/built-in-identity <br> OR <br>Bring-your-own-User-assigned-Managed identity |Required to set a lock on the user-assigned managed identity created by the policy.|

As the policy assignment object must have this permission ahead of time, PolicyAssignmentMI can't be a system-assigned managed identity for this scenario. The user performing the policy assignment task must pre-authorize PolicyAssignmentMI ahead of time with the above role assignments.

As you can see the resultant least privilege role required is “contributor” at the subscription scope.

## Known issues

A possible race condition with another deployment that changes the identities assigned to a VM can result in unexpected results.

If two or more parallel deployments update the same virtual machine and they all change the identity configuration of the virtual machine, then it's possible, under specific race conditions, that all expected identities won't be assigned to the machines.
For example, if the policy in this document is updating the managed identities of a VM and at the same time another process is also making changes to the managed identities section, then it's not guaranteed that all the expected identities are properly assigned to the VM.

## Next steps

- [Deploy Azure Monitor Agent](/azure/azure-monitor/agents/azure-monitor-agent-manage#use-azure-policy)
