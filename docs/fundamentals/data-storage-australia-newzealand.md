---
title: Customer data storage for Australian and New Zealand customers
description: Learn about where Microsoft Entra ID stores customer-related data for its Australian and New Zealand customers.
author: barclayn
manager: amycolannino
ms.author: barclayn

ms.service: entra
ms.subservice: fundamentals
ms.topic: conceptual
ms.date: 06/27/2024
ms.custom: it-pro, references_regions
ms.collection: M365-identity-device-management
---

# Customer Data storage for Australian and New Zealand customers in Microsoft Entra ID

Microsoft Entra ID stores identity data in a location chosen based on the address provided by your organization when subscribing to a Microsoft service like Microsoft 365 or Azure. Microsoft Online services include Microsoft 365 and Azure.

For information about where Microsoft Entra ID and other Microsoft services' data is located, see the [Where your data is located](https://www.microsoft.com/trust-center/privacy/data-location) section of the Microsoft Trust Center.

From February 26, 2020, Microsoft began storing Microsoft Entra ID's Customer Data for new tenants with an Australian or New Zealand billing address within the Australian datacenters.

Additionally, certain Microsoft Entra features don't yet support storage of Customer Data in Australia. Go to the [Microsoft global datacenters map](https://datacenters.microsoft.com/globe/explore) for information specific to your region. For example, Microsoft Entra multifactor authentication stores Customer Data in the US and processes it globally. For more information, see [Data residency and customer data for Microsoft Entra multifactor authentication](~/identity/authentication/concept-mfa-data-residency.md).

> [!NOTE]
> Microsoft products, services, and third-party applications that integrate with Microsoft Entra ID have access to Customer Data. Evaluate each product, service, and application you use to determine how Customer Data is processed by that specific product, service, and application, and whether they meet your company's data storage requirements. For more information about Microsoft services' data residency, see the [Where your data is located](https://www.microsoft.com/trust-center/privacy/data-location) section of the Microsoft Trust Center.

## Azure role-based access control (Azure RBAC)

Role definitions, role assignments, and deny assignments are stored globally to ensure that you have access to your resources regardless of the region you created the resource. For more information, see [What is Azure role-based access control (RBAC)?](/azure/role-based-access-control/overview#where-is-azure-rbac-data-stored).
