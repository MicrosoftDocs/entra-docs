---
title: How to enable QR code authentication in Microsoft Entra ID (preview)
description: Learn about how to enable QR code authentication method in Microsoft Entra ID to help improve and secure sign-in events for frontline workers.

ms.service: entra-id
ms.subservice: authentication
ms.topic: conceptual
ms.date: 12/15/2024

ms.author: justinha
author: aanjusingh
ms.reviewer: anjusingh
manager: amycolannino

# Customer intent: As an identity administrator, I want to understand how to enable QR code authentication in Microsoft Entra ID to improve and secure user sign-in events for frontline workers
---

# How to enable the QR code authentication method in Microsoft Entra ID (Preview)

This topic covers how to enable the QR code authentication method in the Authentication methods policy in Microsoft Entra ID. It also covers how to manage QR code authentication method for users, and how they can sign in with a QR code and PIN. 

## Prerequisites to enable the QR code authentication method

- Microsoft Entra ID tenant with at least an F1, F3 or P1 license. 
- Android, iOS or iPadOS (iOS/iPadOS version 15.0 or later) shared devices. 
- [Optional but highly recommended] Shared device mode enabled on the shared devices. 
- A printer to print 2" x 2" QR codes. 
- Teams app installed on the shared device (Android version 1.0.0.2024143204 or later and iOS version 1.0.0.77.2024132501 or later)
- [Enable and setup MyStaff portal](~/identity/role-based-access-control/my-staff-configure.md#how-to-enable-my-staff) if you plan for frontline managers to use MyStaff to provision, manage, and reset QR code and PINs. 

## Enable QR code authentication method

You can enable the QR code authentication method by using the Microsoft Entra admin center or Microsoft Graph API. 

### Enable QR code authentication method in the Microsoft Entra admin center

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Authentication Policy Administrator](~/identity/role-based-access-control/permissions-reference.md#authentication-policy-administrator).
1. Browse to **Protection** > **Authentication methods** > **Policies**.
1. Click **QR code** > **Enable and target** > **Add target** > select a group of users who need to sign in with a QR code. 


1. Update default QR code settings as needed:
   - By default, the PIN length is 8 digits. The PIN length can be 8 to 20 digits. If you increase the PIN length, the new value becomes the minimum number of digits required for the PIN. For example, if you increase the PIN length to 10, a user needs to create a PIN with at least 10 digits when they are forced to change their PIN.
   - The default lifetime of a standard QR code (provided to the users for long term use) is 365 days. The range is between 1-395 days.

### Enable QR code authentication method in Microsoft Graph API

This example enables QR code authentication for a group, with a PIN length of 10 digits, and a Standard QR code lifetime of 395 days:

- **Request**

  ```https
  PATCH https://graph.microsoft.com/beta/policies/authenticationMethodsPolicy/authenticationMethodConfigurations/qrCodePin
  {
    "@odata.type" : "microsoft.graph.qrCodePinAuthenticationMethodConfiguration", 
    "id": "qrCodePin", 
    "state": "enabled", 
    "includeTargets": [{ 
      "targetType": "group", 
      "id": "b185b746-e7db-4fa2-bafc-69ecf18850dd", 
      }], 
    "excludeTargets": [], 
    "standardQRCodeLifetimeInDays":395,
    "pinLength": 10
  }
  ```

- **Response**

  ```https
  204 No Response
  ```

## Add QR code authentication method for a user

You can add a QR code authentication method for a user by using the Microsoft Entra admin center, My Staff, or Microsoft Graph API. 

### Add QR code authentication method for a user in the Microsoft Entra admin center

1. Navigate to **Users** > select a user > **Authentication methods** > click **Add authentication method** and choose **QR code**.

   :::image type="content" source="media/how-to-authentication-qr-code/choose-qr-code.png" alt-text="Screenshot of how to choose QR code for a user.":::

1. Modify the expiration date for the user if needed, set **Activation time**, and provide or generate a temporary PIN. When ready, click **Add** to add the QR code authentication method for the user.

   :::image type="content" source="media/how-to-authentication-qr-code/add-qr-code.png" alt-text="Screenshot of how to add QR code for a user.":::

1. Save the PIN, and click **Download image** to download and print the QR code. The QR code image download has the smallest optimum print size. If you reduce the size, the QR code is hard to scan. 

   You can't regenerate the same QR code because it has a unique secret. If the QR code can’t work for some reason, delete it. Create a new QR code for the user.

   :::image type="content" source="media/how-to-authentication-qr-code/download-qr-code.png" alt-text="Screenshot of how to download the QR code image for a user.":::

1. The QR code authentication method is listed in usable authentication methods for the user.

   :::image type="content" source="media/how-to-authentication-qr-code/usable-authentication-methods.png" alt-text="Screenshot of the QR code authentication method listed in usable authentication methods for a user.":::

### Add QR code authentication method for a user in My Staff

1. Sign in to the MyStaff portal as a frontline manager. Select an administrative unit (AU) and a frontline worker.

   :::image type="content" border="true" source="media/how-to-authentication-qr-code/select-admin-unit.png" alt-text="Screenshot of how to select an admin unit.":::

   :::image type="content" border="true" source="media/how-to-authentication-qr-code/select-user.png" alt-text="Screenshot of how to select a user.":::

1. Click **Manage QR code authentication method**.

   :::image type="content" border="true" source="media/how-to-authentication-qr-code/manage-qr-code-authentication-method.png" alt-text="Screenshot of how to manage a QR code authentication method.":::

1. Click **Add QR code method**.

   :::image type="content" border="true" source="media/how-to-authentication-qr-code/add-qr-code-authentication-method.png" alt-text="Screenshot of how to add a QR code authentication method.":::

1. Specify the expiration and activation date, and click **Add** to generate a QR code and PIN for the user.

   :::image type="content" border="true" source="media/how-to-authentication-qr-code/activation-date.png" alt-text="Screenshot of how to set the activation date for a QR code authentication method.":::

1. Save the PIN, and click **Download QR image** to download the QR code to print. The QR code image download has the smallest optimum print size. If you reduce the size, the QR code is hard to scan. You can't regenerate the same QR code because it has a unique secret. If the QR code can’t work for some reason, delete it. Create a new QR code for the user.

   :::image type="content" border="true" source="media/how-to-authentication-qr-code/qr-code-done.png" alt-text="Screenshot of a QR code authentication method after an administrator adds it.":::

### Add QR code authentication method for a user in Microsoft Graph API

This example adds QR code authentication method for a user: 

:::image type="content" border="true" source="media/how-to-authentication-qr-code/add-qr-code-graph.png" alt-text="Screenshot of Microsoft Graph response after you add a QR code authentication method for a user.":::

This example confirms whether QR code authentication method is added for the user:

:::image type="content" border="true" source="media/how-to-authentication-qr-code/confirm-add-qr-code-graph.png" alt-text="Screenshot of confirmation after you add a QR code authentication method for a user.":::


## Edit the QR code authentication method for a user

You can edit QR code authentication method for a user by using the Microsoft Entra admin center, My Staff, or Microsoft Graph API. 

### Edit the QR code authentication method for a user in the Microsoft Entra admin center

- Navigate to the usable authentication methods for a user, and click **Edit** to edit the properties of the QR code authentication method.

  :::image type="content" source="media/how-to-authentication-qr-code/edit-usable-authentication-method.png" alt-text="Screenshot of how to edit the usable authentication method for a user.":::

- Change the expiration time for the standard QR code, and click **Save**.

  :::image type="content" source="media/how-to-authentication-qr-code/change-expiration.png" alt-text="Screenshot of how to change the expiration date.":::

- Delete a standard QR code. You might want to delete the standard QR code if it's reported as expired, compromised, or stolen. 
  
  :::image type="content" source="media/how-to-authentication-qr-code/delete-qr-code.png" alt-text="Screenshot of how to delete a QR code.":::

  After you delete the standard QR code, click the add symbol (**+**) to add a new standard QR code for the user. 
  The deleted QR code is no longer valid for login. 
  
  You need to print and distribute the new QR code to the user. 
  The user can continue to use their existing PIN. 
  
  If you want the user to update the PIN, you can delete the QR code authentication method for the user, and add it back again to generate a new Standard QR code and temporary PIN. The user needs to use the new QR code and update the PIN on when they first sign in. 

  :::image type="content" source="media/how-to-authentication-qr-code/replace-qr-code.png" alt-text="Screenshot of how to replace a lost or stolen QR code.":::

- Reset a PIN. Click the pencil icon after the masked PIN. Click **Generate new PIN** to create a new temporary PIN. The user is forced to change the temporary PIN when they next sign in. Copy the temporary PIN and share it with the frontline worker. 

  :::image type="content" source="media/how-to-authentication-qr-code/reset-pin.png" alt-text="Screenshot of how to reset a PIN.":::

- Add or delete a temporary QR code. A temporary QR code reduces admin overhead of printing the QR code on badge if a user forgets their badge. It also reduces the stress of retaining the QR code after their shift. A temporary QR code has a lifetime of 1-12 hours and can be activated instantly or later. 
You can delete the temporary QR code. The QR code is unusable after its expiry.

  :::image type="content" source="media/how-to-authentication-qr-code/add-temporary-qr-code.png" alt-text="Screenshot of how to add a temporary QR code.":::

  :::image type="content" source="media/how-to-authentication-qr-code/download-temporary-qr-code.png" alt-text="Screenshot of how to download a temporary QR code.":::

### Edit the QR code authentication method for a user in My Staff

- To edit the expiration date for a standard QR code, click **Edit**. Edit the expiration date and save the changes.

  :::image type="content" border="true" source="media/how-to-authentication-qr-code/edit-qr-code-my-staff.png" alt-text="Screenshot of how to edit a QR code in My Staff.":::

- To delete Standard QR code, click **Delete**. Confirm the action.

  :::image type="content" border="true" source="media/how-to-authentication-qr-code/delete-qr-code-my-staff.png" alt-text="Screenshot of how to delete a QR code in My Staff.":::

- To add a new standard QR code, click **Add new** next to the standard QR code.

  :::image type="content" border="true" source="media/how-to-authentication-qr-code/add-new-qr-code-my-staff.png" alt-text="Screenshot of how to add a new a QR code in My Staff.":::

  Select the activation time and expiration date for the QR Code. 

  :::image type="content" border="true" source="media/how-to-authentication-qr-code/select-qr-code-expiration-my-staff.png" alt-text="Screenshot of how to select the expiration date of a QR code in My Staff.":::

  Click **Add** to view the QR code for this user.

  :::image type="content" border="true" source="media/how-to-authentication-qr-code/view-qr-code-my-staff.png" alt-text="Screenshot of how to view a newly added QR code in My Staff.":::

- To add a temporary QR code, click **Add new** next to the temporary QR code. Specify the **Lifetime in hours** and the **Activation date**.

  :::image type="content" border="true" source="media/how-to-authentication-qr-code/set-temporary-qr-code-expiration.png" alt-text="Screenshot of how to set the expiration date for a temporary QR code.":::

  Click **Add** to view the QR code for this user.

  :::image type="content" border="true" source="media/how-to-authentication-qr-code/view-temporary-qr-code-my-staff.png" alt-text="Screenshot of how to view a temporary QR code in My Staff.":::

- To reset a PIN, click **Reset PIN**. 

  :::image type="content" border="true" source="media/how-to-authentication-qr-code/reset-pin-my-staff.png" alt-text="Screenshot of how to reset a PIN in My Staff.":::

  Click **Copy PIN** to copy the PIN to your clipboard.

  :::image type="content" border="true" source="media/how-to-authentication-qr-code/copy-pin-my-staff.png" alt-text="Screenshot of how to copy a PIN in My Staff.":::

### Edit the QR code authentication method for a user in Microsoft Graph API

- This example shows how to delete the standard QR code for a user if they lose their badge, and create a new standard QR code. The user isn't required to change their PIN.

  :::image type="content" border="true" source="media/how-to-authentication-qr-code/delete-standard-qr-code-graph.png" alt-text="Screenshot of how to delete a standard QR code for a user in Microsoft Graph.":::

  :::image type="content" border="true" source="media/how-to-authentication-qr-code/replace-qr-code-graph.png" alt-text="Screenshot of how to replace a deleted standard QR code for a user in Microsoft Graph.":::

  :::image type="content" border="true" source="media/how-to-authentication-qr-code/get-standard-qr-code-graph.png" alt-text="Screenshot of how to get a deleted standard QR code for a user in Microsoft Graph.":::

- This example shows how to create a temporary QR code for a user. The user can use the existing PIN. 

  :::image type="content" border="true" source="media/how-to-authentication-qr-code/add-temporary-qr-code-graph.png" alt-text="Screenshot of how to add a temporary QR code for a user in Microsoft Graph.":::

  :::image type="content" border="true" source="media/how-to-authentication-qr-code/get-temporary-qr-code-graph.png" alt-text="Screenshot of how to get a temporary QR code for a user in Microsoft Graph.":::

- This example shows how to delete a temporary QR code for a user.  

  :::image type="content" border="true" source="media/how-to-authentication-qr-code/delete-temporary-qr-code-graph.png" alt-text="Screenshot of how to delete a temporary QR code for a user in Microsoft Graph.":::

- This example shows how to reset the PIN a QR code authentication method.

  :::image type="content" border="true" source="media/how-to-authentication-qr-code/reset-pin-qr-code-graph.png" alt-text="Screenshot of how to reset the PIN for the QR code for a user in Microsoft Graph.":::

- This example shows how to force a user to change their PIN for a QR code authentication method.

  :::image type="content" border="true" source="media/how-to-authentication-qr-code/force-pin-change-graph.png" alt-text="Screenshot of how to force a user to change the PIN of their QR code authentication method.":::

## Delete the QR code authentication method for a user

You can delete the QR code authentication method for a user by using the Microsoft Entra admin center, My Staff, or Microsoft Graph API. 

### Delete the QR code authentication method for a user in the Microsoft Entra admin center

If a QR code authentication method is deleted for a user, they can no longer sign in by using that authentication method. 

Navigate to **Users** > **User** > **Usable authentication methods**.

:::image type="content" border="true" source="media/how-to-authentication-qr-code/delete-qr-code-method-admin-center.png" alt-text="Screenshot of how to delete the QR code authentication method for a user in the Microsoft Entra admin center.":::

### Delete the QR code authentication method for a user in in My Staff

1. To delete QR code auth method itself, click **Delete QR code method**.

   :::image type="content" border="true" source="media/how-to-authentication-qr-code/delete-qr-code-method-my-staff.png" alt-text="Screenshot of how to delete the QR code authentication method in My Staff.":::

1. Click **Delete** to confirm the action.

   :::image type="content" border="true" source="media/how-to-authentication-qr-code/confirm-delete-qr-code-method-my-staff.png" alt-text="Screenshot of how to confirm deletion of the QR code authentication method in My Staff.":::


### Delete the QR code authentication method for a user in Microsoft Graph API

:::image type="content" border="true" source="media/how-to-authentication-qr-code/delete-qr-code-graph.png" alt-text="Screenshot of how to delete a QR code in Microsoft Graph.":::

## Sign in to Microsoft Teams with a QR code

Microsoft Teams accelerates sign in with a QR code. An Authentication Policy Administrator neeeds to configure Intune or another MDM solution to enable the QR code authentication method for mobile devices. 

### Enable sign-in with a QR code in Teams

| Platform | MDM app config key    | Value | Configuration location |
|----------|-----------------------|-------|------------------------|
| iOS      | preferred_auth_config | qrpin | Device management profile, which configures a single sign-on (SSO) extension |
| Android  | preferred_auth_config | qrpin | Microsoft Authenticator |

### Sign-in with a QR code to Teams 

Users need to [download Teams](https://aka.ms/teamsmobiledownload):

- For iOS and iPad, you need Teams version 1.0.0.77.2024132501 or later 
- For Android, you need Teams version 1.0.0.2024143204 or later 

1. Click **Sign-in with QR code** in Microsoft Teams.
    
   :::image type="content" border="true" source="media/how-to-authentication-qr-code/sign-in.png" alt-text="Screenshot of how to sign in to Teams with a QR code and PIN.":::

1. Scan the QR code. Give consent if asked for camera permission.
1. Enter your PIN.
1. If this is your first sign-in, update your PIN.
1. You're now signed in to the app

   :::image type="content" border="true" source="media/how-to-authentication-qr-code/sign-in-qr-code.png" alt-text="Screenshot of a successful sign-in to Teams with a QR code and PIN.":::

1. If you sign in with a temporary PIN, you need to change it. 

   :::image type="content" border="true" source="media/how-to-authentication-qr-code/sign-in.png" alt-text="Screenshot of how to sign in to Teams with a QR code and PIN.":::

## Sign in to login.microsoftonline.com with a QR code 

1. Click **More sign-in options** > **Sign in to an organization** > **Sign in with QR code**.

   :::image type="content" border="true" source="media/how-to-authentication-qr-code/sign-in-qr-code.png" alt-text="Screenshot of how to sign in to Microsoft with a QR code and PIN.":::

1. Allow the camera when prompted > scan the QR code > enter your PIN > you're successfully signed in.

   :::image type="content" border="true" source="media/how-to-authentication-qr-code/enter-pin.png" alt-text="Screenshot of how to enter your PIN.":::

## Restrict the QR code authentication method to only frontline workers and shared devices 

This section covers how to create policies that restrict QR code authentication method to only frontline workers and shared devices.

### Restrict a QR + PIN to frontline workers  

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Authentication Policy Administrator](~/identity/role-based-access-control/permissions-reference.md#authentication-policy-administrator).
1. Browse to **Protection** > **Authentication methods** > **QR code** > **Enable and target**.
1. Click **Add target** > select the **Pilot users** group, which only include frontline workers. This group selection restricts enablement of the QR code authentication method only to frontline workers added to the **Pilot users** group. 

   :::image type="content" border="true" source="media/how-to-authentication-qr-code/add-groups-and-roles.png" alt-text="Screenshot of the Microsoft Entra admin center that shows how to add groups to the QR code settings.":::

### Restrict a QR + PIN to shared devices 

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as a [Conditional Access Administrator](~/identity/role-based-access-control/permissions-reference.md#conditional-access-administrator). 
1. Create a custom authentication strength Conditional Access policy and select all authentication combinations except QR + PIN.  

   :::image type="content" border="true" source="media/how-to-authentication-qr-code/configure-authentication-strength.png" alt-text="Screenshot of the Microsoft Entra admin center that shows how to select method combinations for an authentication strength.":::

1. Create a Conditional Access policy to enforce the authentication strength policy, and restrict usage of QR + PIN from any device type except shared devices. 
   1. Under **Users or workload identities**, select **All Users**.  
   1. Under **Target resources** > **Include** > select **All cloud apps**.
   1. Under **Conditions** > **Filter for devices** > **Exclude filtered devices from policy** > **ProfileType** **Equals** **Shared**. 
   1. Under **Grant** > **Grant access** > select **Require authentication strength**.  

1. Create a Conditional Access policy that requires shared devices be marked as compliant with policies from Intune or other mobile device management (MDM) solution. This policy makes sure that frontline workers can access only specific resources from a compliant, shared device by using QR + PIN, or another registered authentication method. 
   1. Under **Users or workload identities** > **Include** > select **Users and groups**, and choose your frontline worker group. 
   1. Under **Target resources** > **Cloud apps** > **Include** > select specific resources that frontline workers can access.
   1. Under **Conditions** > **Filter for devices** > **Configure** > select **Yes** > **Include filtered devices from policy** > **ProfileType** **Equals** **Shared**.
   1. Under **Access controls** > **Grant** > select **Require device to be marked as compliant**.

## Related content

[Authentication methods in Microsoft Entra ID - QR code authentication method (Preview)](concept-authentication-qr-code.md)


