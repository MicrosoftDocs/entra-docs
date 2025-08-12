---
title: 'Workday expression mapping functions for Microsoft Entra ID provisioning'
description: A comprehensive guide to commonly used expression mapping functions when configuring Workday to on-premises Active Directory/Microsoft Entra ID user provisioning. These functions help transform and map data from Workday to create appropriate user attributes in Microsoft Entra ID.

author: jenniferf-skc
manager: pmwongera
ms.service: entra-id
ms.subservice: app-provisioning
ms.topic: reference
ms.date: 08/12/2025
ms.author: jfields
ms.reviewer: chmutali
ai-usage: ai-assisted
---

# Workday expression mapping functions for Microsoft Entra ID provisioning

This article provides a comprehensive guide to commonly used expression mapping functions when configuring Workday to on-premises Active Directory / Microsoft Entra ID user provisioning. These functions help transform and map data from Workday to create appropriate user attributes in Microsoft Entra ID.

## Table of contents

- [String manipulation functions](#string-manipulation-functions)
- [Email address generation](#email-address-generation)
- [Phone number processing](#phone-number-processing)
- [Account status logic for Active Directory](#account-status-logic-for-active-directory)
- [Account status logic for Microsoft Entra ID](#account-status-logic-for-microsoft-entra-id)
- [Date functions](#date-functions)
- [Organizational unit (OU) assignment](#organizational-unit-ou-assignment)
- [Random ID generation](#random-id-generation)
- [Name processing](#name-processing)
- [Advanced scenarios](#advanced-scenarios)

## String manipulation functions

### Basic string operations

...

### Text case conversion

...

### Country-specific naming logic

...

## Email address generation

### Basic email generation

...

### Company-specific email domains

...

### Proxyaddresses configuration

...

## Phone number processing

### International phone number parsing

...

### Phone number formatting for different systems

...

## Account status logic for Active Directory

### Basic account status management

...

### Rehire processing

...

### Pre-hire account creation

...

### Handling hire rescinds

...

## Account status logic for Microsoft Entra ID

### Basic account status management

...

### Rehire processing

...

### Pre-hire account creation

...

## Date functions

### Date formatting and conversion

...

### Conditional date-based logic

...

## Organizational unit (OU) assignment

### Simple OU assignment

...

### Complex OU structure

...

### Terminated user OU assignment

...

## Random ID generation

### Guid-based random generation

...

### Numeric ID generation

...

## Name processing

### Display name generation

...

### Common name (CN) generation with uniqueness

...

### Samaccountname generation

...

## Advanced scenarios

### Hide from address lists logic

...

### Multi-valued attribute setting

...

### Writeback scenarios

...

## Best practices

1. **Always use SelectUniqueValue** for attributes that require uniqueness (like UPN, samAccountName, email).

2. **Handle null and empty values** using functions like `IsNullOrEmpty`, `IsPresent`, or `Switch` statements.

3. **Use NormalizeDiacritics** when processing names with special characters to ensure compatibility.

4. **Test date logic thoroughly** as different time zones and date formats can affect results.

5. **Use IgnoreFlowIfNullOrEmpty** when you want to skip attribute updates for empty values.

6. **Consider using Switch instead of nested IIF** statements for better readability.

7. **Always validate regular expressions** in an online regex tester before implementing.

## Additional resources

- [Microsoft Entra ID Application Provisioning Functions Reference](functions-for-customizing-application-data.md)
- [Workday Integration Reference](~/saas-apps/workday-inbound-tutorial)
- [Expression Builder in Application Provisioning](functions-for-customizing-application-data.md#expression-builder)
