---
title: How to manage an external authentication method in Microsoft Entra ID (Preview)
description: Learn how to configure an external authentication method provider for Microsoft Entra multifactor authentication


ms.service: entra-id
ms.subservice: authentication
ms.topic: conceptual
ms.date: 04/19/2024

ms.author: justinha
author: justinha
manager: amycolannino
ms.reviewer: gregkmsft, msgustavosa

# Customer intent: As an authentication administrator, I want learn how to manage an external authentication method for Entra ID.

---
# Manage an external authentication method in Microsoft Entra ID (Preview)

External authentication methods enable users to use an external provider when satisfying multifactor authentication requirements when signing in with Entra ID. External authentication methods enable users to satisfy MFA requirements from Conditional Access policies, Identity Protection sign-in risk policies, Privileged Identity Management (PIM) activation, and when the application itself requires MFA. 

External authentication methods differ from federation in that the user identity is originated and managed in Entra ID. With federation, the identity is managed in the external identity provider.

:::image type="content" source="./media/concept-authentication-external-method-provider/how-external-method-authentication-works.png" alt-text="Diagram of how external method authentication works.":::

## Required information from your external authentication provider
Before creating the method, you will need the following information from your external authentication provider:

- An **Application ID** is generally a multitenant application from your provider, which is used as part of the integration. You need to provide admin consent for this application in your tenant.
- A **Client ID** is an identifier from your provider used as part of the authentication integration to identify Entra ID requesting authentication.  
- A **Discovery URL** is the OIDC discovery endpoint for the external authentication provider. 
 

## Manage an external authentication method in the Microsoft Entra admin center

External authentication methods are managed with the Entra ID Authentication methods policy, just like built-in methods. 

### Create an external authentication method
 
To create an external authentication method using the admin center, you will need the [required information from your external authentication provider](#required-information-from-your-external-authentication-provider). Open the Authentication methods policy, and select **Add external method**.
