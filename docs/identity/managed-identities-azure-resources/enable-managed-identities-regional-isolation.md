---
title: Enable regional isolation for user-assigned managed identities
description: Learn how to enable regional isolation scope for user-assigned managed identities to improve security and resilience.

author: SHERMANOUKO
manager: pmwongera
ms.author: shermanouko
ms.reviewer: arluca
ms.service: entra-id
ms.subservice: managed-identities
ms.topic: how-to
ms.date: 07/09/2025
---

# Enable regional isolation for user-assigned managed identities

Regional isolation for user-assigned managed identities helps improve security and resilience by restricting where managed identities can be used. This article explains how to enable regional isolation scope and its benefits.

When working with managed identities, there are two types of resources:

- **Source resource**: The resource that has the managed identity assigned to it
- **Target resource**: The resource that the source resource accesses using the managed identity

For example, if an App Service needs to access a Storage Account using a managed identity, the App Service is the source resource and the Storage Account is the target resource.

Regional isolation applies to the relationship between the managed identity and the source resource. When you enable regional isolation scope:

- The managed identity can only be assigned to source resources in the same region
- Source resources can still access target resources in other regions (with proper role permissions)

Regional isolation provides several key benefits:

- **Reduced attack surface**: Prevents managed identities from being used across regions
- **Principle of least privilege**: Enforces more granular access controls
- **Eliminates single points of failure**: Prevents one managed identity from affecting multiple regions
- **Reduces service-wide outages**: Limits the impact of misconfigurations or incidents
- **Improves disaster recovery**: Enables region-specific recovery strategies

To maximize the benefits of regional isolation:

- Use one managed identity per region. Create separate managed identities for each Azure region where your services are deployed
- Match managed identity region to compute resources. Ensure managed identities reside in the same region as their source resources
- Plan for dependencies. Ensure all compute resources sharing a managed identity have access to the same dependencies

## Enable regional isolation in Azure Portal

To create a user-assigned managed identity with regional isolation scope:

1. Sign in to the [Azure Portal](https://portal.azure.com)

1. Navigate to **Managed Identities**. In the search box, type "Managed Identities". Under **Services**, select **Managed Identities**

1. Create a new managed identity. Select **+ Create** to add a new user-assigned managed identity. Configure the basic settings:
    
    - **Subscription**: Select your subscription
    - **Resource Group**: Choose an existing resource group or create a new one
    - **Region**: Select the specific region for deployment
    - **Isolation Scope**: Select *Regional*
    - **Name**: Enter the name of the managed identity

1. Review and create. Select **Review + create** to validate your configuration.

1. Select **Create** to deploy the managed identity.

Once you set the value for isolation scope, you can only update it via Azure Resource Manager deployment template or REST API. The Azure portal doesn't support changing the isolation scope after creation.
