---
title: Assign a managed identity to an application role
description: Step-by-step instructions for assigning a managed identity access to another application's role.

author: barclayn
manager: amycolannino

ms.service: entra-id
ms.subservice: managed-identities
ms.topic: how-to
ms.tgt_pltfrm: na
ms.date: 06/05/2024
ms.author: barclayn
ms.custom: has-azure-ad-ps-ref, devx-track-azurepowershell, devx-track-azurecli

appliesto:
zone_pivot_groups: identity-mi-app-role
---

# Assign a managed identity access to an application role

Managed identities for Azure resources provide Azure services with an identity in Microsoft Entra ID. They work without needing credentials in your code. Azure services use this identity to authenticate to services that support Microsoft Entra authentication. Application roles provide a form of role-based access control, and allow a service to implement authorization rules.

> [!NOTE]
> The tokens your application receives are cached by the underlying infrastructure. This means that any changes to the managed identity's roles can take significant time to process. For more information, see [Limitation of using managed identities for authorization](managed-identity-best-practice-recommendations.md#limitation-of-using-managed-identities-for-authorization).

In this article, you'll learn how to assign a managed identity to an application role exposed by another application using the [Microsoft Graph PowerShell SDK](/powershell/microsoftgraph/overview).

## Prerequisites

- If you're unfamiliar with managed identities for Azure resources, see [Managed identity for Azure resources overview](~/identity/managed-identities-azure-resources/overview.md). 
- Review the [difference between a system-assigned and user-assigned managed identity](/azure/logic-apps/authenticate-with-managed-identity).
- If you don't already have an Azure account, [sign up for a free account](https://azure.microsoft.com/free/) before continuing.

::: zone pivot="identity-mi-app-role-powershell"
[!INCLUDE [how-to-assign-app-role-managed-identity-powershell](includes/how-to-assign-app-role-managed-identity-powershell.md)]
::: zone-end

::: zone pivot="identity-mi-app-role-cli"
[!INCLUDE [how-to-assign-app-role-managed-identity-cli](includes/how-to-assign-app-role-managed-identity-cli.md)]
::: zone-end

## Next steps

- [Managed identity for Azure resources overview](~/identity/managed-identities-azure-resources/overview.md)
- To enable managed identity on an Azure VM, see [Configure managed identities for Azure resources on an Azure VM](~/identity/managed-identities-azure-resources/how-to-configure-managed-identities.md).
