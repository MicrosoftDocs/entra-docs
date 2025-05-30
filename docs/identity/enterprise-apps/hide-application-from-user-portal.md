---
title: Hide an enterprise application
description: How to hide an Enterprise application from user's experience in Microsoft Entra ID access portals or Microsoft 365 launchers.
author: omondiatieno
manager: CelesteDG
ms.service: entra-id
ms.subservice: enterprise-apps
ms.topic: how-to
ms.date: 03/04/2025
ms.author: jomondi
ms.reviewer: ergreenl, lenalepa
ms.collection: M365-identity-device-management
zone_pivot_groups: enterprise-apps-all
ms.custom: enterprise-apps, no-azure-ad-ps-ref, sfi-ga-blocked
#customer intent: As an administrator, I want to hide an application from the My Apps portal and Microsoft 365 launcher, so that users do not have visibility or access to the application.
---

# Hide an enterprise application

Learn how to hide enterprise applications in Microsoft Entra ID. When an application is hidden, users still have permissions to the application.

## Prerequisites

To hide an application from the My Apps portal and Microsoft 365 launcher, you need:

- A Microsoft Entra account with an active subscription. [Create an account for free](https://azure.microsoft.com/free/?WT.mc_id=A261C142F).
- One of the following roles:
  - Cloud Application Administrator
  - Application Administrator.
  - Global Administrator is required to hide all Microsoft 365 applications.

## Hide an application from the end user

:::zone pivot="portal"

Use the following steps to hide an application from My Apps portal and Microsoft 365 application launcher.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator). 
1. Browse to **Entra ID** > **Enterprise apps** > **All applications**.
1. Search for the application you want to hide, and select the application.
1. In the left navigation pane, select **Properties**.
1. Select **No** for the **Visible to users?** question.
1. Select **Save**.

:::zone-end

> [!NOTE]
> These instructions apply only to non-first-party Microsoft Enterprise Applications. To learn more about first-party Microsoft applications see [First-party Microsoft applications in sign-in reports](/troubleshoot/azure/entra/entra-id/governance/verify-first-party-apps-sign-in). Administrators also need to keep in mind that hiding the application from the users doesn't prevent them from signing into these applications via methods other than the My Apps portal, such as shared links or service dependencies. 

:::zone pivot="entra-powershell"


To hide an application from the My Apps portal, using Microsoft Entra PowerShell, you need to connect to Microsoft Entra PowerShell and sign in as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator). You can manually add the **HideApp** tag to the service principal for the application. Run the following Microsoft Entra PowerShell commands to set the application's **Visible to Users?** property to **No**.

```PowerShell
Connect-Entra -scopes "Application.ReadWrite.All"

$objectId = "<objectId>"
$servicePrincipal = Get-EntraServicePrincipal -ObjectId $objectId
$tags = $servicePrincipal.tags
$tags += "HideApp"
Set-EntraServicePrincipal -ObjectId $objectId -Tags $tags
```
:::zone-end

:::zone pivot="ms-powershell"

To hide an application from the My Apps portal, using Microsoft Graph PowerShell, you need to connect to Microsoft Graph PowerShell and sign in as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator). You can manually add the HideApp tag to the service principal for the application. Run the following Microsoft Graph PowerShell commands to set the application's **Visible to Users?** property to **No**.

```PowerShell
Connect-MgGraph "Application.ReadWrite.All"
$tags = $servicePrincipal.tags
$tags += "HideApp"
Update-MgServicePrincipal -ServicePrincipalID  $objectId -Tags $tags
```
:::zone-end

:::zone pivot="ms-graph"

To hide an enterprise application using [Graph Explorer](https://developer.microsoft.com/graph/graph-explorer), you need to sign in as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator). 

Ensure you consent to the `Application.ReadWrite.All` permission before running the queries.

Run the following queries.

1. Get the application you want to hide.

   ```http
   GET https://graph.microsoft.com/v1.0/servicePrincipals/00001111-aaaa-2222-bbbb-3333cccc4444
   ```
1. Update the application to hide it from users.

   ```http
   PATCH https://graph.microsoft.com/v1.0/servicePrincipals/00001111-aaaa-2222-bbbb-3333cccc4444/
   ```

    Supply the following request body.

    ```json
    {
        "tags": [
        "HideApp"
        ]
    }
    ```
   
   >[!WARNING]
   >If the application has other tags, you must include them in the request body. Otherwise, the query will overwrite them.

:::zone-end

:::zone pivot="portal"

## Hide Microsoft 365 applications from the My Apps portal


Use the following steps to hide all Microsoft 365 applications from the My Apps portal. The applications are still visible in the Office 365 portal.

[!INCLUDE [least-privilege-note](../../includes/definitions/least-privilege-note.md)]

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as a [Global Administrator](~/identity/role-based-access-control/permissions-reference.md#global-administrator).
1. Browse to **Entra ID** > **Enterprise apps**.
1. Select **App launchers** under **Manage** menu items.
1. Select **Settings**.
1. Enable the option of **Users can only see Microsoft 365 apps in the Microsoft 365 portal**.
1. Select **Save**.

:::zone-end

## Related content

- [Remove a user or group assignment from an enterprise app](./assign-user-or-group-access-portal.md)
