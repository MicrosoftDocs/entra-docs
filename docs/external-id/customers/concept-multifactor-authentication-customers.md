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
- SMS based authentication, available as an add-on ([see details](#sms-based-authentication))

Enforcing MFA enhances your organization's security by adding an extra layer of verification, making it more difficult for unauthorized users to gain access.

## Creating an MFA policy

In an external tenant, you can use Microsoft Entra Conditional Access to create a policy that prompts users for MFA when they sign up or sign in to your app. You create this policy in the Microsoft Entra admin center under Conditional Access in the Protection section. You can specify which users and groups the policy apply to, including all users and excluding any emergency access or break-glass accounts.

In the policy, you define the applications that require MFA. You can apply the policy to all cloud apps or select specific apps, while excluding any applications that don't require MFA. Then you configure the policy to grant access only if users complete the MFA requirement.

For details, see [how to create a Conditional Access policy in an external tenant](how-to-multifactor-authentication-customers.md#create-a-conditional-access-policy).

## Enabling MFA methods

When you select identity provider options in your user flows, you define the first-factor authentication methods for sign-up and sign-in. Second-factor verification methods for MFA are configured in a separate section of the Microsoft Entra admin center, under **Authentication methods** in the **Protection** section.

Depending on which option you choose as the first factor, different second-factor verification methods are available for [multifactor authentication (MFA)](how-to-multifactor-authentication-customers.md).

- **Email with password and social identity providers**: For any of these first-factor methods, you can enable email one-time passcode, SMS, or both as second-factor verification methods for MFA.
- **Email one-time passcode**: When email with one-time passcode is selected as the first-factor authentication method, it can't be used for second-factor verification. Therefore, only SMS-based verification can be enabled for MFA.

For details, see [how to enable MFA methods in an external tenant](how-to-multifactor-authentication-customers.md#enable-email-one-time-passcode-as-an-mfa-method).

## Email one-time passcode

Email one-time passcode authentication is available in an external tenant both as a first- and second-factor verification method. To allow the use of email one-time passcodes for MFA, your local account authentication method must be set to *Email with password*. If you choose *Email with one-time passcode*, customers who use this method for primary sign-in aren't able to use it for MFA secondary verification.

When email one-time passcode is enabled for MFA, the user signs in with their primary sign-in method and is notified that a code will be sent to the user's email address. The user chooses to send the code, retrieves the passcode from their email inbox, and enters it in the sign-in window.

## SMS-based authentication

SMS is available at additional cost for second-factor verification in external tenants. Currently, SMS is not available for first-factor authentication in external tenants.

When SMS is enabled for MFA, users sign in with their primary method and are prompted to verify their identity with a code sent via text. They enter their phone number and receive an SMS with the verification code.

   :::image type="content" source="media/concept-multifactor-authentication-customers/sms-text.png" alt-text="Screenshot of the SMS text for MFA." border="false":::

External ID mitigates fraudulent sign-ups via SMS by enforcing the following measures:

- Telephony throttling limits help prevent outages and slowdowns. See [Service limits and restrictions](reference-service-limits.md).
- CAPTCHA for SMS MFA helps prevent automated attacks by distinguishing human users from automated bots. If an attack is detected, users are blocked from signing in, and an SMS verification code is sent only after they complete a CAPTCHA.

### SMS pricing tiers by country/region

The following table provides details about the different pricing tiers for SMS based authentication services across various countries or regions.

|Tier                               |Countries/Regions  |
|-----------------------------------|-------------------|
|Phone Authentication Low Cost      |Australia, Brazil, Brunei, Canada, Chile, China, Colombia, Cyprus, Macedonia, Poland, Portugal, South Korea, Thailand, Turkey, United States         |
|Phone Authentication Mid Low Cost  |Greenland, Albania, American Samoa, Austria, Bahamas, Bahrain, Bosnia & Herzegovina, Botswana, Costa Rica, Czech Republic, Denmark, Estonia, Faroe Islands, Finland, France, Greece, Hong Kong, Hungary, Iceland, Ireland, Italy, Japan, Latvia, Lithuania, Luxembourg, Macao, Malta, Mexico, Micronesia, Moldova, Namibia, New Zealand, Nicaragua, Norway, Romania, São Tomé and Príncipe, Seychelles Republic, Singapore, Slovakia, Solomon Islands, Spain, Sweden, Switzerland, Taiwan, United Kingdom, United States Virgin Islands, Uruguay         |
|Phone Authentication Mid High Cost |Andorra, Angola, Anguilla, Antarctica, Antigua and Barbuda, Argentina, Armenia, Aruba, Ascension, Barbados, Belgium, Benin, Bolivia, British Virgin Islands, Bulgaria, Burkina Faso, Cameroon, Cayman Islands, Central African Republic, Cook Islands, Croatia, Cuba, Diego Garcia, Djibouti, Dominican Republic, Dominican Republic, Dominican Republic, East Timor, Ecuador, El Salvador, Eritrea, Falkland Islands, Fiji, French Guiana, French Polynesia, Gambia, Georgia, Germany, Gibraltar, Grenada, Guadeloupe, Guam, Guinea, Guyana, Honduras, India, Ivory Coast, Kenya, Kiribati, Laos, Liberia, Malaysia, Marshall Islands, Martinique, Mauritius, Monaco, Montenegro, Montserrat, Netherlands, Netherlands Antilles, New Caledonia, Niue, North Korea, Oman, Palau, Panama, Paraguay, Peru, Puerto Rico, Puerto Rico, Réunion, Rwanda, Saint Helena, Saint Kitts & Nevis, Saint Lucia, Saint Pierre & Miquelon, Saint Vincent and the Grenadines, Saipan, Samoa, San Marino, Saudi Arabia, Sint Maarten, Slovenia, South Africa, South Sudan, Suriname, Swaziland (New Name is Kingdom of Eswatini), Tokelau, Tonga, Turks & Caicos, Tuvalu, United Arab Emirates, Vanuatu, Venezuela, Vietnam, Wallis and Futuna         |
|Phone Authentication High Cost     |Liechtenstein, Bermuda, Cambodia, Cape Verde, Democratic Republic of Congo, Dominica, Egypt, Equatorial Guinea, Ghana, Guatemala, Guinea-Bissau, Israel, Jamaica, Jamaica, Kosovo, Lesotho, Maldives, Mali, Mauritania, Morocco, Mozambique, Papua New Guinea, Philippines, Qatar, Sierra Leone, Trinidad & Tobago, Ukraine, Zimbabwe, Afghanistan, Algeria, Azerbaijan, Bangladesh, Belarus, Belize, Bhutan, Burundi, Chad, Comoros, Congo, Ethiopia, Gabonese Republic, Haiti, Indonesia, Iran, Iraq, Jordan, Kuwait, Kyrgyzstan, Lebanon, Libya, Madagascar, Malawi, Mongolia, Myanmar, Nauru, Nepal, Niger, Nigeria, Pakistan, Palestinian National Authority, Russia, Senegal, Serbia, Somalia, Sri Lanka, Sudan, Syria, Tajikistan, Tanzania, Togolese Republic, Tunisia, Turkmenistan, Uganda, Uzbekistan, Yemen, Zambia         |

## Next steps

[Add multifactor authentication (MFA) to an app](how-to-multifactor-authentication-customers.md)