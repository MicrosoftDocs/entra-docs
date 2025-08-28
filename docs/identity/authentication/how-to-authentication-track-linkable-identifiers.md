---
title: Track and investigate identity activities with linkable identifiers in Microsoft Entra
description: Discover how linkable identifiers like session IDs and unique token identifiers in Microsoft Entra help track and investigate identity-related activities, enhancing security and transparency.
ms.topic: how-to
ms.date: 05/27/2025
ms.author: justinha
author: vimrang
manager: dougeby
ms.reviewer: vranganathan
---

# Track and investigate identity activities with linkable identifiers in Microsoft Entra 

Microsoft embeds specific identifiers in all access tokens that enable the correlation of activities back to a single root authentication event. These linkable identifiers are surfaced in customer-facing logs to support threat hunters and security analysts in investigating and mitigating identity-based attacks. By using these identifiers, security professionals can more effectively trace, analyze, and respond to malicious activity across sessions and tokens, enhancing both the transparency and security of the environment.

## Types of linkable identifiers

There are two types of linkable identifiers used to support advanced identity investigation and threat hunting scenarios: session ID-based identifiers and unique token identifiers.

### Session ID-based identifiers
An identifier based on session ID (SID-based identifier) enables correlation of all authentication artifacts such as [access token (AT)](/entra/identity-platform/access-tokens), [refresh token (RT)](/entra/identity-platform/refresh-tokens), and session cookies issued from a single root authentication event. This identifier is especially useful for tracking activity across a session.

Common SID-based investigation scenarios include:

- **Correlate activity across services**: Start with a session ID from Microsoft Entra sign-in logs. Join it with workload logs, such as the Exchange Online audit logs or Microsoft Graph activity logs. Then you can identify all actions performed by access tokens that share the same session ID.
- **Filter by user or device**: Narrow results by using UserId or DeviceId, or filter tokens issued within a specific session timeframe.
- **Enumerate sessions**: Determine how many active sessions exist for a specific user (UserId) or device (DeviceId).
- **Link across authentication artifacts**: The SID claim is generated during interactive authentication and included in the primary refresh token (PRT), refresh token, or session cookie. All access tokens issued from these sources inherit the same SID, enabling consistent linkage across authentication artifacts.

### Unique token identifiers 
The unique token identifier (UTI) is a globally unique identifier (GUID) embedded in every Microsoft Entra [access token (AT)](/entra/identity-platform/access-tokens) or [ID token](/entra/identity-platform/id-tokens). It uniquely identifies each token or request, providing fine-grained traceability.

A common UTI-based investigation scenario is **token-level activity tracing**. Start with a UTI from Microsoft Entra sign-in logs and correlate it with workload logs, such as the Exchange Online audit logs or Microsoft Graph activity logs, to trace all actions performed by a specific access token.

The UTI is unique for every access token and session, which makes it ideal for pinpointing suspicious or compromised tokens during investigations.

## Linkable identifier claims

This table describes all the linkable identifier claims in the Entra tokens.

| **Claim** | **Format**            | **Description**                                                                                                                                                                                              |
|-----------|-----------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| oid       | String, a GUID        | The immutable identifier for the requestor, which is the verified identity of the user or service principal. This ID uniquely identifies the requestor across applications.                                  |
| tid       | String, a GUID        | Represents the tenant that the user is signing in to.                                                                                                                                                        |
| sid       | String, a GUID        | Represents a unique identifier for an entire session and is generated when a user does interactive authentication. This ID helps link all authentication artifacts issued from a single root authentication. |
| deviceid  | String, a GUID        | Represents a unique identifier for the device from which a user is interacting with an application.                                                                                                          |
| uti       | String                | Represents the token identifier claim This ID is a unique, per-token identifier that is case-sensitive.                                                                                                                      |
| iat       | int, a Unix timestamp | Specifies when the authentication for this token occurred.                                                                                                                                                   |

## Log availability for linkable identifiers

Currently, linkable identifiers are recorded in the following log sources:

- Microsoft Entra sign-in logs
- Microsoft Exchange Online audit logs
- Microsoft Graph activity logs
- Microsoft SharePoint Online audit logs
- Microsoft Teams audit logs

These logs enable security analysts to correlate authentication events and token usage across services, supporting comprehensive investigations into identity-related threats.

## Linkable identifiers in Microsoft Entra sign in logs

All sign-in logs entries will have the linkable identifier claims and this table shows the mapping between linkable identifier claim with Entra sign-in log attribute.

| **Claim** | **Entra Sign in log attribute name** |
|-----------|--------------------------------|
| oid       | User ID                        |
| tid       | Resource Tenant ID             |
| sid       | Session ID                     |
| deviceid  | Device ID                      |
| uti       | Unique Token Identifier        |
| iat       | Date                           |

To view the sign-in logs from the Microsoft Entra admin center:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com/) as at least a [Reports Reader](/entra/identity/role-based-access-control/permissions-reference#reports-reader).
2. Browse to **Microsoft Entra ID** > **Monitoring & health** > **Sign-in logs**.
3. Filter by time, or by specific user to look at the specific log entries.
4. Click any sign-in log entry.
5. **Basic Info** shows the User ID, Resource Tenant ID, Session ID, Unique Token Identifier, and Date. **Devices** shows the Device ID for registered and domain-joined devices.

:::image type="content" border="true" source="media/how-to-authentication-track-linkable-identifiers/sign-in-logs-entry.png" alt-text="Screenshot of sign-in log entry in Microsoft Entra admin center.":::

:::image type="content" border="true" source="media/how-to-authentication-track-linkable-identifiers/log-entry-linkable-identifiers.png" alt-text="Screenshot of sign-in log entry with linkable identifiers.":::

You should start with Microsoft Entra sign-in logs User ID attribute and manually search on the workload audit logs to track all the activities using a specific access token. Similarly, the Session ID attribute can be used to manually search on the workload audit logs to track all the activities.

## Linkable identifiers in Microsoft Exchange Online logs

Exchange Online audit logs provide visibility into critical user activity and support in-depth investigations by capturing detailed audit events. These logs include linkable identifiers carried forward from Microsoft Entra tokens, enabling correlation across authentication artifacts and workloads.

### Supported investigation scenarios

For scenarios such as mailbox updates, item moves, or deletions, you can:

- Start with linkable identifiers from Microsoft Entra sign-in logs, such as session ID (SID) or unique token identifier (UTI).
- Use these identifiers to search Microsoft Purview Audit (Standard) or Audit (Premium) logs.
- Track all user actions performed on mailbox items during a specific session or by a specific token.

This approach enables security analysts to trace activity across services and identify potential misuse or compromise.

For detailed guidance about searching Exchange Online audit logs, see [Search the audit log](/purview/audit-search).

This table shows the mapping between linkable identifier claims and Exchange Online audit log attribute.

| **Claim** | **Exchange Online audit log attribute name**                              |
|-----------|---------------------------------------------------------------|
| oid       | TokenObjectId                                                 |
| tid       | TokenTenantId                                                 |
| sid       | SessionID / AADSessionId within App Access Context object     |
| deviceid  | DeviceId (Available only for registered/domain joined device) |
| uti       | UniqueTokenId within App Access Context object                |
| iat       | IssuedAtTime within App Access Context object                 |

### View Exchange Online logs using Microsoft Purview portal

1. Go to [Microsoft Purview portal](https://purview.microsoft.com/).
2. Search for logs with a specific timeframe and record types starting with Exchange.

   :::image type="content" border="true" source="media/how-to-authentication-track-linkable-identifiers/purview-search.png" alt-text="Screenshot of Microsoft Purview portal showing search for logs with Exchange workload.":::

3. You can further filter for a specific user, or a UTI value from Microsoft Entra sign-in logs. You can filter all the activity logs within a session with `SessionId`.
4. The results show all the linkable identifiers.

   :::image type="content" border="true" source="media/how-to-authentication-track-linkable-identifiers/purview-search-linkable-identifiers.png" alt-text="Screenshot of Microsoft Purview portal showing log item with linkable identifiers.":::

   :::image type="content" border="true" source="media/how-to-authentication-track-linkable-identifiers/purview-search-linkable-identifiers-details.png" alt-text="Screenshot of Microsoft Purview portal showing detailed log item.":::

5. Export the audit log and investigate for a specific `SessionId` or `UniqueTokenId` for all the activities for Exchange Online.

### View Exchange Online logs using PowerShell commandlets

1. Run PowerShell as an administrator.
2. If the ExchangeOnlineManagement module isn't installed, run:

   ```powershell
   Install-Module -Name ExchangeOnlineManagement
   ```

3. Connect to Exchange Online:

   ```powershell
   Connect-ExchangeOnline -UserPrincipalName <user@4jkvzv.onmicrosoft.com>
   ```

4. Run some mailbox commands:

   ```powershell
   Set-Mailbox user@4jkvzv.onmicrosoft.com -MaxSendSize 97MB
   ```

   ```powershell
   Set-Mailbox user@4jkvzv.onmicrosoft.com -MaxSendSize 98MB
   ```

   ```powershell
   Set-Mailbox user@4jkvzv.onmicrosoft.com -MaxSendSize 99MB
   ```

5. Search the unified audit log:

   ```powershell
   Search-UnifiedAuditLog -StartDate 01/06/2025 -EndDate 01/08/2025 -RecordType ExchangeItem, ExchangeAdmin, ExchangeAggregatedOperation, ExchangeItemAggregated, ExchangeItemGroup, ExchangeSearch
   ```

6. The results have all of the linkable identifiers.

> [!NOTE]
> The linkable identifiers aren't available in the Exchange Online audit logs on some aggregated log entries, or logs generated from background processes.

For more information, see [Exchange Online PowerShell](/powershell/exchange/exchange-online-powershell).

## Linkable identifiers in Microsoft Graph activity logs

Microsoft Graph activity logs provide an audit trail of all HTTP requests received and processed by the Microsoft Graph service for a tenant. These logs are stored in a Log Analytics workspace, enabling advanced analysis and investigation.

If you configure Microsoft Graph activity logs to be sent to a Log Analytics workspace, you can query them using [Kusto Query Language](/azure/data-explorer/kusto/query/). This allows you to perform detailed investigations into user and application behavior across Microsoft 365 services.

### Investigation scenarios using linkable identifiers

For scenarios involving Microsoft Graph activity, you can:

- Start with linkable identifiers from Microsoft Entra sign-in logs, such as SID or UTI.
- Use these identifiers to correlate and trace user actions across Microsoft Graph activity logs.
- Track all operations performed on mailbox items or other resources by a specific token or session see [Microsoft Graph Activity Logs](/graph/microsoft-graph-activity-logs-overview).

This table shows the mapping between linkable identifier claims and Microsoft Graph activity log attribute.

| **Claim** | **Attribute name in the Microsoft Graph Activity log**                |
|-----------|--------------------------------------------------------------------|
| oid       | UserId                                                             |
| tid       | TenantId                                                           |
| sid       | SessionId                                                          |
| deviceid  | DeviceId (available only for registered and domain-joined devices) |
| uti       | SignInActivityId                                                   |
| iat       | TokenIssuedAt                                                      |

### Join sign-in logs and Microsoft Graph activity logs using KQL

You can use Kusto Query Language (KQL) to join Microsoft Entra sign-in logs and Microsoft Graph Activity logs for advanced investigation scenarios. 

**Filtering by linkable identifiers**

- Filter by uti :
Use the uti attribute to analyze all activities associated with a specific access token. This is useful for tracing the behavior of a single token across services.
- Filter by sid (Session ID):
Use the sid claim to analyze all activities performed by access tokens issued from a refresh token that originated from a root interactive authentication. This allows you to trace the full session lifecycle.
- Additional filtering:
You can further refine your queries using attributes such as UserId, DeviceId, and time-based filters to narrow the scope of your investigation.

These capabilities enable security analysts to correlate authentication events with workload activity, improving visibility and response to identity-related threats.

```kql
MicrosoftGraphActivityLogs
| where TimeGenerated > ago(4d) and UserId == '4624cd8c-6c94-4593-b0d8-a4983d797ccb'
| join kind=leftouter (union
SigninLogs,
AADNonInteractiveUserSignInLogs,
AADServicePrincipalSignInLogs,
AADManagedIdentitySignInLogs,
ADFSSignInLogs
| where TimeGenerated > ago(4d))
on $left.SignInActivityId == $right.UniqueTokenIdentifier
```

:::image type="content" border="true" source="media/how-to-authentication-track-linkable-identifiers/kusto-query.png" alt-text="Screenshot of KQL query results showing joined logs.":::

For more information about queries in Log Analytics Workspace, see [Analyze Microsoft Entra activity logs with Log Analytics](/azure/active-directory/reports-monitoring/howto-analyze-activity-logs-log-analytics).

## Example Scenario: Tracing User Activity Across Microsoft 365 Services Exchange Online and MSGraph

This example shows how to trace the actions of a user across Microsoft 365 services by using linkable identifiers and audit logs.

**Scenario Overview**

A user performs the following sequence of actions:

1. Signs in to Office.com
The user initiates an interactive authentication, generating a root token. This token includes linkable identifiers such as the Session ID (SID) and Unique Token Identifier (UTI), which are propagated to subsequent tokens.

2. Accesses Microsoft Graph
The user interacts with Microsoft Graph APIs to retrieve or modify organizational data. Each request is logged in the Microsoft Graph activity logs, with the associated SID and UTI enabling correlation back to the original sign-in event.

3. Uses Exchange Online (Outlook)
The user opens Outlook via Exchange Online and performs mailbox operations such as reading, moving, or deleting emails. These actions are captured in Exchange Online audit logs, which also include the same linkable identifiers.

By using the SID, analysts can trace all activities across services that originated from the same session. Alternatively, the UTI can be used to pinpoint actions tied to a specific access token.

1. Find the interactive login log line in the sign in logs, and capture the `SessionId`:

   :::image type="content" border="true" source="media/how-to-authentication-track-linkable-identifiers/sign-in-log-session-id.png" alt-text="Screenshot of interactive sign-in log line with session ID.":::

1. Add a filter by `SessionId`. You can get the `SessionId` for interactive or noninteractive sign-ins.

   **Interactive sign-ins:**

   :::image type="content" border="true" source="media/how-to-authentication-track-linkable-identifiers/interactive-sign-in.png" alt-text="Screenshot of interactive sign-ins filtered by session ID.":::

   **Noninteractive sign-ins:**

   :::image type="content" border="true" source="media/how-to-authentication-track-linkable-identifiers/noninteractive-sign-in.png" alt-text="Screenshot of non-interactive sign-ins filtered by session ID.":::

1. To get all the activities on Microsoft Graph workload done by the user within this specific session, go to Log Analytics in Microsoft Entra admin center and run the query to join Microsoft Entra sign in logs and Microsoft Graph Activity logs. The following query filters by `UserId` and `SessionId`.

   :::image type="content" border="true" source="media/how-to-authentication-track-linkable-identifiers/graph-filter.png" alt-text="Screenshot of Microsoft Graph activities filtered by user ID and session ID.":::

   Further filtering can be done on a `SignInActivityId` (uti claim) attribute to learn more about the access by specific request.

1. To get Exchange Online activities, open the Microsoft Purview portal and search by Users or Record Types.

   :::image type="content" border="true" source="media/how-to-authentication-track-linkable-identifiers/purview-record-types.png" alt-text="Screenshot of Microsoft Purview portal showing search by Users or Record Types.":::

1. Export the data.

   :::image type="content" border="true" source="media/how-to-authentication-track-linkable-identifiers/export-data.png" alt-text="Screenshot of data export in Microsoft Purview portal.":::

1. The log entry has all of the linkable identifiers. You can search by `UniqueTokenId` for each unique activity, and search by `AADSessionId` for all activities within the session.

   :::image type="content" border="true" source="media/how-to-authentication-track-linkable-identifiers/search-token-id.png" alt-text="Screenshot of log line with linkable identifiers.":::

## Linkable identifiers in Microsoft SharePoint Online audit logs

Microsoft SharePoint Online audit logs provide a comprehensive audit trail of all requests processed by the SharePoint Online service for a tenant. These logs capture a wide range of user activities, including operations such as file and folder creation, updates, deletions, and list modifications. For a detailed overview of SharePoint Online audit logging, see [SharePoint Online Audit Logs](/purview/audit-log-sharing?tabs=microsoft-purview-portal). 

**Investigation Scenarios Using Linkable Identifiers**

For scenarios involving SharePoint Online activity, you can:

- Start with linkable identifiers from Microsoft Entra sign-in logs, such as SID or UTI.
- Use these identifiers to search Microsoft Purview Audit (Standard) or Audit (Premium) logs.
- Track all user actions performed within SharePoint Online during a specific session or by a specific token.

This approach enables security analysts to correlate authentication events with SharePoint activity, supporting effective investigation and response to potential threats.

For guidance on searching SharePoint Online audit logs, see [Search the audit log | Microsoft Learn](/purview/audit-search).

The table below shows the mapping between linkable identifier claims and Microsoft SharePoint Online audit log attribute.

| **Claim** | **Microsoft SharePoint Online audit log attribute name**                              |
|-----------|---------------------------------------------------------------|
| oid       | UserObjectId                                                              |
| tid       | OrganizationId                                                |
| sid       | AADSessionId within App Access Context object                 |
| deviceid  | DeviceId (Available only for registered/domain joined device) |
| uti       | UniqueTokenId within App Access Context object                |
| iat       | IssuedAtTime within App Access Context object                 |

### View Microsoft SharePoint Online audit logs using Microsoft Purview portal

1. Go to [Microsoft Purview portal](https://purview.microsoft.com/).
1. Search for logs with a specific timeframe and workload as  Microsoft SharePoint Online.

   :::image type="content" border="true" source="media/how-to-authentication-track-linkable-identifiers/sharepoint-purview-workload-search.png" alt-text="Screenshot of Microsoft Purview portal showing search for SharePoint Online logs.":::

1. To filter by Record Types, the supported record types can be found by items starting with SharePoint.
 
   :::image type="content" border="true" source="media/how-to-authentication-track-linkable-identifiers/sharepoint-purview-record-types-search.png" alt-text="Screenshot of Microsoft Purview portal showing supported Record Types for SharePoint Online.":::

1. You can further filter for a specific user, or a UTI value from Microsoft Entra sign-in logs. You can filter all the activity logs within a session with `AADSessionId`.
1. The audit search results will show all the log lines from the SharePoint Online activities.
    
   :::image type="content" border="true" source="media/how-to-authentication-track-linkable-identifiers/purview-search-linkable-identifiers-sharepoint-results.png" alt-text="Screenshot of Microsoft Purview portal showing audit log results for SharePoint Online.":::

1. Each log item shows all the linkable identifiers.

   :::image type="content" border="true" source="media/how-to-authentication-track-linkable-identifiers/purview-search-linkable-identifiers-sharepoint.png" alt-text="Screenshot of Microsoft Purview portal showing log item with linkable identifiers for SharePoint Online.":::

1. Export the audit log and investigate for a specific `AADSessionId` or `UniqueTokenId` for all the activities for Microsoft SharePoint Online.

## Linkable identifiers in Microsoft Teams audit logs

Microsoft Teams audit logs capture a detailed record of all requests processed by the Teams service for a tenant. Audited activities include team creation and deletion, channel additions and removals, and changes to channel settings.

For a full list of audited Teams activities, see [Teams activities in the audit log](/purview/audit-log-activities).
For more information about Teams audit logs, see [Teams Audit Logs](/purview/audit-teams-audit-log-events). For more information about how to search the Teams audit logs, see [Search the audit log](/purview/audit-search).

### Investigation scenarios using linkable identifiers

To investigate Teams activity:

- Start with linkable identifiers from Microsoft Entra sign-in logs, such as SID or UTI.
- Use these identifiers to search Microsoft Purview Audit (Standard) or Audit (Premium) logs.
- Track user actions across Teams sessions, including team and channel operations.

The table below shows the mapping between linkable identifier claims and Teams audit log attribute.

| **Claim** | **Teams audit log attribute name**                              |
|-----------|---------------------------------------------------------------|
| oid       | UserKey                                                 |
| tid       | OrganizationId                                                 |
| sid       | AADSessionId within App Access Context object     |
| deviceid  | DeviceId (Available only for registered/domain joined device) |
| uti       | UniqueTokenId within App Access Context object                |
| iat       | IssuedAtTime within App Access Context object                 |

## Investigating Token Misuse Across Microsoft Teams and SharePoint Online

In the event of a security incident where an access token is compromised—such as through phishing—and subsequently used by a malicious actor, tenant administrators should take immediate action to contain the threat and investigate its impact.

After revoking all active user sessions and tokens, administrators can begin a forensic investigation to determine the scope of unauthorized activity. Specifically, they may need to identify actions performed by the attacker across Microsoft Teams and SharePoint Online during the affected timeframe.

Using linkable identifiers such as the Session ID (SID) and Unique Token Identifier (UTI) from Microsoft Entra sign-in logs, administrators can correlate and trace activity across Microsoft Purview Audit (Standard) and Audit (Premium) logs. This enables visibility into:

Teams-related actions such as team or channel creation, deletion, or configuration changes.
SharePoint Online operations including file access, creation, modification, or deletion.

1. Start with Microsoft Entra sign-in logs to find the session id of this access token by filtering around the time the token was phished and the user objectId.

   :::image type="content" border="true" source="media/how-to-authentication-track-linkable-identifiers/linkable-sign-in-log-entries.png" alt-text="Screenshot of Microsoft Purview portal showing log item with linkable identifiers for Teams scenario.":::

1. Determine the linkable identifiers from Microsoft Entra sign-in logs, such as SID or UTI, to use as a filter on Teams and SharePoint Online audit logs.

1. In the Purview portal, search for logs with a specific timeframe for workloads such as Teams and SharePoint Online, and for the specific user.

   :::image type="content" border="true" source="media/how-to-authentication-track-linkable-identifiers/purview-search-teams-sharepoint.png" alt-text="Screenshot of Microsoft Purview portal showing search for logs for SharePoint and Teams workload.":::

1. The search returns all audit log entries within that timeframe, filtered by the user and workloads as Teams and SharePoint Online.

   :::image type="content" border="true" source="media/how-to-authentication-track-linkable-identifiers/purview-search-teams-sharepoint-results.png" alt-text="Screenshot of Microsoft Purview portal showing results for SPO and Teams logs.":::

1. Admin can see all the audit log trail from user logging into team and see that the bad actor has done several activities like added specific users into a Teams channel, posted a phishing message, deleted files from sharepoint and added files etc.

1. Each log item can be opened to get detailed information on linkable identifiers. Below is an example of user posting a message.

   :::image type="content" border="true" source="media/how-to-authentication-track-linkable-identifiers/purview-search-teams-sharepoint-log-item.png" alt-text="Screenshot of Microsoft Purview portal showing log item for Teams and SPO.":::

1. Below is an example of user downloading a file from SharePoint Online.

   :::image type="content" border="true" source="media/how-to-authentication-track-linkable-identifiers/purview-search-sharepoint-log-item.png" alt-text="Screenshot of Microsoft Purview portal showing search for log item for Teams and SPO.":::

1. Export the audit log and investigate for a specific `SessionId` or `UniqueTokenId` for specific activities. The image below shows all different operations that have been performed by the attacker.

   :::image type="content" border="true" source="media/how-to-authentication-track-linkable-identifiers/purview-search-teams-sharepoint-exported-file.png" alt-text="Screenshot of Microsoft Purview portal showing search for logs exported.":::

By analyzing the log files with linkable identifiers, tenant admin and security professionals can effectively trace, analyze, and respond to malicious activity across sessions and tokens.

## Related content

[Microsoft Entra Sign in logs](~/identity/monitoring-health/concept-sign-ins.md)<br/>
[Teams Audit Logs](/purview/audit-teams-audit-log-events)<br/>
[SharePoint Online Audit Logs](/purview/audit-log-sharing#tabs=microsoft-purview-portal)<br/>
[Microsoft Graph Activity Logs](/graph/microsoft-graph-activity-logs-overview)

