---
title: OATH tokens authentication method
description: Learn about using OATH tokens in Microsoft Entra ID to help improve and secure sign-in events.

services: active-directory
ms.service: entra-id
ms.subservice: authentication
ms.topic: conceptual
ms.date: 02/14/2024

ms.author: justinha
author: justinha
manager: amycolannino

ms.collection: M365-identity-device-management

# Customer intent: As an identity administrator, I want to understand how to use OATH tokens in Microsoft Entra ID to improve and secure user sign-in events.
---

# Authentication methods in Microsoft Entra ID - OATH tokens 

OATH time-based one-time password (TOTP) is an open standard that specifies how one-time password (OTP) codes are generated. OATH TOTP can be implemented using either software or hardware to generate the codes. Microsoft Entra ID doesn't support OATH HOTP, a different code generation standard.

## OATH software tokens

Software OATH tokens are typically applications such as the Microsoft Authenticator app and other authenticator apps. Microsoft Entra ID generates the secret key, or seed, that's input into the app and used to generate each OTP.

The Authenticator app automatically generates codes when set up to do push notifications so a user has a backup even if their device doesn't have connectivity. Third-party applications that use OATH TOTP to generate codes can also be used.

Some OATH TOTP hardware tokens are programmable, meaning they don't come with a secret key or seed preprogrammed. These programmable hardware tokens can be set up using the secret key or seed obtained from the software token setup flow. Customers can purchase these tokens from the vendor of their choice and use the secret key or seed in their vendor's setup process.

## OATH hardware tokens (Preview)

Microsoft Entra ID supports the use of OATH-TOTP SHA-1 tokens that refresh codes every 30 or 60 seconds. Customers can purchase these tokens from the vendor of their choice. Hardware OATH tokens are available for users with a Microsoft Entra ID P1 or P2 license.  

> [!IMPORTANT]
> The preview is only supported in Azure Global and Azure Government clouds.

OATH TOTP hardware tokens typically come with a secret key, or seed, pre-programmed in the token. These keys must be input into Microsoft Entra ID as described in the following steps. Secret keys are limited to 128 characters, which is not compatible with some tokens. The secret key can only contain the characters *a-z* or *A-Z* and digits *2-7*, and must be encoded in *Base32*.

Programmable OATH TOTP hardware tokens that can be reseeded can also be set up with Microsoft Entra ID in the software token setup flow.

OATH hardware tokens are supported as part of a public preview. For more information about previews, see [Supplemental Terms of Use for Microsoft Azure Previews](https://aka.ms/EntraPreviewsTermsOfUse).

:::image type="content" border="true" source="./media/concept-authentication-methods/oath-tokens.png" alt-text="Screenshot of OATH token management." lightbox="./media/concept-authentication-methods/oath-tokens.png":::

Once tokens are acquired, they must be uploaded in a comma-separated values (CSV) file format. The file should include the UPN, serial number, secret key, time interval, manufacturer, and model, as shown in the following example:

```csv
upn,serial number,secret key,time interval,manufacturer,model
Helga@contoso.com,1234567,2234567abcdef2234567abcdef,60,Contoso,HardwareKey
```

> [!NOTE]
> Make sure you include the header row in your CSV file. 

Once properly formatted as a CSV file, a Global Administrator can then sign in to the Microsoft Entra admin center, navigate to **Protection** > **Multifactor authentication** > **OATH tokens**, and upload the resulting CSV file.

Depending on the size of the CSV file, it can take a few minutes to process. Select the **Refresh** button to get the current status. If there are any errors in the file, you can download a CSV file that lists any errors for you to resolve. The field names in the downloaded CSV file are different than the uploaded version.  

Once any errors are addressed, the administrator then can activate each key by selecting **Activate** for the token and entering the OTP displayed on the token. You can activate a maximum of 200 OATH tokens every 5 minutes. 

Users can have a combination of up to five OATH hardware tokens or authenticator applications, such as the Microsoft Authenticator app, configured for use at any time. Hardware OATH tokens can't be assigned to guest users in the resource tenant. 

> [!IMPORTANT]
> Make sure to only assign each token to a single user.
> In the future, support for the assignment of a single token to multiple users stops to prevent a security risk.

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
