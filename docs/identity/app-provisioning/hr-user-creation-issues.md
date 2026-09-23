---
title: Troubleshoot user creation issues with HR provisioning
description: Learn how to troubleshoot user creation issues with HR provisioning
ms.topic: troubleshooting
ms.date: 08/20/2026
ms.reviewer: chmutali
ai-usage: ai-assisted
---

# Troubleshoot HR user creation issues

## Null and empty values during user creation

**Applies to:**
* Workday to on-premises Active Directory user provisioning
* Workday to Microsoft Entra user provisioning
* SAP SuccessFactors to on-premises Active Directory user provisioning
* SAP SuccessFactors to Microsoft Entra user provisioning

| Troubleshooting | Details |
|-- | -- |
| **Issue** | The HR app returns a null or empty value during user creation, and the resulting target value doesn't match the intended behavior. For provisioning to on-premises Active Directory, the create operation might fail with the error message: `InvalidAttributeSyntax-LdapErr: The syntax is invalid. The parameter is incorrect. Error in attribute conversion operation, data 0, v3839`. |
| **Cause** | Attribute value clearing is disabled by default. If null value flow isn't enabled for both the source attribute and target mapping, the provisioning service might ignore the source value or pass an empty string to the target. The on-premises Active Directory connector can't set an empty string and returns the LDAP error. |
| **Resolution** | Check the provisioning logs and identify the source and target attributes associated with the null or empty value. Then configure the mapping based on whether the target attribute should remain empty, receive a fallback value, or ignore the source value. |

**Recommended resolutions**

Let's say the Workday attribute `BusinessTitle`, which maps to the Active Directory attribute `jobTitle`, can be null or empty.

- To leave the optional target attribute empty during creation and clear it during future updates, [enable attribute value clearing](clear-attribute-values.md) for both the source attribute and target mapping. If you configure **Default value if null**, the provisioning service uses that value during creation only.
- To populate a required target attribute with a nonblank fallback value, use the [Switch](functions-for-customizing-application-data.md#switch) function. For example, `Switch([BusinessTitle],[BusinessTitle],"","N/A")`.

- To ignore the null or empty source value instead of clearing the target attribute, use the [IgnoreFlowIfNullOrEmpty](functions-for-customizing-application-data.md#ignoreflowifnullorempty) function. For example, `IgnoreFlowIfNullOrEmpty([BusinessTitle])`.

## Next steps

* [Learn more about Microsoft Entra ID and Workday integration scenarios and web service calls](workday-integration-reference.md)
* [Learn more about Microsoft Entra ID and SAP SuccessFactors integration scenarios](sap-successfactors-integration-reference.md)
* [Learn how to review logs and get reports on provisioning activity](check-status-user-account-provisioning.md)
