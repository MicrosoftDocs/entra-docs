---
title: OATH tokens authentication method
description: Learn about using OATH tokens in Microsoft Entra ID to help improve and secure sign-in events.

services: active-directory
ms.service: entra-id
ms.subservice: authentication
ms.topic: conceptual
ms.date: 10/31/2024

ms.author: justinha
author: justinha
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

## Hardware OATH tokens (Preview)

Microsoft Entra ID supports the use of OATH-TOTP SHA--256 and SHA-1 tokens that refresh codes every 30 or 60 seconds. Customers can purchase these tokens from the vendor of their choice. Hardware OATH tokens are available for users with a Microsoft Entra ID P1 or P2 license.  

Microsoft Entra ID has a new Microsoft Graph API in preview for Azure and Azure for US Government clouds.

This preview refresh uses the hardware OATH token Authentication methods policy. [Privileged Authentication Administrators](~/identity/role-based-access-control/permissions-reference.md#privileged-authentication-administrator) can use Microsoft Graph to manage tokens in the preview. There aren't any options to manage hardware OATH token in this preview refresh in the Microsoft Entra admin center. 

Hardware OATH tokens that you add with Microsoft Graph for this preview refresh appear along with other tokens in the admin center. But you can only manage them by using Microsoft Graph. Here are features in the preview refresh:

Feature | Description | API/Portal support | Role requirement
--------|-------------|--------------------|-----------------
[Authentication method policy for hardware OATH tokens](#authentication-method-policy-for-hardware-oath-tokens) | You can scope the **Hardware OATH** method to specific users and groups. No need to use the legacy tenant-level setting that applies to both hardware and software OATH tokens. | API available<br>UX – During the private preview. | Global Administrator<br>Authentication Policy Administrator
[User authentication methods in Microsoft Graph](#user-authentication-methods-in-microsoft-graph) | Assign and activate a token from the tenant inventory to a specific user under the user’s authentication method in the Microsoft Entra admin center. | API, UX – available. | Global Administrator<br>Authentication Administrator<br>Privileged Authentication Administrator (to assign a token to a privileged user)
[User self-assignment and activation](#user-self-assignment-and-activation) | Users can assign and activate token on themselves from the security info flow. | API – Available.<br>Security Info UX – will be become available during the preview. | Users manage themselves 

### Improvements in the preview refresh

This hardware OATH token preview refresh improves flexibility and security for organizations by removing Global Administrator requirements. 
Organizations can delegate token creation, assignment, and activation to Privileged Authentication Authentication Policy Administrator. 

End users can also self-assign and activate tokens from their [Security info](https://mysignins.microsoft.com/security-info) page. For more information, see [User self-assignment and activation](#user-self-assignment-and-activation).

The following table compares the administrator role requirements to manage hardware OATH tokens in the preview refresh versus original preview option.

| Task | Details | Original preview | Preview refresh |
|------|---------|------------------|-----------------|
| Create | Create a new token in the tenant’s inventory. | Global Administrator | Authentication Policy Administrator |
| Read   | Read a token from the tenant’s inventory; doesn't return the secret. | Global Administrator | Authentication Policy Administrator |
| Update | Update a token in the tenant. For example, update manufacturer or module; Secret can't be updated. | Global Administrator | Authentication Policy Administrator |
| Delete a token | Delete a token from the tenant’s inventory. | Global Administrator | Authentication Policy Administrator |

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
"secretKey": "Gg7Hh~8Ii9.-Jj0Kk1Ll2Mm3Nn4Oo5_Pp6Qq7Rr8", 
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




Let's try another example where a creates two tokens, with hashFunction optional. The hashFunction is SHA-1 by default. For SHA-256, enter `hmacsha256` as the value for the property. 

PATCH https://graph.microsoft.com/beta/directory/authenticationMethodDevices/hardwareOathDevices
{
"@context":"#$delta", 
"value": [ 
    { 
        "@contentId": "1", 
        "serialNumber": "GALT11420108", 
        "manufacturer": "Thales", 
        "model": "OTP 110 Token", 
        "secretKey": "Bb2Cc~3Dd4.-Ee5Ff6Gg7Hh8Ii9Jj0_Kk1Ll2Mm3", 
        "timeIntervalInSeconds": 30, 
        "hashFunction": "hmacsha1" 
        },
    { 
        "@contentId": "2", 
        "serialNumber": "GALT11420112", 
        "manufacturer": "Thales", 
        "model": "OTP 110 Token", 
        "secretKey": "Cc3Dd~4Ee5.-Ff6Gg7Hh8Ii9Jj0Kk1_Ll2Mm3Nn4", 
        "timeIntervalInSeconds": 30, 
        "hashFunction": "hmacsha1" 
        }
    ]          
} 

POST https://graph.microsoft.com/beta/users/0cadbf92-af6b-4cf4-ba77-3f381e059551/authentication/hardwareOathMethods
{
    "device": 
    {
        "id": "6c0272a7-8a5e-490c-bc45-9fe7a42fc4e0" 
    }
}




### User self-assignment and activation



| Task | Details | Token state | Role requirement |
|------|---------|------------------|-----------------|
| Create | Assign a token from the inventory to a user in the tenant. | Assigned | Member (self)<br>Authentication Administrator<br>Privileged Authentication Administrator |
| Read   | Read the token of the userl doesn't return the secret. | Activated / Assigned  (depends if the token was already activated or not) | Member (self)<br>Authentication Administrator (only has restricted Read, not standard Read)<br>Privileged Authentication Administrator  |
| Update | Update the token of the user, such as provide current 6-digit code for activation, or change token name. | Activated | Member (self)<br>Authentication Administrator<br>Privileged Authentication Administrator |
| Delete | Remove the token from the user. The token goes back to the token inventory. | Available (back to the tenant inventory) | Member (self)<br>Authentication Administrator<br>Privileged Authentication Administrator |

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
"secretKey": "A1bC2dE3fH4iJ5kL6mN7oP8qR9sT0u", 
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

To validate the token is activated, sign in as the test user.


#### Scenario 2: Admin creates and assigns a token that a user activates

In this scenario, an Authentication Administrator creates and assigns a token, and then a user can activate it on their Security info page.


#### Scenario 3: Admin creates a token that a user self-assigns and activates

In this scenario, an Authentication Administrator creates tokens without assignment, and users self-assign and activate the tokens.


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

### Upload tokens in CSV format

OATH TOTP hardware tokens typically come with a secret key, or seed, pre-programmed in the token. As an alternative to using the new Microsoft Graph API in preview, A Global Administrator can input these keys into Microsoft Entra ID. Secret keys are limited to 128 characters, which is not compatible with some tokens. The secret key can only contain the characters *a-z* or *A-Z* and digits *2-7*, and must be encoded in *Base32*.

Programmable OATH TOTP hardware tokens that can be reseeded can also be set up with Microsoft Entra ID in the software token setup flow.


:::image type="content" border="true" source="./media/concept-authentication-methods/oath-tokens.png" alt-text="Screenshot of OATH token management." lightbox="./media/concept-authentication-methods/oath-tokens.png":::

Once tokens are acquired, a Global Administrator must upload them in a comma-separated values (CSV) file format. The file should include the UPN, serial number, secret key, time interval, manufacturer, and model, as shown in the following example:

```csv
upn,serial number,secret key,time interval,manufacturer,model
Helga@contoso.com,1234567,2234567abcdef2234567abcdef,60,Contoso,HardwareKey
```

> [!NOTE]
> Make sure you include the header row in your CSV file. 

Once properly formatted as a CSV file, the Global Administrator can then sign in to the Microsoft Entra admin center, navigate to **Protection** > **Multifactor authentication** > **OATH tokens**, and upload the resulting CSV file.

Depending on the size of the CSV file, it can take a few minutes to process. Select the **Refresh** button to get the current status. If there are any errors in the file, you can download a CSV file that lists any errors for you to resolve. The field names in the downloaded CSV file are different than the uploaded version.  

Once any errors are addressed, a Privileged Authentication Administrator or an end user can activate a key. Select **Activate** for the token and enterthe OTP displayed on the token. You can activate a maximum of 200 OATH tokens every 5 minutes. 

Users can have a combination of up to five OATH hardware tokens or authenticator applications, such as the Microsoft Authenticator app, configured for use at any time. Hardware OATH tokens can't be assigned to guest users in the resource tenant. 

> [!IMPORTANT]
> Make sure to only assign each token to a single user.
> A single token can't be assigned to multiple users.

## Troubleshooting a failure during upload processing

At times, there may be conflicts or issues that occur with the processing of an upload of the CSV file. If any conflict or issue occurs, you'll receive a notification similar to the following:  

:::image type="content" border="true" source="./media/concept-authentication-methods/upload-error-example.png" alt-text="Screenshot of upload error example.":::
  
To determine the error message, be sure and select **View Details**. The **Hardware token status** blade opens and provides the summary of the status of the upload. It shows that there's been a failure, or multiple failures, as in the following example:

:::image type="content" border="true" source="./media/concept-authentication-methods/hardware-token-status.png" alt-text="Screenshot of hardware token status example.":::

To determine the cause of the failure listed, make sure to click the checkbox next to the status you want to view, which activates the **Download** option. This downloads a CSV file that contains the error identified. 

:::image type="content" border="true" source="./media/concept-authentication-methods/download-status-example.png" alt-text="Screenshot of download status example.":::

The downloaded file is named **Failures_filename.csv** where *filename* is the name of the file uploaded. It's saved to your default downloads directory for your browser. 

This example shows the error identified as a user who doesn't currently exist in the tenant directory:  

:::image type="content" border="true" source="./media/concept-authentication-methods/error-reason-example.png" alt-text="Screenshot of error reason example.":::

Once you've addressed the errors listed, upload the CSV again until it processes successfully. The status information for each attempt remains for 30 days. The CSV can be manually removed by clicking the checkbox next to the status, then selecting **Delete status** if so desired. 

## Determine OATH token registration type

Users can manage and add OATH token registrations by accessing [mysecurityinfo](https://aka.ms/mysecurityinfo) or by selecting **Security info** from **My account**. Specific icons are used to differentiate whether the OATH token registration is hardware or software based.  

Token registration type | Icon |
------ | ------ |
OATH software token   | <img width="63" alt="Software OATH token" src="media/concept-authentication-methods/software-oath-token-icon.png">  |
OATH hardware token | <img width="63" alt="Hardware OATH token" src="media/concept-authentication-methods/hardware-oath-token-icon.png"> |


## Next steps

Learn more about configuring authentication methods using the [Microsoft Graph REST API](/graph/api/resources/authenticationmethods-overview).
Learn about [FIDO2 security key providers](concept-authentication-passwordless.md) that are compatible with passwordless authentication.
