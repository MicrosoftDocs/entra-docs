---
title: Conditional Access and Microsoft Entra activity logs
description: Learn how to view Conditional Access details in Microsoft Entra activity logs so that you can assess the effect of your policies.
author: shlipsey3
manager: pmwongera
ms.service: entra-id
ms.topic: how-to
ms.subservice: monitoring-health
ms.date: 11/19/2024
ms.author: sarahlipsey
ms.reviewer: egreenberg

# Customer intent: As an IT admin, I want to view applied Conditional Access details in the Microsoft Entra sign-in logs so that I can assess the effect of any policies in place.

---

# View applied Conditional Access details in the Microsoft Entra activity logs

With Conditional Access policies, you can control how your users get access to your Azure and Microsoft Entra resources. As a tenant admin, you need to be able to determine what effect your Conditional Access policies have on sign-ins to your tenant, so that you can take action if necessary. You might also need to view audit logs for recent changes to Conditional Access policies.

This article explains how to view applied Conditional Access policies in the Microsoft Entra activity logs.

## Prerequisites

To see applied Conditional Access policies in the logs, administrators must have permissions to view *both* the logs and the policies. The least privileged built-in role that grants *both* permissions is *Security Reader*. As a best practice, you should add the Security Reader role to the related administrator accounts.

The following built-in roles grant permissions to *read Conditional Access policies*:

- Security Reader
- Security Administrator
- Conditional Access Administrator

The following built-in roles grant permission to *view activity logs*:

- Reports Reader
- Security Reader
- Security Administrator

### Permissions

If you use a client app or the Microsoft Graph PowerShell module to pull logs from Microsoft Graph, your app needs permissions to receive the `appliedConditionalAccessPolicy` resource from Microsoft Graph. As a best practice, assign `Policy.Read.ConditionalAccess` because it's the least privileged permission.

The following permissions allow a client app to access the activity logs and any applied Conditional Access policies in the logs through Microsoft Graph:

- `Policy.Read.ConditionalAccess`
- `Policy.ReadWrite.ConditionalAccess`
- `Policy.Read.All`
- `AuditLog.Read.All`
- `Directory.Read.All`

To use the Microsoft Graph PowerShell module, you also need the following least privileged permissions with the necessary access:

- To consent to the necessary permissions: `Connect-MgGraph -Scopes Policy.Read.ConditionalAccess, AuditLog.Read.All, Directory.Read.All`
- To view the sign-in logs: `Get-MgAuditLogSignIn`
- To view the audit logs: `Get-MgAuditLogDirectoryAudit`

For more information, see [Get-MgAuditLogSignIn](/powershell/module/microsoft.graph.reports/get-mgauditlogsignin) and [Get-MgAuditLogDirectoryAudit](/powershell/module/microsoft.graph.reports/get-mgauditlogdirectoryaudit).

## Conditional Access and sign-in log scenarios

As a Microsoft Entra administrator, you can use the sign-in logs to:

- Troubleshoot sign-in problems.
- Check on feature performance.
- Evaluate the security of a tenant.

Some scenarios require you to get an understanding of how your Conditional Access policies were applied to a sign-in event. Common examples include:

- Helpdesk administrators who need to look at applied Conditional Access policies to understand if a policy is the root cause of a ticket that a user opened.
- Tenant administrators who need to verify that Conditional Access policies have the intended effect on the users of a tenant.

You can access the sign-in logs by using the Microsoft Entra admin center, the Azure portal, Microsoft Graph, and PowerShell.  

## How to view Conditional Access policies
<a name='view-conditional-access-policies-in-azure-ad-sign-in-logs'></a>

### [Microsoft Entra admin center](#tab/microsoft-entra-admin-center)


The activity details of sign-in logs contain several tabs. The **Conditional Access** tab lists the Conditional Access policies applied to that sign-in event.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Reports Reader](../role-based-access-control/permissions-reference.md#reports-reader).
1. Browse to **Entra ID** > **Monitoring & health** > **Sign-in logs**.
1. Select a sign-in item from the table to view the sign-in details pane.  
1. Select the **Conditional Access** tab.

If you don't see the Conditional Access policies, confirm you're using a role that provides access to both the sign-in logs and the Conditional Access policies.

### [Microsoft Graph API](#tab/microsoft-graph-api)

Follow these instructions to view Conditional Access policies and log details using the Microsoft Graph API in [Graph Explorer](https://aka.ms/ge).

1. Sign in to the [Graph Explorer](https://aka.ms/ge).
1. Select **GET** as the HTTP method from the dropdown. 
1. Select the API version to **v1.0**.
1. To get sign-in attempts where Conditional Access failed during a specific time frame, add the following query and select **Run query**.

   ```http
   GET https://graph.microsoft.com/v1.0/auditLogs/signIns?$filter=(createdDateTime ge 2024-11-01T14:13:32Z and createdDateTime le 2024-11-10T17:43:26Z) and conditionalAccessStatus eq 'failure'
   ```

1. To view a specific Conditional Access policy, add the policy ID.

   ```http
   GET https://graph.microsoft.com/v1.0/identity/conditionalAccess/policies/{id}
   ```

For more information, review the following resources:

- [conditionalAccessPolicy resource type](/graph/api/resources/conditionalaccesspolicy)
- [signIn resource type](/graph/api/resources/signin)

### [Microsoft Graph PowerShell](#tab/microsoft-graph-powershell)

Follow these steps to list Microsoft Entra roles using PowerShell.

1. Open a PowerShell window. If necessary, use [Install-Module](/powershell/module/powershellget/install-module) to install Microsoft Graph PowerShell. For more information, see [Prerequisites to use PowerShell or Graph Explorer](../role-based-access-control/prerequisites.md).

    ```powershell
    Install-Module Microsoft.Graph -Scope CurrentUser
    ```

2. In a PowerShell window, use [Connect-MgGraph](/powershell/microsoftgraph/authentication-commands#using-connect-mggraph) to sign in to your tenant.

    ```powershell
    Connect-MgGraph -Scopes "Policy.Read.All", "Policy.Read.ConditionalAccess"
    ```

3. Use [Get-MgIdentityConditionalAccessPolicy](/powershell/module/microsoft.graph.identity.signins/get-mgidentityconditionalaccesspolicy) to get all Conditional Access policies.

    ```powershell
    Get-MgIdentityConditionalAccessPolicy
    ```

4. To format the results as a list, use the following command:

    ```powershell
    Get-MgIdentityConditionalAccessPolicy |Format-List
    ```

The following command can be used to export sign-in logs to a CSV file, formatted to highlight Conditional Access related details.

1. Define the output CSV file path.

    ```powershell
    $PathCsv = "C:\\temp\\ConditionalAccessSignInLogs.csv"
    ```
1. Retrieve the logs, filtered from a specified date, and export them to the CSV file.

    ```powershell
    $SignInLogs = Get-MgAuditLogSignIn -Filter "createdDateTime gt 2024-11-10T05:30:00.0Z" | Select-Object `
    @{Name="ResourceName";Expression={$_.ResourceDisplayName}}, `
    @{Name="User";Expression={$_.UserDisplayName}}, `
    @{Name="IPv4";Expression={$_.IPAddress}}, `
    @{Name="Location";Expression={$_.Location.City}}, `
    @{Name="NamedLocation";Expression={$_.ConditionalAccessLocations}}, `
    @{Name="Success/Failure/ReportOnly";Expression={$_.ConditionalAccessStatus}}, `
    @{Name="FailureReason";Expression={$_.FailureReason}}, `
    @{Name="Details";Expression={$_.ConditionalAccessDetails}}, `
    @{Name="DeviceName";Expression={$_.DeviceDetail.DeviceDisplayName}}, `
    @{Name="ClientApp";Expression={$_.ClientAppUsed}} | 
    Export-Csv -Path $PathCsv -NoTypeInformation

    Write-Host "Conditional Access SignInLogs exported to $PathCsv"
    ```

---

## Conditional Access and audit log scenarios

The Microsoft Entra audit logs contain information about changes to Conditional Access policies. You can use the audit logs to find out when a policy was created, updated, or deleted.

To see when an existing Conditional Access policy was updated:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Reports Reader](../role-based-access-control/permissions-reference.md#reports-reader).
1. Browse to **Entra ID** > **Monitoring & health** > **Audit logs**.
1. Set **Service** filter to **Conditional Access**.
1. Set the **Category** filter to **Policy**.
1. Set the **Activity** filter to **Update Conditional Access policy**.

You might need to adjust the date to see the changes you're looking for. The **Target** column shows the name of the Conditional Access policy that was updated.

To compare the current policy with the previous policy, select the audit log entry and then select the **Modified properties** tab.

## Related content

- [Troubleshoot Conditional Access related sign-in problems](../conditional-access/troubleshoot-conditional-access.md#microsoft-entra-sign-in-events)
- [Review the Conditional Access sign-in logs FAQs](reports-faq.yml#conditional-access)
- [Learn about the sign-in logs](concept-sign-ins.md)
