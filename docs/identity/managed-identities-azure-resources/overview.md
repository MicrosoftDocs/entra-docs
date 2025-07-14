---
title: Managed identities for Azure resources
description: An overview of the managed identities for Azure resources.
author: SHERMANOUKO
manager: CelesteDG
ms.assetid: 0232041d-b8f5-4bd2-8d11-27999ad69370
ms.service: entra-id
ms.subservice: managed-identities
ms.topic: overview
ms.date: 12/02/2024
ms.author: shermanouko
ms.reviewer: ryanwi

#Customer intent: As a developer, I'd like to securely manage the credentials that my application uses for authenticating to cloud services without having the credentials in my code or checked into source control.
---

# What are managed identities for Azure resources?

A common challenge for developers is the management of secrets, credentials, certificates, and keys used to secure communication between services. Manual handling of secrets and certificates are a known source of security issues and outages. Managed identities eliminate the need for developers to manage these credentials. Applications can use managed identities to obtain Microsoft Entra tokens without having to manage any credentials.

## What are managed identities?

At a high level, there are two types of identities: human and machine/non-human identities. Machine / non-human identities consist of device and workload identities. In Microsoft Entra, workload identities are applications, service principals, and managed identities. For more information on workload identities, see [workload identities](../../workload-id/workload-identities-overview.md).

A managed identity is an identity that can be assigned to an Azure compute resource (Virtual Machine (VM), Virtual Machine Scale Set (VMSS), Service Fabric Cluster, Azure Kubernetes cluster) or any [App hosting platform supported by Azure](/azure/developer/intro/hosting-apps-on-azure?source=recommendations). Once a managed identity is assigned on the compute resource, it can be authorized, directly or indirectly, to access downstream dependency resources, such as a storage account, SQL database, CosmosDB, and so on. Managed identity replaces secrets such as access keys or passwords. In addition, managed identities can replace certificates or other forms of authentication for service-to-service dependencies.

The following video shows how you can use managed identities:</br>

> [!VIDEO https://learn-video.azurefd.net/vod/player?show=on-net&ep=using-azure-managed-identities]

Here are some of the benefits of using managed identities:

- You don't need to manage credentials. Credentials aren’t even accessible to you.
- You can use managed identities to authenticate to any resource that supports [Microsoft Entra authentication](../authentication/overview-authentication.md), including your own applications.
- Managed identities can be used at no extra cost.

## Managed identity types

There are two types of managed identities:

- **System-assigned**. Some Azure resources, such as virtual machines allow you to enable a managed identity directly on the resource. When you enable a system-assigned managed identity: 
  - A service principal of a special type is created in Microsoft Entra ID for the identity. The service principal is tied to the lifecycle of that Azure resource. When the Azure resource is deleted, Azure automatically deletes the service principal for you.
  - By design, only that Azure resource can use this identity to request tokens from Microsoft Entra ID.
  - You authorize the managed identity to have access to one or more services.
  - The name of the system-assigned service principal is always the same as the name of the Azure resource it's created for. For a deployment slot, the name of its system-assigned managed identity is ```<app-name>/slots/<slot-name>```.

- **User-assigned**. You may also create a managed identity as a standalone Azure resource. You can [create a user-assigned managed identity](./how-manage-user-assigned-managed-identities.md?pivots=identity-mi-methods-azp) and assign it to one or more Azure Resources. When you enable a user-assigned managed identity:

  - A service principal of a special type is created in Microsoft Entra ID for the identity. The service principal is managed separately from the resources that use it. 
  - User-assigned managed identities can be used by multiple resources.
  - You authorize the managed identity to have access to one or more services.

  User-assigned managed identities, which are provisioned independently from compute and can be assigned to multiple compute resources, are the recommended managed identity type for Microsoft services.

Resources that support system assigned managed identities allow you to:

- Enable or disable managed identities at the resource level.
- Use role-based access control (RBAC) to [grant permissions](/azure/role-based-access-control/role-assignments-portal).
- View the create, read, update, and delete (CRUD) operations in [Azure Activity logs](/azure/azure-monitor/essentials/activity-log).
- View sign in activity in Microsoft Entra ID [sign in logs](../monitoring-health/concept-sign-ins.md).

If you choose a user assigned managed identity instead:

- You can [create, read, update, and delete](./how-manage-user-assigned-managed-identities.md?pivots=identity-mi-methods-azp) the identities.
- You can use RBAC role assignments to [grant permissions](/azure/role-based-access-control/role-assignments-portal).
- User assigned managed identities can be used on more than one resource.
- CRUD operations are available for review in [Azure Activity logs](/azure/azure-monitor/essentials/activity-log).
- View sign in activity in Microsoft Entra ID [sign in logs](../monitoring-health/concept-sign-ins.md).

Operations on managed identities can be performed by using an Azure Resource Manager template, the Azure portal, Azure CLI, PowerShell, and REST APIs.

## Differences between system-assigned and user-assigned managed identities

|  Property    | System-assigned managed identity | User-assigned managed identity |
|------|----------------------------------|--------------------------------|
| Creation |  Created as part of an Azure resource (for example, Azure Virtual Machines or Azure App Service). | Created as a stand-alone Azure resource. |
| Life cycle | Shared life cycle with the Azure resource that the managed identity is created with. <br/> When the parent resource is deleted, the managed identity is deleted as well. | Independent life cycle. <br/> Must be explicitly deleted. |
| Sharing across Azure resources | Can’t be shared. <br/> It can only be associated with a single Azure resource. | Can be shared. <br/> The same user-assigned managed identity can be associated with more than one Azure resource. |
| Common use cases | Workloads contained within a single Azure resource. <br/> Workloads needing independent identities. <br/> For example, an application that runs on a single virtual machine. | Workloads that run on multiple resources and can share a single identity. <br/> Workloads needing preauthorization to a secure resource, as part of a provisioning flow. <br/> Workloads where resources are recycled frequently, but permissions should stay consistent. <br/> For example, a workload where multiple virtual machines need to access the same resource. |

## How can I use managed identities for Azure resources?

You can use managed identities by following the steps below: 

1. Create a managed identity in Azure. You can choose between system-assigned managed identity or user-assigned managed identity. 
    1. When using a user-assigned managed identity, you assign the managed identity to the "source" Azure Resource, such as a Virtual Machine, Azure Logic App or an Azure Web App.
1. Authorize the managed identity to have access to the "target" service.
1. Use the managed identity to access a resource. In this step, you can use the Azure SDK with the Azure.Identity library. Some "source" resources offer connectors that know how to use Managed identities for the connections. In that case, you use the identity as a feature of that "source" resource.


## Which Azure services support the feature?

Managed identities for Azure resources can be used to authenticate to services that support Microsoft Entra authentication. For a list of supported Azure services, see [services that support managed identities for Azure resources](./managed-identities-status.md).

## Work with managed identities

Managed identities can be used directly or as a Federated Identity Credential for Microsoft Entra ID applications.

The steps involved in using managed identities are as follows:

1. Create a managed identity in Azure. You can choose between system-assigned managed identity or user-assigned managed identity. When using a user-assigned managed identity, you assign the managed identity to the source Azure Resource, such as a Virtual Machine, Azure Logic App or an Azure Web App.
1. Authorize the managed identity to have access to the target service.
1. Use the managed identity to access a resource. In this step, you can use any of the [client libraries](). Some source resources offer connectors that know how to use Managed identities for the connections. In that case, you use the identity as a feature of that source resource.

### Use managed identity directly

Service code running on your Azure compute resource uses either the Microsoft Authentication Library (MSAL) or Azure.Identity SDK to retrieve a managed identity token from Entra ID backed by the managed identity. This token acquisition doesn't require any secrets and is automatically authenticated based on the environment where the code runs. As long as the managed identity is authorized, the service code can access downstream dependencies that support Entra ID authentication.

For example, you can use an Azure Virtual Machine (VM) as Azure Compute. You can then create a user-assigned managed identity and assign it to the VM. The workload running on the VM interfaces with both Azure.Identity (or MSAL) and Azure Storage client SDKs to access a storage account. The user-assigned managed identity is authorized to access the storage account.

### Use managed identity as a Federated Identity Credential (FIC) on an Entra ID app

Workload Identity Federation enables using a managed identity as a credential, just like certificate or password, on Entra ID Applications. Whenever an Entra ID app is required, this is the recommended way to be credential-free. There's a limit of 20 FICs when using managed identities as FIC on an Entra ID App.

A workload acting in the capacity of Entra ID application can be hosted on any Azure compute which has a managed identity. The workload uses the managed identity to acquire a token to be exchanged for an Entra ID Application token, via workload identity federation. This feature is also referred to as managed identity as FIC (Federated Identity Credentials). For more information, see [configure an application to trust a managed identity](/entra/workload-id/workload-identity-federation-config-app-trust-managed-identity).

## Next steps

- [Developer introduction and guidelines](overview-for-developers.md)
- [Use a VM system-assigned managed identity to access Resource Manager](tutorial-windows-vm-access.md)
- [How to use managed identities for App Service and Azure Functions](/azure/app-service/overview-managed-identity)
- [How to use managed identities with Azure Container Instances](/azure/container-instances/container-instances-managed-identity)
- [Implementing managed identities for Microsoft Azure Resources](https://www.pluralsight.com/courses/microsoft-azure-resources-managed-identities-implementing)
- Use [workload identity federation for managed identities](../../workload-id/workload-identity-federation.md) to access Microsoft Entra protected resources without managing secrets
