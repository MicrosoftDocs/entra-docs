---
title: 'SuccessFactors expression mapping functions for Microsoft Entra ID provisioning'
description: S comprehensive guide to commonly used expression mapping functions when configuring SuccessFactors to Microsoft Entra ID user provisioning. These functions help transform and map data from SuccessFactors to create appropriate user attributes in Microsoft Entra ID.

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

# SuccessFactors expression mapping functions for Microsoft Entra ID provisioning

This article provides a comprehensive guide to commonly used expression mapping functions when configuring SuccessFactors to Microsoft Entra ID user provisioning. These functions help transform and map data from SuccessFactors to create appropriate user attributes in Microsoft Entra ID.

## Table of contents

- [String manipulation functions](#string-manipulation-functions)
- [Email address generation](#email-address-generation)
- [Account management logic](#account-management-logic)
- [Date functions and account expiration](#date-functions-and-account-expiration)
- [Organizational unit (OU) assignment](#organizational-unit-ou-assignment)
- [Name processing and display names](#name-processing-and-display-names)
- [SamAccountName generation](#samaccountname-generation)
- [ProxyAddresses configuration](#proxyaddresses-configuration)
- [Phone number processing](#phone-number-processing)
- [Country and location-based logic](#country-and-location-based-logic)
- [Employee classification and contingent workers](#employee-classification-and-contingent-workers)
- [Advanced scenarios](#advanced-scenarios)

## String manipulation functions

### Basic string operations

**Scenario 1**: You want to pad a person ID with leading zeros to create an 8-character string.

**Target attribute**: employeeId

```
Replace(Join("","00000000",[personIdExternal]), ,"(.*?)(?<id>.{0,8})$", ,"${id}", ,)
```

**Example:**
- **Input Values**: [personIdExternal] = "12345"
- **Output of Expression**: `00012345`

**Scenario 2**: You need to pad cost center with leading zeros to make it 10 characters.

**Target attribute**: extensionAttribute1

```
Replace(Join("","0000000000",[costCenterId]), ,"(.*?)(?<id>.{0,10})$", ,"${id}", ,)
```

**Example:**
- **Input Values**: [costCenterId] = "567"
- **Output of Expression**: `0000000567`

**Scenario 3**: You want to create an employee ID by appending a prefix to a padded employee number.

**Target attribute**: employeeId

```
Append("05",Replace(Join("","000000",[employeeId]), ,"(.*?)(?<id>.{0,6})$", ,"${id}", ,))
```

**Example:**
- **Input Values**: [employeeId] = "789"
- **Output of Expression**: `05000789`

### Text case conversion

**Scenario 1**: You need to convert names from all uppercase to proper case (Title Case).

**Target attribute**: sn

```
Join("",Mid([lastName],1,1),ToLower(Mid([lastName],2,64)))
```

**Example:**
- **Input Values**: [lastName] = "JOHNSON"
- **Output of Expression**: `Johnson`

**Scenario 2**: You want to create a display name with proper case formatting.

**Target attribute**: displayName

```
Join(", ", Join("",Mid([lastName],1,1),ToLower(Mid([lastName],2,64))), Join("",Mid([firstName],1,1),ToLower(Mid([firstName],2,64))))
```

**Example:**
- **Input Values**: [lastName] = "SMITH", [firstName] = "JOHN"
- **Output of Expression**: `Smith, John`

**Scenario 3**: You need to handle names with spaces by replacing spaces with periods.

**Target attribute**: givenName

```
Replace([firstName]," ", , ,".", , )
```

**Example:**
- **Input Values**: [firstName] = "Mary Ann"
- **Output of Expression**: `Mary.Ann`

## Email address generation

### Basic email generation

**Scenario 1**: You want to generate email addresses using first name and last name with company-specific domains.

**Target attribute**: mail

```
SelectUniqueValue(
    Switch([company], 
        Join("@", NormalizeDiacritics(StripSpaces(Join(".", [firstName], [lastName]))), "contoso.com"),
        "Contoso", Join("@", NormalizeDiacritics(StripSpaces(Join(".", [firstName], [lastName]))), "contoso.com"),
        "Fabrikam", Join("@", NormalizeDiacritics(StripSpaces(Join(".", [firstName], [lastName]))), "fabrikam.com"),
        "Woodgrove", Join("@", NormalizeDiacritics(StripSpaces(Join(".", Mid([firstName],1,1), [lastName]))), "woodgrove.com")
    ),
    Switch([company], 
        Join("@", NormalizeDiacritics(StripSpaces(Join(".", [firstName], Mid([middleName],1,1), [lastName]))), "contoso.com"), 
        "Contoso", Join("@", NormalizeDiacritics(StripSpaces(Join(".", [firstName], Mid([middleName],1,1), [lastName]))), "contoso.com"), 
        "Fabrikam", Join("@", NormalizeDiacritics(StripSpaces(Join(".", [firstName], Mid([middleName],1,1), [lastName]))), "fabrikam.com"), 
        "Woodgrove", Join("@", NormalizeDiacritics(StripSpaces(Join(".", Mid([firstName],1,1), Mid([middleName],1,1), [lastName]))), "woodgrove.com")
    )
)
```

**Example:**
- **Input Values**: [company] = "Contoso", [firstName] = "John", [lastName] = "Smith", [middleName] = "Michael"
- **Output of Expression**: `john.smith@contoso.com` (or `john.m.smith@contoso.com` if first option is taken)

### Employee group-based email generation

**Scenario 1**: You want to generate different email formats based on employee classification (permanent vs. temporary).

**Target attribute**: userPrincipalName

```
StripSpaces(NormalizeDiacritics(Switch([custom06], 
    Join("", [firstName], ".", [lastName], "@ltts.com"), 
    "Temporary", Join("", [firstName], ".", [lastName], "_ext@ltts.com"), 
    "External", Join("", [firstName], ".", [lastName], "_ext@ltts.com"), 
    "Permanent", Join("", [firstName], ".", [lastName], "@ltts.com")
)))
```

**Example:**
- **Input Values**: [custom06] = "Temporary", [firstName] = "Sarah", [lastName] = "Wilson"
- **Output of Expression**: `sarah.wilson_ext@ltts.com`

### Corporate domain validation

**Scenario 1**: You want to only flow email addresses that belong to a specific corporate domain.

**Target attribute**: mail

```
IgnoreFlowIfNullOrEmpty(IIF(InStr([emailAddress],"@contoso.com")=0,"",[emailAddress]))
```

**Example:**
- **Input Values**: [emailAddress] = "john.doe@contoso.com"
- **Output of Expression**: `john.doe@contoso.com`
- **Alternative Input**: [emailAddress] = "john.doe@external.com"
- **Alternative Output**: *(empty - ignored)*

### Existing email preservation

**Scenario 1**: You want to use existing email from SuccessFactors for certain divisions, but generate new ones for others.

**Target attribute**: userPrincipalName

```
SelectUniqueValue(
    Switch([divisionId], 
        Join("@", NormalizeDiacritics(StripSpaces(Join(".", [firstName], [lastName]))), "contoso.com"), 
        "8900", [email]
    ), 
    Join("1@", NormalizeDiacritics(StripSpaces(Join(".", [firstName], [lastName]))), "contoso.com"), 
    Join("2@", NormalizeDiacritics(StripSpaces(Join(".", [firstName], [lastName]))), "contoso.com")
)
```

**Example:**
- **Input Values**: [divisionId] = "8900", [email] = "existing.user@company.com", [firstName] = "Mike", [lastName] = "Brown"
- **Output of Expression**: `existing.user@company.com`
- **Alternative Input**: [divisionId] = "1200", [firstName] = "Mike", [lastName] = "Brown"
- **Alternative Output**: `mike.brown@contoso.com`

## Account management logic

### Basic account status

**Scenario 1**: You want to determine if an account should be disabled based on employment status.

**Target attribute**: accountDisabled

```
Switch([emplStatus], "False", "741", "False", "749", "True", "746", "True")
```

**Example:**
- **Input Values**: [emplStatus] = "741"
- **Output of Expression**: `False` (account enabled)
- **Alternative Input**: [emplStatus] = "746"
- **Alternative Output**: `True` (account disabled)

### Hide from address lists logic

**Scenario 1**: You need to set the msExchHideFromAddressLists attribute based on start and end dates.

**Target attribute**: msExchHideFromAddressLists

```
IIF(DateDiff("d", CDate(IIF(IsPresent([startDate]), [startDate], DateAdd("d", "10", Now()))), Now()) >= -1, IIF(DateDiff("d", Now(), CDate(IIF(IsPresent([endDate]), [endDate], DateAdd("d", "1", Now())))) >= 0, "FALSE", "TRUE"), "TRUE")
```

**Example:**
- **Input Values**: [startDate] = "2025-01-15", [endDate] = "2025-12-31" (current date: 2025-07-30)
- **Output of Expression**: `FALSE` (not hidden from address lists)
- **Alternative Input**: [startDate] = "2025-01-15", [endDate] = "2025-06-30"
- **Alternative Output**: `TRUE` (hidden from address lists)

### Complex employee status logic

**Scenario 1**: You have a complex requirement to disable accounts based on custom fields and hire dates.

**Target attribute**: accountEnabled

```
Switch([empNavCustomString3], "True",
"62220", Switch([cust_hiredate], 
    IIF(DateDiff("d", CDate([cust_hiredate]), Now()) = 3, 
        Switch([cust_customDate67], 
            IIF(DateDiff("d", CDate([cust_customDate67]), Now())=0, "False", "True"),
            "", "False" 
        ), "True"
    ),
    "", "True"
))
```

**Example:**
- **Input Values**: [empNavCustomString3] = "62220", [cust_hiredate] = "2025-07-27", [cust_customDate67] = "2025-07-30" (current date: 2025-07-30)
- **Output of Expression**: `False` (account enabled)
- **Alternative Input**: [empNavCustomString3] = "62220", [cust_hiredate] = "2025-07-27", [cust_customDate67] = "2025-07-29"
- **Alternative Output**: `True` (account disabled)

## Date functions and account expiration

### Basic account expiration

**Scenario 1**: You want to set account expiration based on the end date from SuccessFactors.

**Target attribute**: accountExpires

```
Switch([endDate], 
    NumFromDate(Join("", FormatDateTime([endDate], "M/d/yyyy hh:mm:ss tt", "yyyy-MM-dd"), " 23:59:59-05:00")), 
    "", "9223372036854775807"
)
```

**Example:**
- **Input Values**: [endDate] = "12/31/2025 12:00:00 AM"
- **Output of Expression**: `133835135990000000` (numeric representation of 2025-12-31 23:59:59-05:00)
- **Alternative Input**: [endDate] = "" (empty)
- **Alternative Output**: `9223372036854775807` (never expires)

### Employment type-based expiration

**Scenario 1**: You need to set different account expiration rules based on employment type (permanent vs. contractor).

**Target attribute**: accountExpires

```
Switch([employmentType], 
    NumFromDate(Join("",FormatDateTime([endDate], ,"M/d/yyyy hh:mm:ss tt","yyyy-MM-dd")," 23:59:59-05:00")),
    "PM", NumFromDate(Join("",FormatDateTime(DateAdd("yyyy", 60, CDate([DOB])), ,"M/d/yyyy hh:mm:ss tt","yyyy-MM-dd")," 23:59:59-05:00")),
    "CON", NumFromDate(Join("",FormatDateTime([endDate], ,"M/d/yyyy hh:mm:ss tt","yyyy-MM-dd")," 23:59:59-05:00"))
)
```

**Example:**
- **Input Values**: [employmentType] = "PM", [DOB] = "1/15/1990 12:00:00 AM"
- **Output of Expression**: `158488415990000000` (numeric representation of 2050-01-15 23:59:59-05:00, 60 years after birth)
- **Alternative Input**: [employmentType] = "CON", [endDate] = "12/31/2025 12:00:00 AM"
- **Alternative Output**: `133835135990000000` (numeric representation of 2025-12-31 23:59:59-05:00)

### Event reason-based account expiration

**Scenario 1**: You want to set account expiration based on specific termination events and severance dates.

**Target attribute**: accountExpires

```
Switch([event], 
    IIF(IsPresent([latestTerminationDate]), NumFromDate(Join("", FormatDateTime([latestTerminationDate], , "M/d/yyyy hh:mm:ss tt", "yyyy-MM-dd"), " 23:59:59-08:00")), "9223372036854775807"), 
    "SEVUNSATP", NumFromDate(Join("", FormatDateTime([severanceStartDate], , "M/d/yyyy hh:mm:ss tt", "yyyy-MM-dd"), " 23:59:59-08:00")), 
    "SEVPOSELIM", NumFromDate(Join("", FormatDateTime([severanceStartDate], , "M/d/yyyy hh:mm:ss tt", "yyyy-MM-dd"), " 23:59:59-08:00")), 
    "POSELIM", NumFromDate(Join("", FormatDateTime([severanceStartDate], , "M/d/yyyy hh:mm:ss tt", "yyyy-MM-dd"), " 23:59:59-08:00"))
)
```

**Example:**
- **Input Values**: [event] = "SEVUNSATP", [severanceStartDate] = "8/15/2025 12:00:00 AM"
- **Output of Expression**: `133877247990000000` (numeric representation of 2025-08-15 23:59:59-08:00)
- **Alternative Input**: [event] = "REGULAR", [latestTerminationDate] = "9/30/2025 12:00:00 AM"
- **Alternative Output**: `133886207990000000` (numeric representation of 2025-09-30 23:59:59-08:00)

### Date format handling

**Scenario 1**: You need to handle invalid dates like "12/31/9999" that cause errors in NumFromDate.

**Target attribute**: accountExpires

```
Switch([endDate],
    NumFromDate(Join("", FormatDateTime([endDate], "M/d/yyyy hh:mm:ss tt", "yyyy-MM-dd"), "T23:59:59-04:00")),
    "12/31/9999 12:00:00 AM", NumFromDate("2099-12-31T23:59:59-04:00")
)
```

**Example:**
- **Input Values**: [endDate] = "12/31/9999 12:00:00 AM"
- **Output of Expression**: `441481535990000000` (numeric representation of 2099-12-31T23:59:59-04:00)
- **Alternative Input**: [endDate] = "8/15/2025 12:00:00 AM"
- **Alternative Output**: `133877283990000000` (numeric representation of 2025-08-15T23:59:59-04:00)

## Organizational unit (OU) assignment

### Department-based OU assignment

**Scenario 1**: You want to place users in different OUs based on their department.

**Target attribute**: parentDistinguishedName

```
Switch([department], "OU=SuccessFactors,DC=contoso,DC=com", 
    "Engineering SG", "OU=Engineering,OU=SuccessFactors,DC=contoso,DC=com", 
    "Shared Services", "OU=Shared Services,OU=SuccessFactors,DC=contoso,DC=com", 
    "Retail - Finance", "OU=Retail Finance,OU=SuccessFactors,DC=contoso,DC=com", 
    "Information Technology BR", "OU=Information Technology,OU=SuccessFactors,DC=contoso,DC=com", 
    "Development", "OU=Development,OU=SuccessFactors,DC=contoso,DC=com"
)
```

**Example:**
- **Input Values**: [department] = "Engineering SG"
- **Output of Expression**: `OU=Engineering,OU=SuccessFactors,DC=contoso,DC=com`
- **Alternative Input**: [department] = "Marketing"
- **Alternative Output**: `OU=SuccessFactors,DC=contoso,DC=com` (default)

### Employment status-based OU assignment

**Scenario 1**: You need to assign users to different OUs based on their employment status and location.

**Target attribute**: parentDistinguishedName

```
Join("",
Switch([emplStatus], "OU=SFProvisoinngUsers", 
"741", Switch([empJobNavCustomString13],
    "OU=SFProvisoinngUsers",
    "LOC1016", "OU=Mysore",
    "LOC1019", "OU=Baroda",
    "LOC1015", Switch([departmentId],
        "OU=Bangalore",
        "DU1026","OU=IT,OU=Bangalore",
        "DU1025","OU=IT,OU=Bangalore"
        )
    ), 
"749", Switch([empJobNavCustomString13],
    "OU=O365-NoSYNC,OU=SFProvisoinngUsers",
    "LOC1016", "OU=O365-NoSYNC,OU=Mysore",
    "LOC1019", "OU=O365-NoSYNC,OU=Baroda",
    "LOC1015", "OU=O365-NoSYNC,OU=Bangalore"
    )
),
",DC=contoso,DC=com")
```

**Example:**
- **Input Values**: [emplStatus] = "741", [empJobNavCustomString13] = "LOC1015", [departmentId] = "DU1026"
- **Output of Expression**: `OU=IT,OU=Bangalore,DC=contoso,DC=com`
- **Alternative Input**: [emplStatus] = "749", [empJobNavCustomString13] = "LOC1016"
- **Alternative Output**: `OU=O365-NoSYNC,OU=Mysore,DC=contoso,DC=com`
- **Alternative Input**: [emplStatus] = "741", [empJobNavCustomString13] = "LOC9999" (not defined)
- **Alternative Output**: `OU=SFProvisoinngUsers,DC=contoso,DC=com` (default)

### Country-based OU assignment

**Scenario 1**: You want to place users in different OUs based on their country with a disabled OU for inactive users.

**Target attribute**: parentDistinguishedName

```
Switch([activeEmploymentsCount],
    Switch([country], "OU=Accounts,DC=corp,DC=contoso,DC=com", 
        "Mexico", "OU=Mexico,OU=Accounts,DC=corp,DC=contoso,DC=com", 
        "Sweden", "OU=Sweden,OU=Accounts,DC=corp,DC=contoso,DC=com", 
        "Colombia", "OU=Internal Accounts,OU=Colombia,OU=Accounts,DC=corp,DC=contoso,DC=com", 
        "Brazil", "OU=Internal Accounts,OU=Brazil,OU=Accounts,DC=corp,DC=contoso,DC=com"
    ),
    "0", "OU=DisabledAccounts,OU=Accounts,DC=corp,DC=contoso,DC=com"
)
```

**Example:**
- **Input Values**: [activeEmploymentsCount] = "1", [country] = "Mexico"
- **Output of Expression**: `OU=Mexico,OU=Accounts,DC=corp,DC=contoso,DC=com`
- **Alternative Input**: [activeEmploymentsCount] = "0", [country] = "Sweden"
- **Alternative Output**: `OU=DisabledAccounts,OU=Accounts,DC=corp,DC=contoso,DC=com` (disabled users go to special OU regardless of country)
- **Alternative Input**: [activeEmploymentsCount] = "1", [country] = "Germany"
- **Alternative Output**: `OU=Accounts,DC=corp,DC=contoso,DC=com` (default OU for countries not specifically defined)

## Name processing and display names

### Common name (CN) generation

**Scenario 1**: You want to generate a unique common name with fallback options for duplicates.

**Target attribute**: cn

```
SelectUniqueValue(
    NormalizeDiacritics(Join(" ", [firstName], [lastName])),
    NormalizeDiacritics(Join(" ", [firstName], Mid([middleName],1,1), [lastName])),
    NormalizeDiacritics(Join(" ", [firstName], [middleName], [lastName]))
)
```

**Example:**
- **Input Values**: [firstName] = "José", [lastName] = "García", [middleName] = "Antonio"
- **Output of Expression**: `Jose Garcia` (or `Jose A Garcia` if first option is taken, or `Jose Antonio Garcia` if first two are taken)

### Display name with preferred names

**Scenario 1**: You need to create a display name that uses preferred name when available, otherwise falls back to first name.

**Target attribute**: displayName

```
Join(", ", Join("", Mid([lastName], 1, 1), ToLower(Mid([lastName], 2, 64), )), Join("", Mid(Coalesce([preferredName], [firstName]), 1, 1), ToLower(Mid(Coalesce([preferredName], [firstName]), 2, 64), )))
```

**Example:**
- **Input Values**: [lastName] = "JOHNSON", [preferredName] = "Mike", [firstName] = "Michael"
- **Output of Expression**: `Johnson, Mike`
- **Alternative Input**: [lastName] = "SMITH", [preferredName] = "", [firstName] = "Robert"
- **Alternative Output**: `Smith, Robert`

### Display name with numeric suffixes

**Scenario 1**: You want to generate unique display names with numeric suffixes for duplicates.

**Target attribute**: displayName

```
SelectUniqueValue(
    Join("", NormalizeDiacritics(Join("", [lastName], ", ")), NormalizeDiacritics(Switch([preferredName], [preferredName], "", [firstName]))), 
    Join("", NormalizeDiacritics(Join("", [lastName], "2, ")), NormalizeDiacritics(Switch([preferredName], [preferredName], "", [firstName]))), 
    Join("", NormalizeDiacritics(Join("", [lastName], "3, ")), NormalizeDiacritics(Switch([preferredName], [preferredName], "", [firstName]))), 
    Join("", NormalizeDiacritics(Join("", [lastName], "4, ")), NormalizeDiacritics(Switch([preferredName], [preferredName], "", [firstName])))
)
```

**Example:**
- **Input Values**: [lastName] = "García", [preferredName] = "Mike", [firstName] = "Michael"
- **Output of Expression**: `Garcia, Mike` (or `Garcia2, Mike` if first option is taken, etc.)
- **Alternative Input**: [lastName] = "Smith", [preferredName] = "", [firstName] = "John"
- **Alternative Output**: `Smith, John` (or `Smith2, John` if first option is taken, etc.)

## SamAccountName generation

### Basic samAccountName generation

**Scenario 1**: You want to create a samAccountName using first initial and last name with proper character sanitization.

**Target attribute**: sAMAccountName

```
SelectUniqueValue(
    Replace(Mid(Replace(NormalizeDiacritics(StripSpaces(Join("", Mid([firstName],1,1), [lastName]))), , "([\\/\\\\\\[\\]\\:\\;\\|\\=\\,\\+\\*\\?\\<\\>])", , "", , ), 1, 20), , "(\\.)*$", , "", , ),
    Join("",Replace(Mid(Replace(NormalizeDiacritics(StripSpaces(Join("", Mid([firstName],1,1), [lastName]))), , "([\\/\\\\\\[\\]\\:\\;\\|\\=\\,\\+\\*\\?\\<\\>])", , "", , ), 1, 19), , "(\\.)*$", , "", , ),"1"),
    Join("",Replace(Mid(Replace(NormalizeDiacritics(StripSpaces(Join("", Mid([firstName],1,1), [lastName]))), , "([\\/\\\\\\[\\]\\:\\;\\|\\=\\,\\+\\*\\?\\<\\>])", , "", , ), 1, 19), , "(\\.)*$", , "", , ),"2")
)
```

**Example:**
- **Input Values**: [firstName] = "José", [lastName] = "García-López"
- **Output of Expression**: `jgarcialopez` (or `jgarcialopez1` if first option is taken, or `jgarcialopez2` if first two are taken)

### SamAccountName with variable first name length

**Scenario 1**: You want to handle duplicates by increasing the number of characters from the first name.

**Target attribute**: sAMAccountName

```
SelectUniqueValue(
    Replace(Mid(Replace(NormalizeDiacritics(StripSpaces(Join("", Mid([firstName],1,1), [lastName]))), , "([\\/\\\\\\[\\]\\:\\;\\|\\=\\,\\+\\*\\?\\<\\>])", , "", , ), 1, 20), , "(\\.)*$", , "", , ),
    Replace(Mid(Replace(NormalizeDiacritics(StripSpaces(Join("", Mid([firstName],1,2), [lastName]))), , "([\\/\\\\\\[\\]\\:\\;\\|\\=\\,\\+\\*\\?\\<\\>])", , "", , ), 1, 20), , "(\\.)*$", , "", , ),
    Replace(Mid(Replace(NormalizeDiacritics(StripSpaces(Join("", Mid([firstName],1,3), [lastName]))), , "([\\/\\\\\\[\\]\\:\\;\\|\\=\\,\\+\\*\\?\\<\\>])", , "", , ), 1, 20), , "(\\.)*$", , "", , )
)
```

**Example:**
- **Input Values**: [firstName] = "Christopher", [lastName] = "Anderson"
- **Output of Expression**: `canderson` (or `chanderson` if first option is taken, or `chranderson` if first two are taken)
- **Alternative Input**: [firstName] = "María", [lastName] = "Rodríguez-Santos"
- **Alternative Output**: `mrodriguezsantos` (or `marodriguezsantos` if first option is taken, or `marrodriguezsantos` if first two are taken)

### SamAccountName from external username

**Scenario 1**: You want to extract the username portion from an email-style external username.

**Target attribute**: sAMAccountName

```
Replace(Mid(Replace(Replace([username],,"(?<id>.*)@(?<domain>.*)",,"${id}",,), , "([\\/\\\\\\[\\]\\:\\;\\|\\=\\,\\+\\*\\?\\<\\>])", , "", , ), 1, 20), , "(\\.)*$", , "", , )
```

**Example:**
- **Input Values**: [username] = "john.smith@external.com"
- **Output of Expression**: `johnsmith`

## ProxyAddresses configuration

### Basic proxyAddresses setup

**Scenario 1**: You want to set multiple proxy addresses including primary and secondary SMTP addresses.

**Target attribute**: proxyAddresses

```
Split(
    Join(",", 
        Append("smtp:", Join("@", NormalizeDiacritics(StripSpaces(Join("", "A", [personIdExternal]))), "contoso.mail.onmicrosoft.com")), 
        Append("smtp:", Join("@", NormalizeDiacritics(StripSpaces(Join("", "A", [personIdExternal]))), "contoso.com")), 
        Append("SMTP:", Join("@", Join(".", StripSpaces([firstName]), StripSpaces([lastName])), "contoso.com"))
    ), 
    ","
)
```

**Example:**
- **Input Values**: [personIdExternal] = "12345", [firstName] = "John", [lastName] = "Smith"
- **Output of Expression**: `["smtp:A12345@contoso.mail.onmicrosoft.com", "smtp:A12345@contoso.com", "SMTP:John.Smith@contoso.com"]`

### Division-based proxyAddresses

**Scenario 1**: You need different proxy address configurations based on employee division.

**Target attribute**: proxyAddresses

```
Split(
    Switch([divisionId], 
        Join(",", 
            Append("smtp:", Join("@", NormalizeDiacritics(StripSpaces(Join("", "A", [personIdExternal]))), "woodgrove.mail.onmicrosoft.com")), 
            Append("smtp:", Join("@", NormalizeDiacritics(StripSpaces(Join("", "A", [personIdExternal]))), "woodgrove.com")), 
            Append("SMTP:", Join("@", Join(".", StripSpaces([firstName]), StripSpaces([lastName])), "woodgrove.com"))
        ),			
        "EXEC", Join(",", 
            Append("smtp:", Join("@", Join(".", StripSpaces([firstName]), StripSpaces([lastName])), "contoso.com")), 
            Append("SMTP:", [email])
        )
    ),
    ","	
)
```

**Example:**
- **Input Values**: [divisionId] = "STANDARD", [personIdExternal] = "67890", [firstName] = "Sarah", [lastName] = "Johnson"
- **Output of Expression**: `["smtp:A67890@woodgrove.mail.onmicrosoft.com", "smtp:A67890@woodgrove.com", "SMTP:Sarah.Johnson@woodgrove.com"]`
- **Alternative Input**: [divisionId] = "EXEC", [firstName] = "Michael", [lastName] = "Brown", [email] = "mbrown@fabrikam.com"
- **Alternative Output**: `["smtp:Michael.Brown@contoso.com", "SMTP:mbrown@fabrikam.com"]`

### Company-specific proxyAddresses

**Scenario 1**: You want to generate proxy addresses based on company affiliation.

**Target attribute**: proxyAddresses

```
SelectUniqueValue (
    Switch([company], 
        Append ("SMTP:", Join("@", NormalizeDiacritics(StripSpaces(Join(".", [firstName], [lastName]))), "contoso.com")),
        "NGC", Append ("SMTP:", Join("@", NormalizeDiacritics(StripSpaces(Join(".", [firstName], [lastName]))), "contoso.com")),
        "CNG", Append ("SMTP:", Join("@", NormalizeDiacritics(StripSpaces(Join(".", [firstName], [lastName]))), "contoso.com")),
        "National Energy", Append ("SMTP:", Join("@", NormalizeDiacritics(StripSpaces(Join(".", Mid([firstName],1,1), [lastName]))), "fabrikam.com"))
    ),
    Switch([company], 
        Append ("SMTP:", Join("@", NormalizeDiacritics(StripSpaces(Join(".", [firstName], Mid([middleName],1,1), [lastName]))), "contoso.com")), 
        "NGC", Append ("SMTP:", Join("@", NormalizeDiacritics(StripSpaces(Join(".", [firstName], Mid([middleName],1,1), [lastName]))), "contoso.com")), 
        "CNG", Append ("SMTP:", Join("@", NormalizeDiacritics(StripSpaces(Join(".", [firstName], Mid([middleName],1,1), [lastName]))), "contoso.com")), 
        "National Energy", Append ("SMTP:", Join("@", NormalizeDiacritics(StripSpaces(Join(".", Mid([firstName],1,1), Mid([middleName],1,1), [lastName]))), "fabrikam.com"))
    )
)
```

**Example:**
- **Input Values**: [company] = "NGC", [firstName] = "Trinidad", [lastName] = "Williams", [middleName] = "James"
- **Output of Expression**: `SMTP:trinidad.williams@contoso.com` (or `SMTP:trinidad.j.williams@contoso.com` if first option is taken)
- **Alternative Input**: [company] = "National Energy", [firstName] = "Rebecca", [lastName] = "Thompson", [middleName] = "Marie"
- **Alternative Output**: `SMTP:r.thompson@fabrikam.com` (or `SMTP:r.m.thompson@fabrikam.com` if first option is taken)
- **Alternative Input**: [company] = "Other Company", [firstName] = "David", [lastName] = "Jones", [middleName] = "Paul"
- **Alternative Output**: `SMTP:david.jones@contoso.com` (default domain, or `SMTP:david.p.jones@contoso.com` if first option is taken)

## Phone number processing

### Basic phone number extraction

**Scenario 1**: You want to extract the phone number portion without the country code.

**Target attribute**: telephoneNumber

```
Replace(Replace([mobile], , "\\+(?<isdCode>\\d* )(?<phoneNumber>.*)", , "${phoneNumber}", , ), ,"[()\\s-]+", ,"", , )
```

**Example:**
- **Input Values**: [mobile] = "+1 (555) 123-4567"
- **Output of Expression**: `5551234567`

**Scenario 2**: You need to extract just the country code from a phone number.

**Target attribute**: c

```
Replace(Replace([mobile], , "\\+(?<isdCode>\\d* )(?<phoneNumber>.*)", , "${isdCode}", , ), ,"[()\\s-]+", ,"", , )
```

**Example:**
- **Input Values**: [mobile] = "+44 20 7946 0958"
- **Output of Expression**: `44`

### Phone number defaults

**Scenario 1**: You want to provide default phone numbers when the field is empty.

**Target attribute**: telephoneNumber

```
IIF(IsNullOrEmpty([telephoneNumber]),"000-000-0000",[telephoneNumber])
Switch([mobile],[mobile],"","000-000-0000")
```

**Example:**
- **Input Values**: [telephoneNumber] = ""
- **Output of Expression**: `000-000-0000`
- **Alternative Input**: [mobile] = "555-123-4567"
- **Alternative Output**: `555-123-4567`

### Primary phone logic

**Scenario 1**: You need to determine which phone number should be marked as primary.

**Target attribute**: extensionAttribute2

```
Switch(Join("+",Switch([businessPhoneIsPrimary],[businessPhoneIsPrimary],"","other"),Switch([cellPhoneIsPrimary],[cellPhoneIsPrimary],"","other")), "no primary phone", 
"false+false", "no primary phone",
"true+false", "business phone is primary",
"false+true", "cell phone is primary",
"true+true", "business phone is primary, cell phone is primary",
"other+true", "cell phone is primary",
"other+false", "no primary phone",
"true+other", "business phone is primary",
"false+other", "no primary phone")
```

**Example:**
- **Input Values**: [businessPhoneIsPrimary] = "true", [cellPhoneIsPrimary] = "false"
- **Output of Expression**: `business phone is primary`
- **Alternative Input**: [businessPhoneIsPrimary] = "false", [cellPhoneIsPrimary] = "true"
- **Alternative Output**: `cell phone is primary`
- **Alternative Input**: [businessPhoneIsPrimary] = "", [cellPhoneIsPrimary] = "true"
- **Alternative Output**: `cell phone is primary`

## Country and location-based logic

### Country code mapping

**Scenario 1**: You want to map country names to ISO country codes.

**Target attribute**: c

```
Switch([country], ,
  "Trinidad and Tobago", "TT",
  "Barbados", "BB"
)
```

**Example:**
- **Input Values**: [country] = "Trinidad and Tobago"
- **Output of Expression**: `TT`

**Scenario 2**: You need to map countries to numeric country codes.

**Target attribute**: countryCode

```
Switch([country], ,
  "Trinidad and Tobago", "780",
  "Barbados", "52"
)
```

**Example:**
- **Input Values**: [country] = "Barbados"
- **Output of Expression**: `52`

### Location-based email domains

**Scenario 1**: You want to assign different email domains based on geographical location.

**Target attribute**: mail

```
SelectUniqueValue (
    Switch([country], 
        Join("@", NormalizeDiacritics(StripSpaces(Join("", [firstName], [lastName]))), "fabrikam.com"),
        "India", Join("@", NormalizeDiacritics(StripSpaces(Join("", [firstName], [lastName]))), "fabrikam.com"),
        "Netherlands", Join("@", NormalizeDiacritics(StripSpaces(Join("", [firstName], [lastName]))), "contoso.com")
    ),
    Switch([country], 
        Join("1@", NormalizeDiacritics(StripSpaces(Join("", [firstName], [lastName]))), "fabrikam.com"),
        "India", Join("1@", NormalizeDiacritics(StripSpaces(Join("", [firstName], [lastName]))), "fabrikam.com"),
        "Netherlands", Join("1@", NormalizeDiacritics(StripSpaces(Join("", [firstName], [lastName]))), "contoso.com")
    )
)
```

**Example:**
- **Input Values**: [country] = "India", [firstName] = "Raj", [lastName] = "Patel"
- **Output of Expression**: `raj.patel@fabrikam.com` (or `1raj.patel@fabrikam.com` if first option is taken)
- **Alternative Input**: [country] = "Netherlands", [firstName] = "Jan", [lastName] = "van der Berg"
- **Alternative Output**: `jan.vanderberg@contoso.com` (or `1jan.vanderberg@contoso.com` if first option is taken)
- **Alternative Input**: [country] = "Germany", [firstName] = "Klaus", [lastName] = "Müller"
- **Alternative Output**: `klaus.muller@fabrikam.com` (default domain, or `1klaus.muller@fabrikam.com` if first option is taken)

## Employee classification and contingent workers

### Employment type classification

**Scenario 1**: You want to map employee type codes to readable descriptions.

**Target attribute**: extensionAttribute3

```
Switch([employeeType],"Default-value",
    "31202","Employee",
    "31230","Contractor"
)
```

**Example:**
- **Input Values**: [employeeType] = "31202"
- **Output of Expression**: `Employee`
- **Alternative Input**: [employeeType] = "99999"
- **Alternative Output**: `Default-value`

### Contingent worker identification

**Scenario 1**: You need to identify and handle contingent workers differently.

**Target attribute**: extensionAttribute4

```
Switch([isContingentWorker], "N/A", "True", "Contractor", "False", "Employee")
```

**Example:**
- **Input Values**: [isContingentWorker] = "True"
- **Output of Expression**: `Contractor`

### Personal title mapping

**Scenario 1**: You want to map personal title codes to proper titles.

```
IgnoreFlowIfNullOrEmpty(Switch([personalTitle], "", "4443", "Dr.", "4444", "Prof.", "4445", "Prof. Dr."))
```

**Example:**
- **Input Values**: [personalTitle] = "4443"
- **Output of Expression**: `Dr.`
- **Alternative Input**: [personalTitle] = ""
- **Alternative Output**: *(empty - ignored)*

## Advanced scenarios

### Conditional department handling

**Scenario 1**: You want to use global assignment department when available, otherwise fall back to regular department.

**Target attribute**: department

```
Switch([globalAssignmentDepartment],[globalAssignmentDepartment],
"",[department])
```

**Example:**
- **Input Values**: [globalAssignmentDepartment] = "Global IT", [department] = "Local IT"
- **Output of Expression**: `Global IT`
- **Alternative Input**: [globalAssignmentDepartment] = "", [department] = "Sales"
- **Alternative Output**: `Sales`

### Soft delete email handling

**Scenario 1**: You need to modify email addresses when users are soft deleted for writeback scenarios.

**Target attribute**: mail

```
IIF([IsSoftDeleted]="True", Join("_",FormatDateTime(Now(), , "M/d/yyyy h:mm:ss tt", "yyyy-MM-dd"),[mail]), [mail])
```

**Example:**
- **Input Values**: [IsSoftDeleted] = "True", [mail] = "john.smith@company.com" (current date: 2025-07-30)
- **Output of Expression**: `2025-07-30_john.smith@company.com`
- **Alternative Input**: [IsSoftDeleted] = "False", [mail] = "jane.doe@company.com"
- **Alternative Output**: `jane.doe@company.com`

### Complex OU assignment with termination logic

**Scenario 1**: You want to move terminated users to a special OU after a specific number of days.

**Target attribute**: parentDistinguishedName

```
IIF(DateDiff("d", Now(), CDate(Switch([latestTerminationDate], [latestTerminationDate], "", "9999-01-01"))) <= -14,
    "OU=DELETED,DC=company,DC=com",
    Switch([department], "OU=Default,DC=company,DC=com", 
        "Engineering", "OU=Engineering,DC=company,DC=com", 
        "Finance", "OU=Finance,DC=company,DC=com"
    )
)
```

**Example:**
- **Input Values**: [latestTerminationDate] = "2025-07-10", [department] = "Engineering" (current date: 2025-07-30)
- **Output of Expression**: `OU=DELETED,DC=company,DC=com` (terminated more than 14 days ago)
- **Alternative Input**: [latestTerminationDate] = "2025-07-25", [department] = "Finance"
- **Alternative Output**: `OU=Finance,DC=company,DC=com` (terminated less than 14 days ago)

### Multi-company UPN generation with employee class

**Scenario 1**: You need to generate UPNs based on both company and employee class information.

**Target attribute**: userPrincipalName

```
SelectUniqueValue (
    Switch([employeeClass], 
        Join("@", NormalizeDiacritics(StripSpaces(Join(".", [firstName], [lastName]))), "contoso.com"),
        "1916", Join("@", NormalizeDiacritics(StripSpaces(Join(".", [firstName], [lastName]))), "contoso.com"),
        "1915", Join("@", NormalizeDiacritics(StripSpaces(Join(".", [firstName], [lastName]))), "fabrikam.com"),
        "1917", Join("@", NormalizeDiacritics(StripSpaces(Join(".", Mid([firstName],1,1), [lastName]))), "woodgrove.com")
    ),
    Switch([employeeClass], 
        Join("01@", NormalizeDiacritics(StripSpaces(Join(".", [firstName], [lastName]))), "contoso.com"),
        "1916", Join("01@", NormalizeDiacritics(StripSpaces(Join(".", [firstName], [lastName]))), "contoso.com"),
        "1915", Join("01@", NormalizeDiacritics(StripSpaces(Join(".", [firstName], [lastName]))), "fabrikam.com"),
        "1917", Join("01@", NormalizeDiacritics(StripSpaces(Join(".", Mid([firstName],1,1), [lastName]))), "woodgrove.com")
    )
)
```

**Example:**
- **Input Values**: [employeeClass] = "1915", [firstName] = "Anna", [lastName] = "Johnson"
- **Output of Expression**: `anna.johnson@fabrikam.com` (or `01anna.johnson@fabrikam.com` if first option is taken)

### Apostrophe and special character handling

**Scenario 1**: You need to remove apostrophes and dashes from email addresses for AAD Connect compatibility.

**Target attribute**: mail

```
SelectUniqueValue(
  Switch ([divisionId], 
    Replace(Join("@", NormalizeDiacritics(StripSpaces(Join(".", Coalesce([preferredName], [firstName]), [lastName]))), "contoso.com"), , "['-]+", , "", , ), 
    "8900", [email]
  ), 
  Replace(Join("1@", NormalizeDiacritics(StripSpaces(Join(".", Coalesce([preferredName], [firstName]), [lastName]))), "contoso.com"), , "['-]+", , "", , ), 
  Replace(Join("2@", NormalizeDiacritics(StripSpaces(Join(".", Coalesce([preferredName], [firstName]), [lastName]))), "contoso.com"), , "['-]+", , "", , )
)
```

**Example:**
- **Input Values**: [divisionId] = "1200", [preferredName] = "Mary-Ann", [firstName] = "Mary", [lastName] = "O'Connor"
- **Output of Expression**: `maryann.oconnor@contoso.com` (apostrophes and dashes removed)
- **Alternative Input**: [divisionId] = "8900", [email] = "existing.user@company.com"
- **Alternative Output**: `existing.user@company.com`

### SIP address generation

**Scenario 1**: You want to generate SIP addresses for Skype for Business/Teams integration.

**Target attribute**: proxyAddresses

```
SelectUniqueValue( 
    Append("sip:", Join("@", NormalizeDiacritics(StripSpaces(Join(".", [firstName], [lastName]))), "contoso.com")),
    Append("sip:", Join("01@", NormalizeDiacritics(StripSpaces(Join(".", [firstName], [lastName]))), "contoso.com")),
    Append("sip:", Join("02@", NormalizeDiacritics(StripSpaces(Join(".", [firstName], [lastName]))), "contoso.com"))
)
```

**Example:**
- **Input Values**: [firstName] = "David", [lastName] = "Wilson"
- **Output of Expression**: `sip:david.wilson@contoso.com` (or `sip:01david.wilson@contoso.com` if first option is taken)
- **Alternative Input**: [firstName] = "María José", [lastName] = "González-Pérez"
- **Alternative Output**: `sip:mariajose.gonzalezperez@contoso.com` (or `sip:01mariajose.gonzalezperez@contoso.com` if first option is taken, or `sip:02mariajose.gonzalezperez@contoso.com` if first two are taken)

### Writeback conditional logic

**Scenario 1**: You want to conditionally write back email addresses based on specific date criteria.

**Target attribute**: mailNickname

```
IgnoreFlowIfNullOrEmpty(IIF(DateDiff("d", Now(), CDate([extensionAttribute9])) <> 1, "", [mail]))
```

**Example:**
- **Input Values**: [extensionAttribute9] = "2025-07-31", [mail] = "user@company.com" (current date: 2025-07-30)
- **Output of Expression**: *(empty - ignored, as date difference is 1 day)*
- **Alternative Input**: [extensionAttribute9] = "2025-08-01", [mail] = "user@company.com"
- **Alternative Output**: `user@company.com`

**Scenario 2**: You need to handle missing attributes in writeback scenarios.

**Target attribute**: mailNickname

```
IgnoreFlowIfNullOrEmpty(IIF(IsPresent([extensionAttribute9]),IIF(DateDiff("d", Now(), CDate([extensionAttribute9])) <> 1, "", [mail]),"noemail@contoso.com"))
```

**Example:**
- **Input Values**: [extensionAttribute9] = "" (empty), [mail] = "user@company.com"
- **Output of Expression**: `noemail@contoso.com`
- **Alternative Input**: [extensionAttribute9] = "2025-08-01", [mail] = "user@company.com" (current date: 2025-07-30)
- **Alternative Output**: `user@company.com`

## Best practices

1. **Use SelectUniqueValue** for all attributes that require uniqueness (UPN, samAccountName, email).

2. **Handle null and empty values** using functions like `IsNullOrEmpty`, `IsPresent`, `Switch`, or `Coalesce`.

3. **Use NormalizeDiacritics and StripSpaces** when processing names to ensure compatibility across systems.

4. **Validate JSONPath expressions** in a JSONPath tester before implementing in production.

5. **Use proper date formatting** when working with SuccessFactors date fields to avoid conversion errors.

6. **Consider time zones** when working with date comparisons and account expiration logic.

7. **Use IgnoreFlowIfNullOrEmpty** for conditional attribute flows and writeback scenarios.

8. **Test complex Switch statements** thoroughly as they can become difficult to debug.

9. **Document business logic** clearly, especially for complex employment status and account management rules.

10. **Use regex patterns carefully** and validate them in online regex testers before implementation.

## Additional resources

- [Microsoft Entra ID Application Provisioning Functions Reference](functions-for-customizing-application-data.md)
- [SuccessFactors Integration Reference](~/sap-successfactors-inbound-provisioning-tutorial)
- [JSONPath Expression Guide](https://goessner.net/articles/JsonPath/)
- [Expression Builder in Application Provisioning](expression-builder.md)

