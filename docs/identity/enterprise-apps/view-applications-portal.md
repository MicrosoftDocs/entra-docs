---
title: 'Quickstart: View enterprise applications'
description: Access Microsoft Entra admin center to effortlessly view and filter enterprise apps. Streamline tenant oversight and take charge now.
author: omondiatieno
manager: CelesteDG
ms.service: entra-id
ms.subservice: enterprise-apps
ms.topic: quickstart
ms.date: 03/31/2025
ms.author: jomondi
ms.reviewer: alamaral
ms.custom: mode-other, enterprise-apps, sfi-image-nochange
#Customer intent: As an enterprise administrator, I want to view and search for enterprise applications in the Microsoft Entra admin center, so that I can manage and configure the applications in my tenant effectively.
---

# Quickstart: View enterprise applications

In this quickstart, you learn how to use the Microsoft Entra admin center to search for and view the enterprise applications configured in your Microsoft Entra tenant.

We recommend that you use a nonproduction environment to test the steps in this quickstart.

## Prerequisites

To view applications registered in your Microsoft Entra tenant, you need:

- A Microsoft Entra user account. If you don't already have one, you can [Create an account for free](https://azure.microsoft.com/free/?WT.mc_id=A261C142F).
- One of the following roles: Cloud Application Administrator, or owner of the service principal.
- Completion of the steps in [Quickstart: Add an enterprise application](add-application-portal.md).

## View a list of applications


To view the enterprise applications registered in your tenant:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator). 
1. Browse to **Entra ID** > **Enterprise apps** > **All applications**.
    :::image type="content" source="media/view-applications-portal/view-enterprise-applications.png" alt-text="View the registered applications in your Microsoft Entra tenant." lightbox="media/view-applications-portal/view-enterprise-applications.png":::
1. To view more applications, select **Load more** at the bottom of the list. If there are many applications in your tenant, it might be easier to search for a particular application instead of scrolling through the list.

## Search for an application

To search for a particular application:

1. Select the **Application Type** filter option. Select **All applications** from the **Application Type** drop-down menu, and choose **Apply**.
1. Enter the name of the application you want to find. If the application is already in your Microsoft Entra tenant, it appears in the search results. For example, you can search for the **Microsoft Entra SAML Toolkit 1** application that is used in the previous quickstarts. 
1. Try entering the first few letters of an application name.

## Select viewing options

Select options according to what you're looking for:

1. The default filters are **Application Type** and **Application ID starts with**. 
1. Under **Application Type**, choose one of these options:
    - **Enterprise Applications** shows non-Microsoft applications.
    - **Microsoft Applications** shows Microsoft applications.
    - **Managed Identities** shows applications that are used to authenticate to services that support Microsoft Entra authentication.
    - **Agent ID (Preview)** shows AI agent identities that are used by AI agents to to authenticate to services that support Microsoft Entra authentication.
    - **All Applications** shows both non-Microsoft and Microsoft applications.
1. Under **Application ID starts with**, enter the first few digits of the application ID if you know the application ID.
1. After choosing the options you want, select **Apply**.
1. Select **Add filters** to add more options for filtering the search results. The other options include:
   - **Application Status**
   - **Application Visibility**
   - **Created on**
   - **Assignment required**
   - **Is App Proxy**
   - **Owner**
   - **Identifier URI (Entity ID)**
   - **Homepage URL** 
1. To remove any of the filter options already added, select the **X** icon next to the filter option.


## Clean up resources

If you created a test application named **Microsoft Entra SAML Toolkit 1** that was used throughout the quickstarts, you can consider deleting it now to clean up your tenant. For more information, see [Delete an application](delete-application-portal.md).

## Related content

- [Delete an application](delete-application-portal.md)
