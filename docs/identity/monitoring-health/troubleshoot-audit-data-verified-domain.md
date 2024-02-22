---

title: Troubleshoot bulk changes to the verified domains of users in the audit logs
description: Troubleshoot changes to UserPrincipalName verified domain in the Microsoft Entra ID audit logs.

author: shlipsey3
manager: amycolannino
ms.service: entra-id
ms.topic: troubleshooting
ms.subservice: monitoring-health
ms.date: 02/21/2024
ms.author: sarahlipsey

---

# How to troubleshoot bulk changes to UserPrincipalName verified domain

This article describes a common scenario where the audit logs display `UserPrincipalName` updates where the domain changed for multiple users. This article explains the causes and considerations for these changes and provides a deep dive into the backend operation that triggers mass object changes in Microsoft Entra ID.

## Symptoms

The Microsoft Entra audit logs show multiple user updates occurred in my Microsoft Entra tenant. The **Actor** information for these events is empty or shows N/A.

The bulk updates involve changing the domain for the `UserPrincipalName` changed from the organization's preferred domain to the default `*.onmicrosoft.com` domain suffix.

### Sample audit log entry

**Activity Date (UTC)**: 2022-01-27 07:44:05

**Activity**: Update user

**Actor Type**: Other

**Actor UPN**: N/A

**Status**: success

**Category**: UserManagement

**Service**: Core Directory

**Target Id**: aaaaaaaaa-bbbb-0000-11111-bbbbbbbbbbbbb

**Target Name**: user@contoso.com

**Target Type**: User

**Details**:

`{ "id": "Directory_0000000-1111111", "category": "UserManagement", "correlationId": "aaaaaa-111111-0000-bbbbbbb", "result": "success", "resultReason": "", "activityDisplayName": "Update user", "activityDateTime": "2022-01-27T07:44:05.7673032Z", "loggedByService": "Core Directory", "operationType": "Update", "userAgent": null, "initiatedBy": { "user": null, "app": null }, "targetResources": [ { "id": "aaaaaaaaa-bbbb-0000-11111-bbbbbbbbbbbbb", "displayName": null, "type": "User", "userPrincipalName": "user@contoso.com", "groupType": null, "modifiedProperties": [ { "displayName": "UserPrincipalName", "oldValue": "[\"user@contoso.onmicrosoft.com\"]", "newValue": "[\"user@contoso.com\"]" }, { "displayName": "Included Updated Properties", "oldValue": null, "newValue": "\"UserPrincipalName\"" }, { "displayName": "Action Client Name", "oldValue": null, "newValue": "\"DirectorySync\"" }, { "displayName": "TargetId.UserType", "oldValue": null, "newValue": "\"Member\"" } ] } ], "additionalDetails": [ { "key": "UserType", "value": "Member" } ] }`

## Causes

One common reason behind mass object changes is due to a non-synchronous backend operation. This operation determines the appropriate `UserPrincipalName` and `proxyAddresses` that are updated in Microsoft Entra users, groups, or contacts.

The purpose of this backend operation ensures that `UserPrincipalName` and `proxyAddresses` are consistent in Microsoft Entra ID at any time. The operation must be triggered by an explicit change, such as a verified domain change.   

For example, if you add a verified domain Fabrikam.com to your Contoso.onmicrosoft.com tenant, this action triggers the backend operation on *all* objects in the tenant. This event is captured in the Microsoft Entra audit logs as **Update User** events preceded by an **Add verified domain** event.

If Fabrikam.com was removed from the Contoso.onmicrosoft.com tenant, then all the **Update User** events will be preceded by a **Remove verified domain** event.   

## Resolution

If you encountered this issue, you might benefit from using Microsoft Entra Connect to sync data between your on-premises directory and Microsoft Entra ID. This action ensures that the `UserPrincipalName` and `proxyAddresses` are consistent in both environments.

When you try to manually add or maintain these objects, you run the risk of another backend operation triggering a bulk change.

Review the following articles to become familiar with these concepts:

- [Microsoft Entra UserPrincipalName population](../../identity/hybrid/connect/plan-connect-userprincipalname.md)

- [How the proxyAddresses attribute is populated in Microsoft Entra ID](/troubleshoot/azure/active-directory/proxyaddresses-attribute-populate)

## Considerations

This backend operation doesn't cause changes to certain objects that: 

- don't have an active Microsoft Exchange license
- have `MSExchRemoteRecipientType` set to Null 
- aren't considered a shared resource.
    - Shared Resource is when `CloudMSExchRecipientDisplayType` contains one of the following values:
        - `MailboxUser` (shared)
        - `PublicFolder`
        - `ConferenceRoomMailbox`
        - `EquipmentMailbox`
        - `ArbitrationMailbox`
        - `RoomList`
        - `TeamMailboxUser`
        - `GroupMailbox`
        - `SchedulingMailbox`
        - `ACLableMailboxUser`
        - `ACLableTeamMailboxUser`
  
To build more correlation between these two disparate events, Microsoft is working on updating the **Actor** info in the audit logs to identify these changes as triggered by a verified domain change. This action will help check when the verified domain change event took place and started to mass update the objects in their tenant. 

In most cases, there are no changes to users as their `UserPrincipalName` and `proxyAddresses` are consistent, so we're working to only display in the audit Logs those updates that caused an actual change to the object. This action will prevent noise in the audit logs and help admins correlate the remaining user changes to verified domain change event as explained above. 

## Deep dive

Want to learn more about what's happening behind the scenes? Here's a deep dive into the backend operation that triggers mass object changes in Microsoft Entra ID. Before you dive in, check out the [Microsoft Entra Connect Sync service shadow attributes](../../identity/hybrid/connect/how-to-connect-syncservice-shadow-attributes.md) article to understand the shadow attributes.

### UserPrincipalName

For cloud-only users, the `UserPrincipalName` is set to a verified domain suffix. When an inconsistent `UserPrincipalName` is processed, the operation converts it to the default onmicrosoft.com suffix, for example: `username@Contoso.onmicrosoft.com`.

For synchronized users, the `UserPrincipalName` is set to a verified domain suffix and matches the on-premises value, `ShadowUserPrincipalName`. When an inconsistent `UserPrincipalName` is processed, the operation reverts to the same value as the `ShadowUserPrincipalName` or, in the case that domain suffix has been removed from the tenant, converts it to the default `*.onmicrosoft.com` domain suffix. 

### ProxyAddresses  

For cloud-only users, consistency means that the `proxyAddresses` match a verified domain suffix. When an inconsistent `proxyAddresses` is processed, ProxyCalc converts it to the default `*.onmicrosoft.com` domain suffix, for example: `SMTP:username@Contoso.onmicrosoft.com`.

For synchronized users, consistency means that the `proxyAddresses` match the on-premises `proxyAddresses` value (i.e ShadowProxyAddresses). `proxyAddresses` are expected to be in sync with **ShadowProxyAddresses**. If the synchronized user has an Exchange license assigned, then the Proxy Addresses must match the on-premises Proxy Address(es) value(s) and must also match a verified domain suffix. In this scenario, **ProxyCalc** will sanitize the inconsistent Proxy Address with an unverified domain suffix and will be removed from the object in Microsoft Entra ID. If that unverified domain is verified later, **ProxyCalc** will recompute and add the Proxy Address from **ShadowProxyAddresses** back to the object in Microsoft Entra ID.  

> [!NOTE]
> For synchronized objects, to avoid the backend operation logic from calculating unexpected results, it's best to set `proxyAddresses` to a Microsoft Entra verified domain on the on-premises object.  

## Next Steps

[Microsoft Entra Connect Sync service shadow attributes](~/identity/hybrid/connect/how-to-connect-syncservice-shadow-attributes.md)
