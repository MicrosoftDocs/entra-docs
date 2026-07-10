---
title: Assignment restriction for managed identities (Preview)
description: Learn how assignment restrictions scope a user-assigned managed identity to one or more resource providers to improve security and resilience.
author: mmacy-msft
ms.author: marshmacy
ms.service: entra-id
ms.subservice: managed-identities
ms.topic: concept-article
ms.custom: msecd-doc-authoring-10012
ms.date: 04/24/2026
ai-usage: ai-assisted

#customer intent: As an Azure administrator, I want to understand assignment restriction for user-assigned managed identities so that I can scope identity usage to one or more resource providers and reduce security and operational risk.

---
## Note about supported Resource Providers and Resource Types in the Azure portal

> [!NOTE]
> Selecting **None** for resource assignment restrictions leaves the identity unrestricted, allowing it to be assigned to resources from any resource provider that supports managed identities.
>
> Configure resource assignment restrictions only when you want to limit identity assignment to specific resource providers. Be aware that the **Select Resource Types** list in the Azure portal may not include all supported resource providers and resource types.

The **Select Resource Types** pane in the Azure portal does not display all resource providers and resource types that support managed identities. If the resource you want to configure is not listed, use the Azure CLI to create or update the identity assignment. Refer to the Azure CLI examples below for resources that are not currently available in the **Select Resource Types** list.

### Create an identity with resource assignment restrictions

```bash
az identity create \
  --name MyIdentity \
  --resource-group MyResourceGroup \
  --resource-restriction '{"providers": ["Microsoft.Compute", "Microsoft.Storage/Accounts"]}'
```

### Update an identity to restrict assignment to specific resources

```bash
az identity update \
  --name MyIdentity \
  --resource-group MyResourceGroup \
  --resource-restriction '{"providers": ["Microsoft.Compute", "Microsoft.Storage/Accounts"]}'
```

### List the associated resources for an identity

```bash
az identity list-resources \
  --name MyIdentity \
  --resource-group MyResourceGroup
```

### Create an unrestricted identity

```bash
az identity create \
--name MyIdentity \
--resource-group MyResourceGroup \
--resource-restriction '{"providers": []}'
```

### Remove all resource provider restrictions from an identity

```bash
az identity update \
--name MyIdentity \
--resource-group MyResourceGroup \
--resource-restriction '{"providers": []}'
```

# Assignment restriction for user-assigned managed identities (Preview)

Assignment restrictions, also known as resource restrictions, are a security feature for user-assigned managed identities that limit the resource providers an identity can be assigned to. It is currently a public preview feature. Assignment restrictions let you isolate a managed identity to one or more resource providers so that it can't be reused across unrelated services.

When you configure assignment restriction, managed identity usage stays tightly scoped. This scoping reduces the blast radius of a compromised or misconfigured identity and helps improve both security and resilience.

## Understand resource restriction

When you work with user-assigned managed identities, two resource roles are involved:

- **Source resource**: The resource that the managed identity is assigned to.
- **Target resource**: The resource that the source resource accesses by using the managed identity.

For example, if an App Service accesses a Storage Account by using a managed identity, the App Service is the source resource and the Storage Account is the target resource.

Assignment restriction applies to the relationship between the managed identity and the *source resource*. It doesn't apply to the target resource.

If you want a managed identity to be restricted to source resources across multiple resource providers (for example, both `Microsoft.Web` and `Microsoft.ContainerRegistry`), [set resource restrictions](configure-managed-identities-assignment-restriction.md) that include each allowed resource provider.

## Assignment restriction scope

When assignment restriction is configured for a user-assigned managed identity:

- The identity can only be assigned to source resources that match the allowed resource providers.
- Source resources can still access target resources outside that scope, as long as the appropriate role assignments exist.

This behavior lets services maintain their downstream dependencies while keeping identity assignment tightly controlled.

## Benefits of assignment restriction

The following benefits make assignment restriction a strong default for production workloads.

### Reduced security exposure

Restricting where a managed identity can be assigned prevents the identity from being reused across unrelated resource providers. This restriction limits the blast radius if credentials are misused or compromised.

### Least privilege by design

Assignment restriction prevents accidental or unnecessary identity reuse. Services don't retain permissions beyond their intended scope.

### Failure containment

If a managed identity is misconfigured, disabled, or compromised, the impact is contained to a limited set of resources instead of cascading across multiple resource providers or services.

### Improved service resilience

Scoping identity assignment limits the reach of outages caused by identity or role assignment issues, which helps prevent service-wide failures.

### Operational clarity

Restricting assignment scope simplifies auditing, troubleshooting, and incident response by making identity usage more predictable and traceable.

## Risks of not setting assignment restriction

> [!NOTE]
> By default, the assignment restrictions value is blank, which represents an empty array.

If the assignment restriction value is unset or configured as an empty array:

- Managed identities can be assigned across multiple resource providers.
- Identity usage becomes difficult to audit.
- A single identity misconfiguration can result in multi-service or service-wide outages.
- A compromised identity can enable broad, unintended access beyond the original design intent.

## Best practices

Consider the following best practices when you plan assignment restriction for user-assigned managed identities:

- Create separate managed identities per resource provider.
- Match managed identity scope to the intended source resources only.
- Avoid reusing managed identities across unrelated workloads for convenience.

## Related content

- [Configure assignment restriction for user-assigned managed identities](configure-managed-identities-assignment-restriction.md)
