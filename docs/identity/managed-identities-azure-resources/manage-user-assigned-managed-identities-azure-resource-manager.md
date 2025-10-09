---
title: Manage user-assigned managed identities using Azure Resource Manager
description: Manage user-assigned managed identities using Azure Resource Manager.
author: SHERMANOUKO
manager: CelesteDG
ms.service: entra-id
ms.subservice: managed-identities
ms.topic: how-to
ms.date: 09/09/2025
ms.author: shermanouko
---

# Manage user-assigned managed identities using Azure Resource Manager

[!INCLUDE [introduction-section](./includes/manage-user-assigned-identity-intro.md)]

In this article, you create a user-assigned managed identity by using Azure Resource Manager. You can't list and delete a user-assigned managed identity by using a Resource Manager template. Use the other methods to list or delete a user-assigned managed identity.

## Prerequisites

- If you're unfamiliar with managed identities for Azure resources, check out the [overview section](overview.md). *Be sure to review the [difference between a system-assigned and user-assigned managed identity](overview.md#managed-identity-types)*.
- If you don't already have an Azure account, [sign up for a free account](https://azure.microsoft.com/free/) before you continue.

## Template creation and editing

Resource Manager templates help you deploy new or modified resources defined by an Azure resource group. Several options are available for template editing and deployment, both local and portal-based. You can:

- Use a [custom template from Azure Marketplace](/azure/azure-resource-manager/templates/deploy-portal#deploy-resources-from-custom-template) to create a template from scratch or base it on an existing common or [quickstart template](https://azure.microsoft.com/resources/templates/).
- Derive from an existing resource group by exporting a template. You can export them from either [the original deployment](/azure/azure-resource-manager/management/manage-resource-groups-portal#export-resource-groups-to-templates) or from the [current state of the deployment](/azure/azure-resource-manager/management/manage-resource-groups-portal#export-resource-groups-to-templates).
- Use a local [JSON editor (such as VS Code)](/azure/azure-resource-manager/templates/quickstart-create-templates-use-the-portal), and then upload and deploy by using PowerShell or the Azure CLI.
- Use the Visual Studio [Azure Resource Group project](/azure/azure-resource-manager/templates/create-visual-studio-deployment-project) to create and deploy a template.

## Create a user-assigned managed identity

To create a user-assigned managed identity, your account needs the [Managed Identity Contributor](/azure/role-based-access-control/built-in-roles#managed-identity-contributor) role assignment.

To create a user-assigned managed identity, use the following template. Replace the `<USER ASSIGNED IDENTITY NAME>` value with your own values.

[!INCLUDE [ua-character-limit](~/includes/managed-identity-ua-character-limits.md)]

```json
{
  "$schema": "https://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#",
  "contentVersion": "1.0.0.0",
  "parameters": {
    "resourceName": {
          "type": "string",
          "metadata": {
            "description": "<USER ASSIGNED IDENTITY NAME>"
          }
        }
  },
  "resources": [
    {
      "type": "Microsoft.ManagedIdentity/userAssignedIdentities",
      "name": "[parameters('resourceName')]",
      "apiVersion": "2018-11-30",
      "location": "[resourceGroup().location]"
    }
  ],
  "outputs": {
      "identityName": {
          "type": "string",
          "value": "[parameters('resourceName')]"
      }
  }
}
```
