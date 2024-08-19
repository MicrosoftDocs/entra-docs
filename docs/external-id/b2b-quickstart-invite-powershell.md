---
title: 'Quickstart: Add a guest user with PowerShell'
description: In this quickstart, you learn how to use PowerShell to send an invitation to a Microsoft Entra B2B collaboration user. You'll use the Microsoft Graph Identity Sign-ins and the Microsoft Graph Users PowerShell modules.
 
ms.author: cmulligan
author: csmulligan
manager: CelesteDG
ms.date: 08/19/2024
ms.topic: quickstart
ms.service: entra-external-id
ms.custom: it-pro, mode-api, has-azure-ad-ps-ref, azure-ad-ref-level-one-done
ms.collection: M365-identity-device-management
#Customer intent: As an administrator, I want to add a guest user to my Microsoft Entra directory and send them an invitation via PowerShell, so that they can collaborate with my organization using their own work, school, or social account.
---

# Quickstart: Add a guest user with PowerShell

[!INCLUDE [applies-to-workforce-only](./includes/applies-to-workforce-only.md)]

There are many ways you can invite external partners to your apps and services with Microsoft Entra B2B collaboration. In the previous quickstart, you saw how to add guest users directly in the Microsoft Entra admin center. You can also use PowerShell to add guest users, either one at a time or in bulk. In this quickstart, you’ll use the New-MgInvitation command to add one guest user to your Microsoft Entra tenant.

If you don’t have an Azure subscription, create a [free account](https://azure.microsoft.com/free/?WT.mc_id=A261C142F) before you begin.

## Prerequisites


To complete the scenario in this quickstart, you need:

- A role that allows you to create users in your tenant directory, such as at least a [Guest Inviter role](~/identity/role-based-access-control/permissions-reference.md#guest-inviter) or a [User Administrator](~/identity/role-based-access-control/permissions-reference.md#user-administrator).
- Install the [Microsoft Graph Identity Sign-ins module](/powershell/module/microsoft.graph.identity.signins/?viewFallbackFrom=graph-powershell-beta&preserve-view=true&view=graph-powershell-1.0) (Microsoft.Graph.Identity.SignIns) and the [Microsoft Graph Users module](/powershell/module/microsoft.graph.users/?viewFallbackFrom=graph-powershell-beta&preserve-view=true&view=graph-powershell-1.0) (Microsoft.Graph.Users). You can use the `#Requires` statement to prevent running a script unless the required PowerShell modules are met.

```powershell
#Requires -Modules Microsoft.Graph.Identity.SignIns, Microsoft.Graph.Users
```

- Get a test email account. You need a test email account that you can send the invitation to. The account must be from outside your organization. You can use any type of account, including a social account such as a gmail.com or outlook.com address.

## Sign in to your tenant

Run the following command to connect to the tenant domain:

```powershell
Connect-MgGraph -Scopes 'User.ReadWrite.All'
```

When prompted, enter your credentials.

## Send an invitation

1. To send an invitation to your test email account, run the following PowerShell command (replace **"Henry Ross"** and **<henry@contoso.com>** with your test email account name and email address):

   ```powershell
   New-MgInvitation -InvitedUserDisplayName "Henry Ross" -InvitedUserEmailAddress henry@contoso.com -InviteRedirectUrl "https://myapplications.microsoft.com" -SendInvitationMessage:$true
   ```

1. The command sends an invitation to the email address specified. Check the output, which should look similar to the following example:

   ```Output
   Id                                   InviteRedeemUrl                                                                                                   
   --                                   ---------------                                                                                                   
   00aa00aa-bb11-cc22-dd33-44ee44ee44ee https://login.microsoftonline.com/redeem?...
   ```

## Verify the user exists in the directory

1. To verify that the invited user was added to Microsoft Entra ID, run the following command (replace **henry@contoso.com** with your invited email):

   ```powershell
   Get-MgUser -Filter "Mail eq 'henry@contoso.com'"
   ```

1. Check the output to make sure the user you invited is listed, with a user principal name (UPN) in the format *emailaddress*#EXT#\@*domain*. For example, *henry_contoso.com#EXT#\@fabrikam.onmicrosoft.com*, where fabrikam.onmicrosoft.com is the organization from which you sent the invitations.

   ```Output
   Id                                   DisplayName              Mail                           UserPrincipalName        
   --                                   -----------              ----                           -----------------               
   00aa00aa-bb11-cc22-dd33-44ee44ee44ee Henry Ross           henry@contoso.com           henry@contoso.com
   ```

## Clean up resources

When no longer needed, you can delete the test user account in the directory. Run the following command to delete a user account:

```powershell
 Remove-MgUser -UserId '<String>'
```

For example:

```powershell
Remove-MgUser -UserId 'henry_contoso.com#EXT#@fabrikam.onmicrosoft.com'
```

or

```powershell
Remove-MgUser -UserId '00aa00aa-bb11-cc22-dd33-44ee44ee44ee'
```

## Next steps
In this quickstart, you invited and added a single guest user to your directory using PowerShell. You can also invite a guest user using the [Microsoft Entra admin center](b2b-quickstart-add-guest-users-portal.md). Additionally you can [invite guest users in bulk using PowerShell](tutorial-bulk-invite.md). 
