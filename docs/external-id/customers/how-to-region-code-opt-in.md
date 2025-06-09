---
title: Regional opt-in for MFA telephony verification with external tenants (preview)
description: To protect customers, some regions require you to enable the country codes to receive SMS telephony verification for Microsoft Entra External ID external tenants.

ms.author: cmulligan
author: csmulligan
manager: dougeby
ms.service: entra-external-id
ms.subservice: external
ms.topic: how-to
ms.date: 11/12/2024
ms.reviewer: aloom3
ms.custom: it-pro, references_regions

#Customer intent: As a dev, devops, or it admin, I want to prevent telephony fraud by choosing which countries and regions to accept telecom traffic from.
---

# Regional opt-in for MFA telephony verification with external tenants (preview)

[!INCLUDE [applies-to-external-only](../includes/applies-to-external-only.md)]

To safeguard against telephony fraud, Microsoft disallows traffic from certain phone number country codes. Doing so helps prevent unauthorized access and protect customers from fraudulent activities such as International Revenue Share Fraud (IRSF). With IRSF, criminals gain unauthorized access to a network and divert traffic to premium rate numbers, resulting in exorbitant charges and making it harder for your customers to access your services. [Learn more](~/identity/authentication/concept-mfa-telephony-fraud.md).

When a country code is blocked, customers trying to set up SMS verification for multifactor authentication (MFA) for your application might encounter the message "Try another verification method." To resolve this issue, you can activate telephony traffic for the specific country code for your application.

You can use the Microsoft Graph API `onPhoneMethodLoadStart` event policy to manage telephony traffic for apps in your external tenant. With this event policy, you can activate or deactivate country codes for specific countries and regions.

[!INCLUDE [preview alert](includes/preview-alert/preview-alert-ciam.md)]

## Country codes requiring opt-in

Starting January 2025, the following country codes will be deactivated by default for SMS verification. If you want to allow traffic from deactivated regions, you need to activate them using the `onPhoneMethodLoadStart`event policy.

**Table 1. SMS verification country codes requiring opt-in**

| Country code | Region Name |
|:------------ |:----------- |
| 93  | Afghanistan |
| 213 | Algeria |
| 244 | Angola |
| 374 | Armenia |
| 994 | Azerbaijan |
| 880 | Bangladesh |
| 375 | Belarus |
| 501 | Belize |
| 229 | Benin |
| 975 | Bhutan |
| 591 | Bolivia |
| 387 | Bosnia and Herzegovina |
| 359 | Bulgaria |
| 226 | Burkina Faso |
| 257 | Burundi |
| 238 | Cabo Verde |
| 855 | Cambodia |
| 237 | Cameroon |
| 235 | Central African Republic |
| 269 | Comoros |
| 243 | Congo (Democratic Republic of the) |
| 242 | Congo (Republic of the) |
| 225 | Côte d'Ivoire |
| 385 | Croatia |
| 53 | Cuba |
| 253 | Djibouti |
| 593 | Ecuador |
| 20 | Egypt |
| 503 | El Salvador |
| 291 | Eritrea |
| 251 | Ethiopia |
| 679 | Fiji |
| 689 | French Polynesia |
| 241 | Gabon |
| 220 | Gambia |
| 995 | Georgia |
| 233 | Ghana |
| 590 | Guadeloupe |
| 502 | Guatemala |
| 224 | Guinea |
| 245 | Guinea-Bissau |
| 592 | Guyana |
| 509 | Haiti |
| 62 | Indonesia |
| 98 | Iran |
| 964 | Iraq |
| 1876 | Jamaica |
| 962 | Jordan |
| 254 | Kenya |
| 686 | Kiribati |
| 383 | Kosovo |
| 965 | Kuwait |
| 996 | Kyrgyzstan |
| 961 | Lebanon |
| 266 | Lesotho |
| 231 | Liberia |
| 218 | Libya |
| 261 | Madagascar |
| 265 | Malawi |
| 223 | Mali |
| 222 | Mauritania |
| 230 | Mauritius |
| 262 | Mayotte |
| 691 | Micronesia |
| 373 | Moldova |
| 976 | Mongolia |
| 212 | Morocco |
| 258 | Mozambique |
| 95 | Myanmar |
| 977 | Nepal |
| 687 | New Caledonia |
| 505 | Nicaragua |
| 227 | Niger |
| 234 | Nigeria |
| 968 | Oman |
| 92 | Pakistan |
| 970 | Palestinian Authority |
| 675 | Papua New Guinea |
| 63 | Philippines |
| 974 | Qatar |
| 7 | Russia, Kazakhstan |
| 250 | Rwanda |
| 290 | Saint Helena |
| 508 | Saint Pierre and Miquelon |
| 1784 | Saint Vincent and the Grenadines |
| 685 | Samoa |
| 377 | San Marino |
| 966 | Saudi Arabia |
| 221 | Senegal |
| 232 | Sierra Leone |
| 1721 | Sint Maarten |
| 386 | Slovenia |
| 252 | Somalia |
| 211 | South Sudan |
| 94 | Sri Lanka |
| 249 | Sudan |
| 963 | Syria |
| 992 | Tajikistan |
| 255 | Tanzania |
| 670 | Timor-Leste |
| 672 | Timor-Leste |
| 228 | Togo |
| 690 | Tonga |
| 216 | Tunisia |
| 993 | Turkmenistan |
| 256 | Uganda |
| 380 | Ukraine |
| 971 | United Arab Emirates |
| 998 | Uzbekistan |
| 678 | Vanuatu |
| 84 | Vietnam |
| 967 | Yemen |
| 260 | Zambia |
| 263 | Zimbabwe |

## Manage telecom for regions with Microsoft Graph

Use the `OnPhoneMethodLoadStartExternalUsersAuthHandler` event policy to activate or deactivate country codes.

**Table 2. Properties of OnPhoneMethodLoadStartExternalUsersAuthHandler**

|Property                  |Description   |
|--------------------------|---------|
|DefaultRegions            |A string of comma-separated country codes where telephony service is enabled by default. Read-only.          |
|IncludeAdditionalRegions  |A string of comma-separated country codes to enable for telephony service in addition to default country codes. Codes are validated against current International Subscriber Dialing (ISD) country codes, where max length is 4. The same code can't be specified in both IncludeAdditionalRegions and in ExcludeRegions.      |
|ExcludeRegions            |A string of comma-separated country codes to disable for telephony service. Codes are validated against current ISD country codes, where max length is 4. The same code can't be specified in both IncludeAdditionalRegions and in ExcludeRegions.   |

### How to activate telecom for regions

To enable telephony traffic from currently deactivated country codes, use the Microsoft Graph API to set the `includeAdditionalRegions` property in the `onPhoneMethodLoadStart` event policy for one or more applications. Include the relevant country codes in the `includeAdditionalRegions` property of the API request body for the regions you want to activate. For example, to send SMS requests in South Asia, activate the numeric country codes for the specific countries within that region.

#### Example REST APIs

```http
POST https://graph.microsoft.com/v1.0/identity/authenticationEventListeners  
{  
    "@odata.type": "#microsoft.graph.onPhoneMethodLoadStartListener",  
    "conditions": {  
        "applications": {  
            "includeApplications": [  
                "3dfff01b-0afb-4a07-967f-d1ccbd81102a"  
            ]  
        }  
    },  
    "priority": 500,  
    "handler": {  
        "@odata.type": "#microsoft.graph.onPhoneMethodLoadStartExternalUsersAuthHandler", 
        /* An Admin can state the country codes they would like to opt in or opt out from. */ 
        { 
                "includeAdditionalRegions": [222, 998], 
                 "excludeRegions": [] 
      } 
} 

HTTP/1.1 201 Created 
{ 
    "@odata.context": "https://microsoft.graph.microsoft.com/v1.0/$metadata#identity/authenticationEventListeners/$entity", 
    "@odata.type": "#microsoft.graph.onPhoneMethodLoadStartListener", 
    "id": "2be3336b-e3b4-44f3-9128-b6fd9ad39bb8", 
    "conditions": {  
        "applications": { 
            "includeApplications": [  
                "3dfff01b-0afb-4a07-967f-d1ccbd81102a"  
            ] 
        }   
    },   
    "handler": 
    {   
        "@odata.type": "#microsoft.graph.onPhoneMethodLoadStartExternalUsersAuthHandler ",  
        { 
            "includeAdditionalRegions": [222, 998], 
            "excludeRegions": [] 
        }, 
    } 
} 
```

### How to deactivate telecom for regions

If you want to disable fraudulent requests coming from a region, you can deactivate the country codes using the `excludeRegions` property in the `onPhoneMethodLoadStart` policy.

For example, if an External ID application detects a high volume of nonverification SMS messages from a specific country code, you can deactivate telecom in that region. To do so, place the country code in the `excludeRegions` list.

#### Example REST APIs

```http
POST https://graph.microsoft.com/v1.0/identity/authenticationEventListeners  
{  
    "@odata.type": "#microsoft.graph.onPhoneMethodLoadStartListener",  
    "conditions": {  
        "applications": {  
            "includeApplications": [  
                "3dfff01b-0afb-4a07-967f-d1ccbd81102a"  
            ]  
        }  
    },  
    "priority": 500,  
    "handler": {  
        "@odata.type": "#microsoft.graph.onPhoneMethodLoadStartExternalUsersAuthHandler", 
        /* An Admin can state the country codes they would like to opt in or opt out from. */ 
        { 
                "includeAdditionalRegions": [222, 998], 
                 "excludeRegions": [1001, 99, 777] 
      } 
} 

HTTP/1.1 201 Created 
{ 
    "@odata.context": "https://microsoft.graph.microsoft.com/v1.0/$metadata#identity/authenticationEventListeners/$entity", 
    "@odata.type": "#microsoft.graph.onPhoneMethodLoadStartListener", 
    "id": "2be3336b-e3b4-44f3-9128-b6fd9ad39bb8", 
    "conditions": {  
        "applications": { 
            "includeApplications": [  
                "3dfff01b-0afb-4a07-967f-d1ccbd81102a"  
            ] 
        }   
    },   
    "handler": 
    {   
        "@odata.type": "#microsoft.graph.onPhoneMethodLoadStartExternalUsersAuthHandler ",  
        { 
            "includeAdditionalRegions": [222, 998], 
            "excludeRegions": [] 
        }, 
    } 
}  
```

## Next steps

- [Understanding telephony fraud](~/identity/authentication/concept-mfa-telephony-fraud.md)
- [Add multifactor authentication (MFA) to an app](how-to-multifactor-authentication-customers.md)
- [Service limits and restrictions](reference-service-limits.md)
