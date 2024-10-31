---
title: Regional telecom restrictions
description: To protect customers, some regions require a support ticket to request to opt in to receive MFA telephony verification Microsoft Entra ID and Micorsoft Azure B2C

author: msmimart
manager: celestedg
ms.service: entra-external-id
ms.subservice: external
ms.topic: how-to
ms.date: 10/07/2024
ms.author: mimart
ms.reviewer: aloom3
ms.custom: it-pro

#Customer intent: As a dev, devops, or it admin, I want to add multifactor authentication to my custoconsumer and business customer app.
---

# Regional telecom restrictions in External ID

[!INCLUDE [applies-to-external-only](../includes/applies-to-external-only.md)]

To safeguard against telephony fraud, Microsoft disallows traffic from certain phone number region codes. Doing so helps to prevent unauthorized access and protect customers from fraudulent activities, like International Revenue Share Fraud (IRSF). With IRSF, criminals gain unauthorized access to a network and divert traffic to premium rate numbers, resulting in exorbitant charges and unreliable services for customers.

For apps in your external tenant, you can activate region codes using the Microsoft Graph API `onPhoneMethodLoadStart` event policy. You can also deactivate regions using this same policy.

## Region codes activated by default

TBD

## Region codes requiring opt-in

For SMS verification, the following region codes are deactivated by default. If you want to allow traffic from these regions, you will need to activate them using the `onPhoneMethodLoadStart`event policy.

**SMS verification region codes requiring opt-in**

| Region Code | Region Name                                    |
|:----------- |:---------------------------------------------- |
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
| 855 | Cambodia |
| 237 | Cameroon |
| 238 | Cape Verde |
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
| 970 | Palestine |
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

## How to activate telecom traffic from regions

To enable telephony traffic from currently deactivated region codes, use the Microsoft Graph API to set the `includeAdditionalRegions` property in the `onPhoneMethodLoadStart` event policy for one or more applications. Include the relevant country codes in the `includeAdditionalRegions` property of the API request body for the regions you want to activate. For example, to send SMS requests in South Asia, activate the numeric region codes for the five countries within that region.

Use the `OnPhoneMethodLoadStartExternalUsersAuthHandler` event policy schema to activate regions.

|Property                  |Description   |
|--------------------------|---------|
|DefaultRegions            |A read-only, pre-defined list of regions where telephony service is enabled. Customers cannot modify this list.          |
|IncludeAdditionalRegions  |A numbers-only set representing the region codes that can be manually added to enable telephony service in those regions, in addition to the list of countries that are already enabled. Regions that require opt in are linked above. Validates against current International Subscriber Dialing (ISD) country codes where the maximum code length is 4. Set cannot overlap ExcludeRegions or include non-numeric characters or null values.          |
|ExcludeRegions            |A numbers-only set representing the region telecom codes to prevent or disable the telephony service. Validates against current International Subscriber Dialing (ISD) country codes where the maximum code length is 4. Set cannot overlap IncludeAdditionalRegions and cannot include non-numeric characters or null values. Exclude does not check the list defined above.   |

```http
POST https://graph.microsoft.com/v1.0/identity/authenticationEventListeners  
{
    "@odata.type": "#microsoft.graph.onPhoneMethodLoadStartListener",  
    "conditions": {  
        "applications": {  
            "includeAllApplications": false,  
            "includeApplications": [  
                "3dfff01b-0afb-4a07-967f-d1ccbd81102a"  
            ]  
        }  
    },  
    "priority": 500,  
    "handler": {  
        "@odata.type": "#microsoft.graph.onPhoneMethodLoadStartExternalUsersAuthHandler", 
        /* An Admin can state the region codes they would like to opt in or opt out from. */ 
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
           "includeAllApplications": false,  

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

## How to deactivate telecom traffic from regions

If want to disable fraudulent requests coming from a region, you can deactivate the region codes using the `excludeRegions` property in the `onPhoneMethodLoadStart` policy.

For example, if an External ID application detects high volumes of SMS messages that are not being used for verification from users in a certain region code, you can deactivate telecom traffic in those regions. To do so, place them in the ‘excludeRegions’ list.

```http
POST https://graph.microsoft.com/v1.0/identity/authenticationEventListeners  

{  

    "@odata.type": "#microsoft.graph.onPhoneMethodLoadStartListener",  

    "conditions": {  

        "applications": {  

            "includeAllApplications": false,  

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
           "includeAllApplications": false,  

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

* [Understanding telephony fraud](concept-mfa-telephony-fraud.md)
* [Authentication methods in Microsoft Entra ID](concept-authentication-authenticator-app.md)
