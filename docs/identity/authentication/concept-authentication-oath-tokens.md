---
title: OATH tokens authentication method
description: Learn about using OATH tokens in Microsoft Entra ID to help improve and secure sign-in events.
services: active-directory
ms.service: entra-id
ms.subservice: authentication
ms.topic: concept-article
ms.date: 03/04/2025
ms.author: justinha
author: justinha
ms.reviewer: lvandenende
manager: dougeby
ms.collection: M365-identity-device-management
ms.custom: sfi-image-nochange
# Customer intent: As an identity administrator, I want to understand how to use OATH tokens in Microsoft Entra ID to improve and secure user sign-in events.
---

# Authentication methods in Microsoft Entra ID - OATH tokens 

OATH time-based one-time password (TOTP) is an open standard that specifies how one-time password (OTP) codes are generated. OATH TOTP can be implemented using either software or hardware to generate the codes. Microsoft Entra ID doesn't support OATH HOTP, a different code generation standard.

## Software OATH tokens

Software OATH tokens are typically applications such as the Microsoft Authenticator app and other authenticator apps. Microsoft Entra ID generates the secret key, or seed, that's input into the app and used to generate each OTP.

The Authenticator app automatically generates codes when set up to do push notifications so a user has a backup even if their device doesn't have connectivity. Third-party applications that use OATH TOTP to generate codes can also be used.

Some OATH TOTP hardware tokens are programmable, meaning they don't come with a secret key or seed preprogrammed. These programmable hardware tokens can be set up using the secret key or seed obtained from the software token setup flow. Customers can purchase these tokens from the vendor of their choice and use the secret key or seed in their vendor's setup process.

## Hardware OATH tokens (preview)

Microsoft Entra ID supports the use of OATH-TOTP SHA-1 and SHA-256 tokens that refresh codes every 30 or 60 seconds. Customers can purchase these tokens from the vendor of their choice. 

Microsoft Entra ID has a new Microsoft Graph API in preview for Azure. Administrators can access Microsoft Graph APIs with least privileged roles to manage tokens in the preview. There aren't any options to manage hardware OATH token in this preview refresh in the Microsoft Entra admin center. 

You can continue to manage tokens from the original preview in **OATH tokens** in the Microsoft Entra admin center. On the other hand, you can only manage tokens in the preview refresh by using Microsoft Graph APIs. 

Hardware OATH tokens that you add with Microsoft Graph for this preview refresh appear along with other tokens in the admin center. But you can only manage them by using Microsoft Graph. 

### Time drift correction

Microsoft Entra ID adjusts time drift of the tokens during activation and every authentication. The following table lists the time adjustment that Microsoft Entra ID makes for tokens during activation and sign in. 

| Token refresh interval | Activation time range | Authentication time range |
|------------------------|-----------------------|---------------------------|
| 30 seconds             | +/- 1 day             | +/- 1 minute              |
| 60 seconds             | +/- 2 days            | +/- 2 minutes             |

### Improvements in the preview refresh

This hardware OATH token preview refresh improves flexibility and security for organizations by removing Global Administrator requirements. Organizations can delegate token creation, assignment, and activation to Privileged Authentication Administrators or Authentication Policy Administrators. 

The following table lists the role requirements to manage hardware OATH tokens in the preview refresh.

| Task                                                                                               | Preview refresh role                |
|----------------------------------------------------------------------------------------------------|-------------------------------------|
| Create a new token in the tenant’s inventory.                                                      | Authentication Policy Administrator |
| Read a token from the tenant’s inventory; doesn't return the secret.                               | Authentication Policy Administrator |
| Update a token in the tenant. For example, update manufacturer or module; Secret can't be updated. | Authentication Policy Administrator |
| Delete a token from the tenant’s inventory.                                                        | Authentication Policy Administrator |

As part of the preview refresh, end users can also self-assign and activate tokens from their [Security info](https://mysignins.microsoft.com/security-info). In the preview refresh, a token can only be assigned to one user. The following table lists token and role requirements to assign and activate tokens. 

| Task | Token state | Role requirement |
|------|-------------|------------------|
| Assign a token from the inventory to a user in the tenant. | Assigned | Member (self)<br>Authentication Administrator<br>Privileged Authentication Administrator |
| Read the token of the user, doesn't return the secret. | Activated / Assigned  (depends if the token was already activated or not) | Member (self)<br>Authentication Administrator (only has restricted Read, not standard Read)<br>Privileged Authentication Administrator  |
| Update the token of the user, such as provide current 6-digit code for activation, or change token name. | Activated | Member (self)<br>Authentication Administrator<br>Privileged Authentication Administrator |
| Remove the token from the user. The token goes back to the token inventory. | Available (back to the tenant inventory) | Member (self)<br>Authentication Administrator<br>Privileged Authentication Administrator |

In the legacy multifactor authentication (MFA) policy, hardware and software OATH tokens can only be enabled together. If you enable OATH tokens in the legacy MFA policy, end users see an option to add **Hardware OATH tokens** in their Security info page.

If you don't want end users to see an option to add **Hardware OATH tokens**, migrate to the Authentication methods policy. 
In the Authentication methods policy, hardware and software OATH tokens can be enabled and managed separately. For more information about how to migrate to the Authentication methods policy, see [How to migrate MFA and SSPR policy settings to the Authentication methods policy for Microsoft Entra ID](how-to-authentication-methods-manage.md).

Tenants with a Microsoft Entra ID P1 or P2 license can continue to upload hardware OATH tokens as in the original preview. For more information, see [Upload hardware OATH tokens in CSV format](how-to-mfa-upload-oath-tokens.md).

For more information about how to enable hardware OATH tokens and Microsoft Graph APIs that you can use to upload, activate, and assign tokens, see [How to manage OATH tokens](how-to-mfa-manage-oath-tokens.md).
 

## OATH token icons

Users can add and manage OATH tokens at [Security info](https://aka.ms/mysecurityinfo), or they can select **Security info** from **My account**. Software and hardware OATH tokens have different icons.  

| Token registration type | Icon |
| ------ | ------ |
| OATH software token   | <img width="63" alt="Software OATH token" src="media/concept-authentication-methods/software-oath-token-icon.png"> |
| OATH hardware token | <img width="63" alt="Hardware OATH token" src="media/concept-authentication-methods/hardware-oath-token-icon.png"> |


## Related content

Learn more about [how to manage OATH tokens](how-to-mfa-manage-oath-tokens.md).
Learn about [FIDO2 security key providers](concept-authentication-passwordless.md) that are compatible with passwordless authentication.
