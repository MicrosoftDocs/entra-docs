---
title: 'Identity Governance custom alerts'
description: This article shows how to create custom alerts with Microsoft Entra ID Governance
author: billmath
manager: amycolannino
ms.service: entra-id-governance
ms.topic: how-to
ms.date: 08/12/2024
ms.author: billmath
ms.custom:
---

# Microsoft Entra ID Governance custom alerts

Microsoft Entra ID Governance makes it easy to alert people in your organization when they need to take action (ex: approve a request for access to a resource) or when a business process isn't functioning properly (ex: new hires aren't getting provisioned).

The following table outlines some of the standard notifications that Microsoft Entra ID Governance provides, the target persona in an organization, where they would expect to be alerted, and how quickly they would be alerted.

**Sample of existing standard notifications**

| Persona | Alert method | Timeliness | Example alert |
| --- | --- | --- | --- |
| End user | Teams | Minutes | You need to approve or deny this request for access;  <br>The access you requested has been approved, go use your new app<br><br>[Learn more](/entra/id-governance/entitlement-management-process#email-notifications-table) |
| End user | Teams | Days | The access you requested is going to expire next week, please renew.[Learn more](/entra/id-governance/entitlement-management-process#email-notifications-table) |
| End user | Email | Days | Welcome to Woodgrove, here is your temporary access pass. [Learn more.](/entra/id-governance/lifecycle-workflow-tasks#generate-temporary-access-pass-and-send-via-email-to-users-manager) |
| Help desk | ServiceNow | Minutes | A user needs to be manually provisioned into a legacy application. [Learn more](entitlement-management-ticketed-provisioning.md) |
| IT operations | Email | Hours | Newly hired employees aren't being imported from Workday. [Learn more](/entra/identity/app-provisioning/application-provisioning-quarantine-status) |

## Custom alert notifications

In addition to the standard notifications provided by Microsoft Entra ID Governance, organizations can create custom alerts to meet their needs. 

All activity performed by the Microsoft Entra ID Governance services is logged in the Microsoft Entra [Audit Logs](/entra/identity/monitoring-health/concept-audit-logs). By pushing the logs to a [Log Analytics workspace](/entra/identity/monitoring-health/howto-integrate-activity-logs-with-azure-monitor-logs), organizations can create [custom alerts](/entra/identity/monitoring-health/howto-analyze-activity-logs-log-analytics#set-up-alerts). 

The following section provides examples of custom alerts that customers can create by integrating Microsoft Entra ID Governance with Azure Monitor.

| Feature | Example alert |
| --- | --- |
| Access Reviews | Alert an IT admin when an access review is deleted. |
| Entitlement management | Alert an IT admin when a user is directly added to a group, without using an access package.|
| Entitlement management | Alert an IT admin when a new connected organization is added. |
| Entitlement management | Alert an IT admin when a custom extension fails. |
| Lifecycle workflows | Alert an IT admin when a specific workflow fails. |
| Multitenant collaboration | Alert an IT admin when cross-tenant sync is enabled |
| Multitenant collaboration | Alert an IT admin when a cross-tenant access policy is enabled |
| Privileged Identity Management | Alert an IT admin when PIM alerts are disabled. |
| Privileged Identity Management | Alert an IT admin when a role is granted outside of PIM.|
| Provisioning | Alert an IT admin when there is a spike in provisioning failures over a 24-hour period. |
| Provisioning| Alert an IT admin when someone starts, stops, disables, restarts, or deletes a provisioning configuration.|


## Access reviews ##

**Alert an IT admin when an access review has been deleted.**


*Query*

```
AuditLogs
| where ActivityDisplayName == " Delete access review"
```

## Entitlement management

**Alert an IT admin when a user is directly added to a group, without using an access package.**

*Query*

```
AuditLogs
| where parse_json(tostring(TargetResources[1].id)) in ("InputGroupID", "InputGroupID")
| where ActivityDisplayName == "Add member to group"
| extend ActorName = tostring(InitiatedBy.app.displayName)
| where ActorName != "Azure AD Identity Governance - User Management"
```

**Alert an IT admin when a new connected organization is created. Users from this organization can now request access to resources made available to all connected organizations.**

*Query*

```
AuditLogs
| where ActivityDisplayName == "Create connected organization"
| mv-expand AdditionalDetails
| extend key = AdditionalDetails.key, value = AdditionalDetails.value
| extend tostring(key) == "Description"
| where key == "Description"
| parse value with * "\n" TenantID 
| distinct TenantID
```

**Alert an IT admin when an entitlement management custom extension fails.**

*Query*

```
AuditLogs
| where ActivityDisplayName == "Execute custom extension"
| where Result == "success"
| mvexpand TargetResources 
| extend  CustomExtensionName=TargetResources.displayName
| where CustomExtensionName in ('<input custom exteionsion name>', '<input custom extension name>')
```

## Lifecycle workflows

**Alert an IT admin when a specific lifecycle workflow fails.**

*Query*

```
AuditLogs
| where Category == "WorkflowManagement"
| where ActivityDisplayName in ('On-demand workflow execution completed', 'Scheduled workflow execution completed')
| where Result != "success"
| mvexpand TargetResources 
| extend  WorkflowName=TargetResources.displayName
| where WorkflowName in ('input workflow name', 'input workflow name')
| extend WorkflowType = AdditionalDetails[0].value 
| extend DisplayName = AdditionalDetails[1].value 
| extend ObjectId = AdditionalDetails[2].value 
| extend UserCount = AdditionalDetails[3].value 
| extend Users = AdditionalDetails[4].value 
| extend RequestId = AdditionalDetails[5].value 
| extend InitiatedBy = InitiatedBy.app.displayName 
| extend Result = Result 
| project WorkflowType, DisplayName, ObjectId, UserCount, Users, RequestId, Id, Result,ActivityDisplayName
```

<u>Alert logic</u>

- Based on: Number of results
- Operator: Equal to
- Threshold: 0

## Multitenant collaboration

**Alert an IT admin when a new cross-tenant access policy is created. This allows your organization to detect when a relationship has been formed with a new organization.**

*Query*

```
AuditLogs
| where OperationName == "Add a partner to cross-tenant access setting"
| where parse_json(tostring(TargetResources[0].modifiedProperties))[0].displayName == "tenantId"
| extend initiating_user=parse_json(tostring(InitiatedBy.user)).userPrincipalName
| extend source_ip=parse_json(tostring(InitiatedBy.user)).ipAddress
| extend target_tenant=parse_json(tostring(TargetResources[0].modifiedProperties))[0].newValue
| project TimeGenerated, OperationName,initiating_user,source_ip, AADTenantId,target_tenant
| project-rename source_tenant= AADTenantId
````

**As an admin, I can get an alert when an inbound cross-tenant sync policy is set to true. This allows your organization to detect when an organization is authorized to synchronize identities into your tenant.**

*Query*

```
AuditLogs
| where OperationName == "Update a partner cross-tenant identity sync setting"
| extend a = tostring(TargetResources)
| where a contains "true"
| where parse_json(tostring(TargetResources[0].modifiedProperties))[0].newValue contains "true"
```
<u>Alert logic</u>

## Privileged identity management ##
**Alert an IT admin when specific PIM security alerts are disabled.**

*Query*

```
AuditLogs
| where ActivityDisplayName == "Disable PIM alert"
```

**Alert an IT admin when a user is added to a role outside of PIM**

The query below is based on a templateId. You can find a list of template IDs [here](https://learn.microsoft.com/entra/identity/role-based-access-control/permissions-reference).

*Query*

```
AuditLogs
| where ActivityDisplayName == "Add member to role"
| where parse_json(tostring(TargetResources[0].modifiedProperties))[2].newValue in ("\"INPUT GUID\"")
```

## Provisioning

**Alert an IT administrator when there is a spike in provisioning failures over a 24 hour period.**

*Query*

```
AADProvisioningLogs
| where JobId == “<input JobId>”
| where resultType == “Failure”
```


<u>Alert Logic</u>

- Based on: Number of results
- Operator: Greater than
- Threshold value: 10

**Alert an IT admin when someone starts, stops, disables, restarts, or deletes a provisioning configuration.**

*Query*

```
AuditLogs
| where ActivityDisplayName in ('Add provisioning configuration','Delete provisioning configuration','Disable/pause provisioning configuration', 'Enable/restart provisioning configuration', 'Enable/start provisioning configuration')
```


**Next steps**

- [Log analytics](/entra/identity/monitoring-health/howto-analyze-activity-logs-log-analytics)
- [Get started with queries in Azure Monitor logs](/azure/azure-monitor/logs/get-started-queries)
- [Create and manage alert groups in the Azure portal](/azure/azure-monitor/alerts/action-groups)
- [Install and use the log analytics views for Microsoft Entra ID](/azure/azure-monitor/visualize/workbooks-view-designer-conversion-overview)
- [Archive logs and reporting on entitlement management in Azure Monitor](/entra/id-governance/entitlement-management-logs-and-reporting)

