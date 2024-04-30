---
title: Troubleshoot writeback issues with HR provisioning
description: Learn how to troubleshoot writeback issues with HR provisioning.
author: jenniferf-skc
manager: amycolannino
ms.service: entra-id
ms.subservice: app-provisioning
ms.topic: troubleshooting
ms.workload: identity
ms.date: 02/27/2024
ms.author: jfields
ms.reviewer: chmutali
---

# Troubleshoot HR writeback issues

## Null and empty values not processed as expected
**Applies to:**
* Workday Writeback
* SAP SuccessFactors Writeback

| Troubleshooting | Details |
| -- | -- |
| **Issue** | You successfully configured the Writeback app. You're getting null or empty value from Microsoft Entra ID. You expect the provisioning service to clear the corresponding email or phone number value in the HR app. But the operation fails. |
| **Cause** | The provisioning service doesn't have a default logic for null value processing. When the provisioning service gets an empty string from the source app, it tries to flow the value "as-is" to the target app. If Workday or SuccessFactors can't process empty values, then an error is returned. |
| **Resolution** | Update the attribute mapping to use expression mappings as recommended. |

**Recommended resolutions**

  Let's say the attribute `telephoneNumber` mapped to SAP SuccessFactors attribute `businessPhoneNumber` may be null or empty in Microsoft Entra ID. 
  * Option 1: Define an expression to check for empty or null values using functions like [IIF,](functions-for-customizing-application-data.md#iif) [IsNullOrEmpty,](functions-for-customizing-application-data.md#isnullorempty) [Coalesce,](functions-for-customizing-application-data.md#coalesce) or [IsPresent](functions-for-customizing-application-data.md#ispresent) and pass a nonblank literal value (example: 000-000-0000 in this case). 
  
     `IIF(IsNullOrEmpty([telephoneNumber]),"000-000-0000",[telephoneNumber])`

  * Option 2: Use the function [IgnoreFlowIfNullOrEmpty](functions-for-customizing-application-data.md#ignoreflowifnullorempty) to drop empty or null attributes in the payload sent to SuccessFactors. 
  
     `IgnoreFlowIfNullOrEmpty([telephoneNumber])` 



## Next steps

* [Learn more about Microsoft Entra ID and Workday integration scenarios and web service calls](workday-integration-reference.md)
* [Learn how to review logs and get reports on provisioning activity](check-status-user-account-provisioning.md)
