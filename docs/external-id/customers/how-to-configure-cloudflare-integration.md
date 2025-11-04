---
title: Configure Cloudflare Web Application Firewall with Microsoft Entra External ID
description: Learn how to configure Cloudflare Web Application Firewall (WAF) to protect against attacks.
author: gargi-sinha
manager: martinco
ms.service: entra-external-id
ms.subservice: external
ms.topic: how-to
ms.date: 11/04/2025
ms.author: gasinh
ms.custom: it-pro

#CustomerIntent: As an IT administrator, I want to learn how to enable the Cloudflare Web Application Firewall (WAF) service for a Microsoft Entra External ID tenant with a Cloudflare WAF so that I can protect web applications from common exploits and vulnerabilities.
---
# Configure Cloudflare Web Application Firewall with Microsoft Entra External ID

In this article, you learn how to configure Cloudflare Web Application Firewall ([Cloudflare WAF](https://www.cloudflare.com/application-services/products/waf/)) to protect your organization from attacks, such as distributed denial of service (DDoS), malicious bots, Open Worldwide Application Security Project [(OWASP) Top-10](https://owasp.org/www-project-top-ten/) security risks, and others. 

## Prerequisites

To get started, you need:

* Microsoft Entra External ID tenant
* Microsoft [Azure Front Door (AFD)](/azure/frontdoor/front-door-overview)
* Cloudflare account with WAF

Learn about tenants and securing apps for consumers and customers with [Microsoft Entra External ID](../external-identities-overview.md).

## Scenario description

* **Microsoft Entra External ID tenant** – The identity provider (IdP) and authorization server that verifies user credentials with custom policies defined for the tenant. 
* **Azure Front Door** – Enables custom URL domains for Microsoft Entra External ID. Traffic to custom URL domains goes through Cloudflare WAF, it then goes to AFD, and then to the Microsoft Entra External ID tenant. 
* **Cloudflare WAF** – Security controls to protect traffic to the authorization server. 

## Setup steps

### Enable custom URL domains

The first step is to enable custom domains with AFD. Use the instructions in, [Enable custom URL domains for apps in external tenants](../customers/how-to-custom-url-domain.md). 

### Create a Cloudflare account

1. Go to [Cloudflare.com/plans](https://www.cloudflare.com/plans/) to create an account. 
2. To enable WAF, on the **Application Services** tab, select **Pro**. 

### Configure the domain name server (DNS)

Enable WAF for a domain.

1. In the DNS console, for CNAME, enable the proxy setting.

   [![Screenshot of CNAME options.](media/how-to-configure-cloudflare-integration./proxy-settings.png)](media/how-to-configure-cloudflare-integration./proxy-settings-expanded.png#lightbox)

2. Under DNS, for **Proxy status**, select **Proxied**.
3. The status turns orange.

   [![Screenshot of proxied status.](media/how-to-configure-cloudflare-integration./proxied-status.png)](media/how-to-configure-cloudflare-integration./proxied-status-expanded.png#lightbox)

> [!NOTE]
> Azure Front Door-managed certificates aren't automatically renewed if your custom domain’s CNAME record points to a DNS record other than the Azure Front Door endpoint’s domain (for example, when using a third-party DNS service like Cloudflare). To renew the certificate in such cases, follow the instructions in the [Renew Azure Front Door-managed certificates](/azure/frontdoor/domain#renew-azure-front-door-managed-certificates) article.

### Cloudflare security controls

For optimal protection, we recommend you enable Cloudflare security controls. 

### DDoS protection

1. Go to the [Cloudflare dashboard](https://developers.cloudflare.com/workers/get-started/dashboard/).
2. Expand the Security section.
3. Select **DDoS**.
4. A message appears. 

    [![Screenshot of DDoS protection message.](media/how-to-configure-cloudflare-integration./ddos-message.png)](media/how-to-configure-cloudflare-integration./ddos-message-expanded.png#lightbox)

### Bot protection

1. Go to the [Cloudflare dashboard](https://developers.cloudflare.com/workers/get-started/dashboard/).
2. Expand the Security section.
3. Under **Configure Super Bot Fight Mode**, for **Definitely automated**, select **Block**.
4. For **Likely automated**, select **Managed Challenge**.
5. For **Verified bots**, select **Allow**.

   ![Screenshot of bot protection options.](media/how-to-configure-cloudflare-integration./bot-protection.png)

### Firewall rules: Traffic from the Tor network

We recommend you block traffic that originates from the Tor proxy network, unless your organization needs to support the traffic. 

   > [!NOTE]
   > If you can't block Tor traffic, select **Interactive Challenge**, not **Block**.

### Block traffic from the Tor network

1. Go to the [Cloudflare dashboard](https://developers.cloudflare.com/workers/get-started/dashboard/). 
2. Expand the Security section.
3. Select **WAF**.
4. Select **Create rule**.
5. For **Rule name**, enter a relevant name.
6. For **If incoming requests match**, for **Field**, select **Continent**.
7. For **Operator**, select **equals**.
8. For **Value**, select **Tor**.
9. For **Then take action**, select **Block**.
10. For **Place at**, select **First**.
11. Select **Deploy**.

    ![Screenshot of the create rule dialog.](media/how-to-configure-cloudflare-integration./create-rule.png)

   > [!NOTE]
   > You can add custom HTML pages for visitors.

### Firewall rules: Traffic from countries or regions

We recommended strict security controls on traffic from countries or regions where business is unlikely to occur, unless your organization has a business reason to support traffic from all countries or regions.  

   > [!NOTE]
   > If you can't block traffic from a country or region, select **Interactive Challenge**, not **Block**.

### Block traffic from countries or regions

For the following instructions, you can add custom HTML pages for visitors. 

1. Go to the [Cloudflare dashboard](https://developers.cloudflare.com/workers/get-started/dashboard/). 
1. Expand the Security section.
1. Select **WAF**.
1. Select **Create rule**.
1. For **Rule name**, enter a relevant name.
1. For **If incoming requests match**, for **Field**, select **Country** or **Continent**.
1. For **Operator**, select **equals**.
1. For **Value**, select the country or continent to block.
1. For **Then take action**, select **Block**.
1. For **Place at**, select **Last**.
1. Select **Deploy**.

   ![Screenshot of the name field on the create rule dialog.](media/how-to-configure-cloudflare-integration./create-rule-name.png)

### OWASP and managed rulesets

1. Select **Managed rules**.
2. For **Cloudflare Managed Ruleset**, select **Enabled**.
3. For **Cloudflare OWASP Core Ruleset**, select **Enabled**.

   [![Screenshot of rule sets.](media/how-to-configure-cloudflare-integration./rulesets.png)](media/how-to-configure-cloudflare-integration./ruleset-expanded.png#lightbox)

## Verification steps

Connect Cloudflare's [API token](https://developers.cloudflare.com/fundamentals/api/get-started/create-token/) and [Zone ID](https://developers.cloudflare.com/fundamentals/account/find-account-and-zone-ids/#copy-your-zone-id) to Microsoft Entra External ID to verify WAF configuration via Microsoft Graph API, using Graph Explorer or any REST client for endpoint calls.

### Connect the API token and Zone ID

You can connect the API token and Zone ID to Microsoft Entra External ID to pull and verify the WAF configuration for your domain. Use the Microsoft Graph API to interact with the Cloudflare API. To do this, you need to include the API token and Zone ID in your requests.

For WAF verification, use the Microsoft Graph API endpoint. You can call this endpoint through [Graph Explorer](https://developer.microsoft.com/en-us/graph/graph-explorer) or any REST client.

- Make sure the caller has the [Security Reader](/entra/identity/role-based-access-control/permissions-reference#security-reader) role and has consented to the [RiskPreventionProviders.Read.All](/graph/permissions-reference#riskpreventionprovidersreadall) permission. See more details about the RiskPreventionProviders.Read.All permission in the [next section](/entra/external-id/customers/how-to-configure-cloudflare-integration#risk-prevention-provider-permission-details).

  :::image type="content" source="media\how-to-configure-akamai-integration\consent-to-permissions.png" alt-text="Screenshot showing consent to permissions." :::

  :::image type="content" source="media\how-to-configure-akamai-integration\consent-button.png" alt-text="Screenshot showing the consent button." :::

- Provide the **API token** you created in the previous step and the **Zone ID** for your domain. This information is required so the backend can call Cloudflare on your behalf to pull and verify the WAF configuration.  
  - The token is treated like any client secret and is never stored or logged in plain text or without encryption.
- The verification process checks that a DNS record is properly configured and validates whether recommended managed rulesets are enabled. It also reports all enabled managed rulesets and custom rules in the specified Cloudflare zone.
- The API returns detailed error codes to help you identify configuration issues and provides actionable recommendations.

### Risk prevention provider permission details

The following permission allows the app to read your organization's risk prevention providers without a signed-in user.

| **Permission**  | **Description**  | **Endpoint**  |
|----|----|----|
| RiskPreventionProviders.Read.All  | Allows reading  Web Application Firewall information.  | POST /riskPrevention/webApplicationFirewalls/Verify  |

### Sample request and response

To connect Cloudflare WAF with Microsoft Entra External ID, use the following example request and response.

Sample request:

```http
POST https://graph.microsoft.com/v1.0/directory/customSecurityAttributeDefinitions
{
  "hostName": "yourdomain.com",
  "connection": {
    "@odata.type": "#microsoft.graph.cloudFlareConnection",
    "apiToken": "{CloudFlare API Token}",
    "zoneId": "{CloudFlare Zone Id}"
  }
}
```

Sample response:

```http
HTTP/1.1 200 OK
Content-type: application/json
{
  "@odata.context": "https://graph.microsoft.com/beta/$metadata#microsoft.graph.webApplicationFirewallVerificationModel",
  "verificationResult": {
    "status": "success",
    "verifiedOnDateTime": "2025-02-19T22:15:09.7116872Z",
    "errors": [],
    "warnings": []
  },
  "verifiedDetails": {
    "@odata.type": "#microsoft.graph.cloudFlareVerifiedDetailsModel",
    "zoneId": "{CloudFlare Zone Id}",
    "dnsConfiguration": {
      "name": "yourdomain.com",
      "isProxied": true,
      "recordType": "cname",
      "value": "google.com"
    },
    "enabledRecommendedRulesets": [
      {
        "rulesetId": "12345ab6c78d9012e3456f7ghi890jk",
        "name": "CloudFlare Free Managed Ruleset",
        "phaseName": "http_request_firewall_managed"
      }
    ],
    "enabledCustomRules": [
      {
        "ruleId": "1234567890a12b3cd4",
        "name": "Block when the IP address is not 1.1.1.1",
        "action": "block",
        "phaseName": "http_request_firewall_custom"
      }
    ]
  }
}

```

### Test the configuration

Once you’ve connected Cloudflare WAF with Microsoft Entra External ID, it’s important to test the configuration to ensure everything is working as expected.

:::image type="content" source="media\how-to-configure-cloudflare-integration\configuration-test.png" alt-text="Screenshot showing configuration test results":::

## Troubleshooting

The following table lists common issues you might encounter when integrating Cloudflare WAF with Microsoft Entra External ID, along with their details and resolutions.

| **Issue** | **Details** | **Resolution** |
|-----------|-------------|-----------------|
| Bad Request Response | `"The provided API Key has insufficient permissions. Please reauthenticate and try again.\r\n CloudFlare Request ID: {CF-Ray-value}\r\nCorrelation ID: random-id-entry-value\r\nTimestamp: 2024-08-25 21:32:40Z"` | Check the permission level mentioned in the above steps. |
| Couldn't reach the external tenant's well-known endpoint | `"Could not reach the tenant's well-known endpoint via custom domain. Please check that your custom domain has been properly configured to route traffic."`<br>At the Graph level, you might see **HTTP 200 OK** with status **failure** when Cloudflare returns error code **403**. This check is performed on our side before any API calls to Cloudflare. | Disable the captcha on the Cloudflare portal (change the wildcard to disable), then rerun the POST request. |

## Additional resources

- Cloudflare WAF [Get started guide](https://developers.cloudflare.com/waf/get-started/): Includes recommendations on how to best configure WAF and what basic protection and rules can be deployed. 
- FAQ related to [External Tenant Overview - Microsoft Entra External ID | Microsoft Learn](/entra/external-id/customers/overview-customers-ciam) for other best practices and considerations. 
- Check traffic results in the Cloudflare dashboard: [Security Analytics · Cloudflare Web Application Firewall (WAF) docs](https://developers.cloudflare.com/waf/analytics/security-analytics/)
- Azure Front Door additional best practices [Domains in Azure Front Door | Microsoft Learn](https://learn.microsoft.com/en-us/azure/frontdoor/domain#domain-types)
- [API Troubleshooting · Cloudflare Fundamentals docs](https://developers.cloudflare.com/fundamentals/api/troubleshooting/) 
- [Troubleshooting · Cloudflare Support docs](https://developers.cloudflare.com/support/troubleshooting/)

## Related content

- [What is Azure Web Application Firewall on Azure Application Gateway?](/azure/web-application-firewall/ag/ag-overview)
- [Tutorial: Configure Cloudflare WAF with Azure AD B2C](/azure/active-directory-b2c/partner-cloudflare)
