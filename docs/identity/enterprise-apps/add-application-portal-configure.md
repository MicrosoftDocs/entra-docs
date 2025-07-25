---
title: Configure enterprise application properties
description: Learn how to configure the properties of an enterprise to how users access and interact with the application.

author: omondiatieno
manager: mwongerapk
ms.service: entra-id
ms.subservice: enterprise-apps
ms.topic: how-to

ms.date: 06/10/2025
ms.author: jomondi
ms.reviewer: ergreenl
zone_pivot_groups: enterprise-apps-minus-legacy-powershell
ms.custom: enterprise-apps
ai-usage: ai-assisted

#customer intent: As a Microsoft Entra admin, I want to configure the properties of an enterprise application, so that I can control how the application is represented and accessed by users.
---

# Configure enterprise application properties

This article shows you where you can configure the properties of an enterprise application in your Microsoft Entra tenant. For more information about the properties that you can configure, see [Properties of an enterprise application](application-properties.md).

## Prerequisites

To configure the properties of an enterprise application, you need:

- A Microsoft Entra user account. If you don't already have one, you can [Create an account for free](https://azure.microsoft.com/free/?WT.mc_id=A261C142F).
- One of the following roles: 
    - Cloud Application Administrator
    - Application Administrator, or owner of the service principal.

## Configure application properties

Application properties control how the application is represented and how the application is accessed.

:::zone pivot="portal"

To configure the application properties:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator). 
1. Browse to **Entra ID** > **Enterprise apps** > **All applications**.
1. Search for and select the application that you want to use.
1. In the **Manage** section, select **Properties** to open the **Properties** pane for editing.
1. On the **Properties** pane, you might want to configure the following properties for your application.
   - Logo
   - User sign in options
   - App visibility to users
   - Set available URL options
   - Choose whether app assignment is required
1. After you configure the properties according to your apps needs, select **Save**.
   
:::zone-end

:::zone pivot="ms-powershell"

Use the following Microsoft Graph PowerShell script to configure basic application properties.

You need to sign in as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator) and consent to the `Application.ReadWrite.All` permission.

```powershell

Import-Module Microsoft.Graph.Applications

$params = @{
    Tags = @(
        "HR"
        "Payroll"
        "HideApp"
    )
    Info = @{
        LogoUrl = "https://cdn.pixabay.com/photo/2016/03/21/23/25/link-1271843_1280.png"
        MarketingUrl = "https://www.contoso.com/app/marketing"
        PrivacyStatementUrl = "https://www.contoso.com/app/privacy"
        SupportUrl = "https://www.contoso.com/app/support"
        TermsOfServiceUrl = "https://www.contoso.com/app/termsofservice"
    }
    Web = @{
        HomePageUrl = "https://www.contoso.com/"
        LogoutUrl = "https://www.contoso.com/frontchannel_logout"
        RedirectUris = @(
            "https://localhost"
        )
    }
    ServiceManagementReference = "Owners aliases: Finance @ contosofinance@contoso.com; The Phone Company HR consulting @ hronsite@thephone-company.com;"
}

Update-MgApplication -ApplicationId $applicationId -BodyParameter $params
```
:::zone-end

:::zone pivot="ms-graph"

To configure the basic properties of an application, sign in to [Graph Explorer](https://developer.microsoft.com/graph/graph-explorer) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).

You need to consent to the `Application.ReadWrite.All` permission.

Run the following Microsoft Graph query to configure basic application properties.

```http
PATCH https://graph.microsoft.com/v1.0/applications/00001111-aaaa-2222-bbbb-3333cccc4444/
Content-type: application/json

{
    "tags": [
        "HR",
        "Payroll",
        "HideApp"
    ],
    "info": {
        "logoUrl": "https://cdn.pixabay.com/photo/2016/03/21/23/25/link-1271843_1280.png",
        "marketingUrl": "https://www.contoso.com/app/marketing",
        "privacyStatementUrl": "https://www.contoso.com/app/privacy",
        "supportUrl": "https://www.contoso.com/app/support",
        "termsOfServiceUrl": "https://www.contoso.com/app/termsofservice"
    },
    "web": {
        "homePageUrl": "https://www.contoso.com/",
        "logoutUrl": "https://www.contoso.com/frontchannel_logout",
        "redirectUris": [
            "https://localhost"
        ]
    },
    "serviceManagementReference": "Owners aliases: Finance @ contosofinance@contoso.com; The Phone Company HR consulting @ hronsite@thephone-company.com;"
}
```
:::zone-end

Enterprise applications (service principals) inherit specific properties from their associated app registrations. These properties are synchronized from the app registration, but the synchronization isn't immediate or continuous. Sometimes, updating an enterprise application might prompt the directory to refresh properties from the app registration, causing updates that weren't part of the original request.

> [!NOTE]
> Managed identities are distinct from Microsoft Entra App Registrations. Managed identities only have a service principal object and don't possess an application object, which is typically used for granting app permissions. As a result, global admins can't change the settings of a managed identity, as the security boundary is the resource itself.

## Use Microsoft Graph to configure advanced app properties

You can also configure other advanced properties of both app registrations and enterprise applications (service principals) through Microsoft Graph. These properties include permissions and role assignments. For more information, see [Create and manage a Microsoft Entra application using Microsoft Graph](/graph/tutorial-applications-basics#configure-other-basic-properties-for-your-app).

## Related content

- [What is application management in Microsoft Entra ID?](what-is-application-management.md)
