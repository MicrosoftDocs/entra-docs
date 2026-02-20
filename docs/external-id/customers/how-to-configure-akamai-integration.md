---
title: Configure Akamai WAF with Microsoft Entra External ID
description: Learn how to configure Akamai Web Application Firewall (WAF) to protect against attacks for Microsoft Entra External ID tenants.
ms.topic: how-to
ms.date: 01/29/2026
ms.custom: it-pro

#CustomerIntent: As an IT administrator, I want to learn how to enable the Akamai Web Application Firewall (WAF) service for an external tenant with a Akamai WAF so that I can protect web applications from common exploits and vulnerabilities.

---
# Configure Akamai with Microsoft Entra External ID

[!INCLUDE [applies-to-external-only](../includes/applies-to-external-only.md)]

You can integrate third-party Web Application Firewall (WAF) solutions with Microsoft Entra External ID to improve overall security. A WAF helps protect your organization from attacks such as distributed denial of service (DDoS), malicious bots, and Open Worldwide Application Security Project [(OWASP) Top-10](https://owasp.org/www-project-top-ten/) security risks.

Akamai Web Application Firewall ([Akamai WAF](https://www.akamai.com/glossary/what-is-a-waf)) protects your web apps from common exploits and vulnerabilities. By integrating Akamai WAF with Microsoft Entra External ID, you add an extra layer of security for your applications.

This article provides step-by-step guidance to configure your external tenant with Akamai WAF.

## Solution overview

The solution uses three main components:

- **External tenant** – Acts as the identity provider (IdP) and authorization server, enforcing custom policies for authentication.
- **Azure Front Door (AFD)** – Handles custom domain routing and forwards traffic to Microsoft Entra External ID.
- **Akamai WAF** – The [Web Application Protector](https://www.akamai.com/us/en/resources/waf.jsp) firewall that manages traffic sent to the authorization server.

## Prerequisites

To get started, you need:

- An [external tenant](how-to-create-external-tenant-portal.md).
- A Microsoft [Azure Front Door (AFD)](/azure/frontdoor/front-door-overview) configuration. Traffic from the Akamai WAF routes to Azure Front Door, which then routes to the external tenant.
- An Akamai account. If you don't have one, go to the [Security Store](https://securitystore.microsoft.com/solutions/akamai-technologies.akamai_wapplusion_public) to create and purchase your account.
- An [Akamai WAF](https://www.akamai.com/glossary/what-is-a-waf) that manages traffic sent to the authorization server.
- A [custom domain](/entra/external-id/customers/how-to-custom-url-domain) in your external tenant that's enabled with Azure Front Door (AFD).

## Akamai setup steps

First, set up Akamai WAF to protect your custom URL domains for Microsoft Entra External ID. Follow these steps to configure Akamai WAF.

### Configure Akamai WAF

After you have a contract with Akamai, you can access the [portal](https://control.akamai.com/), which lets you manage all your Akamai WAF settings and more. To build your initial setup, you can choose between two options:

- The **Quick start wizard** provides a guided workflow to help you deploy the building blocks that protect traffic with WAF—recommended if you're new to Akamai. You can update these settings later to meet your requirements.
- The **Advanced mode** gives you granular control by configuring individual interfaces for detailed customization.

To explore all the capabilities of the Akamai WAF solution, see the [user guide](https://techdocs.akamai.com/app-api-protector/docs/welcome).

# [Quick start wizard](#tab/quick-start-wizard)

Akamai provides a **quick start wizard** to help you onboard new hostnames and protect them with its WAF solution, called [App & API Protector](https://www.akamai.com/products/app-and-api-protector).  

[Ion Standard](https://www.akamai.com/products/web-performance-optimization) is an extra solution that improves application performance and optimizes content delivery on the Akamai platform.  

To access the wizard, select **Get Started** > **App & API Protector + Ion Standard**. The initial screen displays the steps required to complete onboarding. Select **Start** to begin.  

For more information, see the steps in **Configure Akamai WAF** in the [Akamai documentation](https://techdocs.akamai.com/initial-aap-setup/docs/welcome).

# [Advanced mode](#tab/advanced-mode)

If you prefer an advanced approach, first create and configure a property in [Property Manager](https://control.akamai.com/apps/property-manager/). A property is a configuration file that tells Akamai edge servers how to handle and respond to incoming requests from your end users.

To learn more, see [What is a Property?](https://techdocs.akamai.com/start/docs/prop). To create and configure a property, follow these steps:

## Create and configure a property

1. Go to [Akamai Control Center](https://control.akamai.com/) to sign in.
1. Navigate to **Property Manager**.
1. For **Property version**, select **Standard** or **Enhanced TLS** (recommended).
1. For **Property hostnames**, add a property hostname for your custom domain.  
   Example: `login.domain.com`

> [!IMPORTANT]  
> Create or modify certificates with the correct custom domain name settings.  
> For details, see [Configure HTTPS hostnames](https://techdocs.akamai.com/property-mgr/docs/serve-content-over-https).

## Origin server property configuration settings

Use these settings for the origin server:

1. For **Origin type**, enter your origin type.
1. For **Origin server hostname**, enter your hostname.  
   Example: `yourafddomain.azurefd.net`
1. For **Forward host header**, select **Incoming Host Header**.
1. For **Cache key hostname**, select **Incoming Host Header**.

## Configure DNS

Create a Canonical Name (CNAME) record in your DNS, such as `login.domain.com`, that points to the Microsoft Edge hostname in the **Property hostname** field.

## Configure Akamai WAF

1. Go to [Akamai Control Center](https://control.akamai.com/) to sign in.
1. Navigate to **Security Configurations**.
1. To create a new security configuration, select **Protect existing property**.
1. Enter a configuration name in **Configuration Details**, then select **Create and activate the configuration on Production network**.
1. To get started with the security configuration, see https://techdocs.akamai.com/cloud-security/docs/app-api-protector.
1. In a subsequent security configuration version, change the action under **Web Application Firewall** for **Attack Group**, and set **Group Action** to **Deny**.

  :::image type="content" source="media\how-to-configure-akamai-integration\denied-attack-groups.png" alt-text=" 	Screenshot of denied attack groups, in the Group action column." :::

---

## Verify Akamai WAF in External ID

After completing the configuration steps, verify that Akamai WAF is protecting your external tenant by connecting the authentication credentials to the WAF configuration.

# [Microsoft Entra admin center](#tab/admin-center)

## WAF provider configuration

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Security Reader](/entra/identity/role-based-access-control/permissions-reference#security-reader).
1. If you have access to multiple tenants, use the **Settings** icon :::image type="icon" source="media/common/admin-center-settings-icon.png" border="false"::: in the top menu to switch to the external tenant you created earlier from the **Directories + subscriptions** menu.
1. Browse to **Entra ID** > **Security Store**.
1. Select the **Protect apps from DDoS with WAF** tile by selecting **Get started**.
1. Under **Choose a WAF Provider** select **Akamai** and then select **Next**.

   :::image type="content" source="media\how-to-configure-akamai-integration\choose-waf-provider.png" alt-text="Screenshot of the choose WAF provider page.":::

6. Create an Akamai account. If you don't have an account yet, create and purchase one in the [Security Store](https://securitystore.microsoft.com/solutions/akamai-technologies.akamai_wapplusion_public). 
7. To grant access to the Akamai API to perform actions, create [EdgeGrid authentication credentials](https://techdocs.akamai.com/developer/docs/set-up-authentication-credentials) and note all the generated information (`client_secret`, `host`, `access_token`, `client_token`). You reuse these values later in the setup process.

Additionally, update the **API restrictions** for the actions to the appropriate access level shown in the following table:

| Title | Description | Access level |
|----|----|----|
| [Microsoft Edge Diagnostics](https://developer.akamai.com/) | Microsoft Edge Diagnostics | READ-WRITE |
| [Property Manager (PAPI)](https://developer.akamai.com/api/luna/papi/overview.html) | Property Manager (PAPI). PAPI requires access to Microsoft Edge Hostnames. Edit your authorizations to add HAPI to your API Client. | READ-ONLY |

8. Return to the Microsoft Entra admin center to complete the setup.
9. Under **Configure Akamai WAF**, you can select an existing configuration or create a new one. If you're creating a new configuration, add the following information:
    - **Configuration name**: A name for the WAF configuration.
    - **Host prefix**: The host prefix from your Akamai EdgeGrid API credentials.
    - **Client secret**: The client secret from your Akamai EdgeGrid API credentials.
    - **Access token**: The access token from your Akamai EdgeGrid API credentials.
    - **Client token**: The client token from your Akamai EdgeGrid API credentials.

  :::image type="content" source=" media\how-to-configure-akamai-integration\configure-akamai-provider.png" alt-text="Screenshot of the configure WAF provider page.":::

10. Select **Next** to go to the next step.

## Domain verification

Select the custom URL domains that Azure Front Door (AFD) enables to verify and connect them to your Akamai WAF configuration. This step ensures that the selected domains are protected with advanced security features.

1. Select **Verify domain** to start the verification process.
1. Select the custom URL domains you want to protect with Akamai WAF and then select **Verify**.

 :::image type="content" source="media\how-to-configure-akamai-integration\verify-domain.png" alt-text="Screenshot of the verify domain page.":::

3. After verification, select **Done** to complete the process.

# [Microsoft Graph API](#tab/graph-api)

You can use the Microsoft Graph API through [Graph Explorer](https://developer.microsoft.com/en-us/graph/graph-explorer) to configure the Akamai WAF integration.

Make sure the caller has the [Security Reader](/entra/identity/role-based-access-control/permissions-reference#security-reader) role and has consented to the [RiskPreventionProviders.Read.All](/graph/permissions-reference#riskpreventionprovidersreadall) permission. 

  :::image type="content" source="media\how-to-configure-akamai-integration\consent-to-permissions.png" alt-text="Screenshot showing consent to permissions." :::

  :::image type="content" source="media\how-to-configure-akamai-integration\consent-button.png" alt-text="Screenshot showing the consent button." :::

This permission allows you to call `POST .../riskPrevention/webApplicationFirewallProviders` to create provider and then call `POST .../riskPrevention/webApplicationFirewallProviders/{webApplicationFirewallProviderId}/verify` to verify.

## Step 1: Create Akamai WAF provider with the API

Make sure that you have the API client you created in Akamai. To grant access to the Akamai API to perform actions, create [EdgeGrid authentication credentials](https://techdocs.akamai.com/developer/docs/set-up-authentication-credentials) and note all the generated information (`client_secret`, `host`, `access_token`, `client_token`).

Additionally, update the **API restrictions** for the actions to the appropriate access level shown in the following table:

| Title | Description | Access level |
|----|----|----|
| [Microsoft Edge Diagnostics](https://developer.akamai.com/) | Microsoft Edge Diagnostics | READ-WRITE |
| [Property Manager (PAPI)](https://developer.akamai.com/api/luna/papi/overview.html) | Property Manager (PAPI). PAPI requires access to Microsoft Edge Hostnames. Edit your authorizations to add HAPI to your API Client. | READ-ONLY |

This information is required so the backend can call Akamai on your behalf to pull and verify the WAF configuration.

### Request

The following example shows a request.
<!-- {
  "blockType": "request",
  "name": "create_webapplicationfirewallprovider_from_akamai"
}
-->
``` http
POST https://graph.microsoft.com/beta/identity/riskPrevention/webApplicationFirewallProviders
Content-Type: application/json
{
    "@odata.type": "#microsoft.graph.akamaiWebApplicationFirewallProvider",
    "displayName": "Akamai Provider Example",
    "hostPrefix": "akab-exampleprefix",
    "clientSecret": "akamai_example_secret_123",
    "clientToken": "akamai_example_token_456",
    "accessToken": "akamai_example_token_789"
}
```

### Response

The following example shows the response. The response object shown here might be shortened for readability.
<!-- {
  "blockType": "response",
  "truncated": true,
  "@odata.type": "microsoft.graph.webApplicationFirewallProvider"
}
-->
``` http
HTTP/1.1 201 Created
Content-Type: application/json
{
    "@odata.context": "https://graph.microsoft.com/beta/$metadata#identity/riskPrevention/webApplicationFirewallProviders/$entity",
    "@odata.type": "#microsoft.graph.akamaiWebApplicationFirewallProvider",
    "id": "00000000-0000-0000-0000-000000000002",
    "displayName": "Akamai Provider Example",
    "hostPrefix": "akab-exampleprefix"
}
```

## Step 2: Verify Akamai WAF provider with the API

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
}identity\authentication\tutorial-enable-cloud-sync-sspr-writeback
```

#### Response

The following example shows the response. The response object shown here might be shortened for readability.
<!-- {
  "blockType": "response",
  "truncated": true,
  "@odata.type": "microsoft.graph.webApplicationFirewallVerificationModel"
}
-->
```http
HTTP/1.1 200 OK
Content-Type: application/json
{
    "@odata.context": "https://graph.microsoft.com/v1.0/$metadata#microsoft.graph.webApplicationFirewallVerificationModel",
    "id": "00000000-0000-0000-0000-000000000000",
    "verifiedHost": "www.contoso.com",
    "providerType": "akamai",
    "verificationResult": {
        "status": "success",
        "verifiedOnDateTime": "2025-10-04T00:50:26.4909654Z",
        "errors": [],
        "warnings": []
    },
    "verifiedDetails": {
        "@odata.type": "#microsoft.graph.akamaiVerifiedDetailsModel",
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
                "name": "akamai Managed Ruleset",
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

## Troubleshooting

| **Scenario** | **Details** |
|--------------|-------------|
| Request blocked by Akamai WAF | When Akamai WAF blocks a request, it returns an Akamai reference code such as `18.6f64d440.1318965461.2f2b078`. You can debug this code by using the [Security Event Error Translator](https://control.akamai.com/apps/appsec-security-center/#/security-error-translator). |
| Other troubleshooting tools | Various tools are available for troubleshooting. Explore these tools [here](https://techdocs.akamai.com/edge-diagnostics/docs/tools-scenarios-descriptions). |

## Additional resources

- **Manage your security settings**  
  - The security configuration presets set WAF to **Alert only** mode. To actively mitigate threats with Akamai, change the **Action** to **Deny**.  
  - Akamai provides comprehensive security protections. Learn more [here](https://techdocs.akamai.com/app-api-protector/docs/about-protections).  
  - At a minimum:  
    - Change DoS Protection for the three Rate Limiting policies to **Deny** after verifying thresholds for your traffic.  
    - Change the Group Action for Command Injection, Cross-Site Scripting, Local File Inclusion, Remote File Inclusion, SQL Injection, Web Attack Tool, Web Platform Attack, and Web Protocol Attack to **Deny**.

- **Manage delivery and performance settings**  
  - Explore useful information to get familiar with Akamai [here](https://techdocs.akamai.com/property-mgr/docs/know-your-around).

- **View flagged requests**  
  - View requests flagged (alerted or denied) by Akamai WAF in [Web Security Analytics](https://techdocs.akamai.com/security-ctr/docs/web-security-analytics-ov-new).  
  - Watch [short videos](https://techdocs.akamai.com/initial-aap-setup/docs/video-tutorials) to accelerate your journey.
