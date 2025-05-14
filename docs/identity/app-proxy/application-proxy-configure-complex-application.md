---
title: Complex applications for Microsoft Entra application proxy
description: Understand complex applications in Microsoft Entra application proxy.
author: kenwith
manager: femila
ms.service: entra-id
ms.subservice: app-proxy
ms.topic: how-to
ms.date: 05/01/2025
ms.author: kenwith
ms.reviewer: dhruvinshah
ai-usage: ai-assisted
---

# Understand complex applications in Microsoft Entra application proxy

Applications are often made up of multiple individual web applications. These situations use different domain suffixes or different ports or paths in the URL. The individual web application instances must be published in separate Microsoft Entra application proxy apps. In these situations, the following problems might arise:
- **Pre authentication:** The client must separately acquire an access token or cookie for each Microsoft Entra application proxy app. The multiple acquisitions lead to more redirects at sign in to `microsoftonline.com`.
- **Cross-Origin Resource Sharing (CORS):** CORS calls, using the `OPTIONS` method, are used to validate access for the URL between the caller web app and the targeted web app. The Microsoft Entra application proxy cloud service blocks these calls. Blocking occurs because the requests can't contain authentication information.
- **Poor app management:** Multiple enterprise apps are created to enable access to a private app adding friction to the app management experience.

The following figure shows an example for complex application domain structure.

:::image type="content" source="./media/application-proxy-configure-complex-application/complex-app-structure-1.png" alt-text="Diagram of domain structure for a complex application showing resource sharing between primary and secondary application.":::

With [Microsoft Entra application proxy](overview-what-is-app-proxy.md), you can address this issue by using complex application publishing that is made up of multiple URLs across various domains. 

:::image type="content" source="./media/application-proxy-configure-complex-application/complex-app-flow-1.png" alt-text="Diagram of a Complex application with multiple application segments definition.":::

A complex app has multiple app segments. Each app segment has an internal and external URL.
One Conditional Access policy is associated with the app. Access to any of the external URLs work with preauthentication with the same set of policies. These policies are enforced for all app segments.

Complex apps provide several benefits: 
- User authentication
- Mitigation of CORS issues
- Access for different domain suffixes or different ports or paths in the internal URL

This article shows you how to configure wildcard application publishing in your environment.

## Characteristics of application segments for complex application. 
- Application segments are only configured a wildcard application.
- External and alternate URL should match the wildcard external and alternate URL domain of the application respectively.
- Application segment URLs (internal and external) need to maintain uniqueness across complex applications.
- CORS Rules (optional) can be configured per application segment.
- Access is only granted to defined application segments for a complex application.
    > [!NOTE]
    > If you delete all application segments, the complex application acts like a wildcard application, allowing access to any valid URL under the specified domain.
- You can have an internal URL defined both as an application segment and a regular application.
    > [!NOTE]
    > Regular applications always take precedence over a complex app (wildcard application).

## Prerequisites
- Enable application proxy and install a connector that has line of sight to your applications. See the tutorial [Add an on-premises application for remote access through application proxy](application-proxy-add-on-premises-application.md) to learn how to prepare your on-premises environment, install and register a connector, and test the connector.


## Configure application segments for complex application. 

> [!NOTE]
> Two application segments per complex distributed application are supported for [Microsoft Entra ID P1 or P2 subscription](https://azure.microsoft.com/pricing/details/active-directory).

To publish a complex distributed app through application proxy with application segments:

1. [Create a wildcard application.](application-proxy-wildcard.md#create-a-wildcard-application)

1. On the application proxy basic settings page, select **Add application segments**.

    :::image type="content" source="./media/application-proxy-configure-complex-application/add-application-segments.png" alt-text="Screenshot of link to add an application segment.":::

3. On the manage and configure application segments page, select **+ Add app segment**.

    :::image type="content" source="./media/application-proxy-configure-complex-application/add-application-segment-1.png" alt-text="Screenshot of Manage and configure application segment page.":::

4. Enter the **Internal Url**.

5. Select a custom domain from the **External Url** drop down the list.

6. Add CORS Rules (optional). For more information, see [Configuring CORS Rule](/graph/api/resources/corsconfiguration_v2?view=graph-rest-beta&preserve-view=true).

7. Select **Create**.

    :::image type="content" source="./media/application-proxy-configure-complex-application/create-app-segment.png" alt-text="Screenshot of add or edit application segment context plane.":::

8. Assign users to the application. 

To edit/update an application segment, select the application segment from the list on the manage and configure application segments page. Upload a certificate for the updated domain, if necessary, and update the Domain Name System (DNS) record. 

## Configuring single sign-on (SSO)

> [!NOTE]
> Single sign-on with Integrated Windows Authentication (IWA) doesn't support wildcard Service Principal Names (SPNs). For example, a wildcard such as `http/*.contoso.com` uses the single configured SPN such as `http/app.contoso.com` for all the segments.

## DNS updates

When using custom domains, create a DNS entry with a CNAME record for the external URL. For example, point `*.adventure-works.com` to the external URL of the application proxy endpoint. For wildcard applications, point the CNAME record to the relevant external URL: `<yourAADTenantId>.tenant.runtime.msappproxy.net`.

Alternatively, a dedicated DNS entry with a CNAME record for every individual application segment can be created as follows:

> `External URL of the application segment` > `<yourAADTenantId>.tenant.runtime.msappproxy.net`

Additionally, adding a CNAME record for the application ID in the same DNS zone is required:

>`<yourAppId>` > `<yourAADTenantId>.tenant.runtime.msappproxy.net`

If the connector group that is assigned to the Complex App isn't in the region of the Default connector group, one of the following domain suffixes must be used in the DNS entries:

| Connector Assigned Region | External URL |
| ---   | ---         |
| Asia | `<yourAADTenantId>.asia.tenant.runtime.msappproxy.net`|
| Australia  | `<yourAADTenantId>.aus.tenant.runtime.msappproxy.net` |
| Europe  | `<yourAADTenantId>.eur.tenant.runtime.msappproxy.net`|
| North America  | `<yourAADTenantId>.nam.tenant.runtime.msappproxy.net` |

For more detailed instructions for application proxy, see [Tutorial: Add an on-premises application for remote access through application proxy in Microsoft Entra ID](~/identity/app-proxy/application-proxy-add-on-premises-application.md).

## Next steps
- [Add an on-premises application for remote access through application proxy in Microsoft Entra ID](application-proxy-add-on-premises-application.md) 
- [Plan a Microsoft Entra application proxy deployment](conceptual-deployment-plan.md) 
- [Understand remote access to on-premises applications through Microsoft Entra application proxy](overview-what-is-app-proxy.md)
- [Understand and solve Microsoft Entra application proxy CORS issues](application-proxy-understand-cors-issues.md)
