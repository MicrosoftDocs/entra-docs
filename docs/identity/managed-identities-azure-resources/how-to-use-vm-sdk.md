---
title: Use managed identities on an Azure VM with Azure SDKs
description: Code samples for using Azure SDKs with an Azure VM that has managed identities for Azure resources.

author: rwike77
manager: CelesteDG

ms.service: entra-id
ms.subservice: managed-identities
ms.topic: how-to
ms.tgt_pltfrm: na
ms.date: 05/23/2023
ms.author: ryanwi

---

# How to use managed identities for Azure resources on an Azure VM with Azure SDKs 

[!INCLUDE [preview-notice](~/includes/entra-msi-preview-notice.md)]  
This article provides a list of SDK samples, which demonstrate use of their respective Azure SDK's support for managed identities for Azure resources.

## Prerequisites

[!INCLUDE [msi-qs-configure-prereqs](~/includes/entra-msi-qs-configure-prereqs.md)]

> [!IMPORTANT]
> - All sample code/script in this article assumes the client is running on a VM with managed identities for Azure resources enabled. Use the VM "Connect" feature in the Azure portal, to remotely connect to your VM. For details on enabling managed identities for Azure resources on a VM, see [Configure managed identities for Azure resources on a VM using the Azure portal](qs-configure-portal-windows-vm.md), or one of the variant articles (using PowerShell, CLI, a template, or an Azure SDK). 

## SDK code samples

| SDK             | Code sample |
| --------------- | ----------- |
| .NET            | [Deploy an Azure Resource Manager template from a Windows VM using managed identities for Azure resources](https://github.com/Azure-Samples/windowsvm-msi-arm-dotnet) |
| .NET Core       | [Call Azure services from a Linux VM using managed identities for Azure resources](https://github.com/Azure-Samples/linuxvm-msi-keyvault-arm-dotnet/) |
| Go              | [Azure identity client module for Go](https://pkg.go.dev/github.com/Azure/azure-sdk-for-go/sdk/azidentity#ManagedIdentityCredential)
| Node.js         | [Manage resources using managed identities for Azure resources](https://github.com/Azure-Samples/resources-node-manage-resources-with-msi) |
| Python          | [Use managed identities for Azure resources to authenticate simply from inside a VM](https://github.com/Azure/azure-sdk-for-python/tree/azure-identity_1.15.0/sdk/identity/azure-identity/) |
| Ruby            | [Manage resources from a VM with managed identities for Azure resources enabled](https://github.com/Azure-Samples/resources-ruby-manage-resources-with-msi/) |

## Next steps

- See [Azure SDKs](https://azure.microsoft.com/downloads/) for the full list of Azure SDK resources, including library downloads, documentation, and more.
- To enable managed identities for Azure resources on an Azure VM, see [Configure managed identities for Azure resources on a VM using the Azure portal](qs-configure-portal-windows-vm.md).
