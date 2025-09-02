---
title: Microsoft Entra multifactor authentication data residency
description: Learn what personal and organizational data Microsoft Entra multifactor authentication stores about you and your users and what data remains within the country/region of origin.


ms.service: entra-id
ms.subservice: authentication
ms.topic: article
ms.date: 06/06/2025

ms.author: justinha
author: justinha
manager: dougeby
ms.reviewer: inbarc
ms.custom: references_regions
---
# Data residency and customer data for Microsoft Entra multifactor authentication

Microsoft Entra ID stores customer data in a geographical location based on the address an organization provides when subscribing to a Microsoft online service such as Microsoft 365 or Azure. For information on where your customer data is stored, see [Where your data is located](https://www.microsoft.com/trust-center/privacy/data-location) in the Microsoft Trust Center.

Microsoft Entra multifactor authentication processes and stores personal data and organizational data. This article outlines what and where data is stored.

The Microsoft Entra multifactor authentication service has datacenters in the United States, Europe, and Asia Pacific. The following activities originate from the regional datacenters except where noted:

* Multifactor authentication SMS and phone calls originate from datacenters in the customer's region and are routed by global providers. **These providers may route the SMS or phone call outside of the user and company location.** Phone calls using custom greetings always originate from data centers in the United States.
* General purpose user authentication requests from other regions are currently processed based on the user's location.
* Push notifications that use the Microsoft Authenticator app are currently processed in regional datacenters based on the user's location. Vendor-specific device services, such as Apple Push Notification Service or Google Firebase Cloud Messaging, might be outside the user's location.

<a name='personal-data-stored-by-azure-ad-multifactor-authentication'></a>

## Personal data stored by Microsoft Entra multifactor authentication

Personal data is user-level information that's associated with a specific person. The following data stores contain personal information:

* Bypassed users
* Microsoft Authenticator device token change requests
* Multifactor authentication activity reports—store multifactor authentication activity from the multifactor authentication on-premises components NPS Extension and AD FS adapter.
* Microsoft Authenticator activations

This information is retained for 90 days.

Microsoft Entra multifactor authentication doesn't log personal data such as usernames, phone numbers, or IP addresses. However, *UserObjectId* identifies authentication attempts to users. Log data is stored for 30 days.

<a name='data-stored-by-azure-ad-multifactor-authentication'></a>

### Data stored by Microsoft Entra multifactor authentication

For Azure public clouds, excluding Azure AD B2C authentication, the NPS Extension, and the Windows Server 2016 or 2019 Active Directory Federation Services (AD FS) adapter, the following personal data is stored:

| Event type                           | Data store type |
|--------------------------------------|-----------------|
| OATH token                           | Multifactor authentication logs     |
| One-way SMS                          | Multifactor authentication logs     |
| Voice call                           | Multifactor authentication logs<br/>Multifactor authentication activity report data store |
| Microsoft Authenticator notification | Multifactor authentication logs<br/>Multifactor authentication activity report data store<br/>Change requests when the Microsoft Authenticator device token changes |

For Microsoft Azure Government, Microsoft Azure operated by 21Vianet, Azure AD B2C authentication, the NPS extension, and the Windows Server 2016 or 2019 AD FS adapter, the following personal data is stored:

| Event type                           | Data store type |
|--------------------------------------|-----------------|
| OATH token                           | Multifactor authentication logs<br/>Multifactor authentication activity report data store |
| One-way SMS                          | Multifactor authentication logs<br/>Multifactor authentication activity report data store |
| Voice call                           | Multifactor authentication logs<br/>Multifactor authentication activity report data store |
| Microsoft Authenticator notification | Multifactor authentication logs<br/>Multifactor authentication activity report data store<br/>Change requests when the Microsoft Authenticator device token changes |

<a name='organizational-data-stored-by-azure-ad-multifactor-authentication'></a>

## Organizational data stored by Microsoft Entra multifactor authentication

Organizational data is tenant-level information that can expose configuration or environment setup. Tenant settings from the multifactor authentication pages might store organizational data such as lockout thresholds or caller ID information for incoming phone authentication requests:

* Account lockout
* Notifications
* Phone call settings

## Related content

For more information about what user information is collected by Microsoft Entra multifactor authentication, see [Microsoft Entra multifactor authentication user data collection](howto-mfa-reporting-datacollection.md).
