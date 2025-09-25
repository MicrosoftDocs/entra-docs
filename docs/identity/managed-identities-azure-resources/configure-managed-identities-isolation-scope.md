---
title: Configure Isolation Scope For User Assigned Managed Identities
description: Learn how to configure isolation scope for user-assigned managed identities to improve security and resilience.

author: SHERMANOUKO
manager: pmwongera
ms.author: shermanouko
ms.reviewer: arluca
ms.service: entra-id
ms.subservice: managed-identities
ms.topic: how-to
ms.date: 07/17/2025
---

# Configure isolation scope for user-assigned managed identities

This article shows you how to configure isolation scope for user-assigned managed identities in the Azure portal. You can either enable regional isolation scope or set your isolation scope to none. Regional isolation helps improve security and resilience by restricting where managed identities can be used, ensuring they can only be assigned to source resources in the same region.

## Prerequisites

Before you begin, ensure you have the following:

- An Azure account with an active subscription. [Create an account for free](https://azure.microsoft.com/free).

- Read the [Isolation scope for user-assigned managed identities](managed-identities-isolation-scope.md) concept article to understand the benefits and implications.

## Configure isolation scope in Azure portal

Use the following steps to configure isolation scope for a user-assigned managed identity.

1. Sign in to the [Azure portal](https://portal.azure.com).

1. Navigate to **Managed Identities**. In the search box, type *Managed Identities*. Under **Services**, select **Managed Identities**.

1. Create a new managed identity. Select **+ Create** to add a new user-assigned managed identity. Configure the basic settings:
    
    - **Subscription**: Select your subscription
    - **Resource Group**: Choose an existing resource group or create a new one
    - **Region**: Select the specific region for deployment
    - **Isolation Scope**: Select *Regional* to set the isolation scope to regional or *None* to set it to none
    - **Name**: Enter the name of the managed identity

1. Review and create. Select **Review + create** to validate your configuration.

1. Select **Create** to deploy the managed identity.

Once you set the value for isolation scope, you can only update it via Azure Resource Manager deployment template or REST API. The Azure portal doesn't yet support changing the isolation scope after creation.

## Next steps

- [Manage user-assigned managed identities](how-manage-user-assigned-managed-identities.md)
