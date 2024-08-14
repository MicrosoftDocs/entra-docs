---
title: Upcoming change to target resources
description: New application IDs for Global Secure Access and upcoming changes to the conditionalAccessPolicy API.

ms.service: entra-id
ms.subservice: conditional-access
ms.topic: reference
ms.date: 06/26/2024

ms.author: joflore
author: MicrosoftGuyJFlo
manager: amycolannino
ms.reviewer: inbarc
---
# Planned change to Conditional Access target resources assignment

Starting in September 2024, we're consolidating the Conditional Access **Target resources** assignments **Cloud apps** and **Global Secure Access** options under a new name of **Resources**. Customers are then able to target **All internet resources with Global Secure Access**, **All resources (formerly all cloud apps)** or **Select specific resources (formerly select apps)**. Some of the Global Secure Access attributes in the Conditional Access beta API are being deprecated. 

There's no change to the behavior of existing Conditional Access policies. Administrators don't need to make changes to their existing policies.

:::image type="content" source="media/reference-resources-change/target-resources.png" alt-text="Screenshot showing a Conditional Access policy with the Global Secure Access controls selected.":::

## What's changing?

### All internet resources with Global Secure Access

This option combines the former **Microsoft 365 traffic** and **Internet traffic** options from **Global Secure Access**. 

Customers are able to target **All internet resources with Global Secure Access** and **Microsoft apps with Global Secure Access** from **All resources (formerly 'all cloud apps')**.

### Microsoft Graph API changes

The **networkAccess** and **globalSecureAccess** settings in the [conditionalAccessPolicy API](/graph/api/conditionalaccessroot-post-policies) are being marked for deprecation. 

:::image type="content" source="media/reference-resources-change/conditional-access-policy-graph-api.md.png" alt-text="Screenshot showing an example of the networkAccess and globalSecureAccess settings in the contisionalAccessPolicy Graph API.":::

Administrators should avoid creating new policies with these settings and migrate any existing policies to the [new Global Secure Access App IDs](#new-global-secure-access-app-ids).

When an administrator edits and saves an existing Conditional Access policy that uses these settings in the Microsoft Entra admin center the schema and AppIDs are updated.

In October 2024, Microsoft will update any remaining policy using the older schema to the new schema.  

### Global Secure Access - Service principals

As part of this change, between July and September 2024, Microsoft is provisioning new service principals in tenants that enabled the Global Secure Access. Tenants that enabled Global Secure Access in the past, will see audit logs for the creation of these service principals (Activity: Add service principal) with the following app IDs.

#### New Global Secure Access App IDs

| Application name | Application ID |
| --- | --- |
| Microsoft apps with Global Secure Access | c08f52c9-8f03-4558-a0ea-9a4c878cf343 |
| All internet resources with Global Secure Access | 5dc48733-b5df-475c-a49b-fa307ef00853 |
| All private resources with Global Secure Access | e92b9b37-1b47-4c01-9fbc-91d84450870e |
