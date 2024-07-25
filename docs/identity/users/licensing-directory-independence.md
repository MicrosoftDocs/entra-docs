---
title: Characteristics of multitenant interaction
description: Understanding the data independence of your Microsoft Entra organizations

author: barclayn
manager: amycolannino
ms.service: entra-id
ms.subservice: users
ms.topic: conceptual
ms.date: 11/15/2023
ms.author: barclayn
ms.custom: it-pro
ms.reviewer: sumitp
---

# Understand how multiple Microsoft Entra tenant organizations interact

In Microsoft Entra ID, part of Microsoft Entra, each Microsoft Entra organization is fully independent: a peer that is logically independent from the other Microsoft Entra organizations that you manage. This independence between organizations includes resource independence, administrative independence, and synchronization independence. There's no parent-child relationship between organizations.

## Resource independence

* If you create or delete a Microsoft Entra resource in one organization, it has no effect on any resource in another organization, with the partial exception of external users.
* If you register one of your domain names with one organization, you can't use it for any other organization.

## Administrative independence

If a non-administrative user of organization 'Contoso' creates a test organization 'Test,' then:

* By default, the user who creates an organization adds as an external user in that new organization, and assigned the Global Administrator role in that organization.
* The administrators of organization 'Contoso' have no direct administrative privileges to organization 'Test,' unless an administrator of 'Test' specifically grants them these privileges.
* If you add or remove a Microsoft Entra role for a user in one organization, the change doesn't affect other roles. For example, roles that the user assigns in any other Microsoft Entra organization.

## Synchronization independence

You can configure each Microsoft Entra organization independently to get data synchronized from different AD forests, using the Microsoft Entra Connect tool.  See [topologies for Microsoft Entra Connect](~/identity/hybrid/connect/plan-connect-topologies.md) for more information on supported topologies when there are multiple Microsoft Entra tenants.

<a name='add-an-azure-ad-organization'></a>

## Add a Microsoft Entra organization

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as a [Global Administrator](~/identity/role-based-access-control/permissions-reference.md#global-administrator).
1. Select Microsoft Entra ID.
1. Select **Manage tenants**.
1. Choose **Create**.
1. Select **Workforce** and provide the requested information. Microsoft Entra ID creates a new organization and appears in the list of organizations.

> [!NOTE]
> Unlike other Azure resources, your Microsoft Entra organizations are not child resources of an Azure subscription. If your Azure subscription is canceled or expired, you can still access your Microsoft Entra organization's data using Azure PowerShell, the Microsoft Graph API, or the Microsoft 365 admin center. You can also [associate another subscription with the organization](~/fundamentals/how-subscriptions-associated-directory.yml).
>

[!INCLUDE [Azure AD PowerShell deprecation note](~/../docs/reusable-content/msgraph-powershell/includes/aad-powershell-deprecation-note.md)]

## Next steps

For Microsoft Entra ID licensing considerations and best practices, see [What is Microsoft Entra ID licensing?](~/fundamentals/concept-group-based-licensing.md).
