---
title: Configure assignment restriction for user-assigned managed identities (preview)
description: Learn how to configure assignment restriction for a user-assigned managed identity in the Azure portal to scope it to specific resource providers.
author: mmacy-msft
ms.author: marshmacy
ms.service: entra-id
ms.subservice: managed-identities
ms.topic: how-to
ms.custom: msecd-doc-authoring-10012
ms.date: 07/10/2026
ai-usage: ai-assisted

#customer intent: As an Azure administrator, I want to configure assignment restriction for a user-assigned managed identity so that the identity can only be assigned to source resources within an allowed resource provider scope.

---

# Configure assignment restriction for user-assigned managed identities (preview)

This article describes how to configure assignment restrictions (also referred to as resource restrictions) for a user-assigned managed identity by using the Azure portal. This is a feature in preview.

Assignment restrictions let you explicitly define the resource providers or resource types that a managed identity can be assigned to. Enforcing assignment restrictions keeps managed identities within their intended scope, which strengthens security and operational boundaries. By restricting where a managed identity can be assigned, you limit identity reuse and reduce blast radius.

## Prerequisites

Before you begin, make sure you have the following:

- An Azure account with an active subscription. [Create an account for free](https://azure.microsoft.com/free).

## Create assignment restrictions in the Azure portal

You configure assignment restrictions when you create a user-assigned managed identity. To create a user-assigned managed identity with assignment restrictions, follow these steps:

1. Sign in to the [Azure portal](https://portal.azure.com) with at least the [Managed Identity Contributor](/azure/role-based-access-control/built-in-roles#managed-identity-contributor) role.

1. Go to **Managed Identities**. In the search box, enter *Managed Identities*. Under **Services**, select **Managed Identities**.

1. Select **+ Create** to add a new user-assigned managed identity and configure the basic settings:

    - **Subscription**: Select your subscription.
    - **Resource group**: Choose an existing resource group or create a new one.
    - **Name**: Enter a name for the managed identity.
    - **Region**: Select the region for deployment.
    - **Isolation Scope**: Select the isolation scope. We recommend setting this value to **Regional** for regional isolation. For more information, see [Isolation scope for user-assigned managed identities](managed-identities-isolation-scope.md).
    - **Resource**: Select **Add resource**. In the **Select Resource Types** panel that opens, search for and select the resource provider or resource type that the identity is restricted to.

    > [!NOTE]
    > If **Resource** is left unconfigured, the value shows as **None**, which represents an empty array.

1. Select **Review + create** to validate your configuration.

1. Select **Create** to deploy the managed identity.

## Update assignment restrictions in the Azure portal

You can update the isolation scope and assignment restrictions of an existing user-assigned managed identity at any time. To update assignment restrictions, follow these steps:

1. Sign in to the [Azure portal](https://portal.azure.com) with at least the [Managed Identity Contributor](/azure/role-based-access-control/built-in-roles#managed-identity-contributor) role.

1. Go to **Managed Identities**, and then select the user-assigned managed identity that you want to update.

1. Under **Settings**, select **Properties**.

1. Update the assignment restrictions:

    - **Isolation Scope**: Select **Regional** or **None**.
    - **Resource**: Select the edit (pencil) icon. In the **Select Resource Types** panel that opens, add or remove the resource providers or resource types that the identity is restricted to.

1. Select **Save** to apply your changes.

> [!NOTE]
> If your update removes a resource provider from the assignment restrictions list, unassign the user-assigned managed identity from the source resource *first*, before you remove the resource provider from the list.

## Supported resource providers and resource types in the Azure portal

> [!NOTE]
> Selecting **None** for resource assignment restrictions leaves the identity unrestricted, allowing it to be assigned to resources from any resource provider that supports managed identities.
>
> Configure resource assignment restrictions only when you want to limit identity assignment to specific resource providers. Be aware that the **Select Resource Types** list in the Azure portal may not include all supported resource providers and resource types.

The **Select Resource Types** pane in the Azure portal does not display all resource providers and resource types that support managed identities. If the resource you want to configure is not listed, use the Azure CLI to create or update the identity assignment. Refer to the Azure CLI examples below for resources that are not currently available in the **Select Resource Types** list.

> [!WARNING]
> In Azure CLI commands and infrastructure-as-code (IaC) templates, specify the resource provider namespace on its own, for example `Microsoft.Storage`. Don't use `Microsoft.Storage/*`.
>
> The **Select Resource Types** pane in the Azure portal displays a provider-wide selection as `Microsoft.Storage/*`. The `/*` suffix is a portal display convention and isn't part of the value that the API accepts. Even when the portal shows `Microsoft.Storage/*`, use `Microsoft.Storage` in Azure CLI commands and IaC templates. To restrict the identity to a single resource type instead of the whole provider, specify the full resource type, for example `Microsoft.Storage/storageAccounts`.

### Create an identity with resource assignment restrictions

```bash
az identity create \
  --name MyIdentity \
  --resource-group MyResourceGroup \
  --resource-restriction '{"providers": ["Microsoft.Compute", "Microsoft.Storage"]}'
```

### Update an identity to restrict assignment to specific resources

```bash
az identity update \
  --name MyIdentity \
  --resource-group MyResourceGroup \
  --resource-restriction '{"providers": ["Microsoft.Compute", "Microsoft.Storage"]}'
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

## Related content

- [Assignment restriction for user-assigned managed identities](managed-identities-assignment-restriction.md)
