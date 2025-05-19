---
title: Regional telecom restrictions
description: To protect customers, some regions require a support ticket to request to opt in to receive MFA telephony verification Microsoft Entra ID and Microsoft Azure B2C

ms.service: entra-id
ms.subservice: authentication
ms.topic: conceptual
ms.date: 03/04/2025

author: aloom3
ms.author: justinha
manager: femila
ms.reviewer: aloom3
ms.custom: references_regions
---
# Regions that need to opt in for MFA telephony verification  

This applies to Entra tenants only.

For B2C tenants follow the guidelines here: [B2C service limits](https://learn.microsoft.com/azure/active-directory-b2c/service-limits)

For Entra External ID tenants follow the guidelines here: [How to region code opt-in](../../external-id/customers/how-to-region-code-opt-in.md)

As a protection for our customers, Microsoft doesn't automatically support telephony verification for certain region codes. If you want to receive traffic from phone numbers with these region codes, your administrator must submit a support ticket and request to opt in.  

## Why this protection is needed  

In today's digital world, telecommunication services have become ingrained into our lives. But, advancements come with a risk of fraudulent activities. International Revenue Share Fraud (IRSF) is a threat with severe financial implications that also makes using services more difficult. Let's look at IRSF fraud more in-depth.  

IRSF is a type of telephony fraud where criminals exploit the billing system of telecommunication services providers to make profit for themselves. Bad actors gain unauthorized access to a telecommunication network and divert traffic to those networks to skim profit for every transaction that is sent to that network. To divert traffic, bad actors steal existing usernames and passwords, create new usernames and passwords, or try a host of other things to send text messages and voice calls through their telecommunication network. Bad actors take advantage of multifactor authentication screens, which require a text message or voice call before a user can access their account. This activity causes exorbitant charges and makes services unreliable for our customers, causing downtime, and system errors.  

Here's how an IRSF attack may happen:  

1. A bad actor first gets premium rate phone numbers and registers them.  
1. A bad actor uses automated scripts to request voice calls or text messages. The bad actor is colluding with number providers and the telecommunication network to drive more traffic to those services. The bad actor skims some of the profits of the increased traffic.  
1. A bad actor will hop around different region codes to continue to drive traffic and make it hard for them to get caught.  

The most common way to conduct IRSF is through an end-user experience that requires a two-factor authentication code. Bad actors add those premium rate phone numbers and pump traffic to them by requesting two-factor authentication codes. This activity results in revenue-skimming, and can lead to billions of dollars in loss.  

IRSF poses a significant threat to online businesses and can cause reputational damage. By understanding IRSF, you can be more aware of the problem and can engage in implementing preventive measures such as regional restrictions, rate limiting, and phone number verification.  

## SMS and Voice verification
 
For SMS and Voice verification, the following region codes require an opt-in. This means that if you'd like to use telecom in these regions, you'll have to reach out to support.

| Region Code | Region Name |
|------------|------------|
| 7 | Russia |
| 20 | Egypt |
| 27 | South Africa |
| 30 | Greece |
| 31 | Netherlands |
| 32 | Belgium |
| 36 | Hungary |
| 39 | Italy |
| 40 | Romania |
| 41 | Switzerland |
| 43 | Austria |
| 44 | United Kingdom |
| 45 | Denmark |
| 46 | Sweden |
| 47 | Norway |
| 48 | Poland |
| 49 | Germany |
| 51 | Peru |
| 52 | Mexico |
| 53 | Cuba |
| 54 | Argentina |
| 55 | Brazil |
| 56 | Chile |
| 57 | Colombia |
| 58 | Venezuela |
| 60 | Malaysia |
| 62 | Indonesia |
| 63 | Philippines |
| 64 | New Zealand |
| 65 | Singapore |
| 66 | Thailand |
| 81 | Japan |
| 82 | South Korea |
| 84 | Vietnam |
| 86 | China |
| 90 | Turkey |
| 91 | India |
| 92 | Pakistan |
| 93 | Afghanistan |
| 94 | Sri Lanka |
| 95 | Myanmar |
| 98 | Iran |
| 211 | South Sudan |
| 212 | Morocco |
| 213 | Algeria |
| 216 | Tunisia |
| 218 | Libya |
| 220 | Gambia |
| 221 | Senegal |
| 222 | Mauritania |
| 223 | Mali |
| 224 | Guinea |
| 225 | Cote d'Ivoire |
| 226 | Burkina Faso |
| 227 | Niger |
| 228 | Togo |
| 229 | Benin |
| 230 | Mauritius |
| 231 | Liberia |
| 232 | Sierra Leone |
| 233 | Ghana |
| 234 | Nigeria |
| 235 | Chad |
| 236 | Central African Republic |
| 237 | Cameroon |
| 238 | Cabo Verde |
| 239 | São Tomé and Príncipe |
| 240 | Equatorial Guinea |
| 241 | Gabon |
| 242 | Congo |
| 243 | Congo |
| 244 | Angola |
| 245 | Guinea-Bissau |
| 246 | British Indian Ocean Territory |
| 247 | Ascension Island |
| 248 | Seychelles |
| 248 | Seychelles Republic |
| 249 | Sudan |
| 250 | Rwanda |
| 251 | Ethiopia |
| 252 | Somalia |
| 253 | Djibouti |
| 254 | Kenya |
| 255 | Tanzania |
| 256 | Uganda |
| 257 | Burundi |
| 258 | Mozambique |
| 260 | Zambia |
| 261 | Madagascar |
| 262 | Mayotte |
| 263 | Zimbabwe |
| 264 | Namibia |
| 265 | Malawi |
| 266 | Lesotho |
| 267 | Botswana |
| 268 | Antigua and Barbuda |
| 269 | Comoros |
| 290 | Saint Helena, Ascension, and Tristan da Cunha |
| 291 | Eritrea |
| 297 | Aruba |
| 298 | Faroe Islands |
| 299 | Greenland |
| 350 | Gibraltar |
| 351 | Portugal |
| 352 | Luxembourg |
| 353 | Republic of Ireland |
| 354 | Iceland |
| 355 | Albania |
| 356 | Malta |
| 357 | Cyprus |
| 358 | Finland |
| 359 | Bulgaria |
| 370 | Lithuania |
| 371 | Latvia |
| 372 | Estonia |
| 373 | Moldova |
| 374 | Armenia |
| 375 | Belarus |
| 376 | Andorra |
| 377 | Monaco |
| 378 | San Marino |
| 380 | Ukraine |
| 381 | Serbia |
| 382 | Montenegro |
| 383 | Kosovo |
| 385 | Croatia |
| 386 | Slovenia |
| 387 | Bosnia and Herzegovina |
| 389 | North Macedonia |
| 420 | Czech Republic |
| 421 | Slovakia |
| 423 | Liechtenstein |
| 500 | Falkland Islands |
| 501 | Belize |
| 502 | Guatemala |
| 503 | El Salvador |
| 504 | Honduras |
| 505 | Nicaragua |
| 506 | Costa Rica |
| 507 | Panama |
| 508 | Saint Pierre and Miquelon |
| 509 | Haiti |
| 590 | Saint Barthelemy, Saint Martin, Guadeloupe |
| 591 | Bolivia |
| 592 | Guyana |
| 593 | Ecuador |
| 594 | French Guiana |
| 595 | Paraguay |
| 596 | Martinique |
| 597 | Suriname |
| 598 | Uruguay |
| 599 | Curacao |
| 670 | Timor-Leste |
| 672 | Antarctica |
| 673 | Brunei |
| 674 | Nauru |
| 675 | Papua New Guinea |
| 676 | Tonga |
| 677 | Solomon Islands |
| 678 | Vanuatu |
| 679 | Fiji |
| 680 | Palau |
| 681 | Wallis and Futuna |
| 682 | Cook Islands |
| 683 | Niue |
| 685 | Samoa |
| 686 | Kiribati |
| 687 | New Caledonia |
| 688 | Tuvalu |
| 689 | French Polynesia |
| 690 | Tokelau |
| 691 | Micronesia |
| 691 | Federated States of Micronesia |
| 692 | Marshall Islands |
| 850 | North Korea |
| 852 | Hong Kong |
| 853 | Macau |
| 855 | Cambodia |
| 856 | Laos |
| 880 | Bangladesh |
| 886 | Taiwan |
| 960 | Maldives |
| 961 | Lebanon |
| 962 | Jordan |
| 963 | Syria |
| 964 | Iraq |
| 965 | Kuwait |
| 966 | Saudi Arabia |
| 967 | Yemen |
| 968 | Oman |
| 970 | Palestinian Authority |
| 971 | United Arab Emirates |
| 972 | Israel |
| 973 | Bahrain |
| 974 | Qatar |
| 975 | Bhutan |
| 976 | Mongolia |
| 977 | Nepal |
| 992 | Tajikistan |
| 993 | Turkmenistan |
| 994 | Azerbaijan |
| 995 | Georgia |
| 996 | Kyrgyzstan |
| 998 | Uzbekistan |
| 1242 | Bahamas |
| 1246 | Barbados |
| 1264 | Anguilla |
| 1268 | Antigua and Barbuda |
| 1284 | British Virgin Islands |
| 1340 | United States Virgin Islands |
| 1345 | Cayman Islands |
| 1441 | Bermuda |
| 1473 | Grenada |
| 1649 | Turks and Caicos Islands |
| 1658 | Jamaica |
| 1664 | Montserrat |
| 1670 | Northern Mariana Islands |
| 1671 | Guam |
| 1684 | American Samoa |
| 1721 | Sint Maarten |
| 1758 | Saint Lucia |
| 1767 | Dominica |
| 1784 | Saint Vincent and the Grenadines |
| 1787 | Puerto Rico |
| 1809 | Dominica |
| 1849 | Dominican Republic |
| 1868 | Trinidad and Tobago |
| 1869 | Saint Kitts and Nevis |
| 1876 | Jamaica |
| 1939 | Puerto Rico |


## Next steps

* [Understanding telephony fraud](concept-mfa-telephony-fraud.md)
* [Authentication methods in Microsoft Entra ID](concept-authentication-authenticator-app.md)
