---
title: How to manage an external authentication method (EAM) in Microsoft Entra ID (Preview)
description: Learn how to manage an external authentication method (EAM) for Microsoft Entra multifactor authentication
ms.service: entra-id
ms.subservice: authentication
ms.topic: conceptual
ms.date: 03/04/2025
ms.author: justinha
author: gregkmsft
manager: dougeby
ms.reviewer: gkinasewitz, gustavosa
ms.custom: sfi-ga-nochange, sfi-image-nochange
# Customer intent: As an authentication administrator, I want learn how to manage an external authentication method (EAM) for Microsoft Entra ID.
---
# Manage an external authentication method in Microsoft Entra ID (Preview)

An external authentication method (EAM) lets users choose an external provider to meet multifactor authentication (MFA) requirements when they sign in to Microsoft Entra ID. An EAM can satisfy MFA requirements from Conditional Access policies, Microsoft Entra ID Protection risk-based Conditional Access policies, Privileged Identity Management (PIM) activation, and when the application itself requires MFA. 

EAMs differ from federation in that the user identity is originated and managed in Microsoft Entra ID. With federation, the identity is managed in the external identity provider. EAMs require at least a Microsoft Entra ID P1 license.

:::image type="content" source="./media/concept-authentication-external-method-provider/how-external-method-authentication-works.png" alt-text="Diagram of how external method authentication works.":::

## Required metadata to configure an EAM
To create an EAM, you need the following information from your external authentication provider:

- An **Application ID** is generally a multitenant application from your provider, which is used as part of the integration. You need to provide admin consent for this application in your tenant.
- A **Client ID** is an identifier from your provider used as part of the authentication integration to identify Microsoft Entra ID requesting authentication.  
- A **Discovery URL** is the OpenID Connect (OIDC) discovery endpoint for the external authentication provider. 
 
   >[!NOTE]
   >See [Configure a new external authentication provider with Microsoft Entra ID](concept-authentication-external-method-provider.md#configure-a-new-external-authentication-provider-with-microsoft-entra-id) to set up the App registration.
   
   >[!IMPORTANT]
   > Ensure that the kid (Key ID) property is base64-encoded in both the JWT header of the id_token and in the JSON Web Key Set (JWKS) retrieved from the provider’s jwks_uri. This encoding alignment is essential for the seamless validation of token signatures during authentication processes. Misalignment can result in issues with key matching or signature validation.

## Manage an EAM in the Microsoft Entra admin center

EAMs are managed with the Microsoft Entra ID Authentication methods policy, just like built-in methods. 

### Create an EAM in the admin center

Before you create an EAM in the admin center, make sure you have the [metadata to configure an EAM](#required-metadata-to-configure-an-eam). 

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Privileged Role Administrator](~/identity/role-based-access-control/permissions-reference.md#privileged-role-administrator).
1. Browse to **Entra ID** > **Authentication methods** > **Add external method (Preview)**.

   :::image type="content" border="true" source="./media/how-to-authentication-external-method-manage/add-external-method.png" alt-text="Screenshot of how to add an EAM in the Microsoft Entra admin center.":::

   Add method properties based on configuration information from your provider. For example:
   
   - Name: Adatum
   - Client ID: 00001111-aaaa-2222-bbbb-3333cccc4444
   - Discovery Endpoint: `https://adatum.com/.well-known/openid-configuration`
   - App ID: 11112222-bbbb-3333-cccc-4444dddd5555

   >[!IMPORTANT]
   >The display name is the name that's shown to the user in the method picker. It can't be changed after the method is created. Display names must be unique.

   :::image type="content" border="true" source="./media/how-to-authentication-external-method-manage/method-properties.png" alt-text="Screenshot of how to add EAM properties.":::

   You need at least the [Privileged Role Administrator](../role-based-access-control/permissions-reference.md#privileged-role-administrator) role to grant admin consent for the provider’s application. If you don't have the role required to grant consent, you can still save your authentication method, but you can't enable it until consent is granted.

   After you enter the values from your provider, press the button to request for admin consent to be granted to the application so that it can read the required info from the user to authenticate correctly. You're prompted to sign in with an account with admin permissions and grant the provider’s application with the required permissions.

   After you sign in, click **Accept** to grant admin consent:

   :::image type="content" border="true" source="./media/how-to-authentication-external-method-manage/permissions-requested.png" alt-text="Screenshot of how to grant admin consent.":::

   You can see the permissions that the provider application requests before you grant consent. After you grant admin consent and the change replicates, the page refreshes to show that admin consent was granted.

   :::image type="content" border="true" source="./media/how-to-authentication-external-method-manage/consent-granted.png" alt-text="Screenshot of Authentication methods policy after consent is granted.":::

If the application has permissions, then you can also enable the method before saving. Otherwise, you need to save the method in a disabled state, and enable after the application is granted consent.

Once the method is enabled, all users in scope can choose the method for any MFA prompts. If the application from the provider doesn't have consent approved, then any sign-in with the method fails.

If the application is deleted or no longer has permission, users see an error and sign-in fails. The method can't be used.
<!---screenshot of error--->

### Configure an EAM in the admin center

To manage your EAMs in the Microsoft Entra admin center, open the Authentication methods policy. Select the method name to open the configuration options. You can choose which users are included and excluded from using this method. 

:::image type="content" border="true" source="./media/how-to-authentication-external-method-manage/target.png" alt-text="Screenshot of how to scope usage of the EAM for specific users.":::

### Delete an EAM in the admin center

If you no longer want your users to be able to use the EAM, you can either:

- Set **Enable** to **Off** to save the method configuration
- Click **Delete** to remove the method

:::image type="content" border="true" source="./media/how-to-authentication-external-method-manage/delete.png" alt-text="Screenshot of how to delete an EAM.":::

## Manage an EAM using Microsoft Graph

To manage the Authentication methods policy by using Microsoft Graph, you need the `Policy.ReadWrite.AuthenticationMethod` permission. For more information, see [Update authenticationMethodsPolicy](/graph/api/authenticationmethodspolicy-update).

## User experience

Users who are enabled for the EAM can use it when they sign-in and multifactor authentication is required. 

If the user has other ways to sign in and [system-preferred MFA](/entra/identity/authentication/concept-system-preferred-multifactor-authentication) is enabled, those other methods appear by default order. The user can choose to use a different method, and then select the EAM. For example, if the user has Authenticator enabled as another method, they get prompted for [number matching](/entra/identity/authentication/how-to-mfa-number-match).

:::image type="content" border="true" source="./media/how-to-authentication-external-method-manage/system-preferred.png" alt-text="Screenshot of how to choose an EAM when system-preferred MFA is enabled.":::


If the user has no other methods enabled, they can just choose the EAM. They're redirected to the external authentication provider to complete authentication.

:::image type="content" border="true" source="./media/how-to-authentication-external-method-manage/sign-in.png" alt-text="Screenshot of how to sign in with an EAM.":::

## Authentication method registration for EAMs
In the preview, all users in an include group for the EAM are considered MFA capable and can use the external authentication method for satisfying MFA.  Users that are MFA-capable due to being an include target for an EAM are not included in reports on authentication method registration.

>[!NOTE]
>We're actively working on adding registration capability for EAMs.  Once registration is added, users that were previously using an EAM will need to have the EAM registered with Entra ID before they will be prompted to use it to satisfy MFA.

## Using EAM and Conditional Access custom controls in parallel

EAMs and custom controls can operate in parallel. Microsoft recommends that admins configure two Conditional Access policies: 

- One policy to enforce the custom control 
- Another policy with the MFA grant required

Include a test group of users for each policy, but not both. If a user is included in both policies, or any policy with both conditions, the user has to satisfy MFA during sign-in. They also have to satisfy the custom control, which makes them redirected to the external provider a second time.

## Next steps

For more information about how to manage authentication methods, see [Manage authentication methods for Microsoft Entra ID](/entra/identity/authentication/concept-authentication-methods-manage).

For EAM provider reference, see [Microsoft Entra multifactor authentication external method provider reference (Preview)](concept-authentication-external-method-provider.md).
