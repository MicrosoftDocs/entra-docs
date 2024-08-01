---
title: Assign enterprise application owners
description: Learn how to assign owners to applications in Microsoft Entra ID

documentationcenter: ''
author: omondiatieno
manager: celesteDG
ms.service: entra-id

ms.subservice: enterprise-apps
ms.topic: how-to
ms.date: 12/20/2023
ms.author: jomondi
ms.reviewer: saibandaru
zone_pivot_groups: enterprise-apps-minus-former-powershell
ms.custom: enterprise-apps

#Customer intent: As an administrator, I want to assign an owner to an enterprise application in Microsoft Entra, so that the owner can manage the organization-specific configuration of the application and perform tasks such as single sign-on, provisioning, and user assignments.
---

# Assign enterprise application owners

An [owner of an enterprise application](overview-assign-app-owners.md) in Microsoft Entra ID can manage the organization-specific configuration of the application, such as single sign-on, provisioning, and user assignments. An owner can also add or remove other owners. Unlike other application administrators, owners can manage only the enterprise applications they own. In this article, you learn how to assign an owner of an application.

## Prerequisites

To add an enterprise application to your Microsoft Entra tenant, you need:

- A Microsoft Entra user account. If you don't already have one, you can [Create an account for free](https://azure.microsoft.com/free/?WT.mc_id=A261C142F).
- One of the following roles: Cloud Application Administrator, or Application Administrator.
[!INCLUDE [portal updates](~/includes/portal-update.md)]

## Assign an owner

:::zone pivot="portal"

To assign an owner to an enterprise application:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator). 
1. Browse to **Identity** > **Applications** > **Enterprise applications** > **All applications**.
1. Select the application that you want to add an owner to.
1. Select **Owners**, and then select **Add** to get a list of user accounts that you can choose an owner from.
1. Search for and select the user account that you want to be an owner of the application.
1. Select **Select** to add the user account that you chose as an owner of the application.

:::zone-end

:::zone pivot="ms-powershell"

To add an owner to an enterprise application using Microsoft Graph PowerShell, you need to sign in as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator) and consent to the `Application.ReadWrite.All` permission.

In the following example, the user's object ID is aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb and the applicationId is 00001111-aaaa-2222-bbbb-3333cccc4444.

```powershell
1. Connect-MgGraph -Scopes 'Application.ReadWrite.All'

1. Import-Module Microsoft.Graph.Applications

$params = @{
    "@odata.id" = "https://graph.microsoft.com/v1.0/directoryObjects/aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
}

New-MgServicePrincipalOwnerByRef -ServicePrincipalId '00001111-aaaa-2222-bbbb-3333cccc4444' -BodyParameter $params
```

:::zone-end

:::zone pivot="ms-graph"

To assign an owner to an application using Microsoft Graph API, sign in to [Graph Explorer](https://developer.microsoft.com/graph/graph-explorer) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).

You need to consent to the `Application.ReadWrite.All` permission.

Run the following Microsoft Graph query to assign an owner to an application. You need the object ID of the user you want to assign the application to. In the following example, the user's object ID is aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb and the appId is 00001111-aaaa-2222-bbbb-3333cccc4444.

```http
POST https://graph.microsoft.com/v1.0/servicePrincipals(appId='00001111-aaaa-2222-bbbb-3333cccc4444')/owners/$ref
Content-Type: application/json

{
    "@odata.id": "https://graph.microsoft.com/v1.0/directoryObjects/aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb"
}
```

:::zone-end

> [!NOTE]
> If the user setting **Restrict access to Microsoft Entra administration portal** is set to `Yes`, non-admin users aren't able to use the Microsoft Entra admin center to manage the applications they own. For more information about the actions that can be performed on owned enterprise applications, see [Owned enterprise applications](~/fundamentals/users-default-permissions.md#owned-enterprise-applications).

## Next steps

- [Delegate app registration permissions in Microsoft Entra ID](~/identity/role-based-access-control/delegate-app-roles.md)
