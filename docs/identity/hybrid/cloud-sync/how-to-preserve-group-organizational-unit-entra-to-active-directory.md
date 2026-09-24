---
layout: Conceptual
title: Preserve a group's organizational unit (Preview)
author: dhanyahk
ms.author: dhanyahk
manager: mwongerapk
ms.reviewer: marshmacy
ms.service: entra-id
ms.subservice: hybrid-cloud-sync
ms.topic: how-to
ms.date: 08/20/2026
description: Set up the GroupDN directory extension so a group keeps its original organizational unit and common name after you convert its Source of Authority to Microsoft Entra ID.
ai-usage: ai-assisted
ms.custom: msecd-doc-authoring-1023
#customer intent: As a hybrid identity administrator, I want to capture a group's distinguished name before I convert its Source of Authority so that the group keeps its original organizational unit and name in Active Directory.
---

# Preserve a group's organizational unit and name when you convert Source of Authority (preview)

When you convert a group's Source of Authority (SOA) to Microsoft Entra ID, the group's original organizational unit (OU) isn't detected automatically. Use the `GroupDN` directory extension to capture the group's distinguished name (DN) before you convert its SOA, then reference that extension in the OU and common name (CN) mapping expressions.

This article covers the one-time setup. Complete it **before** you convert the group to cloud-managed. For the mapping expressions that consume the extension, see [Preserve a group's original organizational unit](how-to-configure-entra-to-active-directory.md#preserve-a-groups-original-organizational-unit).

## Prerequisites

Complete the steps in [Prerequisites for provisioning from Microsoft Entra ID to Active Directory](how-to-prerequisites-provision-entra-to-active-directory.md) before you continue.

## Set up the GroupDN extension

Complete the following tasks in order, before you convert the group to cloud-managed.

### Change the group scope to Universal

To change the group scope to Universal:

1. Open **Active Directory Administrative Center**.
1. Select and hold (or right-click) the group, and then select **Properties**.
1. In the **Group** section, select **Universal** as the group scope.
1. Select **Save**.

### Create the extension

Cloud Sync only supports extensions created on the `CloudSyncCustomExtensionsApp` application. Create this application once per tenant if it doesn't already exist.

# [Graph PowerShell](#tab/ps)

1. Open an elevated PowerShell window and run the following commands to install modules and connect:

    ```powershell
    Install-Module Microsoft.Graph -Scope CurrentUser -Force
    Connect-MgGraph -Scopes "Application.ReadWrite.All","Directory.ReadWrite.All","Directory.AccessAsUser.All"
    ```

1. Check if the application exists. If it doesn't, create it, and ensure a service principal is present:

    ```powershell
    $tenantId = (Get-MgOrganization).Id
    $app = Get-MgApplication -Filter "identifierUris/any(uri:uri eq 'API://$tenantId/CloudSyncCustomExtensionsApp')"
    if (-not $app) {
      $app = New-MgApplication -DisplayName "CloudSyncCustomExtensionsApp" -IdentifierUris "API://$tenantId/CloudSyncCustomExtensionsApp"
    }
    $app

    $sp = Get-MgServicePrincipal -Filter "AppId eq '$($app.AppId)'"
    if (-not $sp) {
      $sp = New-MgServicePrincipal -AppId $app.AppId
    }
    $sp
    ```

1. Add a directory extension property named `GroupDN` — a string attribute on group objects:

    ```powershell
    New-MgApplicationExtensionProperty `
      -ApplicationId $app.Id `
      -Name "GroupDN" `
      -DataType "String" `
      -TargetObjects Group
    ```

# [Graph Explorer](#tab/ge)

1. Check if an application with the identifier URI `API://<tenantId>/CloudSyncCustomExtensionsApp` exists:

    ```http
    GET /applications?$filter=identifierUris/any(uri:uri eq 'api://<tenantId>/CloudSyncCustomExtensionsApp')
    ```

1. If the application doesn't exist, create it:

    ```http
    POST https://graph.microsoft.com/v1.0/applications
    Content-type: application/json

    {
      "displayName": "CloudSyncCustomExtensionsApp",
      "identifierUris": ["api://<tenant id>/CloudSyncCustomExtensionsApp"]
    }
    ```

1. Create the `GroupDN` directory extension (string type, for Group objects):

    ```http
    POST https://graph.microsoft.com/v1.0/applications/<ApplicationId>/extensionProperties
    Content-type: application/json

    {
      "name": "GroupDN",
      "dataType": "String",
      "isMultiValued": false,
      "targetObjects": [ "Group" ]
    }
    ```

---

For more information, see [Directory extensions for provisioning Microsoft Entra ID to Active Directory](custom-attribute-mapping-entra-to-active-directory.md).

### Map distinguishedName to the GroupDN extension

Tell Cloud Sync to populate the extension with the group's distinguished name (DN) from Active Directory. This captures the group's full DN (CN + OU path) in Microsoft Entra ID.

1. Open **Entra ID** > **Entra Connect** > **Cloud Sync**.
1. Select your **AD to Microsoft Entra ID** configuration.
1. Go to **Attribute mappings** and set **Object type** to **Group**.
1. Add a new attribute mapping:
    - **Mapping type**: Direct
    - **Source attribute**: `distinguishedName`
    - **Target attribute**: `extension_<appIdWithoutHyphens>_GroupDN`
1. Save the schema to trigger a sync.

### Verify the mapping and convert SOA

After a sync runs, verify that the extension property is populated with the DN by using Microsoft Graph PowerShell:

```powershell
$groupDisplayName = 'My Security Group'
$clientId = $app.AppId
$propName = "extension_{0}_GroupDN" -f ($clientId -replace "-","")
$grp = Get-MgGroup -Filter "displayName eq '$groupDisplayName'" -ConsistencyLevel eventual
Get-MgGroup -GroupId $grp.Id -Property "id,displayName,$propName" |
  Select-Object id, displayName, @{n=$propName; e={$_."$propName"}}
```

Once the DN is stored in the extension, [convert the group's Source of Authority to Microsoft Entra ID](../how-to-group-source-of-authority-configure.md). The group becomes cloud-managed while its original DN is preserved in the extension for use in the OU and CN mapping expressions that follow.


## Next step

> [!div class="nextstepaction"]
> [Test and enable provisioning](how-to-test-and-enable-provisioning-entra-to-active-directory.md)

## Related content

- [Configure Microsoft Entra ID to Active Directory provisioning](how-to-configure-entra-to-active-directory.md)
- [Directory extensions for provisioning Microsoft Entra ID to Active Directory](custom-attribute-mapping-entra-to-active-directory.md)
- [Use directory extensions when provisioning to Active Directory](tutorial-directory-extension-group-provisioning.md)
- [Configure group Source of Authority](../how-to-group-source-of-authority-configure.md)
