---
title: Microsoft Entra ID Protection to analyze risk
description: Learn about risk assessment through event types, risky users, and risk level patterns.
author: gargi-sinha
manager: martinco
ms.author: gasinh
ms.service: entra-id-protection
ms.topic: concept-article
ms.date: 10/22/2025

#CustomerIntent: As an administrator, I want to learn more about risk assessment and resulting actions. I need to prepare for common risk event types and risky users, also to understand risk level patterns.
---

# Microsoft Entra ID Protection to analyze risk

When configuring access to resources, a proactive approach to risk mitigates the accelerating pace of cyber attack complexity. Create automated conditions for access and save on operations and support costs. Organizations gain visibility into risk assessment and resulting actions with [Azure Monitor Logs](/azure/azure-monitor/logs/data-platform-logs) reference tables. Learn about common risk event types, repeatedly flagged users, and risk level patterns. 

* Track risk events across users and sign-ins 
* Correlate anomalies with [Conditional Access](../identity/conditional-access/overview.md) policies and sign-in logs 
* Identify potential threat patterns
  * Enrich investigations and stream telemetry to [Microsoft Defender XDR](/defender-xdr/microsoft-365-defender) and [Microsoft Sentinel](/azure/sentinel/overview)

You can [search the audit log for events in Microsoft Defender XDR](/defender-xdr/microsoft-xdr-auditing).

## Risk analysis with the AADUserRiskEvents table 

Identity risks grow in speed and complexity every year. You can use risk insights to grasp the volume and details of potential identity attacks and compromises. Enable Azure Monitor Logs reference tables to analyze risk insights with [Microsoft Entra ID Protection](../id-protection/overview-identity-protection.md), then investigate and remediate identity risks with Conditional Access. With these tools, you can construct targeted policies to address risks.  

Learn more in the [Azure Monitor Logs overview](/azure/azure-monitor/logs/data-platform-logs)

In Microsoft Entra ID Protection, there are four risk tables to query risk events, risky users, and risky Service Principals. 

* AADUserRiskEvents 
* AADRiskyUsers 
* AADServicePrincipalRiskEvents 
* AADRiskyServicePrincipals 

In this article, the focus is the **AADUserRiskEvents** table. 

To understand more about discerning risks to your organization, see the following video, </br>**Mastering risk analysis with Microsoft Entra ID Protection**. 

   > [!VIDEO abb7d7fe-4155-4ee1-bcce-afa027d22f8d]

## Prerequisites 

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
2. To incorporate the data you want to analyze, add diagnostics settings: 

* AuditLogs
* SignInLogs
* NonInteractiveUserSignInLogs
* ServicePrincipalSignInLogs
* ManagedIdentitySignInLogs
* RiskyUsers
* UserRiskEvents
* RiskyServicePrincipals
* ServicePrincipalRiskEvents 

3. To view the Queries hub, in the Log Analytics workspace, select **Logs**.

   ![Screenshot of the Logs option and the Queries hub page.](./media/id-protection-guide-analyze/queries-hub.png)


4. Search for **Risk**.
5. Locate the **Recent user risk events** query.
6. Select **Run**.
7. From the dropdown, change **Simple mode** to ***KQL mode**.

   ![Screenshot of the KQL-mode option in the dropdown menu.](./media/id-protection-guide-analyze/kql-mode.png)

## Three steps to analyze risk

The following sections illustrate how to analyze risk with Azure Monitor. 

### Step one: Identify risky users

1. Run the query to summarize the count by UserDisplayName
2. Add a time range in DetectedDateTime < ago().  

In the following example, 30d is the date range. 

```kusto
// Recent user risk events 
// Gets list of the top 100 active user risk events. 
AADUserRiskEvents 
| where DetectedDateTime > ago(30d) 
| where RiskState == "atRisk" 
| take 100 
| summarize count()by UserDisplayName 
```
Use this query to identify common user patterns, such as service accounts or small user subsets generating a large amount of risk. In the following screenshot, there are risky users. One generates more risk events than the others. For this scenario, you can block the user or require a secure password change. 

   ![Screenshot of risky user data from the query.](./media/id-protection-guide-analyze/risky-users.png)

## Step two: Discern risk event types

After you determine user patterns, review detections and summarize them by the risk event type.  

1. Use the AADUserRiskEvents table.
2. Summarize with RiskEventType. 

```kusto
// Recent user risk events 
// Gets list of the top 100 active user risk events. 
AADUserRiskEvents 
| where DetectedDateTime > ago(30d) 
| where RiskState == "atRisk" 
| take 100  
| summarize count()by RiskEventType 
```

While reviewing risk types, pay attention to large volumes. In the following screenshot, there are flagged risk events, most related to:

* **UnfamiliarFeatures** - Unfamiliar sign-in properties for a user. Enforce session controls such as sign-in frequency, application restrictions, and persistent browser controls
* **AnomalousToken** - Set up Conditional Access policies to require password reset, perform multifactor authentication (MFA), or block access for high-risk sign-ins
* **UnlikelyTravel** – If some users travel frequently, add named locations as trusted IPs and ensure trusted locations aren’t flagged as risky

   ![Screenshot of the results from the active-user risk events query.](./media/id-protection-guide-analyze/risk-events.png)
