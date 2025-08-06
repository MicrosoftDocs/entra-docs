---
title: Manage Rules for Dynamic Membership Groups in Microsoft Entra ID
description: Learn how to manage rules for dynamic membership groups to automatically populate group members and rule references.

author: barclayn
manager: pmwongera
ms.service: entra-id
ms.subservice: users
ms.topic: how-to
ms.date: 12/19/2024
ms.author: barclayn
ms.reviewer: krbain
ms.custom: it-pro
---

# Manage rules for dynamic membership groups in Microsoft Entra ID

You can create user-based or device attribute-based rules to enable membership for dynamic membership groups in Microsoft Entra ID. You can add and remove dynamic membership groups automatically by using membership rules based on member attributes. In Microsoft Entra, a single tenant can have a maximum of 15,000 dynamic membership groups.

This article details the properties and syntax to create rules for dynamic membership groups based on users or devices.

> [!NOTE]
> Security groups can include either devices or users, but Microsoft 365 groups can include only users.

## Considerations for dynamic membership groups

When the attributes of a user or a device change, the system evaluates all rules for dynamic membership groups in a directory to see if the change would trigger any group additions or removals. If users or devices satisfy a rule on a group, they're added as members of that group. If they no longer satisfy the rule, they're removed. You can't manually add or remove a member of a dynamic membership group.

Also keep these limitations in mind:

- You can create a dynamic membership groups for users or devices, but you can't create a rule that contains both users and devices.
- You can't create a device membership group based on the user attributes of the device owner. Device membership rules can reference only device attributes.

### License requirements

The feature of dynamic membership groups requires a Microsoft Entra ID P1 license or an Intune for Education license for each unique user who's a member of one or more dynamic membership groups. You don't have to assign licenses to users for them to be members of dynamic membership groups. But you must have the minimum number of licenses in the Microsoft Entra organization to cover all such users.

For example, if you have a total of 1,000 unique users in all dynamic membership groups in your organization, you need at least 1,000 licenses for Microsoft Entra ID P1 to meet the license requirement.

No license is required for devices that are members of a dynamic membership group based on a device.

## Rule builder in the Azure portal

Microsoft Entra ID provides a rule builder to create and update your important rules more quickly. The rule builder supports the construction of up to five expressions. You can use the rule builder to form a rule with a few simple expressions, but you can't use it to reproduce every rule. If the rule builder doesn't support the rule that you want to create, you can use the text box.

:::image type="content" source="./media/groups-dynamic-membership/update-dynamic-group-rule.png" alt-text="Screenshot that shows the rule builder, with the action for adding an expression highlighted.":::

For step-by-step instructions, see [Create or update a dynamic membership group](groups-create-rule.md).

> [!IMPORTANT]
> The rule builder is available only for user-based dynamic membership groups. You can create device-based dynamic membership groups only by using the text box.

Here are some examples of advanced rules or syntax that require the use of the text box:

- Rule with more than five expressions
- Rule for direct reports
- Rule with a `-contains` or `-notContains` operator
- Setting [operator precedence](#operator-precedence)
- [Rule with complex expressions](#rules-with-complex-expressions); for example, `(user.proxyAddresses -any (_ -startsWith "contoso"))`

> [!NOTE]
> The rule builder might not be able to display some rules constructed in the text box. You might see a message when the rule builder can't display the rule. The rule builder doesn't change the supported syntax, validation, or processing of rules for dynamic membership groups in any way.

## Rule syntax for a single expression

A single expression is the simplest form of a membership rule. A rule with a single expression takes the form of `<Property> <Operator> <Value>`, where the syntax for the property is the name of `<object>.<property>`.

The following example illustrates a properly constructed membership rule with a single expression:

```
user.department -eq "Sales"
```

Parentheses are optional for a single expression. The total length of the body of your membership rule can't exceed 3,072 characters.

### Constructing the body of a membership rule

A membership rule that automatically populates a group with users or devices is a binary expression that results in a true or false outcome. The three parts of a simple rule are:

- Property
- Operator
- Value

The order of the parts within an expression is important to avoid syntax errors.

### Supported properties

You can use three types of properties to construct a membership rule:

- Boolean
- Date/time
- String
- String collection

You can use the following user properties to create a single expression.

#### Properties of type Boolean

| Property | Allowed values | Usage |
| --- | --- | --- |
| `accountEnabled` |`true`, `false` |```user.accountEnabled -eq true``` |
| `dirSyncEnabled` |`true`, `false` |```user.dirSyncEnabled -eq true``` |

#### Properties of type date/time

| Property | Allowed values | Usage |
| --- | --- | --- |
| `employeeHireDate` (preview) |Any `DateTimeOffset` value or keyword `system.now` | ```user.employeeHireDate -eq "value"``` |

#### Properties of type string

| Property | Allowed values | Usage |
| --- | --- | --- |
| `city` |Any string value or `null` | ```user.city -eq "value"``` |
| `country` |Any string value or `null` | ```user.country -eq "value"``` |
| `companyName` | Any string value or `null` | ```user.companyName -eq "value"``` |
| `department` |Any string value or `null` | ```user.department -eq "value"``` |
| `displayName` |Any string value | ```user.displayName -eq "value"``` |
| `employeeId` |Any string value | ```user.employeeId -eq "value"```<br><br>```user.employeeId -ne "null"``` |
| `facsimileTelephoneNumber` |Any string value or `null` | ```user.facsimileTelephoneNumber -eq "value"``` |
| `givenName` |Any string value or `null` | ```user.givenName -eq "value"``` |
| `jobTitle` |Any string value or `null` | ```user.jobTitle -eq "value"``` |
| `mail` |Any string value or `null` (SMTP address of the user) | ```user.mail -eq "value"```<br><br>```user.mail -notEndsWith "@Contoso.com"``` |
| `mailNickName` |Any string value (mail alias of the user) | ```user.mailNickName -eq "value"```<br><br>```user.mailNickname -endsWith "-vendor"``` |
| `memberOf` | Any string value (valid group object ID) | ```user.memberOf -any (group.objectId -in ['value'])``` |
| `mobile` |Any string value or `null` | ```user.mobile -eq "value"```|
| `objectId` |GUID of the user object | ```user.objectId -eq "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"```|
| `onPremisesDistinguishedName` | Any string value or `null` | ```user.onPremisesDistinguishedName -eq "value"```|
| `onPremisesSecurityIdentifier` | On-premises security identifier (SID) for users who were synchronized from on-premises to the cloud | ```user.onPremisesSecurityIdentifier -eq "S-1-1-11-1111111111-1111111111-1111111111-1111111"``` |
| `passwordPolicies` |`None`, `DisableStrongPassword`, `DisablePasswordExpiration`, `DisablePasswordExpiration`, `DisableStrongPassword` | ```user.passwordPolicies -eq "DisableStrongPassword"``` |
| `physicalDeliveryOfficeName` |Any string value or `null` | ```user.physicalDeliveryOfficeName -eq "value"``` |
| `postalCode` |Any string value or `null` | ```user.postalCode -eq "value"``` |
| `preferredLanguage` |ISO 639-1 code | ```user.preferredLanguage -eq "en-US"``` |
| `sipProxyAddress` |Any string value or `null` | ```user.sipProxyAddress -eq "value"``` |
| `state` |Any string value or `null` | ```user.state -eq "value"``` |
| `streetAddress` |Any string value or `null` | ```user.streetAddress -eq "value"``` |
| `surname` |Any string value or `null` | ```user.surname -eq "value"``` |
| `telephoneNumber` |Any string value or `null` | ```user.telephoneNumber -eq "value"``` |
| `usageLocation` |Two-letter country or region code | ```user.usageLocation -eq "US"``` |
| `userPrincipalName` |Any string value | ```user.userPrincipalName -eq "alias@domain"``` |
| `userType` |`member`, `guest`, `null` | ```user.userType -eq "Member"``` |

#### Properties of type string collection

| Property | Allowed values | Examples |
| --- | --- | --- |
| `otherMails` |Any string value | ```user.otherMails -startsWith "alias@domain"```<br><br>```user.otherMails -endsWith"@contoso.com"``` |
| `proxyAddresses` |`SMTP: alias@domain`, `smtp: alias@domain` | ```user.proxyAddresses -startsWith "SMTP: alias@domain"```<br><br>```user.proxyAddresses -notEndsWith "@outlook.com"``` |

For the properties used for device rules, see [Rules for devices](#rules-for-devices).

### Supported expression operators

The following table lists all the supported operators and their syntax for a single expression. You can use operators with or without the hyphen (`-`) prefix. The `Contains` operator does partial string matches but not matches for items in a collection.

> [!CAUTION]
> For best results, minimize the use of `Match` or `Contains` as much as possible. The article [Create simpler, more efficient rules for dynamic membership groups](groups-dynamic-rule-more-efficient.md) provides guidance on how to create rules that result in better dynamic group processing times. The [`memberOf`](groups-dynamic-rule-member-of.md) operator is in preview and has some limitations, so use it with caution.

| Operator | Syntax |
| --- | --- |
| `Ends With` | `-endsWith` |
| `Not Ends With` | `-notEndsWith` |
| `Not Equals` | `-ne` |
| `Equals` | `-eq` |
| `Not Starts With` | `-notStartsWith` |
| `Starts With` | `-startsWith` |
| `Not Contains` | `-notContains` |
| `Contains` | `-contains` |
| `Not Match` | `-notMatch` |
| `Match` | `-match` |
| `In` | `-in` |
| `Not In` | `-notIn` |

#### Using the -in and -notIn operators

If you want to compare the value of a user attribute against multiple values, you can use the `-in` or `-notIn` operator. Use the bracket symbols (`[` and `]`) to begin and end the list of values.

In the following example, the expression evaluates to `true` if the value of `user.department` equals any of the values in the list:

```
   user.department -in ["50001","50002","50003","50005","50006","50007","50008","50016","50020","50024","50038","50039","51100"]
```

#### Using the -le and -ge operators

You can use the less than (`-le`) or greater than (`-ge`) operator when you're using the `employeeHireDate` attribute in rules for dynamic membership groups.

Here are examples:

```
user.employeehiredate -ge system.now -plus p1d 

user.employeehiredate -le 2020-06-10T18:13:20Z 

```

#### Using the -match operator

You can use the `-match` operator for matching any regular expression.

For the following example, `Da`, `Dav`, and `David` evaluate to `true`. `aDa` evaluates to `false`.

```
user.displayName -match "^Da.*"   
```

For the following example, `David` evaluates to `true`. `Da` evaluates to `false`.

```
user.displayName -match ".*vid"
```

### Supported values

The values that you use in an expression can consist of several types:

- Strings
- Boolean (`true`, `false`)
- Numbers
- Arrays (number array, string array)

When you specify a value within an expression, it's important to use the correct syntax to avoid errors. Here are some syntax tips:

- Double quotation marks are optional unless the value is a string.
- Regex and string operations aren't case sensitive.
- Ensure that property names are correctly formatted as shown, because they're case sensitive.
- When a string value contains double quotation marks, you should escape both quotation marks by using the backslash (`\`) character. For example, *user.department -eq \`"Sales\`"* is the proper syntax when `Sales` is the value. Escape single quotation marks by using two single quotation marks instead of one each time.
- You can also perform null checks by using `null` as a value; for example, `user.department -eq null`.

#### Use of null values

To specify a `null` value in a rule:

- Use `-eq` or `-ne` when you're comparing the `null` value in an expression.
- Use quotation marks around the word `null` only if you want it to be interpreted as a literal string value.
- Don't use the `-not` operator as a comparative operator for the null value. If you use it, you get an error whether you use `null` or `$null`.

The correct way to reference the `null` value is as follows:

```
   user.mail –ne null
```

## Rules with multiple expressions

Rules for dynamic membership groups can consist of more than one single expression connected by the `-and`, `-or`, and `-not` logical operators. You can also use logical operators in combination.

The following are examples of properly constructed membership rules with multiple expressions:

```
(user.department -eq "Sales") -or (user.department -eq "Marketing")
(user.department -eq "Sales") -and -not (user.jobTitle -startsWith "SDE")
```

### Operator precedence

The following list shows all operators in order of precedence from highest to lowest. Operators on the same line are of equal precedence.

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

You need parentheses only when precedence doesn't meet your requirements. For example, if you want the department to be evaluated first, the following code shows how you can use parentheses to determine the order:

```
   user.country –eq "US" –and (user.department –eq "Marketing" –or user.department –eq "Sales")
```

## Rules with complex expressions

A membership rule can consist of complex expressions where the properties, operators, and values take on more complex forms. Expressions are considered complex when any of the following points are true:

- The property consists of a collection of values; specifically, multi-value properties.
- The expressions use the `-any` and `-all` operators.
- The value of the expression can itself be one or more expressions.

### Multi-value properties

Multi-value properties are collections of objects of the same type. You can use them to create membership rules by using the `-any` and `-all` logical operators.

| Property | Values | Usage |
| --- | --- | --- |
| `assignedPlans` | Each object in the collection exposes the following string properties: `capabilityStatus`, `service`, `servicePlanId` | ```user.assignedPlans -any (assignedPlan.servicePlanId -eq "aaaa0a0a-bb1b-cc2c-dd3d-eeeeee4e4e4e" -and assignedPlan.capabilityStatus -eq "Enabled")```|
| `proxyAddresses` | `SMTP: alias@domain`, `smtp: alias@domain` | ```(user.proxyAddresses -any (\_ -startsWith "contoso"))``` |

#### Using the -any and -all operators

You can use the following operators to apply a condition to one or all of the items in the collection:

- `-any`: Satisfied when at least one item in the collection matches the condition.
- `-all`: Satisfied when all items in the collection match the condition.

##### Example 1

`assignedPlans` is a multi-value property that lists all service plans assigned to the user. The following expression selects users who have the Exchange Online (Plan 2) service plan (as a GUID value) that's also in an `Enabled` state:

```
user.assignedPlans -any (assignedPlan.servicePlanId -eq "efb87545-963c-4e0d-99df-69c6916d9eb0" -and assignedPlan.capabilityStatus -eq "Enabled")
```

You can use a rule like this one to group all users for whom a Microsoft 365 or other Microsoft Online Services capability is enabled. You could then apply the rule with a set of policies to the group.

##### Example 2

The following expression selects all users who have any service plan that's associated with the Intune service (identified by the service name `SCO`):

```
user.assignedPlans -any (assignedPlan.service -eq "SCO" -and assignedPlan.capabilityStatus -eq "Enabled")
```

##### Example 3

The following expression selects all users who have no assigned service plan:

```
user.assignedPlans -all (assignedPlan.servicePlanId -eq null)
```

#### Using the underscore (\_) syntax

The underscore (`_`) syntax matches occurrences of a specific value in one of the multi-value string collection properties to add users or devices to a dynamic membership group. You use it with the `-any` or `-all` operator.

Here's an example of using the underscore in a rule to add members based on `user.proxyAddress`. (It works the same for `user.otherMails`.) This rule adds any user who has a proxy address that starts with `contoso` to the group.

```
(user.proxyAddresses -any (_ -startsWith "contoso"))
```

### Other properties and common rules

#### Create a rule for direct reports

You can create a group that contains all direct reports of a manager. When the manager's direct reports change in the future, the group's membership is adjusted automatically.

You construct the direct reports rule by using the following syntax:

```
Direct Reports for "{objectID_of_manager}"
```

Here's an example of a valid rule, where `aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb` is the object ID of the manager:

```
Direct Reports for "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
```

The following tips can help you use the rule properly:

- The *manager ID* is the object ID of the manager. You can find it in the manager's profile.
- For the rule to work, make sure that the `Manager` property is set correctly for users in your organization. You can check the current value in the user's profile.
- This rule supports only the manager's direct reports. You can't create a group that has the manager's direct reports *and* their reports.
- You can't combine this rule with any other membership rules.

#### Create a rule for all users

You can create a group that contains all users within an organization by using a membership rule. When users are added or removed from the organization in the future, the group's membership is adjusted automatically.

You construct the rule for all users by using a single expression that includes the `-ne` operator and the `null` value. This rule adds business-to-business guest users and member users to the group.

```
user.objectId -ne null
```

If you want your group to exclude guest users and include only members of your organization, you can use the following syntax:

```
(user.objectId -ne null) -and (user.userType -eq "Member")
```

#### Create a rule for all devices

You can create a group that contains all devices within an organization by using a membership rule. When devices are added or removed from the organization in the future, the group's membership is adjusted automatically.

You construct the rule for all devices by using single expression that includes the `-ne` operator and the `null` value:

```
device.objectId -ne null
```

### Extension attributes and custom extension properties

Extension attributes and custom extension properties are supported as string properties in rules for dynamic membership groups.

You can [sync extension attributes](/graph/api/resources/onpremisesextensionattributes) from on-premises Windows Server Active Directory. Or you can update extension attributes by using Microsoft Graph.

Extension attributes take the format of `ExtensionAttribute<X>`, where `<X>` equals `1`-`15`. Multi-value extension properties aren't supported in rules for dynamic membership groups.

Here's an example of a rule that uses an extension attribute as a property:

```
(user.extensionAttribute15 -eq "Marketing")
```

You can [sync custom extension properties](~/identity/hybrid/connect/how-to-connect-sync-feature-directory-extensions.md) from on-premises Windows Server Active Directory or from a connected software as a service (SaaS) application. You can create custom extension properties by using Microsoft Graph.

Custom extension properties take the format of `user.extension_[GUID]_[Attribute]`, where:

- `[GUID]` is the stripped version of the unique identifier in Microsoft Entra ID for the application that created the property. It contains only characters 0-9 and A-Z.
- `[Attribute]` is the name of the property as it was created.

An example of a rule that uses a custom extension property is:

```
user.extension_c272a57b722d4eb29bfe327874ae79cb_OfficeNumber -eq "123"
```

Custom extension properties are also called directory or Microsoft Entra extension properties.

You can find the custom property name in the directory by querying a user's property in Graph Explorer and searching for the property name. Also, you can now select the **Get custom extension properties** link in the dynamic rule builder to enter a unique app ID and receive the full list of custom extension properties to use when creating a rule for dynamic membership groups. You can refresh this list to get any new custom extension properties for that app. Extension attributes and custom extension properties must be from applications in your tenant.  

For more information, see [Use the attributes in dynamic membership groups](~/identity/hybrid/connect/how-to-connect-sync-feature-directory-extensions.md#use-the-attributes-in-dynamic-membership-groups).

## Rules for devices

You can create a rule that selects device objects for membership in a group. You can't have both users and devices as group members.

> [!NOTE]
> The `organizationalUnit` attribute is no longer listed, and you shouldn't use it. Intune sets this string in specific cases, but Microsoft Entra ID doesn't recognize it. No devices are added to groups based on this attribute.
>
> The `systemlabels` attribute is read-only. You can't set it with Intune.

For Windows 10, the correct format of the `deviceOSVersion` attribute is `device.deviceOSVersion -startsWith "10.0.1"`. You can validate the formatting by using the `Get-MgDevice` PowerShell cmdlet:

```
Get-MgDevice -Search "displayName:YourMachineNameHere" -ConsistencyLevel eventual | Select-Object -ExpandProperty 'OperatingSystemVersion'
```

You can use the following device attributes.

<!-- docutune:disable -->

 | Device attribute  | Values | Examples |
 | ----- | ----- | ---------------- |
 | `accountEnabled` | `true`, `false` | `device.accountEnabled -eq true` |
 | `deviceCategory` | A valid device category name | `device.deviceCategory -eq "BYOD"` |
 | `deviceId` | A valid Microsoft Entra device ID | `device.deviceId -eq "d4fe7726-5966-431c-b3b8-cddc8fdb717d"` |
 | `deviceManagementAppId` | A valid application ID for mobile device management in Microsoft Entra ID | `device.deviceManagementAppId -eq "0000000a-0000-0000-c000-000000000000"` for Microsoft Intune managed devices<br><br>`"54b943f8-d761-4f8d-951e-9cea1846db5a"` for System Center Configuration Manager co-managed devices |
 | `deviceManufacturer` | Any string value | `device.deviceManufacturer -eq "Samsung"` |
 | `deviceModel` | Any string value | `device.deviceModel -eq "iPad Air"` |
 | `displayName` | Any string value | `device.displayName -eq "Rob iPhone"` |
 | `deviceOSType` | Any string value | `(device.deviceOSType -eq "iPad") -or (device.deviceOSType -eq "iOS")`<br><br>`device.deviceOSType -startsWith "AndroidEnterprise"`<br><br>`device.deviceOSType -eq "AndroidForWork"`<br><br>`device.deviceOSType -eq "Windows"` |
 | `deviceOSVersion` | Any string value | `device.deviceOSVersion -eq "9.1"`<br><br>`device.deviceOSVersion -startsWith "10.0.1"` |
 | `deviceOwnership`<sup>1</sup> | `Personal`, `Company`, `Unknown` | `device.deviceOwnership -eq "Company"` |
 | `devicePhysicalIds` | Any string value that Windows Autopilot uses, such as all Windows Autopilot devices, `OrderID`, or `PurchaseOrderID`  | `device.devicePhysicalIDs -any _ -startsWith "[ZTDId]"`<br><br>`device.devicePhysicalIds -any _ -eq "[OrderID]:179887111881"`<br><br>`device.devicePhysicalIds -any _ -eq "[PurchaseOrderId]:76222342342"` |
 | `deviceTrustType`<sup>2</sup> | `AzureAD`, `ServerAD`, `Workplace` | `device.deviceTrustType -eq "AzureAD"` |
 | `enrollmentProfileName` | Profile name for Apple Automated Device Enrollment, Android Enterprise corporate-owned dedicated device enrollment, or Windows Autopilot | `device.enrollmentProfileName -eq "DEP iPhones"` |
 | `extensionAttribute1`<sup>3</sup> | Any string value | `device.extensionAttribute1 -eq "some string value"` |
 | `extensionAttribute2` | Any string value | `device.extensionAttribute2 -eq "some string value"` |
 | `extensionAttribute3` | Any string value | `device.extensionAttribute3 -eq "some string value"` |
 | `extensionAttribute4` | Any string value | `device.extensionAttribute4 -eq "some string value"` |
 | `extensionAttribute5` | Any string value | `device.extensionAttribute5 -eq "some string value"` |
 | `extensionAttribute6` | Any string value | `device.extensionAttribute6 -eq "some string value"` |
 | `extensionAttribute7` | Any string value | `device.extensionAttribute7 -eq "some string value"` |
 | `extensionAttribute8` | Any string value | `device.extensionAttribute8 -eq "some string value"` |
 | `extensionAttribute9` | Any string value | `device.extensionAttribute9 -eq "some string value"` |
 | `extensionAttribute10` | Any string value | `device.extensionAttribute10 -eq "some string value"` |
 | `extensionAttribute11` | Any string value | `device.extensionAttribute11 -eq "some string value"` |
 | `extensionAttribute12` | Any string value | `device.extensionAttribute12 -eq "some string value"` |
 | `extensionAttribute13` | Any string value | `device.extensionAttribute13 -eq "some string value"` |
 | `extensionAttribute14` | Any string value | `device.extensionAttribute14 -eq "some string value"` |
 | `extensionAttribute15` | Any string value | `device.extensionAttribute15 -eq "some string value"` |
 | `isRooted` | `true`, `false` | `device.isRooted -eq true` |
 | `managementType` | Mobile device management (for mobile devices) | `device.managementType -eq "MDM"` |
 | `memberOf` | Any string value (valid group object ID) | `device.memberOf -any (group.objectId -in ['value'])` |
 | `objectId` | A valid Microsoft Entra object ID | `device.objectId -eq "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"` |
 | `profileType` | A valid [profile type](/graph/api/resources/device?view=graph-rest-1.0&preserve-view=true#properties) in Microsoft Entra ID | `device.profileType -eq "RegisteredDevice"` |
 | `systemLabels`<sup>4</sup> | A read-only string that matches the Intune device property for tagging Modern Workplace devices | `device.systemLabels -startsWith "M365Managed" SystemLabels` |

<!-- docutune:enable -->

<sup>1</sup> When you use `deviceOwnership` to create dynamic membership groups for devices, you need to set the value equal to `Company`. On Intune, the device ownership is represented instead as `Corporate`. For more information, see [`ownerTypes`](/mem/intune/developer/reports-ref-devices#ownertypes).

<sup>2</sup> When you use `deviceTrustType` to create dynamic membership groups for devices, you need to set the value equal to `AzureAD` to represent Microsoft Entra joined devices, `ServerAD` to represent Microsoft Entra hybrid joined devices, or `Workplace` to represent Microsoft Entra registered devices.

<sup>3</sup> When you use `extensionAttribute1-15` to create dynamic membership groups for devices, you need to set the value for `extensionAttribute1-15` on the device. [Learn more about how to write `extensionAttributes` on a Microsoft Entra device object](/graph/api/device-update?view=graph-rest-1.0&tabs=http&preserve-view=true#example-2--write-extensionattributes-on-a-device).

<sup>4</sup> When you use `systemLabels`, a read-only attribute that's used in various contexts (such as device management and sensitivity labeling) is not editable through Intune.

## Related content

- [Create a group with members and view all groups and members](~/fundamentals/groups-view-azure-portal.md)
- [Manage Microsoft Entra groups and group membership](/entra/fundamentals/how-to-manage-groups)
- [Create or update a dynamic membership group in Microsoft Entra ID](groups-create-rule.md)
