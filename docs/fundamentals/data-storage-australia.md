---
title: Identity data storage for Australian and New Zealand customers
description: Learn about where Microsoft Entra ID stores identity-related data for
  its Australian and New Zealand customers.
author: barclayn
manager: pmwongera
ms.author: barclayn
ms.service: entra
ms.subservice: fundamentals
ms.topic: conceptual
ms.date: 03/05/2025
ms.custom: it-pro
ms.collection: M365-identity-device-management
---

# Identity data storage for Australian and New Zealand customers in Microsoft Entra ID

Microsoft Entra ID stores identity data in a location chosen based on the address provided by your organization when subscribing to a Microsoft service like Microsoft 365 or Azure. For information on where your Identity Customer Data is stored, you can review the Microsoft Trust center section titled [Where is your data located?](https://www.microsoft.com/trustcenter/privacy/where-your-data-is-located).

> [!NOTE]
> Services and applications that integrate with Microsoft Entra ID have access to Identity Customer Data. Evaluate each service and application you use. Determine how that specific service and application process identity data, and whether they meet your company's data storage requirements. 

For customers who provided an address in Australia or New Zealand, Microsoft Entra ID keeps identity data for these services within Australian datacenters:

- Microsoft Entra Directory Management
- Authentication

All other Microsoft Entra services store customer data in global datacenters.

<a name='microsoft-azure-ad-multi-factor-authentication-mfa'></a>

## Microsoft Entra multifactor authentication

Multifactor authentication stores Identity Customer Data in global datacenters. To learn more about the user information collected and stored by cloud-based Microsoft Entra multifactor authentication and Azure multifactor authentication Server, see [Microsoft Entra multifactor authentication user data collection](~/identity/authentication/concept-mfa-data-residency.md).

## Next steps

For more information about Multifactor authentication, see these articles:
- [What is multifactor authentication?](~/identity/authentication/concept-mfa-howitworks.md)