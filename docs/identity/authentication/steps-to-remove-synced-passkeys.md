---  
title: Find and remove synced passkeys  
description: Learn how to find and remove synced passkeys using Microsoft Graph API or Azure Portal. Includes steps for listing, deleting, and auditing passkeys.  
author: Justinha  
contributors:  
ms.topic: conceptual  
ms.date: 03/27/2025  
ms.author: justinha  
ms.reviewer: justinha  
---  

# Steps to find and remove synced passkeys

## Microsoft Graph API

You can use the Microsoft Graph API to programmatically list each user’s authentication methods and find any synced passkeys that they have registered.

1. To list all passkeys registered with a user’s account: 
   
   ```html
   GET https://graph.microsoft.com/beta/users/{id | userPrincipalName}/authentication/fido2Methods
   ``` 

1. Using the beta endpoint, you’ll get access to a new credential property called **passkeyType**. The value for this property is `synced` for synced passkeys.  

1. Note the passkey’s ID for a subsequent delete operation.

For more information, including required permissions, see [List fido2AuthenticationMethod](/graph/api/fido2authenticationmethod-list?view=graph-rest-1.0&tabs=http).  

## Removing registered synced passkeys

### Graph API

You can use the Microsoft Graph API to programmatically delete passkeys.

1. **To delete a passkey from a user’s account:**  
   DELETE https://graph.microsoft.com/v1.0/users/{id | userPrincipalName}/authentication/fido2Methods/{passkeyId}  

For more information, including required permissions, please see [Delete fido2AuthenticationMethod](/graph/api/fido2authenticationmethod-delete?view=graph-rest-1.0&tabs=http).  

### Azure Portal

In the Microsoft Azure Portal, you can view each user’s authentication methods and delete any synced passkeys that they have registered.

1. Go to [portal.azure.com](https://portal.azure.com).  
2. Search for and select **Microsoft Entra ID**.  
3. In the left navigation bar, select **Users**.  
4. Search for the user that you are looking for, then select the user object.  
5. In the left navigation bar, select **Authentication methods**.  
6. Select the three dots on the rightmost end of a passkey entry.  
7. Select **View details** to check if the passkey’s ID matches the synced passkey ID(s) you identified earlier using the Graph API.  
8. Once you have determined which passkey to delete, you can repeat step #6, then select **Delete** to delete the passkey.  

:::image type="content" source="media/steps-to-remove-synced-passkeys/image1.png" alt-text="Screenshot of the Azure Portal showing the steps to delete a synced passkey.":::

## Graveyard

### Audit Logs Approach

#### Azure Portal

In the Microsoft Azure Portal, you can find audit logs that contain records of synced passkey registrations, along with the user who performed the action.

1. Go to [portal.azure.com](https://portal.azure.com).  
2. Search for and select **Microsoft Entra ID**.  
3. In the Entra ID blade, scroll to the bottom of the left navigation bar. Under **Monitoring**, select **Audit logs**.  
4. In the filters, select **Date range** to expand the date range of the presented audit logs. The date range will depend on the data retention policy applied to your licensing SKU. Please see [Microsoft Entra data retention](/entra/identity/monitoring-health/reference-reports-data-retention) for more information.  
5. In the filters, select **Activity**. Then, search for and select **Add Passkey (synced)**. Now you have a set of audit logs for synced passkey registration.  
6. If you click on a log, it will contain more details about the passkey, including its AAGUID and the user who created the passkey.  

:::image type="content" source="media/steps-to-remove-synced-passkeys/image2.png" alt-text="Screenshot of the Azure Portal showing audit logs for synced passkey registrations.":::

#### Graph API

You can also use the Microsoft Graph API to query this information programmatically.

1. **To list audit logs containing synced passkey registrations:**  
   GET https://graph.microsoft.com/v1.0/auditLogs/directoryAudits?\$filter=activityDisplayName eq 'Add Passkey (synced)'  

2. **To list UPNs with registered synced passkeys:**  
   GET https://graph.microsoft.com/v1.0/auditLogs/directoryAudits?\$filter=activityDisplayName eq 'Add Passkey (synced)'&\$select=initiatedBy  

For more information, please see [directoryAudit resource type](/graph/api/resources/directoryaudit?view=graph-rest-1.0).  