---
author: SHERMANOUKO
ms.author: shermanouko
ms.date: 09/09/2025
ms.topic: include
ms.service: entra-id
ms.subservice: managed-identities
---

Managed identities for Azure resources provide Azure services with an identity in Microsoft Entra ID. They work without needing credentials in your code. Azure services use this identity to authenticate to services that support Microsoft Entra authentication. Application roles provide a form of role-based access control, and allow a service to implement authorization rules.

> [!NOTE]
> The tokens your application receives are cached by the underlying infrastructure. This means that any changes to the managed identity's roles can take significant time to process. For more information, see [Limitation of using managed identities for authorization](../managed-identity-best-practice-recommendations.md#limitation-of-using-managed-identities-for-authorization).

In this article, you'll learn how to assign a managed identity to an application role exposed by another application using the [Microsoft Graph PowerShell SDK](/powershell/microsoftgraph/overview) or [Azure CLI](/cli/azure/what-is-azure-cli).
