---
title: Upload hardware OATH tokens in CSV format
description: Learn how to upload hardware OATH tokens in Microsoft Entra ID by using CSV file and Global Administrator role.
services: active-directory
ms.topic: how-to
ms.date: 12/11/2025
author: efdake
ms.reviewer: lvandenende
ms.collection: M365-identity-device-management
ms.custom: sfi-ga-nochange
# Customer intent: As an identity administrator, I want to understand how to upload hardware OATH tokens in Microsoft Entra ID by using CSV file and Global Administrator role.
---

# Upload hardware OATH tokens in CSV format

Hardware OATH tokens typically come with a secret key, or seed, preprogrammed in the token. 
Before a user can sign in to their work or school account in Microsoft Entra ID by using a hardware OATH token, an administrator needs to add the token to the tenant. 

The recommended way to add the token is by using Microsoft Graph with a least privileged administrator role. An updated process that uses a least privileged role is in preview. For more information, see [Hardware OATH tokens (preview)](concept-authentication-oath-tokens.md#hardware-oath-tokens-preview).

As an alternative to using Microsoft Graph APIs, tenants with a Microsoft Entra ID Premium license can have a Global Administrator input these keys into Microsoft Entra ID. 
If you upload tokens in CSV format, they aren't compatible with the new features in preview.  
To use the Hardware OATH tokens preview instead of CSV upload, see [How to manage OATH tokens in Microsoft Entra ID (Preview)](how-to-mfa-manage-oath-tokens.md).


## CSV format 

Secret keys are limited to 128 characters, which isn't compatible with some tokens. The secret key can only contain the characters *a-z* or *A-Z* and digits *2-7*, and must be encoded in *Base32*.

Programmable OATH time-based one-time passcode (TOTP) hardware tokens that can be reseeded can also be set up with Microsoft Entra ID in the software token setup flow.


:::image type="content" border="true" source="./media/concept-authentication-methods/oath-tokens.png" alt-text="Screenshot of OATH token management." lightbox="./media/concept-authentication-methods/oath-tokens.png":::

Once tokens are acquired, a Global Administrator must upload them in a comma-separated values (CSV) file format. The file should include the UPN, serial number, secret key, time interval, manufacturer, and model, as shown in the following example:

```csv
upn,serial number,secret key,time interval,manufacturer,model
Helga@contoso.com,1234567,2234567abcdef2234567abcdef,60,Contoso,HardwareKey
```

> [!NOTE]
> Make sure you include the header row in your CSV file. 

Once properly formatted as a CSV file, the Global Administrator can then sign in to the Microsoft Entra admin center, navigate to **Entra ID** > **Multifactor authentication** > **OATH tokens**, and upload the resulting CSV file.

Depending on the size of the CSV file, it can take a few minutes to process. Select the **Refresh** button to get the current status. If there are any errors in the file, you can download a CSV file that lists any errors for you to resolve. The field names in the downloaded CSV file are different than the uploaded version.  

Users can have a combination of up to five OATH hardware tokens or authenticator applications, such as the Microsoft Authenticator app, configured for use at any time. Hardware OATH tokens can't be assigned to guest users in the resource tenant. 

> [!IMPORTANT]
> Make sure to only assign each token to a single user.
> A single token can't be assigned to multiple users.

## Troubleshooting a failure during upload processing

At times, there may be conflicts or issues that occur with the processing of an upload of the CSV file. If any conflict or issue occurs, you get notified like this:  

:::image type="content" border="true" source="./media/concept-authentication-methods/upload-error-example.png" alt-text="Screenshot of upload error example.":::
  
To determine the error message, be sure and select **View Details**. The **Hardware token status** blade opens and provides the summary of the status of the upload. It shows if there's a failure, or multiple failures, as in the following example:

:::image type="content" border="true" source="./media/concept-authentication-methods/hardware-token-status.png" alt-text="Screenshot of hardware token status example.":::

To determine the cause of the failure listed, make sure to select the checkbox next to the status you want to view, which activates the **Download** option. This option downloads a CSV file that contains the error identified. 

:::image type="content" border="true" source="./media/concept-authentication-methods/download-status-example.png" alt-text="Screenshot of download status example.":::

The downloaded file is named **Failures_filename.csv**, where *filename* is the name of the file uploaded. The file is saved to your default downloads directory for your browser. 

This example shows the error identified as a user who doesn't currently exist in the tenant directory:  

:::image type="content" border="true" source="./media/concept-authentication-methods/error-reason-example.png" alt-text="Screenshot of error reason example.":::

After you fix the errors listed, upload the CSV again until it processes successfully. The status information for each attempt remains for 30 days. To remove the CSV, select the checkbox next to the status, then select **Delete status**. 
