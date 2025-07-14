---
title: Configure a Temporary Access Pass in Microsoft Entra ID to register passwordless authentication methods
description: Learn how to configure and enable users to register passwordless authentication methods by using a Temporary Access Pass (TAP).
ms.service: entra-id
ms.subservice: authentication
ms.topic: conceptual
ms.date: 03/04/2025
ms.author: justinha
author: tilarso
manager: dougeby
ms.reviewer: tilarso
ms.custom: sfi-ga-nochange, sfi-image-nochange
---
# Configure Temporary Access Pass to register passwordless authentication methods

Passwordless authentication methods like a passkey (FIDO2) let users sign in securely without a password. Users can bootstrap passwordless methods in one of two ways:

- Use existing Microsoft Entra multifactor authentication methods 
- Use a Temporary Access Pass 

A Temporary Access Pass (TAP) is a time-limited passcode that can be configured for single use or multiple sign-ins. Users can sign in with a TAP to onboard other passwordless authentication methods. A TAP also makes recovery easier when a user loses or forgets a strong authentication method.

This article shows you how to enable and use a TAP using the [Microsoft Entra admin center](https://entra.microsoft.com). You can also perform these actions using REST APIs. 

## Enable the Temporary Access Pass policy

A TAP policy defines settings, such as the lifetime of passes created in the tenant, or the users and groups who can use a TAP to sign-in. 

Before users can sign-in with a TAP, you need to enable this method in the Authentication methods policy and choose which users and groups can sign in by using a TAP.

Although you can create a TAP for any user, only users included in the policy can sign-in with it. You need the [Authentication Policy Administrator](../role-based-access-control/permissions-reference.md#authentication-policy-administrator) role to update the TAP Authentication methods policy.

To configure TAP in the Authentication methods policy:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Authentication Policy Administrator](~/identity/role-based-access-control/permissions-reference.md#authentication-policy-administrator).
1. Browse to **Entra ID** > **Authentication methods** > **Policies**.
1. From the list of available authentication methods, select **Temporary Access Pass**.

   :::image type="content" border="true" source="./media/how-to-authentication-temporary-access-pass/select-temporary-access-pass-policy.png" alt-text="Screenshot of how to manage Temporary Access Pass within the Authentication methods policy experience.":::

1. Select **Enable** and then select users to include or exclude from the policy. 
   
   :::image type="content" border="true" source="./media/how-to-authentication-temporary-access-pass/enable-temporary-access-pass.png" alt-text="Screenshot of how to enable Temporary Access Pass in the Authentication methods policy.":::

1. (Optional) Select **Configure** to modify the default Temporary Access Pass settings, such as setting maximum lifetime, or length, and select **Update**. 

   :::image type="content" border="true" source="./media/how-to-authentication-temporary-access-pass/configure-temporary-access-pass.png" alt-text="Screenshot of how to customize the settings for Temporary Access Pass.":::

1. Select **Save** to apply the policy. 

   The default value and the range of allowed values are described in the following table.

   | Setting | Default values | Allowed values | Comments |
   |---|---|---|---|
   | Minimum lifetime | 1 hour | 10 – 43,200 Minutes (30 days) | Minimum number of minutes that the TAP is valid. |
   | Maximum lifetime | 8 hours | 10 – 43,200 Minutes (30 days) | Maximum number of minutes that the TAP is valid. |
   | Default lifetime | 1 hour | 10 – 43,200 Minutes (30 days) | Individual passes within the minimum and maximum lifetime configured by the policy can override default value. |
   | One-time use | False | True/False | When the policy is set to false, passes in the tenant can be used either once or more than once during its validity (maximum lifetime). By enforcing one-time use in the TAP policy, all passes created in the tenant are one-time use. |
   | Length | 8 | 8-48 characters | Defines the length of the passcode. |

## Create a Temporary Access Pass

After you enable a TAP policy, you can create a TAP policy for users in Microsoft Entra ID. The following roles can perform various actions related to a TAP.

- [Privileged Authentication Administrators](~/identity/role-based-access-control/permissions-reference.md#privileged-authentication-administrator) can create, delete, and view a TAP for admins and members (except themselves).
- [Authentication Administrators](~/identity/role-based-access-control/permissions-reference.md#authentication-administrator) can create, delete, and view a TAP for members (except themselves).
- [Authentication Policy Administrators](~/identity/role-based-access-control/permissions-reference.md#authentication-policy-administrator) can enable TAP, include or exclude groups, and edit the Authentication methods policy.
- [Global Readers](~/identity/role-based-access-control/permissions-reference.md#global-reader) can view TAP details for the user (without reading the code itself).

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Authentication Administrator](~/identity/role-based-access-control/permissions-reference.md#authentication-administrator).
1. Browse to **Entra ID** > **Users**.
1. Select the user you would like to create a TAP for. 
1. Select **Authentication methods** and select **Add authentication method**. 

   :::image type="content" border="true" source="./media/how-to-authentication-temporary-access-pass/create.png" alt-text="Screenshot of how to create a Temporary Access Pass.":::

1. Select **Temporary Access Pass**.
1. Define a custom activation time or duration and select **Add**.

   :::image type="content" border="true" source="./media/how-to-authentication-temporary-access-pass/add-method.png" alt-text="Screenshot of adding a method - Temporary Access Pass.":::

1. Once added, the details of the TAP are shown. 

   > [!IMPORTANT]
   > Make a note of the actual TAP value, because you provide this value to the user. You can't view this value after you select **Ok**.

   :::image type="content" border="true" source="./media/how-to-authentication-temporary-access-pass/details.png" alt-text="Screenshot of Temporary Access Pass details.":::

1. Select **OK** when you're done. 

The following commands show how to create and get a TAP using PowerShell. 

```powershell
# Create a Temporary Access Pass for a user
$properties = @{}
$properties.isUsableOnce = $True
$properties.startDateTime = '2022-05-23 06:00:00'
$propertiesJSON = $properties | ConvertTo-Json

New-MgUserAuthenticationTemporaryAccessPassMethod -UserId user2@contoso.com -BodyParameter $propertiesJSON

Id                                   CreatedDateTime       IsUsable IsUsableOnce LifetimeInMinutes MethodUsabilityReason StartDateTime         TemporaryAccessPass
--                                   ---------------       -------- ------------ ----------------- --------------------- -------------         -------------------
00aa00aa-bb11-cc22-dd33-44ee44ee44ee 5/22/2022 11:19:17 PM False    True         60                NotYetValid           23/05/2022 6:00:00 AM TAPRocks!

# Get a user's Temporary Access Pass
Get-MgUserAuthenticationTemporaryAccessPassMethod -UserId user3@contoso.com

Id                                   CreatedDateTime       IsUsable IsUsableOnce LifetimeInMinutes MethodUsabilityReason StartDateTime         TemporaryAccessPass
--                                   ---------------       -------- ------------ ----------------- --------------------- -------------         -------------------
00aa00aa-bb11-cc22-dd33-44ee44ee44ee 5/22/2022 11:19:17 PM False    True         60                NotYetValid           23/05/2022 6:00:00 AM

```

For more information, see [New-MgUserAuthenticationTemporaryAccessPassMethod](/powershell/module/microsoft.graph.identity.signins/new-mguserauthenticationtemporaryaccesspassmethod) and [Get-MgUserAuthenticationTemporaryAccessPassMethod](/powershell/module/microsoft.graph.identity.signins/get-mguserauthenticationtemporaryaccesspassmethod?view=graph-powershell-1.0&preserve-view=true&viewFallbackFrom=graph-powershell-beta).

## Use a Temporary Access Pass

The most common use for a TAP is for a user to register authentication details during the first sign-in or device setup, without the need to complete extra security prompts. Authentication methods are registered at [https://aka.ms/mysecurityinfo](https://aka.ms/mysecurityinfo). Users can also update existing authentication methods here.

1. Open a web browser to [https://aka.ms/mysecurityinfo](https://aka.ms/mysecurityinfo).
1. Enter the UPN of the account you created the TAP for, such as *tapuser@contoso.com*.
1. If the user is included in the TAP policy, they see a screen to enter their TAP.
1. Enter the TAP that was displayed in the Microsoft Entra admin center.

   :::image type="content" border="true" source="./media/how-to-authentication-temporary-access-pass/enter.png" alt-text="Screenshot of how to enter a Temporary Access Pass.":::

> [!NOTE]
> For federated domains, a TAP is preferred over federation. A user with a TAP completes the authentication in Microsoft Entra ID and isn't redirected to the federated Identity Provider (IdP).

The user is now signed in and can update or register a method such as FIDO2 security key. 
Users who update their authentication methods due to losing their credentials or device should make sure they remove the old authentication methods. 
Users can also continue to sign-in by using their password; a TAP doesn’t replace a user’s password.

### User management of Temporary Access Pass

Users managing their security information at [https://aka.ms/mysecurityinfo](https://aka.ms/mysecurityinfo) see an entry for the Temporary Access Pass. If a user doesn't have any other registered methods, they get a banner at the top of the screen that says to add a new sign-in method. Users can also see the TAP expiration time, and delete the TAP if it's no longer needed. 

:::image type="content" border="true" source="./media/how-to-authentication-temporary-access-pass/tap-my-security-info.png" alt-text="Screenshot of how users can manage a Temporary Access Pass in My Security Info..":::

### Windows device setup

Users with a TAP can navigate the setup process on Windows 10 and 11 to perform device join operations and configure Windows Hello for Business. TAP usage for setting up Windows Hello for Business varies based on the devices joined state. 

For joined devices to Microsoft Entra ID: 
- During the domain-join setup process, users can authenticate with a TAP (no password required) to join the device and register Windows Hello for Business.
- On already-joined devices, users must first authenticate with another method such as a password, smartcard, or FIDO2 key, before using TAP to set up Windows Hello for Business. 
- If the [Web sign-in](/windows/client-management/mdm/policy-csp-authentication#authentication-enablewebsignin) feature on Windows is also enabled, the user can use TAP to sign into the device. This is intended only for completing initial device setup, or recovery when the user doesn't know or have a password. 

For hybrid-joined devices, users must first authenticate with another method such as a password, smartcard or FIDO2 key, before using TAP to set up Windows Hello for Business. 

> [!NOTE]
> For federated domains where federatedIdpMfaBehavior is set to enforceMfaByFederatedIdp, users will not be prompted for TAP to satisfy multifactor authentication (MFA) to set up Windows Hello for Business. Instead, they are redirected to the federated Identity Provider (IdP) for multifactor authentication (MFA).

:::image type="content" border="true" source="./media/how-to-authentication-temporary-access-pass/windows-10-tap.png" alt-text="Screenshot of how to enter Temporary Access Pass when setting up Windows.":::

### Using TAP with Microsoft Authenticator 

Users can also use their TAP to register Microsoft Authenticator with their account. By adding a work or school account and signing in with a TAP users can register both passkeys and passwordless phone sign-in directly from the Authenticator app. 

For more information, see [Add your work or school account to the Microsoft Authenticator app](https://support.microsoft.com/account-billing/add-your-work-or-school-account-to-the-microsoft-authenticator-app-43a73ab5-b4e8-446d-9e54-2a4cb8e4e93c).

:::image type="content" border="true" source="./media/how-to-authentication-temporary-access-pass/enter-work-school.png" alt-text="Screenshot of how to enter a Temporary Access Pass using work or school account.":::

### Guest access

You can add a TAP as a sign-in method to an internal guest, but not other types of guests. An internal guest has user object **UserType** set to **Guest**. They have authentication methods registered in Microsoft Entra ID. For more information about internal guests and other guest accounts, see [B2B guest user properties](/entra/external-id/user-properties).

If you try to add a TAP to an external guest account in the Microsoft Entra admin center or in Microsoft Graph, you'll receive an error stating **Temporary Access Pass cannot be added to an external guest user.**

External guest users can sign-in to a resource tenant with a TAP issued by their home tenant if the TAP meets the home tenant authentication requirements and Cross Tenant Access policies have been configured to trust MFA from the users home tenant, see [Manage cross-tenant access settings for B2B collaboration](/entra/external-id/cross-tenant-access-settings-b2b-collaboration). 

### Expiration

An expired or deleted TAP can’t be used for interactive or non-interactive authentication. 

Users need to reauthenticate with different authentication methods after the TAP is expired or deleted.

The token lifetime (session token, refresh token, access token, and so on) obtained by using a TAP sign-in is limited to the TAP lifetime. When a TAP expires, it leads to the expiration of the associated token.

## Delete an expired Temporary Access Pass

Under the **Authentication methods** for a user, the **Detail** column shows when the TAP expired. You can delete an expired TAP using the following steps:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Authentication Administrator](~/identity/role-based-access-control/permissions-reference.md#authentication-administrator).
1. Browse to **Entra ID** > **Users**, select a user, such as *Tap User*, then choose **Authentication methods**.
1. On the right-hand side of the **Temporary Access Pass** authentication method shown in the list, select **Delete**.

You can also use PowerShell:

```powershell
# Remove a user's Temporary Access Pass
Remove-MgUserAuthenticationTemporaryAccessPassMethod -UserId user3@contoso.com -TemporaryAccessPassAuthenticationMethodId 00aa00aa-bb11-cc22-dd33-44ee44ee44ee
```

For more information, see [Remove-MgUserAuthenticationTemporaryAccessPassMethod](/powershell/module/microsoft.graph.identity.signins/remove-mguserauthenticationtemporaryaccesspassmethod?view=graph-powershell-1.0&preserve-view=true&viewFallbackFrom=graph-powershell-beta).

## Replace a Temporary Access Pass 

- Each user can only have one TAP. The passcode can be used during the start and end time of the TAP.
- If a user requires a new TAP:
  - If the existing TAP is valid, the admin can create a new TAP to override the existing valid TAP.  
  - If the existing TAP has expired, a new TAP overrides the existing TAP.

For more information about NIST standards for onboarding and recovery, see [NIST Special Publication 800-63A](https://pages.nist.gov/800-63-3/sp800-63a.html#sec4).

## Limitations

Keep these limitations in mind:

- When using a one-time TAP to register a passwordless method such as a FIDO2 security key or phone sign-in, the user must complete the registration within 10 minutes of sign-in with the one-time TAP. This limitation doesn't apply to a TAP that can be used more than once.
- Users in scope for self service password reset (SSPR) registration policy *or* [Microsoft Entra ID Protection multifactor authentication registration policy](~/id-protection/howto-identity-protection-configure-mfa-policy.md) are required to register authentication methods after they've signed in with a TAP using a browser. 
Users in scope for these policies are redirected to the [Interrupt mode of the combined registration](concept-registration-mfa-sspr-combined.md#combined-registration-modes). This experience doesn't currently support FIDO2 and phone sign-in registration. 
- A TAP can't be used with the Network Policy Server (NPS) extension and Active Directory Federation Services (AD FS) adapter.
- It can take a few minutes for changes to replicate. Because of this, after a TAP is added to an account, it can take a while for the prompt to appear. For the same reason, after a TAP expires, users may still see a prompt for TAP. 

## Troubleshooting    

- If a TAP isn't offered to a user during sign-in:
  - Make sure the user is in scope for TAP use in the Authentication methods policy.
  - Make sure the user has a valid TAP, and if it's one-time use, it wasn’t used yet.
- If **Temporary Access Pass sign in was blocked due to User Credential Policy** appears during sign-in with a TAP:
  - Check that the user is in scope for the TAP policy
  - Make sure the user doesn't have a TAP for multiple use while the Authentication methods policy requires a one-time TAP.
  - Check if a one-time TAP was already used.
- If **Temporary Access Pass cannot be added to an external guest user** appears when you try to add a TAP to an account as an authentication method, the account is an external guest. Both internal and external guest accounts have an option to add a TAP for sign-in in the Microsoft Entra admin center and Microsoft Graph APIs. However, only internal guest accounts can be issued a TAP. 

## Next steps

- [Plan a passwordless authentication deployment in Microsoft Entra ID](howto-authentication-passwordless-deployment.md)
