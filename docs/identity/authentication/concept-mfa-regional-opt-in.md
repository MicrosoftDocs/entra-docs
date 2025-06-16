---
title: Telephony Fraud Protections and Throttles  
description: Microsoft Entra ID uses heuristics and machine learning to detect and throttle suspicious telephony activity during MFA. Some regions require opt-in via support ticket due to elevated fraud risk.

ms.service: entra-id  
ms.subservice: authentication  
ms.topic: conceptual  
ms.date: 05/20/2025

author: justinha
ms.author: justinha
manager: dougeby
ms.reviewer: aloom3
ms.custom: references_regions

---

# Overview

To protect customers from telephony-based abuse and fraud, Microsoft Entra ID applies intelligent detection and throttling mechanisms to all telecom-based authentication requests.

These protections use a combination of heuristics, machine learning models, and risk-based signals to detect and block potentially abusive or fraudulent telephony activity in real time.

In addition, some region codes require opt-in. Admins can submit a support request to enable telephony verification for these regions if needed.

Together, these safeguards help organizations defend against fraud while preserving a smooth authentication experience for legitimate users.

B2C tenants can follow the guidelines in [B2C service limits](/azure/active-directory-b2c/service-limits).  
Microsoft Entra External ID tenants can follow the guidelines in [How to region code opt-in](/entra/external-id/customers/how-to-region-code-opt-in).

## Behind-the-Scenes Protections

To combat telephony fraud, Microsoft Entra ID employs layered protections that assess each telephony transaction (SMS or voice call) using a combination of heuristics, risk signals, and machine learning models.

These protections help detect:

- Unusual call volumes or repeated attempts  
- High-risk geographic or carrier patterns  
- Known abusive behavior signals  
- Abuse of free or metered phone number services  

When a transaction is flagged as potentially abusive:

- The transaction may be throttled, preventing immediate delivery of the SMS or voice call.  
- The user may see a "Sorry, we're having trouble verifying your account" message.  
- The user can choose an alternative authentication method, such as using the Microsoft Authenticator app or another registered method.  

New tenants are subject to additional safeguards to prevent abuse from newly created or compromised tenants. Specifically, telephony activity is throttled for the first few days after a tenant is created to limit excess telecom usage and reduce fraud exposure during this high-risk window.

## Why This Protection Is Needed

In today's digital world, telecommunication services have become ingrained in our lives. However, advancements also come with increased risk of fraudulent activities. International Revenue Share Fraud (IRSF) is a threat with severe financial implications that can also degrade service reliability.

IRSF is a type of telephony fraud where criminals exploit the billing systems of telecommunication service providers to profit. Bad actors gain unauthorized access to a telecom network and divert traffic to premium rate numbers to skim profits from each transaction sent to those numbers. To drive traffic, bad actors may steal credentials, create new accounts, or exploit MFA workflows that send text messages or voice calls. This behavior results in excessive charges, unreliability, and service interruptions for customers.

Here’s how an IRSF attack typically works:

1. A bad actor registers premium rate phone numbers.  
2. They use automated scripts to repeatedly request voice calls or text messages. In collaboration with telecom providers, they drive traffic to their numbers and skim a share of the profit.  
3. They rotate across region codes to evade detection and maximize profits.  

The most common IRSF attack vector is through end-user MFA, which relies on text or voice calls. Bad actors exploit these mechanisms to funnel traffic to premium numbers, resulting in large-scale revenue skimming and potentially billions in losses.

IRSF poses a significant threat to online services and can cause reputational harm. Understanding the threat enables implementation of preventative measures like regional restrictions, rate limiting, and phone number verification.

## Regions That Require Opt-In for MFA Telephony Verification

For SMS and voice verification, the following region codes require opt-in. If you want to enable telephony in these regions, you must submit a support request.

**Note:** We strongly recommend configuring more than one authentication method, with at least one being non-telecom-based.

**Note:** If a user previously received SMS or voice calls in a country but has stopped receiving them, throttling may be in effect. Retry after some time. If users in a tenant cannot receive SMS or voice calls in a specific country and that country is listed below, it may mean the tenant is not enabled for telecom authentication in that region. In such cases, we recommend using an alternative method to unblock the user. If telecom authentication is required and alternatives are unavailable, please open a support ticket.

Region Code | Region Name  
------------|-------------  
Afghanistan|93  
Albania|355  
Algeria|213  
American Samoa|1684  
Andorra|376  
Angola|244  
Anguilla|1264  
Antarctica|672  
Antigua and Barbuda|268  
Antigua and Barbuda|1268  
Argentina|54  
Armenia|374  
Aruba|297  
Ascension Island|247  
Austria|43  
Azerbaijan|994  
Bahamas|1242  
Bahrain|973  
Bangladesh|880  
Barbados|1246  
Belarus|375  
Belgium|32  
Belize|501  
Benin|229  
Bermuda|1441  
Bhutan|975  
Bolivia|591  
Bosnia and Herzegovina|387  
Botswana|267  
Brazil|55  
British Indian Ocean Territory|246  
British Virgin Islands|1284  
Brunei|673  
Bulgaria|359  
Burkina Faso|226  
Burundi|257  
Cabo Verde|238  
Cambodia|855  
Cameroon|237  
Cayman Islands|1345  
Central African Republic|236  
Chad|235  
Chile|56  
China|86  
Colombia|57  
Comoros|269  
Congo|242  
Congo (DRC)|243  
Cook Islands|682  
Costa Rica|506  
Côte d'Ivoire|225  
Croatia|385  
Cuba|53  
Curaçao|599  
Cyprus|357  
Czech Republic|420  
Denmark|45  
Djibouti|253  
Dominica|1767  
Dominican Republic|1809  
Dominican Republic|1849  
Ecuador|593  
Egypt|20  
El Salvador|503  
Equatorial Guinea|240  
Eritrea|291  
Estonia|372  
Ethiopia|251  
Falkland Islands|500  
Faroe Islands|298  
Micronesia (Federated States)|691  
Fiji|679  
Finland|358  
French Guiana|594  
French Polynesia|689  
Gabon|241  
Gambia|220  
Georgia|995  
Germany|49  
Ghana|233  
Gibraltar|350  
Greece|30  
Greenland|299  
Grenada|1473  
Guam|1671  
Guatemala|502  
Guinea|224  
Guinea-Bissau|245  
Guyana|592  
Haiti|509  
Honduras|504  
Hong Kong SAR|852  
Hungary|36  
Iceland|354  
India|91  
Indonesia|62  
Iran|98  
Iraq|964  
Israel|972  
Italy|39  
Jamaica|1658  
Jamaica|1876  
Japan|81  
Jordan|962  
Kenya|254  
Kiribati|686  
Kosovo|383  
Kuwait|965  
Kyrgyzstan|996  
Laos|856  
Latvia|371  
Lebanon|961  
Lesotho|266  
Liberia|231  
Libya|218  
Liechtenstein|423  
Lithuania|370  
Luxembourg|352  
Macao SAR|853  
Madagascar|261  
Malawi|265  
Malaysia|60  
Maldives|960  
Mali|223  
Malta|356  
Marshall Islands|692  
Martinique|596  
Mauritania|222  
Mauritius|230  
Mayotte|262  
Mexico|52  
Micronesia|691  
Moldova|373  
Monaco|377  
Mongolia|976  
Montenegro|382  
Montserrat|1664  
Morocco|212  
Mozambique|258  
Myanmar|95  
Namibia|264  
Nauru|674  
Nepal|977  
Netherlands|31  
New Caledonia|687  
New Zealand|64  
Nicaragua|505  
Niger|227  
Nigeria|234  
Niue|683  
North Korea|850  
North Macedonia|389  
Northern Mariana Islands|1670  
Norway|47  
Oman|968  
Pakistan|92  
Palau|680  
Palestinian Territories|970  
Panama|507  
Papua New Guinea|675  
Paraguay|595  
Peru|51  
Philippines|63  
Poland|48  
Portugal|351  
Puerto Rico|1787  
Puerto Rico|1939  
Qatar|974  
Republic of Ireland|353  
Romania|40  
Russia|7  
Rwanda|250  
Saint Barthélemy, Saint Martin, Guadeloupe|590  
Saint Helena, Ascension, Tristan da Cunha|290  
Saint Kitts and Nevis|1869  
Saint Lucia|1758  
Saint Pierre and Miquelon|508  
Saint Vincent and the Grenadines|1784  
Samoa|685  
San Marino|378  
São Tomé and Príncipe|239  
Saudi Arabia|966  
Senegal|221  
Serbia|381  
Seychelles|248  
Sierra Leone|232  
Singapore|65  
Sint Maarten|1721  
Slovakia|421  
Slovenia|386  
Solomon Islands|677  
Somalia|252  
South Africa|27  
South Korea|82  
South Sudan|211  
Sri Lanka|94  
Sudan|249  
Suriname|597  
Sweden|46  
Switzerland|41  
Syria|963  
Taiwan|886  
Tajikistan|992  
Tanzania|255  
Thailand|66  
Timor-Leste|670  
Togo|228  
Tokelau|690  
Tonga|676  
Trinidad and Tobago|1868  
Tunisia|216  
Türkiye|90  
Turkmenistan|993  
Turks and Caicos Islands|1649  
Tuvalu|688  
Uganda|256  
Ukraine|380  
United Arab Emirates|971  
United Kingdom|44  
United States Virgin Islands|1340  
Uruguay|598  
Uzbekistan|998  
Vanuatu|678  
Venezuela|58  
Vietnam|84  
Wallis and Futuna|681  
Yemen|967  
Zambia|260  
Zimbabwe|263

## Next Steps

- [Understanding telephony fraud](concept-mfa-telephony-fraud.md)  
- [Authentication methods in Microsoft Entra ID](concept-authentication-authenticator-app.md)
