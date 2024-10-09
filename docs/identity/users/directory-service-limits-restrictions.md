---
title: Service limits and restrictions
description: Usage constraints and other service limits for the Microsoft Entra service

author: barclayn
manager: amycolannino

ms.service: entra-id
ms.subservice: users
ms.topic: reference
ms.date: 03/19/2024
ms.author: barclayn
ms.custom: aaddev;it-pro
ms.reviewer: vincesm

---
# Microsoft Entra service limits and restrictions

This article contains the usage constraints and other service limits for the Microsoft Entra ID, part of Microsoft Entra, service. If you’re looking for the full set of Microsoft Azure service limits, see [Azure Subscription and Service Limits, Quotas, and Constraints](/azure/azure-resource-manager/management/azure-subscription-service-limits).

[!INCLUDE [AAD-service-limits](~/includes/entra-service-limits-include.md)]
- In the Service limits document, specifically the application section. The following service limits are suggested to be added as CSS engineers have received some cases on this in the past 6 months. This is internally noted but not publicly
- The application section needs to add the follow:
There is a maximum of 400 API permissions that can be added to an app registration
There is a maximum of 40 API resources that can be added to an app registration

## Related content

* [Configure group claims for applications by using Microsoft EntraID](../hybrid/connect/how-to-connect-fed-group-claims.md)
* [Sign up for Azure as an organization](~/fundamentals/sign-up-organization.md)
* [How Azure subscriptions are associated with Microsoft Entra ID](~/fundamentals/how-subscriptions-associated-directory.yml)
