---
title: Audit Log Events for Microsoft Entra ID self-service account recovery (SSAR)
description: How to set up Microsoft Entra ID self-service account recovery.
ms.service: entra-id
ms.subservice: authentication
ms.topic: how-to
ms.date: 10/15/2025
ms.author: justinha
author: justinha
manager: dougeby
ms.reviewer: timlarso
ms.custom: sfi-ga-nochange, sfi-image-nochange
# Customer intent: As a Microsoft Entra Administrator, I want to learn how to enable and enforce passkeys sign in for end users. Add Unique events and Diagnosing the account recovery experience, determine why and where users fail to recover.  (Help more users avoid the manual help desk)
---
# Audit log events for Microsoft Entra ID self-service account recovery (SSAR)

The following table lists audit events for end users during account recovery. 

Event Name | Outcome | Description 
-----------|---------|------------
User started account recovery | Success | Emitted when user clicks on “recover my account” in login.
User started identity issuance with certified partner | Success | Emitted when we redirect the user to the 3P IDV partner site. 
User completed identity issuance with certified partner | Success | If issuance fails, emit User failed document validation event.
User failed document validation | Failure	| Emit when IDV partner sends signal to VID service that documentation validation failed.
User completed identity presentation  | Success | If presentation fails, emit User failed face check comparison event.
User failed face check comparison | Failure | Emit when the face check failed to match against the verified photo claim from the IDV partner.
User account matched and validated | Success | If user match fails, emit audit User account not matched or validated event.
User account not matched or validated | Failure | Emit when matching verified attributes against directory information fails.
User registered security information | Success	| N/A
User completed account recovery | Success	| N/A

The following table lists audit events in the order of admin setup.

Event Name | Description 
-----------|------------
Account Recovery policy creation started | Emitted if the user selects **Recover my account** when they sign in.
Account Recovery policy creation in progress	| Emitted when the user starts to define a recovery policy, but doesn't save it.<br>Status reason can be<br>- Pending subscription<br>- Pending provisioning
Authentication Method Policy Update	| Modified properties to include Verified ID policy settings that were updated.  
Account Recovery policy created | Details include information from the **Overview** page in the Microsoft Entra admin center, including a link to the **Identity Verification Profile** created.

The following table lists audit events for admins that can occur anytime.

Event Name | Description 
-----------|------------
Identity verification provider subscription updated | Details include the subscription state from Secure Exchange. Emit anytime the subscription status changes. For more information, see [SaaS lifecycle events](/partner-center/marketplace-offers/pc-saas-fulfillment-life-cycle).<br>Status reason can be:<br>- Purchased but not yet activated (PendingFulfillmentStart)<br>- Active (subscribed)<br>- Being updated (Subscribed)<br>- Suspended (Suspended)<br>- Reinstated (Suspended)<br>- Renewed (Subscribed)<br>- Canceled (Unsubscribed)
Account Recovery settings updated | Details include what settings were updated and a policy state before and after the update. Emit when an admin updates global recovery settings. 
Authentication Method Policy Update	| Modified properties to include Verified ID policy settings that were updated.  
