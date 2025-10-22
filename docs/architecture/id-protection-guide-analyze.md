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

   ![The Logs option and the Queries hub page.](./media/id-protection-guide-analyze/queries-hub.png)

4. Search for **Risk**.
5. Locate the **Recent user risk events** query.
6. Select **Run**.
7. From the dropdown, change **Simple mode** to ***KQL mode**.

   ![The KQL-mode option in the dropdown menu.](./media/id-protection-guide-analyze/kql-mode.png)

