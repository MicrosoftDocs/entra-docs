---
title: OATH tokens authentication method
description: Learn about using OATH tokens in Microsoft Entra ID to help improve and secure sign-in events.

services: active-directory
ms.service: entra-id
ms.subservice: authentication
ms.topic: conceptual
ms.date: 11/04/2024

ms.author: justinha
author: justinha
ms.reviewer: lvandenende
manager: amycolannino

ms.collection: M365-identity-device-management

# Customer intent: As an identity administrator, I want to understand how to use OATH tokens in Microsoft Entra ID to improve and secure user sign-in events.
---

# Authentication methods in Microsoft Entra ID - OATH tokens 

OATH time-based one-time password (TOTP) is an open standard that specifies how one-time password (OTP) codes are generated. OATH TOTP can be implemented using either software or hardware to generate the codes. Microsoft Entra ID doesn't support OATH HOTP, a different code generation standard.

## Software OATH tokens

Software OATH tokens are typically applications such as the Microsoft Authenticator app and other authenticator apps. Microsoft Entra ID generates the secret key, or seed, that's input into the app and used to generate each OTP.

The Authenticator app automatically generates codes when set up to do push notifications so a user has a backup even if their device doesn't have connectivity. Third-party applications that use OATH TOTP to generate codes can also be used.

Some OATH TOTP hardware tokens are programmable, meaning they don't come with a secret key or seed preprogrammed. These programmable hardware tokens can be set up using the secret key or seed obtained from the software token setup flow. Customers can purchase these tokens from the vendor of their choice and use the secret key or seed in their vendor's setup process.

## Hardware OATH tokens (preview)

Microsoft Entra ID supports the use of OATH-TOTP SHA--256 and SHA-1 tokens that refresh codes every 30 or 60 seconds. Customers can purchase these tokens from the vendor of their choice. Hardware OATH tokens are available for users with a Microsoft Entra ID P1 or P2 license.  

Microsoft Entra ID has a new Microsoft Graph API in preview for Azure and Azure for US Government clouds.

This preview refresh uses the hardware OATH token Authentication methods policy. [Privileged Authentication Administrators](~/identity/role-based-access-control/permissions-reference.md#privileged-authentication-administrator) can use Microsoft Graph to manage tokens in the preview. There aren't any options to manage hardware OATH token in this preview refresh in the Microsoft Entra admin center. 

Hardware OATH tokens that you add with Microsoft Graph for this preview refresh appear along with other tokens in the admin center. But you can only manage them by using Microsoft Graph. 

### Improvements in the preview refresh

This hardware OATH token preview refresh improves flexibility and security for organizations by removing Global Administrator requirements. 
Organizations can delegate token creation, assignment, and activation to Privileged Authentication Authentication Policy Administrator. 

End users can also self-assign and activate tokens from their [Security info](https://mysignins.microsoft.com/security-info) page. For more information, see [User self-assignment and activation](#user-self-assignment-and-activation).

The following table compares the administrator role requirements to manage hardware OATH tokens in the preview refresh versus original preview option.

| Task    | Original preview | Preview refresh |
|---------|------------------|-----------------|
| Create a new token in the tenant’s inventory. | Global Administrator | Authentication Policy Administrator |
| Read a token from the tenant’s inventory; doesn't return the secret. | Global Administrator | Authentication Policy Administrator |
| Update a token in the tenant. For example, update manufacturer or module; Secret can't be updated. | Global Administrator | Authentication Policy Administrator |
| Delete a token from the tenant’s inventory. | Global Administrator | Authentication Policy Administrator |

Another difference pertains to end users. In the legacy multifactor authentication (MFA) policy, hardware and software OATH tokens can only be enabled together. If you enable OATH tokens in the legacy MFA policy, end users see an option to add Hardware OATH tokens in their Security info page.

If you don't want end users to see an option to add Hardware OATH tokens, migrate to the Authentication methods policy. 
In the Authentication methods policy, hardware and software OATH tokens can be enabled and managed separately. For more information about how to migrate to the Authentication methods policy, see [How to migrate MFA and SSPR policy settings to the Authentication methods policy for Microsoft Entra ID](how-to-authentication-methods-manage.md).

### Authentication method policy for hardware OATH tokens

1. You can view the Hardware OATH tokens policy status using the APIs

   ```msgraph-interactive
   GET https://developer.microsoft.com/graph/graph-explorer?request=policies%2FauthenticationMethodsPolicy%2FauthenticationMethodConfigurations%2FhardwareOath&method=GET&version=beta&GraphUrl=https://graph.microsoft.com
   ```

1. Start by enabling Hardware OATH tokens policy using the APIs.


1. If you enabled the HW OATH authentication method policy above, we recommend that you clear the **Verification code from mobile app or hardware token** setting. To verify this setting, sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Authentication Policy Administrator](~/identity/role-based-access-control/permissions-reference.md#authentication-policy-administrator).
1. Browse to **Protection** > **Multifactor authentication** > **Additional cloud-based multifactor authentication settings**.

Note: there might be some delays in the policy propagation(up to 20 mins). This can impact the 
user’s ability to sign-in with HW OATH token and showing HW OATH token in the “Security Info” 
page. Please allow an hour or so for this policy to get updated.


### User authentication methods in Microsoft Graph

You can use the following Microsoft Graph examples to assign and activate tokens for a user. 
You can allow assignment without activation. 
The following examples require the [Authentication Policy Administrator](~/identity/role-based-access-control/permissions-reference.md#authentication-policy-administrator) role.


List tokens: 

```msgraph-interactive
GET https://graph.microsoft.com/beta/directory/authenticationMethodDevices/hardwareOathDevices 
```

Delete a token with token ID 3dee0e53-f50f-43ef-85c0-b44689f2d66d: 

```msgraph-interactive
DELETE https://graph.microsoft.com/beta/directory/authenticationMethodDevices/hardwareOathDevices/3dee0e53-f50f-43ef-85c0-b44689f2d66d


Create a single token:

```msgraph-interactive
POST https://graph.microsoft.com/beta/directory/authenticationMethodDevices/hardwareOathDevices

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

Authentication Administrators and end users can unassign a token: 

```msgraph-interactive
DELETE https://graph.microsoft.com/beta/users/66aa66aa-bb77-cc88-dd99-00ee00ee00ee/authentication/hardwareoathmethods/6c0272a7-8a5e-490c-bc45-9fe7a42fc4e0
```

Let's try another example where an Authentication Policy Administrator creates two tokens, with **hashFunction** optional. The hashFunction is SHA-1 by default. For SHA-256, enter `hmacsha256` as the value for the property. 


### User self-assignment and activation

The following table lists requirements to assign and activate hardware OATH tokens.

| Task | Token state | Role requirement |
|------|-------------|------------------|
| Assign a token from the inventory to a user in the tenant. | Assigned | Member (self)<br>Authentication Administrator<br>Privileged Authentication Administrator |
| Read the token of the userl doesn't return the secret. | Activated / Assigned  (depends if the token was already activated or not) | Member (self)<br>Authentication Administrator (only has restricted Read, not standard Read)<br>Privileged Authentication Administrator  |
| Update the token of the user, such as provide current 6-digit code for activation, or change token name. | Activated | Member (self)<br>Authentication Administrator<br>Privileged Authentication Administrator |
| Remove the token from the user. The token goes back to the token inventory. | Available (back to the tenant inventory) | Member (self)<br>Authentication Administrator<br>Privileged Authentication Administrator |

### Scenario use cases

The next sections cover different scenarios to demonstrate options for different roles create, assign, and activate tokens. 

#### Scenario 1: Admin creates, assigns, and activates a hardware OATH token 

This scenario cover how to create, assign, and activate a hardware OATH token as an admin, including the necessary API calls and verification steps.

Let's look at an example where an Authentication Administrator creates a token and assigns it to a user. For the body of the POST in this example, you can find the **serialNumber** from your device and the **secretKey** is delivered to you.

```msgraph-interactive
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

Here's how the Authentication Administrator can activate the token. Replace the verifcation code in the Request body with the code from your hardware OATH token.

```msgraph-interactive
POST https://graph.microsoft.com/beta/users/00aa00aa-bb11-cc22-dd33-44ee44ee44ee/authentication/hardwareOathMethods/3dee0e53-f50f-43ef-85c0-b44689f2d66d/activate

{ 
    "verificationCode" : "903809" 
}
```

To validate the token is activated, sign in to [Security info](https://aka.ms/mysecurityinfo) as the test user. If you're prompted to approve a sign-in request from Microsoft Authenticator, select Use a verification code.


#### Scenario 2: Admin creates and assigns a token that a user activates

In this scenario, an Authentication Policy Administrator creates and assigns a token, and then a user can activate it on their Security info page, or by using Microsoft Graph Explorer. When you assign a token, you can share steps for the user to sign in to [Security info](https://aka.ms/mysecurityinfo) to activate their token. They can choose **Add sign-in method** > **Hardware token**. They need to provide the hardware token serial number, which is typically on the back of the device. 


```msgraph-interactive
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

```msgraph-interactive
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
1. Click **Add sign-in method** and choose **Hardware token**.

   :::image type="content" source="media/concept-authentication-oath-tokens/add-sign-in-method.png" alt-text="Screenshot of how to add a new sign-in method in Security info.":::

1. After you select **Hardware token**, click **Add**.

   :::image type="content" source="media/concept-authentication-oath-tokens/add-hardware-token.png" alt-text="Screenshot of how to add a hardware OATH token in Security info.":::

1. Check the back of the device for the serial number, enter it, and click **Next**.

   :::image type="content" source="media/concept-authentication-oath-tokens/add-serial-number.png" alt-text="Screenshot of how to add the serial number of a hardware OATH token.":::

1. Create a friendly name to help you choose this method to complete multifactor authentication, and click **Next**.

   :::image type="content" source="media/concept-authentication-oath-tokens/add-name.png" alt-text="Screenshot of how to add a freindly name for a hardware OATH token.":::

1. Supply the random verification code that appears when you tap the button on the device. You need to enter this code and click **Next** before the code changes.

   :::image type="content" source="media/concept-authentication-oath-tokens/add-code.png" alt-text="Screenshot of how to add a verification code to activate a hardware OATH token.":::

1. When you see the hardware OATH token is successfully added, click **Done**.

   :::image type="content" source="media/concept-authentication-oath-tokens/success.png" alt-text="Screenshot of a hardware OATH token after it is added.":::

1. The hardware OATH token appears in the list of your available authentication methods.

   :::image type="content" source="media/concept-authentication-oath-tokens/new-token.png" alt-text="Screenshot of a hardware OATH token in Security info.":::

Here are steps users can follow to self-activate their hardware OATH token by using Microsoft Graph Explorer.

1. Open Microsoft Graph Explorer, sign in, and consent to the required permissions.
1. Make sure you have the required permissions.
1. Get a list of hardware OATH tokens that are assigned to your account, but not yet activated.

   ```msgraph-interactive
   GET https://graph.microsoft.com/beta/me/authentication/hardwareOathMethods
   ```

1. Copy the **id** of the token device, and add it to the end of the URL followed by */activate*. You need to enter the verification code in the request body and submit the POST call before the code changes.

   ```msgraph-interactive  
   POST https://graph.microsoft.com/beta/me/authentication/hardwareOathMethods/b65fd538-b75e-4c88-bd08-682c9ce98eca/activate
   ```

   Request body:

   ```msgraph-interactive
   {
      "verificationCode": "988659"
   }
   ```

#### Scenario 3: Admin creates token that users self-assign and activate

In this scenario, an Authentication Administrator creates tokens without assignment, and users self-assign and activate the tokens. You can upload new tokens to the tenant in bulk. Users can sign in to [Security info](https://aka.ms/mysecurityinfo) to activate their token. They can choose **Add sign-in method** > **Hardware token**. They need to provide the hardware token serial number, which is typically on the back of the device. 

For greater assurance that the token is only activated by a specific user, you can assign the token to the user, and send the device to them for self-activation.


```msgraph-interactive
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



### Troubleshooting

#### User has two tokens with the same SerialNumber

A user might have two instances of the same hardware OATH token registered as authentication methods. This happens if the legacy token isn't removed from **OATH tokens (Preview)** in the Microsoft Entra admin center after it's uploaded by using Microsoft Graph.

When this happens, both instances of the token are listed as registered for the user:

```msgraph-interactive
GET https://graph.microsoft.com/beta/users/{user-upn-or-objectid}/authentication/hardwareOathMethods
```

Both instances of the token are also listed in **OATH tokens (Preview)** in the Microsoft Entra admin center:

:::image type="content" source="media/concept-authentication-oath-tokens/duplicate-tokens.png" alt-text="Screenshot of the duplicate tokens in the Microsoft Entra admin center.":::

To identify and remove the legacy token.

1. List all Hardware OATH tokens on the user.

   ```msgraph-interactive
   GET https://graph.microsoft.com/beta/users/{user-upn-or-objectid}/authentication/hardwareOathMethods
   ```

   Note the **id** of both tokens and copy the **serialNumber** of the duplicate token.

1. Identify the legacy token. Only one token is returned in the response of the following command. That token was created by using Microsoft Graph.

   ```msgraph-interactive
   GET https://graph.microsoft.com/beta/directory/authenticationMethodDevices/hardwareOathDevices?$filter=serialNumber eq '20033752'
   ```

1. Remove the legacy token assignment from the user. Now that you know the **id** of the new token, you can identify the **id** of the legacy token from the list returned in step 1. Craft the URL using the legacy token **id**.

   ```msgraph-interactive
   DELETE https://graph.microsoft.com/beta/users/{user-upn-or-objectid}/authentication/hardwareOathMethods/{legacyHardwareOathMethodId}
   ```

1. Delete the legacy token by using the legacy token **id** in this call.

   ```msgraph-interactive
   DELETE https://graph.microsoft.com/beta/directory/authenticationMethodDevices/hardwareOathDevices/{legacyHardwareOathMethodId}
   ```

## OATH token icons

Users can add and manage OATH tokens at [Security info](https://aka.ms/mysecurityinfo), or they can select **Security info** from **My account**. Software and hardware OATH tokens have different icons.  

Token registration type | Icon |
------ | ------ |
OATH software token   | <img width="63" alt="Software OATH token" src="media/concept-authentication-methods/software-oath-token-icon.png">  |
OATH hardware token | <img width="63" alt="Hardware OATH token" src="media/concept-authentication-methods/hardware-oath-token-icon.png"> |


## Related content

Learn more about configuring authentication methods using the [Microsoft Graph REST API](/graph/api/resources/authenticationmethods-overview).
Learn about [FIDO2 security key providers](concept-authentication-passwordless.md) that are compatible with passwordless authentication.
