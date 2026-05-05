---
title: Use Azure Policy to assign managed identities (preview)
description: Documentation for the Azure Policy that can be used to assign managed identities to Azure resources.
ms.topic: how-to
ms.date: 05/05/2026
ai-usage: ai-assisted

---

# Use Azure Policy to assign managed identities (preview)


[Azure Policy](/azure/governance/policy/overview) helps enforce organizational standards and assess compliance at scale. Through its compliance dashboard, Azure policy provides an aggregated view that helps administrators evaluate the overall state of the environment. You have the ability to drill down to the per-resource, per-policy granularity. It also helps bring your resources to compliance through bulk remediation for existing resources and automatic remediation for new resources. Common use cases for Azure Policy include implementing governance for:

- Resource consistency
- Regulatory compliance
- Security
- Cost
- Management


Policy definitions for these common use cases are already available in your Azure environment to help you get started.

Azure Monitoring Agents require a [managed identity](overview.md) on the monitored Azure Virtual Machines (VMs). This document describes the behavior of a built-in Azure Policy provided by Microsoft that helps ensure a managed identity, needed for these scenarios, is assigned to VMs at scale.

While using a system-assigned managed identity is possible, when used at scale (for example, for all VMs in a subscription) it results in a substantial number of identities created (and deleted) in Microsoft Entra ID. To avoid this churn of identities, use user-assigned managed identities. They can be created once and shared across multiple VMs.

## Policy definition and details

- [Policy for Virtual Machines](https://portal.azure.com/#blade/Microsoft_Azure_Policy/PolicyDetailBlade/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicyDefinitions%2Fd367bd60-64ca-4364-98ea-276775bddd94)
- [Policy for Virtual Machine Scale Sets](https://portal.azure.com/#blade/Microsoft_Azure_Policy/PolicyDetailBlade/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicyDefinitions%2F516187d4-ef64-4a1b-ad6b-a7348502976c)



When executed, the policy takes the following actions:

1. Create a new built-in user-assigned managed identity (if one doesn't exist) in the subscription. The identity is created in each Azure region based on the VMs that are in scope of the policy.
1. Lock the user-assigned managed identity to prevent accidental deletion.
1. Assign the built-in user-assigned managed identity to virtual machines from the subscription and region based on the VMs that are in scope of the policy.
> [!NOTE]
> If the virtual machine already has exactly one user-assigned managed identity assigned, the policy skips assigning the built-in identity to that VM. This behavior makes sure that the policy assignment doesn't break applications that depend on [the default behavior of the token endpoint on Azure Instance Metadata Service (IMDS)](managed-identities-faq.md#what-identity-will-imds-default-to-if-i-dont-specify-the-identity-in-the-request).


There are two scenarios to use the policy:

- Let the policy create and use a built-in user-assigned managed identity.
- Bring your own user-assigned managed identity.

The policy takes the following input parameters:

- **Bring-Your-Own-UAMI?** - Should the policy create a new user-assigned managed identity if one doesn't exist?
  - If set to true, you must specify:
    - Name of the managed identity.
    - Resource group containing the managed identity.
  - If set to false, no more input is needed.
    - The policy creates the required user-assigned managed identity called `built-in-identity` in a resource group called `built-in-identity-rg`.
- **Restrict-Bring-Your-Own-UAMI-To-Subscription?** - When the **Bring-Your-Own-UAMI** parameter is set to true, should the policy use a centralized user-assigned managed identity or use an identity for each subscription?
  - If set to true, no more input is needed.
    - The policy uses a user-assigned managed identity per subscription.
  - If set to false, the policy uses a single centralized user-assigned managed identity that's applied across all the subscriptions covered by the policy assignment. You must specify:
    - User Assigned Managed Identity Resource ID

## Using the policy
### Creating the policy assignment

The policy definition can be assigned to different scopes in Azure - at the management group, subscription, or a specific resource group. Because policies must be enforced continuously, the assignment operation uses a managed identity associated with the policy-assignment object. The policy assignment object supports both system-assigned and user-assigned managed identities.
For example, you can create a user-assigned managed identity called PolicyAssignmentMI. The built-in policy creates a user-assigned managed identity in each subscription and in each region with resources that are in scope of the policy assignment. The user-assigned managed identities created by the policy have the following resource ID format:

> /subscriptions/your-subscription-id/resourceGroups/built-in-identity-rg/providers/Microsoft.ManagedIdentity/userAssignedIdentities/built-in-identity-{location}

For example:
> /subscriptions/aaaa0a0a-bb1b-cc2c-dd3d-eeeeee4e4e4e/resourceGroups/built-in-identity-rg/providers/Microsoft.ManagedIdentity/userAssignedIdentities/built-in-identity-eastus

### Required authorization

For PolicyAssignmentMI managed identity to be able to assign the built-in policy across the specified scope, it needs the following permissions, expressed as an Azure RBAC (Azure role-based access control) Role Assignment:

| Principal| Role / Action | Scope | Purpose |
|----|----|----------------|----|
|PolicyAssignmentMI |Managed Identity Operator | /subscription/subscription-id/resourceGroups/built-in-identity <br> OR <br>Bring-your-own-User-assigned-Managed identity |Required to assign the built-in identity to VMs.|
|PolicyAssignmentMI |Contributor | /subscription/subscription-id> |Required to create the resource-group that holds the built-in managed identity in the subscription. |
|PolicyAssignmentMI |Managed Identity Contributor | /subscription/subscription-id/resourceGroups/built-in-identity |Required to create a new user-assigned managed identity.|
|PolicyAssignmentMI |User Access Administrator | /subscription/subscription-id/resourceGroups/built-in-identity <br> OR <br>Bring-your-own-User-assigned-Managed identity |Required to set a lock on the user-assigned managed identity created by the policy.|


Because the policy assignment object must have this permission ahead of time, PolicyAssignmentMI can't be a system-assigned managed identity for this scenario. The user performing the policy assignment task must preauthorize PolicyAssignmentMI with the role assignments shown in the preceding table.

The resultant least-privilege role required is `Contributor` at the subscription scope.



## Known issues

Possible race condition with another deployment that changes the identities assigned to a VM can result in unexpected results.

Under specific race conditions, when two or more parallel deployments update the same virtual machine and all change the identity configuration of the virtual machine, all expected identities might not be assigned to the machines.

For example, the policy in this document might update the managed identities of a VM while another process changes the managed identities section at the same time. In that case, the VM isn't guaranteed to have all the expected identities properly assigned.


## Next steps

- [Deploy Azure Monitor Agent](/azure/azure-monitor/agents/azure-monitor-agent-manage#use-azure-policy)
