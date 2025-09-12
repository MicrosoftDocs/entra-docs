---
title: Troubleshoot user creation issues with HR provisioning
description: Learn how to troubleshoot user creation issues with HR provisioning
author: jenniferf-skc
manager: pmwongera
ms.service: entra-id
ms.subservice: app-provisioning
ms.topic: troubleshooting
ms.date: 03/04/2025
ms.author: jfields
ms.reviewer: chmutali
---

# Troubleshoot HR user creation issues

## Creation fails due to null / empty values 

**Applies to:**
* Workday to on-premises Active Directory user provisioning
* Workday to Microsoft Entra user provisioning
* SAP SuccessFactors to on-premises Active Directory user provisioning
* SAP SuccessFactors to Microsoft Entra user provisioning

| Troubleshooting | Details |
|-- | -- |
| **Issue** | You successfully configured the inbound provisioning app. You're getting null or empty value from the HR app. The create operation fails with the error message: `InvalidAttributeSyntax-LdapErr: The syntax is invalid. The parameter is incorrect. Error in attribute conversion operation, data 0, v3839` |
| **Cause** | The provisioning service doesn't have a default logic for null value processing. When the provisioning service gets an empty string from the source app, it tries to flow the value "as-is" to the target app. In this case, on-premises Active Directory provisioning connector currently doesn't support setting empty string values and hence you see the error stated earlier. |
| **Resolution** | Check the provisioning logs. Identify attributes in the target Active Directory that are receiving null or empty string values. Update the attribute mapping for such attributes to use an expression mapping. See recommended resolutions here. |

**Recommended resolutions**

  Let's say the attribute `BusinessTitle` mapped to AD attribute `jobTitle` can be null or empty in Workday. 

  * Option 1: Use the function [Switch](functions-for-customizing-application-data.md#switch) to check for empty or null values and pass a nonblank literal value.

     `Switch([BusinessTitle],[BusinessTitle],"","N/A")`

  * Option 2: Use the function [IgnoreFlowIfNullOrEmpty](functions-for-customizing-application-data.md#ignoreflowifnullorempty) to drop empty or null attributes in the payload sent to on-premises Active Directory / Microsoft Entra ID. 
  
     `IgnoreFlowIfNullOrEmpty([BusinessTitle])` 


## Next steps

* [Learn more about Microsoft Entra ID and Workday integration scenarios and web service calls](workday-integration-reference.md)
* [Learn how to review logs and get reports on provisioning activity](check-status-user-account-provisioning.md)
