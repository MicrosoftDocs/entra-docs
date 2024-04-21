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
 
To create an external authentication method using the admin center, you will need the [required information from your external authentication provider](#required-information-from-your-external-authentication-provider). 


1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Authentication Policy Administrator](~/identity/role-based-access-control/permissions-reference.md#authentication-policy-administrator).
1. Browse to **Protection** > **Authentication methods** > **Add external method (Preview)**.

   :::image type="content" border="true" source="./media/how-to-authentication-external-method-manage/add-external-method.png" alt-text="Screenshot of how to add an external authentication method in the Microsoft Entra admin center.":::

   Add method properties based on configuration information from your provider. For example:
   
   - Name: Adatum
   - Client ID: 06a011bd-ec92-4404-80fb-db6d5ada8ee2
   - Discovery Endpoint: `https://adatum.com/.well-known/openid-configuration`
   - App ID: 2f3d5a67-7441-4f1e-aa92-e77ca6b5a5ca

   >[!IMPORTANT]
   >The display name can't be changed after the method is created. Display names must be unique.

   :::image type="content" border="true" source="./media/how-to-authentication-external-method-manage/method-properties.png" alt-text="Screenshot of how to add an external authentication method properties.":::

If you have the required roles to grant consent for the provider’s application (Global Administrator or Privileged Role Administrator) then you can grant consent directly.  If you do not have the role required to grant admin consent, you can still save your authentication method but you will not be able to enable it until admin consent has been granted.

After the input of the values from your provider, press the button to request for admin consent to be granted to the application so that it can read the required info from the user to authenticate correctly.  You will be shown a window asking you to login with an account with admin permissions and grant the provider’s application with the required permissions.

After you login successfully, you should see the following window asking for permissions:

## Next steps

For more information about how to manage authentication methods, see [Manage authentication methods for Microsoft Entra ID](/entra/identity/authentication/concept-authentication-methods-manage)
