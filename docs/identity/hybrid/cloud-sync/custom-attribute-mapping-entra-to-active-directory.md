---
title: 'Microsoft Entra directory extensions for provisioning to AD'
description: Learn how directory extensions for users and groups support provisioning from Microsoft Entra ID to Active Directory.
author: dhanyahk
ms.author: dhanyahk
ms.service: entra-id
ms.custom: has-azure-ad-ps-ref, azure-ad-ref-level-one-done, msecd-doc-authoring-1023
ms.topic: concept-article
ms.date: 08/11/2026
ms.subservice: hybrid-cloud-sync
ai-usage: ai-assisted
#customer intent: As a hybrid identity administrator, I want to understand directory extensions so that I can use them when provisioning users and groups to Active Directory.
---

# Directory extensions for provisioning Microsoft Entra ID to Active Directory

You can use directory extensions to extend the schema of users and groups, and then use those attributes for scoping and attribute mapping. If you're looking for directory extensions when provisioning from Active Directory to Microsoft Entra ID, see [Cloud sync directory extensions and custom attribute mapping](custom-attribute-mapping.md).

> [!IMPORTANT]
> Directory extensions for Microsoft Entra Cloud Sync are supported only for applications with the identifier URI `api://<tenantId>/CloudSyncCustomExtensionsApp` and the [Tenant Schema Extension App](../connect/how-to-connect-sync-feature-directory-extensions.md#configuration-changes-in-azure-ad-made-by-the-wizard) created by Microsoft Entra Connect.

For step-by-step examples of extending the schema and then using directory extension attributes with cloud sync provisioning to Active Directory, see [Use directory extensions when provisioning to Active Directory](tutorial-directory-extension-group-provisioning.md). That article covers both users and groups.

## Ways to create directory extensions

You can create directory extensions in Microsoft Entra ID in several different ways. The following table provides links and additional information.

|Method|Description|URL|
|-----|-----|-----|
|Microsoft Graph|Create extensions using Microsoft Graph|[Create extensionProperty](/graph/api/application-post-extensionproperty?view=graph-rest-1.0&tabs=http&preserve-view=true)|
|PowerShell|Create extensions using PowerShell|[New-MgApplicationExtensionProperty](/powershell/module/microsoft.graph.applications/new-mgapplicationextensionproperty)|
|Microsoft Entra Connect|Create extensions using Microsoft Entra Connect|[Create an extension attribute using Microsoft Entra Connect](../../app-provisioning/user-provisioning-sync-attributes-for-mapping.md#create-an-extension-attribute-using-azure-ad-connect)|


## Next step

> [!div class="nextstepaction"]
> [Use directory extensions when provisioning to Active Directory](tutorial-directory-extension-group-provisioning.md)

## Related content

- [Microsoft Entra schema and custom expressions](concept-attributes.md)
- [Microsoft Entra Connect Sync: Directory extensions](../connect/how-to-connect-sync-feature-directory-extensions.md)
- [Scoping filter and attribute mapping - Microsoft Entra ID to Active Directory](how-to-attribute-mapping-entra-to-active-directory.md)
