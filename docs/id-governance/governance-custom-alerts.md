---
title: 'Identity Governance Alerting'
description: This article shows how to create custom alerts with Microsoft Entra ID Governance
author: billmath
manager: amycolannino
ms.service: entra-id-governance
ms.topic: how-to
ms.date: 07/26/2024
ms.author: billmath
ms.custom:
---

# Microsoft Entra ID Governance Alerting

Microsoft Entra ID Governance makes it easy to alert people in your organization when they need to take action (ex: approve a request for access to a resource) or when a business process isn't functioning properly (ex: new hires aren't getting provisioned).

The following table outlines some of the standard notifications that Microsoft Entra ID Governance provides, the target persona in an organization, where they would expect to be alerted, and how quickly they would be alerted.

**Sample of existing standard notifications**

| Persona | Alert method | Timeliness | Example alert |
| --- | --- | --- | --- |
| End user | Teams | Minutes | You need to approve or deny this request for access;  <br>The access you requested has been approved, go use your new app<br><br>[Learn more](https://learn.microsoft.com/entra/id-governance/entitlement-management-process#email-notifications-table) |
| End user | Teams | Days | The access you requested is going to expire next week, please renew.[Learn more](https://learn.microsoft.com/entra/id-governance/entitlement-management-process#email-notifications-table) |
| End user | Email | Days | Welcome to Woodgrove, here is your temporary access pass. [Learn more.](https://learn.microsoft.com/entra/id-governance/lifecycle-workflow-tasks#generate-temporary-access-pass-and-send-via-email-to-users-manager) |
| Help desk | ServiceNow | Minutes | A user needs to be manually provisioned into a legacy application. [Learn more](entitlement-management-ticketed-provisioning.md) |
| IT operations | Email | Hours | Newly hired employees aren't being imported from Workday. [Learn more](https://learn.microsoft.com/entra/identity/app-provisioning/application-provisioning-quarantine-status) |

## Custom alert notifications

In addition to the standard notifications provided by Microsoft Entra ID Governance, organizations can create custom alerts to meet their needs. 

All activity performed by the Microsoft Entra ID Governance services is logged in the Microsoft Entra [Audit Logs](https://learn.microsoft.com/entra/identity/monitoring-health/concept-audit-logs). By pushing the logs to a [Log Analytics workspace](https://learn.microsoft.com/entra/identity/monitoring-health/howto-analyze-activity-logs-log-analytics), organizations can create [custom alerts](https://learn.microsoft.com/entra/identity/monitoring-health/howto-integrate-activity-logs-with-azure-monitor-logs). 

The following section provides examples of custom alerts that customers can create by integrating Entra ID Governance with Azure Monitor.

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
| Provisioning | Alert an IT admin when there is a spike in provisioning failures over a 24-hour period. |
| Provisioning| Alert an IT admin when someone starts, stops, disables, restarts, or deletes a provisioning configuration.|


## Access Reviews ##

**Alert an IT admin when an access review has been deleted.**


<u>Query</u>

```
AuditLogs
| where ActivityDisplayName == " Delete access review"
```

## Entitlement management

**Alert an IT admin when a user is directly added to a group, without using an access package.**
<u>Query</u>

```
AuditLogs
| where parse_json(tostring(TargetResources[1].id)) in ("InputGroupID", "InputGroupID")
| where ActivityDisplayName == "Add member to group"
| extend ActorName = tostring(InitiatedBy.user.displayName)
| where ActorName != "Azure AD Identity Governance - User Management"
```

**Alert an IT admin when a new connected organization is created. Users from this organization can now request access to resources made available to all connected organizations.**

<u>Query</u>

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

<u>Query</u>

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

<u>Query</u>

```
AuditLogs
| where Category == "WorkflowManagement"
| where ActivityDisplayName in ('On-demand workflow execution completed', 'Scheduled workflow execution completed')
| where Result == "failure"
| mvexpand TargetResources 
| extend  WorkflowName=TargetResources.displayName
| where WorkflowName in ('<input workflow name>', '<input workflow name>')
| distinct Id
```

<u>Alert logic</u>

- Based on: Number of results
- Operator: Equal to
- Threshold: 0

## Multitenant collaboration

**Alert an IT admin when a new cross-tenant access policy is created. This allows your organization to detect when a relationship has been formed with a new organization.**

<u>Query</u>

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

<u>Query</u>

```
AuditLogs
| where OperationName == "Update a partner cross-tenant identity sync setting"
| extend a = tostring(TargetResources)
| where a contains "true"
| where parse_json(tostring(TargetResources[0].modifiedProperties))[0].newValue contains "true"
```
<u>Alert logic</u>

## Privileged Identity Management ##
**Alert an IT admin when specific PIM security alerts are disabled.**

<u>Query</u>

```
AuditLogs
| where ActivityDisplayName == "Disable PIM alert"
```

## Provisioning

**Alert an IT administrator when there is a spike in provisioning failures over a 24 hour period.**

<u>Query</u>

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
<u>Query</u>

```
AuditLogs
| where ActivityDisplayName in ('Add provisioning configuration','Delete provisioning configuration','Disable/pause provisioning configuration', 'Enable/restart provisioning configuration', 'Enable/start provisioning configuration')
```


**Next steps**

- [Log analytics](https://learn.microsoft.com/entra/identity/monitoring-health/howto-analyze-activity-logs-log-analytics)
- [Get started with queries in Azure Monitor logs](https://learn.microsoft.com/azure/azure-monitor/logs/get-started-queries)
- [Create and manage alert groups in the Azure portal](https://learn.microsoft.com/azure/azure-monitor/alerts/action-groups)
- [Install and use the log analytics views for Microsoft Entra ID](https://learn.microsoft.com/azure/azure-monitor/visualize/workbooks-view-designer-conversion-overview)
- [Microsoft Entra audit logs Provisioning object summary](https://learn.microsoft.com/graph/api/resources/provisioningobjectsummary?preserve-view=true&view=graph-rest-beta)

