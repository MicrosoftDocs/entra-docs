---
title: 'Microsoft Entra Cloud Sync directory extensions for provisioning to Active Directory'
description: This article provides information on directory extensions for provisioning to Active Directory with cloud sync.
author: billmath
manager: femila
ms.service: entra-id
ms.custom: has-azure-ad-ps-ref, azure-ad-ref-level-one-done
ms.topic: conceptual
ms.date: 04/09/2025
ms.subservice: hybrid-cloud-sync
ms.author: billmath
---

# Directory extensions for provisioning Microsoft Entra ID to Active Directory
You can use directory extensions to extend the schema of your groups and then use these attributes for scoping and attribute mapping. You can use the same steps that are outlined in the [cloud sync directory extensions and custom attributes](custom-attribute-mapping.md) doc.

>[!Important]
> Directory extension for Microsoft Entra Cloud Sync is only supported for applications with the identifier URI "api://&LT;tenantId&GT;/CloudSyncCustomExtensionsApp" and the [Tenant Schema Extension App](../connect/how-to-connect-sync-feature-directory-extensions.md#configuration-changes-in-azure-ad-made-by-the-wizard) created by Microsoft Entra Connect 

For a step-by-step tutorial on how to extend the schema and then use the directory extension attribute with cloud sync provisioning to AD, see [Scenario - Using directory extensions with group provisioning to Active Directory](tutorial-directory-extension-group-provisioning.md).

## Ways to create directory extensions
You can create directory extensions in Microsoft Entra ID in several different ways.   The following table provides links and additional information.

|Method|Description|URL|
|-----|-----|-----|
|MS Graph|Create extensions using GRAPH|[Create extensionProperty](/graph/api/application-post-extensionproperty?view=graph-rest-1.0&tabs=http&preserve-view=true)|
|PowerShell|Create extensions using PowerShell|[New-MgApplicationExtensionProperty](/powershell/module/microsoft.graph.applications/new-mgapplicationextensionproperty)| 
Using cloud sync and Microsoft Entra Connect|Create extensions using Microsoft Entra Connect|[Create an extension attribute using Microsoft Entra Connect](../../app-provisioning/user-provisioning-sync-attributes-for-mapping.md#create-an-extension-attribute-using-azure-ad-connect)|


## Additional resources

- [Microsoft Entra schema and custom expressions](concept-attributes.md)
- [Microsoft Entra Connect Sync: Directory extensions](../connect/how-to-connect-sync-feature-directory-extensions.md)
- [Attribute mapping in Microsoft Entra Cloud Sync](how-to-attribute-mapping.md)
