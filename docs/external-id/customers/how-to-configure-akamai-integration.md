---
title: Configure Akamai WAF with Microsoft Entra External ID
description: Learn how to configure Akamai Web Application Firewall (WAF) to protect against attacks for Microsoft Entra External ID tenants.
author: csmulligan
manager: dougeby
ms.service: entra-external-id
ms.subservice: external
ms.topic: how-to
ms.date: 10/21/2025
ms.author: cmulligan
ms.custom: it-pro

#CustomerIntent: As an IT administrator, I want to learn how to enable the Akamai Web Application Firewall (WAF) service for an external tenant with a Akamai WAF so that I can protect web applications from common exploits and vulnerabilities.

---
# Configure Akamai WAF with Microsoft Entra External ID

[!INCLUDE [applies-to-external-only](../includes/applies-to-external-only.md)]

You can integrate third-party Web Application Firewall (WAF) solutions with Microsoft Entra External ID to improve overall security. A WAF helps protect your organization from attacks such as distributed denial of service (DDoS), malicious bots, and Open Worldwide Application Security Project [(OWASP) Top-10](https://owasp.org/www-project-top-ten/) security risks.

Akamai Web Application Firewall ([Akamai WAF](https://www.akamai.com/glossary/what-is-a-waf)) protects your web apps from common exploits and vulnerabilities. By integrating Akamai WAF with Microsoft Entra External ID, you add an extra layer of security for your applications.

This article provides step-by-step guidance for configuring your external tenant with Akamai for Web Application Firewall (WAF) settings.

## Solution overview

The solution uses three main components:

- **External tenant** – Acts as the identity provider (IdP) and authorization server, enforcing custom policies for authentication.
- **Azure Front Door (AFD)** – Handles custom domain routing and forwards traffic to Microsoft Entra External ID.
- **Akamai account** – The account used to manage Akamai services. You can create an [Akamai account](https://akamai.com/) on the Cloud Computing Services page.
- **Akamai WAF** – The [Web Application Protector](https://www.akamai.com/us/en/resources/waf.jsp) firewall that manages traffic sent to the authorization server.

## Prerequisites

To get started, you need:

- An [external tenant](how-to-create-external-tenant-portal.md).
- A Microsoft [Azure Front Door (AFD)](/azure/frontdoor/front-door-overview) configuration. Traffic from the Akamai WAF routes to Azure Front Door, which then routes to the external tenant.
- An [Akamai Web Application Firewall (WAF)](https://www.akamai.com/glossary/what-is-a-waf) that manages traffic sent to the authorization server.
- A [custom domain](/entra/external-id/customers/how-to-custom-url-domain) in your external tenant that’s enabled with Azure Front Door (AFD).

## Setup steps

To configure Akamai WAF with Microsoft Entra External ID, complete the following steps:

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

If you prefer an advanced approach, first create and configure a property in [Property Manager](https://control.akamai.com/apps/property-manager/). A property is a configuration file that tells our edge servers how to handle and respond to incoming requests from your end users.

To learn more, see [What is a Property?](https://techdocs.akamai.com/start/docs/prop). To create and configure a property, follow these steps:

## Create and configure a property

1. Go to [Akamai Control Center](https://control.akamai.com/) to sign in.
2. Navigate to **Property Manager**.
3. For **Property version**, select **Standard** or **Enhanced TLS** (recommended).
4. For **Property hostnames**, add a property hostname for your custom domain.  
   Example: `login.domain.com`

> [!IMPORTANT]  
> Create or modify certificates with the correct custom domain name settings.  
> For details, see [Configure HTTPS hostnames](https://techdocs.akamai.com/property-mgr/docs/serve-content-over-https).

## Origin server property configuration settings

Use these settings for the origin server:

1. For **Origin type**, enter your origin type.
2. For **Origin server hostname**, enter your hostname.  
   Example: `yourafddomain.azurefd.net`
3. For **Forward host header**, select **Incoming Host Header**.
4. For **Cache key hostname**, select **Incoming Host Header**.

## Configure DNS

Create a Canonical Name (CNAME) record in your DNS, such as `login.domain.com`, that points to the Microsoft Edge hostname in the **Property hostname** field.

## Configure Akamai Web Application Firewall

1. Go to [Akamai Control Center](https://control.akamai.com/) to sign in.
2. Navigate to **Security Configurations**.
3. To create a new security configuration, select **Protect existing property**.
4. Enter a configuration name in **Configuration Details**, then select **Create and activate the configuration on Production network**.
5. To get started with the security configuration, see https://techdocs.akamai.com/cloud-security/docs/app-api-protector.
6. In a subsequent security configuration version, change the action under **Web Application Firewall** for **Attack Group**, and set **Group Action** to **Deny**.

  :::image type="content" source="media\how-to-configure-akamai-integration\denied-attack-groups.png" alt-text=" 	Screenshot of denied attack groups, in the Group action column." :::

---

### Grant access to the Akamai API to perform actions

Create [EdgeGrid authentication credentials](https://techdocs.akamai.com/developer/docs/set-up-authentication-credentials) and note all the generated information (`client_secret`, `host`, `access_token`, `client_token`). You reuse these values in **Step 3**.

Additionally, update the **API restrictions** for the actions to the appropriate access level shown in the following table:

| Title | Description | Access level |
|----|----|----|
| [Microsoft Edge Diagnostics](https://developer.akamai.com/) | Microsoft Edge Diagnostics | READ-WRITE |
| [Property Manager (PAPI)](https://developer.akamai.com/api/luna/papi/overview.html) | Property Manager (PAPI). PAPI requires access to Microsoft Edge Hostnames. Edit your authorizations to add HAPI to your API Client. | READ-ONLY |

## Verification steps

After completing the configuration steps, verify that Akamai WAF is protecting your external tenant by connecting the authentication credentials to the WAF configuration.

### Connect authentication credentials to the WAF configuration

You can connect the AuthCredentials to pull and verify the WAF configuration for your domain. For WAF verification, use the Microsoft Graph API endpoint. You can call this endpoint through [Graph Explorer](https://developer.microsoft.com/en-us/graph/graph-explorer) or any REST client.

- Make sure the caller has the [Security Reader](/entra/identity/role-based-access-control/permissions-reference#security-reader) role and has consented to the [RiskPreventionProviders.Read.All](/graph/permissions-reference#riskpreventionprovidersreadall) permission. See more details about the RiskPreventionProviders.Read.All permission in the [next section](/entra/external-id/customers/how-to-configure-akamai-integration#risk-prevention-provider-permission-details).

  :::image type="content" source="media\how-to-configure-akamai-integration\consent-to-permissions.png" alt-text="Screenshot showing consent to permissions." :::

  :::image type="content" source="media\how-to-configure-akamai-integration\consent-button.png" alt-text="Screenshot showing the consent button." :::

- The verification Graph API endpoint requires the **API token** that you created in the previous step. The backend uses this token to call Akamai on your behalf to retrieve and verify the WAF configuration.
  - The token is treated like any client secret and is never stored or logged in plain text or without encryption.
- The verification process checks that a DNS record is correctly configured and validates whether the recommended managed rulesets are enabled.
- The API returns detailed error codes to help you identify configuration issues and provides actionable recommendations.

#### Risk prevention provider permission details

The following permission allows the app to read your organization's risk prevention providers without a signed-in user.

| **Permission**  | **Description**  | **Endpoint**  |
|----|----|----|
| RiskPreventionProviders.Read.All  | Allows reading  Web Application Firewall information.  | POST /riskPrevention/webApplicationFirewalls/Verify  |

#### Sample request and response

To connect Akamai WAF with Microsoft Entra External ID, use the following example request and response.

Sample request:

```http
POST https://graph.microsoft.com/v1.0/directory/customSecurityAttributeDefinitions
{
    "hostName": "contoso.marketing.com"
   	"connection": {
        "@odata.type": "#microsoft.graph.akamaiConnection",
        "HostPrefix": "hostprefixvalue",
        "ClientSecret": "clientsecretvalue",
        "ClientToken": "clienttokenvalue",
        "AccessToken": "accesstokenvalue"
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
    "status": "Success",
    "verifiedOnDateTime": "2024-11-09 06:00:00Z",
    "errors": [],
    "warnings": []
  },
  "verifiedDetails": {
    "odata.type": "#microsoft.graph.akamaiVerifiedDetailsModel",
    "dnsConfiguration": {
      "name": "contoso.marketing.com",
      "isProxied": true,
      "recordType": "CNAME",
      "value": "login-abc1defghijkl2mn.o01.azurefd.net",
      "isDomainVerified": true
    }
  }
}
```

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