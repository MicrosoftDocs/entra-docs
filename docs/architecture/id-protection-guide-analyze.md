---
title: Microsoft Entra ID Protection scenario for visibility into risk analysis for resulting actions
description: Learn about risk analysis to identify risky users, discern risk event types, and examine risk levels for access and identity decisions.
author: gargi-sinha
manager: martinco
ms.author: gasinh
ms.service: entra-id-protection
ms.topic: concept-article
ms.date: 10/24/2025

#CustomerIntent: As an administrator, I want to improve my risk analysis, risk assessment, and resulting actions for common risk event types, flagged users, and risk-level patterns.
---
# Microsoft Entra ID Protection scenario: Visibility into risk analysis for resulting actions

The proof-of-concept (PoC) guidance in this series of articles helps you to learn, deploy, and test Microsoft Entra ID Protection to detect, investigate, and remediate identity-based risks.

An overview of the guidance begins with [Introduction to Microsoft Entra ID Protection proof-of-concept guidance](id-protection-guide-introduction.md).

Detailed guidance continues with these scenarios:

* [Use real-time risk detection to grant access to protected resources](id-protection-guide-detect.md)
* [Bring identity risk-related telemetry into security investigations](id-protection-guide-investigate.md)
* [Allow users to self-remediate identity risk for enterprise-managed resources](id-protection-guide-remediate.md)

This article helps identity administrators gain visibility into risk analysis and resulting actions with [Azure Monitor Logs](/azure/azure-monitor/logs/data-platform-logs). Configure access to your organization's resources with a proactive approach to risk. Create automated conditions for access and save on operationional and support costs. Mitigate the accelerating pace of cyber attack complexity. 

* Track risk events across users and sign-ins 
* Correlate anomalies with [Microsoft Entra Conditional Access](../identity/conditional-access/overview.md) policies and sign-in logs 
* Identify potential threat patterns
  * Enrich investigations and stream telemetry to [Microsoft Defender XDR](/defender-xdr/microsoft-365-defender) and [Microsoft Sentinel](/azure/sentinel/overview), a security information and event management (SIEM) tool with threat intelligence and a data-lake architecture
  * You can [search the audit log in Microsoft Defender XDR](/defender-xdr/microsoft-xdr-auditing).

Use the following sections to learn how to collect, transform, remove, optimize, and route data. Also learn how to manage common risk event types, repeatedly flagged users, and risk level patterns with Azure Monitor logs and Microsoft Entra ID Protection.

* [Enable risk analysis with the AADUserRiskEvents table](#enable-risk-analysis-with-the-aaduserriskevents-table)
* [Ensure prerequisites are met](#ensure-prerequisites-are-met)
* [Create a Log Analytics workspace](#create-a-log-analytics-workspace)
* [Idenitify risky users](#identify-risky-users)
* [Discern risk event types](#discern-risk-event-types)
* [Examine risk levels](#examine-risk-levels)
* [Get started with Azure Monitor Logs reference tables](#get-started-with-azure-monitor-logs-reference-tables)

## Enable risk analysis with the AADUserRiskEvents table 

Identity risks grow in speed and complexity every year. You can use risk insights to grasp the volume and details of potential identity attacks and compromises. Enable Azure Monitor Logs reference tables to analyze risk insights with [Microsoft Entra ID Protection](../id-protection/overview-identity-protection.md) that detects, investigates, and remediates identity risks. Risk data goes to access decisions tools, or tools for investigation and correlation. Microsoft Entra ID Protection is continuously updated to help organizations stay ahead of emerging threats. Identity risk management becomes more proactive, scalable, and effective. 

With insights, reference tables, and more, you can investigate and remediate identity risks with Conditional Access and construct targeted policies to address your orgnanization's risks.  

Learn more in the [Azure Monitor Logs overview](/azure/azure-monitor/logs/data-platform-logs).

In Microsoft Entra ID Protection, there are four risk tables to query risk events, risky users, and risky [Service Principals](/azure/databricks/admin/users-groups/service-principals). 

* AADUserRiskEvents 
* AADRiskyUsers 
* AADServicePrincipalRiskEvents 
* AADRiskyServicePrincipals 

In this article, the focus is the **AADUserRiskEvents** table. To understand more about discerning risks to your organization, see the following video. 

**Mastering risk analysis with Microsoft Entra ID Protection** 

   > [!VIDEO abb7d7fe-4155-4ee1-bcce-afa027d22f8d]

## Ensure prerequisites are met

To use Azure Monitor, ensure the following prerequisites are met. 

* A Microsoft Entra ID P2 Premium license
  * See [Microsoft Entra plans and pricing](https://www.microsoft.com/security/business/microsoft-entra-pricing?msockid=3c61c9beef5963ba2f03dc9cee156239)
* An Azure account with an active subscription
  * Learn about [Azure accounts](https://azure.microsoft.com/pricing/purchase-options/azure-account/)
* Microsoft.OperationalInsights/workspaces/write permissions to the resource group for the Log Analytics workspace
  * Learn about the **Log Analytics Contributor** role in [manage access to Log Analytics workspaces](/azure/azure-monitor/logs/manage-access)

## Create a Log Analytics workspace

A Log Analytics workspace is a data store to collect log data types from Azure and non-Azure resources and applications. We recommend you send all log data to one Log Analytics workspace. 

1. [Create a Log Analytics workspace](/azure/azure-monitor/logs/quick-create-workspace).
2. To incorporate the data you want to analyze, add diagnostics settings. See the following list.
3. To view the Queries hub, in the Log Analytics workspace, select **Logs**.
4. Search for **Risk**.
5. Locate the **Recent user risk events** query.
6. Select **Run**.

**Diagnostics settings**
  * AuditLogs
  * SignInLogs
  * NonInteractiveUserSignInLogs
  * ServicePrincipalSignInLogs
  * ManagedIdentitySignInLogs
  * RiskyUsers
  * UserRiskEvents
  * RiskyServicePrincipals
  * ServicePrincipalRiskEvents

See the following screenshot of the **Logs** option and the Queries hub page.

   ![Screenshot of the Logs option and the Queries hub page.](./media/id-protection-guide-analyze/queries-hub.png)

7. From the dropdown, change **Simple mode** to Kusto Query Language mode (**KQL mode**).

   ![Screenshot of the KQL-mode option in the dropdown menu.](./media/id-protection-guide-analyze/kql-mode.png)

## Identify risky users

This section and the following sections illustrate how to analyze risk with Azure Monitor. Risk users have one or more risky sign-ins, or other risky actions

1. Run the query to summarize the count by **UserDisplayName**.
2. Add a time range in **DetectedDateTime < ago()**.  

In the following example query, **30d** is the date range. 

```kusto
// Recent user risk events 
// Gets list of the top 100 active user risk events. 
AADUserRiskEvents 
| where DetectedDateTime > ago(30d) 
| where RiskState == "atRisk" 
| take 100 
| summarize count()by UserDisplayName 
```

Use the previous query to identify common user patterns, such as service accounts, or small user subsets generating large amounts of risk. In the following screenshot, there are risky users. One generates more risk events than the others. For this scenario, you can block the user, or require a secure password change. 

   ![Screenshot of risky user data from the query.](./media/id-protection-guide-analyze/risky-users.png)

## Discern risk event types

Risk even types include unfamiliar sign-in, unusual tokens, and unlikely travel are examples. After you determine user patterns, review detections and summarize them by the risk event type.  

1. Use the **AADUserRiskEvents** table.
2. Summarize with **RiskEventType**. 

**Example query**
```kusto
// Recent user risk events 
// Gets list of the top 100 active user risk events. 
AADUserRiskEvents 
| where DetectedDateTime > ago(30d) 
| where RiskState == "atRisk" 
| take 100  
| summarize count()by RiskEventType 
```

While reviewing risk types, pay attention to large volumes. In the following screenshot, there are flagged risk events, most are related to:

* **UnfamiliarFeatures** - Detect unfamiliar sign-in properties for a user
  * Enforce session controls such as sign-in frequency, application restrictions, and persistent browser controls
* **AnomalousToken** - Set up Conditional Access policies to require password reset and perform multifactor authentication (MFA)
  * Block access for high-risk sign-ins
* **UnlikelyTravel** - Add named locations as trusted IPs
  * Enable trusted locations for users that travel frequently

See the following screenshot of results from the active-user risk events query.

   ![Screenshot of the results from the active-user risk events query.](./media/id-protection-guide-analyze/risk-events.png)

## Examine risk levels

Risk-level totals enable effective decision making. Examine the **AADUserRiskEvents** table to review low-, medium-, and high-risk levels. Summarize risk events by level and analyze risk level totals. 

**Example query**
```kusto
// Recent user risk events 
// Gets list of the top 100 active user risk events. 
AADUserRiskEvents 
| where DetectedDateTime > ago(30d) 
| where RiskState == "atRisk" 
| take 100 
| summarize count()by RiskLevel  
```

In the following screenshot, three detections are high-risk. We recommend a minimum-baseline Conditional Access policy that requires secure password change, or that blocks high-risk users. 

   ![Screenshot of query results that show three high-risk users.](./media/id-protection-guide-analyze/three-high.png)

Learn more about access control decisions: [What is Conditional Access?](/azure/data-explorer/security-conditional-access)

## Get started with Azure Monitor Logs reference tables

To help you get started, see and learn more about Azure Monitor Log reference tables for Microsoft Entra ID Protection. The following links go to a list of tables by table name. Use logs generated by identity protection for user risk events, risky users, Service Principal risk events, risky Service Principals, and more.

* [AADUserRiskEvents](/azure/azure-monitor/reference/tables/aaduserriskevents)
* [AADRiskyUsers](/azure/azure-monitor/reference/tables/aadriskyusers)
* [AADServicePrincipalRiskEvents](/azure/azure-monitor/reference/tables/aadserviceprincipalriskevents)
* [AADRiskyServicePrincipals](/azure/azure-monitor/reference/tables/aadriskyserviceprincipals)

## Next steps

* [Introduction to Microsoft Entra ID Protection proof-of-concept guidance](id-protection-guide-introduction.md)
* [Use real-time risk detection to grant access to protected resources](id-protection-guide-detect.md)
* Enable visibility into risk analysis for resulting actions
* [Bring identity risk-related telemetry into security investigations](id-protection-guide-investigate.md)
* [Allow users to self-remediate identity risk for enterprise-managed resources](id-protection-guide-remediate.md)  

**Additional links**

* Watch instructional videos in the [ID Protect YouTube playlist](https://www.youtube.com/playlist?list=PL3ZTgFEc7Lyvgqywy5KvqYcFYpDSBj-qm)
* Visit the [Tech Community](https://techcommunity.microsoft.com/) for updates and technical information
* Learn to configure diagnostics at [idpdiagnosticssettings](https://aka.ms/idpdiagnosticssettings)

### Learn about Microsoft Entra

[Microsoft Entra](../fundamentals/what-is-entra.md) is a family of identity and network access products to implement a [Zero Trust](/security/zero-trust/zero-trust-overview) security strategy and create a [trust fabric](https://www.microsoft.com/security/blog/2024/05/08/how-implementing-a-trust-fabric-strengthens-identity-and-network/) to: 

* Verify identity
* Validate access conditions
* Check permissions
* Encrypt connection channels
* Monitor for compromise

With Microsoft Entra, organizations enable real-time access and identity decisions across hybrid and multicloud environments. Discover its features and capabilities for secure access. 

* [Microsoft Entra documentation](/entra/)
* [Microsoft Entra News and Insights, Microsoft Security Blog](https://www.microsoft.com/security/blog/product/microsoft-entra/)
* [Microsoft Entra blog, Tech Community](https://techcommunity.microsoft.com/)
* [Microsoft Entra discussions, Microsoft Community](https://techcommunity.microsoft.com/)


















































