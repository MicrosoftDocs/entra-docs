---
author: SHERMANOUKO
ms.author: shermanouko
ms.date: 04/24/2024
ms.topic: include
---

In this article, you learn how to enable and remove managed identities for Azure resources for an Azure VM, using an Azure SDK.

## Prerequisites

[!INCLUDE [msi-qs-configure-prereqs](~/includes/entra-msi-qs-configure-prereqs.md)]

## Azure SDKs with managed identities for Azure resources support 

Azure supports multiple programming platforms through a series of [Azure SDKs](https://azure.microsoft.com/downloads). Several of them have been updated to support managed identities for Azure resources, and provide corresponding samples to demonstrate usage. This list is updated as other support is added:

| SDK | Sample |
| --- | ------ | 
| .NET   | [Manage resource from a VM enabled with managed identities for Azure resources enabled](https://github.com/Azure-Samples/aad-dotnet-manage-resources-from-vm-with-msi) |
| Java   | [Manage storage from a VM enabled with managed identities for Azure resources](https://github.com/Azure-Samples/compute-java-manage-resources-from-vm-with-msi-in-aad-group)|
| Node.js| [Create a VM with system-assigned managed identity enabled](https://azure.microsoft.com/resources/samples/compute-node-msi-vm/) |
| Python | [Create a VM with system-assigned managed identity enabled](https://azure.microsoft.com/resources/samples/compute-python-msi-vm/) |
| Ruby   | [Create Azure VM with a system-assigned identity enabled](https://github.com/Azure-Samples/compute-ruby-msi-vm/) |

## Next steps

- See related articles under **Configure Identity for an Azure VM**, to learn how you can also use the Azure portal, PowerShell, CLI, and resource templates.
