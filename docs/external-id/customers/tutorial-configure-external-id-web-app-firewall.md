---
title: Configure Microsoft Entra External ID with Azure Web Application Firewall
description: Tutorial to configure Microsoft Entra External ID with Azure Web Application Firewall
author: gargi-sinha
manager: martinco
ms.author: gasinh
ms.reviewer: kengaderdus
ms.service: entra-external-id
ms.subservice: external
ms.topic: tutorial
ms.custom: it-pro
ms.date: 12/18/2024

#CustomerIntent: As an IT administrator, I want to learn how to enable the Azure Web Application Firewall (WAF) service for a Microsoft Entra External ID tenant with an Azure WAF so that I can protects web applications from common exploits and vulnerabilities.
---
# Tutorial: Configure Microsoft Entra External ID with Azure Web Application Firewall

In this tutorial, you learn how to enable the [Azure Web Application Firewall](/azure/web-application-firewall/ag/ag-overview) (WAF) service for a Microsoft Entra External ID tenant. Azure WAF protects web applications from common exploits and vulnerabilities such as cross-site scripting, Distributed Denial-of-Service (DDoS) attacks, and malicious bot activity.

## Prerequisites

- **An Azure subscription**. If you don’t have one, [get an Azure account](https://azure.microsoft.com/free/) for free.
- **A Microsoft Entra External ID tenant**. Authorization server that verifies user credentials with custom policies in the tenant, also known as the identity provider (IdP). Learn how to [create an external tenant](how-to-create-external-tenant-portal.md).
- **Azure Front Door Premium**. [Azure Front Door](/azure/frontdoor/) enables custom domains for the Microsoft Entra External ID tenant with security optimization and access to WAF managed rule sets.
- **Azure Web Application Firewall** (requires Premium SKU). [Azure WAF](https://azure.microsoft.com/services/web-application-firewall/) manages traffic that the authorization server receives.
- **A custom domain**. Use with the custom domain features in Azure Front Door. Learn how to [enable custom URL domains for apps in external tenants](how-to-custom-url-domain.md).

> [!IMPORTANT]
> After you configure the custom domain, [test your custom domain](how-to-custom-url-domain.md#test-your-custom-url-domains).

## Enable WAF

To enable WAF for protection, configure a WAF policy and associate it with Azure Front Door Premium. Microsoft optimizes Azure Front Door premium for security and manages the rule sets provided by the WAF to protect against common vulnerabilities including cross-site scripting and Java exploits. Additionally, Azure WAF provides rule sets that help protect against malicious bot activity and provide layer 7 DDoS protection for your application.

## Create WAF policy

Create a WAF policy with Azure-managed default rule sets (DRS). See [Web Application Firewall DRS rule groups and rules](/azure/web-application-firewall/afds/waf-front-door-drs).

1. Sign in to the **Azure portal**.
1. Select **Create a resource**.
1. Search for **Azure WAF**.
1. Select **Azure Service Web Application Firewall (WAF) from Microsoft**.
1. Select **Create**.
1. Go to **Create a WAF policy**.
1. Select **Basics**.
1. **Policy for**: Select **Global WAF (Front Door)**.
1. **Front Door SKU**: Select the Premium SKU.
1. **Subscription**: Select your Front Door subscription name.
1. **Resource group**: Select your Front Door resource group name.
1. **Policy name**: Enter a unique name for your WAF policy.
1. **Policy state**: Select **Enabled**.
1. **Policy mode**: Select **Detection**.
1. Go to **Create a WAF policy** > **Association**.
1. Select **+ Associate a Front Door profile**.
1. **Front Door**: Select the Front Door name that you associated with your Microsoft Entra External ID custom domain.
1. **Domains**: Select the Microsoft Entra External ID custom domains to which to associate the WAF policy.
1. Select **Add**.
1. Select **Review + create**.
1. Select **Create**.

## Configure default rule set

After you create a new WAF policy, Azure Front Door automatically deploys with the latest version of the [Azure-managed default rule set](/azure/web-application-firewall/afds/waf-front-door-drs) (DRS). This rule set protects web applications from common vulnerabilities and exploits. Azure-managed rule sets protect against common security threats. Azure manages and updates these rule sets as needed to protect against new attack signatures. The DRS includes the [Microsoft Threat Intelligence Collection rules](/azure/web-application-firewall/afds/waf-front-door-drs#microsoft-threat-intelligence-collection-rules) that provide increased coverage, patches for specific vulnerabilities, and better false positive reduction.

## Configure bot manager rule set

By default, the Azure Front Door WAF deploys with the latest version of the Azure-managed [bot manager rule set](/azure/web-application-firewall/afds/afds-overview#bot-protection-rule-set). This rule set categorizes bot traffic into good, bad, and unknown bots. The WAF platform manages and dynamically updates the bot signatures behind this rule set.

## Configure rate limiting

[Rate limiting for Azure Front Door](/azure/web-application-firewall/afds/waf-front-door-rate-limit) enables you to detect and block abnormally high traffic from any socket IP address. Use Azure WAF in Azure Front Door to mitigate some types of denial-of-service attacks. Rate limiting protects clients accidentally misconfigured to send large volumes of requests in a short time. You must use custom rules to [manually configure rate limiting on the WAF](/azure/web-application-firewall/afds/waf-front-door-rate-limit-configure).

## Configure detection and prevention modes

After you create a WAF policy, Azure starts the policy in **Detection mode**. Leave the WAF policy in **Detection mode** while you tune the WAF for your traffic. In **Detection mode**, the WAF doesn’t block requests. Instead, the WAF logs requests that match the WAF rules after you [enable logging](/azure/web-application-firewall/afds/waf-front-door-monitor#logs-and-diagnostics).

After you enable logging and your WAF receives request traffic, look through your logs and [tune your WAF](/azure/web-application-firewall/afds/waf-front-door-tuning).

The following query shows the requests that an example WAF policy blocked in the previous 24 hours. The details include rule name, request data, action that the policy took, and policy mode.

```kusto
AzureDiagnostics
| where TimeGenerated >= ago(24h)
| where Category == "FrontdoorWebApplicationFirewallLog"
| where action_s == "Block"
| project RuleID=ruleName_s, DetailMsg=details_msg_s, Action=action_s, Mode=policyMode_s, DetailData=details_data_s
```

|RuleID|DetailMsg|Action|Mode|DetailData|
|---|---|---|---|---|
|DefaultRuleSet-1.0-SQLI-942430|Restricted SQL Character Anomaly Detection (args): # of special characters exceeded (12)|Block|Detection|Matched Data: CfDJ8KQ8bY6D|

Review the WAF logs to determine if your WAF's rules caused any false positives. Then use exclusions to mitigate those WAF false positives. [Configure web application firewall exclusion lists](/azure/web-application-firewall/afds/waf-front-door-exclusion-configure). Configure [Web Application Firewall with Azure Front Door exclusion lists](/azure/web-application-firewall/afds/waf-front-door-exclusion).

After you set up logging and your WAF receives traffic, you can assess the effectiveness of your bot manager rules in handling bot traffic. The following query shows the actions that the example bot manager rule set took categorized by bot type. While in **Detection mode**, the WAF only logs bot traffic actions. After you switch to **Prevention mode**, the WAF begins actively blocking unwanted bot traffic.

```kusto
AzureDiagnostics
| where Category == "FrontDoorWebApplicationFirewallLog"
| where action_s in ("Log", "Allow", "Block", "JSChallenge", "Redirect") and ruleName_s contains "BotManager"
| extend RuleGroup = extract("Microsoft_BotManagerRuleSet-[\\d\\.]+-(.*?)-Bot\\d+", 1, ruleName_s)
| extend RuleGroupAction = strcat(RuleGroup, " - ", action_s)
| summarize Hits = count() by RuleGroupAction, bin(TimeGenerated, 30m)
| project TimeGenerated, RuleGroupAction, Hits
| render columnchart kind=stacked
```

## Switch modes

To see WAF act on request traffic, select **Switch to Prevention mode** from your WAF policy’s **Overview** page in the Azure portal. This selection changes the mode from **Detection mode** to **Prevention mode**. The WAF blocks requests that match the rules in WAF policy and logs them in the WAF logs. The WAF takes the prescribed action when a request matches one or more rules and logs the results. By default, the DRS sets to [anomaly scoring mode](/azure/web-application-firewall/afds/waf-front-door-drs#anomaly-scoring-mode); the WAF doesn’t take action on a request unless it meets the anomaly score threshold.

To revert to **Detection mode**, select **Switch to Detection mode** from the **Overview** page.

## Next steps

- [Best practices for Azure Web Application Firewall in Azure Front Door](/azure//web-application-firewall/afds/waf-front-door-best-practices)
- [Manage Web Application Firewall policies](/azure/firewall-manager/manage-web-application-firewall-policies)
- [Tune Azure Web Application Firewall for Azure Front Door](/azure/web-application-firewall/afds/waf-front-door-tuning)
