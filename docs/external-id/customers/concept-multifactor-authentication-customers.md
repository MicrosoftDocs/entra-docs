---
title: MFA in external tenants
description: Learn about using MFA to secure apps in your external tenant and enabling email one-time passcodes (EOTP) or SMS as a second verification method for sign-up and sign-in.
 
author: msmimart
manager: celestedg
ms.service: entra-external-id

ms.subservice: customers

ms.topic: concept-article
ms.date: 08/14/2024
ms.author: mimart
ms.custom: it-pro

#Customer intent: As a dev, devops, or it admin, I want to learn about ways to secure apps in my external tenant by adding multifactor authentication and enabling SMS and email one-time passcodes.
---

# Multifactor authentication in external tenants

[!INCLUDE [applies-to-external-only](../includes/applies-to-external-only.md)]

[Multifactor authentication (MFA)](~/identity/authentication/concept-mfa-howitworks.md) adds a layer of security to your applications by requiring users to provide a second method for verifying their identity during sign-up or sign-in. External tenants support two methods for authentication as a second factor:

- Email one-time passcode
- SMS based authentication (add-on, see [details below](#sms-based-authentication))

Enforcing MFA enhances your organization's security by adding an extra layer of verification, making it more difficult for unauthorized users to gain access.

## Creating an MFA policy

In an external tenant, you can use Microsoft Entra Conditional Access to create a policy that prompts users for MFA when they sign up or sign in to your app. You create this policy in the Microsoft Entra admin center under Conditional Access in the Protection section. You can specify which users and groups the policy will apply to, including all users and excluding any emergency access or break-glass accounts.

In the policy, you define the applications that will require MFA. You have the option to apply the policy to all cloud apps or select specific apps, while excluding any applications that do not require MFA. Then you configure the policy to grant access only if users complete the MFA requirement.

For details, see [how to create a Conditional Access policy in an external tenant](how-to-multifactor-authentication-customers.md#create-a-conditional-access-policy).

## Enabling MFA methods

When you select identity provider options in your user flows, you define the first-factor authentication methods for sign-up and sign-in. Second-factor verification methods for MFA are configured in a separate section of the Microsoft Entra admin center, under **Authentication methods** in the **Protection** section.

Depending on which option you choose as the first factor, different second-factor verification methods are available for [multifactor authentication (MFA)](how-to-multifactor-authentication-customers.md).

- **Email with password and social identity providers**: For any of these first-factor methods, you can enable email one-time passcode, SMS, or both as second-factor verification methods for MFA.
- **Email one-time passcode**: When email with one-time passcode is selected as the first-factor authentication method, it can't be used for second-factor verification. Therefore, only SMS-based verification can be enable for MFA.

For details, see [how to enable MFA methods in an external tenant](how-to-multifactor-authentication-customers.md#enable-email-one-time-passcode-as-an-mfa-method).

## Email one-time passcode

Email one-time passcode authentication is available in an external tenant both as a first- and second-factor verification method. To allow the use of email one-time passcodes for MFA, your local account authentication method must be set to *Email with password*. If you choose *Email with one-time passcode*, customers who use this method for primary sign-in won't be able to use it for MFA secondary verification.

When email one-time passcode is enabled for MFA, the user signs in with their primary sign-in method and is notified that a code will be sent to the user's email address. The user chooses to send the code, retrieves the passcode from their email inbox, and enters it in the sign-in window.

## SMS-based authentication

SMS is available at an additional cost for second-factor verification in external tenants. Currently, SMS is not available for first-factor authentication in external tenants.

When SMS is enabled for MFA, users sign in with their primary method and are prompted to verify their identity with a code sent via text. They enter their phone number and receive an SMS with the verification code.

   :::image type="content" source="media/concept-multifactor-authentication-customers/sms-text.png" alt-text="Screenshot of the SMS text for MFA." border="false":::

External ID mitigates fraudulent sign-ups via SMS by enforcing the following measures:

- Telephony throttling limits help prevent outages and slowdowns. See [Service limits and restrictions](reference-service-limits.md).
- CAPTCHA for SMS MFA helps prevent automated attacks by distiguishing human users from automated bots. If an attack is detected, users are blocked from signing in, and an SMS verification code is sent only after they complete a CAPTCHA.

### SMS pricing tiers by country/region

The following table provides details about the different pricing tiers for SMS based authentication services across various countries or regions.

|Tier                               |Countries/Regions  |
|-----------------------------------|-------------------|
|Phone Authentication Low Cost      |Australia, Brazil, Brunei, Canada, Chile, China, Colombia, Cyprus, Greenland, Macedonia, Poland, Portugal, South Korea, Thailand, Turkey, United States         |
|Phone Authentication Mid Low Cost  |Albania, American Samoa, Andorra, Angola, Austria, Bahamas, Bahrain, Belgium, Bosnia & Herzegovina, Botswana, Costa Rica, Croatia, Cuba, Czech Republic, Denmark, Dominican Republic, Dominican Republic, Dominican Republic, El Salvador, Estonia, Faroe Islands, Finland, France, French Guiana, Greece, Guam, Honduras, Hong Kong, Hungary, Iceland, India, Ireland, Italy, Japan, Laos, Latvia, Liechtenstein, Lithuania, Luxembourg, Macao, Malta, Mexico, Micronesia, Moldova, Namibia, New Zealand, Nicaragua, Norway, Palau, Paraguay, Peru, Réunion, Romania, Saipan, San Marino, São Tomé and Príncipe, Seychelles Republic, Singapore, Slovakia, Solomon Islands, South Africa, Spain, Sweden, Switzerland, Taiwan, Tuvalu, United Kingdom, United States Virgin Islands, Uruguay         |
|Phone Authentication Mid High Cost |Anguilla, Antarctica, Antigua and Barbuda, Argentina , Armenia, Aruba, Ascension, Barbados, Benin, Bermuda, Bolivia, British Virgin Islands, Bulgaria, Burkina Faso, Cambodia, Cameroon, Cape Verde, Cayman Islands, Central African Republic, Cook Islands, Democratic Republic of Congo, Diego Garcia, Djibouti, Dominica, East Timor, Ecuador, Egypt, Equatorial Guinea, Eritrea, Falkland Islands, Fiji, French Polynesia , Gambia, Georgia , Germany, Ghana, Gibraltar, Grenada, Guadeloupe, Guatemala, Guinea, Guinea-Bissau, Guyana, Israel , Ivory Coast, Jamaica, Jamaica, Kenya, Kiribati, Kosovo, Lesotho, Liberia, Malaysia , Maldives, Mali, Marshall Islands, Martinique, Mauritania, Mauritius , Monaco, Montenegro, Montserrat, Morocco, Mozambique , Netherlands , Netherlands Antilles, New Caledonia, Niue, North Korea, Oman, Panama, Papua New Guinea, Philippines , Puerto Rico, Puerto Rico, Qatar, Rwanda, Saint Helena, Saint Kitts & Nevis, Saint Lucia, Saint Pierre & Miquelon , Saint Vincent and the Grenadines , Samoa, Saudi Arabia, Sierra Leone, Sint Maarten, Slovenia, South Sudan, Suriname, Swaziland (New Name is Kingdom of Eswatini), Tokelau, Tonga, Trinidad & Tobago, Turks & Caicos, Ukraine, United Arab Emirates, Vanuatu, Venezuela , Vietnam, Wallis and Futuna, Zimbabwe         |
|Phone Authentication High Cost     |Afghanistan, Algeria, Azerbaijan , Bangladesh, Belarus, Belize, Bhutan, Burundi, Chad, Comoros, Congo, Ethiopia, Gabonese Republic, Haiti, Indonesia, Iran, Iraq, Jordan, Kuwait , Kyrgyzstan, Lebanon, Libya, Madagascar, Malawi, Mongolia , Myanmar, Nauru, Nepal, Niger, Nigeria, Pakistan, Palestinian National Authority , Russia, Senegal, Serbia, Somalia, Sri Lanka, Sudan, Syria, Tajikistan , Tanzania, Togolese Republic , Tunisia, Turkmenistan, Uganda, Uzbekistan, Yemen, Zambia         |

## Next steps

[Add multifactor authentication (MFA) to an app](how-to-multifactor-authentication-customers.md)