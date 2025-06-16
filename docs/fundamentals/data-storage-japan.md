---
title: Customer data storage for Japan customers
description: Learn about where Microsoft Entra ID stores customer-related data for its Japan customers.
author: justinha
manager: dougeby
ms.author: justinha

ms.service: entra
ms.subservice: fundamentals
ms.topic: conceptual
ms.date: 01/03/2024
ms.custom: it-pro, references_regions
ms.collection: M365-identity-device-management
---

# Customer data storage for Japan customers in Microsoft Entra ID

Microsoft Entra ID stores its Customer Data in a geographical location based on the country/region you provided when you signed up for a Microsoft Online service. Microsoft Online services include Microsoft 365 and Azure.

For information about where Microsoft Entra ID and other Microsoft services' data is located, see the [Where your data is located](https://www.microsoft.com/trust-center/privacy/data-location) section of the Microsoft Trust Center.

Additionally, certain Microsoft Entra features do not yet support storage of Customer Data in Japan. For example, Microsoft Entra multifactor authentication stores Customer Data in the US and processes it globally. For more information, see [Data residency and customer data for Microsoft Entra multifactor authentication](~/identity/authentication/concept-mfa-data-residency.md).

> [!NOTE]
> Microsoft products, services, and third-party applications that integrate with Microsoft Entra ID have access to Customer Data. Evaluate each product, service, and application you use to determine how Customer Data is processed by that specific product, service, and application, and whether they meet your company's data storage requirements. For more information about Microsoft services' data residency, see the [Where your data is located](https://www.microsoft.com/trust-center/privacy/data-location) section of the Microsoft Trust Center.

## Azure role-based access control (Azure RBAC)

Role definitions, role assignments, and deny assignments are stored globally to ensure that you have access to your resources regardless of the region you created the resource. For more information, see [What is Azure role-based access control (RBAC) (Azure RBAC)?](/azure/role-based-access-control/overview#where-is-azure-rbac-data-stored).
