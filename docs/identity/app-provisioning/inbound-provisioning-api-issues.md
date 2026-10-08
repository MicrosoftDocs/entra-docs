---
title: Troubleshoot issues with inbound provisioning API
description: This article provides potential issues and resolutions that guide you in how to troubleshoot issues with the inbound provisioning API.
ms.topic: troubleshooting
ms.date: 07/07/2026
ms.reviewer: chmutali
ai-usage: ai-assisted
---

# Troubleshoot inbound provisioning API issues

## Introduction

This document covers commonly encountered errors and issues with inbound provisioning API and how to troubleshoot them.

## Troubleshooting scenarios

### Invalid data format 

**Issue description**
* You're getting the error message ```Invalid Data Format``` with HTTP 400 (Bad Request) response code.

**Probable causes**
1. You're sending a valid bulk request as per the provisioning [/bulkUpload](/graph/api/synchronization-synchronizationjob-post-bulkupload) API specs, but you have not set the HTTP Request Header 'Content-Type' to `application/scim+json`. 
2. You're sending a bulk request that doesn't comply to the provisioning [/bulkUpload](/graph/api/synchronization-synchronizationjob-post-bulkupload) API specs.

**Resolution:**
1. Ensure the HTTP Request has the `Content-Type` header set to the value ```application/scim+json```.
1. Ensure that the bulk request payload complies to the provisioning [/bulkUpload](/graph/api/synchronization-synchronizationjob-post-bulkupload) API specs.

### There's nothing in the provisioning logs

**Issue description**
* You sent a request to the provisioning /bulkUpload API endpoint and you got HTTP 202 response code, but there's no data in the provisioning logs corresponding to your request. 

**Probable causes**
1. Your API-driven provisioning app is paused. 
1. The provisioning service is yet to update the provisioning logs with the bulk request processing details.
2. Your On-premises provisioning agent status is inactive (If you're running the [/API-driven inbound user provisioning to on-premises Active Directory](https://go.microsoft.com/fwlink/?linkid=2245182)).


**Resolution:**
1. Verify that your provisioning app is running. If it isn't running, select the menu option **Start provisioning** to process the data.
2. Turn your On-premises provisioning agent status to active by restarting the On-premises agent.
1. Expect a 5-minute to 10-minute delay between processing the request and writing to the provisioning logs. If your API client is sending data to the provisioning /bulkUpload API endpoint, then introduce a time delay between the request invocation and provisioning logs query. 

### Forbidden 403 response code 

**Issue description**
* You sent a request to the provisioning /bulkUpload API endpoint and you got HTTP 403 (Forbidden) response code. 

**Probable causes**
* The Graph permission `SynchronizationData-User.Upload` isn't assigned to your API client. 

**Resolution:**
* Assign your API client the Graph permission `SynchronizationData-User.Upload` and retry the operation. 

### Too many requests 429 response code

The bulkUpload API endpoint enforces the following throttling limits and returns a 429 response code if these limits are breached. 

- 40 API calls per 5 seconds – if the number of calls go beyond this limit in a 5-second range, then the client gets a 429 response. One way to avoid this is by *pacing* the request submission using delays in the client request submission logic. 

- 6,000 API calls over a 24-hour period – if the number of calls go beyond this limit, then the client gets a 429 response. One way to prevent this is to make sure that your SCIM bulk payload is optimized to use the max 50 records per API call. With this approach, you can send 300K records every 24 hours. 

### Bucket full 500 response code

**Issue description**
* The SCIM client gets HTTP 500 (Internal Server Error) with the message: "The bucket that stores the ingested data is full, please wait for the synchronization service to process the ingested data and retry this request."
* You might see this error during initial sync or full sync cycles when large HR datasets are sent to the provisioning `/bulkUpload` endpoint.

**Why this error occurs**
* The "bucket" is the temporary ingestion queue used by the provisioning service to buffer incoming `/bulkUpload` payloads before they are processed.
* Each API-driven provisioning job has a dedicated ingestion queue.
* The provisioning service continuously processes queued payloads and then deletes processed data. If this process-and-delete cycle falls behind or stops, queued data can build up until the bucket is full.

**Probable causes and resolution**

| Cause | Resolution |
| --- | --- |
| Payload processing fails due to incorrect mappings (for example, trying to update Microsoft Entra ID attributes managed by on-premises Active Directory) or invalid data. Failed payloads remain in the queue, which can eventually fill the bucket. | Review the provisioning logs to identify failed request processing, fix mapping or data issues, restart the provisioning job, and resend the requests. |
| The API-driven provisioning job is in **Paused** or **Stopped** state. Requests continue to queue, but processing doesn't run. | Resume the provisioning job so it can process and clear queued requests. |
| The API-driven provisioning job remains in **Quarantined** state for a long period. Requests continue to queue, but processing doesn't run. | Restart the provisioning job to clear quarantine. During restart, existing queued data is cleared, which might take time. Wait about 40 minutes, then resend SCIM `/bulkUpload` requests. |
| Source systems send SCIM data faster than the provisioning job can process it. | Pace request submission. After each bulk upload, check the HTTP status code. If you get HTTP 500 with the bucket-full message, pause the client (for example, 5 to 10 minutes) before retrying. |


### Unauthorized 401 response code

**Issue description**
* You sent a request to the provisioning /bulkUpload API endpoint and you got HTTP 401 (Unauthorized) response code. The error code displays "InvalidAuthenticationToken" with a message that the "Access token has expired or is not yet valid."  

**Probable causes**
* Your access token has expired. 

**Resolution:**
* Generate a new access token for your API client. 

### The job enters quarantine state

**Issue description**
* You just started the provisioning app and it is in quarantine state. 

**Probable causes**
* You have not set the notification email prior to starting the job. 

**Resolution:**
Go to the **Edit Provisioning** menu item. Under **Settings** there's a checkbox next to **Send an email notification when a failure occurs** and a field to input your **Notification Email**. Make sure to check the box, provide an email, and save the change. Click **Restart provisioning** to get the job out of quarantine. 

### User creation - Invalid UPN

**Issue description**
There's a user provisioning failure. The provisioning logs displays the error code: ```AzureActiveDirectoryInvalidUserPrincipalName```.  

**Resolution:**
1. Got to the **Edit Attribute Mappings** page.
2. Select the ```UserPrincipalName``` mapping and update it to use the ```RandomString``` function. 
3. Copy and paste this expression into the expression box:
```Join("", Replace([userName], , "(?<Suffix>@(.)*)", "Suffix", "", , ), RandomString(3, 3, 0, 0, 0, ), "@", DefaultDomain())```

This expression fixes the issue by appending a random number to the UPN value accepted by Microsoft Entra ID.

### User creation failed - Invalid domain

**Issue description**
There's a user provisioning failure. The provisioning logs displays an error message that states ```domain does not exist```.  

**Resolution:**
1. Go to the **Edit Attribute Mappings** page. 
2. Select the ```UserPrincipalName``` mapping and copy and paste this expression into the expression input box: 
```Join("", Replace([userName], , "(?<Suffix>@(.)*)", "Suffix", "", , ), RandomString(3, 3, 0, 0, 0, ), "@", DefaultDomain())```

This expression fixes the issue by appending a default domain to the UPN value accepted by Microsoft Entra ID. 

### Known limitation: multi-valued addresses, emails and phone numbers

**Issue description**
* API-driven provisioning does not currently process SCIM multi-valued attributes in `addresses`, `emails` and `phoneNumbers` when the `type` value is `home` or any other non-`work` value.
* This limitation applies to expressions such as `addresses[type eq "home"]`, `addresses[type eq "any-other-value"]`, and `phoneNumbers[type eq "home"]`.

**Current behavior**
* Only `addresses[type eq "work"]`, `emails[type eq "work"]` and `phoneNumbers[type eq "work"]` values are processed.

**Workaround**
* Send supported values using the `work` type when you need the attribute to be processed by API-driven provisioning.

## Next steps

* [Learn more about API-driven inbound provisioning](inbound-provisioning-api-concepts.md)
