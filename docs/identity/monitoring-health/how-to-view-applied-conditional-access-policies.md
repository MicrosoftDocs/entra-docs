---
title: Conditional Access and Microsoft Entra sign-in logs
description: Learn how to view Conditional Access policies in Microsoft Entra sign-in logs so that you can assess the effect of those policies.
author: shlipsey3
manager: amycolannino
ms.service: entra-id
ms.topic: how-to
ms.subservice: monitoring-health
ms.date: 04/15/2024
ms.author: sarahlipsey
ms.reviewer: egreenberg

# Customer intent: As an IT admin, I want to view applied Conditional Access policies in Microsoft Entra sign-in logs so that I can assess the effect of those policies.

---

# View applied Conditional Access policies in Microsoft Entra sign-in logs

With Conditional Access policies, you can control how your users get access to the resources of your Azure tenant. As a tenant admin, you need to be able to determine what effect your Conditional Access policies have on sign-ins to your tenant, so that you can take action if necessary.

The sign-in logs in Microsoft Entra ID give you the information that you need to assess the effect of your policies. This article explains how to view applied Conditional Access policies in those logs.

## Prerequisites

To see applied Conditional Access policies in the sign-in logs, administrators must have permissions to view *both* the logs and the policies. The least privileged built-in role that grants *both* permissions is *Security Reader*. As a best practice, you should add the Security Reader role to the related administrator accounts.

The following built-in roles grant permissions to *read Conditional Access policies*:

- Security Reader
- Global Reader
- Security Administrator
- Conditional Access Administrator

The following built-in roles grant permission to *view sign-in logs*:

- Reports Reader
- Security Reader
- Global Reader
- Security Administrator

### Permissions for client apps

If you use a client app to pull sign-in logs from Microsoft Graph, your app needs permissions to receive the `appliedConditionalAccessPolicy` resource from Microsoft Graph. As a best practice, assign `Policy.Read.ConditionalAccess` because it's the least privileged permission.

Any of the following permissions is sufficient for a client app to access applied Conditional Access policies in sign-in logs through Microsoft Graph:

- `Policy.Read.ConditionalAccess`
- `Policy.ReadWrite.ConditionalAccess`
- `Policy.Read.All`

### Permissions for PowerShell

Like any other client app, the Microsoft Graph PowerShell module needs client permissions to access applied Conditional Access policies in the sign-in logs. To successfully pull applied Conditional Access policies in the sign-in logs, you must consent to the necessary permissions with your administrator account for Microsoft Graph PowerShell. As a best practice, consent to:

- `Policy.Read.ConditionalAccess`
- `AuditLog.Read.All`
- `Directory.Read.All`

The following permissions are the least privileged permissions with the necessary access:

- To consent to the necessary permissions: `Connect-MgGraph -Scopes Policy.Read.ConditionalAccess, AuditLog.Read.All, Directory.Read.All`
- To view the sign-in logs: `Get-MgAuditLogSignIn`

For more information about this cmdlet, see [Get-MgAuditLogSignIn](/powershell/module/microsoft.graph.reports/get-mgauditlogsignin).

## Conditional Access and sign-in log scenarios

As a Microsoft Entra administrator, you can use the sign-in logs to:

- Troubleshoot sign-in problems.
- Check on feature performance.
- Evaluate the security of a tenant.

Some scenarios require you to get an understanding of how your Conditional Access policies were applied to a sign-in event. Common examples include:

- Helpdesk administrators who need to look at applied Conditional Access policies to understand if a policy is the root cause of a ticket that a user opened.

- Tenant administrators who need to verify that Conditional Access policies have the intended effect on the users of a tenant.

You can access the sign-in logs by using the Microsoft Entra admin center, the Azure portal, Microsoft Graph, and PowerShell.  

## View Conditional Access policies in Microsoft Entra sign-in logs
<a name='view-conditional-access-policies-in-azure-ad-sign-in-logs'></a>

[!INCLUDE [portal update](../../includes/portal-update.md)]

The activity details of sign-in logs contain several tabs. The **Conditional Access** tab lists the Conditional Access policies applied to that sign-in event.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Global Reader](../role-based-access-control/permissions-reference.md#global-reader).
1. Browse to **Identity** > **Monitoring & health** > **Sign-in logs**.
1. Select a sign-in item from the table to view the sign-in details pane.  
1. Select the **Conditional Access** tab.

If you don't see the Conditional Access policies, confirm you're using a role that provides access to both the sign-in logs and the Conditional Access policies.

## Next steps

- [Troubleshoot Conditional Access related sign-in problems](../conditional-access/troubleshoot-conditional-access.md#microsoft-entra-sign-in-events)
- [Review the Conditional Access sign-in logs FAQs](reports-faq.yml#conditional-access)
- [Learn about the sign-in logs](concept-sign-ins.md)
