---
title: Configure Microsoft Entra for increased security
description: 

ms.service: entra
ms.subservice: fundamentals
ms.topic: reference
ms.date: 02/03/2025

ms.author: joflore
author: MicrosoftGuyJFlo
manager: amycolannino
ms.reviewer: 
---
# Configure Microsoft Entra for increased security

In Microsoft Entra, we group our security recommendations into several main areas. This structure allows organizations to logically break up projects into related consumable chunks.

> [!TIP]
> Some organizations might take these recommendations exactly as written, while others might choose to make modifications based on their own business needs. In our initial release of this guidance, we focus on traditional [workforce tenants](https://learn.microsoft.com/entra/external-id/tenant-configurations#workforce-tenants). These workforce tenants are for your employees, internal business apps, and other organizational resources. 

<!--- 
> 
> You can use the Zero Trust assessment tool (preview) to validate your configuration against the security recommendations outlined in this document. You can find more information about this tool at https://aka.ms/<>.
--->

We recommend that all of the following controls be implemented where licenses are available. This helps provide a foundation for, or shore up an existing one, for other resources built on top of this secure foundation. 

## Privileged access

### Privileged accounts are cloud native identities  

[!INCLUDE [21814](../includes/secure-recommendations/21814.md)]

### Privileged accounts have phishing-resistant methods registered

[!INCLUDE [21782](../includes/secure-recommendations/21782.md)]

### Privileged users sign in with phishing-resistant methods

[!INCLUDE [21781](../includes/secure-recommendations/21781.md)]

## Credential management

### Users have strong authentication methods configured

[!INCLUDE [21801](../includes/secure-recommendations/21801.md)]

## Access control

### Block legacy authentication

[!INCLUDE [21796](../includes/secure-recommendations/21796.md)]

### Privileged Microsoft Entra built-in roles are targeted with Conditional Access policies to enforce phishing-resistant methods 

[!INCLUDE [21783](../includes/secure-recommendations/21783.md)]

<!--- 
## Devices

COMING SOON...
--->

## Application management

### Inactive applications don't have highly privileged Microsoft Graph API permissions 

[!INCLUDE [21770](../includes/secure-recommendations/21770.md)]

### Inactive applications don't have highly privileged built-in roles 

[!INCLUDE [21771](../includes/secure-recommendations/21771.md)]

### Applications don't have secrets configured 

[!INCLUDE [21772](../includes/secure-recommendations/21772.md)]

### Applications don't have certificates with expiration longer than 180 days 

[!INCLUDE [21773](../includes/secure-recommendations/21773.md)]

### Creating new applications and service principles is restricted to privileged users 

[!INCLUDE [21807](../includes/secure-recommendations/21807.md)]

## External collaboration

### Guests can't invite other guests

[!INCLUDE [21791](../includes/secure-recommendations/21791.md)]

### Guests have restricted access to directory objects

[!INCLUDE [21792](../includes/secure-recommendations/21792.md)]

### Guest access is protected by strong authentication methods 

[!INCLUDE [21851](../includes/secure-recommendations/21851.md)]

<!--- 
## Identity governance

COMING SOON...
--->

## Monitoring

### Diagnostic settings are configured for all Microsoft Entra logs 

[!INCLUDE [21860](../includes/secure-recommendations/21860.md)]

### No legacy authentication sign-in activity 

[!INCLUDE [21795](../includes/secure-recommendations/21795.md)]

### All user sign-in activity uses strong authentication methods 

[!INCLUDE [21800](../includes/secure-recommendations/21800.md)]

## Related content

- [Microsoft Entra deployment plans](../architecture/deployment-plans.md)
- [Microsoft Entra operations reference guide](../architecture/ops-guide-intro.md)
