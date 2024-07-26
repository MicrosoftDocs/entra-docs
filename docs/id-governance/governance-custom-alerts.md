---
title: 'Identity Governance Alerting'
description: This article shows how to create custom alerts with Microsoft Entra Identity Governance
author: billmath
manager: amycolannino
ms.service: entra-id-governance
ms.topic: how-to
ms.date: 07/26/2024
ms.author: billmath
ms.custom:
---

# Microsoft Entra Identity Governance Alerting

Microsoft Entra Identity Governance makes it easy to alert people in your organization when they need to take action (ex: approve a request for access to a resource) or when a business process is not functioning properly (ex: new hires are not getting provisioned).

The following table outlines some of the standard notifications that Microsoft Entra Identity Governance provides, the target persona in an organization, where they would expect to be alerted, and how quickly they would be alerted.

| Persona | Alert method | Timeliness | Example alert |
| --- | --- | --- | --- |
| IT operations | Email | Hours | Newly hired employees are not being imported from Workday. [Learn more](https://learn.microsoft.com/entra/identity/app-provisioning/application-provisioning-quarantine-status) |
| GRC specialist | Email | Days | Application access requests are being denied because approvers are not approving the requests. |
| Help desk | ServiceNow | Minutes | A user needs to be manually provisioned into a legacy application. [Learn more](https://learn.microsoft.com/en-us/entra/id-governance/entitlement-management-ticketed-provisioning) |
| End user | Teams | Minutes | You need to approve or deny this request for access;  <br>The access you requested has been approved, go use your new app<br><br>[Learn more](https://learn.microsoft.com/entra/id-governance/entitlement-management-process#email-notifications-table) |
| End user | Teams | Days | The access you requested is going to expire next week, please renew<br><br>[Learn more](https://learn.microsoft.com/entra/id-governance/entitlement-management-process#email-notifications-table) |
| End user | Email | Days | Welcome to Woodgrove, here is your temporary access pass. [Learn more.](https://learn.microsoft.com/en-us/entra/id-governance/lifecycle-workflow-tasks#generate-temporary-access-pass-and-send-via-email-to-users-manager) |

# Custom email notifications

All activity performed by Microsoft Entra Identity Governance services is audited in the Microsoft Entra Audit Logs. By pushing the logs to Azure Monitor, customers can create custom notifications that are tailored to meet their organization's needs. The following section provides examples of custom alerts that customers can create by integrating Entra Identity Governance with Azure Monitor.

| Feature | Example alert |
| --- | --- |
| Provisioning | Alert an IT administrator through email when there is a spike in provisioning failures over a 24-hour period. |
| Provisioning | Alert an IT admin when the provisioning service does not export any changes in the past month. |
| Lifecycle workflows | Alert an IT admin through email when a specific workflow fails. |
| Entitlement management | Alert an IT administrator through email when a new connected organization is added. |
| Entitlement management | Alert an IT admin when a custom extension fails. |
| Entitlement management | \*\* pending query Alert when a guest user has been added to a specific access package. |
| Access Reviews | Alert an IT admin when an access review is deleted. |
| Privileged Identity Management | Alert an IT admin when PIM alerts are disabled. |
| Multi-tenant collaboration | Alert an IT amin when cross-tenant sync is enabled |
| Multi-tenant collaboration | Alert an IT admin when a cross-tenant access policy is enabled |

## Provisioning

**Alert an IT administrator through email when there is a spike in provisioning failures over a 24 hour period.**

<u>Query</u>

```
AADProvisioningLogs
| where JobId == “<input JobId>
| where resultType == “Failure”
```


<u>Alert Logic</u>

- Based on: Number of results
- Operator: Greater than
- Threshold value: 10

**Alert an IT admin when the provisioning service does not export any changes in the past month.**

<u>Query</u>

```
AADProvisioningLogs
| take 1
```

<u>Alert logic</u>

- Based on: Number of results
- Operator: Equal to
- Threshold: 0

## Lifecycle workflows

**Alert an IT admin through email when a specific workflow fails.**

<u>Query</u>

```
AuditLogs
| where Category == "WorkflowManagement"
| where ActivityDisplayName in ('On-demand workflow execution completed', 'Scheduled workflow execution completed')
| where Result == "failure"
| mvexpand TargetResources
| extend WorkflowName=TargetResources.displayName
| where WorkflowName in ('&lt;input workflow name&gt;', '&lt;input workflow name&gt;')
| distinct Id
```

<u>Alert logic</u>

- Based on: Number of results
- Operator: Equal to
- Threshold: 0

**Alert an <persona> through <medium> when <scenario>**

<u>Query</u>

<u>Alert logic</u>

- Based on:
- Operator:
- Threshold:

## Multi-tenant collaboration

## _As an admin, I can get an email when a cross-tenant access policy is created_

<u>Query</u>

```
AuditLogs
| where OperationName == "Add a partner to cross-tenant access setting"

| where parse_json(tostring(TargetResources\[0\].modifiedProperties))\[0\].displayName == "tenantId"

| extend initiating_user=parse_json(tostring(InitiatedBy.user)).userPrincipalName

| extend source_ip=parse_json(tostring(InitiatedBy.user)).ipAddress

| extend target_tenant=parse_json(tostring(TargetResources\[0\].modifiedProperties))\[0\].newValue

| project TimeGenerated, OperationName,initiating_user,source_ip, AADTenantId,target_tenant

| project-rename source_tenant= AADTenantId

````

**As an admin, I can get an email when an inbound cross-tenant sync policy is set to true**

**Query**

```
AuditLogs

| where OperationName == "Update a partner cross-tenant identity sync setting"

| extend a = tostring(TargetResources)

| where a contains "true"

| where parse_json(tostring(TargetResources\[0\].modifiedProperties))\[0\].newValue contains "true"
```

## Entitlement management

**Alert an IT admin through email when a new connected organization is created.**

<u>Query</u>

```
AuditLogs
| where ActivityDisplayName == "Create connected organization"_
| mv-expand AdditionalDetails_
| extend key = AdditionalDetails.key, value = AdditionalDetails.value_

_| extend tostring(key) == "Description"_

_| where key == "Description"_

_| parse value with \* "\\n" TenantID_

_| project TenantID_
```

<u>Alert logic</u>

- Based on:
- Operator:
- Threshold:

**Alert an IT admin through email when a custom extension fails.**

<u>Query</u>

```
AuditLogs_

_| where ActivityDisplayName == "Execute custom extension"_

_| where Result == "success"_

_| mvexpand TargetResources_

_| extend CustomExtensionName=TargetResources.displayName_

_| where CustomExtensionName in ('&lt;input custom exteionsion name&gt;', '&lt;input custom extension name&gt;')_
```

Access Reviews

**Alert an IT admin when an access review has been deleted.**

Query

AuditLogs

| where ActivityDisplayName == " Delete access review"

Privileged Identity Management

**Alert an IT admin through email when specific PIM security alerts are disabled.**

Query

AuditLogs

| where ActivityDisplayName == "Disable PIM alert"

Alert logic

- Based on:
- Operator:
- Threshold:

**Next steps**

- [Log analytics](https://learn.microsoft.com/en-us/entra/identity/monitoring-health/howto-analyze-activity-logs-log-analytics)
- [Get started with queries in Azure Monitor logs](https://learn.microsoft.com/en-us/azure/azure-monitor/logs/get-started-queries)
- [Create and manage alert groups in the Azure portal](https://learn.microsoft.com/en-us/azure/azure-monitor/alerts/action-groups)
- [Install and use the log analytics views for Microsoft Entra ID](https://learn.microsoft.com/en-us/azure/azure-monitor/visualize/workbooks-view-designer-conversion-overview)

<https://learn.microsoft.com/en-us/graph/api/resources/provisioningobjectsummary?preserve-view=true&view=graph-rest-beta>

