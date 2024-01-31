---
title: Troubleshoot user update issues with HR provisioning
description: Learn how to troubleshoot user update issues with HR provisioning
author: jenniferf-skc
manager: amycolannino
ms.service: active-directory
ms.subservice: app-provisioning
ms.topic: troubleshooting
ms.workload: identity
ms.date: 01/30/2024
ms.author: jfields
ms.reviewer: chmutali
---

# Troubleshoot HR user update issues

## Null and empty values not processed as expected
**Applies to:**
* Workday to on-premises Active Directory user provisioning
* Workday to Microsoft Entra ID user provisioning
* SAP SuccessFactors to on-premises Active Directory user provisioning
* SAP SuccessFactors to Microsoft Entra ID user provisioning

| Troubleshooting | Details |
|-- | -- |
| **Issue** | You successfully configured the inbound provisioning app. You're getting null or empty value from the HR app. You expect the provisioning service to clear the corresponding target attribute value in on-premises Active Directory / Microsoft Entra ID. But the operation fails with the error message: `InvalidAttributeSyntax-LdapErr: The syntax is invalid. The parameter is incorrect. Error in attribute conversion operation, data 0, v3839` |
| **Cause** | The provisioning service doesn't have a default logic for null value processing. When the provisioning service gets an empty string from the source app, it tries to flow the value "as-is" to the target app. In this case, on-premises Active Directory provisioning connector currently doesn't support setting empty string values and hence you see the above error. |
| **Resolution** | Check the provisioning logs. Identify attributes in the target Active Directory that are receiving null or empty string values. Update the attribute mapping for such attributes to use an expression mapping. See recommended resolutions. |

**Recommended resolutions**

  Let's say the attribute `BusinessTitle` mapped to AD attribute `jobTitle` may be null or empty in Workday. 
  * Option 1: Use the function [Switch](https://go.microsoft.com/fwlink/?linkid=2259244) to check for empty or null values and pass a nonblank literal value.

Switch([BusinessTitle],[BusinessTitle],"","N/A")


  * Option 2: Use the function [IgnoreFlowIfNullOrEmpty](functions-for-customizing-application-data.md#ignoreflowifnullorempty) to drop empty or null attributes in the payload sent to on-premises Active Directory / Microsoft Entra ID. 
  
     `IgnoreFlowIfNullOrEmpty([BusinessTitle])` 

## Some Workday attribute updates are missing
**Applies to:**
* Workday to on-premises Active Directory user provisioning
* Workday to Microsoft Entra ID user provisioning

| Troubleshooting | Details |
|-- | -- |
| **Issue** | You successfully configured the Workday inbound provisioning app and successfully connected to the Workday tenant URL. You're observing that there's a delay in the flow of certain attribute updates from Workday or in some cases, the attributes changes from Workday aren't flowing through as expected during incremental sync. |
| **Cause** | During incremental sync, the provisioning app queries Workday transaction log for changes to the primary Worker entity and only changes tracked by Workday's transaction log are processed. <br> If changes to a Workday attribute in your setup aren't tracked by Workday's transaction log, then Microsoft Entra ID won't fetch that change. For example: the *LocalReference* Workday attribute is part of the default attribute mapping and it has XPATH `wd:Worker/wd:Worker_Data/wd:Employment_Data/wd:Position_Data/wd:Business_Site_Summary_Data/wd:Local_Reference/wd:ID[@wd:type='Locale_ID']/text()`. This attribute is part of the entity *Business_Site_Summary_Data*. A change in the value of this attribute in Workday doesn't show up in the Workday transaction log. Thus during incremental sync, the new value of this attribute shows up only if an attribute associated with the primary Worker entity also changes during the sync interval. |
| **Resolution** | If you notice this behavior frequently, where changes to certain Workday attributes aren't flowing through, we recommend periodically running a weekly or monthly full sync. |

## User match with extensionAttribute not working
**Applies to:**
* Workday to Microsoft Entra user provisioning
* SAP SuccessFactors to Microsoft Entra ID user provisioning

| Troubleshooting | Details |
|-- | -- |
| **Issue** | Let's say you're using *extensionAttribute3* in Microsoft Entra ID to store the employee ID and you map it to Workday *WorkerID* or SuccessFactors *personIdExternal* attribute for user matching. With this configuration, the matching step in provisioning process fails. This issue impacts both user creation and updates. |
| **Cause** | The Microsoft Entra ID *OnPremisesExtensionAttributes* (`extensionAttributes1-15`) can't be used as a matching attribute because the `$filter` parameter of **Azure AD Graph API** doesn't [support filtering by extensionAttributes](/previous-versions/azure/ad/graph/howto/azure-ad-graph-api-supported-queries-filters-and-paging-options#filter). |
| **Resolution** | Don't use Microsoft Entra ID *OnPremisesExtensionAttributes* (`extensionAttributes1-15`) in the matching attribute pair. Use employeeID. |

## Updates to Microsoft Entra ID *mail* attribute not supported
**Applies to:**
* Workday to Microsoft Entra ID user provisioning
* SAP SuccessFactors to Microsoft Entra ID user provisioning
* API-driven provisioning Microsoft Entra ID 

| Troubleshooting | Details |
|-- | -- |
| **Issue** | You configured *mail* attribute provisioning from your HR system to Microsoft Entra ID. Any update to the mail attribute isn't working even though the provisioning logs display a record for the mail attribute.  |
| **Cause** | The provisioning connector to Microsoft Entra ID only supports setting the mail attribute during user creation. Once the user is created, the connector doesn't support updating the email address. |
| **Resolution** | To update the mail attribute for existing users, consider using Exchange Online portal or PowerShell. |

## Provisioning Last Day of Work field from Workday
**Applies to:**
* Workday to on-premises Active Directory user provisioning
* Workday to Microsoft Entra ID user provisioning 

| Troubleshooting | Details |
|-- | -- |
| **Issue** | You configured attribute mapping for Workday “Last Day of Work” (`StatusTerminationLastDayOfWork`) attribute in the provisioning app. However, the “Last Day of Work” update only happens after the termination date is effective, whereas you’d like to fetch this “Last Day of Work” before the termination date. |
| **Cause** | In Workday, the “Last Day of Work” field gets set on the worker profile only after the termination date is effective. Hence, the Workday provisioning connector is unable to get this date in advance before the termination date. |
| **Resolution** | There's no workaround for this behavior. |



## Next steps

* [Learn more about Microsoft Entra ID and Workday integration scenarios and web service calls](workday-integration-reference.md)
* [Learn how to review logs and get reports on provisioning activity](check-status-user-account-provisioning.md)
