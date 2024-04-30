---

title: Reset redemption status for a guest user
description: Learn how to reset the invitation redemption status for a Microsoft Entra B2B guest users in Microsoft Entra External ID.

 
ms.service: entra-external-id
ms.topic: how-to
ms.date: 03/26/2024

ms.author: cmulligan
author: csmulligan
manager: celestedg

ms.collection: M365-identity-device-management
# Customer intent: As an admin managing guest users in B2B collaboration, I want to reset the redemption status for a guest user, so that I can update their sign-in information and reinvite them without deleting their account.
---

# Reset redemption status for a guest user

In this article, you'll learn how to update the [guest user's](user-properties.md) sign-in information after they've redeemed your invitation for B2B collaboration. There might be times when you'll need to update their sign-in information, for example when:

- The user wants to sign in using a different email and identity provider
- The account for the user in their home tenant has been deleted and re-created
- The user has moved to a different company, but they still need the same access to your resources
- The user’s responsibilities have been passed along to another user

To manage these scenarios previously, you had to manually delete the guest user’s account from your directory and reinvite the user. Now you can use the Microsoft Entra admin center, PowerShell or the Microsoft Graph invitation API to reset the user's redemption status and reinvite the user while keeping the user's object ID, group memberships, and app assignments. When the user redeems the new invitation, the UserPrincipalName (UPN) of the user doesn't change, but the user's sign-in name changes to the new email. Then the user can sign in using the new email or an email you've added to the `otherMails` property of the user object.

<a name='required-azure-ad-roles'></a>

## Required Microsoft Entra roles

To reset a user's redemption status, you'll need one of the following roles:

- [Helpdesk Administrator](~/identity/role-based-access-control/permissions-reference.md#helpdesk-administrator) (least privileged)
- [User Administrator](~/identity/role-based-access-control/permissions-reference.md#user-administrator)
- [Global Administrator](~/identity/role-based-access-control/permissions-reference.md#global-administrator)

## Use the Microsoft Entra admin center to reset redemption status

[!INCLUDE [portal updates](~/includes/portal-update.md)]


1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [User Administrator](~/identity/role-based-access-control/permissions-reference.md#user-administrator).
1. Browse to **Identity** > **Users** > **All users**.
1. In the list, select the user's name to open their user profile.
1. (Optional) If the user wants to sign in using a different email:
   1. Select the **Edit properties** icon.
   1. Scroll to **Email** and type the new email.
   1. Next to **Other emails**, select **Add email**. Select **Add**, type the new email, and select **Save**.
   1. Select the **Save** button at the bottom of the page to save all changes.

1. On the **Overview** tab, under **My Feed**, select the **Reset redemption status** link in the **B2B collaboration** tile.

   :::image type="content" source="media/reset-redemption-status/user-profile-b2b-collaboration.png" alt-text="Screenshot showing the B2B collaboration reset link." lightbox="media/reset-redemption-status/user-profile-b2b-collaboration.png":::

1. Under **Reset redemption status**, select **Reset**.

   :::image type="content" source="media/reset-redemption-status/reset-status.png" alt-text="Screenshot showing the reset invitation status setting.":::

## Use PowerShell or Microsoft Graph API to reset redemption status

### Reset the email address used for sign-in

If a user wants to sign in using a different email:

1. Make sure the new email address is added to the `mail` or `otherMails` property of the user object. 
1. Replace the email address in the `InvitedUserEmailAddress` property with the new email address.
1. Use one of the methods below to reset the user's redemption status.

> [!NOTE]
>- When you're resetting the user's email address to a new address, we recommend setting the `mail` property. This way the user can redeem the invitation by signing into your directory in addition to using the redemption link in the invitation.
>- For app-only calls, the redemption status can't be reset if there are any roles assigned to the target user account.

### Use PowerShell to reset redemption status

```powershell
Install-Module Microsoft.Graph
Connect-MgGraph -Scopes "User.ReadWrite.All"

$user = Get-MgUser -Filter "startsWith(mail, 'john.doe@fabrikam.net')"
New-MgInvitation `
    -InvitedUserEmailAddress $user.Mail `
    -InviteRedirectUrl "https://myapps.microsoft.com" `
    -ResetRedemption `
    -SendInvitationMessage `
    -InvitedUser $user
```

### Use Microsoft Graph API to reset redemption status

To use the [Microsoft Graph invitation API](/graph/api/resources/invitation), set the `resetRedemption` property  to `true` and specify the new email address in the `invitedUserEmailAddress` property.

```json
POST https://graph.microsoft.com/v1.0/invitations  
Authorization: Bearer eyJ0eX...  
ContentType: application/json  
{  
   "invitedUserEmailAddress": "<<external email>>",  
   "sendInvitationMessage": true,  
   "invitedUserMessageInfo": {  
      "messageLanguage": "en-US",  
      "ccRecipients": [  
         {  
            "emailAddress": {  
               "name": null,  
               "address": "<<optional additional notification email>>"  
            }  
         } 
      ],  
      "customizedMessageBody": "<<custom message>>"  
},  
"inviteRedirectUrl": "https://myapps.microsoft.com?tenantId=",  
"invitedUser": {  
   "id": "<<ID for the user you want to reset>>"  
}, 
"resetRedemption": true 
}
```

## Next step

- [Properties of a Microsoft Entra B2B guest user](user-properties.md)

