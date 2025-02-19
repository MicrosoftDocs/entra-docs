---
title: How to enable QR code authentication in Microsoft Entra ID (preview)
description: Learn about how to enable QR code authentication method in Microsoft Entra ID to help improve and secure sign-in events for frontline workers.

ms.service: entra-id
ms.subservice: authentication
ms.topic: conceptual
ms.date: 02/18/2025

ms.author: justinha
author: aanjusingh
ms.reviewer: anjusingh
manager: amycolannino

# Customer intent: As an identity administrator, I want to understand how to enable QR code authentication in Microsoft Entra ID to improve and secure user sign-in events for frontline workers
---

# How to enable the QR code authentication method in Microsoft Entra ID (Preview)

This topic covers how to enable the QR code authentication method in the Authentication methods policy in Microsoft Entra ID. It also covers how to manage the QR code authentication method for users, and how they can sign in with a QR code and PIN. 

## Prerequisites to enable the QR code authentication method

- Microsoft Entra ID tenant with at least an F1, F3, or P1 license. 
- Android, iOS, or iPadOS (iOS/iPadOS version 15.0 or later) shared devices. 
- Shared device mode enabled on the shared devices (optional but highly recommended). 
- A printer to print 2" x 2" QR codes. 
- Teams app installed on the shared device (Android version 1.0.0.2024143204 or later, and iOS version 1.0.0.77.2024132501 or later).
- [Enable and setup My Staff portal](~/identity/role-based-access-control/my-staff-configure.md#how-to-enable-my-staff) if you plan for frontline managers to use My Staff to provision, manage, and reset QR code and PINs. 

## Enable QR code authentication method

You can enable the QR code authentication method by using the Microsoft Entra admin center or Microsoft Graph API. 

### Enable QR code authentication method in the Microsoft Entra admin center

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Authentication Policy Administrator](~/identity/role-based-access-control/permissions-reference.md#authentication-policy-administrator).
1. Go to **Protection** > **Authentication methods** > **Policies**.
1. Click **QR code** > **Enable and target** > **Add target** > select a group of users who need to sign in with a QR code. 

   :::image type="content" border="true" source="media/how-to-authentication-qr-code/enable-qr-code.png" alt-text="Screenshot that shows how to enable QR code for an organization.":::

1. Update default QR code settings as needed:
   - By default, the PIN length is 8 digits. The PIN length can be 8 to 20 digits. If you increase the PIN length, the new value becomes the minimum number of digits required for the PIN. For example, if you increase the PIN length to 10, a user needs to provide a 10-digit PIN during next sign-in.
   - The default lifetime of a standard QR code (provided to the users for long term use) is 365 days. The range is between 1-395 days. You can change the lifetime of a standard QR code for specific user when you add the QR code authentication method for them.

   :::image type="content" border="true" source="media/concept-authentication-qr-code/qr-code-settings.png" alt-text="Screenshot that shows how to updates QR code settings.":::

1. When you're done, click **Save**.

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

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Authentication Administrator](~/identity/role-based-access-control/permissions-reference.md#authentication-administrator).

1. Go to **Users**, select a user, and click **Authentication methods**.

1. Click **Add authentication method** and choose **QR code**.

   :::image type="content" border="true" source="media/how-to-authentication-qr-code/choose-qr-code.png" alt-text="Screenshot that shows how to choose QR code for a user.":::

1. Modify the expiration date for the user if needed. Set **Activation time** to now or later. Provide or generate a temporary PIN. The custom PIN can be specified only when you add the QR code authentication method. A PIN is autogenerated during reset events. When ready, click **Add** to add the QR code authentication method for the user.

   :::image type="content" border="true" source="media/how-to-authentication-qr-code/add-qr-code.png" alt-text="Screenshot that shows how to add QR code for a user.":::

1. Save the PIN, and click **Download image** to download and print the QR code. The QR code image download has the smallest optimal print size. If you reduce the size of the QR code, it may impact QR code scan performance.

   You can't regenerate the same QR code because it has a unique secret. If the QR code can't work for some reason, delete it. Create a new QR code for the user.

   :::image type="content" border="true" source="media/how-to-authentication-qr-code/download-qr-code.png" alt-text="Screenshot that shows how to download the QR code image for a user.":::

1. After you add the QR code authentication method, it appears as a usable authentication method for the user.

   :::image type="content" border="true" source="media/how-to-authentication-qr-code/usable-authentication-methods.png" alt-text="Screenshot that shows the QR code authentication method listed in usable authentication methods for a user.":::

### Add the QR code authentication method for a user in My Staff

[!Include [Add QR code](../../includes/add-qr-code-my-staff.md)]

### Add QR code authentication method for a user in Microsoft Graph API

This example adds QR code authentication method for a user: 

- **Request**

  ```https
  HTTP PUT/users/{id | userPrincipalName}/authentication/qrCodePinMethod
  
  
  {
    "standardQRCode": {
      "expireDateTime": "2024-12-30T12:00:00Z",
      "startDateTime": "2024-10-30T12:00:00Z"
    },
    "pin": {
      "code": "<PIN>"
    }
  }
  ```

- **Response**

  ```https
  HTTP/1.1 201 Created
  Location: /beta/users/aaaaaaaa-bbbb-cccc-1111-222222222222/authentication/qrCodePinMethod`
  Content-type: application/json

  {
    "standardQRCode": {
      "id": "BBBBBBBB-1C1C-2D2D-3E3E-444444444444"
      "expireDateTime": "2024-12-30T12:00:00Z",
      "startDateTime": "2024-10-30T12:00:00Z"
      "createdDateTime": "2024-10-30T12:00:00Z",
      "lastUsedDateTime": null,
       "image":
          {
    "binaryValue": "<binaryImageData>",
           "version": 1,
           "errorCorrectionLevel": "H".
           "rawContent": <binary data encoded in QR>        
    }
      },
    "temporaryQRCode": null,
    "pin": {
      "code": "<PIN>",
      "isForcePinChangeRequired": true,
      "createdDateTime": "2024-10-30T12:00:00Z",
      "updatedDateTime": null
    }  
  }
  ```

This example confirms whether QR code authentication method is added for the user:

- **Request**

  ```https
  GET https://graph.microsoft.com/beta/users/flokreg@contoso.com/authentication/qrCodePinMethod`
  ```


- **Response**

  ```https
  HTTP/1.1 200 OK
  Content-type: application/json
  
  {
    "id": "<id>",
    "standardQRCode": {
      "id": "BBBBBBBB-1C1C-2D2D-3E3E-444444444444"
      "image": null,
      "expireDateTime": "2024-12-30T12:00:00Z",
      "startDateTime": "2024-10-30T12:00:00Z"
      "createdDateTime": "2024-10-30T12:00:00Z",
      "lastUsedDateTime": "2024-12-30T12:00:00Z"
    },
    "temporaryQRCode": {
      "id": "CCCCCCCC-2D2D-3E3E-4F4F-555555555555"
      "image": null,
      "expireDateTime": "2024-12-30T12:00:00Z",
      "startDateTime": "2024-10-30T12:00:00Z"
      "createdDateTime": "2024-10-30T12:00:00Z",
      "lastUsedDateTime": "2024-12-30T12:00:00Z"
    },
    "pin": {
      "code": null,
      "isForcePinChangeRequired": false,
      "createdDateTime": "2024-10-30T12:00:00Z",
      "updatedDateTime": "2024-11-30T12:00:00Z"
    }
  }

## Edit the QR code authentication method for a user

You can edit QR code authentication method for a user by using the Microsoft Entra admin center, My Staff, or Microsoft Graph API. 

### Edit the QR code authentication method for a user in the Microsoft Entra admin center

- Navigate to the usable authentication methods for a user, and click **Edit** to edit the properties of the QR code authentication method.

  :::image type="content" border="true" source="media/how-to-authentication-qr-code/edit-usable-authentication-method.png" alt-text="Screenshot that shows how to edit the usable authentication method for a user.":::

- Change the expiration time for the standard QR code, and click **Save**. After you make edits, click **Done**.

  :::image type="content" border="true" source="media/how-to-authentication-qr-code/change-expiration.png" alt-text="Screenshot that shows how to change the expiration date.":::

- Delete a standard QR code. You might want to delete the standard QR code if it's reported as expired, compromised, or stolen. 
  
  :::image type="content" border="true" source="media/how-to-authentication-qr-code/delete-qr-code.png" alt-text="Screenshot that shows how to delete a QR code.":::

  After you delete the standard QR code, click the add symbol (**+**) to add a new standard QR code for the user. 
  The deleted QR code is no longer valid for login. 
  
  You need to print and distribute the new QR code to the user. 
  The user can continue to use their existing PIN. 
  
  If you want the user to update their PIN, generate a temporary one and distribute it to the user. The user will be required to change the temporary PIN at the next sign-in.

  :::image type="content" border="true" source="media/how-to-authentication-qr-code/replace-qr-code.png" alt-text="Screenshot that shows how to replace a lost or stolen QR code.":::

- Reset a PIN. Click the pencil icon after the masked PIN. Click **Generate new PIN** to create a new temporary PIN. Click **OK** to confirm that the user is forced to change the temporary PIN when they next sign in. Copy the temporary PIN and share it with the user. 

  :::image type="content" border="true" source="media/how-to-authentication-qr-code/reset-pin.png" alt-text="Screenshot that shows how to reset a PIN.":::

- Add or delete a temporary QR code. A temporary QR code reduces admin overhead of provisioning and deprovisioning the QR code on a badge if a user didn't bring their badge to work. It also reduces the stress of retaining the QR code after their shift. A temporary QR code has a lifetime of 1-12 hours and can be activated instantly or later. 
To deprovision the QR code, you can delete the temporary QR code or let it expire as it's unusable after expiry.

  :::image type="content" border="true" source="media/how-to-authentication-qr-code/add-temporary-qr-code.png" alt-text="Screenshot that shows how to add a temporary QR code.":::

  :::image type="content" border="true" source="media/how-to-authentication-qr-code/download-temporary-qr-code.png" alt-text="Screenshot that shows how to download a temporary QR code.":::

### Edit the QR code authentication method for a user in My Staff

[!Include [Edit QR code](../../includes/edit-qr-code-my-staff.md)]

### Edit the QR code authentication method for a user in Microsoft Graph API

This example shows how to delete the standard QR code for a user if they lose their badge, and create a new standard QR code. The user isn't required to change their PIN.

Delete a standard QR code:

- **Request**

  ```https
  DELETE https://graph.microsoft.com/beta/users/flokreg@contoso.com/authentication/qrCodePinMethod/standardQRCode`
  ```

- **Response**

  ```https
  HTTP/1.1 204 No Content
  ```

Create a standard QR code:

- **Request**

  ```https
  HTTP PATCH/users/{id | userPrincipalName}/authentication/qrCodePinMethod/standardQRCode`
  
  
  {
      "startDateTime": "2024-10-30T12:00:00Z",
      "expireDateTime": "2024-12-30T12:00:00Z"
  }
  ```

- **Response**

  ```https
  HTTP/1.1 201 Created
  Location: /beta/users/aaaaaaaa-bbbb-cccc-1111-222222222222/authentication/qrCodePinMethod/standardQRCode`
  Content-type: application/json

  {
      "id": "BBBBBBBB-1C1C-2D2D-3E3E-444444444444"
      "expireDateTime": "2024-12-30T12:00:00Z",
      "startDateTime": "2024-10-30T12:00:00Z"
      "createdDateTime": "2024-10-30T12:00:00Z",
      "lastUsedDateTime": null,
       "image":
          {
    "binaryValue": "<binaryImageData>",
           "version": 1,
           "errorCorrectionLevel": "H".
           "rawContent": <binary data encoded in QR>        
    }
    }
  
Get a standard QR code:

- **Request**

  ```https
  GET https://graph.microsoft.com/beta/users/{id|UPN}/authentication/qrCodePinMethod/standardQRCode`
  ```

- **Response**

  ```https
  HTTP/1.1 200 OK
  Content-type: application/json

  {
      "id": "BBBBBBBB-1C1C-2D2D-3E3E-444444444444",
      "image": null,
      "expireDateTime": "2024-12-30T12:00:00Z",
      "startDateTime": "2024-10-30T12:00:00Z"
      "createdDateTime": "2024-10-30T12:00:00Z",
      "lastUsedDateTime": "2024-12-30T12:00:00Z"
  }

This example shows how to create a temporary QR code for a user. The user can use the existing PIN. This operation returns an error if a temporary QR code already exists for the user, or if the **expireDateTime** is more than 12 hours past the **startDateTime**. 

- **Request**

  ```https
  HTTP PATCH/users/{id | userPrincipalName}/authentication/qrCodePinMethod/temporaryQRCode`
  
  
  {
      "startDateTime": "2024-10-30T12:00:00Z",
      "expireDateTime": "2024-10-30T22:00:00Z"
  }
  ```

- **Response**

  ```https
  HTTP/1.1 201 Created
  Location: /beta/users/aaaaaaaa-bbbb-cccc-1111-222222222222/authentication/qrCodePinMethod/temporaryQRCode`
  Content-type: application/json

  {
      "id": "EEEEEEEE-4F$F-5A5A-6B6B-777777777777"
      "expireDateTime": "2024-10-30T22:00:00Z",
      "startDateTime": "2024-10-30T12:00:00Z"
      "createdDateTime": "2024-10-30T12:00:00Z",
      "lastUsedDateTime": null,
       "image":
          {
    "binaryValue": "<binaryImageData>",
           "version": 1,
           "errorCorrectionLevel": "H".
           "rawContent": <binary data encoded in QR>        
    }
    }


Get a temporary QR code:

- **Request**

  ```https
  GET https://graph.microsoft.com/beta/users/{id|UPN}/authentication/qrCodePinMethod/temporaryQRCode`
  ```

- **Response**

  ```https
  HTTP/1.1 200 OK
  Content-type: application/json

  {
      "id": "EEEEEEEE-4F$F-5A5A-6B6B-777777777777",
      "image": null,
      "expireDateTime": "2024-10-30T22:00:00Z",
      "startDateTime": "2024-10-30T12:00:00Z"
      "createdDateTime": "2024-10-30T12:00:00Z",
      "lastUsedDateTime": "2024-10-30T20:00:00Z"
  }

This example shows how to delete a temporary QR code for a user.  

- **Request**

  ```https
  DELETE https://graph.microsoft.com/beta/users/flokreg@contoso.com/authentication/qrCodePinMethod/temporaryQRCode`
  ```

- **Response**

  ```https
  HTTP/1.1 204 No Content
  ```

This example shows how to reset the PIN a QR code authentication method:

- **Request**

  ```https
  PATCH https://graph.microsoft.com/beta/users/flokreg@contoso.com/authentication/qrCodePinMethod/pin`
  ```

- **Response**

  ```https
  {
    "code": <PIN>,
    "forceChangePinNextSignIn": true,
    "createdDateTime": "2024-10-30T12:00:00Z",
    "updatedDateTime": null
  }
  ```

This example shows how to force a user to change their PIN for a QR code authentication method:

- **Request**

  ```https
  PATCH https://graph.microsoft.com/beta/users/flokreg@contoso.com/authentication/qrCodePinMethod/updatePin`

  {
    "currentPin": "<Old PIN>",
    "newPin": "<New PIN>"
  }
  ```

- **Response**

  ```https
  HTTP/1.1 204 No Content
  ```

## Delete the QR code authentication method for a user

You can delete the QR code authentication method for a user by using the Microsoft Entra admin center, My Staff, or Microsoft Graph API. 

### Delete the QR code authentication method for a user in the Microsoft Entra admin center

If a QR code authentication method is deleted for a user, they can no longer sign in by using that authentication method. 

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Authentication Administrator](~/identity/role-based-access-control/permissions-reference.md#authentication-administrator).

1. Go to **Users**, select a user, and click **Authentication methods**.
1. Under **Usable authentication methods**, click the ellipsis on the right side of the QR code, and click **Delete**.

   :::image type="content" border="true" source="media/how-to-authentication-qr-code/delete-qr-code-method-admin-center.png" alt-text="Screenshot that shows how to delete the QR code authentication method for a user in the Microsoft Entra admin center.":::

### Delete the QR code authentication method for a user in My Staff

[!Include [Edit QR code](../../includes/delete-qr-code-authentication-method-my-staff.md)]

### Delete the QR code authentication method for a user in Microsoft Graph API

This example shows how to delete a standard QR code for a user.  

- **Request**

  ```https
  DELETE https://graph.microsoft.com/beta/users/flokreg@contoso.com/authentication/qrCodePinMethod/standardQRCode`
  ```

- **Response**

  ```https
  HTTP/1.1 204 No Content
  ```

## Sign in to Microsoft Teams or Managed Home Screen (MHS) with QR code

Microsoft Teams and Managed Home Screen (MHS) apps  have optimized QR code sign-in experience. An Authentication Policy Administrator needs to configure Intune or another mobile device management (MDM) solution to enable the QR code authentication method for mobile devices. 

### Enable sign-in with a QR code in Teams or MHS
When configuring with Intune, assign Microsoft Authenticator as a Required apps for all devices you want to add QR code authentication for.

| Platform | MDM app config key    | Value | Configuration location |
|----------|-----------------------|-------|------------------------|
| iOS      | preferred_auth_config | qrpin | Device management profile, which configures a single sign-on (SSO) extension |
| Android  | preferred_auth_config | qrpin | Microsoft Authenticator |

Note: Managed Home Screen is only available on Android devices.

### QR code authentication Teams sign-in experience 

Users need to [download Teams](https://aka.ms/teamsmobiledownload):

- For iOS and iPad, you need Teams version 1.0.0.77.2024132501 or later 
- For Android, you need Teams version 1.0.0.2024143204 or later 

   
1. Click **Sign-in with QR code** in Microsoft Teams.
1. Scan the QR code. Give consent if asked for camera permission.
1. Enter your PIN.

   :::image type="content" border="true" source="media/how-to-authentication-qr-code/enter-pin.png" alt-text="Screenshot that shows how to enter a PIN.":::

1. When you first sign-in, you need to update your PIN.
1. You're now signed in to the app.
1. If you sign in with a temporary PIN, you need to change it. 

   :::image type="content" border="true" source="media/how-to-authentication-qr-code/change-pin.png" alt-text="Screenshot that shows how to change a PIN.":::


## QR code authentication web sign-in experience (login.microsoftonline.com)

1. Click **More sign-in options** > **Sign in to an organization** > **Sign in with QR code**.
1. Allow the camera when prompted > scan the QR code > enter your PIN > you're successfully signed in.

   :::image type="content" source="media/concept-authentication-qr-code/sign-in-web.png" alt-text="Screenshot that shows web sign-in experience.":::

## Add security with QR code authentication using Conditional Access policies

Restrict the QR code authentication method to only frontline workers and shared devices. This section covers how to create policies that restrict QR code authentication method to only frontline workers and shared devices.

### Restrict QR code authentication to frontline workers  

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Authentication Policy Administrator](~/identity/role-based-access-control/permissions-reference.md#authentication-policy-administrator).
1. Browse to **Protection** > **Authentication methods** > **QR code** > **Enable and target**.
1. Click **Add target** > select a group that only includes frontline workers, such as **Frontline workers** in the following screenshot. This group selection restricts enablement of the QR code authentication method only to frontline workers added to the **Frontline workers** group. 

   :::image type="content" border="true" source="media/how-to-authentication-qr-code/add-groups-and-roles.png" alt-text="Screenshot that shows the Microsoft Entra admin center that shows how to add groups to the QR code settings.":::

### Restrict QR code authentication to shared devices 

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as a [Conditional Access Administrator](~/identity/role-based-access-control/permissions-reference.md#conditional-access-administrator). 
1. Click **Conditional Access** > **Authentication strengths** > **New authentication strength**.

   :::image type="content" border="true" source="media/how-to-authentication-qr-code/new-authentication-strength.png" alt-text="Screenshot that shows how to create a new authentication strength.":::

1. Create a custom authentication strength Conditional Access policy. Select authentication **QR code (Preview)**.  

1. Create a Conditional Access policy that requires shared devices be marked as compliant with policies from Intune or other MDM solution. This policy makes sure that frontline workers can access only specific resources from a compliant, shared device by using QR code auth
   
   1. Under **Users or workload identities** > **Include** > select **Users and groups**, and choose your **Frontline workers** frontline worker group. 
   1. Under **Target resources** > **Include** > select specific resources that frontline workers can access.
   1. Under **Conditions**, click **Filter for devices**, set **Configure** to **Yes**.
   1. Click **Include filtered devices from policy**.
   1. For **Property**, select **ProfileType**.
   1. For **Operator**, select **Equals**.
   1. For **Value**, select **Shared**.  

      :::image type="content" border="true" source="media/how-to-authentication-qr-code/include-filtered-devices.png" alt-text="Screenshot that shows how to include filtered devices from a policy for an authentication strength.":::
   
   1. Under **Access controls** > **Grant** > select **Require device to be marked as compliant**, and click **Select**.  
   1. Click **Create**.

## Related content

- [Authentication methods in Microsoft Entra ID - QR code authentication method (Preview)](concept-authentication-qr-code.md)
- [Manage your users with My Staff](~/identity/role-based-access-control/my-staff-configure.md)
- [What authentication and verification methods are available in Microsoft Entra ID?](concept-authentication-methods.md)


