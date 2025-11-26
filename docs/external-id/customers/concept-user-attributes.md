---
title: User profile attributes
description: User profile attributes that you can collect from the user during sign-up, and how to extend user profile attributes by using custom user attributes.
author: kengaderdus
ms.author: kengaderdus
manager: dougeby
ms.service: entra-external-id
ms.subservice: external
ms.topic: concept-article
ms.date: 04/28/2025
ms.custom: it-pro, sfi-image-nochange
#Customer intent: As a developer, devops, IT admin, I want to learn about the built-in user profile attributes that I can collect from the user during sign-up, and how Microsoft Entra External ID extends user profile attributes by using custom user attributes. 
---

# User profile attributes

[!INCLUDE [applies-to-external-only](../includes/applies-to-external-only.md)]

The user attributes you collect during sign-up are stored with the user's profile in your directory. You can choose from built-in user attributes or create custom user attributes.

- [Built-in user attributes](#built-in-user-attributes), such as city, country/region, email address, and so on, are available in Microsoft Entra External ID. You can choose the built-in user attributes you want to collect during sign-up.
- For any additional information you want to collect, you can create [custom user attributes](#custom-user-attributes). Several custom input controls can be added to the sign-up page to collect the attributes, including text boxes, radio buttons, and check boxes. The following example shows how custom input controls can be used to collect attributes for loyalty number, terms of use consent for terms of use, and privacy policy consent.
   
   :::image type="content" source="media/concept-user-attributes/attribute-collection-page-types-reduced.png" border="false" alt-text="Screenshot of a sign-up page with terms of use and privacy policy checkboxes." lightbox="media/concept-user-attributes/attribute-collection-page-types.png":::

## Built-in user attributes

Microsoft Entra External ID has built-in user attributes you can collect during sign-up. You configure these attributes when you [create user flows in the Microsoft Entra admin center](how-to-user-flow-sign-up-sign-in-customers.md).

This table summarizes the built-in user attributes you can collect during the sign-up flow:
 
<!---kengaderdus added this section to be used by devs who reference user profile attributes programmatically such those who use native authentication API-->

- *Label in Microsoft Entra admin center* is the name of the user attribute as it appears in the Microsoft Entra admin center. 
- *Programmable name* is the name of the user attribute as used in the [user resource](/graph/api/resources/user/#properties) of the Microsoft Graph API. You use this name when you want to use this user attribute programmatically, such as in [native authentication](../../identity-platform/reference-native-authentication-overview.md?bc=/entra/external-id/customers/breadcrumb/toc.json&toc=/entra/external-id/customers/toc.json).
- *Data type* is the user attribute's data type.

|  Label in Microsoft Entra admin center| Programmable name |     Data type   |  Remarks    |
|-----------------------|-------------------------|------------------------|------------------------|
|City|city|String|Maximum length is 128 characters.|
|Country/Region|country|String|Maximum length is 128 characters.|
|Display Name|displayName|String|Maximum length is 256 characters.|
|Email Address| email| String | This property can't contain accent characters. In the [native authentication API](../../identity-platform/reference-native-authentication-overview.md?bc=/entra/external-id/customers/breadcrumb/toc.json&toc=/entra/external-id/customers/toc.json), this attribute is referenced as *username*.|
|Given Name|givenName|String|Maximum length is 64 characters.|
|Job Title|jobTitle|String|Maximum length is 128 characters.|
|Postal Code|postalCode	|String|Maximum length is 40 characters.|
|State/Province|state|String|Maximum length is 128 characters.|
|Street Address|streetAddress|String|Maximum length is 1024 characters.|
|Surname|surname|String|Maximum length is 64 characters.|

## Custom user attributes

If your app requires more information than the built-in user attributes provide, you can add your own attributes. We refer to these attributes as *custom user attributes*.

To define a custom user attribute, you first create the attribute at the tenant level so it can be used in any user flow in the tenant. Then you assign the attribute to your sign-up user flow and configure how you want it to appear on the sign-up page.

Learn how to create custom user attributes [Create custom user attributes](how-to-define-custom-attributes.md#create-custom-user-attributes) article.

### Custom user attributes input types

Before you use custom user attributes, determine the best way to gather user input for each custom attribute you want to collect. You can collect information from your users during sign-up by using the following input type controls:

  - String text box
  - Radio buttons
  - Multiselect checkboxes
  - Numeric text box
  - Single-select checkbox
  
Refer to this table to find the appropriate data types and user input types:

|Data type  |User input type     |Description  |
|-----------|--------------------|-------------|
|String     |TextBox             |Free-form text entry field.         |
|String     |RadioSingleSelect   |Series of radio buttons with only one selection allowed. The **Text** for individual radio buttons can include hyperlinks formatted in Markdown language.          |
|String     |CheckboxMultiSelect |Series of one or more checkboxes with multiple selections allowed. The **Text** for individual checkboxes can include hyperlinks formatted in Markdown language.        |
|Boolean    |CheckboxSingleSelect|Single boolean checkbox with a label. The **Label** for the checkbox can include hyperlinks formatted in Markdown language.      |
|Int        |NumericTextBox      |Free-form integer entry.         |

Checkboxes and radio buttons can include hyperlinks to other content, such as terms of use and privacy policies. The example at the beginning of this article shows a sign-up page that combines built-in attributes and custom attributes. In the example:

- The **Display Name** field is a built-in attribute.
- The **Loyalty Number** is a custom attribute with a free-form entry field that accepts a numeric integer. You can configure this format using the **Int** data type and **NumericTextBox** user input type.
- The **terms of use** and **privacy policy** custom attributes are separate, single-select checkboxes with labels containing hyperlinks. You can configure a single checkbox using the **Boolean** data type, which defaults to the **CheckboxSingleSelect** user input type. Use Markdown language to add hyperlinks to the checkbox label.

Learn how to configure their user attributes input types in [Configure the user input types](how-to-define-custom-attributes.md#configure-the-user-input-types-and-page-layout) article.

### Where custom user attributes are stored

Custom user attributes are also known as directory extension attributes because they extend the user profile information stored in your directory. All extension attributes for your external tenant are stored in an app named *b2c-extensions-app*. After a user enters a value for the custom attribute during sign-up, it's added to the user object and can be called via the Microsoft Graph API using the naming convention `extension_{appId-without-hyphens}_{custom-attribute-name}` where:

 - `{appId-without-hyphens}` is the stripped version of the client ID for the *b2c-extensions-app*. 
 - `{custom-attribute-name}` is the name you assigned to the custom attribute.

For example, if the client ID of the *b2c-extensions-app* is `2588a-bcdwh-tfeehj-jeeqw-ertc` and the attribute name is:
- *loyaltyNumber*, then the custom attribute is named as`extension_2588abcdwhtfeehjjeeqwertc_loyaltyNumber`.
- *Loyalty Number* then the custom attribute is named as`extension_2588abcdwhtfeehjjeeqwertc_loyaltyNumber`. You remove the space and use camel case to separate the words.

Use the [Find the application ID for the extensions app](how-to-define-custom-attributes.md) article to learn how to find the application ID for the *b2c-extensions-app* registered in your external tenant.

## Microsoft Graph APIs

User attributes are referred to as *user flow attributes* in Microsoft Graph. Use the [identityUserFlowAttribute resource type](/graph/api/resources/identityuserflowattribute) and its associated methods to manage both built-in and custom user flow attributes.

## Related content

- [Add attributes to the ID token returned to your application](how-to-add-attributes-to-token.md).

- [Learn more about creating a sign-up and sign-in user flow for customers](how-to-user-flow-sign-up-sign-in-customers.md).

- [Native authentication MSAL Android SDK attribute builder](concept-native-authentication-user-attribute-builder.md).
