---
title: Isolation Scope For User Assigned Managed Identities
description: Learn about isolation scope for user-assigned managed identities and how it improves security and resilience.

author: SHERMANOUKO
manager: pmwongera
ms.author: shermanouko
ms.reviewer: arluca
ms.service: entra-id
ms.subservice: managed-identities
ms.topic: concept-article
ms.date: 07/16/2025
---

# Isolation scope for user-assigned managed identities

You can set your managed identity's isolation scope value to either `None` or `Regional`:

- *None* (default): The identity can be used across all regions
- *Regional*: The identity can only be used by source resources in the same region as the managed identity

Setting the isolation scope to `Regional` ensures that the managed identity usage is tightly scoped and aligned with your security and operational boundaries. Regional isolation for user-assigned managed identities helps improve security and resilience by restricting where managed identities can be used.

## Understand regional isolation

When you're working with managed identities, there are two types of resources:

- **Source resource**: The resource that has the managed identity assigned to it
- **Target resource**: The resource that the source resource accesses using the managed identity

For example, if an App Service needs to access a Storage Account using a managed identity, the App Service is the source resource and the Storage Account is the target resource.

Regional isolation applies to the relationship between the managed identity and the source resource. When you enable regional isolation scope:

- The managed identity can only be assigned to source resources in the same region.
- Source resources can still access target resources in other regions (with proper role permissions). For example, a managed identity assigned to a source resource in West US can be used to access target resources in Spain Central or UAE North.

## Benefits of regional isolation

Regional isolation provides several key benefits:

### Minimizes security exposure

By scoping a managed identity to a single region, you prevent it from being used across regions, reducing the blast radius if the identity is ever compromised. Without isolation, a token issued in one region could be used to access resources in another, increasing the potential impact of credential theft or misuse.

### Enforces least privilege by design

Regional isolation ensures that identities are only granted access to resources in their own region and prevent services from retaining unnecessary privileges by unassigning identities. This helps teams avoid unintentionally granting access to services or data in other regions.

### Contains failures to a single region

If a managed identity is misconfigured or compromised, regional scoping ensures that incidents and outages are contained. Without isolation, a single identity could disrupt services across multiple regions, undermining fault isolation strategies.

### Improves service resilience

Regional scoping limits the reach of outages caused by identity misconfigurations. For example, if a role assignment or token issuance fails in one region, it won't cascade across your global footprint.

### Supports robust disaster recovery

With region-specific identities, you can design independent recovery strategies per region. This avoids scenarios where a global identity becomes a bottleneck or single point of failure during regional failover or recovery.

## Risks of setting isolation scope to none

If the isolation scope property on a user-assigned managed identity isn't set or set to `None` (the default), the identity can be used across all regions. This introduces several risks:

- Cross-region token usage: A token issued in one region could be used to access resources in another, violating data residency or compliance boundaries.
- Unintended access: You might unknowingly assign the identity to resources in multiple regions, leading to broader-than-intended access.
- Harder to audit and troubleshoot: Without isolation, it becomes difficult to trace which resources are using the identity and where, complicating incident response.
- Increased blast radius: A compromised identity could be used to access resources across your entire deployment, not just in one region.

To avoid these risks, set isolation scope to `Regional` when creating a user-assigned managed identity.

## Best practices

To maximize the benefits of regional isolation:

- Use one managed identity per region: Create separate managed identities for each Azure region where your services are deployed
- Match managed identity region to compute resources: Ensure managed identities reside in the same region as their source resources
- Plan for dependencies: Ensure all compute resources sharing a managed identity have access to the same dependencies. These dependencies are the downstream services, resources, or systems that a compute resource (like a VM, Function App, or App Service) needs to access using its managed identity.

## Next steps

- [Enable regional isolation for user-assigned managed identities](./configure-managed-identities-isolation-scope.md)
