---
title: Use Azure Resources Extension in VS Code for Managed Identities
description: Learn how to use VS Code's Azure Resources extension to manage and configure Azure managed identities directly from your development environment.
author: SHERMANOUKO
manager: pmwongera
ms.date: 06/12/2024

ms.service: entra-id
ms.subservice: managed-identities
ms.topic: how-to
ms.author: shermanouko
ms.reviewer: arluca
---

# Use Azure Resources Extension in VS Code for Managed Identities

The Azure Resources extension for Visual Studio Code provides a powerful interface for managing Azure resources directly from your development environment. When working with managed identities, the extension offers essential capabilities for developers to inspect, and verify their managed identity configurations. This article focuses on three tasks you can accomplish from within VS Code to ensure your managed identities are properly configured and secure.

## Prerequisites

Before starting, ensure you have:

- Visual Studio Code installed
- Appropriate permissions to view Azure resources
- Access to the Azure subscription containing your managed identities

## Install Azure Resources Extension

To work with managed identities in Visual Studio Code, you need the Azure Resources extension. For more information, see []()

## Create a Managed Identity

You'll need to have a managed identity created in your Azure subscription. For more information, see [create a managed identity]().

## Discover managed identity properties (Client ID, Object ID, etc.)

The first step in working with managed identities is understanding their key properties and how to access them from VS Code. Every managed identity has several important properties that your application code needs. For example:

- Client ID: The unique identifier used by your application to request tokens
- Object ID (Principal ID): The unique identifier in Azure AD used for role assignments
- Resource ID: The full Azure resource path for the managed identity
- Tenant ID: The Azure AD tenant where the identity exists

These properties can't be directly viewed in the Azure Resources extension. You'll need to use Copilot with the `/@azure` command to retrieve them. Here’s how you can do it:

1. Open the Azure Resources extension in the VS Code sidebar
1. Select your subscription
1. Locate the Managed Identities section. Here. yopu'll see all your MIs that you have access to.
1. Right click on the managed identity of interest and select **Ask @Azure**. This will open a chat with Copilot. It will require you to sign in to your Azure account if you haven't already. Ensure you are using Copilot in agent mode since this is required to access Azure resources.
1. Query for any property you are looking for like `Client ID`, `Object ID`, or `Resource ID`. For example, you can type:

   ```
    /@azure get the Client ID of the managed identity named "myManagedIdentity"
   ```

## Confirm source resources using a managed identity

Managed identities can be used as an identity for various Azure resources, such as virtual machines, app services, and more. To confirm which resources are using a specific managed identity, you can check the target services associated with that identity.

1. Open the Azure Resources extension in the VS Code sidebar
1. Select your subscription
1. Locate the Managed Identities section. Here. you'll see all your MIs that you have access to.
1. Select a managed identity then select **Source Resources**.
1. All resources using the managed identity are listed here.

## Confirm managed identity assignment to target resource

Managed identities can be assigned to various Azure resources. You can check the resources to which a managed identity is assigned directly from the Azure Resources extension in Visual Studio Code. This is particularly useful for ensuring that your managed identity is correctly configured for the resources it needs to access.

1. Open the Azure Resources extension in the VS Code sidebar
1. Select your subscription
1. Locate the Managed Identities section. Here. yopu'll see all your MIs that you have access to.
1. Select a managed identity then select **Target Services**.
1. All resources that the managed identity is assigned to are listed here.

## Confirm managed identity permissions to target resources

Permissions are managed through Azure Role-Based Access Control (RBAC), which allows you to assign roles to your managed identity for specific resources.

Follow these steps to confirm the permissions of your managed identity:

1. Open the Azure Resources extension in the VS Code sidebar
1. Select your subscription
1. Locate the Managed Identities section. Here, you'll see all your managed identities that you have access to.
1. Select a managed identity then select **Target Services**. All resources that the managed identity is assigned to will be listed here.
1. Select a target resource to view its permissions
