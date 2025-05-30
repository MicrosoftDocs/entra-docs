---
title: How to manage OATH tokens in Microsoft Entra ID (Preview)
description: Learn about how to manage OATH tokens in Microsoft Entra ID to help improve and secure sign-in events.
services: active-directory
ms.service: entra-id
ms.subservice: authentication
ms.topic: conceptual
ms.date: 03/26/2025
ms.author: justinha
author: justinha
ms.reviewer: lvandenende
manager: femila
ms.collection: M365-identity-device-management
ms.custom: sfi-image-nochange
# Customer intent: As an identity administrator, I want to understand how to manage OATH tokens in Microsoft Entra ID to improve and secure user sign-in events.
---
# How to manage hardware OATH tokens in Microsoft Entra ID (Preview)

This topic covers how to manage hardware oath tokens in Microsoft Entra ID, including Microsoft Graph APIs that you can use to upload, activate, and assign hardware OATH tokens. 

## Enable hardware OATH tokens in the Authentication methods policy

You can view and enable hardware OATH tokens in the Authentication methods policy by using Microsoft Graph APIs or the Microsoft Entra admin center. 

- To view the hardware OATH tokens policy status by using the APIs:

   ```https
   GET https://graph.microsoft.com/beta/policies/authenticationMethodsPolicy/authenticationMethodConfigurations/hardwareOath
   ```

- To enable hardware OATH tokens policy by using the APIs.

   ```https
   PATCH https://graph.microsoft.com/beta/policies/authenticationMethodsPolicy/authenticationMethodConfigurations/hardwareOath
   ```
   
   In the request body, add:

   ```https
   {
    "state": "enabled"
   }
   ```

To enable hardware OATH tokens in the Microsoft Entra admin center:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Authentication Policy Administrator](~/identity/role-based-access-control/permissions-reference.md#authentication-policy-administrator).
1. Browse to **Entra ID** > **Authentication methods** > **Hardware OATH tokens (Preview)**.
1. Select **Enable**, choose which groups of users to include in the policy, and select **Save**.

   :::image type="content" source="media/concept-authentication-oath-tokens/enable.png" alt-text="Screenshot of how to enable hardware OATH tokens in the Microsoft Entra admin center.":::

We recommend that you [migrate to the Authentication methods policy](how-to-authentication-methods-manage.md) to manage hardware OATH tokens. If you enable OATH tokens in the legacy MFA policy, browse to the policy in the Microsoft Entra admin center as an Authentication Policy Administrator: **Entra ID** > **Multifactor authentication** > **Additional cloud-based multifactor authentication settings**. Clear the checkbox for **Verification code from mobile app or hardware token**. 


## Scenario: Admin creates, assigns, and activates a hardware OATH token 

This scenario covers how to create, assign, and activate a hardware OATH token as an admin, including the necessary API calls and verification steps. For more information about the permissions required to invoke these APIs and to inspect the request-response samples, see [Create hardwareOathTokenAuthenticationMethodDevice](/graph/api/authenticationmethoddevice-post-hardwareoathdevices?view=graph-rest-beta&preserve-view=true).

>[!NOTE]
>There might be up to a 20-minute delay for the policy propagation. Allow an hour for the policy to update before users can sign in with their hardware OATH token and see it in their [Security info](https://mysignins.microsoft.com/security-info).

Let's look at an example where an Authentication Policy Administrator creates a token and assigns it to a user. You can allow assignment without activation. 

For the body of the POST in this example, you can find the **serialNumber** from your device and the **secretKey** is delivered to you.

```https
POST https://graph.microsoft.com/beta/directory/authenticationMethodDevices/hardwareOathDevices
{ 
"serialNumber": "GALT11420104", 
"manufacturer": "Thales", 
"model": "OTP 110 Token", 
"secretKey": "C2dE3fH4iJ5kL6mN7oP1qR2sT3uV4w", 
"timeIntervalInSeconds": 30, 
"assignTo": {"id": "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"}
}
```

The response includes the token **id**, and the user **id** that the token is assigned to:

```http
{
    "@odata.context": "https://graph.microsoft.com/beta/$metadata#directory/authenticationMethodDevices/hardwareOathDevices/$entity",
    "id": "3dee0e53-f50f-43ef-85c0-b44689f2d66d",
    "displayName": null,
    "serialNumber": "GALT11420104",
    "manufacturer": "Thales",
    "model": "OTP 110 Token",
    "secretKey": null,
    "timeIntervalInSeconds": 30,
    "status": "available",
    "lastUsedDateTime": null,
    "hashFunction": "hmacsha1",
    "assignedTo": {
        "id": "00aa00aa-bb11-cc22-dd33-44ee44ee44ee",
        "displayName": "Test User"
    }
}
```

Here's how the Authentication Policy Administrator can activate the token. Replace the verification code in the Request body with the code from your hardware OATH token.

```https
POST https://graph.microsoft.com/beta/users/00aa00aa-bb11-cc22-dd33-44ee44ee44ee/authentication/hardwareOathMethods/3dee0e53-f50f-43ef-85c0-b44689f2d66d/activate

{ 
    "verificationCode" : "903809" 
}
```

To validate the token is activated, sign in to [Security info](https://aka.ms/mysecurityinfo) as the test user. If you're prompted to approve a sign-in request from Microsoft Authenticator, select Use a verification code.


You can GET to list tokens: 

```https
GET https://graph.microsoft.com/beta/directory/authenticationMethodDevices/hardwareOathDevices 
```



This example creates a single token:

```https
POST https://graph.microsoft.com/beta/directory/authenticationMethodDevices/hardwareOathDevices
```

In the request body, add:

```https
{ 
"serialNumber": "GALT11420104", 
"manufacturer": "Thales", 
"model": "OTP 110 Token", 
"secretKey": "abcdef2234567abcdef2234567", 
"timeIntervalInSeconds": 30, 
"hashFunction": "hmacsha1" 
}

```

The response includes the token ID. 

```http
#### Response
{
    "@odata.context": "https://graph.microsoft.com/beta/$metadata#directory/authenticationMethodDevices/hardwareOathDevices/$entity",
    "id": "3dee0e53-f50f-43ef-85c0-b44689f2d66d",
    "displayName": null,
    "serialNumber": "GALT11420104",
    "manufacturer": "Thales",
    "model": "OTP 110 Token",
    "secretKey": null,
    "timeIntervalInSeconds": 30,
    "status": "available",
    "lastUsedDateTime": null,
    "hashFunction": "hmacsha1",
    "assignedTo": null
}
```

Authentication Policy Administrators or an end user can unassign a token: 

```https
DELETE https://graph.microsoft.com/beta/users/66aa66aa-bb77-cc88-dd99-00ee00ee00ee/authentication/hardwareoathmethods/6c0272a7-8a5e-490c-bc45-9fe7a42fc4e0
```

This example shows how to delete a token with token ID 3dee0e53-f50f-43ef-85c0-b44689f2d66d: 

```https
DELETE https://graph.microsoft.com/beta/directory/authenticationMethodDevices/hardwareOathDevices/3dee0e53-f50f-43ef-85c0-b44689f2d66d
```

## Scenario: Admin creates and assigns a hardware OATH token that a user activates

In this scenario, an Authentication Policy Administrator creates and assigns a token, and then a user can activate it on their Security info page, or by using Microsoft Graph Explorer. When you assign a token, you can share steps for the user to sign in to [Security info](https://aka.ms/mysecurityinfo) to activate their token. They can choose **Add sign-in method** > **Hardware token**. They need to provide the hardware token serial number, which is typically on the back of the device. 


```https
POST https://graph.microsoft.com/beta/directory/authenticationMethodDevices/hardwareOathDevices
{ 
"serialNumber": "GALT11420104", 
"manufacturer": "Thales", 
"model": "OTP 110 Token", 
"secretKey": "C2dE3fH4iJ5kL6mN7oP1qR2sT3uV4w", 
"timeIntervalInSeconds": 30, 
"assignTo": {"id": "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"}
}
```

The response includes an **id** value for each token. An Authentication Administrator can assign the token to a user:

```https
POST https://graph.microsoft.com/beta/users/00aa00aa-bb11-cc22-dd33-44ee44ee44ee/authentication/hardwareOathMethods
{
    "device": 
    {
        "id": "6c0272a7-8a5e-490c-bc45-9fe7a42fc4e0" 
    }
}
```

Here are steps a user can follow to self-activate their hardware OATH token in Security info:

1. Sign in to [Security info](https://aka.ms/mysecurityinfo).
1. Select **Add sign-in method** and choose **Hardware token**.

   :::image type="content" source="media/concept-authentication-oath-tokens/add-sign-in-method.png" alt-text="Screenshot of how to add a new sign-in method in Security info.":::

1. After you select **Hardware token**, select **Add**.

   :::image type="content" source="media/concept-authentication-oath-tokens/add-hardware-token.png" alt-text="Screenshot of how to add a hardware OATH token in Security info.":::

1. Check the back of the device for the serial number, enter it, and select **Next**.

   :::image type="content" source="media/concept-authentication-oath-tokens/add-serial-number.png" alt-text="Screenshot of how to add the serial number of a hardware OATH token.":::

1. Create a friendly name to help you choose this method to complete multifactor authentication, and select **Next**.

   :::image type="content" source="media/concept-authentication-oath-tokens/add-name.png" alt-text="Screenshot of how to add a friendly name for a hardware OATH token.":::

1. Supply the random verification code that appears when you tap the button on the device. For a token that refreshes its code every 30 seconds, you need to enter the code and select **Next** within one minute. For a token that refreshes every 60 seconds, you have two minutes. 

   :::image type="content" source="media/concept-authentication-oath-tokens/add-code.png" alt-text="Screenshot of how to add a verification code to activate a hardware OATH token.":::

1. When you see the hardware OATH token is successfully added, select **Done**.

   :::image type="content" source="media/concept-authentication-oath-tokens/success.png" alt-text="Screenshot of a hardware OATH token after it's added.":::

1. The hardware OATH token appears in the list of your available authentication methods.

   :::image type="content" source="media/concept-authentication-oath-tokens/new-token.png" alt-text="Screenshot of a hardware OATH token in Security info.":::

Here are steps users can follow to self-activate their hardware OATH token by using Graph Explorer.

1. Open Microsoft Graph Explorer, sign in, and consent to the required permissions.
1. Make sure you have the required permissions. For a user to be able to do the self-service API operations, admin consent is required for `Directory.Read.All`, `User.Read.All`, and `User.ReadWrite.All`.
1. Get a list of hardware OATH tokens that are assigned to your account, but not yet activated.

   ```https
   GET https://graph.microsoft.com/beta/me/authentication/hardwareOathMethods
   ```

1. Copy the **id** of the token device, and add it to the end of the URL followed by */activate*. You need to enter the verification code in the request body and submit the POST call before the code changes.

   ```https  
   POST https://graph.microsoft.com/beta/me/authentication/hardwareOathMethods/b65fd538-b75e-4c88-bd08-682c9ce98eca/activate
   ```

   Request body:

   ```https
   {
      "verificationCode": "988659"
   }
   ```

## Scenario: Admin creates multiple hardware OATH tokens in bulk that users self-assign and activate

In this scenario, an Authentication Administrator creates tokens without assignment, and users self-assign and activate the tokens. You can upload new tokens to the tenant in bulk. Users can sign in to [Security info](https://aka.ms/mysecurityinfo) to activate their token. They can choose **Add sign-in method** > **Hardware token**. They need to provide the hardware token serial number, which is typically on the back of the device. 

For greater assurance that the token is only activated by a specific user, you can assign the token to the user, and send the device to them for self-activation.


```https
PATCH https://graph.microsoft.com/beta/directory/authenticationMethodDevices/hardwareOathDevices
{
"@context":"#$delta", 
"value": [ 
    { 
        "@contentId": "1", 
        "serialNumber": "GALT11420108", 
        "manufacturer": "Thales", 
        "model": "OTP 110 Token", 
        "secretKey": "abcdef2234567abcdef2234567", 
        "timeIntervalInSeconds": 30, 
        "hashFunction": "hmacsha1" 
        },
    { 
        "@contentId": "2", 
        "serialNumber": "GALT11420112", 
        "manufacturer": "Thales", 
        "model": "OTP 110 Token", 
        "secretKey": "2234567abcdef2234567abcdef", 
        "timeIntervalInSeconds": 30, 
        "hashFunction": "hmacsha1" 
        }
    ]          
} 
```



## Troubleshooting hardware OATH token issues

This section covers common 

### User has two tokens with the same serial number

A user might have two instances of the same hardware OATH token registered as authentication methods. This happens if the legacy token isn't removed from **OATH tokens (Preview)** in the Microsoft Entra admin center after it's uploaded by using Microsoft Graph.

When this happens, both instances of the token are listed as registered for the user:

```https
GET https://graph.microsoft.com/beta/users/{user-upn-or-objectid}/authentication/hardwareOathMethods
```

Both instances of the token are also listed in **OATH tokens (Preview)** in the Microsoft Entra admin center:

:::image type="content" source="media/concept-authentication-oath-tokens/duplicate-tokens.png" alt-text="Screenshot of the duplicate tokens in the Microsoft Entra admin center.":::

To identify and remove the legacy token.

1. List all hardware OATH tokens on the user.

   ```https
   GET https://graph.microsoft.com/beta/users/{user-upn-or-objectid}/authentication/hardwareOathMethods
   ```

   Find the **id** of both tokens and copy the **serialNumber** of the duplicate token.

1. Identify the legacy token. Only one token is returned in the response of the following command. That token was created by using Microsoft Graph.

   ```https
   GET https://graph.microsoft.com/beta/directory/authenticationMethodDevices/hardwareOathDevices?$filter=serialNumber eq '20033752'
   ```

1. Remove the legacy token assignment from the user. Now that you know the **id** of the new token, you can identify the **id** of the legacy token from the list returned in step 1. Craft the URL using the legacy token **id**.

   ```https
   DELETE https://graph.microsoft.com/beta/users/{user-upn-or-objectid}/authentication/hardwareOathMethods/{legacyHardwareOathMethodId}
   ```

1. Delete the legacy token by using the legacy token **id** in this call.

   ```https
   DELETE https://graph.microsoft.com/beta/directory/authenticationMethodDevices/hardwareOathDevices/{legacyHardwareOathMethodId}
   ```

## Related content

Learn more about [OATH tokens](concept-authentication-oath-tokens.md).
Learn how to [create one or more hardwareOathTokenAuthenticationMethodDevices](/graph/api/authenticationmethoddevice-update).