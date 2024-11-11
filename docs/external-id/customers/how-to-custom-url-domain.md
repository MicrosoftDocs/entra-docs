---
title: How to enable custom URL domains for External ID
description: Learn how to set up custom URL domains to personalize the authentication sign-in endpoints for the external customers and consumers of your app.
 
author: msmimart
manager: celestedg
ms.service: entra-external-id
 
ms.subservice: external
ms.topic: how-to
ms.date: 05/21/2024
ms.author: mimart
ms.custom: it-pro

#Customer intent: As a dev, devops, or it admin, I want to learn how to personalize my application’s sign-in endpoints with my own branding or naming instead of Microsoft’s default domain name by using a custom URL domain.
---

# Enable custom URL domains for apps in external tenants (Preview)

[!INCLUDE [applies-to-external-only](../includes/applies-to-external-only.md)]

This article describes how to enable [custom URL domains](concept-custom-url-domain.md) for Microsoft Entra External ID applications in external tenants. A custom URL domain allows you to brand your application’s sign-in endpoints with your own custom URL domain instead of Microsoft’s default domain name.

[!INCLUDE [preview alert](includes/preview-alert/preview-alert-ciam.md)]

## Prerequisites

- [Learn how custom URL domains work](concept-custom-url-domain.md) in External ID.
- If you haven't already created an external tenant, [create one now](how-to-create-external-tenant-portal.md).
- [Create a user flow](how-to-user-flow-sign-up-sign-in-customers.md) so users can sign up and sign in to your application.
- [Register a web application](how-to-register-ciam-app.md).

## Step 1: Add a custom domain name to your tenant

When you create an external tenant, it comes with an initial domain name, &lt;domainname&gt;.onmicrosoft.com. You can't change or delete the initial domain name, but you can add your own custom domain name. For these steps, be sure to sign in to your *external* tenant configuration in the Microsoft Entra admin center.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Domain Name Administrator](~/identity/role-based-access-control/permissions-reference.md#domain-name-administrator).
1. Choose your *external* tenant: Select the **Settings** icon in the top menu, and then switch to your external tenant.
1. Navigate to **Identity** > **Settings** > **Domain names** > **Custom domain names**.

1. [Add your custom domain name](~/fundamentals/add-custom-domain.yml#add-your-custom-domain-name) to Microsoft Entra ID.

1. [Add your DNS information to the domain registrar](~/fundamentals/add-custom-domain.yml#add-your-dns-information-to-the-domain-registrar). After you add your custom domain name to your tenant, create a DNS `TXT` or `MX` record for your domain. Creating this DNS record for your domain verifies ownership of your domain name.

   The following are examples of TXT records for *login.contoso.com* and *account.contoso.com*:

   |Name (hostname)  |Type  |Data       |
   |---------|---------|----------------|
   |login    | TXT     | MS=ms12345678  |
   |account  | TXT     | MS=ms87654321  |

   The TXT record must be associated with the subdomain or hostname of the domain (for example, the *login* part of the *contoso.com* domain). If the hostname is empty or `@`, Microsoft Entra ID can't verify the custom domain name you added.

   > [!TIP]
   > You can manage your custom domain name with any publicly available DNS service, such as GoDaddy. If you don't have a DNS server, you can use  [Azure DNS zone](/azure/dns/dns-getstarted-portal), or [App Service domains](/azure/app-service/manage-custom-dns-buy-domain).

1. [Verify your custom domain name](~/fundamentals/add-custom-domain.yml#verify-your-custom-domain-name). Verify each subdomain or hostname you plan to use. For example, to be able to sign in with *login.contoso.com* and *account.contoso.com*, you need to verify both subdomains and not just the top-level domain *contoso.com*.

   > [!IMPORTANT]
   > After the domain is verified, delete the DNS TXT record you created.

## Step 2: Associate the custom domain name with a custom URL domain

After you add and verify the custom domain name in your external tenant, associate the custom domain name with a custom URL domain.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com).
1. Choose your *external* tenant: Select the **Settings** icon in the top menu, and then switch to your external tenant.
1. Navigate to **Identity** > **Settings** > **Domain names** > **Custom URL domains (Preview)**.
1. Select **Add custom url domain**.
1. In the **Add custom url domain** pane, select the custom domain name you entered in [Step 1](#step-1-add-a-custom-domain-name-to-your-tenant).

   :::image type="content" source="./media/how-to-custom-url-domain/add-custom-url-domain.png" alt-text="Screenshot showing the Add custom URL domain pane." lightbox="./media/how-to-custom-url-domain/add-custom-url-domain.png":::

2. Select **Add**.

## Step 3: Create a new Azure Front Door instance

Follow these steps to create an Azure Front Door:

1. Sign in to the [Azure portal](https://portal.azure.com).

1. Choose the tenant containing your Azure Front Door subscription: Select the **Settings** icon in the top menu, and then switch to the tenant that contains your Azure Front Door subscription.
1. Follow the steps in [Create Front Door profile - Quick Create](/azure/frontdoor/create-front-door-portal#create-front-door-profile---quick-create) to create a Front Door for your tenant using the following settings. Leave the **Caching** and **WAF policy** settings empty.

    |Key      |Value    |
    |---------|---------|
    |Subscription|Select your Azure subscription.|
    |Resource group| Select an existing resource group, or create a new one.|
    |Name| Give your profile a name such as `ciamazurefrontdoor`.|
    |Tier| Select either Standard or Premium tier. Standard tier is content delivery optimized. Premium tier builds on Standard tier and is focused on security. See [Tier Comparison](/azure/frontdoor/standard-premium/tier-comparison).|
    |Endpoint name| Enter a globally unique name for your endpoint, such as `ciamazurefrontdoor`. The **Endpoint hostname** is generated automatically. |
    |Origin type| Select `Custom`.|
    |Origin host name| Enter `<tenant-name>.ciamlogin.com`. Replace `<tenant-name>` with the name of your tenant, for example `contoso.ciamlogin.com`.|

1. Once the Azure Front Door resource is created, select **Overview**, and copy the **Endpoint hostname** for use in a later step. It looks something like `ciamazurefrontdoor-ab123e.z01.azurefd.net`.

1. Make sure the **Host name** and **Origin host header** of your origin have the same value:
    1. Under **Settings**, select **Origin groups**.
    1. Select your origin group from the list, such as **default-origin-group**.
    1. On the right pane, select your **Origin host name** such as `contoso.ciamlogin.com`.
    1. On the **Update origin** pane, update the **Host name** and **Origin host header** to have the same value.

   :::image type="content" source="./media/how-to-custom-url-domain/front-door-update-origin-page.png" alt-text="Screenshot showing the host name and origin host header fields.":::

## Step 4: Set up your custom URL domain on Azure Front Door

In this step, you add the custom URL domain you registered in [Step 1](#step-1-add-a-custom-domain-name-to-your-tenant) to your Azure Front Door.

### 4.1. Create a CNAME DNS record

To add the custom URL domain, create a canonical name (CNAME) record with your domain provider. A CNAME record is a type of DNS record that maps a source domain name to a destination domain name (alias). For Azure Front Door, the source domain name is your custom URL domain name, and the destination domain name is your Front Door default hostname that you configured in Step 2, for example, `ciamazurefrontdoor-ab123e.z01.azurefd.net`.

After Front Door verifies the CNAME record that you created, traffic addressed to the source custom URL domain (such as `login.contoso.com`) is routed to the specified destination Front Door default frontend host, such as `contoso-frontend.azurefd.net`. For more information, see [add a custom domain to your Front Door](/azure/frontdoor/front-door-custom-domain).

To create a CNAME record for your custom domain:

1. Sign in to the web site of the domain provider for your custom domain.

1. Find the page for managing DNS records by consulting the provider's documentation or searching for areas of the web site labeled **Domain Name**, **DNS**, or **Name Server Management**.

1. Create a CNAME record entry for your custom URL domain and complete the fields as shown in the following table.

    | Source          | Type  | Destination           |
    |-----------------|-------|-----------------------|
    | `<login.contoso.com>` | CNAME | `contoso-frontend.azurefd.net` |

   - Source: Enter your custom URL domain (for example, login.contoso.com).

   - Type: Enter *CNAME*.

   - Destination: Enter the default Front Door frontend host you create in [Step 2](#step-2-associate-the-custom-domain-name-with-a-custom-url-domain). It must be in the following format: *&lt;hostname&gt;*.azurefd.net, for example, `contoso-frontend.azurefd.net`.

1. Save your changes.

### 4.2. Associate the custom URL domain with your Front Door

1. In the Azure portal home, search for and select the `ciamazurefrontdoor` Azure Front Door resource to open it.

1. In the left menu, under **Settings**, select **Domains**.

1. Select **Add a domain**.

1. For **DNS management**, select **All other DNS services**.

1. For **Custom domain**, enter your custom domain, such as `login.contoso.com`.

1. Keep the other values as defaults, and then select **Add**. Your custom domain is added to the list.

1. Under **Validation state** of the domain that you just added, select **Pending**. A pane with a TXT record info opens.

    1. Sign in to the web site of the domain provider for your custom domain.

    1. Find the page for managing DNS records by consulting the provider's documentation or searching for areas of the web site labeled **Domain Name**, **DNS**, or **Name Server Management**.

    1. Create a new TXT DNS record and complete the following fields:
        - **Name**: Enter just subdomain portion of `_dnsauth.contoso.com`, for example `_dnsauth`
        - **Type**: `TXT`
        - **Value**: For example, `75abc123t48y2qrtsz2bvk......`

        After you add the TXT DNS record, the **Validation state** in the Front Door resource will eventually change from **Pending** to **Approved**. You might need to refresh the page to see the change.

1. In the Azure portal. Under **Endpoint association** of the domain that you just added, select **Unassociated**.

1. For **Select endpoint**, select the hostname endpoint from the dropdown.

1. For **Select routes** list, select **default-route**, and then select **Associate**.

### 4.3. Enable the route

The **default-route** routes the traffic from the client to Azure Front Door. Then, Azure Front Door uses your configuration to send the traffic to the external tenant. To enable the default-route, follow these steps.

1. Select **Front Door manager**.

1. To enable the **default-route**, first expand an endpoint from the list of endpoints in the Front Door manager. Then, select the **default-route**.

1. Select the **Enabled route** checkbox.

1. Select **Update** to save the changes.

## Test your custom URL domains

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com).

1. Choose your *external* tenant: Select the **Settings** icon in the top menu, and then switch to your external tenant.

1. Under **External Identities**, select **User flows**.

1. Select a user flow, and then select **Run user flow**.

1. For **Application**, select the web application named *webapp1* that you previously registered. The **Reply URL** should show `https://jwt.ms`.

1. Copy the URL under **Run user flow endpoint**.

   :::image type="content" source="media/how-to-custom-url-domain/run-user-flow.png" alt-text="Screenshot showing the run user flow option.":::

1. To simulate a sign in with your custom domain, open a web browser and use the URL you copied. Replace the domain (*&lt;tenant-name&gt;*.ciamlogin.com) with your custom domain.

    For example, instead of:

    ```http
    https://contoso.ciamlogin.com/contoso.onmicrosoft.com/oauth2/v2.0/authorize?p=B2C_1_susi&client_id=00001111-aaaa-2222-bbbb-3333cccc4444&nonce=defaultNonce&redirect_uri=https%3A%2F%2Fjwt.ms&scope=openid&response_type=id_token&prompt=login
    ```

    use:

    ```http
    https://login.contoso.com/contoso.onmicrosoft.com/oauth2/v2.0/authorize?p=B2C_1_susi&client_id=00001111-aaaa-2222-bbbb-3333cccc4444&nonce=defaultNonce&redirect_uri=https%3A%2F%2Fjwt.ms&scope=openid&response_type=id_token&prompt=login
    ```

1. Verify that the sign-in page is loaded correctly. Then, sign in with a local account.

## Configure your applications

After you configure and test the custom URL domain, update your applications to load a URL with your custom URL domain as the hostname instead of the default domain.

The custom URL domain integration applies to authentication endpoints that use External ID user flows to authenticate users. These endpoints have the following format:

- `https://<custom-url-domain>/<tenant-name>/v2.0/.well-known/openid-configuration`

- `https://<custom-url-domain>/<tenant-name>/oauth2/v2.0/authorize`

- `https://<custom-url-domain>/<tenant-name>/oauth2/v2.0/token`

Replace:

- **custom-url-domain** with your custom URL domain
- **tenant-name** with your tenant name or tenant ID

The SAML service provider metadata might look like the following sample:

```html
https://custom-url-domain-name/tenant-name/Samlp/metadata
```

### (Optional) Use the tenant ID

You can replace your external tenant name in the URL with your tenant ID GUID to remove all references to “onmicrosoft.com” in the URL. You can find your tenant ID GUID in the **Overview** page in the Azure portal or the Microsoft Entra admin center. For example, change `https://account.contosobank.co.uk/contosobank.onmicrosoft.com/` to `https://account.contosobank.co.uk/<tenant-ID-GUID>/`.

If you choose to use tenant ID instead of tenant name, be sure to update the identity provider **OAuth redirect URIs** accordingly. When you use your tenant ID instead of tenant name, a valid OAuth redirect URI looks similar to the following sample:

```html
https://login.contoso.com/00001111-aaaa-2222-bbbb-3333cccc4444/oauth2/authresp 
```

## (Optional) Azure Front Door advanced configuration

You can use Azure Front Door advanced configuration, such as Azure Web Application Firewall (WAF). Azure WAF provides centralized protection of your web applications from common exploits and vulnerabilities.

When using custom domains, consider the following points:

- The WAF policy must be the same tier as the Azure Front Door profile. For more information about how to create a WAF policy to use with Azure Front Door, see [Configure WAF policy](/azure/frontdoor/how-to-configure-endpoints).
- The WAF managed rules feature isn't officially supported as it can cause false positives and prevent legitimate requests from passing through, so only use WAF custom rules if they meet your needs.

## Troubleshooting

- **Page not found message.** When you try to sign in with the custom URL domain, you get an HTTP 404 error message. This issue could be related to the DNS configuration or the Azure Front Door backend configuration. Try the following steps:

  - Make sure the custom URL domain is registered and successfully verified in your tenant.
  - Make sure the [custom domain](/azure/frontdoor/front-door-custom-domain) is configured properly. The `CNAME` record for your custom domain must point to your Azure Front Door default frontend host (for example, contoso-frontend.azurefd.net).

- **Our services aren't available right now message.** When you try to sign in with the custom URL domain, you get the error message: *Our services aren't available right now. We're working to restore all services as soon as possible. Please check back soon.* This issue could be related to the Azure Front Door route configuration. Check the status of the **default-route**. If it's disabled, [enable the route](#43-enable-the-route).

- **Resource was removed, changed names, or is temporarily unavailable.** When you try to sign in with the custom URL domain, you get the error message *the resource you are looking for has been removed, had its name changed, or is temporarily unavailable*. This issue could be related to the Microsoft Entra custom domain verification. Make sure the custom domain is registered and **successfully verified** in your tenant.

- **Error code 399265: RoutingFromInvalidHost.** This error code appears when a tenant is making a request from a domain that isn't verified. Make sure to [add TXT record details in your DNS records](#step-1-add-a-custom-domain-name-to-your-tenant). Then [verify your custom domain name](~/fundamentals/add-custom-domain.yml#verify-your-custom-domain-name) again.

- **Error code 399280: InvalidCustomUrlDomain.** This error code appears when a tenant is making request from a verified domain that is not a custom URL domain. Make sure to [associate the custom domain name with a custom URL domain](#step-2-associate-the-custom-domain-name-with-a-custom-url-domain).

## Next steps

See all of our [sample guides and tutorials for building apps for External ID](samples-ciam-all.md?tabs=apptype).