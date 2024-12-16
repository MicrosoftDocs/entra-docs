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
- [Enable and setup MyStaff portal](~/role-based-access-control/my-staff-configure.md#how-to-enable-my-staff) if you plan for frontline managers to use MyStaff to provision, manage, and reset QR code and PINs. 

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

1. Specify the expiration and activation date, and click **Add**.

   :::image type="content" border="true" source="media/how-to-authentication-qr-code/activation-date.png" alt-text="Screenshot of how to set the activation date for a QR code authentication method.":::

1. to generate a QR code and PIN for the user.
1. Save the PIN, and click **Download image** to download the QR code to print. The QR code image download has the smallest optimum print size. If you reduce the size, the QR code is hard to scan. You can't regenerate the same QR code because it has a unique secret. If the QR code can’t work for some reason, delete it. Create a new QR code for the user.

   :::image type="content" border="true" source="media/how-to-authentication-qr-code/qr-code-done.png" alt-text="Screenshot of a QR code authentication method after an administrator adds it.":::

### Add QR code authentication method for a user in Microsoft Graph API

This example adds QR code authentication method for a user: 

:::image type="content" border="true" source="media/how-to-authentication-qr-code/add-qr-code-graph.png" alt-text="Screenshot of Microsoft Graph response after you add a QR code authentication method for a user.":::

This example confirms whether QR code authentication method is added for the user:

:::image type="content" border="true" source="media/how-to-authentication-qr-code/confirm-add-qr-code-graph.png" alt-text="Screenshot of confirmation after you add a QR code authentication method for a user.":::


## Edit the QR code authentication method for a user

You can edit QR code authentication method for a user by using the Microsoft Entra admin center, My Staff, or Microsoft Graph API. 

### Edit the QR code authentication method for a user in the Microsoft Entra admin center

1. Navigate to the usable authentication methods for a user, and click **Edit** to edit the properties of the QR code authentication method.

   :::image type="content" border="true" source="media/how-to-authentication-qr-code/qr-code-done.png" alt-text="Screenshot of a QR code authentication method after an administrator adds it.":::

1. Change the expiration time for the standard QR code
Edit expiration of Standard QR code and click ‘save’ to save the changes

2.	Delete/ add Standard QR code
You might want to delete the Standard QR code if it is reported as stolen/expired/compromised. After deleting the standard QR code, you will see the add symbol (+) to add new Standard QR code (note – the deleted QR code won't be valid for login). The newly added QR code needs to be printed and distributed to the end-user. The user will be able to continue using their existing PIN. If you want the user to update the PIN as well, you can delete the QR code auth method for the user and add it back again to generate a new Standard QR code and temporary PIN. User will need to use the new QR code and update the PIN on first login. 

3.	Reset PIN. Generate new PIN to create a new temporary PIN by clicking the pencil icon besides the masked PIN. User will be forced to change the temporary PIN on next sign-in attempt. Copy the temporary PIN and share with frontline worker. 

4.	Add/delete Temporary QR code
Temporary QR code is to reduce the admin overhead of printing the QR code on badge if user forgot to bring the badge to work. It also reduces the stress of retaining the QR code after their shift. Temporary QR code has a lifetime of 1-12 hours and can be activated instantly or later. 
You will have the option to delete the temporary QR code. The QR code will be unusable after its expiry.


### Edit the QR code authentication method for a user in My Staff

1.	To edit the expiration date for the Standard QR code, select the Edit option as shown below,

Edit the expiration date and save the changes

2.	To delete Standard QR code, select the delete option for the QR code

Confirm the action 

3.	To add a new Standard QR code, select the Add New option next to the Standard QR code.

Select the activation and expiration date for the QR Code

Hit Add and view the QR Code and PIN that has been generated for this user

4.	Add a temporary QR code

Specify the Lifetime (in hours) and the Activation Date for this Temporary QR code

Click “Add” and download / print this QR code image as needed

5.	Reset PIN

Click “Reset PIN”

Click on “Copy PIN” to copy the PIN to your clipboard



### Edit the QR code authentication method for a user in Microsoft Graph API


1.	Delete the Standard QR code on existing authentication if badge is lost and create a new one. User will not be required to go through PIN change process.

2.	Create Temporary QR code for existing authentication method. User will be able to use the existing PIN. 

3.	Delete Temporary QR code for existing authentication method.  

4.	Reset PIN for existing authentication method

5.	Force change pin for existing authentication method

## Delete the QR code authentication method for a user

You can delete QR code authentication method for a user by using the Microsoft Entra admin center, My Staff, or Microsoft Graph API. 

### Delete the QR code authentication method for a user in the Microsoft Entra admin center

If QR code authentication method is deleted for a user, they will no longer be able to sign-in using this auth method. 
1.	Navigate to Users > User > Usable authentication methods

### Delete the QR code authentication method for a user in in My Staff

1.	To delete QR code auth method itself, click **Delete QR code method**.

2.	Confirm the action by clicking on the “Delete” button in the dialog

### Delete the QR code authentication method for a user in Microsoft Graph API

## Sign in to Microsoft Teams with a QR code

Microsoft Teams accelerates sign in with a QR code. An Authentication Policy Administrator neeeds to configure Intune or another MDM solution to enable the QR code authentication method for mobile devices. 

### Enable sign-in with QR code in Teams

| Platform | MDM app config key | Value | Configuration location |
|----------|-------------|-------|------------------------|			
| iOS | preferred_auth_config | qrpin | Device management profile which configures SSO extension | 
| Android | preferred_auth_config | qrpin | Microsoft Authenticator app |


### Sign-in with a QR code to Teams 

Users need to download Teams version 1.0.0.2024143204 or later from Google PlayStore, or Teams version 1.0.0.77.2024132501 or later from Apple AppStore. 

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

1. Allow camera when prompted > scan the QR code > enter your PIN > you're successfully signed in.

   :::image type="content" border="true" source="media/how-to-authentication-qr-code/enter-pin.png" alt-text="Screenshot of how to enter your PIN.":::

## Restrict QR code authentication method to only frontline workers and shared devices 

This section covers how to create policies that restrict QR code authentication method to only frontline workers and shared devices.

### Restrict QR + PIN to frontline workers  

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Authentication Policy Administrator](~/identity/role-based-access-control/permissions-reference.md#authentication-policy-administrator).
1. Browse to **Protection** > **Authentication methods** > **QR code** > **Enable and target**.
1. Click **Add target** > select the **Pilot users** group, which only include frontline workers. This group selection restricts enablement of the QR code authentication method only to frontline workers added to the **Pilot users** group. 

   :::image type="content" border="true" source="media/how-to-authentication-qr-code/add-groups-and-roles.png" alt-text="Screenshot of the Microsoft Entra admin center that shows how to add groups to the QR code settings.":::

### Restrict QR + PIN to shared devices 

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as a [Conditional Access Administrator](~/identity/role-based-access-control/permissions-reference.md#conditional-policy-administrator). 
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


