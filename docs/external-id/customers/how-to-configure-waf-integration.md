---
title: Configure Cloudflare WAF with Microsoft Entra External ID
description: Learn how to configure Cloudflare Web Application Firewall (WAF) to protect against attacks.
ms.topic: how-to
ms.date: 11/04/2025
ms.custom: it-pro

#CustomerIntent: As an IT administrator, I want to learn how to enable the Cloudflare Web Application Firewall (WAF) service for a Microsoft Entra External ID tenant with a Cloudflare WAF so that I can protect web applications from common exploits and vulnerabilities.
---
# Configure Cloudflare with Microsoft Entra External ID

[!INCLUDE [applies-to-external-only](../includes/applies-to-external-only.md)]

You can integrate third-party Web Application Firewall (WAF) solutions with Microsoft Entra External ID to improve overall security. A WAF helps protect your organization from attacks such as distributed denial of service (DDoS), malicious bots, and Open Worldwide Application Security Project [(OWASP) Top-10](https://owasp.org/www-project-top-ten/) security risks.

Cloudflare Web Application Firewall ([Cloudflare WAF](https://www.cloudflare.com/application-services/products/waf/)) protects your web apps from common exploits and vulnerabilities. By integrating Cloudflare WAF with Microsoft Entra External ID, you add an extra layer of security for your applications.

This article provides step-by-step guidance to configure your external tenant with Cloudflare WAF.

## Solution overview

The solution uses three main components:

- **External tenant** – Acts as the identity provider (IdP) and authorization server, enforcing custom policies for authentication.
- **Azure Front Door (AFD)** – Handles custom domain routing and forwards traffic to Microsoft Entra External ID.
- **Cloudflare WAF** – The WAF that manages traffic sent to the authorization server.

## Prerequisites

To get started, you need:

- An [external tenant](how-to-create-external-tenant-portal.md).
- A Microsoft [Azure Front Door (AFD)](/azure/frontdoor/front-door-overview) configuration. Traffic from the Cloudflare WAF routes to Azure Front Door, which then routes to the external tenant.
- A [Cloudflare WAF](https://www.cloudflare.com/application-services/products/waf/) that manages traffic sent to the authorization server.
- A [custom domain](/entra/external-id/customers/how-to-custom-url-domain) in your external tenant that’s enabled with Azure Front Door (AFD).

Learn about tenants and securing apps for consumers and customers with [Microsoft Entra External ID](../external-identities-overview.md).

## Cloudflare setup steps

First, set up Cloudflare WAF to protect your custom URL domains for Microsoft Entra External ID. Follow these steps to configure Cloudflare WAF.

### Enable custom URL domains

The first step is to enable custom domains with AFD. Use the instructions in [Enable custom URL domains for apps in external tenants](../customers/how-to-custom-url-domain.md). 

### Create a Cloudflare account

1. Go to [Cloudflare.com/plans](https://www.cloudflare.com/plans/) to create an account. 
1. To enable WAF, on the **Application Services** tab, select **Pro**. 

### Configure the domain name server (DNS)

Enable WAF for a domain.

1. In the DNS console, for CNAME, enable the proxy setting.

   :::image type="content" source="media/how-to-configure-cloudflare-integration/proxy-settings.png" alt-text="Screenshot of CNAME options." lightbox="media/how-to-configure-cloudflare-integration/proxy-settings-expanded.png":::

1. Under DNS, for **Proxy status**, select **Proxied**.
1. The status turns orange.

   :::image type="content" source="media/how-to-configure-cloudflare-integration/proxied-status.png" alt-text="Screenshot of proxied status." lightbox="media/how-to-configure-cloudflare-integration/proxied-status-expanded.png":::

> [!NOTE]
> Azure Front Door-managed certificates aren't automatically renewed if your custom domain’s CNAME record points to a DNS record other than the Azure Front Door endpoint’s domain (for example, when using a third-party DNS service like Cloudflare). To renew the certificate in such cases, follow the instructions in the [Renew Azure Front Door-managed certificates](/azure/frontdoor/domain#renew-azure-front-door-managed-certificates) article.

### Cloudflare security controls

For optimal protection, enable Cloudflare security controls. 

### DDoS protection

1. Go to the [Cloudflare dashboard](https://developers.cloudflare.com/workers/get-started/dashboard/).
1. Expand the Security section.
1. Select **DDoS**.
1. A message appears. 

  :::image type="content" source="media/how-to-configure-cloudflare-integration/bot-protection.png" alt-text="Screenshot of bot protection options.":::

### Bot protection

1. Go to the [Cloudflare dashboard](https://developers.cloudflare.com/workers/get-started/dashboard/).
1. Expand the Security section.
1. Under **Configure Super Bot Fight Mode**, for **Definitely automated**, select **Block**.
1. For **Likely automated**, select **Managed Challenge**.
1. For **Verified bots**, select **Allow**.

  :::image type="content" source="media/how-to-configure-cloudflare-integration/bot-protection.png" alt-text="Screenshot of bot protection options.":::

### Firewall rules: Traffic from the Tor network

Block traffic that originates from the Tor proxy network, unless your organization needs to support the traffic. 

   > [!NOTE]
   > If you can't block Tor traffic, select **Interactive Challenge**, not **Block**.

### Block traffic from the Tor network

1. Go to the [Cloudflare dashboard](https://developers.cloudflare.com/workers/get-started/dashboard/). 
1. Expand the Security section.
1. Select **WAF**.
1. Select **Create rule**.
1. For **Rule name**, enter a relevant name.
1. For **If incoming requests match**, for **Field**, select **Continent**.
1. For **Operator**, select **equals**.
1. For **Value**, select **Tor**.
1. For **Then take action**, select **Block**.
1. For **Place at**, select **First**.
1. Select **Deploy**.

  :::image type="content" source="media/how-to-configure-cloudflare-integration/create-rule.png" alt-text="Screenshot of the create rule dialog.":::

  > [!NOTE]
  > You can add custom HTML pages for visitors.

### Firewall rules: Traffic from countries or regions

We recommend strict security controls on traffic from countries or regions where business is unlikely to occur, unless your organization has a business reason to support traffic from all countries or regions.  

  > [!NOTE]
  > If you can't block traffic from a country or region, select **Interactive Challenge**, not **Block**.

### Block traffic from countries or regions

For the following instructions, you can add custom HTML pages for visitors. 

1. Go to the [Cloudflare dashboard](https://developers.cloudflare.com/workers/get-started/dashboard/). 
1. Expand the Security section.
1. Select **WAF**.
1. Select **Create rule**.
1. For **Rule name**, enter a relevant name.
1. For **If incoming requests match**, for **Field**, select **Country/Region** or **Continent**.
1. For **Operator**, select **equals**.
1. For **Value**, select the country/region or continent to block.
1. For **Then take action**, select **Block**.
1. For **Place at**, select **Last**.
1. Select **Deploy**.

  :::image type="content" source="media/how-to-configure-cloudflare-integration/create-rule-name.png" alt-text="Screenshot of the name field on the create rule dialog.":::

### OWASP and managed rulesets

1. Select **Managed rules**.
1. For **Cloudflare Managed Ruleset**, select **Enabled**.
1. For **Cloudflare OWASP Core Ruleset**, select **Enabled**.

  :::image type="content" source="media/how-to-configure-cloudflare-integration/rulesets.png" alt-text="Screenshot of rule sets." lightbox="media/how-to-configure-cloudflare-integration/ruleset-expanded.png":::

## Verify Cloudflare WAF in External ID

After you set up your Cloudflare account, connect it to Microsoft Entra External ID. Use your Cloudflare [API token](https://developers.cloudflare.com/fundamentals/api/get-started/create-token/) and [Zone ID](https://developers.cloudflare.com/fundamentals/account/find-account-and-zone-ids/#copy-your-zone-id) to complete the connection. You can do this in the admin center or by using Microsoft Graph API.

# [Microsoft Entra admin center](#tab/admin-center)

## WAF provider configuration

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Security Reader](/entra/identity/role-based-access-control/permissions-reference#security-reader).
1. If you have access to multiple tenants, use the **Settings** icon :::image type="icon" source="media/common/admin-center-settings-icon.png" border="false"::: in the top menu to switch to the external tenant you created earlier from the **Directories + subscriptions** menu.
1. Browse to **Entra ID** > **Security Store**.
1. Select the **Protect apps from DDoS with WAF** tile by selecting **Get started**.
1. Under **Choose a WAF Provider** select **Cloudflare** and then select **Next**.

   :::image type="content" source="media/how-to-configure-cloudflare-integration/choose-waf.png" alt-text="Screenshot of the choose WAF provider page.":::

1. Under **Configure Cloudflare WAF**, you can select an existing configuration or create a new one. If you're creating a new configuration, add the following information:
    - **Configuration name**: A name for the WAF configuration.
    - **API token**: The API token from your Cloudflare dashboard.
    - **Zone ID**: The Zone ID for your domain, from your Cloudflare dashboard.

   :::image type="content" source=" media/how-to-configure-cloudflare-integration/configure-waf-provider.png" alt-text="Screenshot of the configure WAF provider page.":::

1. Select **Next** to save your changes.

## Domain verification

Select the custom URL domains that Azure Front Door (AFD) enables to verify and connect them to your Cloudflare WAF configuration. This step ensures that the selected domains are protected with advanced security features.

1. Select **Verify domain** to start the verification process.
1. Select the custom URL domains you want to protect with Cloudflare WAF and then select **Verify**.

   :::image type="content" source=" media/how-to-configure-cloudflare-integration/verify-domain.png" alt-text="Screenshot of the verify domain page.":::

1. After verification, select **Done**.

# [Microsoft Graph API](#tab/graph-api)

You can use the Microsoft Graph API through [Graph Explorer](https://developer.microsoft.com/en-us/graph/graph-explorer) to configure the Cloudflare WAF integration.

Make sure the caller has the [Security Reader](/entra/identity/role-based-access-control/permissions-reference#security-reader) role and has consented to the [RiskPreventionProviders.Read.All](/graph/permissions-reference#riskpreventionprovidersreadall) permission.

  :::image type="content" source="media\how-to-configure-cloudflare-integration\consent-to-permissions.png" alt-text="Screenshot showing consent to permissions." :::

  :::image type="content" source="media\how-to-configure-cloudflare-integration\consent-button.png" alt-text="Screenshot showing the consent button." :::

This permission allows you to call `POST .../riskPrevention/webApplicationFirewallProviders` to create provider and then call `POST .../riskPrevention/webApplicationFirewallProviders/{webApplicationFirewallProviderId}/verify` to verify.

## Step 1: Create Cloudflare WAF provider with the API

Make sure that you have the **API token** you created in Cloudflare and the **Zone ID** for your domain. This information is required so the backend can call Cloudflare on your behalf to pull and verify the WAF configuration.

### Request

The following example shows a request to create a new Cloudflare WAF object.
<!-- {
  "blockType": "request",
  "name": "create_webapplicationfirewallprovider_from_cloudflare"
}
-->
``` http
POST https://graph.microsoft.com/beta/identity/riskPrevention/webApplicationFirewallProviders
Content-Type: application/json
{
    "@odata.type": "#microsoft.graph.cloudFlareWebApplicationFirewallProvider",
    "displayName": "Cloudflare Provider Example",
    "zoneId": "11111111111111111111111111111111",
    "apiToken": "cf_example_token_123"
}
```

### Response

The following example shows the response with Cloudflare WAF object.

``` http
HTTP/1.1 201 Created
Content-Type: application/json
{
    "@odata.context": "https://graph.microsoft.com/beta/$metadata#identity/riskPrevention/webApplicationFirewallProviders/$entity",
    "@odata.type": "#microsoft.graph.cloudFlareWebApplicationFirewallProvider",
    "id": "00000000-0000-0000-0000-000000000001",
    "displayName": "Cloudflare Provider Example",
    "zoneId": "11111111111111111111111111111111"
}
```

## Step 2: Verify Cloudflare WAF provider with the API

The following example shows how to verify a domain via `webApplicationFirewallProvider` using the `hostName`.

#### Request

The following example shows a request.
<!-- {
  "blockType": "request",
  "name": "webapplicationfirewallproviderthis.verify"
}
-->
``` http
POST https://graph.microsoft.com/v1.0/identity/riskPrevention/webApplicationFirewallProviders/{webApplicationFirewallProviderId}/verify
Content-Type: application/json
{
  "hostName": "www.contoso.com"
}
```

#### Response

The following example shows the response.

```http
HTTP/1.1 200 OK
Content-Type: application/json
{
    "@odata.context": "https://graph.microsoft.com/v1.0/$metadata#microsoft.graph.webApplicationFirewallVerificationModel",
    "id": "00000000-0000-0000-0000-000000000000",
    "verifiedHost": "www.contoso.com",
    "providerType": "cloudflare",
    "verificationResult": {
        "status": "success",
        "verifiedOnDateTime": "2025-10-04T00:50:26.4909654Z",
        "errors": [],
        "warnings": []
    },
    "verifiedDetails": {
        "@odata.type": "#microsoft.graph.cloudFlareVerifiedDetailsModel",
        "zoneId": "11111111111111111111111111111111",
        "dnsConfiguration": {
            "name": "www.contoso.com",
            "isProxied": true,
            "recordType": "cname",
            "value": "contoso.azurefd.net",
            "isDomainVerified": true
        },
        "enabledRecommendedRulesets": [
            {
                "rulesetId": "22222222222222222222222222222222",
                "name": "CloudFlare Managed Ruleset",
                "phaseName": "http_request_firewall_managed"
            }
        ],
        "enabledCustomRules": [
            {
                "ruleId": "33333333333333333333333333333333",
                "name": "Block SQL Injection",
                "action": "block"
            },
            {
                "ruleId": "44444444444444444444444444444444",
                "name": "Block XSS",
                "action": "block"
            }
        ]
    }
}
```

---

> [!NOTE]
> CRUD (Create, Read, Update, Delete) operations on providers’ verification details may experience delays of up to 15 minutes. If you delete a domain, verification might take up to 15 minutes before you can add it back.

### Test the configuration

After you connect Cloudflare WAF with Microsoft Entra External ID, test the configuration to make sure everything works as expected.

:::image type="content" source="media\how-to-configure-cloudflare-integration\configuration-test.png" alt-text="Screenshot showing configuration test results.":::

## Troubleshooting

The following table lists common issues you might encounter when integrating Cloudflare WAF with Microsoft Entra External ID, along with their details and resolutions.

| **Issue** | **Details** | **Resolution** |
|-----------|-------------|-----------------|
| Bad Request Response | "The provided API Key has insufficient permissions. Please reauthenticate and try again.\r\n CloudFlare Request ID: {CF-Ray-value}\r\nCorrelation ID: random-id-entry-value\r\nTimestamp: 2024-08-25 21:32:40Z" | Check the permission level mentioned in the preceding steps. |
| Couldn't reach the external tenant's well-known endpoint | "Could not reach the tenant's well-known endpoint via custom domain. Please check that your custom domain is properly configured to route traffic."<br>At the Graph level, you might see **HTTP 200 OK** with status **failure** when Cloudflare returns error code **403**. This check is performed on our side before any API calls to Cloudflare. | Disable the captcha on the Cloudflare portal (change the wildcard to disable), then rerun the POST request. |

## Additional resources

- Cloudflare WAF [Get started guide](https://developers.cloudflare.com/waf/get-started/): Includes recommendations on how to best configure WAF and what basic protection and rules you can deploy. 
- FAQ related to [External Tenant Overview - Microsoft Entra External ID | Microsoft Learn](/entra/external-id/customers/overview-customers-ciam) for other best practices and considerations. 
- Check traffic results in the Cloudflare dashboard: [Security Analytics · Cloudflare WAF docs](https://developers.cloudflare.com/waf/analytics/security-analytics/)
- Azure Front Door additional best practices [Domains in Azure Front Door | Microsoft Learn](/azure/frontdoor/domain)
- [API Troubleshooting · Cloudflare Fundamentals docs](https://developers.cloudflare.com/fundamentals/api/troubleshooting/) 
- [Troubleshooting · Cloudflare Support docs](https://developers.cloudflare.com/support/troubleshooting/)

## Related content

- [What is Azure Web Application Firewall on Azure Application Gateway?](/azure/web-application-firewall/ag/ag-overview)
- [Tutorial: Configure Cloudflare WAF with Azure AD B2C](/azure/active-directory-b2c/partner-cloudflare)
