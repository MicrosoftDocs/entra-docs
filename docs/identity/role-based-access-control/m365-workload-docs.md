---
title: Roles across Microsoft services
description: Find content, API references, and audit and monitoring references related to role-based access control (RBAC) for Microsoft 365 and other services
author: rolyon
manager: femila
ms.service: entra-id
ms.subservice: role-based-access-control
ms.topic: reference
ms.date: 08/31/2024
ms.author: rolyon
ms.reviewer: vincesm
ms.custom: it-pro, sfi-ga-nochange
#Customer intent: As a Microsoft Entra administrator, to delegate permissions across Microsoft 365 services quickly and accurately I want to know where the content is for admin roles.
---

# Roles across Microsoft services

Services in Microsoft 365 can be managed with administrative roles in Microsoft Entra ID. Some services also provide additional roles that are specific to that service. This article lists content, API references, and audit and monitoring references related to role-based access control (RBAC) for Microsoft 365 and other services.

## Microsoft Entra

Microsoft Entra ID and related services in Microsoft Entra.

### Microsoft Entra ID

> [!div class="mx-tableFixed"]
> | Area | Content |
> | --- | --- |
> | Overview | [Microsoft Entra built-in roles](permissions-reference.md) |
> | Management API reference | **Microsoft Entra roles**<br/>[Microsoft Graph v1.0 roleManagement API](/graph/api/resources/rolemanagement)<br/>• Use `directory` provider<br/>• When role is assigned to a group, manage group memberships with the [Microsoft Graph v1.0 groups API](/graph/api/resources/groups-overview) |
> | Audit and monitoring reference | **Microsoft Entra roles**<br/>[Microsoft Entra activity log overview](/entra/identity/monitoring-health/howto-access-activity-logs)<br/>API access to Microsoft Entra audit logs:<br/>• [Microsoft Graph v1.0 directoryAudit API](/graph/api/resources/directoryaudit)<br/>• Audits with `RoleManagement` category<br/>• When a role is assigned to a group, to audit changes to group memberships, see audits with category `GroupManagement` and activities `Add member to group` and `Remove member from group` |

### Entitlement management

> [!div class="mx-tableFixed"]
> | Area | Content |
> | --- | --- |
> | Overview | [Entitlement management roles](/entra/id-governance/entitlement-management-delegate#entitlement-management-roles) |
> | Management API reference | **Entitlement Management-specific roles in Microsoft Entra ID**<br/>[Microsoft Graph v1.0 roleManagement API](/graph/api/resources/rolemanagement)<br/>• Use `directory` provider<br/>• See roles with permissions starting with: `microsoft.directory/entitlementManagement`<br/><br/>**Entitlement Management-specific roles**<br/>[Microsoft Graph v1.0 roleManagement API](/graph/api/resources/rolemanagement)<br/>• Use `entitlementManagement` provider |
> | Audit and monitoring reference | **Entitlement Management-specific roles in Microsoft Entra ID**<br/>[Microsoft Entra activity log overview](/entra/identity/monitoring-health/howto-access-activity-logs)<br/>API access to Microsoft Entra audit logs:<br/>• [Microsoft Graph v1.0 directoryAudit API](/graph/api/resources/directoryaudit)<br/>• Audits with `RoleManagement` category<br/><br/>**Entitlement Management-specific roles**<br/>In Microsoft Entra audit log, with category `EntitlementManagement` and Activity is one of:<br/>• `Remove Entitlement Management role assignment`<br/>• `Add Entitlement Management role assignment` |

## Microsoft 365

Services in the Microsoft 365 suite.

### Exchange

> [!div class="mx-tableFixed"]
> | Area | Content |
> | --- | --- |
> | Overview | [Permissions in Exchange Online](/exchange/permissions-exo/permissions-exo) |
> | Management API reference | **Exchange-specific roles in Microsoft Entra ID**<br/>[Microsoft Graph v1.0 roleManagement API](/graph/api/resources/rolemanagement)<br/>• Use `directory` provider<br/>• Roles with permissions starting with: `microsoft.office365.exchange`<br/><br/>**Exchange-specific roles**<br/>[Microsoft Graph Beta roleManagement API](/graph/api/resources/rolemanagement?view=graph-rest-beta&preserve-view=true)<br/>• Use `exchange` provider |
> | Audit and monitoring reference | **Exchange-specific roles in Microsoft Entra ID**<br/>[Microsoft Entra activity log overview](/entra/identity/monitoring-health/howto-access-activity-logs)<br/>API access to Microsoft Entra audit logs:<br/>• [Microsoft Graph v1.0 directoryAudit API](/graph/api/resources/directoryaudit)<br/>• Audits with `RoleManagement` category<br/><br/>**Exchange-specific roles**<br/>Use the [Microsoft Graph Beta Security API](/graph/api/resources/security-api-overview?view=graph-rest-beta&preserve-view=true#audit-logs-query-preview) ([audit log query](/graph/api/resources/security-auditlogquery)) and list audit events where recordType == `ExchangeAdmin` and Operation is one of:<br/>`Add-RoleGroupMember`, `Remove-RoleGroupMember`, `Update-RoleGroupMember`, `New-RoleGroup`, `Remove-RoleGroup`, `New-ManagementRole`, `Remove-ManagementRoleEntry`, `New-ManagementRoleAssignment` |

### SharePoint

Includes SharePoint, OneDrive, Delve, Lists, Project Online, and Loop.

> [!div class="mx-tableFixed"]
> | Area | Content |
> | --- | --- |
> | Overview | [About the SharePoint Administrator role in Microsoft 365](/sharepoint/sharepoint-admin-role)<br/>[Delve for admins](/sharepoint/delve-for-office-365-admins)<br/>[Control settings for Microsoft Lists](/sharepoint/control-lists)<br/>[Change permission management in Project Online](/projectonline/change-permission-management-in-project-online) |
> | Management API reference | **SharePoint-specific roles in Microsoft Entra ID**<br/>[Microsoft Graph v1.0 roleManagement API](/graph/api/resources/rolemanagement)<br/>• Use `directory` provider<br/>• Roles with permissions starting with: `microsoft.office365.sharepoint` |
> | Audit and monitoring reference | **SharePoint-specific roles in Microsoft Entra ID**<br/>[Microsoft Entra activity log overview](/entra/identity/monitoring-health/howto-access-activity-logs)<br/>API access to Microsoft Entra audit logs:<br/>• [Microsoft Graph v1.0 directoryAudit API](/graph/api/resources/directoryaudit)<br/>• Audits with `RoleManagement` category |

### Intune

> [!div class="mx-tableFixed"]
> | Area | Content |
> | --- | --- |
> | Overview | [Role-based access control (RBAC) with Microsoft Intune](/mem/intune/fundamentals/role-based-access-control) |
> | Management API reference | **Intune-specific roles in Microsoft Entra ID**<br/>[Microsoft Graph v1.0 roleManagement API](/graph/api/resources/rolemanagement)<br/>• Use `directory` provider<br/>• Roles with permissions starting with: `microsoft.intune`<br/><br/>**Intune-specific roles**<br/>[Microsoft Graph Beta roleManagement API](/graph/api/resources/rolemanagement?view=graph-rest-beta&preserve-view=true)<br/>• Use `deviceManagement` provider<br/>• Alternatively, use Intune-specific [Microsoft Graph Beta RBAC management API](/graph/api/resources/intune-rbac-conceptual?view=graph-rest-beta&preserve-view=true) |
> | Audit and monitoring reference | **Intune-specific roles in Microsoft Entra ID**<br/>[Microsoft Graph v1.0 directoryAudit API](/graph/api/resources/directoryaudit)<br/>• `RoleManagement` category<br/><br/>**Intune-specific roles**<br/>[Intune auditing overview](/mem/intune/fundamentals/monitor-audit-logs)<br/>API access to Intune-specific audit logs:<br/>• [Microsoft Graph Beta getAuditActivityTypes API](/graph/api/intune-auditing-auditevent-getauditactivitytypes?view=graph-rest-beta&preserve-view=true)<br/>• First list activity types where category=`Role`, then use [Microsoft Graph Beta auditEvents API](/graph/api/intune-auditing-auditevent-list?view=graph-rest-beta&preserve-view=true) to list all auditEvents for each activity type |

### Teams

Includes Teams, Bookings, Copilot Studio for Teams, and Shifts.

> [!div class="mx-tableFixed"]
> | Area | Content |
> | --- | --- |
> | Overview | [Use Microsoft Teams administrator roles to manage Teams](/microsoftteams/using-admin-roles) |
> | Management API reference | **Teams-specific roles in Microsoft Entra ID**<br/>[Microsoft Graph v1.0 roleManagement API](/graph/api/resources/rolemanagement)<br/>• Use `directory` provider<br/>• Roles with permissions starting with: `microsoft.teams` |
> | Audit and monitoring reference | **Teams-specific roles in Microsoft Entra ID**<br/>[Microsoft Entra activity log overview](/entra/identity/monitoring-health/howto-access-activity-logs)<br/>API access to Microsoft Entra audit logs:<br/>• [Microsoft Graph v1.0 directoryAudit API](/graph/api/resources/directoryaudit)<br/>• Audits with `RoleManagement` category |

### Purview suite

Includes Purview suite, Azure Information Protection, and Information Barriers.

> [!div class="mx-tableFixed"]
> | Area | Content |
> | --- | --- |
> | Overview | [Roles and role groups in Microsoft Defender for Office 365 and Microsoft Purview](/defender-office-365/scc-permissions) |
> | Management API reference | **Purview-specific roles in Microsoft Entra ID**<br/>[Microsoft Graph v1.0 roleManagement API](/graph/api/resources/rolemanagement)<br/>• Use `directory` provider<br/>• See roles with permissions starting with:<br/>`microsoft.office365.complianceManager`<br/>`microsoft.office365.protectionCenter`<br/>`microsoft.office365.securityComplianceCenter`<br/><br/>**Purview-specific roles**<br/>Use PowerShell: [Security & Compliance PowerShell](/powershell/exchange/scc-powershell). Specific cmdlets are:<br/>[Get-RoleGroup](/powershell/module/exchange/get-rolegroup)<br/>[Get-RoleGroupMember](/powershell/module/exchange/get-rolegroupmember)<br/>[New-RoleGroup](/powershell/module/exchange/new-rolegroup)<br/>[Add-RoleGroupMember](/powershell/module/exchange/add-rolegroupmember)<br/>[Update-RoleGroupMember](/powershell/module/exchange/update-rolegroupmember)<br/>[Remove-RoleGroupMember](/powershell/module/exchange/remove-rolegroupmember)<br/>[Remove-RoleGroup](/powershell/module/exchange/remove-rolegroup) |
> | Audit and monitoring reference | **Purview-specific roles in Microsoft Entra ID**<br/>[Microsoft Entra activity log overview](/entra/identity/monitoring-health/howto-access-activity-logs)<br/>API access to Microsoft Entra audit logs:<br/>• [Microsoft Graph v1.0 directoryAudit API](/graph/api/resources/directoryaudit)<br/>• Audits with `RoleManagement` category<br/><br/>**Purview-specific roles**<br/>Use the [Microsoft Graph Beta Security API](/graph/api/resources/security-api-overview?view=graph-rest-beta&preserve-view=true#audit-logs-query-preview) ([audit log query Beta](/graph/api/resources/security-auditlogquery?view=graph-rest-beta&preserve-view=true)) and list audit events where recordType == `SecurityComplianceRBAC` and Operation is one of `Add-RoleGroupMember`, `Remove-RoleGroupMember`, `Update-RoleGroupMember`, `New-RoleGroup`, `Remove-RoleGroup` |

### Power Platform

Includes Power Platform, Dynamics 365, Flow, and Dataverse for Teams.

> [!div class="mx-tableFixed"]
> | Area | Content |
> | --- | --- |
> | Overview | [Use service admin roles to manage your tenant](/power-platform/admin/use-service-admin-role-manage-tenant)<br/>[Security roles and privileges](/power-platform/admin/security-roles-privileges) |
> | Management API reference | **Power Platform-specific roles in Microsoft Entra ID**<br/>[Microsoft Graph v1.0 roleManagement API](/graph/api/resources/rolemanagement)<br/>• Use `directory` provider<br/>• See roles with permissions starting with:<br/>`microsoft.powerApps`<br/>`microsoft.dynamics365`<br/>`microsoft.flow`<br/><br/>**Dataverse-specific roles**<br/>[Perform operations using the Web API](/power-apps/developer/data-platform/webapi/perform-operations-web-api)<br/>• Query the [User (SystemUser) table/entity reference](/power-apps/developer/data-platform/reference/entities/systemuser)<br/>• Role assignments are part of the [systemuserroles_association](/power-apps/developer/data-platform/reference/entities/systemuser#BKMK_systemuserroles_association) tables |
> | Audit and monitoring reference | **Power Platform-specific roles in Microsoft Entra ID**<br/>[Microsoft Entra activity log overview](/entra/identity/monitoring-health/howto-access-activity-logs)<br/>API access to Microsoft Entra audit logs:<br/>• [Microsoft Graph v1.0 directoryAudit API](/graph/api/resources/directoryaudit)<br/>• Audits with `RoleManagement` category<br/><br/>**Dataverse-specific roles**<br/>[Dataverse auditing overview](/power-platform/admin/manage-dataverse-auditing)<br/>API to access dataverse-specific audit logs<br/>[Dataverse Web API](/power-apps/developer/data-platform/webapi/perform-operations-web-api)<br/>• [Audit table reference](/power-apps/developer/data-platform/reference/entities/audit)<br/>• Audits with [action codes](/power-apps/developer/data-platform/reference/entities/audit#action-choicesoptions):<br/>53 – Assign Role To Team<br/>54 – Remove Role From Team<br/>55 – Assign Role To User<br/>56 – Remove Role From User<br/>57 – Add Privileges to Role<br/>58 – Remove Privileges From Role<br/>59 – Replace Privileges In Role |

### Defender suite

Includes Defender suite, Secure Score, Cloud App Security, and Threat Intelligence.

> [!div class="mx-tableFixed"]
> | Area | Content |
> | --- | --- |
> | Overview | [Microsoft Defender XDR Unified role-based access control (RBAC)](/defender-xdr/manage-rbac) |
> | Management API reference | **Defender-specific roles in Microsoft Entra ID**<br/>[Microsoft Graph v1.0 roleManagement API](/graph/api/resources/rolemanagement)<br/>• Use `directory` provider<br/>• The following roles have permissions ([reference](/microsoft-365/security/defender/m365d-permissions)): Security Administrator, Security Operator, Security Reader, Global Administrator, and Global Reader<br/><br/>**Defender-specific roles**<br/>Workloads must be activated to use Defender unified RBAC. See [Activate Microsoft Defender XDR Unified role-based access control (RBAC)](/microsoft-365/security/defender/activate-defender-rbac). Activating defender Unified RBAC will turn off individual Defender solution roles.<br/>• Can only be managed via security.microsoft.com portal. |
> | Audit and monitoring reference | **Defender-specific roles in Microsoft Entra ID**<br/>[Microsoft Entra activity log overview](/entra/identity/monitoring-health/howto-access-activity-logs)<br/>API access to Microsoft Entra audit logs:<br/>• [Microsoft Graph v1.0 directoryAudit API](/graph/api/resources/directoryaudit)<br/>• Audits with `RoleManagement` category |

### Viva Engage

> [!div class="mx-tableFixed"]
> | Area | Content |
> | --- | --- |
> | Overview | [Manage administrator roles in Viva Engage](/viva/engage/eac-key-admin-roles-permissions) |
> | Management API reference | **Viva Engage-specific roles in Microsoft Entra ID**<br/>[Microsoft Graph v1.0 roleManagement API](/graph/api/resources/rolemanagement)<br/>• Use `directory` provider<br/>• See roles with permissions starting with `microsoft.office365.yammer`.<br/><br/>**Viva Engage-specific roles**<br/>• Verified admin and Network admin roles can be managed via the Yammer admin center.<br/>• Corporate communicator role can be assigned via the Viva Engage admin center.<br/>• [Yammer Data Export API](/rest/api/yammer/network-data-export) can be used to export admins.csv to read the list of admins |
> | Audit and monitoring reference | **Viva Engage-specific roles in Microsoft Entra ID**<br/>[Microsoft Entra activity log overview](/entra/identity/monitoring-health/howto-access-activity-logs)<br/>API access to Microsoft Entra audit logs:<br/>• [Microsoft Graph v1.0 directoryAudit API](/graph/api/resources/directoryaudit)<br/>• Audits with `RoleManagement` category<br/><br/>**Viva Engage-specific roles**<br/>• Use [Yammer Data Export API](/rest/api/yammer/network-data-export) to incrementally export admins.csv for a list of admins |

### Viva Connections

> [!div class="mx-tableFixed"]
> | Area | Content |
> | --- | --- |
> | Overview | [Admin roles and tasks in Microsoft Viva](/viva/microsoft-viva-admin-roles#viva-connections) |
> | Management API reference | **Viva Connections-specific roles in Microsoft Entra ID**<br/>[Microsoft Graph v1.0 roleManagement API](/graph/api/resources/rolemanagement)<br/>• Use `directory` provider<br/>• The following roles have permissions: SharePoint Administrator, Teams Administrator, and Global Administrator |
> | Audit and monitoring reference | **Viva Connections-specific roles in Microsoft Entra ID**<br/>[Microsoft Entra activity log overview](/entra/identity/monitoring-health/howto-access-activity-logs)<br/>API access to Microsoft Entra audit logs:<br/>• [Microsoft Graph v1.0 directoryAudit API](/graph/api/resources/directoryaudit)<br/>• Audits with `RoleManagement` category |

### Viva Learning

> [!div class="mx-tableFixed"]
> | Area | Content |
> | --- | --- |
> | Overview | [Set up Microsoft Viva Learning in the Teams admin center](/viva/learning/set-up-viva-learning#admin-roles-and-permissions) |
> | Management API reference | **Viva Learning-specific roles in Microsoft Entra ID**<br/>[Microsoft Graph v1.0 roleManagement API](/graph/api/resources/rolemanagement)<br/>• Use `directory` provider<br/>• See roles with permissions starting with `microsoft.office365.knowledge` |
> | Audit and monitoring reference | **Viva Learning-specific roles in Microsoft Entra ID**<br/>[Microsoft Entra activity log overview](/entra/identity/monitoring-health/howto-access-activity-logs)<br/>API access to Microsoft Entra audit logs:<br/>• [Microsoft Graph v1.0 directoryAudit API](/graph/api/resources/directoryaudit)<br/>• Audits with `RoleManagement` category |

### Viva Insights

> [!div class="mx-tableFixed"]
> | Area | Content |
> | --- | --- |
> | Overview | [Roles in Viva Insights](/viva/insights/advanced/setup-maint/user-roles) |
> | Management API reference | **Viva Insights-specific roles in Microsoft Entra ID**<br/>[Microsoft Graph v1.0 roleManagement API](/graph/api/resources/rolemanagement)<br/>• Use `directory` provider<br/>• See roles with permissions starting with `microsoft.office365.insights` |
> | Audit and monitoring reference | **Viva Insights-specific roles in Microsoft Entra ID**<br/>[Microsoft Entra activity log overview](/entra/identity/monitoring-health/howto-access-activity-logs)<br/>API access to Microsoft Entra audit logs:<br/>• [Microsoft Graph v1.0 directoryAudit API](/graph/api/resources/directoryaudit)<br/>• Audits with `RoleManagement` category |

### Search

> [!div class="mx-tableFixed"]
> | Area | Content |
> | --- | --- |
> | Overview | [Set up Microsoft Search](/microsoftsearch/setup-microsoft-search) |
> | Management API reference | **Search-specific roles in Microsoft Entra ID**<br/>[Microsoft Graph v1.0 roleManagement API](/graph/api/resources/rolemanagement)<br/>• Use `directory` provider<br/>• See roles with permissions starting with `microsoft.office365.search` |
> | Audit and monitoring reference | **Search-specific roles in Microsoft Entra ID**<br/>[Microsoft Entra activity log overview](/entra/identity/monitoring-health/howto-access-activity-logs)<br/>API access to Microsoft Entra audit logs:<br/>• [Microsoft Graph v1.0 directoryAudit API](/graph/api/resources/directoryaudit)<br/>• Audits with `RoleManagement` category |

### Universal Print

> [!div class="mx-tableFixed"]
> | Area | Content |
> | --- | --- |
> | Overview | [Universal Print Administrator Roles](/universal-print/fundamentals/universal-print-administrator-roles) |
> | Management API reference | **Universal Print-specific roles in Microsoft Entra ID**<br/>[Microsoft Graph v1.0 roleManagement API](/graph/api/resources/rolemanagement)<br/>• Use `directory` provider<br/>• See roles with permissions starting with `microsoft.azure.print` |
> | Audit and monitoring reference | **Universal Print-specific roles in Microsoft Entra ID**<br/>[Microsoft Entra activity log overview](/entra/identity/monitoring-health/howto-access-activity-logs)<br/>API access to Microsoft Entra audit logs:<br/>• [Microsoft Graph v1.0 directoryAudit API](/graph/api/resources/directoryaudit)<br/>• Audits with `RoleManagement` category |

### Microsoft 365 Apps suite management

Includes Microsoft 365 Apps suite management and Forms.

> [!div class="mx-tableFixed"]
> | Area | Content |
> | --- | --- |
> | Overview | [Overview of the Microsoft 365 Apps admin center](/microsoft-365-apps/admin-center/overview)<br/>[Administrator settings for Microsoft Forms](/microsoft-forms/administrator-settings-microsoft-forms) |
> | Management API reference | **Microsoft 365 Apps-specific roles in Microsoft Entra ID**<br/>[Microsoft Graph v1.0 roleManagement API](/graph/api/resources/rolemanagement)<br/>• Use `directory` provider<br/>• The following roles have permissions: Office Apps Administrator, Security Administrator, Global Administrator |
> | Audit and monitoring reference | **Microsoft 365 Apps-specific roles in Microsoft Entra ID**<br/>[Microsoft Entra activity log overview](/entra/identity/monitoring-health/howto-access-activity-logs)<br/>API access to Microsoft Entra audit logs:<br/>• [Microsoft Graph v1.0 directoryAudit API](/graph/api/resources/directoryaudit)<br/>• Audits with `RoleManagement` category |

## Azure

Azure role-based access control (Azure RBAC) for the Azure control plane and subscription information.

### Azure

Includes Azure and Sentinel.

> [!div class="mx-tableFixed"]
> | Area | Content |
> | --- | --- |
> | Overview | [What is Azure role-based access control (Azure RBAC)?](/azure/role-based-access-control/overview)<br/>[Roles and permissions in Microsoft Sentinel](/azure/sentinel/roles) |
> | Management API reference | **Azure service-specific roles in Azure**<br/>[Azure Resource Manager Authorization API](/rest/api/authorization)<br/>• Role assignment: [List](/azure/role-based-access-control/role-assignments-list-rest), [Create/Update](/azure/role-based-access-control/role-assignments-rest), [Delete](/azure/role-based-access-control/role-assignments-remove#rest-api)<br/>• Role definition: [List](/rest/api/authorization/role-definitions/list), [Create/Update](/rest/api/authorization/role-definitions/create-or-update), [Delete](/rest/api/authorization/role-definitions/delete)<br/><br/>• There is a legacy method to grant access to Azure resources called [classic administrators](/azure/role-based-access-control/classic-administrators). Classic administrators are equivalent to the Owner role in Azure RBAC. Classic administrators will be retired in August 2024.<br/>• Note that an Microsoft Entra Global Administrator can gain unilateral access to Azure via [elevate access](/azure/role-based-access-control/elevate-access-global-admin). |
> | Audit and monitoring reference | **Azure service-specific roles in Azure**<br/>[Monitor Azure RBAC changes in the Azure Activity Log](/azure/role-based-access-control/change-history-report)<br/>• [Azure Activity Log API](/rest/api/monitor/activity-logs/list)<br/>• Audits with Event Category `Administrative` and Operation `Create role assignment`, `Delete role assignment`, `Create or update custom role definition`, `Delete custom role definition`.<br/><br/>[View Elevate Access logs in the tenant level Azure Activity Log](/azure/role-based-access-control/elevate-access-global-admin#view-elevate-access-log-entries-in-the-directory-activity-logs)<br/>• [Azure Activity Log API – Tenant Activity Logs](/rest/api/monitor/tenant-activity-logs/list)<br/>• Audits with Event Category `Administrative` and containing string `elevateAccess`.<br/>• Access to tenant level activity logs requires using [elevate access](/azure/role-based-access-control/elevate-access-global-admin) at least once to gain tenant level access. |

## Commerce

Services related to purchasing and billing.

### Cost Management and Billing – Enterprise Agreements

> [!div class="mx-tableFixed"]
> | Area | Content |
> | --- | --- |
> | Overview | [Managing Azure Enterprise Agreement roles](/azure/cost-management-billing/manage/understand-ea-roles) |
> | Management API reference | **Enterprise Agreements-specific roles in Microsoft Entra ID**<br/>Enterprise Agreements does not support Microsoft Entra roles.<br/><br/>**Enterprise Agreements-specific roles**<br/>[Billing Role Assignments API](/rest/api/billing/role-assignments)<br/>• Enterprise Administrator (Role ID: 9f1983cb-2574-400c-87e9-34cf8e2280db)<br/>• Enterprise Administrator (read only) (Role ID: 24f8edb6-1668-4659-b5e2-40bb5f3a7d7e)<br/>• EA Purchaser (Role ID: da6647fb-7651-49ee-be91-c43c4877f0c4)<br/>[Enrollment Department Role Assignments API](/rest/api/billing/enrollment-department-role-assignments)<br/>• Department Admin (Role ID: fb2cf67f-be5b-42e7-8025-4683c668f840)<br/>• Department Reader (Role ID: db609904-a47f-4794-9be8-9bd86fbffd8a)<br/>[Enrollment Account Role Assignments API](/rest/api/billing/enrollment-account-role-assignments)<br/>• Account Owner (Role ID: c15c22c0-9faf-424c-9b7e-bd91c06a240b) |
> | Audit and monitoring reference | **Enterprise Agreements-specific roles**<br/>[Azure Activity Log API – Tenant Activity Logs](/rest/api/monitor/tenant-activity-logs/list)<br/>• Access to tenant level activity logs requires using [elevate access](/azure/role-based-access-control/elevate-access-global-admin) at least once to gain tenant level access.<br/>• Audits where resourceProvider == `Microsoft.Billing` and operationName contains `billingRoleAssignments` or `EnrollmentAccount` |

### Cost Management and Billing – Microsoft Customer Agreements

> [!div class="mx-tableFixed"]
> | Area | Content |
> | --- | --- |
> | Overview | [Understand Microsoft Customer Agreement administrative roles in Azure](/azure/cost-management-billing/manage/understand-mca-roles)<br/>[Understand your Microsoft business billing account](/microsoft-365/commerce/manage-billing-accounts#what-are-billing-account-roles) |
> | Management API reference | **Microsoft Customer Agreements-specific roles in Microsoft Entra ID**<br/>[Microsoft Graph v1.0 roleManagement API](/graph/api/resources/rolemanagement)<br/>• Use `directory` provider<br/>• The following roles have permissions: Billing Administrator, Global Administrator.<br/><br/>**Microsoft Customer Agreements-specific roles**<br/>• By default, the Microsoft Entra Global Administrator and Billing Administrator roles are automatically assigned the Billing Account Owner role in Microsoft Customer Agreements-specific RBAC.<br/>• [Billing Role Assignment API](/rest/api/billing/billing-role-assignments) |
> | Audit and monitoring reference | **Microsoft Customer Agreements-specific roles in Microsoft Entra ID**<br/>[Microsoft Entra activity log overview](/entra/identity/monitoring-health/howto-access-activity-logs)<br/>API access to Microsoft Entra audit logs:<br/>• [Microsoft Graph v1.0 directoryAudit API](/graph/api/resources/directoryaudit)<br/>• Audits with category `RoleManagement`<br/><br/>**Microsoft Customer Agreements-specific roles**<br/>[Azure Activity Log API – Tenant Activity Logs](/rest/api/monitor/tenant-activity-logs/list)<br/>• Access to tenant level activity logs requires using [elevate access](/azure/role-based-access-control/elevate-access-global-admin) at least once to gain tenant level access.<br/>• Audits where resourceProvider == `Microsoft.Billing` and operationName one of the following (all prefixed with `Microsoft.Billing`):<br/>`/permissionRequests/write`<br/>`/billingAccounts/createBillingRoleAssignment/action`<br/>`/billingAccounts/billingProfiles/createBillingRoleAssignment/action`<br/>`/billingAccounts/billingProfiles/invoiceSections/createBillingRoleAssignment/action`<br/>`/billingAccounts/customers/createBillingRoleAssignment/action`<br/>`/billingAccounts/billingRoleAssignments/write`<br/>`/billingAccounts/billingRoleAssignments/delete`<br/>`/billingAccounts/billingProfiles/billingRoleAssignments/delete`<br/>`/billingAccounts/billingProfiles/customers/createBillingRoleAssignment/action`<br/>`/billingAccounts/billingProfiles/invoiceSections/billingRoleAssignments/delete`<br/>`/billingAccounts/departments/billingRoleAssignments/write`<br/>`/billingAccounts/departments/billingRoleAssignments/delete`<br/>`/billingAccounts/enrollmentAccounts/transferBillingSubscriptions/action`<br/>`/billingAccounts/enrollmentAccounts/billingRoleAssignments/write`<br/>`/billingAccounts/enrollmentAccounts/billingRoleAssignments/delete`<br/>`/billingAccounts/billingProfiles/invoiceSections/billingSubscriptions/transfer/action`<br/>`/billingAccounts/billingProfiles/invoiceSections/initiateTransfer/action`<br/>`/billingAccounts/billingProfiles/invoiceSections/transfers/delete`<br/>`/billingAccounts/billingProfiles/invoiceSections/transfers/cancel/action`<br/>`/billingAccounts/billingProfiles/invoiceSections/transfers/write`<br/>`/transfers/acceptTransfer/action`<br/>`/transfers/accept/action`<br/>`/transfers/decline/action`<br/>`/transfers/declineTransfer/action`<br/>`/billingAccounts/customers/initiateTransfer/action`<br/>`/billingAccounts/customers/transfers/delete`<br/>`/billingAccounts/customers/transfers/cancel/action`<br/>`/billingAccounts/customers/transfers/write`<br/>`/billingAccounts/billingProfiles/invoiceSections/products/transfer/action`<br/>`/billingAccounts/billingSubscriptions/elevateRole/action` |

### Business Subscriptions and Billing – Volume Licensing

> [!div class="mx-tableFixed"]
> | Area | Content |
> | --- | --- |
> | Overview | [Manage volume licensing user roles Frequently Asked Questions](/microsoft-365/commerce/licenses/user-roles-faq) |
> | Management API reference | **Volume Licensing-specific roles in Microsoft Entra ID**<br/>Volume Licensing does not support Microsoft Entra roles.<br/><br/>**Volume Licensing-specific roles**<br/>[VL users and roles](/microsoft-365/commerce/licenses/user-roles-faq#how-do-i-manage-vl-users-and-roles) are managed in the M365 Admin Center. |

### Partner Center

> [!div class="mx-tableFixed"]
> | Area | Content |
> | --- | --- |
> | Overview | [Roles, permissions, and workspace access for users](/partner-center/permissions-overview) |
> | Management API reference | **Partner Center-specific roles in Microsoft Entra ID**<br/>[Microsoft Graph v1.0 roleManagement API](/graph/api/resources/rolemanagement)<br/>• Use `directory` provider<br/>• The following roles have permissions: Global Administrator, User Administrator.<br/><br/>**Partner Center-specific roles**<br/>[Partner Center-specific roles](/partner-center/permissions-overview#microsoft-entra-tenant-roles-and-non-azure-ad-roles) can only be managed via Partner Center. |
> | Audit and monitoring reference | **Partner Center-specific roles in Microsoft Entra ID**<br/>[Microsoft Entra activity log overview](/entra/identity/monitoring-health/howto-access-activity-logs)<br/>API access to Microsoft Entra audit logs:<br/>• [Microsoft Graph v1.0 directoryAudit API](/graph/api/resources/directoryaudit)<br/>• Audits with category `RoleManagement` |

## Other services

### Azure DevOps

> [!div class="mx-tableFixed"]
> | Area | Content |
> | --- | --- |
> | Overview | [About permissions and security groups](/azure/devops/organizations/security/about-permissions) |
> | Management API reference | **Azure DevOps-specific roles in Microsoft Entra ID**<br/>[Microsoft Graph v1.0 roleManagement API](/graph/api/resources/rolemanagement)<br/>• Use `directory` provider<br/>• See roles with permissions starting with `microsoft.azure.devOps`.<br/><br/>**Azure DevOps-specific roles**<br/>Create/read/update/delete permissions granted via [Roleassignments API](/rest/api/azure/devops/securityroles/roleassignments)<br/>• View permissions of roles with [Roledefinitions API](/rest/api/azure/devops/securityroles/roledefinitions)<br/>• [Permissions reference topic](/azure/devops/organizations/security/permissions)<br/>• When an Azure DevOps group (note: different from Microsoft Entra group) is assigned to a role, create/read/update/delete group memberships with the [Memberships API](/rest/api/azure/devops/graph/memberships) |
> | Audit and monitoring reference | **Azure DevOps-specific roles in Microsoft Entra ID**<br/>[Microsoft Entra activity log overview](/entra/identity/monitoring-health/howto-access-activity-logs)<br/>API access to Microsoft Entra audit logs:<br/>• [Microsoft Graph v1.0 directoryAudit API](/graph/api/resources/directoryaudit)<br/>• Audits with category `RoleManagement`<br/><br/>**Azure DevOps-specific roles**<br/>• [Accessing the AzureDevOps Audit Log](/azure/devops/organizations/audit/azure-devops-auditing)<br/>• [Audit API reference](/rest/api/azure/devops/audit/)<br/>• [AuditId reference](/azure/devops/organizations/audit/auditing-events)<br/>• Audits with ActionId `Security.ModifyPermission`, `Security.RemovePermission`.<br/>• For changes to groups assigned to roles, audits with ActionId `Group.UpdateGroupMembership`, `Group.UpdateGroupMembership.Add`, `Group.UpdateGroupMembership.Remove` |

### Fabric

Includes Fabric and Power BI.

> [!div class="mx-tableFixed"]
> | Area | Content |
> | --- | --- |
> | Overview | [Understand Microsoft Fabric admin roles](/fabric/admin/roles) |
> | Management API reference | **Fabric-specific roles in Microsoft Entra ID**<br/>[Microsoft Graph v1.0 roleManagement API](/graph/api/resources/rolemanagement)<br/>• Use `directory` provider<br/>• See roles with permissions starting with `microsoft.powerApps.powerBI`. |
> | Audit and monitoring reference | **Fabric-specific roles in Microsoft Entra ID**<br/>[Microsoft Entra activity log overview](/entra/identity/monitoring-health/howto-access-activity-logs)<br/>API access to Microsoft Entra audit logs:<br/>• [Microsoft Graph v1.0 directoryAudit API](/graph/api/resources/directoryaudit)<br/>• Audits with category `RoleManagement` |

### Unified Support Portal for managing customer support cases

Includes Unified Support Portal and Services Hub.

> [!div class="mx-tableFixed"]
> | Area | Content |
> | --- | --- |
> | Overview | [Services Hub roles and permissions](/services-hub/unified/getting-started/roles-permissions) |
> | Management API reference | Manage these roles in the Services Hub portal, https://serviceshub.microsoft.com. |

## Microsoft Graph application permissions

In addition to the previously mentioned RBAC systems, elevated permissions can be granted to Microsoft Entra application registrations and service principals using application permissions. For example, a non-interactive, non-human application identity can be granted the ability to read all mail in a tenant (the `Mail.Read` application permission). The following table lists how to manage and monitor application permissions. 

> [!div class="mx-tableFixed"]
> | Area | Content |
> | --- | --- |
> | Overview | [Overview of Microsoft Graph permissions](/graph/permissions-overview?tabs=http#application-permissions) |
> | Management API reference | **Microsoft Graph-specific roles in Microsoft Entra ID**<br/>[Microsoft Graph v1.0 servicePrincipal API](/graph/api/resources/serviceprincipal)<br/>• Enumerate the [appRoleAssignments](/graph/api/resources/approleassignment) for each [servicePrincipal](/graph/api/resources/serviceprincipal) in the tenant.<br/>• For each appRoleAssignment, get information about the permissions granted by the assignment by reading the appRole property on the servicePrincipal object referenced by the resourceId and appRoleId in the appRoleAssignment.<br/>• Of specific interest are app permissions to the Microsoft Graph (servicePrincipal with appID == "00000003-0000-0000-c000-000000000000") which grant access to Exchange, SharePoint, Teams, and so on. Here is a reference for [Microsoft Graph permissions](/graph/permissions-reference).<br/>• Also see [Microsoft Entra security operations for applications](/entra/architecture/security-operations-applications). |
> | Audit and monitoring reference | **Microsoft Graph-specific roles in Microsoft Entra ID**<br/>[Microsoft Entra activity log overview](/entra/identity/monitoring-health/howto-access-activity-logs)<br/>API access to Microsoft Entra audit logs:<br/>• [Microsoft Graph v1.0 directoryAudit API](/graph/api/resources/directoryaudit)<br/>• Audits with category `ApplicationManagement` and Activity name `Add app role assignment to service principal` |

## Next steps

* [Assign Microsoft Entra roles](manage-roles-portal.md)
* [Microsoft Entra built-in roles](permissions-reference.md)
