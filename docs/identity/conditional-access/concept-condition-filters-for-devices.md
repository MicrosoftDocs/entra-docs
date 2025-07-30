---
title: Filter for devices as a condition in Conditional Access policy
description: Use filter for devices in Conditional Access to enhance security posture.

ms.service: entra-id
ms.subservice: conditional-access

ms.topic: conceptual
ms.date: 05/19/2025

ms.author: joflore
author: MicrosoftGuyJFlo
manager: dougeby
ms.reviewer: sandeo
---
# Conditional Access: Filter for devices

When administrators create Conditional Access policies, the ability to target or exclude specific devices in their environment is a common task. The condition filter for devices gives administrators the ability to target specific devices. Administrators can use [supported operators and properties for device filters](#supported-operators-and-device-properties-for-filters) along side the other available assignment conditions in your Conditional Access policies.

:::image type="content" source="media/concept-condition-filters-for-devices/create-filter-for-devices-condition.png" alt-text="Creating a filter for device in Conditional Access policy conditions":::

## Common scenarios

There are multiple scenarios that organizations can now enable using filter for devices condition. The following scenarios provide examples of how to use this new condition.

- **Restrict access to privileged resources**. For this example, lets say you want to allow access to Windows Azure Service Management API from a user who:
   - Is assigned a [privileged role](../role-based-access-control/permissions-reference.md).
   - Completed multifactor authentication.
   - Is on a device that is [privileged or secure admin workstations](/security/compass/privileged-access-devices) and attested as compliant.
   - For this scenario, organizations would create two Conditional Access policies:
      - Policy 1: All users with an administrator role, accessing the Windows Azure Service Management API cloud app, and for Access controls, Grant access, but require multifactor authentication and require device to be marked as compliant.
      - Policy 2: All users with an administrator, accessing the Windows Azure Service Management API cloud app, excluding a filter for devices using rule expression device.extensionAttribute1 equals SAW and for Access controls, Block. Learn how to [update extensionAttributes on a Microsoft Entra device object](/graph/api/device-update?view=graph-rest-1.0&tabs=http&preserve-view=true).
- **Block access to organization resources from devices running an unsupported Operating System**. For this example, lets say you want to block access to resources from Windows OS version older than Windows 10. For this scenario, organizations would create the following Conditional Access policy:
   - All users accessing all resources, excluding those with devices where the rule expression `device.operatingSystem == 'Windows'` and `device.operatingSystemVersion startsWith '10.0'` applies, should be blocked by Access controls.
- **Do not require multifactor authentication for specific accounts on specific devices**. For this example, lets say you want to not require multifactor authentication when using service accounts on specific devices like Teams Phones or Surface Hub devices. For this scenario, organizations would create the following two Conditional Access policies:
   - Policy 1: All users excluding service accounts, accessing all resources, and for Access controls, Grant access, but require multifactor authentication.
   - Policy 2: Select users and groups and include group that contains service accounts only, accessing all resources, excluding a filter for devices using rule expression device.extensionAttribute2 not equals TeamsPhoneDevice and for Access controls, Block.

> [!NOTE] 
> Microsoft Entra ID uses device authentication to evaluate device filter rules. For a device that is unregistered with Microsoft Entra ID, all device properties are considered as null values and the device attributes cannot be determined since the device does not exist in the directory. The best way to target policies for unregistered devices is by using the negative operator since the configured filter rule would apply. If you were to use a positive operator, the filter rule would only apply when a device exists in the directory and the configured rule matches the attribute on the device. 

## Create a Conditional Access policy

Filter for devices is an optional control when creating a Conditional Access policy.

The following steps help create two Conditional Access policies to support the first scenario under [Common scenarios](#common-scenarios). 

Policy 1: All users with an administrator role, accessing the Windows Azure Service Management API cloud app, and for Access controls, Grant access, but require multifactor authentication and require device to be marked as compliant.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Conditional Access Administrator](../role-based-access-control/permissions-reference.md#conditional-access-administrator).
1. Browse to **Entra ID** > **Conditional Access** > **Policies**.
1. Select **New policy**.
1. Give your policy a name. We recommend that organizations create a meaningful standard for the names of their policies.
1. Under **Assignments**, select **Users or workload identities**.
   1. Under **Include**, select **Directory roles**, then all roles with administrator in the name.
   
      > [!WARNING]
      > Conditional Access policies support built-in roles. Conditional Access policies are not enforced for other role types including [administrative unit-scoped](../role-based-access-control/manage-roles-portal.md or [custom roles](../role-based-access-control/custom-create.md).

   1. Under **Exclude**, select **Users and groups** and choose your organization's emergency access or break-glass accounts. 
   1. Select **Done**.
1. Under **Target resources** > **Resources (formerly cloud apps)** > **Include** > **Select resources**, choose **Windows Azure Service Management API**, and select **Select**.
1. Under **Access controls** > **Grant**, select **Grant access**, **Require multifactor authentication**, and **Require device to be marked as compliant**, then select **Select**.
1. Confirm your settings and set **Enable policy** to **On**.
1. Select **Create** to create to enable your policy.

Policy 2: All users with an administrator role, accessing the Windows Azure Service Management API cloud app, excluding a filter for devices using rule expression device.extensionAttribute1 equals SAW and for Access controls, Block.

1. Select **New policy**.
1. Give your policy a name. We recommend that organizations create a meaningful standard for the names of their policies.
1. Under **Assignments**, select **Users or workload identities**.
   1. Under **Include**, select **Directory roles**, then all roles with administrator in the name
   
      > [!WARNING]
      > Conditional Access policies support built-in roles. Conditional Access policies are not enforced for other role types including [administrative unit-scoped](../role-based-access-control/manage-roles-portal.md) or [custom roles](../role-based-access-control/custom-create.md).

   1. Under **Exclude**, select **Users and groups** and choose your organization's emergency access or break-glass accounts. 
   1. Select **Done**.
1. Under **Target resources** > **Resources (formerly cloud apps)** > **Include** > **Select resources**, choose **Windows Azure Service Management API**, and select **Select**.
1. Under **Conditions**, **Filter for devices**.
   1. Toggle **Configure** to **Yes**.
   1. Set **Devices matching the rule** to **Exclude filtered devices from policy**.
   1. Set the property to `ExtensionAttribute1`, the operator to `Equals` and the value to `SAW`.
   1. Select **Done**.
1. Under **Access controls** > **Grant**, select **Block access**, then select **Select**.
1. Confirm your settings and set **Enable policy** to **On**.
1. Select **Create** to create to enable your policy.

> [!WARNING]
> Policies that require compliant devices may prompt users on Mac, iOS, and Android to select a device certificate during policy evaluation, even though device compliance is not enforced. These prompts may repeat until the device is made compliant.

### Setting attribute values

Setting extension attributes is made possible through the Microsoft Graph API. For more information about setting device attributes, see the article [Update device](/graph/api/device-update?tabs=http#example-2--write-extensionattributes-on-a-device).

### Filter for devices Graph API

The filter for devices API is available in Microsoft Graph v1.0 endpoint and can be accessed using the endpoint `https://graph.microsoft.com/v1.0/identity/conditionalaccess/policies/`. You can configure a filter for devices when creating a new Conditional Access policy or you can update an existing policy to configure the filter for devices condition. To update an existing policy, you can do a patch call on the Microsoft Graph v1.0 endpoint by appending the policy ID of an existing policy and executing the following request body. The example here shows configuring a filter for devices condition excluding devices that aren't marked as SAW devices. The rule syntax can consist of more than one single expression. To learn more about the syntax, see [rules for dynamic membership groups for groups in Microsoft Entra ID](~/identity/users/groups-dynamic-membership.md). 

```json
{
    "conditions": {
        "devices": {
            "deviceFilter": {
                "mode": "exclude",
                "rule": "device.extensionAttribute1 -ne \"SAW\""
            }
        }
    }
}
```

## Supported operators and device properties for filters

The following device attributes can be used with the filter for devices condition in Conditional Access.

> [!IMPORTANT]
> Microsoft recommends using atleast one system defined or admin configurable device property when using Filter for devices condition in Conditional Access.

> [!NOTE] 
> Microsoft Entra ID uses device authentication to evaluate device filter rules. For a device that is unregistered with Microsoft Entra ID, all device properties are considered as null values and the device attributes cannot be determined since the device does not exist in the directory. The best way to target policies for unregistered devices is by using the negative operator since the configured filter rule would apply. If you were to use a positive operator, the filter rule would only apply when a device exists in the directory and the configured rule matches the attribute on the device. 

| Supported device attributes | System defined or admin configured | Supported operators | Supported values | Example |
| --- | --- | --- | --- | --- |
| deviceId | Yes | Equals, NotEquals, In, NotIn | A valid deviceId that is a GUID | (device.deviceid -eq "aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb") |
| displayName | No | Equals, NotEquals, StartsWith, NotStartsWith, EndsWith, NotEndsWith, Contains, NotContains, In, NotIn | Any string | (device.displayName -contains "ABC") |
| deviceOwnership | Yes | Equals, NotEquals | Supported values are "Personal" for bring your own devices and "Company" for corporate owned devices  | (device.deviceOwnership -eq "Company") |
| enrollmentProfileName | Yes | Equals, NotEquals, StartsWith, NotStartsWith, EndsWith, NotEndsWith, Contains, NotContains, In, NotIn | This is set by Microsoft Intune based on the profile the device was enrolled under at the time of enrollment. It's a string value created by Microsoft Intune admin, and matches the Windows Autopilot, Apple Automated Device Enrollment (ADE), or Google enrollment profile applied to the device. | (device.enrollmentProfileName -startsWith "AutoPilot Profile") |
| isCompliant | Yes | Equals, NotEquals | Supported values are "True" for compliant devices and "False" for non compliant devices  | (device.isCompliant -eq "True") |
| manufacturer | No | Equals, NotEquals, StartsWith, NotStartsWith, EndsWith, NotEndsWith, Contains, NotContains, In, NotIn | Any string | (device.manufacturer -startsWith "Microsoft") |
| mdmAppId | Yes | Equals, NotEquals, In, NotIn | A valid MDM application ID | (device.mdmAppId -in ["00001111-aaaa-2222-bbbb-3333cccc4444"]) |
| model | No | Equals, NotEquals, StartsWith, NotStartsWith, EndsWith, NotEndsWith, Contains, NotContains, In, NotIn | Any string | (device.model -notContains "Surface") |
| operatingSystem | Yes  | Equals, NotEquals, StartsWith, NotStartsWith, EndsWith, NotEndsWith, Contains, NotContains, In, NotIn | A valid operating system (like Windows, iOS, or Android) | (device.operatingSystem -eq "Windows") |
| operatingSystemVersion | Yes | Equals, NotEquals, StartsWith, NotStartsWith, EndsWith, NotEndsWith, Contains, NotContains, In, NotIn | A valid operating system version (like 6.1 for Windows 7, 6.2 for Windows 8, or 10.0 for Windows 10 and Windows 11) | (device.operatingSystemVersion -in ["10.0.18363", "10.0.19041", "10.0.19042", "10.0.22000"]) |
| physicalIds | Yes | Contains, NotContains | As an example all Windows Autopilot devices store ZTDId (a unique value assigned to all imported Windows Autopilot devices) in device physicalIds property. | (device.physicalIds -contains "[ZTDId]:value") |
| profileType | Yes | Equals, NotEquals | A valid profile type set for a device. Supported values are: RegisteredDevice (default), SecureVM (used for Windows VMs in Azure enabled with Microsoft Entra sign-in), Printer (used for printers), Shared (used for shared devices), IoT (used for IoT devices) | (device.profileType -eq "Printer") |
| systemLabels | Yes | Contains, NotContains | List of labels applied to the device by the system. Some of the supported values are: AzureResource (used for Windows VMs in Azure enabled with Microsoft Entra sign-in), M365Managed (used for devices managed using Microsoft Managed Desktop), MultiUser (used for shared devices) | (device.systemLabels -contains "M365Managed") |
| trustType | Yes | Equals, NotEquals | A valid registered state for devices. Supported values are: AzureAD (used for Microsoft Entra joined devices), ServerAD (used for Microsoft Entra hybrid joined devices), Workplace (used for Microsoft Entra registered devices) | (device.trustType -eq "ServerAD") |
| extensionAttribute1-15 | Yes | Equals, NotEquals, StartsWith, NotStartsWith, EndsWith, NotEndsWith, Contains, NotContains, In, NotIn | extensionAttributes1-15 are attributes that customers can use for device objects. Customers can update any of the extensionAttributes1 through 15 with custom values and use them in the filter for devices condition in Conditional Access. Any string value can be used. | (device.extensionAttribute1 -eq "SAW") |

> [!WARNING] 
> Devices must be Microsoft Intune managed, compliant, or Microsoft Entra hybrid joined for a value to be available in extensionAttributes1-15 at the time of the Conditional Access policy evaluation.

> [!NOTE] 
> When building complex rules or using too many individual identifiers like deviceid for device identities, keep in mind "The maximum length for the filter rule is 3072 characters".

> [!NOTE] 
> The `Contains` and the `NotContains` operators work differently depending on attribute types. For string attributes such as `operatingSystem` and `model`, the `Contains` operator indicates whether a specified substring occurs within the attribute. For string collection attributes such as `physicalIds` and `systemLabels`, the `Contains` operator indicates whether a specified string matches one of the whole strings in the collection.

## Policy behavior with filter for devices

The filter for devices condition in Conditional Access evaluates policy based on device attributes of a registered device in Microsoft Entra ID and hence it's important to understand under what circumstances the policy is applied or not applied. The following table illustrates the behavior when a filter for devices condition is configured. 

| Filter for devices condition | Device registration state | Device filter Applied |
| --- | --- | --- |
| Include/exclude mode with positive operators (Equals, StartsWith, EndsWith, Contains, In) and use of any attributes | Unregistered device | No |
| Include/exclude mode with positive operators (Equals, StartsWith, EndsWith, Contains, In) and use of attributes excluding extensionAttributes1-15 | Registered device | Yes, if criteria are met |
| Include/exclude mode with positive operators (Equals, StartsWith, EndsWith, Contains, In) and use of attributes including extensionAttributes1-15 | Registered device managed by Intune | Yes, if criteria are met |
| Include/exclude mode with positive operators (Equals, StartsWith, EndsWith, Contains, In) and use of attributes including extensionAttributes1-15 | Registered device not managed by Intune | Yes, if criteria are met. When extensionAttributes1-15 are used, the policy applies if device is compliant or Microsoft Entra hybrid joined |
| Include/exclude mode with negative operators (NotEquals, NotStartsWith, NotEndsWith, NotContains, NotIn) and use of any attributes | Unregistered device | Yes |
| Include/exclude mode with negative operators (NotEquals, NotStartsWith, NotEndsWith, NotContains, NotIn) and use of any attributes excluding extensionAttributes1-15 | Registered device | Yes, if criteria are met |
| Include/exclude mode with negative operators (NotEquals, NotStartsWith, NotEndsWith, NotContains, NotIn) and use of any attributes including extensionAttributes1-15 | Registered device managed by Intune | Yes, if criteria are met |
| Include/exclude mode with negative operators (NotEquals, NotStartsWith, NotEndsWith, NotContains, NotIn) and use of any attributes including extensionAttributes1-15 | Registered device not managed by Intune | Yes, if criteria are met. When extensionAttributes1-15 are used, the policy applies if device is compliant or Microsoft Entra hybrid joined |

## Related content

- [Back to school – Using Boolean algebra correctly in complex filters](https://techcommunity.microsoft.com/t5/intune-customer-success/back-to-school-using-boolean-algebra-correctly-in-complex/ba-p/3422765)
- [Update device Graph API](/graph/api/device-update?tabs=http)
- [Conditional Access: Conditions](concept-conditional-access-conditions.md)
- [Common Conditional Access policies](concept-conditional-access-policy-common.md)
