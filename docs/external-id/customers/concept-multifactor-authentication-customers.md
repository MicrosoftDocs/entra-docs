---
title: MFA in external tenants
description: Learn about using MFA to secure apps in your external tenant and enabling email one-time passcodes (EOTP) or SMS as a second verification method for sign-up and sign-in.
 
author: msmimart
manager: celestedg
ms.service: entra-external-id

ms.subservice: customers

ms.topic: concept-article
ms.date: 08/08/2024
ms.author: mimart
ms.custom: it-pro

#Customer intent: As a dev, devops, or it admin, I want to learn about ways to secure apps in my external tenant by adding multifactor authentication and enabling SMS and email one-time passcodes.
---

# Multifactor authentication in external tenants

[!INCLUDE [applies-to-external-only](../includes/applies-to-external-only.md)]

[Multifactor authentication (MFA)](~/identity/authentication/concept-mfa-howitworks.md) adds a layer of security to your applications by requiring users to provide a second method for verifying their identity during sign-up or sign-in. In your external tenant, you can use Microsoft Entra Conditional Access policies to require MFA during the sign-in or sign-in process. External tenants support two methods for authentication as a second factor:

- Email one-time passcode
- SMS based authentication

During the sign-up or sign-in process, users are prompted to register for an MFA method. Depending on how you've configured the user flow and which methods you've enabled, the user can choose either the email one-time passcode or SMS verification method.

## Setting up MFA in an external tenant

External tenants support both email one-time passcodes and SMS-based authentication for second-factor verification. The local email account options that you configure in your user flows, including using an email with a password or an email one-time passcode, serve as first-factor authentication methods for sign-up and sign-in. Depending on which of these options you choose as the first factor, you'll have different second-factor authentication methods available for [multifactor authentication (MFA)](how-to-multifactor-authentication-customers.md).

- **Email with password**: Users can create a local account using their email as the username and a password. When enabling MFA, you can offer second-factor verification through email one-time passcodes, SMS-based authentication, or both.
- **Email one-time passcode**: Users can set up a local account with their email as the username and a one-time passcode sent to their email. For MFA, second-factor verification is limited to SMS-based authentication only. Because the one-time passcode is the primary sign-in method, it can't be used for secondary verification.

For details, see [Add multifactor authentication (MFA) to an app](how-to-multifactor-authentication-customers.md).

## Email one-time passcode

Email one-time passcode authentication is available in an external tenant both as a first- and second-factor verification method. To allow the use of email one-time passcodes for MFA, your local account authentication method must be set to *Email with password*. If you choose *Email with one-time passcode*, customers who use this method for primary sign-in won't be able to use it for MFA secondary verification.

When email one-time passcode is enabled for MFA, the user first signs in with their primary sign-in method. Then a message in the browser indicates that a code will be sent to the user's email address. The user chooses to send the code, retrieves the passcode from their email inbox, and enters it in the browser window.

## SMS-based authentication

While SMS isn't an option for first factor authentication, it's available as a second factor for MFA. Users who sign in with email and password, email and one-time passcode, or social identities like Google or Facebook, are prompted for second verification using SMS. Our SMS MFA includes automatic fraud checks. If we suspect fraud, we'll ask the user to complete a CAPTCHA to confirm they're not a robot before sending the SMS code for verification.


## SMS based authentication for MFA

When a user attempts to sign in, your Conditional Access policy requires the user to satisfy the MFA requirement. The user is prompted to complete verification with SMS. Our SMS MFA includes automatic fraud checks. If we suspect fraud, we'll ask the user to complete a CAPTCHA before sending them the SMS OTP for verification. The user enters their phone number, and then receives an SMS text with a verification code.

   :::image type="content" source="media/concept-multifactor-authentication-customers/sms-text.png" alt-text="Screenshot of the SMS text for MFA." border="false":::

## SMS pricing tiers by country/region

The following table provides details about the different pricing tiers for SMS based authentication services across various countries or regions.

|Tier                               |Countries/Regions  |
|-----------------------------------|-------------------|
|*Phone Authentication Low Cost*      |Australia, Brazil, Brunei, Canada, Chile, China, Colombia, Cyprus, Greenland, Macedonia, Poland, Portugal, South Korea, Thailand, Turkey, United States         |
|Phone Authentication Mid Low Cost  |Albania, American Samoa, Andorra, Angola, Austria, Bahamas, Bahrain, Belgium, Bosnia & Herzegovina, Botswana, Costa Rica, Croatia, Cuba, Czech Republic, Denmark, Dominican Republic, Dominican Republic, Dominican Republic, El Salvador, Estonia, Faroe Islands, Finland, France, French Guiana, Greece, Guam, Honduras, Hong Kong, Hungary, Iceland, India, Ireland, Italy, Japan, Laos, Latvia, Liechtenstein, Lithuania, Luxembourg, Macao, Malta, Mexico, Micronesia, Moldova, Namibia, New Zealand, Nicaragua, Norway, Palau, Paraguay, Peru, Réunion, Romania, Saipan, San Marino, São Tomé and Príncipe, Seychelles Republic, Singapore, Slovakia, Solomon Islands, South Africa, Spain, Sweden, Switzerland, Taiwan, Tuvalu, United Kingdom, United States Virgin Islands, Uruguay         |
|Phone Authentication Mid High Cost |Anguilla, Antarctica, Antigua and Barbuda, Argentina , Armenia, Aruba, Ascension, Barbados, Benin, Bermuda, Bolivia, British Virgin Islands, Bulgaria, Burkina Faso, Cambodia, Cameroon, Cape Verde, Cayman Islands, Central African Republic, Cook Islands, Democratic Republic of Congo, Diego Garcia, Djibouti, Dominica, East Timor, Ecuador, Egypt, Equatorial Guinea, Eritrea, Falkland Islands, Fiji, French Polynesia , Gambia, Georgia , Germany, Ghana, Gibraltar, Grenada, Guadeloupe, Guatemala, Guinea, Guinea-Bissau, Guyana, Israel , Ivory Coast, Jamaica, Jamaica, Kenya, Kiribati, Kosovo, Lesotho, Liberia, Malaysia , Maldives, Mali, Marshall Islands, Martinique, Mauritania, Mauritius , Monaco, Montenegro, Montserrat, Morocco, Mozambique , Netherlands , Netherlands Antilles, New Caledonia, Niue, North Korea, Oman, Panama, Papua New Guinea, Philippines , Puerto Rico, Puerto Rico, Qatar, Rwanda, Saint Helena, Saint Kitts & Nevis, Saint Lucia, Saint Pierre & Miquelon , Saint Vincent and the Grenadines , Samoa, Saudi Arabia, Sierra Leone, Sint Maarten, Slovenia, South Sudan, Suriname, Swaziland (New Name is Kingdom of Eswatini), Tokelau, Tonga, Trinidad & Tobago, Turks & Caicos, Ukraine, United Arab Emirates, Vanuatu, Venezuela , Vietnam, Wallis and Futuna, Zimbabwe         |
|Phone Authentication High Cost     |Afghanistan, Algeria, Azerbaijan , Bangladesh, Belarus, Belize, Bhutan, Burundi, Chad, Comoros, Congo, Ethiopia, Gabonese Republic, Haiti, Indonesia, Iran, Iraq, Jordan, Kuwait , Kyrgyzstan, Lebanon, Libya, Madagascar, Malawi, Mongolia , Myanmar, Nauru, Nepal, Niger, Nigeria, Pakistan, Palestinian National Authority , Russia, Senegal, Serbia, Somalia, Sri Lanka, Sudan, Syria, Tajikistan , Tanzania, Togolese Republic , Tunisia, Turkmenistan, Uganda, Uzbekistan, Yemen, Zambia         |

## Next steps

[Add multifactor authentication (MFA) to an app](how-to-multifactor-authentication-customers.md)