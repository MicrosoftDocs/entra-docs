---
title: Define custom attributes
description: Learn how to create and define new custom attributes to be collected from users during sign-up and sign-in.
 
author: msmimart
manager: celestedg
ms.service: active-directory
 
ms.subservice: ciam
ms.topic: how-to
ms.date: 11/27/2023
ms.author: mimart
ms.custom: it-pro

---

# Collect user attributes during sign-up  

User attributes are values collected from a user during self-service sign-up. In the user flow settings, you can select from a set of built-in user attributes or define your own custom attributes. During sign-up, the user enters the information on the attribute collection page, and it's stored with their profile in your directory.

- **Built-in user attributes.** Microsoft Entra External ID comes with a set of built-in user attributes that you can choose to collect during sign-up:

  - City
  - Country/Region
  - Display Name
  - Email Address
  - Given Name
  - Job Title
  - Postal Code
  - State/Province
  - Street Address
  - Surname

- **Custom user attributes.** If you want to collect information beyond the built-in attributes, you can create *custom user attributes* and add them to your sign-up user flow. The following input types can be created:

  - String text box
  - Radio buttons
  - Multiselect checkboxes
  - Numeric text box
  - Single-select checkbox

The labels for checkboxes and radio buttons can include hyperlinks to other content. For example, if you want users to give consent to your terms and conditions, you can configure a required checkbox that includes links to your terms of use and privacy policies. The following example shows a sign-up page that combines built-in attributes and custom attributes:

   :::image type="content" source="media/how-to-define-custom-attributes/attribute-collection-page-types-reduced.png" border="false" alt-text="Screenshot of a sign-up page with terms of use and privacy policy checkboxes." lightbox="media/how-to-define-custom-attributes/attribute-collection-page-types.png":::

In this example:

- The **Display Name** field is a built-in attribute.
- The **Loyalty Number** is a custom attribute with a free-form entry field that accepts a numeric integer. You can configure this format using the **Int** data type and **NumericTextBox** user input type.
- The **terms of use** and **privacy policy** custom attributes are separate, single-select checkboxes with labels containing hyperlinks. You can configure a single checkbox using the **Boolean** data type, which defaults to the **CheckboxSingleSelect** user input type. Use Markdown language to add hyperlinks to the checkbox label.

Other input types are available, including multiselect checkboxes, radio buttons, and free-form text entry fields. Learn how to [create custom user attributes](#create-custom-user-attributes) in this article.

### Where custom user attributes are stored

Custom user attributes are also known as directory extension attributes because they extend the user profile information stored in your directory. All extension attributes for your customer tenant are stored in an app named *b2c-extensions-app*. After a user enters a value for the custom attribute during sign-up, it's added to the user object and can be called via the Microsoft Graph API using the naming convention `extension_<b2c-extensions-app-id>_attributename`.

If your application relies on certain built-in or custom user attributes, you can also [include these attributes in the token](how-to-add-attributes-to-token.md) that is sent to your application.

### Referencing custom user attributes

The custom user attributes you create are added to the *b2c-extensions-app* registered in your customer tenant. If you want to call a custom attribute from an application or manage it via Microsoft Graph, use the naming convention `extension_<b2c-extensions-app-id>_<custom-attribute-name>` where:

- `<b2c-extensions-app-id>` is the *b2c-extensions-app* application ID with no hyphens.
- `<custom-attribute-name>` is the name you assigned to the custom attribute.

To find the application ID for the *b2c-extensions-app* registered in your customer tenant:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com).
1. Browse to **Identity** > **App registrations** > **All applications**.
1. Select the application **b2c-extensions-app. Do not modify. Used by AADB2C for storing user data.**
1. On the **Overview** page, use the **Application (client) ID** value, for example: `12345678-abcd-1234-1234-ab123456789`, but remove the hyphens.

**Example**: If you created a custom attribute named **loyaltyNumber**, refer to it as follows:

`extension_12345678abcd12341234ab123456789_loyaltyNumber`

## Create custom user attributes

Before you begin, determine which types of user input controls would work best for gathering the attributes you want to collect. Use the following table to find the appropriate values for data type and user input type based on the input controls you need.

### Custom user attribute data and input types

|Data type  |User input type     |Description  |
|-----------|--------------------|-------------|
|String     |TextBox             |Free-form text entry field.         |
|String     |RadioSingleSelect   |Series of radio buttons with only one selection allowed. Radio button text supports Markdown language for hyperlinks to other content.           |
|String     |CheckboxMultiSelect |Series of one or more checkboxes with multiple selections allowed. Checkbox text supports Markdown language for hyperlinks to other content.        |
|Boolean    |CheckboxSingleSelect|Single boolean checkbox with label. Label text supports Markdown language for hyperlinks to other content (for example, Terms of Use, Privacy Policy).      |
|Int        |NumericTextBox      |Free-form integer entry.         |

To define a custom user attribute, you first create the attribute at the tenant level so it can be used in any user flow in the tenant. Then you assign the attribute to your sign-up user flow and configure how you want it to appear on the sign-up page.

### To create a custom user attribute

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com).

1. If you have access to multiple tenants, use the **Settings** icon :::image type="icon" source="media/common/admin-center-settings-icon.png" border="false"::: in the top menu to switch to your customer tenant from the **Directories + subscriptions** menu.

1. Browse to **Identity** > **External Identities** > **Overview**.

1. Select **Custom user attributes**. The list contains all user attributes available in the tenant, including any custom user attributes that have been created. The **Attribute type** column indicates whether an attribute is built-in or custom.

1. Select **Add**. In the **Add an attribute** pane, enter a **Name** for the custom attribute (for example, "Terms and conditions").

1. In **Data Type**, choose **String**, **Boolean**, or **Int** depending on the [type of data and user input control](#custom-user-attribute-data-and-input-types) you want to create. **String** attributes have a default user input type value of **TextBox**, but you'll be able to change this in a later step (for example if you want to configure radio buttons or checkboxes).

1. (Optional) In **Description**, enter a description of the custom attribute for internal use. This description isn't visible to the user.

   :::image type="content" source="media/how-to-define-custom-attributes/add-attribute.png" alt-text="Screenshot of the pane for adding an attribute." lightbox="media/how-to-define-custom-attributes/add-attribute.png":::

1. Select **Create**. The custom attribute is now available in the list of user attributes and can be [added to your user flows](#include-the-custom-user-attribute-in-a-sign-up-flow).

## Include the custom user attribute in a sign-up flow

Follow these steps to add custom user attributes to a user flow you've already created. (For a new user flow, see [Create a sign-up and sign-in user flow for customers](how-to-user-flow-sign-up-sign-in-customers.md).)

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com).

1. If you have access to multiple tenants, use the **Settings** icon :::image type="icon" source="media/common/admin-center-settings-icon.png" border="false"::: in the top menu to switch to your customer tenant from the **Directories + subscriptions** menu.

1. Browse to **Identity** > **External Identities** > **User flows**.

1. Select the user flow from the list.

1. Select **User attributes**. The list includes any custom user attributes you defined as described in the previous section. For example, the new **Terms and conditions** attribute now appears in the list. Choose all the attributes you want to collect from the user during sign-up.

   :::image type="content" source="media/how-to-define-custom-attributes/user-attributes.png" alt-text="Screenshot of the user attribute options on the Create a user flow page." lightbox="media/how-to-define-custom-attributes/user-attributes.png":::

1. Select **Save**.

## Configure the user input types and page layout
  
On the **Page layout** page, you can indicate which attributes are required and arrange the display order. You can also edit attribute labels, create radio buttons or checkboxes, and add hyperlinks to more content (such as terms of use or a privacy policy).

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com).

1. Browse to **Identity** > **External Identities** > **User flows**.

1. From the list, select your user flow.

1. Under **Customize**, select **Page layouts**. The attributes you chose to collect appear.

1. Edit the label for any attribute by selecting the value in the **Label** column and modifying the text.

1. Configure checkboxes or radio buttons:

   - **Single-select checkbox**: A Boolean attribute type renders as a single-select checkbox on the sign-up page. To configure the text that displays next to the checkbox, select and edit the value in the **Label** column. Use Markdown language to add hyperlinks. For details, see [To configure a single-select checkbox (CheckboxSingleSelect)](#to-configure-a-single-select-checkbox-checkboxsingleselect)
   - **Multiselect checkboxes**: Find the **String** data type attribute you want to configure, and select the value in the **User Input Type** column. In the editor pane, choose the appropriate user input type and enter the values. For details, see [To configure multiple checkboxes (CheckboxMultiSelect)](#to-configure-multiple-checkboxes-checkboxmultiselect).
   - **Radio buttons**: Find the **String** data type attribute you want to configure, and select the value in the **User Input Type** column. In the editor pane, choose the appropriate user input type and enter the values. For details, see [To configure radio buttons (RadioSingleSelect)](#to-configure-radio-buttons-radiosingleselect)

1. Change the order of display by selecting an attribute and choosing **Move up**, **Move down**, **Move to the top**, or **Move to the bottom**.

1. Make an attribute required by selecting the checkbox in the **Required** column. All attributes can be marked as required. For a multiselect checkbox, "Required" means that a minimum of one checkbox in the attribute is required to be selected.

1. When all your changes are complete, select **Save**.

### To configure a single-select checkbox (CheckboxSingleSelect)

An attribute with a Boolean data type has a user input type of CheckboxSingleSelect. You can modify the text that displays next to the checkbox and include hyperlinks.

1. On the **Page layouts** page, find the attribute with data type of **String** that you want to configure as a series of checkboxes.

1. Select the value in the **Label** column and enter the text you want to display next to the checkbox. Use Markdown language to add hyperlinks. For example, if you want to combine your terms of use and privacy policy into a single required checkbox, you can enter:

   `I have read and agree to the [terms of use](https://woodgrove.com/terms-of-use) and the [privacy policy](https://woodgrove.com/privacy)`.

1. Select **Ok**.

   :::image type="content" source="media/how-to-define-custom-attributes/page-layout-single-checkbox.png" alt-text="Screenshot of adding a checkbox to a string attribute in the page layout options." lightbox="media/how-to-define-custom-attributes/page-layout-single-checkbox.png":::

1. On the **Page layouts** page, select **Save**.


### To configure multiselect checkboxes (CheckboxMultiSelect)

An attribute with a String data type can be configured as a CheckboxMultiSelect user input type, which is a series of one or more checkboxes that appear under the attribute label. The user can select one or more checkboxes. You can define the text for individual checkboxes and include hyperlinks to other content.

1. On the **Page layouts** page, find the attribute with data type of **String** that you want to configure as a series of checkboxes.

1. Select the value in the **Label** column and enter the heading you want to display above the series of checkboxes, for example `Terms and conditions`.

1. Select the value in the **User Input Type** column to open the editor pane.

1. Under **User input type**, select **CheckboxMultiSelect**.

1. For each checkbox you want to add, create a new line and enter the following information:

   - Under **Text**, enter the text you want to display next to the checkbox. Use Markdown language to add hyperlinks.

   - Under **Values**, enter a value to be written on the user object and returned as the claim if the user selects the checkbox.

1. Select **Ok**.

   :::image type="content" source="media/how-to-define-custom-attributes/page-layout-multicheckbox.png" alt-text="Screenshot of adding a checkbox to a string attribute in the page layout options." lightbox="media/how-to-define-custom-attributes/page-layout-multicheckbox.png":::

1. On the **Page layouts** page, select **Save**.

### To configure radio buttons (RadioSingleSelect)

An attribute with a String data type can be configured as a RadioSingleSelect user input type, which is a series of radio buttons that appear under the attribute label. The user can select only one radio button. You can define the text for individual radio buttons and include hyperlinks to other content.

1. On the **Page layouts** page, find the attribute with data type of **String** that you want to configure as a radio button or series of radio buttons.

1. Select the value in the **Label** column and enter the heading you want to display above the series of radio buttons, for example `Sweatshirt size`.

1. Select the value in the **User Input Type** column.

1. In the editor pane, under **User input type**, select **RadioSingleSelect**.

1. For each radio button you want to add, create a new line and enter the following information:

   - Under **Text**, enter the text you want to display next to the radio button. Use Markdown language to add hyperlinks.

   - Under **Values**, enter a value to be written on the user object and returned as the claim if the user selects the radio button.

1. Select **Ok**.

   :::image type="content" source="media/how-to-define-custom-attributes/page-layout-radio-button.png" alt-text="Screenshot of adding a radio button to a string attribute in the page layout options." lightbox="media/how-to-define-custom-attributes/page-layout-radio-button.png":::

1. On the **Page layouts** page, select **Save**.

## Next steps

[Add attributes to the ID token returned to your application](how-to-add-attributes-to-token.md)

[Learn more about creating a sign-up and sign-in user flow for customers](how-to-user-flow-sign-up-sign-in-customers.md)
