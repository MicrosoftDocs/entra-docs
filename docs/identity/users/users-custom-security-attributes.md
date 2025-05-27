---
title: Assign, update, list, or remove custom security attributes for a user
description: Assign, update, list, or remove custom security attributes for a user in Microsoft Entra ID.
author: rolyon
manager: femila
ms.author: rolyon
ms.date: 08/25/2024
ms.topic: how-to
ms.service: entra-id
ms.subservice: users
ms.custom: it-pro, no-azure-ad-ps-ref, sfi-image-nochange
---

# Assign, update, list, or remove custom security attributes for a user

[Custom security attributes](~/fundamentals/custom-security-attributes-overview.md) in Microsoft Entra ID, part of Microsoft Entra, are business-specific attributes (key-value pairs) that you can define and assign to Microsoft Entra objects. For example, you can assign custom security attribute to filter your employees or to help determine who gets access to resources. This article describes how to assign, update, list, or remove custom security attributes for Microsoft Entra ID.

## Prerequisites

To assign or remove custom security attributes for a user in your Microsoft Entra tenant, you need:

- [Attribute Assignment Administrator](~/identity/role-based-access-control/permissions-reference.md#attribute-assignment-administrator)
- Microsoft.Graph module when using [Microsoft Graph PowerShell](/powershell/microsoftgraph/installation)

[!INCLUDE [security-attributes-roles](../../includes/security-attributes-roles.md)]
    
## Assign custom security attributes to a user


1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as an [Attribute Assignment Administrator](~/identity/role-based-access-control/permissions-reference.md#attribute-assignment-administrator).

1. Make sure that you have defined custom security attributes. For more information, see [Add or deactivate custom security attribute definitions in Microsoft Entra ID](~/fundamentals/custom-security-attributes-add.md).

1. Browse to **Identity **Users** > **All users**.

1. Find and select the user you want to assign custom security attributes to.

1. In the Manage section, select **Custom security attributes**.

1. Select **Add assignment**.

1. In **Attribute set**, select an attribute set from the list.

1. In **Attribute name**, select a custom security attribute from the list.
  
1. Depending on the properties of the selected custom security attribute, you can enter a single value, select a value from a predefined list, or add multiple values.

    - For freeform, single-valued custom security attributes, enter a value in the **Assigned values** box.
    - For predefined custom security attribute values, select a value from the **Assigned values** list.
    - For multi-valued custom security attributes, select **Add values** to open the **Attribute values** pane and add your values. When finished adding values, select **Done**.

    :::image type="content" source="./media/users-custom-security-attributes/users-attributes-assign.png" alt-text="Screenshot showing assigning a custom security attribute to a user." lightbox="./media/users-custom-security-attributes/users-attributes-assign.png":::

1. When finished, select **Save** to assign the custom security attributes to the user.

## Update custom security attribute assignment values for a user

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as an [Attribute Assignment Administrator](~/identity/role-based-access-control/permissions-reference.md#attribute-assignment-administrator).

1. Browse to **Identity **Users** > **All users**.

1. Find and select the user that has a custom security attribute assignment value you want to update.

1. In the Manage section, select **Custom security attributes**.
  
1. Find the custom security attribute assignment value you want to update.

    Once you have assigned a custom security attribute to a user, you can only change the value of the custom security attribute. You can't change other properties of the custom security attribute, such as attribute set or attribute name.

1. Depending on the properties of the selected custom security attribute, you can update a single value, select a value from a predefined list, or update multiple values.

1. When finished, select **Save**.

## Filter users based on custom security attribute assignments

You can filter the list of custom security attributes assigned to users on the All users page.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as an [Attribute Assignment Reader](~/identity/role-based-access-control/permissions-reference.md#attribute-assignment-reader).

1. Browse to **Identity **Users** > **All users**.

1. Select **Add filter** to open the Add filter pane.

1. Select **Custom security attributes**.

1. Select your attribute set and attribute name.

1. For **Operator**, you can select equals (**==**), not equals (**!=**), or **starts with**.

1. For **Value**, enter or select a value.

    :::image type="content" source="./media/users-custom-security-attributes/users-attributes-filter.png" alt-text="Screenshot showing a custom security attribute filter for users." lightbox="./media/users-custom-security-attributes/users-attributes-filter.png":::

1. To apply the filter, select **Apply**.

## Remove custom security attribute assignments from a user

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as an [Attribute Assignment Administrator](~/identity/role-based-access-control/permissions-reference.md#attribute-assignment-administrator).

1. Browse to **Identity **Users** > **All users**.

1. Find and select the user that has the custom security attribute assignments you want to remove.

1. In the Manage section, select **Custom security attributes**.

1. Add check marks next to all the custom security attribute assignments you want to remove.

1. Select **Remove assignment**.

## PowerShell or Microsoft Graph API

To manage custom security attribute assignments for users in your Microsoft Entra organization, you can use PowerShell or Microsoft Graph API. The following examples can be used to manage assignments.

#### Assign a custom security attribute with a string value to a user

The following example assigns a custom security attribute with a string value to a user.

- Attribute set: `Engineering`
- Attribute: `ProjectDate`
- Attribute data type: String
- Attribute value: `"2024-11-15"`

# [PowerShell](#tab/ms-powershell)

[Update-MgUser](/powershell/module/microsoft.graph.users/update-mguser)

```powershell
$customSecurityAttributes = @{
    "Engineering" = @{
        "@odata.type" = "#Microsoft.DirectoryServices.CustomSecurityAttributeValue"
        "ProjectDate" = "2024-11-15"
    }
}
Update-MgUser -UserId $userId -CustomSecurityAttributes $customSecurityAttributes
```

# [Microsoft Graph](#tab/ms-graph)

[Update user](/graph/api/user-update)

```http
PATCH https://graph.microsoft.com/v1.0/users/{id}
{
    "customSecurityAttributes":
    {
        "Engineering":
        {
            "@odata.type":"#Microsoft.DirectoryServices.CustomSecurityAttributeValue",
            "ProjectDate":"2024-11-15"
        }
    }
}
```

---

#### Assign a custom security attribute with a multi-string value to a user

The following example assigns a custom security attribute with a multi-string value to a user.

- Attribute set: `Engineering`
- Attribute: `Project`
- Attribute data type: Collection of Strings
- Attribute value: `["Baker","Cascade"]`

# [PowerShell](#tab/ms-powershell)

[Update-MgUser](/powershell/module/microsoft.graph.users/update-mguser)

```powershell
$customSecurityAttributes = @{
    "Engineering" = @{
        "@odata.type" = "#Microsoft.DirectoryServices.CustomSecurityAttributeValue"
        "Project@odata.type" = "#Collection(String)"
        "Project" = @("Baker","Cascade")
    }
}
Update-MgUser -UserId $userId -CustomSecurityAttributes $customSecurityAttributes
```

# [Microsoft Graph](#tab/ms-graph)

[Update user](/graph/api/user-update)

```http
PATCH https://graph.microsoft.com/v1.0/users/{id}
{
    "customSecurityAttributes":
    {
        "Engineering":
        {
            "@odata.type":"#Microsoft.DirectoryServices.CustomSecurityAttributeValue",
            "Project@odata.type":"#Collection(String)",
            "Project":["Baker","Cascade"]
        }
    }
}
```

---

#### Assign a custom security attribute with an integer value to a user

The following example assigns a custom security attribute with an integer value to a user.

- Attribute set: `Engineering`
- Attribute: `NumVendors`
- Attribute data type: Integer
- Attribute value: `4`

# [PowerShell](#tab/ms-powershell)

[Update-MgUser](/powershell/module/microsoft.graph.users/update-mguser)

```powershell
$customSecurityAttributes = @{
    "Engineering" = @{
        "@odata.type" = "#Microsoft.DirectoryServices.CustomSecurityAttributeValue"
        "NumVendors@odata.type" = "#Int32"
        "NumVendors" = 4
    }
}
Update-MgUser -UserId $userId -CustomSecurityAttributes $customSecurityAttributes
```

# [Microsoft Graph](#tab/ms-graph)

[Update user](/graph/api/user-update)

```http
PATCH https://graph.microsoft.com/v1.0/users/{id}
{
    "customSecurityAttributes":
    {
        "Engineering":
        {
            "@odata.type":"#Microsoft.DirectoryServices.CustomSecurityAttributeValue",
            "NumVendors@odata.type":"#Int32",
            "NumVendors":4
        }
    }
}
```

---

#### Assign a custom security attribute with a multi-integer value to a user

The following example assigns a custom security attribute with a multi-integer value to a user.

- Attribute set: `Engineering`
- Attribute: `CostCenter`
- Attribute data type: Collection of Integers
- Attribute value: `[1001,1003]`

# [PowerShell](#tab/ms-powershell)

[Update-MgUser](/powershell/module/microsoft.graph.users/update-mguser)

```powershell
$customSecurityAttributes = @{
    "Engineering" = @{
        "@odata.type" = "#Microsoft.DirectoryServices.CustomSecurityAttributeValue"
        "CostCenter@odata.type" = "#Collection(Int32)"
        "CostCenter" = @(1001,1003)
    }
}
Update-MgUser -UserId $userId -CustomSecurityAttributes $customSecurityAttributes
```

# [Microsoft Graph](#tab/ms-graph)

[Update user](/graph/api/user-update)

```http
PATCH https://graph.microsoft.com/v1.0/users/{id}
{
    "customSecurityAttributes":
    {
        "Engineering":
        {
            "@odata.type":"#Microsoft.DirectoryServices.CustomSecurityAttributeValue",
            "CostCenter@odata.type":"#Collection(Int32)",
            "CostCenter":[1001,1003]
        }
    }
}
```

---

#### Assign a custom security attribute with a Boolean value to a user

The following example assigns a custom security attribute with a Boolean value to a user.

- Attribute set: `Engineering`
- Attribute: `Certification`
- Attribute data type: Boolean
- Attribute value: `true`

# [PowerShell](#tab/ms-powershell)

[Update-MgUser](/powershell/module/microsoft.graph.users/update-mguser)

```powershell
$customSecurityAttributes = @{
    "Engineering" = @{
        "@odata.type" = "#Microsoft.DirectoryServices.CustomSecurityAttributeValue"
        "Certification" = $true
    }
}
Update-MgUser -UserId $userId -CustomSecurityAttributes $customSecurityAttributes
```

# [Microsoft Graph](#tab/ms-graph)

[Update user](/graph/api/user-update)

```http
PATCH https://graph.microsoft.com/v1.0/users/{id}
{
    "customSecurityAttributes":
    {
        "Engineering":
        {
            "@odata.type":"#Microsoft.DirectoryServices.CustomSecurityAttributeValue",
            "Certification":true
        }
    }
}
```

---

#### Update a custom security attribute assignment with an integer value for a user

The following example updates a custom security attribute assignment with an integer value for a user.

- Attribute set: `Engineering`
- Attribute: `NumVendors`
- Attribute data type: Integer
- Attribute value: `8`

# [PowerShell](#tab/ms-powershell)

[Update-MgUser](/powershell/module/microsoft.graph.users/update-mguser)

```powershell
$customSecurityAttributes = @{
    "Engineering" = @{
        "@odata.type" = "#Microsoft.DirectoryServices.CustomSecurityAttributeValue"
        "NumVendors@odata.type" = "#Int32"
        "NumVendors" = 8
    }
}
Update-MgUser -UserId $userId -CustomSecurityAttributes $customSecurityAttributes
```

# [Microsoft Graph](#tab/ms-graph)

[Update user](/graph/api/user-update)

```http
PATCH https://graph.microsoft.com/v1.0/users/{id}
{
    "customSecurityAttributes":
    {
        "Engineering":
        {
            "@odata.type":"#Microsoft.DirectoryServices.CustomSecurityAttributeValue",
            "NumVendors@odata.type":"#Int32",
            "NumVendors":8
        }
    }
}
```

---

#### Update a custom security attribute assignment with a Boolean value for a user

The following example updates a custom security attribute assignment with a Boolean value for a user.

- Attribute set: `Engineering`
- Attribute: `Certification`
- Attribute data type: Boolean
- Attribute value: `false`

# [PowerShell](#tab/ms-powershell)

[Update-MgUser](/powershell/module/microsoft.graph.users/update-mguser)

```powershell
$customSecurityAttributes = @{
    "Engineering" = @{
        "@odata.type" = "#Microsoft.DirectoryServices.CustomSecurityAttributeValue"
        "Certification" = $false
    }
}
Update-MgUser -UserId $userId -CustomSecurityAttributes $customSecurityAttributes
```

# [Microsoft Graph](#tab/ms-graph)

[Update user](/graph/api/user-update)

```http
PATCH https://graph.microsoft.com/v1.0/users/{id}
{
    "customSecurityAttributes":
    {
        "Engineering":
        {
            "@odata.type":"#Microsoft.DirectoryServices.CustomSecurityAttributeValue",
            "Certification":false
        }
    }
}
```

---

#### Update a custom security attribute assignment with a multi-string value for a user

The following example updates a custom security attribute assignment with a multi-string value for a user.

- Attribute set: `Engineering`
- Attribute: `Project`
- Attribute data type: Collection of Strings
- Attribute value: `("Alpine","Baker")`

# [PowerShell](#tab/ms-powershell)

[Update-MgUser](/powershell/module/microsoft.graph.users/update-mguser)

```powershell
$customSecurityAttributes = @{
    "Engineering" = @{
        "@odata.type" = "#Microsoft.DirectoryServices.CustomSecurityAttributeValue"
        "Project@odata.type" = "#Collection(String)"
        "Project" = @("Alpine","Baker")
    }
}
Update-MgUser -UserId $userId -CustomSecurityAttributes $customSecurityAttributes
```

# [Microsoft Graph](#tab/ms-graph)

[Update user](/graph/api/user-update)

```http
PATCH https://graph.microsoft.com/v1.0/users/{id}
{
    "customSecurityAttributes":
    {
        "Engineering":
        {
            "@odata.type":"#Microsoft.DirectoryServices.CustomSecurityAttributeValue",
            "Project@odata.type":"#Collection(String)",
            "Project":["Alpine","Baker"]
        }
    }
}
```

---

#### Get the custom security attribute assignments for a user

The following example gets the custom security attribute assignments for a user.

# [PowerShell](#tab/ms-powershell)

[Get-MgUser](/powershell/module/microsoft.graph.users/get-mguser)

```powershell
$userAttributes = Get-MgUser -UserId $userId -Property "customSecurityAttributes"
$userAttributes.CustomSecurityAttributes.AdditionalProperties | Format-List
$userAttributes.CustomSecurityAttributes.AdditionalProperties.Engineering
$userAttributes.CustomSecurityAttributes.AdditionalProperties.Marketing
```

```Output
Key   : Engineering
Value : {[@odata.type, #microsoft.graph.customSecurityAttributeValue], [Project@odata.type, #Collection(String)], [Project, System.Object[]],
        [ProjectDate, 2024-11-15]…}

Key   : Marketing
Value : {[@odata.type, #microsoft.graph.customSecurityAttributeValue], [EmployeeId, GS45897]}


Key                   Value
---                   -----
@odata.type           #microsoft.graph.customSecurityAttributeValue
Project@odata.type    #Collection(String)
Project               {Baker, Alpine}
ProjectDate           2024-11-15
NumVendors            8
CostCenter@odata.type #Collection(Int32)
CostCenter            {1001, 1003}
Certification         False


Key         Value
---         -----
@odata.type #microsoft.graph.customSecurityAttributeValue
EmployeeId  KX45897
```

If there are no custom security attributes assigned to the user or if the calling principal does not have access, the response will be empty.


# [Microsoft Graph](#tab/ms-graph)

[Get user](/graph/api/user-get)

```http
GET https://graph.microsoft.com/v1.0/users/{id}?$select=customSecurityAttributes
```

```http
{
    "@odata.context": "https://graph.microsoft.com/v1.0/$metadata#users(customSecurityAttributes)/$entity",
    "customSecurityAttributes": {
        "Engineering": {
            "@odata.type": "#microsoft.graph.customSecurityAttributeValue",
            "Project@odata.type": "#Collection(String)",
            "Project": [
                "Baker",
                "Alpine"
            ],
            "ProjectDate": "2024-11-15",
            "NumVendors": 8,
            "CostCenter@odata.type": "#Collection(Int32)",
            "CostCenter": [
                1001,
                1003
            ],
            "Certification": false
        },
        "Marketing": {
            "@odata.type": "#microsoft.graph.customSecurityAttributeValue",
            "EmployeeId": "GS45897"
        }
    }
}
```

If there are no custom security attributes assigned to the user or if the calling principal does not have access, the response will look like:

```http
{
    "customSecurityAttributes": null
}
```

---

#### List all users with a custom security attribute assignment that equals a value

The following example lists all users with a custom security attribute assignment that equals a value. It retrieves users with a custom security attribute named `AppCountry` with a value that equals `Canada`. The filter value is case sensitive. You must add `ConsistencyLevel=eventual` in the request or the header. You must also include `$count=true` to ensure the request is routed correctly.

- Attribute set: `Marketing`
- Attribute: `AppCountry`
- Filter: AppCountry eq 'Canada'

# [PowerShell](#tab/ms-powershell)

[Get-MgUser](/powershell/module/microsoft.graph.users/get-mguser)

```powershell
$userAttributes = Get-MgUser -CountVariable CountVar -Property "id,displayName,customSecurityAttributes" -Filter "customSecurityAttributes/Marketing/AppCountry eq 'Canada'" -ConsistencyLevel eventual
$userAttributes | select Id,DisplayName,CustomSecurityAttributes
$userAttributes.CustomSecurityAttributes.AdditionalProperties | Format-List
```

```Output
Id                                   DisplayName CustomSecurityAttributes
--                                   ----------- ------------------------
00aa00aa-bb11-cc22-dd33-44ee44ee44ee Jiya        Microsoft.Graph.PowerShell.Models.MicrosoftGraphCustomSecurityAttributeValue
11bb11bb-cc22-dd33-ee44-55ff55ff55ff Jana        Microsoft.Graph.PowerShell.Models.MicrosoftGraphCustomSecurityAttributeValue

Key   : Engineering
Value : {[@odata.type, #microsoft.graph.customSecurityAttributeValue], [Datacenter@odata.type, #Collection(String)], [Datacenter, System.Object[]]}

Key   : Marketing
Value : {[@odata.type, #microsoft.graph.customSecurityAttributeValue], [AppCountry@odata.type, #Collection(String)], [AppCountry, System.Object[]],
        [EmployeeId, KX19476]}

Key   : Marketing
Value : {[@odata.type, #microsoft.graph.customSecurityAttributeValue], [AppCountry@odata.type, #Collection(String)], [AppCountry, System.Object[]],
        [EmployeeId, GS46982]}
```

# [Microsoft Graph](#tab/ms-graph)

[List users](/graph/api/user-list)

```http
GET https://graph.microsoft.com/v1.0/users?$count=true&$select=id,displayName,customSecurityAttributes&$filter=customSecurityAttributes/Marketing/AppCountry eq 'Canada'
ConsistencyLevel: eventual
```

```http
{
    "@odata.context": "https://graph.microsoft.com/v1.0/$metadata#users(id,displayName,customSecurityAttributes)",
    "@odata.count": 2,
    "value": [
        {
            "id": "00aa00aa-bb11-cc22-dd33-44ee44ee44ee",
            "displayName": "Jiya",
            "customSecurityAttributes": {
                "Engineering": {
                    "@odata.type": "#microsoft.graph.customSecurityAttributeValue",
                    "Datacenter@odata.type": "#Collection(String)",
                    "Datacenter": [
                        "India"
                    ]
                },
                "Marketing": {
                    "@odata.type": "#microsoft.graph.customSecurityAttributeValue",
                    "AppCountry@odata.type": "#Collection(String)",
                    "AppCountry": [
                        "India",
                        "Canada"
                    ],
                    "EmployeeId": "KX19476"
                }
            }
        },
        {
            "id": "11bb11bb-cc22-dd33-ee44-55ff55ff55ff",
            "displayName": "Jana",
            "customSecurityAttributes": {
                "Marketing": {
                    "@odata.type": "#microsoft.graph.customSecurityAttributeValue",
                    "AppCountry@odata.type": "#Collection(String)",
                    "AppCountry": [
                        "Canada",
                        "Mexico"
                    ],
                    "EmployeeId": "GS46982"
                }
            }
        }
    ]
}
```

---

#### List all users with a custom security attribute assignment that starts with a value

The following example lists all users with a custom security attribute assignment that starts with a value. It retrieves users with a custom security attribute named `EmployeeId` with a value that starts with `GS`. The filter value is case sensitive. You must add `ConsistencyLevel=eventual` in the request or the header. You must also include `$count=true` to ensure the request is routed correctly.

- Attribute set: `Marketing`
- Attribute: `EmployeeId`
- Filter: EmployeeId startsWith 'GS'

# [PowerShell](#tab/ms-powershell)

[Get-MgUser](/powershell/module/microsoft.graph.users/get-mguser)

```powershell
$userAttributes = Get-MgUser -CountVariable CountVar -Property "id,displayName,customSecurityAttributes" -Filter "startsWith(customSecurityAttributes/Marketing/EmployeeId,'GS')" -ConsistencyLevel eventual
$userAttributes | select Id,DisplayName,CustomSecurityAttributes
$userAttributes.CustomSecurityAttributes.AdditionalProperties | Format-List
```

```Output
Id                                   DisplayName CustomSecurityAttributes
--                                   ----------- ------------------------
22cc22cc-dd33-ee44-ff55-66aa66aa66aa Chandra     Microsoft.Graph.PowerShell.Models.MicrosoftGraphCustomSecurityAttributeValue
11bb11bb-cc22-dd33-ee44-55ff55ff55ff Jana        Microsoft.Graph.PowerShell.Models.MicrosoftGraphCustomSecurityAttributeValue
33dd33dd-ee44-ff55-aa66-77bb77bb77bb Joe         Microsoft.Graph.PowerShell.Models.MicrosoftGraphCustomSecurityAttributeValue

Key   : Marketing
Value : {[@odata.type, #microsoft.graph.customSecurityAttributeValue], [EmployeeId, GS36348]}

Key   : Marketing
Value : {[@odata.type, #microsoft.graph.customSecurityAttributeValue], [AppCountry@odata.type, #Collection(String)], [AppCountry, System.Object[]],
        [EmployeeId, GS46982]}

Key   : Engineering
Value : {[@odata.type, #microsoft.graph.customSecurityAttributeValue], [Project@odata.type, #Collection(String)], [Project, System.Object[]],
        [ProjectDate, 2024-11-15]…}

Key   : Marketing
Value : {[@odata.type, #microsoft.graph.customSecurityAttributeValue], [EmployeeId, GS45897]}
```

# [Microsoft Graph](#tab/ms-graph)

[List users](/graph/api/user-list)

```http
GET https://graph.microsoft.com/v1.0/users?$count=true&$select=id,displayName,customSecurityAttributes&$filter=startsWith(customSecurityAttributes/Marketing/EmployeeId,'GS')
ConsistencyLevel: eventual
```

```http
{
    "@odata.context": "https://graph.microsoft.com/v1.0/$metadata#users(id,displayName,customSecurityAttributes)",
    "@odata.count": 3,
    "value": [
        {
            "id": "22cc22cc-dd33-ee44-ff55-66aa66aa66aa",
            "displayName": "Chandra",
            "customSecurityAttributes": {
                "Marketing": {
                    "@odata.type": "#microsoft.graph.customSecurityAttributeValue",
                    "EmployeeId": "GS36348"
                }
            }
        },
        {
            "id": "11bb11bb-cc22-dd33-ee44-55ff55ff55ff",
            "displayName": "Jana",
            "customSecurityAttributes": {
                "Marketing": {
                    "@odata.type": "#microsoft.graph.customSecurityAttributeValue",
                    "AppCountry@odata.type": "#Collection(String)",
                    "AppCountry": [
                        "Canada",
                        "Mexico"
                    ],
                    "EmployeeId": "GS46982"
                }
            }
        },
        {
            "id": "33dd33dd-ee44-ff55-aa66-77bb77bb77bb",
            "displayName": "Joe",
            "customSecurityAttributes": {
                "Engineering": {
                    "@odata.type": "#microsoft.graph.customSecurityAttributeValue",
                    "Project@odata.type": "#Collection(String)",
                    "Project": [
                        "Baker",
                        "Alpine"
                    ],
                    "ProjectDate": "2024-11-15",
                    "NumVendors": 8,
                    "CostCenter@odata.type": "#Collection(Int32)",
                    "CostCenter": [
                        1001,
                        1003
                    ],
                    "Certification": false
                },
                "Marketing": {
                    "@odata.type": "#microsoft.graph.customSecurityAttributeValue",
                    "EmployeeId": "GS45897"
                }
            }
        }
    ]
}
```

---

#### List all users with a custom security attribute assignment that does not equal a value

The following example lists all users with a custom security attribute assignment that does not equal a value. It retrieves users with a custom security attribute named `AppCountry` with a value that does not equal `Canada`. The filter value is case sensitive. You must add `ConsistencyLevel=eventual` in the request or the header. You must also include `$count=true` to ensure the request is routed correctly.

- Attribute set: `Marketing`
- Attribute: `AppCountry`
- Filter: AppCountry ne 'Canada'

# [PowerShell](#tab/ms-powershell)

[Get-MgUser](/powershell/module/microsoft.graph.users/get-mguser)

```powershell
$userAttributes = Get-MgUser -CountVariable CountVar -Property "id,displayName,customSecurityAttributes" -Filter "customSecurityAttributes/Marketing/AppCountry ne 'Canada'" -ConsistencyLevel eventual
$userAttributes | select Id,DisplayName,CustomSecurityAttributes
```

```Output
Id                                   DisplayName              CustomSecurityAttributes
--                                   -----------              ------------------------
22cc22cc-dd33-ee44-ff55-66aa66aa66aa Chandra                  Microsoft.Graph.PowerShell.Models.MicrosoftGraphCustomSecurityAttributeValue
44ee44ee-ff55-aa66-bb77-88cc88cc88cc Isabella                 Microsoft.Graph.PowerShell.Models.MicrosoftGraphCustomSecurityAttributeValue
00aa00aa-bb11-cc22-dd33-44ee44ee44ee Alain                    Microsoft.Graph.PowerShell.Models.MicrosoftGraphCustomSecurityAttributeValue
33dd33dd-ee44-ff55-aa66-77bb77bb77bb Joe                      Microsoft.Graph.PowerShell.Models.MicrosoftGraphCustomSecurityAttributeValue
00aa00aa-bb11-cc22-dd33-44ee44ee44ee Dara                     Microsoft.Graph.PowerShell.Models.MicrosoftGraphCustomSecurityAttributeValue
```

# [Microsoft Graph](#tab/ms-graph)

[List users](/graph/api/user-list)

```http
GET https://graph.microsoft.com/v1.0/users?$count=true&$select=id,displayName,customSecurityAttributes&$filter=customSecurityAttributes/Marketing/AppCountry ne 'Canada'
ConsistencyLevel: eventual
```

```http
{
    "@odata.context": "https://graph.microsoft.com/v1.0/$metadata#users(id,displayName,customSecurityAttributes)",
    "@odata.count": 47,
    "value": [
        {
            "id": "22cc22cc-dd33-ee44-ff55-66aa66aa66aa",
            "displayName": "Chandra",
            "customSecurityAttributes": {
                "Marketing": {
                    "@odata.type": "#microsoft.graph.customSecurityAttributeValue",
                    "EmployeeId": "GS36348"
                }
            }
        },
        {
            "id": "44ee44ee-ff55-aa66-bb77-88cc88cc88cc",
            "displayName": "Isabella",
            "customSecurityAttributes": {
                "Marketing": {
                    "@odata.type": "#microsoft.graph.customSecurityAttributeValue",
                    "AppCountry@odata.type": "#Collection(String)",
                    "AppCountry": [
                        "France"
                    ]
                }
            }
        },
        {
            "id": "00aa00aa-bb11-cc22-dd33-44ee44ee44ee",
            "displayName": "Alain",
            "customSecurityAttributes": {
                "Marketing": {
                    "@odata.type": "#microsoft.graph.customSecurityAttributeValue",
                    "AppCountry@odata.type": "#Collection(String)",
                    "AppCountry": [
                        "Germany",
                        "Japan"
                    ]
                }
            }
        },
        {
            "id": "33dd33dd-ee44-ff55-aa66-77bb77bb77bb",
            "displayName": "Joe",
            "customSecurityAttributes": {
                "Engineering": {
                    "@odata.type": "#microsoft.graph.customSecurityAttributeValue",
                    "Project@odata.type": "#Collection(String)",
                    "Project": [
                        "Baker",
                        "Alpine"
                    ],
                    "ProjectDate": "2024-11-15",
                    "NumVendors": 8,
                    "CostCenter@odata.type": "#Collection(Int32)",
                    "CostCenter": [
                        1001,
                        1003
                    ],
                    "Certification": false
                },
                "Marketing": {
                    "@odata.type": "#microsoft.graph.customSecurityAttributeValue",
                    "EmployeeId": "GS45897"
                }
            }
        },
        {
            "id": "00aa00aa-bb11-cc22-dd33-44ee44ee44ee",
            "displayName": "Dara",
            "customSecurityAttributes": null
        }
    ]
}
```

---

#### Remove a single-valued custom security attribute assignment from a user

The following example removes a single-valued custom security attribute assignment from a user by setting the value to null.

- Attribute set: `Engineering`
- Attribute: `ProjectDate`
- Attribute value: `null`

# [PowerShell](#tab/ms-powershell)

[Invoke-MgGraphRequest](/powershell/microsoftgraph/authentication-commands#using-invoke-mggraphrequest)

```powershell
$params = @{
    "customSecurityAttributes" = @{
        "Engineering" = @{
            "@odata.type" = "#Microsoft.DirectoryServices.CustomSecurityAttributeValue"
            "ProjectDate" = $null
        }
    }
}
Invoke-MgGraphRequest -Method PATCH -Uri "https://graph.microsoft.com/v1.0/users/$userId" -Body $params
```

# [Microsoft Graph](#tab/ms-graph)

[Update user](/graph/api/user-update)

```http
PATCH https://graph.microsoft.com/v1.0/users/{id}
{
    "customSecurityAttributes":
    {
        "Engineering":
        {
            "@odata.type":"#Microsoft.DirectoryServices.CustomSecurityAttributeValue",
            "ProjectDate":null
        }
    }
}
```

---

#### Remove a multi-valued custom security attribute assignment from a user

The following example removes a multi-valued custom security attribute assignment from a user by setting the value to an empty collection.

- Attribute set: `Engineering`
- Attribute: `Project`
- Attribute value: `[]`

# [PowerShell](#tab/ms-powershell)

[Update-MgUser](/powershell/module/microsoft.graph.users/update-mguser)

```powershell
$customSecurityAttributes = @{
    "Engineering" = @{
        "@odata.type" = "#Microsoft.DirectoryServices.CustomSecurityAttributeValue"
        "Project" = @()
    }
}
Update-MgUser -UserId $userId -CustomSecurityAttributes $customSecurityAttributes
```

# [Microsoft Graph](#tab/ms-graph)

[Update user](/graph/api/user-update)

```http
PATCH https://graph.microsoft.com/v1.0/users/{id}
{
    "customSecurityAttributes":
    {
        "Engineering":
        {
            "@odata.type":"#Microsoft.DirectoryServices.CustomSecurityAttributeValue",
            "Project":[]
        }
    }
}
```

---

## Frequently asked questions

**Where are custom security attribute assignments for users supported?**

Custom security attribute assignments for users are supported in Microsoft Entra admin center, PowerShell, and Microsoft Graph APIs. Custom security attribute assignments are not supported in My Apps or Microsoft 365 admin center.

**Who can view the custom security attributes assigned to a user?**

Only users that have been assigned the Attribute Assignment Administrator or Attribute Assignment Reader roles at tenant scope can view custom security attributes assigned to any users in the tenant. Users cannot view the custom security attributes assigned to their own profile or other users. Guests cannot view the custom security attributes regardless of the guest permissions set on the tenant.

**Do I need to create an app to add custom security attribute assignments?**

No, custom security attributes can be assigned to user objects without requiring an application.

**Why do I keep getting an error trying to save custom security attribute assignments?**

You don't have permissions to assign custom security attributes to users. Make sure that you are assigned the Attribute Assignment Administrator role.

**Can I assign custom security attributes to guests?**

Yes, custom security attributes can be assigned to members or guests in your tenant.

**Can I assign custom security attributes to directory synced users?**

Yes, directory synced users from an on-premises Active Directory can be assigned custom security attributes.

**Are custom security attribute assignments available for rules for dynamic membership groups?**

No, custom security attributes assigned to users are not supported for configuring rules for dynamic membership groups.

**Are custom security attributes the same as the custom attributes in B2C tenants?**

No, custom security attributes are not supported in B2C tenants and are not related to B2C features.

## Next steps

- [Add or deactivate custom security attribute definitions in Microsoft Entra ID](~/fundamentals/custom-security-attributes-add.md)
- [Assign, update, list, or remove custom security attributes for an application](~/identity/enterprise-apps/custom-security-attributes-apps.md)
- [Examples: Assign, update, list, or remove custom security attribute assignments using the Microsoft Graph API](/graph/custom-security-attributes-examples)
- [Troubleshoot custom security attributes in Microsoft Entra ID](~/fundamentals/custom-security-attributes-troubleshoot.md)
