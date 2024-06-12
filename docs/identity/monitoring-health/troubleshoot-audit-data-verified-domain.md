---
title: Bulk changes to usernames during verified domain changes
description: Learn how Microsoft Entra audit logs display UserManagement updates from Core Directory during verified domain changes.

author: shlipsey3
manager: amycolannino
ms.service: entra-id
ms.topic: troubleshooting
ms.subservice: monitoring-health
ms.date: 03/04/2024
ms.author: sarahlipsey

---

# Understanding bulk user updates during verified domain changes

This article describes a common scenario where the audit logs display many `UserPrincipalName` updates triggered by a verified domain change. This article explains the causes and considerations for UserManagement updates in the audit logs that occur during verified domain changes. The article provides a deep dive into the backend operation that triggers mass object changes in Microsoft Entra ID.

## Symptoms

The Microsoft Entra audit logs show multiple user updates occurred in my Microsoft Entra tenant. The **Actor** information for these events is empty or shows N/A.

The bulk updates involve changing the domain for the `UserPrincipalName` changed from the organization's preferred domain to the default `*.onmicrosoft.com` domain suffix.

### Sample audit log details

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

Within the full details of the audit log entry, look for the `modifiedProperties` section. This section shows the changes made to the user object. The `oldValue` and `newValue` fields show the domain change.

```json
"modifiedProperties":
  "displayName": "UserPrincipalName",
  "oldValue": "[\"user@contoso.onmicrosoft.com\"]",
  "newValue": "[\"user@contoso.com\"]"

```

## Causes

One common reason behind mass object changes is due to a nonsynchronous backend operation. This operation determines the appropriate `UserPrincipalName` and `proxyAddresses` that are updated in Microsoft Entra users, groups, or contacts.

The purpose of this backend operation ensures that UserPrincipalName and proxyAddresses are consistent in Microsoft Entra ID at any time. An explicit change, such as a verified domain change, triggers this operation.

For example, if you add a verified domain Fabrikam.com to your Contoso.onmicrosoft.com tenant, this action triggers the backend operation on *all* objects in the tenant. This event is captured in the Microsoft Entra audit logs as **Update User** events preceded by an **Add verified domain** event.

If Fabrikam.com was removed from the Contoso.onmicrosoft.com tenant, then all the **Update User** events are preceded by a **Remove verified domain** event.   

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
- aren't considered a shared resource

A shared resource is when `CloudMSExchRecipientDisplayType` contains one of the following values:

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
  
To build more correlation between these two disparate events, Microsoft is working on updating the **Actor** info in the audit logs to identify these changes as triggered by a verified domain change. This action helps check when the verified domain change event took place and started to mass update the objects in the tenant. 

In most cases, there are no changes to users as their `UserPrincipalName` and `proxyAddresses` are consistent, so we're working to only display in the audit logs those updates that caused an actual change to the object. This action prevents noise in the audit logs and help admins correlate the remaining user changes to verified domain change events. 

## Deep dive

Want to learn more about what's happening behind the scenes? Here's a deep dive into the backend operation that triggers mass object changes in Microsoft Entra ID. Before you dive in, check out the [Microsoft Entra Connect Sync service shadow attributes](../../identity/hybrid/connect/how-to-connect-syncservice-shadow-attributes.md) article to understand the shadow attributes.

### UserPrincipalName

For cloud-only users, the UserPrincipalName is set to a verified domain suffix. When an inconsistent UserPrincipalName is processed, the operation converts it to the default onmicrosoft.com suffix, for example: `username@Contoso.onmicrosoft.com`.

For synchronized users, the UserPrincipalName is set to a verified domain suffix and matches the on-premises value, `ShadowUserPrincipalName`. When an inconsistent UserPrincipalName is processed, the operation reverts to the same value as the ShadowUserPrincipalName or, in the case that domain suffix was removed from the tenant, converts it to the default `*.onmicrosoft.com` domain suffix. 

### ProxyAddresses  

For cloud-only users, consistency means that the `proxyAddresses` match a verified domain suffix. When an inconsistent proxyAddresses is processed, the backend operation converts it to the default `*.onmicrosoft.com` domain suffix, for example: `SMTP:username@Contoso.onmicrosoft.com`.

For synchronized users, consistency means that the proxyAddresses match the on-premises proxyAddresses value (that is, ShadowProxyAddresses). The proxyAddresses are expected to be in sync with ShadowProxyAddresses. If the synchronized user has an Exchange license assigned, then the cloud and on-premises values must match. These values must also match a verified domain suffix.

In this scenario, the backend operation sanitizes the inconsistent proxyAddresses with an unverified domain suffix and is removed from the object in Microsoft Entra ID. If that unverified domain is verified later, the backend operation recomputes and adds the proxyAddresses from ShadowProxyAddresses back to the object in Microsoft Entra ID.  

> [!NOTE]
> For synchronized objects, to avoid the backend operation logic from calculating unexpected results, it's best to set proxyAddresses to a Microsoft Entra verified domain on the on-premises object.  

## Next Steps

[Microsoft Entra Connect Sync service shadow attributes](../hybrid/connect/how-to-connect-syncservice-shadow-attributes.md)
