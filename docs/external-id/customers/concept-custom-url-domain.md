---
title: Overview of custom URL domains for External ID
description: Learn about setting up custom URL domains to personalize the authentication sign-in endpoints for the external customers and consumers of your app.
ms.author: cmulligan
author: csmulligan
manager: dougeby
ms.service: entra-external-id
ms.subservice: external
ms.topic: concept-article
ms.date: 03/12/2025
ms.custom: it-pro, sfi-image-nochange
#Customer intent: As a dev, devops, or it admin, I want to learn about personalizing my application’s sign-in endpoints with my own branding or naming instead of Microsoft’s default domain name by using a custom URL domain.
---

# Custom URL domains in external tenants

[!INCLUDE [applies-to-external-only](../includes/applies-to-external-only.md)]

A custom URL domain allows you to brand your application’s sign-in endpoints with your own custom URL domain instead of Microsoft’s default domain name.

:::image type="content" source="./media/concept-custom-url-domain/custom-domain-user-experience-small.png" alt-text="Screenshot demonstrates an External ID custom URL domain user experience." lightbox="./media/concept-custom-url-domain/custom-domain-user-experience.png":::

Using a verified custom URL domain has several benefits:

- It provides a more consistent user experience. From the user's perspective, they remain in your domain during the sign in process rather than redirecting to the default domain *&lt;tenant-name&gt;.ciamlogin.com*.
- You mitigate the effect of [third-party cookie blocking](~/identity-platform/reference-third-party-cookies-spas.md) by staying in the same domain for your application during sign-in.

> [!TIP]
> [![Try it now](./media/common/try-it-now.png)](https://woodgrovedemo.com/#usecase=CustomDomain)
>
> To try out this feature, go to the Woodgrove Groceries demo and start the "custom URL domain name” use case.

## How a custom URL domain works

A custom URL domain lets you use your verified custom URL domain names as your applications' sign-in authentication endpoints. When you add a new custom URL domain name, you can associate it with a custom URL domain. Then a reverse proxy service, such as [Azure Front Door](https://azure.microsoft.com/services/frontdoor/), can use the custom URL domain to direct sign-ins to your application.

The following diagram illustrates Azure Front Door integration:

![Diagram showing Azure Front Door integration with External ID.](media/concept-custom-url-domain/custom-domain-network-flow.png)

1. From an application, a user selects the sign in button, which takes them to the sign in page. This page specifies a custom URL domain.
1. The web browser resolves the custom URL domain to the Azure Front Door IP address. During Domain Name System (DNS) resolution, a canonical name (CNAME) record with a custom URL domain points to your Front Door default front-end host (for example, `contoso-frontend.azurefd.net`).
1. The traffic addressed to the custom URL domain (for example, `login.contoso.com`) is routed to the specified Front Door default front-end host (`contoso-frontend.azurefd.net`).
1. Azure Front Door invokes content using the `<tenant-name>.ciamlogin.com` default domain. The request to the endpoint includes the original custom URL domain.
1. External ID responds to the custom URL domain request by displaying the relevant content and the original custom URL domain.

Azure Front Door passes the user's original IP address, which is the IP address you see in the audit reporting.

> [!IMPORTANT]
> If the client sends an `x-forwarded-for` header to Azure Front Door, External ID will use the originator's `x-forwarded-for` as the user's IP address for Conditional Access evaluation and the `{Context:IPAddress}` claims resolver.

## Considerations and limitations

When using custom URL domains:

- You can set up multiple custom URL domains. For the maximum number of supported custom URL domains, see [Microsoft Entra service limits and restrictions](~/identity/users/directory-service-limits-restrictions.md) for Microsoft Entra, and [Azure subscription and service limits, quotas, and constraints](/azure/azure-resource-manager/management/azure-subscription-service-limits#azure-front-door-classic-limits) for Azure Front Door.
- You can use Azure Front Door, which is a separate Azure service that incurs extra charges. For more information, see [Front Door pricing](https://azure.microsoft.com/pricing/details/frontdoor). Your Azure Front Door instance can be hosted in a different subscription than your external tenant.
- If you have multiple applications, migrate them all to the custom URL domain because the browser stores the session under the domain name currently being used.

> [!IMPORTANT]
>
>- Azure Front Door: The connection from the browser to Azure Front Door should always use IPv4 instead of IPv6.
>- Social identity providers: Custom URL domains now support Google and Facebook in addition to Apple.

## Blocking the default domain

For added security, we recommend blocking the default domain. After you configure custom URL domains, users will still be able to access the default domain name *&lt;tenant-name&gt;.ciamlogin.com*. You need to block access to the default domain so that attackers can't use it to access your apps or run distributed denial-of-service (DDoS) attacks. To block access to the default domain, [open a support ticket](~/fundamentals/how-to-get-support.md) and submit a request.

> [!CAUTION]
> Make sure your custom URL domain works properly before you submit a request to block the default domain.

### Feature impact and workarounds

Blocking the default domain will disable certain features that depend on it. However, you can maintain functionality for the features outlined in the following table by configuring them with your custom URL domain.

|Feature  |Workaround  |
|---------|------------|
|Run now                  | In the Microsoft Entra admin center, update the URL used by the "Run now" feature in the get started guide and the user flow pane with your custom URL domain. In the browser URL, replace `{your_domain}.ciamlogin.com` with your custom URL domain `{your_custom_URL_domain}/{your_tenant_ID}`.         |
|Get started samples      |Configure the samples in the get started guide with your custom URL domain. For detailed instructions, refer to the documentation for each sample. For example, see the “Use custom URL domain” section in the [Vanilla JavaScript single-page app tutorial](../../identity-platform/tutorial-single-page-app-javascript-configure-authentication.md).         |
|Power Pages with External ID        |When using [External ID with your Power Pages site](/power-pages/security/authentication/entra-external-id), update the site settings with your custom URL domain. In the Power Pages identity provider configuration page, replace the Authority URL field, which contains `{your_domain}.ciamlogin.com`, with your custom URL domain `{your_custom_URL_domain}/{your_tenant_ID}`.         |
|Azure App Service with External ID  |When using [External ID with Azure App Service](/azure/app-service/scenario-secure-app-authentication-app-service), edit the identity provider and change the Issuer URL field from `{your_domain}.ciamlogin.com` to your custom URL domain `{your_custom_URL_domain}/{your_tenant_ID}`.         |
|Visual Studio Code Extension        |In the [Visual Studio Code extension](visual-studio-code-extension.md), add your custom URL domain to the application's MSAL configuration so the application and the “Run it now” feature work properly. Change the authority in the authconfig file from `{your_domain}.ciamlogin.com` to `{your_custom_URL_domain}/{your_tenant_ID}`, and add the known authorities with your custom URL domain.         |
|Visual Studio with External ID      |In the appsettings.json file, add your custom URL domain followed by the tenant ID, and add the known authorities with your custom URL domain.         |
|GitHub samples                      |Certain samples, such as [OpenAI Chat Application with Microsoft Entra Authentication (Python)](https://github.com/Azure-Samples/openai-chat-app-entra-auth-builtin/blob/main/README.md), need your custom URL domain. When setting up the sample, set the AZURE_AUTH_LOGIN_ENDPOINT to your custom URL domain.         |


## Next steps

[Enable custom URL domains for Microsoft Entra External ID](how-to-custom-url-domain.md).
