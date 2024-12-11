---
title: Manage rules for dynamic membership groups in Microsoft Entra ID
description: How to manage rules for dynamic membership groups to automatically populate group members and rule references.

author: barclayn
manager: amycolannino
ms.service: entra-id
ms.subservice: users
ms.topic: conceptual
ms.date: 08/23/2024
ms.author: barclayn
ms.reviewer: krbain
ms.custom: it-pro
---

# Manage rules for dynamic membership groups in Microsoft Entra ID

You can create user or device attribute-based rules to enable membership for dynamic membership groups in Microsoft Entra ID, part of Microsoft Entra. You can add and remove dynamic membership groups automatically using membership rules based on member attributes. In Microsoft Entra, a single tenant can have a maximum of 15,000 dynamic membership groups.

This article details the properties and syntax to create rules for dynamic membership groups based on users or devices.

> [!NOTE]
> Security groups can be used for either devices or users, but Microsoft 365 groups can include only users. 

When the attributes of a user or a device change, the system evaluates all rules for dynamic membership groups in a directory to see if the change would trigger any group adds or removes. If a user or device satisfies a rule on a group, they're added as a member of that group. If they no longer satisfy the rule, they're removed. You can't manually add or remove a member of a dynamic membership group.

- You can create a dynamic membership groups for users or devices, but you can't create a rule that contains both users and devices.
- You can't create a device membership group based on the user attributes of the device owner. Device membership rules can reference only device attributes.

> [!NOTE]
> This feature requires a Microsoft Entra ID P1 license or Intune for Education for each unique user that is a member of one or more dynamic membership groups. You don't have to assign licenses to users for them to be members of dynamic membership groups, but you must have the minimum number of licenses in the Microsoft Entra organization to cover all such users. For example, if you had a total of 1,000 unique users in all dynamic membership groups in your organization, you would need at least 1,000 licenses for Microsoft Entra ID P1 to meet the license requirement.
> No license is required for devices that are members of a dynamic membership group based on a device.

## Rule builder in the Azure portal

Microsoft Entra ID provides a rule builder to create and update your important rules more quickly. The rule builder supports the construction of up to five expressions. The rule builder makes it easier to form a rule with a few simple expressions, however, it can't be used to reproduce every rule. If the rule builder doesn't support the rule you want to create, you can use the text box.

>[!IMPORTANT]
> The rule builder is available only for user-based dynamic membership groups. Device-based dynamic membership groups can be created only using the text box.

Here are some examples of advanced rules or syntax that require the use of the text box:

- Rule with more than five expressions
- The Direct reports rule
- Rules with -contains or -notContains operator
- Setting [operator precedence](#operator-precedence)
- [Rules with complex expressions](#rules-with-complex-expressions); for example, `(user.proxyAddresses -any (_ -startsWith "contoso"))`

> [!NOTE]
> The rule builder might not be able to display some rules constructed in the text box. You might see a message when the rule builder is not able to display the rule. The rule builder doesn't change the supported syntax, validation, or processing of rules for dynamic membership groups in any way.

For more step-by-step instructions, see [Create or update a dynamic membership group](groups-create-rule.md).

:::image type="content" source="./media/groups-dynamic-membership/update-dynamic-group-rule.png" alt-text="Screenshot of the add membership rule for a dynamic membership group.":::

### Rule syntax for a single expression

A single expression is the simplest form of a membership rule and only has the three parts mentioned above. A rule with a single expression looks similar to this example: `Property Operator Value`, where the syntax for the property is the name of object.property.

The following example illustrates a properly constructed membership rule with a single expression:

```
user.department -eq "Sales"
```

Parentheses are optional for a single expression. The total length of the body of your membership rule can't exceed 3072 characters.

## Constructing the body of a membership rule

A membership rule that automatically populates a group with users or devices is a binary expression that results in a true or false outcome. The three parts of a simple rule are:

- Property
- Operator
- Value

The order of the parts within an expression is important to avoid syntax errors.

## Supported properties

There are three types of properties that can be used to construct a membership rule.

- Boolean
- DateTime
- String
- String collection


The following are the user properties that you can use to create a single expression.


### Properties of type boolean

Properties | Allowed values | Usage
--- | --- | ---
accountEnabled |true false |user.accountEnabled -eq true
dirSyncEnabled |true false |user.dirSyncEnabled -eq true

### Properties of type dateTime

| Properties | Allowed values | Usage |
| --- | --- | --- |
| employeeHireDate (Preview) |Any DateTimeOffset value or keyword system.now | user.employeeHireDate -eq "value" |

### Properties of type string

| Properties | Allowed values | Usage |
| --- | --- | --- |
| city |Any string value or *null* | user.city -eq "value" |
| country |Any string value or *null* | user.country -eq "value" |
| companyName | Any string value or *null* | user.companyName -eq "value" |
| department |Any string value or *null* | user.department -eq "value" |
| displayName |Any string value | user.displayName -eq "value" |
| employeeId |Any string value | user.employeeId -eq "value"<br>user.employeeId -ne *null* |
| facsimileTelephoneNumber |Any string value or *null* | user.facsimileTelephoneNumber -eq "value" |
| givenName |Any string value or *null* | user.givenName -eq "value" |
| jobTitle |Any string value or *null* | user.jobTitle -eq "value" |
| mail |Any string value or *null* (SMTP address of the user) | user.mail -eq "value" |
| mailNickName |Any string value (mail alias of the user) | user.mailNickName -eq "value" |
| memberOf | Any string value (valid group object ID) | user.memberOf -any (group.objectId -in ['value']) |
| mobile |Any string value or *null* | user.mobile -eq "value" |
| objectId |GUID of the user object | user.objectId -eq "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" |
| onPremisesDistinguishedName | Any string value or *null* | user.onPremisesDistinguishedName -eq "value" |
| onPremisesSecurityIdentifier | On-premises security identifier (SID) for users who were synchronized from on-premises to the cloud. | user.onPremisesSecurityIdentifier -eq "S-1-1-11-1111111111-1111111111-1111111111-1111111" |
| passwordPolicies |None<br>DisableStrongPassword<br>DisablePasswordExpiration<br>DisablePasswordExpiration, DisableStrongPassword | user.passwordPolicies -eq "DisableStrongPassword" |
| physicalDeliveryOfficeName |Any string value or *null* | user.physicalDeliveryOfficeName -eq "value" |
| postalCode |Any string value or *null* | user.postalCode -eq "value" |
| preferredLanguage |ISO 639-1 code | user.preferredLanguage -eq "en-US" |
| sipProxyAddress |Any string value or *null* | user.sipProxyAddress -eq "value" |
| state |Any string value or *null* | user.state -eq "value" |
| streetAddress |Any string value or *null* | user.streetAddress -eq "value" |
| surname |Any string value or *null* | user.surname -eq "value" |
| telephoneNumber |Any string value or *null* | user.telephoneNumber -eq "value" |
| usageLocation |Two letter country or region code | user.usageLocation -eq "US" |
| userPrincipalName |Any string value | user.userPrincipalName -eq "alias@domain" |
| userType |member guest *null* | user.userType -eq "Member" |

### Properties of type string collection

| Properties | Allowed values | Example |
| --- | --- | --- |
| otherMails |Any string value | user.otherMails -startsWith "alias@domain" |
| proxyAddresses |SMTP: alias@domain smtp: alias@domain | user.proxyAddresses -startsWith "SMTP: alias@domain" |

For the properties used for device rules, see [Rules for devices](#rules-for-devices).

## Supported expression operators

The following table lists all the supported operators and their syntax for a single expression. Operators can be used with or without the hyphen (-) prefix. The **Contains** operator does partial string matches but not item in a collection matches.


>[!CAUTION]
> For best results, minimize the use of MATCH or CONTAINS as much as possible. [Create simpler, more efficient rules for dynamic membership groups](groups-dynamic-rule-more-efficient.md) provides guidance on how to create rules that result in better dynamic group processing times. The ['''memberOf'''](groups-dynamic-rule-member-of.md) operator is in preview and should be used with caution, as it has some limitations.

| Operator | Syntax |
| --- | --- |
| Not Equals |-ne |
| Equals |-eq |
| Not Starts With |-notStartsWith |
| Starts With |-startsWith |
| Not Contains |-notContains |
| Contains |-contains |
| Not Match |-notMatch |
| Match |-match |
| In | -in |
| Not In | -notIn |

### Using the -in and -notIn operators

If you want to compare the value of a user attribute against multiple values, you can use the -in or -notIn operators. Use the bracket symbols "[" and "]" to begin and end the list of values.

 In the following example, the expression evaluates to true if the value of user.department equals any of the values in the list:

```
   user.department -in ["50001","50002","50003","50005","50006","50007","50008","50016","50020","50024","50038","50039","51100"]
```
### Using the -le and -ge operators

You can use the less than (-le) or greater than (-ge) operators when using the employeeHireDate attribute in rules for dynamic membership groups.  
Examples:

```
user.employeehiredate -ge system.now -plus p1d 

user.employeehiredate -le 2020-06-10T18:13:20Z 

```

### Using the -match operator 

The **-match** operator is used for matching any regular expression. Examples:

```
user.displayName -match "^Da.*"   
```
`Da`, `Dav`, `David` evaluate to true, aDa evaluates to false.

```
user.displayName -match ".*vid"
```
`David` evaluates to true, `Da` evaluates to false.

## Supported values

The values used in an expression can consist of several types, including:

- Strings
- Boolean – true, false
- Numbers
- Arrays – number array, string array

When specifying a value within an expression, it's important to use the correct syntax to avoid errors. Some syntax tips are:

- Double quotes are optional unless the value is a string.
- Regex and string operations are not case sensitive.
- Ensure that property names are correctly formatted as shown, as they're case sensitive.
- When a string value contains double quotes, both quotes should be escaped using the \` character, for example, user.department -eq \`"Sales\`" is the proper syntax when "Sales" is the value. Single quotes should be escaped by using two single quotes instead of one each time.
- You can also perform Null checks, using null as a value, for example, `user.department -eq null`.

### Use of Null values

To specify a null value in a rule, you can use the *null* value. 

- Use -eq or -ne when comparing the *null* value in an expression.
- Use quotes around the word *null* only if you want it to be interpreted as a literal string value.
- The -not operator can't be used as a comparative operator for null. If you use it, you get an error whether you use null or $null.

The correct way to reference the null value is as follows:

```
   user.mail –ne null
```

## Rules with multiple expressions

Manage rules for dynamic membership groups can consist of more than one single expression connected by the -and, -or, and -not logical operators. Logical operators can also be used in combination.

The following are examples of properly constructed membership rules with multiple expressions:

```
(user.department -eq "Sales") -or (user.department -eq "Marketing")
(user.department -eq "Sales") -and -not (user.jobTitle -startsWith "SDE")
```

### Operator precedence

All operators are listed below in order of precedence from highest to lowest. Operators on same line are of equal precedence:

```
-eq -ne -startsWith -notStartsWith -contains -notContains -match –notMatch -in -notIn
-not
-and
-or
-any -all
```

The following example illustrates operator precedence where two expressions are being evaluated for the user:

```
   user.department –eq "Marketing" –and user.country –eq "US"
```

Parentheses are needed only when precedence doesn't meet your requirements. For example, if you want department to be evaluated first, the following shows how parentheses can be used to determine order:

```
   user.country –eq "US" –and (user.department –eq "Marketing" –or user.department –eq "Sales")
```

## Rules with complex expressions

A membership rule can consist of complex expressions where the properties, operators, and values take on more complex forms. Expressions are considered complex when any of the following are true:

- The property consists of a collection of values; specifically, multi-valued properties
- The expressions use the -any and -all operators
- The value of the expression can itself be one or more expressions

## Multi-value properties

Multi-value properties are collections of objects of the same type. They can be used to create membership rules using the -any and -all logical operators.

| Properties | Values | Usage |
| --- | --- | --- |
| assignedPlans | Each object in the collection exposes the following string properties: capabilityStatus, service, servicePlanId |user.assignedPlans -any (assignedPlan.servicePlanId -eq "aaaa0a0a-bb1b-cc2c-dd3d-eeeeee4e4e4e" -and assignedPlan.capabilityStatus -eq "Enabled") |
| proxyAddresses| SMTP: alias@domain smtp: alias@domain | (user.proxyAddresses -any (\_ -startsWith "contoso")) |

### Using the -any and -all operators

You can use -any and -all operators to apply a condition to one or all of the items in the collection, respectively.

- -any (satisfied when at least one item in the collection matches the condition)
- -all (satisfied when all items in the collection match the condition)

#### Example 1

assignedPlans is a multi-value property that lists all service plans assigned to the user. The following expression selects users who have the Exchange Online (Plan 2) service plan (as a GUID value) that is also in Enabled state:

```
user.assignedPlans -any (assignedPlan.servicePlanId -eq "efb87545-963c-4e0d-99df-69c6916d9eb0" -and assignedPlan.capabilityStatus -eq "Enabled")
```

A rule such as this one can be used to group all users for whom a Microsoft 365 or other Microsoft Online Service capability is enabled. You could then apply with a set of policies to the group.

#### Example 2

The following expression selects all users who have any service plan that is associated with the Intune service (identified by service name "SCO"):

```
user.assignedPlans -any (assignedPlan.service -eq "SCO" -and assignedPlan.capabilityStatus -eq "Enabled")
```

#### Example 3

The following expression selects all users who have no assigned service plan:

```
user.assignedPlans -all (assignedPlan.servicePlanId -eq null)
```

### Using the underscore (\_) syntax

The underscore (\_) syntax matches occurrences of a specific value in one of the multivalued string collection properties to add users or devices to a dynamic membership group. It's used with the -any or -all operators.

Here's an example of using the underscore (\_) in a rule to add members based on user.proxyAddress (it works the same for user.otherMails). This rule adds any user with proxy address that starts with "contoso" to the group.

```
(user.proxyAddresses -any (_ -startsWith "contoso"))
```

## Other properties and common rules

### Create a "Direct reports" rule

You can create a group containing all direct reports of a manager. When the manager's direct reports change in the future, the group's membership is adjusted automatically.

The direct reports rule is constructed using the following syntax:

```
Direct Reports for "{objectID_of_manager}"
```

Here's an example of a valid rule, where "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb" is the objectID of the manager:

```
Direct Reports for "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
```

The following tips can help you use the rule properly.

- The **Manager ID** is the object ID of the manager. It can be found in the manager's **Profile**.
- For the rule to work, make sure the **Manager** property is set correctly for users in your organization. You can check the current value in the user's **Profile**.
- This rule supports only the manager's direct reports. In other words, you can't create a group with the manager's direct reports *and* their reports.
- This rule can't be combined with any other membership rules.

### Create an "All users" rule

You can create a group containing all users within an organization using a membership rule. When users are added or removed from the organization in the future, the group's membership is adjusted automatically.

The "All users" rule is constructed using single expression using the -ne operator and the null value. This rule adds B2B guest users and member users to the group.

```
user.objectId -ne null
```
If you want your group to exclude guest users and include only members of your organization, you can use the following syntax:

```
(user.objectId -ne null) -and (user.userType -eq "Member")
```

### Create an "All devices" rule

You can create a group containing all devices within an organization using a membership rule. When devices are added or removed from the organization in the future, the group's membership is adjusted automatically.

The "All Devices" rule is constructed using single expression using the -ne operator and the null value:

```
device.objectId -ne null
```

## Extension properties and custom extension properties

Extension attributes and custom extension properties are supported as string properties in rules for dynamic membership groups. [Extension attributes](/graph/api/resources/onpremisesextensionattributes) can be synced from on-premises Window Server Active Directory or updated using Microsoft Graph and take the format of "ExtensionAttributeX", where X equals 1 - 15. Multi-value extension properties aren't supported in rules for dynamic membership groups. 

Here's an example of a rule that uses an extension attribute as a property:

```
(user.extensionAttribute15 -eq "Marketing")
```

[Custom extension properties](~/identity/hybrid/connect/how-to-connect-sync-feature-directory-extensions.md) can be synced from on-premises Windows Server Active Directory, from a connected SaaS application, or created using Microsoft Graph, and are of the format of `user.extension_[GUID]_[Attribute]`, where:

- [GUID] is the stripped version of the unique identifier in Microsoft Entra ID for the application that created the property. It contains only characters 0-9 and A-Z
- [Attribute] is the name of the property as it was created

An example of a rule that uses a custom extension property is:

```
user.extension_c272a57b722d4eb29bfe327874ae79cb_OfficeNumber -eq "123"
```

Custom extension properties are also called directory or Microsoft Entra extension properties.

The custom property name can be found in the directory by querying a user's property using Graph Explorer and searching for the property name. Also, you can now select **Get custom extension properties** link in the dynamic membership groups rule builder to enter a unique app ID and receive the full list of custom extension properties to use when creating a rule for dynamic membership groups. This list can also be refreshed to get any new custom extension properties for that app. Extension attributes and custom extension properties must be from applications in your tenant.  

For more information, see [Use the attributes in dynamic membership groups](~/identity/hybrid/connect/how-to-connect-sync-feature-directory-extensions.md) in the article [Microsoft Entra Connect Sync: Directory extensions](~/identity/hybrid/connect/how-to-connect-sync-feature-directory-extensions.md).

## Rules for devices

You can also create a rule that selects device objects for membership in a group. You can't have both users and devices as group members. 

> [!NOTE]
> The `organizationalUnit` attribute is no longer listed and should not be used. This string is set by Intune in specific cases but is not recognized by Microsoft Entra ID, so no devices are added to groups based on this attribute.
>
> The `systemlabels` attribute is read-only and cannot be set with Intune.

For Windows 10, the correct format of the `deviceOSVersion` attribute is as follows: (device.deviceOSVersion -startsWith "10.0.1"). The formatting can be validated with the Get-MgDevice PowerShell cmdlet:

```
Get-MgDevice -Search "displayName:YourMachineNameHere" -ConsistencyLevel eventual | Select-Object -ExpandProperty 'OperatingSystemVersion'
```

The following device attributes can be used.

<!-- docutune:disable -->

 Device attribute  | Values | Example
 ----- | ----- | ----------------
 accountEnabled | true false | device.accountEnabled -eq true
 deviceCategory | a valid device category name | device.deviceCategory -eq "BYOD"
 deviceId | a valid Microsoft Entra device ID | device.deviceId -eq "d4fe7726-5966-431c-b3b8-cddc8fdb717d"
 deviceManagementAppId | a valid MDM application ID in Microsoft Entra ID | device.deviceManagementAppId -eq "0000000a-0000-0000-c000-000000000000" for Microsoft Intune managed or "54b943f8-d761-4f8d-951e-9cea1846db5a" for System Center Configuration Manager Co-managed devices
 deviceManufacturer | any string value | device.deviceManufacturer -eq "Samsung"
 deviceModel | any string value | device.deviceModel -eq "iPad Air"
 displayName | any string value | device.displayName -eq "Rob iPhone"
 deviceOSType | any string value | (device.deviceOSType -eq "iPad") -or (device.deviceOSType -eq "iOS")<br>device.deviceOSType -startsWith "AndroidEnterprise" <br>device.deviceOSType -eq "AndroidForWork"<br>device.deviceOSType -eq "Windows"
 deviceOSVersion | any string value | device.deviceOSVersion -eq "9.1"<br>device.deviceOSVersion -startsWith "10.0.1"
 deviceOwnership | Personal, Company, Unknown | device.deviceOwnership -eq "Company"
 devicePhysicalIds | any string value used by Autopilot, such as all Autopilot devices, OrderID, or PurchaseOrderID  | device.devicePhysicalIDs -any _ -startsWith "[ZTDId]"<br>(device.devicePhysicalIds -any _ -eq "[OrderID]:179887111881"<br>(device.devicePhysicalIds -any _ -eq "[PurchaseOrderId]:76222342342"
 deviceTrustType | AzureAD, ServerAD, Workplace | device.deviceTrustType -eq "AzureAD"
 enrollmentProfileName | Apple Device Enrollment Profile name, Android Enterprise Corporate-owned dedicated device Enrollment Profile name, or Windows Autopilot profile name | device.enrollmentProfileName -eq "DEP iPhones"
 extensionAttribute1 | any string value | device.extensionAttribute1 -eq "some string value"
 extensionAttribute2 | any string value | device.extensionAttribute2 -eq "some string value"
 extensionAttribute3 | any string value | device.extensionAttribute3 -eq "some string value"
 extensionAttribute4 | any string value | device.extensionAttribute4 -eq "some string value"
 extensionAttribute5 | any string value | device.extensionAttribute5 -eq "some string value"
 extensionAttribute6 | any string value | device.extensionAttribute6 -eq "some string value"
 extensionAttribute7 | any string value | device.extensionAttribute7 -eq "some string value"
 extensionAttribute8 | any string value | device.extensionAttribute8 -eq "some string value"
 extensionAttribute9 | any string value | device.extensionAttribute9 -eq "some string value"
 extensionAttribute10 | any string value | device.extensionAttribute10 -eq "some string value"
 extensionAttribute11 | any string value | device.extensionAttribute11 -eq "some string value"
 extensionAttribute12 | any string value | device.extensionAttribute12 -eq "some string value"
 extensionAttribute13 | any string value | device.extensionAttribute13 -eq "some string value"
 extensionAttribute14 | any string value | device.extensionAttribute14 -eq "some string value"
 extensionAttribute15 | any string value | device.extensionAttribute15 -eq "some string value"
 isRooted | true false | device.isRooted -eq true
 managementType | MDM (for mobile devices) | device.managementType -eq "MDM"
 memberOf | Any string value (valid group object ID) | device.memberOf -any (group.objectId -in ['value']) 
 objectId | a valid Microsoft Entra object ID | device.objectId -eq "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
 profileType | a valid [profile type](/graph/api/resources/device?view=graph-rest-1.0&preserve-view=true#properties) in Microsoft Entra ID | device.profileType -eq "RegisteredDevice"
 systemLabels | a read-only string matching the Intune device property for tagging Modern Workplace devices | device.systemLabels -startsWith "M365Managed" SystemLabels

<!-- docutune:enable -->

> [!NOTE]
> When using `systemLabels`, a read-only attribute that is used in various contexts, such as device management and sensitivity labeling, is not editable through Intune.<br>
> When using `deviceOwnership` to create dynamic membership groups for devices, you need to set the value equal to `Company`. On Intune the device ownership is represented instead as Corporate. For more information, see [OwnerTypes](/mem/intune/developer/reports-ref-devices#ownertypes) for more details. <br>
> When using `deviceTrustType` to create dynamic membership groups for devices, you need to set the value equal to `AzureAD` to represent Microsoft Entra joined devices, `ServerAD` to represent Microsoft Entra hybrid joined devices or `Workplace` to represent Microsoft Entra registered devices.<br>
> When using `extensionAttribute1-15` to create dynamic membership groups for devices you need to set the value for `extensionAttribute1-15` on the device. Learn more on [how to write `extensionAttributes` on a Microsoft Entra device object](/graph/api/device-update?view=graph-rest-1.0&tabs=http&preserve-view=true#example-2--write-extensionattributes-on-a-device)

## Next steps

These articles provide additional information on groups in Microsoft Entra ID.

- [See existing groups](~/fundamentals/groups-view-azure-portal.md)
- [Create a new group and adding members](~/fundamentals/how-to-manage-groups.yml)
- [Manage settings of a group](~/fundamentals/how-to-manage-groups.yml)
- [Manage memberships of a group](~/fundamentals/how-to-manage-groups.yml)
- [Manage rules for dynamic membership groups for users](groups-create-rule.md)
