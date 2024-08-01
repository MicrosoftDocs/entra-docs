---
title: Known issues in external tenants
description: Learn about known issues in external tenants.
 
author: msmimart
manager: celestedg
ms.service: entra-external-id
 
ms.subservice: customers
ms.topic: concept-article
ms.date: 04/19/2024
ms.author: mimart
ms.custom: it-pro

---

# Known issues with Microsoft Entra External ID for external-facing apps

This article describes known issues that you may experience when you use Microsoft Entra External ID for your external-facing apps, and provides help to resolve these issues.

## Tenant creation and management

### Using your admin email to create a local customer account prevents you from administering the tenant

If you're the admin who created the external tenant, and you use the same email address as your admin account to create a local customer account in that same tenant, you can't sign in directly to the tenant with admin privileges.

**Cause**: Using your tenant admin email to create a customer account via self-service sign-up creates a second user with the same email address, but with customer-level privileges. When you sign in to the tenant via `https://entra.microsoft.com/<tenantID>` or `<tenantName>.onmicrosoft.com`, the least-privileged account takes precedence, and you're signed in as the customer instead of the admin. You have insufficient privileges to manage the tenant.

**Workaround**: Take one of the following actions.

- When creating a local customer account, use a different email address than the one used by the admin who created the tenant.
- If you've already created a customer account with the same email address as the admin, sign out of the admin center, and then use `https://entra.microsoft.com` instead of `https://entra.microsoft.com/<tenantID>` or `<tenantName>.onmicrosoft.com` to sign in with the correct admin account.

## Token version in Web API

### Error when running a web API

When you create your own web API in an external tenant (without using the app creation scripts in the web API samples), and then run it and send an access token, you enable logging and see the following error:

   `IDX20804: Unable to retrieve document from: https://<tenant>.ciamlogin.com/common/discovery/keys`

**Cause**: This error occurs if you haven't set the accepted access token version to 2.

**Workaround**: Do the following.

1. Go to the app registration for your application.
1. Choose to edit the manifest.
1. Change the **accessTokenAcceptedVersion** property from null to **2**.

## Related content

See also [Supported features in Microsoft Entra External ID](concept-supported-features-customers.md).

