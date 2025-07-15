---
title: Configure Microsoft Entra for increased security
description: Learn how to improve your security posture with Microsoft Entra.

ms.service: entra
ms.subservice: fundamentals
ms.topic: reference
ms.date: 07/14/2025

ms.author: joflore
author: MicrosoftGuyJFlo
manager: femila
ms.reviewer: 
---
# Configure Microsoft Entra for increased security (Preview)

In Microsoft Entra, we group our security recommendations into several main areas. This structure allows organizations to logically break up projects into related consumable chunks.

> [!TIP]
> Some organizations might take these recommendations exactly as written, while others might choose to make modifications based on their own business needs. In our initial release of this guidance, we focus on traditional [workforce tenants](/entra/external-id/tenant-configurations#workforce-tenants). These workforce tenants are for your employees, internal business apps, and other organizational resources. 

We recommend that all of the following controls be implemented where licenses are available. This helps to provide a foundation for other resources built on top of this solution. More controls will be added to this document over time.

## Privileged access

### Privileged accounts are cloud native identities  

[!INCLUDE [21814](../includes/secure-recommendations/21814.md)]

### Privileged accounts have phishing-resistant methods registered

[!INCLUDE [21782](../includes/secure-recommendations/21782.md)]

### Privileged users sign in with phishing-resistant methods

[!INCLUDE [21781](../includes/secure-recommendations/21781.md)]

### All privileged role assignments are activated just in time and not permanently active

[!INCLUDE [21815](../includes/secure-recommendations/21815.md)]

### Permissions to create new tenants are limited to the Tenant Creator role

[!INCLUDE [21787](../includes/secure-recommendations/21787.md)]

## Credential management

### Users have strong authentication methods configured

[!INCLUDE [21801](../includes/secure-recommendations/21801.md)]

## Access control

### Block legacy authentication

[!INCLUDE [21796](../includes/secure-recommendations/21796.md)]

### Privileged Microsoft Entra built-in roles are targeted with Conditional Access policies to enforce phishing-resistant methods 

[!INCLUDE [21783](../includes/secure-recommendations/21783.md)]

### Restrict access to high risk users

[!INCLUDE [21797](../includes/secure-recommendations/21797.md)]

### Restrict device code flow

[!INCLUDE [21808](../includes/secure-recommendations/21808.md)]

### Require multifactor authentication for device join and device registration using user action

[!INCLUDE [21872](../includes/secure-recommendations/21872.md)]

### Use cloud authentication

[!INCLUDE [21829](../includes/secure-recommendations/21829.md)]

## Application management

### Inactive applications don't have highly privileged Microsoft Graph API permissions 

[!INCLUDE [21770](../includes/secure-recommendations/21770.md)]

### Inactive applications don't have highly privileged built-in roles 

[!INCLUDE [21771](../includes/secure-recommendations/21771.md)]

### Applications don't have client secrets configured 

[!INCLUDE [21772](../includes/secure-recommendations/21772.md)]

### Applications don't have certificates with expiration longer than 180 days 

[!INCLUDE [21773](../includes/secure-recommendations/21773.md)]

### Application Certificates need to be rotated on a regular basis

[!INCLUDE [21992](../includes/secure-recommendations/21992.md)]

### Creating new applications and service principles is restricted to privileged users 

[!INCLUDE [21807](../includes/secure-recommendations/21807.md)]

### App registrations use safe redirect URIs

[!INCLUDE [21885](../includes/secure-recommendations/21885.md)]

### Service principals use safe redirect URIs

[!INCLUDE [23183](../includes/secure-recommendations/23183.md)]

### Admin consent workflow is enabled

[!INCLUDE [21809](../includes/secure-recommendations/21809.md)]

## External collaboration

### Guests can't invite other guests

[!INCLUDE [21791](../includes/secure-recommendations/21791.md)]

### Guests have restricted access to directory objects

[!INCLUDE [21792](../includes/secure-recommendations/21792.md)]

### Guest access is protected by strong authentication methods 

[!INCLUDE [21851](../includes/secure-recommendations/21851.md)]

## Monitoring

### Diagnostic settings are configured for all Microsoft Entra logs 

[!INCLUDE [21860](../includes/secure-recommendations/21860.md)]

### No legacy authentication sign-in activity 

[!INCLUDE [21795](../includes/secure-recommendations/21795.md)]

### All user sign-in activity uses strong authentication methods 

[!INCLUDE [21800](../includes/secure-recommendations/21800.md)]

### All high-risk users are triaged

[!INCLUDE [21861](../includes/secure-recommendations/21861.md)]

### All high-risk sign-ins are triaged

[!INCLUDE [21863](../includes/secure-recommendations/21863.md)]

### High priority Entra recommendations are addressed

[!INCLUDE [22124](../includes/secure-recommendations/22124.md)]

### All Microsoft Entra recommendations are addressed

[!INCLUDE [21866](../includes/secure-recommendations/21866.md)]

## Free security features

### Enable Microsoft Entra ID security defaults

[!INCLUDE [21871](../includes/secure-recommendations/21871.md)]

## Related content

- [Microsoft Entra deployment plans](../architecture/deployment-plans.md)
- [Microsoft Entra operations reference guide](../architecture/ops-guide-intro.md)
