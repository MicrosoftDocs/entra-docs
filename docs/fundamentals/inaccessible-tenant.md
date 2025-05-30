---
title: Troubleshoot inaccessible tenants
description: Instructions about how to unblock a tenant.
author: barclayn
manager: femila
ms.service: entra
ms.topic: troubleshooting
ms.subservice: fundamentals
ms.date: 01/15/2025
ms.author: barclayn
ms.reviewer: Sunayana
ms.custom: sfi-image-nochange
---



# Tenant inaccessible due to inactivity

Configured tenants no longer in use may still generate costs for your organization. Making a tenant inaccessible due to inactivity helps reduce unnecessary expenses. This article discusses how to handle an inaccessible tenant, reactivation, and guidance for both administrators and application developers. 

If you try to access the tenant, you receive a message similar to the example shown. 

Error message ```Error message: AADSTS5000225: This tenant has been blocked due to inactivity. To learn more about ...``` is expected for tenants' inaccessible due to inactivity. 

:::image type="content" source="media/tenant-inaccessible/tenant-block.png" alt-text="Screenshot showing an error when tenant access blocked due to inactivity." lightbox="media/tenant-inaccessible/tenant-block.png":::

Administrators can request a tenant to be reactivated within 20 days of the tenant entering an inactive state. Tenants that remain in this state for longer than 20 days are deleted.

Take the appropriate steps depending on your goals for the tenant and your role in the environment.

## Administrators

If you need to reactivate your tenant:

- The tenant administrator can reach out to Microsoft, see the [global support phone numbers](https://support.microsoft.com/topic/global-customer-service-phone-numbers-c0389ade-5640-e588-8b0e-28de8afeb3f2).
- Refrain from submitting another assistance request while your existing case is in process and until you receive a response with a decision on this case.

If you don't plan to reactivate your tenant:

- The tenant is deleted after 20 days of being inaccessible due to inactivity and it isn't recoverable.
- Review Microsoft's data protection policies, [here](https://www.microsoft.com/trust-center/privacy/data-management#leave).  

## Application owners/developers

- Minimize the number of authentication requests sent to this deactivated tenant until the tenant is reactivated.
- Refrain from submitting another assistance request. You are contacted once that a decision is made.
- Review Microsoft's [data protection policies](https://www.microsoft.com/trust-center/privacy/data-management#leave).  

## Related content

- [Quickstart: Create a new tenant in Microsoft Entra ID](create-new-tenant.md)
- [Add your custom domain name to your tenant](add-custom-domain.yml)