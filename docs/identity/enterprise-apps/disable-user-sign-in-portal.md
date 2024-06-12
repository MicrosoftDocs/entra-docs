---
title: Disable user sign-in for application
description: How to disable an enterprise application so that no users can sign in to it in Microsoft Entra ID.

author: omondiatieno
manager: CelesteDG
ms.service: entra-id
ms.subservice: enterprise-apps

ms.topic: how-to
ms.date: 2/14/2024
ms.author: jomondi
ms.reviewer: ergreenl
ms.custom: it-pro, enterprise-apps, has-azure-ad-ps-ref
ms.collection: M365-identity-device-management
zone_pivot_groups: enterprise-apps-all

#customer intent: As an IT administrator, I want to disable user sign-in for an application, so that I can prevent users from accessing the application and issuing tokens.
---
# Disable user sign-in for an application

There might be situations while configuring or managing an application where you don't want tokens to be issued for an application. Or, you might want to block an application that you don't want your employees to try to access. To block user access to an application, you can disable user sign-in for the application, which prevents all tokens from being issued for that application.

In this article, you learn how to prevent users from signing in to an application in Microsoft Entra ID through both the Microsoft Entra admin center and PowerShell. If you're looking for how to block specific users from accessing an application, use [user or group assignment](./assign-user-or-group-access-portal.md).

## Prerequisites

To disable user sign-in, you need:

- A Microsoft Entra user account. If you don't already have one, you can [Create an account for free](https://azure.microsoft.com/free/?WT.mc_id=A261C142F).
- One of the following roles: Cloud Application Administrator, Application Administrator, or owner of the service principal.

:::zone pivot="portal"

## Disable user sign-in using the Microsoft Entra admin center

[!INCLUDE [portal updates](~/includes/portal-update.md)]

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).
1. Browse to **Identity** > **Applications** > **Enterprise applications** > **All applications**.
1. Search for the application you want to disable a user from signing in, and select the application.
1. Select **Properties**.
1. Select **No** for **Enabled for users to sign-in?**.
1. Select **Save**.

:::zone-end

:::zone pivot="aad-powershell"

## Disable user sign-in using Azure AD PowerShell

You might know the AppId of an app that doesn't appear on the Enterprise apps list. For example, if you delete the app or the service principal isn't yet created because Microsoft preauthorizes it. You can manually create the service principal for the app and then disable it by using the following Azure AD PowerShell cmdlet.

Ensure you've installed the Azure AD PowerShell module (use the command `Install-Module -Name AzureAD`). In case you're prompted to install a NuGet module or the new Azure AD PowerShell V2 module, type Y and press ENTER. You need to sign in as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).

```PowerShell
# Connect to Azure AD PowerShell
Connect-AzureAD -Scopes

# The AppId of the app to be disabled
$appId = "{AppId}"

# Check if a service principal already exists for the app
$servicePrincipal = Get-AzureADServicePrincipal -Filter "appId eq '$appId'"
if ($servicePrincipal) {
    # Service principal exists already, disable it
    Set-AzureADServicePrincipal -ObjectId $servicePrincipal.ObjectId -AccountEnabled $false
} else {
    # Service principal does not yet exist, create it and disable it at the same time
    $servicePrincipal = New-AzureADServicePrincipal -AppId $appId -AccountEnabled $false
}
```

:::zone-end

:::zone pivot="ms-powershell"

## Disable user sign-in using Microsoft Graph PowerShell

You might know the AppId of an app that doesn't appear on the Enterprise apps list. For example, if you delete the app or the service principal isn't yet created due to the app because Microsoft preauthorizes it. You can manually create the service principal for the app and then disable it by using the following Microsoft Graph PowerShell cmdlet.

Ensure you install the Microsoft Graph module (use the command `Install-Module Microsoft.Graph`). You need to sign in as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).

```powershell
# Connect to Microsoft Graph PowerShell
Connect-MgGraph -Scopes "Application.ReadWrite.All"

# The AppId of the app to be disabled  
$appId = "{AppId}"  

# Check if a service principal already exists for the app 
$servicePrincipal = Get-MgServicePrincipal -Filter "appId eq '$appId'"  

# If Service principal exists already, disable it , else, create it and disable it at the same time 
if ($servicePrincipal) { Update-MgServicePrincipal -ServicePrincipalId $servicePrincipal.Id -AccountEnabled:$false }  

else {  $servicePrincipal = New-MgServicePrincipal -AppId $appId –AccountEnabled:$false } 
```

:::zone-end

:::zone pivot="ms-graph"

## Disable user sign-in using Microsoft Graph API

You might know the AppId of an app that doesn't appear on the Enterprise apps list. For example, if you delete the app or the service principal isn't yet created due to the app because Microsoft preauthorizes it. You can manually create the service principal for the app and then disable it by using the following Microsoft Graph call.

To disable sign-in to an application, sign in to [Graph Explorer](https://developer.microsoft.com/graph/graph-explorer) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).

You need to consent to the `Application.ReadWrite.All` permission.

Run the following query to disable user sign-in to an application.

```http
PATCH https://graph.microsoft.com/v1.0/servicePrincipals/00001111-aaaa-2222-bbbb-3333cccc4444

Content-type: application/json

{
    "accountEnabled": false
}
```

:::zone-end

## Next steps

- [Remove a user or group assignment from an enterprise app](./assign-user-or-group-access-portal.md)
