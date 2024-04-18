---
title: User default permissions in external tenants
description: Learn about the default permissions for users in an external tenant. 
author: msmimart
manager: celestedg
ms.service: entra-external-id
 
ms.subservice: customers
ms.topic: reference
ms.date: 05/01/2023
ms.author: mimart
ms.custom: it-pro
---

# Default user permissions in external tenants

An external tenant provides clear separation between your corporate workforce directory and your customer-facing app directory. Furthermore, users created in your external tenant are restricted from accessing information about other users in the external tenant. By default, customers can’t access information about other users, groups, or devices.

The following table describes the default permissions assigned to a customer.

| **Area** | **Customer user permissions** |
| ------------ | --------- |
| Users and contacts | - Read and update their own profile through the app profile management experience  <br>- Change their own password <br>- Sign in with a local or social account |
| Applications | - Access customer-facing applications <br>- Revoke consent to applications |
