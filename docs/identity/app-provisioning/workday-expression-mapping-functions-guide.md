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

## String manipulation functions

### Basic string operations

**Scenario 1**: You want to clean up a phone number value coming from Workday by removing spaces, brackets, and dashes.

**Target attribute**: telephoneNumber, mobile

```
Replace([PrimaryWorkTelephone], , "[()\\s-]+", , "", , )
Replace([Mobile], , "[()\\s-]+", , "", , )
```

**Example:**
- **Input Values**: [PrimaryWorkTelephone] = "+1 (555) 123-4567"
- **Output of Expression**: `+15551234567`

**Scenario 2**: You need to extract the last name from a `PreferredNameData` field that contains "FirstName LastName".

**Target attribute**: `sn` in on-premises Active Directory, `surname` in Microsoft Entra ID

```
Replace([PreferredNameData], , "(?<firstName>[a-zA-Z]+ )(?<lastName>[a-zA-Z]+)", ,"${lastName}", ,)
```

**Example:**
- **Input Values**: [PreferredNameData] = "John Smith"
- **Output of Expression**: `Smith` 

**Scenario 3**: You want to remove leading zeros from a Worker ID before matching it with an employee ID in on-premises Active Directory or Microsoft Entra ID. 

**Target attribute**: employeeId

```
Replace([WorkerID], , "(?<leadingZeros>^0+)(?<actualValue>[a-zA-Z0-9]+)", , "${actualValue}", ,)
```

**Example:**
- **Input Values**: [WorkerID] = "00012345"
- **Output of Expression**: `12345`

**Scenario 4**: The `HereditarySuffix` attribute contains suffix information that is tagged with country ISO code and you want to only extract the suffix information and append it to the surname. 

**Target attribute**: `sn` in on-premises Active Directory, `surname` in Microsoft Entra ID

```
Join(" ",Replace([HereditarySuffix], ,"(?<CountryISOCode>.*)_(?<suffix1>.*)_(?<suffix2>.*)[0-9]", ,"${suffix1} ${suffix2}", , ),[PreferredLastName])
```

**Example:**
- **Input Values**: [HereditarySuffix] = "NLD_Van_der3", [PreferredLastName] = "Hof"
- **Output of Expression**: `Van der Hof`


### Text case conversion

**Scenario 1**: You need to convert text to proper case but handle apostrophes correctly (e.g., "st john's hospital" should become "St John's Hospital").

**Target attribute**: company

```
Replace(PCase("st john's hospital"),"'S", , ,"'s", , )
```

**Example:**
- **Input Values**: Static text "st john's hospital"
- **Output of Expression**: `St John's Hospital`

**Scenario 2**: You want to create a lowercase username from first and last name.

**Target attribute**: mailNickname

```
ToLower(NormalizeDiacritics(StripSpaces(Join(".", [PreferredFirstName], [PreferredLastName]))))
```

**Example:**
- **Input Values**: [PreferredFirstName] = "José", [PreferredLastName] = "García-López"
- **Output of Expression**: `jose.garcia-lopez`

### Country-specific naming logic

**Scenario 1**: You need to apply different naming conventions based on the user's country (e.g., "Last, First" for certain countries).

**Target attribute**: displayName, cn

```
Switch([CountryReferenceTwoLetter], 
    Join(" ", [PreferredFirstName], [PreferredLastName]),  
    "HU", Join(",", [PreferredLastName], [PreferredFirstName]), 
    "JP", Join(",", [PreferredLastName], [PreferredFirstName]), 
    "KR", Join(",", [PreferredLastName], [PreferredFirstName])
)
```

**Example:**
- **Input Values**: [CountryReferenceTwoLetter] = "JP", [PreferredFirstName] = "Hiroshi", [PreferredLastName] = "Tanaka"
- **Output of Expression**: `Tanaka,Hiroshi` (Japanese naming convention)
- **Alternative Input**: [CountryReferenceTwoLetter] = "US", [PreferredFirstName] = "John", [PreferredLastName] = "Smith"
- **Alternative Output**: `John Smith` (default Western naming convention)


## Email address generation

### Basic email generation

**Scenario 1**: You want to construct an email address by joining first name and last name, removing spaces and special characters, and appending a domain.

**Target attribute**: mail

```
Join("@", NormalizeDiacritics(StripSpaces(Join(".", [PreferredFirstName], [PreferredLastName]))), "contoso.com")
```

**Example:**
- **Input Values**: [PreferredFirstName] = "María", [PreferredLastName] = "José González"
- **Output of Expression**: `maria.josegonzalez@contoso.com`

**Scenario 2**: You need to handle special characters like quotes and commas in names when generating email addresses.

**Target attribute**: userPrincipalName

```
SelectUniqueValue(
    Join("@", Replace(NormalizeDiacritics(StripSpaces(Join(".", [PreferredFirstName], [PreferredLastName]))), , "[\"',]+", , "", , ), "contoso.com"), 
    Join("@", Replace(NormalizeDiacritics(StripSpaces(Join(".", Mid([PreferredFirstName], "1", "1"), [PreferredLastName]))), , "[\"',]+", , "", , ), "contoso.com"), 
    Join("@", Replace(NormalizeDiacritics(StripSpaces(Join(".", Mid([PreferredFirstName], "1", "2"), [PreferredLastName]))), , "[\"',]+", , "", , ), "contoso.com")
)
```

**Example:**
- **Input Values**: [PreferredFirstName] = "Mary-Ann", [PreferredLastName] = "O'Connor"
- **Output of Expression**: `maryann.oconnor@contoso.com` (or `m.oconnor@contoso.com` if first option is taken, or `ma.oconnor@contoso.com` if first two are taken)

### Company-specific email domains

**Scenario 1**: You have multiple companies and need to generate email addresses with different domain suffixes based on the company.

**Target attribute**: mail

```
Switch([Company], 
    Join("@", NormalizeDiacritics(StripSpaces(Join(".", [FirstName], [LastName]))), "contoso.com"),
    "Contoso", Join("@", NormalizeDiacritics(StripSpaces(Join(".", [FirstName], [LastName]))), "contoso.com"),
    "Fabrikam", Join("@", NormalizeDiacritics(StripSpaces(Join(".", [FirstName], [LastName]))), "fabrikam.com"),
    "Woodgrove", Join("@", NormalizeDiacritics(StripSpaces(Join(".", Mid([FirstName],1,1), [LastName]))), "woodgrove.com")
)
```

**Example:**
- **Input Values**: [Company] = "Fabrikam", [FirstName] = "John", [LastName] = "Smith"
- **Output of Expression**: `john.smith@fabrikam.com`
- **Alternative Input**: [Company] = "Woodgrove", [FirstName] = "Sarah", [LastName] = "Johnson"
- **Alternative Output**: `s.johnson@woodgrove.com`

### ProxyAddresses configuration

**Scenario 1**: You need to set multiple proxy addresses for Exchange, including primary and secondary SMTP addresses.

**Target attribute**: proxyAddresses

```
Split(
    Join(",",
        Append("smtp:", Join("@", NormalizeDiacritics(StripSpaces(Join(".", [PreferredFirstName], [PreferredLastName]))), "contoso.mail.onmicrosoft.com")),
        Append("smtp:", Join("@", NormalizeDiacritics(StripSpaces(Join(".", [PreferredFirstName], [PreferredLastName]))), "contoso.onmicrosoft.com")),
        Append("SMTP:", Join("@", NormalizeDiacritics(StripSpaces(Join(".", [PreferredFirstName], [PreferredLastName]))), "contoso.com"))
    ), ","
)
```

**Example:**
- **Input Values**: [PreferredFirstName] = "Michael", [PreferredLastName] = "Brown"
- **Output of Expression**: `["smtp:michael.brown@contoso.mail.onmicrosoft.com", "smtp:michael.brown@contoso.onmicrosoft.com", "SMTP:michael.brown@contoso.com"]`

## Phone number processing

These expression mappings can be used in the Workday Writeback application. 

### International phone number parsing

**Scenario 1**: You have phone numbers in international format (+1 737-626-8331) and need to extract just the phone number without the country code.

**Target attribute**: telephoneNumber

```
Replace(Replace([telephoneNumber], , "\\+(?<isdCode>\\d* )(?<phoneNumber>.*)", , "${phoneNumber}", , ), ,"[()\\s-]+", ,"", , )
```

**Example:**
- **Input Values**: [telephoneNumber] = "+1 737-626-8331"
- **Output of Expression**: `7376268331`

**Scenario 2**: You need to extract the country code from a phone number to determine the country for directory purposes.

**Target attribute**: c

```
Switch(Replace([telephoneNumber], , "\\+(?<isdCode>\\d* )(?<phoneNumber>.*)", , "${isdCode}", , ), "USA",
  "1", "USA",
  "44", "GBR", 
  "49", "DEU"
)
```

**Example:**
- **Input Values**: [telephoneNumber] = "+44 20 7946 0958"
- **Output of Expression**: `GBR`
- **Alternative Input**: [telephoneNumber] = "+1 555-123-4567"
- **Alternative Output**: `USA`

**Scenario 3**: You need to writeback the phone number that Microsoft Teams generates and sets in Microsoft Entra ID (e.g. +4926180001111). In this phone number, there is no space between the CountryCode and the actual phone number. You can use the following regex parsing mechanism to extract country codes relevant to your organization and use it to set the Workday `CountryCodeName`. 

**Target attribute**: CountryCodeName

```
Switch(Replace([telephoneNumber], , "\+(?<isdCode>49|44|43|1|352|91|31|32|55|237|420|45|20|212|216|234|263|27|30|33|34|351|352|36|372|380|381|383|39|40|41|421|46|47|48|58|60|7|90|91|92|94|961|971|98|995)(?<phoneNumber>.*)", , "${isdCode}", , ), , "43", "AUT", "32", "BEL", "1", "USA", "420", "CZE", "45", "DNK", "372", "EST", "33", "FRA", "49", "GER", "30", "GRC", "36", "HUN", "91", "IND", "39", "ITA", "352", "LUX", "31", "NLD", "47", "NOR", "48", "POL", "40", "ROU", "421", "SVK", "27", "ZAF", "34", "ESP", "46", "SWE", "41", "CHE", "90", "TUR")

```

**Example:**
- **Input Values**: [telephoneNumber] = "+493012345678"
- **Output of Expression**: `GER`
- **Alternative Input**: [telephoneNumber] = "+919876543210"
- **Alternative Output**: `IND`
- **Alternative Input**: [telephoneNumber] = "+15551234567"
- **Alternative Output**: `USA`


### Phone number formatting for different systems

**Scenario 1**: You need to process phone numbers that include extensions (e.g., "+1 (206) 291-8163 x8125").

**Target attribute**: telephoneNumber

```
Replace(Replace([telephoneNumber], , "\\+(?<isdCode>\\d* )(?<phoneNumber>.* )[x](?<extension>.*)", , "${phoneNumber}", , ), ,"[()\\s-]+", ,"", , )
```

**Example:**
- **Input Values**: [telephoneNumber] = "+1 (206) 291-8163 x8125"
- **Output of Expression**: `2062918163`

**Scenario 2**: You want to extract just the extension from a phone number.

**Target attribute**: extensionAttribute1

```
Replace([telephoneNumber], , "\\+(?<isdCode>\\d* )(?<phoneNumber>.* )[x](?<extension>.*)", , "${extension}", , )
```

**Example:**
- **Input Values**: [telephoneNumber] = "+1 (206) 291-8163 x8125"
- **Output of Expression**: `8125`

## Account status logic for Active Directory
The expressions in this section are applicable to the `accountDisabled` attribute that is part of "Workday to on-premises Active Directory user provisioning app". For setting the `accountEnabled` attribute that is part of "Workday to Microsoft Entra ID user provisioning app", refer to the section [Account Status Logic for Microsoft Entra ID](#account-status-logic-for-microsoft-entra-id).   

### Basic account status management

**Scenario 1**: You want to disable on-premises Active Directory accounts for users who are not active in Workday. 

**Target attribute**: accountDisabled

```
Switch([Active], , "1", "False", "0", "True")
```

**Example:**
- **Input Values**: [Active] = "1"
- **Output of Expression**: `False` (account enabled)
- **Alternative Input**: [Active] = "0"
- **Alternative Output**: `True` (account disabled)

### Rehire processing

**Scenario 1**: You need
**Scenario 1**: You need to handle rehire scenarios where accounts should only be enabled on or after the hire date.

**Target attribute**: accountDisabled

```
Switch([Active], , 
"1", IIF([StatusRehire]=1, IIF(DateDiff("d", Now(), CDate([StatusHireDate])) >= 0, "False", "True"), "False"), 
"0", "True")
```

**Example:**
- **Input Values**: [Active] = "1", [StatusRehire] = "1", [StatusHireDate] = "2025-08-15" (current date: 2025-07-30)
- **Output of Expression**: `True` (account disabled until hire date)
- **Alternative Input**: [Active] = "1", [StatusRehire] = "1", [StatusHireDate] = "2025-07-15"
- **Alternative Output**: `False` (account enabled as hire date has passed)

### Pre-Hire Account Creation

**Scenario 1**: You want to create accounts for future hires but keep them disabled until 14 days before their start date.

**Target attribute**: accountDisabled

```
Switch([Active], , "1", IIF(DateDiff("d", Now(), CDate([StatusHireDate])) <= 14, "False", "True"), "0", "True")
```

**Example:**
- **Input Values**: [Active] = "1", [StatusHireDate] = "2025-08-10" (current date: 2025-07-30)
- **Output of Expression**: `False` (account enabled as hire date is within 14 days)
- **Alternative Input**: [Active] = "1", [StatusHireDate] = "2025-09-15"
- **Alternative Output**: `True` (account disabled as hire date is more than 14 days away)


### Handling Hire Rescinds

**Scenario 1**: You need to handle hire rescind scenarios when setting the `accountDisabled` attribute. You want to implement the logic: 
  * If Terminated = 1 in workday then accountDisabled = True
  * If Rescinded = 1 in workday then accountDisabled = True
  * If Active =1 in workday then
     * if
         * HireDate is more than seven days in future then accountDisabled = True (disable the account)
         * HireDate is <= seven days in future then accountDisabled = False (enable the account)
  * If Active = 0 then accountDisabled = True

**Target attribute**: accountDisabled

```
Switch([StatusTerminated], "False", "1", "True", "0",
  Switch([StatusHireRescinded], "False", "1", "True", "0",
     Switch([Active], "False", 
         "1", IIF(DateDiff("d", Now(), CDate(IIF(IsNullOrEmpty([StatusHireDate]), "9999-01-01", [StatusHireDate]))) < 7, "False", "True"), 
         "0", "True"
         )
    )
)
```

**Example:**
- **Input Values**: [Terminated] = "1", [Active] = "1", [StatusHireDate] = "2025-08-15"
- **Output of Expression**: `True` (account disabled due to termination)
- **Alternative Input**: [Terminated] = "0", [Rescinded] = "1", [Active] = "1"
- **Alternative Output**: `True` (account disabled due to rescind)
- **Alternative Input**: [Terminated] = "0", [Rescinded] = "0", [Active] = "1", [StatusHireDate] = "2025-08-15" (current date: 2025-07-30)
- **Alternative Output**: `True` (account disabled as hire date is more than 7 days away)
- **Alternative Input**: [Terminated] = "0", [Rescinded] = "0", [Active] = "1", [StatusHireDate] = "2025-08-05"
- **Alternative Output**: `False` (account enabled as hire date is within 7 days)



## Account Status Logic for Microsoft Entra ID
The expressions in this section are applicable to the `accountEnabled` attribute that is part of "Workday to Microsoft Entra ID user provisioning app". For setting the `accountDisabled` attribute that is part of "Workday to on-premises Active Directory user provisioning app", refer to the section [Account Status Logic for Active Directory](#account-status-logic-for-active-directory).   

### Basic Account Status Management

**Scenario 1**: You want to disable Microsoft Entra ID accounts for users who are not active in Workday. 

**Target attribute**: accountEnabled

```
Switch([Active], , "1", "True", "0", "False")
```

**Example:**
- **Input Values**: [Active] = "1"
- **Output of Expression**: `True` (account enabled)
- **Alternative Input**: [Active] = "0"
- **Alternative Output**: `False` (account disabled)

### Rehire Processing

**Scenario 1**: You need to handle rehire scenarios where accounts should only be enabled on or after the hire date.

**Target attribute**: accountEnabled

```
Switch([Active], , 
"1", IIF([StatusRehire]=1, IIF(DateDiff("d", Now(), CDate([StatusHireDate])) >= 0, "True", "False"), "True"), 
"0", "False")
```

**Example:**
- **Input Values**: [Active] = "1", [StatusRehire] = "1", [StatusHireDate] = "2025-08-15" (current date: 2025-07-30)
- **Output of Expression**: `False` (account disabled until hire date)
- **Alternative Input**: [Active] = "1", [StatusRehire] = "1", [StatusHireDate] = "2025-07-15"
- **Alternative Output**: `True` (account enabled as hire date has passed)

### Pre-Hire Account Creation

**Scenario 1**: You want to create accounts for future hires but keep them disabled until 14 days before their start date.

**Target attribute**: accountEnabled

```
Switch([Active], , "1", IIF(DateDiff("d", Now(), CDate([StatusHireDate])) <= 14, "True", "False"), "0", "False")
```

**Example:**
- **Input Values**: [Active] = "1", [StatusHireDate] = "2025-08-10" (current date: 2025-07-30)
- **Output of Expression**: `True` (account enabled as hire date is within 14 days)
- **Alternative Input**: [Active] = "1", [StatusHireDate] = "2025-09-15"
- **Alternative Output**: `False` (account disabled as hire date is more than 14 days away)



## Date Functions

### Date Formatting and Conversion

**Scenario 1**: You need to convert a Workday contract end date to Active Directory format for the accountExpires attribute, so the account expires on the contract end date. 

**Target attribute**: accountExpires

```
NumFromDate(Join("", FormatDateTime([ContractEndDate], ,"yyyy-MM-ddzzz", "yyyy-MM-dd"), "T23:59:59-08:00"))
```

**Example:**
- **Input Values**: [StatusHireDate] = "2025-12-31"
- **Output of Expression**: `133835135990000000` (numeric representation of 2025-12-31T23:59:59-07:00)

**Scenario 2**: You want to set an account expiration date five years from the hire date.

**Target attribute**: accountExpires

```
NumFromDate(Join("",FormatDateTime(DateAdd("yyyy", 5, CDate([StatusHireDate])), , "yyyy-MM-dd", "yyyy-MM-dd")," 23:59:59-05:00"))
```

**Example:**
- **Input Values**: [StatusHireDate] = "2025-01-15"
- **Output of Expression**: `139418879990000000` (numeric representation of 2030-01-15 23:59:59-05:00)

### Conditional Date-Based Logic

**Scenario 1**: You want to flow department information only if the employee has started work (hire date is in the past).

**Target attribute**: department

```
IIF(DateDiff("d", Now(), CDate([StatusHireDate])) >= 0, [Department], IgnoreAttributeFlow)
```

**Example:**
- **Input Values**: [StatusHireDate] = "2025-07-15", [Department] = "Engineering" (current date: 2025-07-30)
- **Output of Expression**: `Engineering` (hire date has passed)
- **Alternative Input**: [StatusHireDate] = "2025-08-15", [Department] = "Marketing"
- **Alternative Output**: `IgnoreAttributeFlow` (hire date is in the future)

**Scenario 2**: You need to create user objects only if the hire date is within 14 days.

**Target attribute**: objectFilter

```
IIF(DateDiff("d", Now(), CDate([StatusHireDate])) <= 14, "False", IgnoreObjectFlow)
```

**Example:**
- **Input Values**: [StatusHireDate] = "2025-08-10" (current date: 2025-07-30)
- **Output of Expression**: `False` (create user object as hire date is within 14 days)
- **Alternative Input**: [StatusHireDate] = "2025-09-15"
- **Alternative Output**: `IgnoreObjectFlow` (don't create user object as hire date is more than 14 days away)

## Organizational Unit (OU) Assignment

### Simple OU Assignment

**Scenario 1**: You want to place users in different OUs based on their city.

**Target attribute**: parentDistinguishedName

```
Switch([City], "OU=Default,OU=Users,DC=contoso,DC=com", 
"Dallas", "OU=Dallas,OU=Users,DC=contoso,DC=com", 
"Austin", "OU=Austin,OU=Users,DC=contoso,DC=com", 
"Seattle", "OU=Seattle,OU=Users,DC=contoso,DC=com", 
"London", "OU=London,OU=Users,DC=contoso,DC=com" 
)
```

**Example:**
- **Input Values**: [City] = "Seattle"
- **Output of Expression**: `OU=Seattle,OU=Users,DC=contoso,DC=com`
- **Alternative Input**: [City] = "Chicago"
- **Alternative Output**: `OU=Default,OU=Users,DC=contoso,DC=com` (default for unspecified cities)

### Complex OU Structure

**Scenario 1**: You need to create a complex OU structure based on department, cost center, and country.

**Target attribute**: parentDistinguishedName

```
Join("", 
    Switch([SupervisoryOrganization],"",
        "Engineering", "OU=Engineering,",
        "Shared Services", "OU=Shared Services,",
        "Information Technology", "OU=Information Technology,",
        "Development", "OU=Development,"
        ),
    Switch([CostCenter],"",
        "Finance and Info. Mgmt.","OU=Finance and Information Management,",
        "Modern Workplace","OU=Modern Workplace,",
        "Green Energy","OU=Green Energy,"
        ),
    Switch([CountryReferenceTwoLetter],"",
        "US","OU=USA,",
        "UK","OU=UK,",
        "IN","OU=IN,"
        ),
    "OU=Users,DC=contoso,DC=com"
)
```

**Example:**
- **Input Values**: [SupervisoryOrganization] = "Engineering", [CostCenter] = "Modern Workplace", [CountryReferenceTwoLetter] = "US"
- **Output of Expression**: `OU=Engineering,OU=Modern Workplace,OU=USA,OU=Users,DC=contoso,DC=com`
- **Alternative Input**: [SupervisoryOrganization] = "Sales", [CostCenter] = "Marketing", [CountryReferenceTwoLetter] = "UK"
- **Alternative Output**: `OU=Users,DC=contoso,DC=com` (defaults when values don't match)

### Terminated User OU Assignment

**Scenario 1**: You want to move terminated users to a special OU on their termination date.

**Target attribute**: parentDistinguishedName

```
IIF(DateDiff("d", Now(),CDate(Switch([StatusTerminationLastDayOfWork],[StatusTerminationLastDayOfWork],
        "","9999-12-31"
        ))
    ) <= 0, 
    "OU=Leavers,OU=Users,DC=contoso,DC=com", 
    Switch([City], "OU=Default,OU=Users,DC=contoso,DC=com", 
        "Dallas", "OU=Dallas,OU=Users,DC=contoso,DC=com", 
        "Austin", "OU=Austin,OU=Users,DC=contoso,DC=com", 
        "Seattle", "OU=Seattle,OU=Users,DC=contoso,DC=com", 
        "London", "OU=London,OU=Users,DC=contoso,DC=com" 
    ) 
)
```

**Example:**
- **Input Values**: [StatusTerminationLastDayOfWork] = "2025-07-25", [City] = "Seattle" (current date: 2025-07-30)
- **Output of Expression**: `OU=Leavers,OU=Users,DC=contoso,DC=com` (moved to Leavers OU as termination date has passed)
- **Alternative Input**: [StatusTerminationLastDayOfWork] = "2025-08-15", [City] = "Dallas"
- **Alternative Output**: `OU=Dallas,OU=Users,DC=contoso,DC=com` (remains in normal OU as termination date is in future)

## Random ID Generation

### GUID-Based Random Generation

**Scenario 1**: You need to generate a random 5-character string that doesn't contain digits.

**Target attribute**: extensionAttribute15

```
SelectUniqueValue (
   Replace(Mid(ConvertToBase64(Guid()), 1, 5 ), ,"[0-9]", ,"A", , ),
   Replace(Mid(ConvertToBase64(Guid()), 1, 5 ), ,"[0-9]", ,"B", , ),
   Replace(Mid(ConvertToBase64(Guid()), 1, 5 ), ,"[0-9]", ,"C", , )
)
```

**Example:**
- **Input Values**: Generated GUID converted to Base64 (e.g., "mV8dXr...")
- **Output of Expression**: `mVAdX` (digits replaced with 'A', or with 'B'/'C' if first option is taken)

**Scenario 2**: You want to generate a random string that starts with "D" followed by 4 alphabetic characters.

**Target attribute**: extensionAttribute14

```
SelectUniqueValue(
    ToUpper(Replace(ConvertToBase64(Guid()), , "(.*?)(?<id>[a-zA-Z]{4})(.*)", , "D${id}", ,)),
    ToUpper(Replace(ConvertToBase64(Guid()), , "(.*?)(?<id>[a-zA-Z]{4})(.*)", , "D${id}", ,)),
    ToUpper(Replace(ConvertToBase64(Guid()), , "(.*?)(?<id>[a-zA-Z]{4})(.*)", , "D${id}", ,))
)
```

**Example:**
- **Input Values**: Generated GUID converted to Base64 containing alphabetic sequence "mVdX"
- **Output of Expression**: `DMVDX` (or different if first option is taken)

### Numeric ID Generation

**Scenario 1**: You need to generate a random 4-digit number from a GUID.

**Target attribute**: extensionAttribute13

```
SelectUniqueValue(
    Replace(Replace(Guid(), ,"-", ,"", , ), ,"(.*?)(?<id>[0-9]{4})(.*)", , "D${id}", ,),
    Replace(Replace(Guid(), ,"-", ,"", , ), ,"(.*?)(?<id>[0-9]{4})(.*)", , "D${id}", ,),
    Replace(Replace(Guid(), ,"-", ,"", , ), ,"(.*?)(?<id>[0-9]{4})(.*)", , "D${id}", ,)
)
```

**Example:**
- **Input Values**: Generated GUID like "a1b2c3d4-e5f6-7890-1234-567890abcdef"
- **Output of Expression**: `D7890` (or `D1234`, `D5678`, etc. depending on which 4-digit sequence is matched first)

## Name Processing

### Display Name Generation

**Scenario 1**: You want to create a display name in "Last, First" format.

**Target attribute**: displayName

```
Join(", ", [PreferredLastName], [PreferredFirstName])
```

**Example:**
- **Input Values**: [PreferredLastName] = "Smith", [PreferredFirstName] = "John"
- **Output of Expression**: `Smith, John`

**Scenario 2**: You need to create a display name that includes middle initial and employee ID.

**Target attribute**: displayName

```
Join("", [PreferredLastName], ",", [PreferredFirstName], " ", Mid([PreferredMiddleName],1,1), "-", [WorkerID])
```

**Example:**
- **Input Values**: [PreferredLastName] = "Johnson", [PreferredFirstName] = "Sarah", [PreferredMiddleName] = "Elizabeth", [WorkerID] = "12345"
- **Output of Expression**: `Johnson,Sarah E-12345`

### Common Name (CN) Generation with Uniqueness

**Scenario 1**: You want to generate a unique common name with fallback options for duplicates.

**Target attribute**: cn

```
SelectUniqueValue(
    NormalizeDiacritics(Join(" ", [PreferredFirstName], [PreferredLastName])),
    NormalizeDiacritics(Join(" ", [PreferredFirstName], Mid([PreferredMiddleName],1,1), [PreferredLastName])),
    NormalizeDiacritics(Join(" ", [PreferredFirstName], [PreferredMiddleName], [PreferredLastName]))
)
```

**Example:**
- **Input Values**: [PreferredFirstName] = "José", [PreferredLastName] = "García", [PreferredMiddleName] = "Antonio"
- **Output of Expression**: `Jose Garcia` (or `Jose A Garcia` if first option is taken, or `Jose Antonio Garcia` if first two are taken)

### SamAccountName Generation

**Scenario 1**: You want to create a 20-character samAccountName using first initial and last name with numeric suffixes for duplicates.

**Target attribute**: sAMAccountName

```
SelectUniqueValue(
    Replace(Mid(Replace(NormalizeDiacritics(StripSpaces(Join("", Mid([FirstName],1,1), [LastName]))), , "([\\/\\\\\\[\\]\\:\\;\\|\\=\\,\\+\\*\\?\\<\\>])", , "", , ), 1, 20), , "(\\.)*$", , "", , ),
    Join("",Replace(Mid(Replace(NormalizeDiacritics(StripSpaces(Join("", Mid([FirstName],1,1), [LastName]))), , "([\\/\\\\\\[\\]\\:\\;\\|\\=\\,\\+\\*\\?\\<\\>])", , "", , ), 1, 19), , "(\\.)*$", , "", , ),"1"),
    Join("",Replace(Mid(Replace(NormalizeDiacritics(StripSpaces(Join("", Mid([FirstName],1,1), [LastName]))), , "([\\/\\\\\\[\\]\\:\\;\\|\\=\\,\\+\\*\\?\\<\\>])", , "", , ), 1, 19), , "(\\.)*$", , "", , ),"2")
)
```

**Example:**
- **Input Values**: [FirstName] = "María José", [LastName] = "González-López"
- **Output of Expression**: `mgonzalezlopez` (or `mgonzalezlopez1` if first option is taken, or `mgonzalezlopez2` if first two are taken)

## Advanced Scenarios

### Hide from Address Lists Logic

This section describes how to set the boolean attribute `msExchHideFromAddressLists`. Use all caps "TRUE" or "FALSE" to set the boolean attribute. Using any other value will result in `HybridSynchronizationActiveDirectoryInvalidParameter` error. 

**Scenario 1**: You want to set `msExchHideFromAddressLists` based on active account status of Workday user. 

**Target attribute**: msExchHideFromAddressLists

```
Switch([Active], , "1", "FALSE", "0", "TRUE")
```

**Example:**
- **Input Values**: [Active] = "0" 
- **Output of Expression**: `TRUE` (hide from address lists as the user is inactive in Workday)
- **Alternative Input**: [Active] = "1" 
- **Alternative Output**: `FALSE` (show in address lists as the user is active in Workday)


**Scenario 2**: You want to set `msExchHideFromAddressLists` based on hire date of the worker. Show the user in the Exchange address list only after hire date. 

**Target attribute**: msExchHideFromAddressLists

```
IIF(DateDiff("d", Now(), CDate([StatusHireDate])) >= 0, "TRUE", "FALSE")
```

**Example:**
- **Input Values**: [StatusHireDate] = "2025-07-31" (current date: 2025-07-30)
- **Output of Expression**: `TRUE` (hide from address lists as hire date is in the future)
- **Alternative Input**: [StatusHireDate] = "2025-07-31" (current date: 2025-08-01)
- **Alternative Output**: `FALSE` (show in address lists as hire date has passed)


### Multi-Valued Attribute Setting

**Scenario 1**: You need to set multiple values for the msExchPoliciesExcluded attribute in Active Directory.

**Target attribute**: msExchPoliciesExcluded

```
Split(
    Join(",","a8cccada-a108-47ae-bf9a-f130499aa4cb","{26491cfc-9e50-4857-861b-0cb8df22b5d7}"),
    ","
)
```

**Example:**
- **Input Values**: Static GUID values
- **Output of Expression**: `["a8cccada-a108-47ae-bf9a-f130499aa4cb", "{26491cfc-9e50-4857-861b-0cb8df22b5d7}"]`


### Writeback Scenarios

**Scenario 1**: You want to write back the username to Workday only if the employee hire date has passed.

**Target attribute**: Username

```
IgnoreFlowIfNullOrEmpty(IIF(DateDiff("d", Now(), CDate([employeeHireDate])) > 0, "", [userPrincipalName]))
```

**Example:**
- **Input Values**: [employeeHireDate] = "2025-07-15", [userPrincipalName] = "user@contoso.com" (current date: 2025-07-30)
- **Output of Expression**: `user@contoso.com` (hire date has passed, write back username)
- **Alternative Input**: [employeeHireDate] = "2025-08-15", [userPrincipalName] = "future@contoso.com"
- **Alternative Output**: *(empty - ignored, hire date is in future)*


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
- [Expression Builder in Application Provisioning](expression-builder.md)
