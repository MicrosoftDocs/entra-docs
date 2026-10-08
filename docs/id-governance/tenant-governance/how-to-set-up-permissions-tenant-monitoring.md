---
title: Configure configuration management service permissions
titleSuffix: Microsoft Entra ID Governance
description: Learn how to assign or remove the application permissions and roles that the Tenant Configuration Management service uses to create snapshots and run monitors
ms.topic: how-to
ms.date: 07/28/2026
---

<!-- source: Tenant Governance - Configure configuration management service permissions how-to.docx -->

# Configure configuration management service permissions

Use the **Configuration management permissions** page to assign or remove permissions for the Tenant Configuration Management service. The service uses these permissions to create snapshots and run monitors.

Configure service permissions before you create snapshots or monitors that include the corresponding workload resources. Missing service permissions can cause a snapshot to be incomplete or a monitor run to fail.

When you create a monitor or snapshot, the **Permissions** step shows whether the service has the least-privilege permissions for the resource types you selected. This step is read-only. If the wizard shows that required least-privilege permissions are missing, use the **Configuration management permissions** page to add them.

## Prerequisites

- A Microsoft Entra role that can assign or remove app-only permissions for service principals in your tenant, such as [Global Administrator](~/identity/role-based-access-control/permissions-reference.md#global-administrator) or [Privileged Role Administrator](~/identity/role-based-access-control/permissions-reference.md#privileged-role-administrator). To see which roles can perform this task, see the [Microsoft Entra built-in roles reference](~/identity/role-based-access-control/permissions-reference.md).

## Open Configuration management permissions

To open the permissions page, follow these steps:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com).
1. Browse to **Tenant Governance** > **Configuration management permissions**.

## Assign permissions

Assign permissions based on the workloads that contain the resources you want to snapshot or monitor:

- **Microsoft Entra ID or Intune resources**: On the **Application permissions** tab, add the app-only permissions for the relevant Microsoft Graph resources.

  - For the permissions required to snapshot or monitor Microsoft Entra resources, see [Supported Microsoft Entra resources for Tenant Configuration Management](/graph/utcm-entra-resources).
  - For the permissions required to snapshot or monitor Intune resources, see [Supported Microsoft Intune resources for Tenant Configuration Management](/graph/utcm-intune-resources).

- **Teams resources**: On the **Entra roles** tab, assign the **Teams Reader** Microsoft Entra role.

- **Exchange Online resources**: On the **Application permissions** tab, assign **Exchange.ManageAsApp**. Then use Exchange Online PowerShell to assign Exchange roles to the Tenant Configuration Management service principal. For the steps, see [App-only authentication in Exchange Online PowerShell and Security & Compliance PowerShell](/powershell/exchange/app-only-auth-powershell-v2#step-2-assign-api-permissions-to-the-application).

  For the permissions required to snapshot or monitor Exchange resources, see [Supported Microsoft Exchange resources for Tenant Configuration Management](/graph/utcm-exchange-resources).

- **Defender or Purview resources**: On the **Application permissions** tab, assign **Exchange.ManageAsApp**. Then use Security & Compliance PowerShell to assign Security and Compliance (Defender and Purview) roles to the Tenant Configuration Management service principal. For the steps, see [Connect to Security & Compliance PowerShell](/powershell/exchange/connect-to-scc-powershell).

  For the permissions required to snapshot or monitor Defender or Purview resources, see [Supported Microsoft Security and Compliance resources for Tenant Configuration Management](/graph/utcm-securityandcompliance-resources).

> [!NOTE]
> The **Configuration management permissions** page doesn't show workload permissions that are assigned to the service within Exchange Online, Defender, or Purview. Use Exchange Online PowerShell or Security & Compliance PowerShell to assign and remove those permissions.

## Remove permissions

To remove a permission or a Microsoft Entra role, select the checkbox next to its name, and then select **Remove** in the command bar.

## Related content

- [Configuration management](configuration-management.md)
- [Set up authentication for Tenant Configuration Management APIs](/graph/utcm-authentication-setup)
- [Exchange Online RBAC for applications](/exchange/permissions-exo/application-rbac)
- [Microsoft Defender unified role-based access control (RBAC)](/defender-xdr/manage-rbac)
- [Microsoft Purview permissions](/purview/purview-permissions)
- [Use Microsoft Teams administrator roles to manage Teams](/microsoftteams/using-admin-roles)
- [Role-based access control (RBAC) with Microsoft Intune](/intune/fundamentals/role-based-access-control/overview)
