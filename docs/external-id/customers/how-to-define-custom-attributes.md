---
title: Define custom attributes
description: Learn how to create and define new custom attributes to be collected from users during sign-up and sign-in.
 
author: msmimart
manager: celestedg
ms.service: entra-external-id
 
ms.subservice: customers
ms.topic: how-to
ms.date: 01/23/2024
ms.author: mimart
ms.custom: it-pro

---

# Collect user attributes during sign-up  



## Find the application ID for the extensions app

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com).
1. Browse to **Identity** > **App registrations** > **All applications**.
1. Select the application **b2c-extensions-app. Do not modify. Used by AADB2C for storing user data.**
1. On the **Overview** page, use the **Application (client) ID** value, for example: `12345678-abcd-1234-1234-ab123456789`, but remove the hyphens.

**Example**: If you created a custom attribute named **loyaltyNumber**, refer to it as follows:

`extension_12345678abcd12341234ab123456789_loyaltyNumber`



### To create a custom user attribute

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com).

1. If you have access to multiple tenants, use the **Settings** icon :::image type="icon" source="media/common/admin-center-settings-icon.png" border="false"::: in the top menu to switch to your customer tenant from the **Directories + subscriptions** menu.

1. Browse to **Identity** > **External Identities** > **Overview**.

1. Select **Custom user attributes**. The list contains all user attributes available in the tenant, including any custom user attributes that have been created. The **Attribute type** column indicates whether an attribute is built-in or custom.

1. Select **Add**. In the **Add an attribute** pane, enter a **Name** for the custom attribute (for example, "Terms of use").

1. In **Data Type**, choose **String**, **Boolean**, or **Int** depending on the [type of data and user input control](#custom-user-attribute-data-and-input-types) you want to create. **String** attributes have a default user input type value of **TextBox**, but you'll be able to change this in a later step (for example if you want to configure radio buttons or multiselect checkboxes).

1. (Optional) In **Description**, enter a description of the custom attribute for internal use. This description isn't visible to the user.

   :::image type="content" source="media/how-to-define-custom-attributes/add-attribute.png" alt-text="Screenshot of the pane for adding an attribute." lightbox="media/how-to-define-custom-attributes/add-attribute.png":::

1. Select **Create**. The custom attribute is now available in the list of user attributes and can be [added to your user flows](#include-the-custom-user-attribute-in-a-sign-up-flow).

## Include the custom user attribute in a sign-up flow

Follow these steps to add custom user attributes to a user flow you've already created. (If you need to create a new user flow, see [Create a sign-up and sign-in user flow for customers](how-to-user-flow-sign-up-sign-in-customers.md).)

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com).

1. If you have access to multiple tenants, use the **Settings** icon :::image type="icon" source="media/common/admin-center-settings-icon.png" border="false"::: in the top menu to switch to your customer tenant from the **Directories + subscriptions** menu.

1. Browse to **Identity** > **External Identities** > **User flows**.

1. Select the user flow from the list.

1. Select **User attributes**. The list includes any custom user attributes you defined as described in the previous section. For example, the new **Terms of use** attribute now appears in the list. Choose all the attributes you want to collect from the user during sign-up.

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
   - **Multiselect checkboxes**: Find the **String** data type attribute you want to configure, and select the value in the **User Input Type** column to open the editor pane. Choose the **CheckboxMultiSelect** user input type and enter the values. For details, see [To configure multiselect checkboxes (CheckboxMultiSelect)](#to-configure-multiselect-checkboxes-checkboxmultiselect).
   - **Radio buttons**: Find the **String** data type attribute you want to configure, and select the value in the **User Input Type** column to open the editor pane. Choose the **RadioSingleSelect** user input type and enter the values. For details, see [To configure radio buttons (RadioSingleSelect)](#to-configure-radio-buttons-radiosingleselect)

1. Change the order of display by selecting an attribute and choosing **Move up**, **Move down**, **Move to top**, or **Move to bottom**.

1. Make an attribute required by selecting the checkbox in the **Required** column. All attributes can be marked as required. For multiselect checkboxes, "Required" means that the user must select at least one checkbox.

1. When all your changes are complete, select **Save**.

### To configure a single-select checkbox (CheckboxSingleSelect)

An attribute with a Boolean data type has a user input type of CheckboxSingleSelect. You can modify the text that displays next to the checkbox and include hyperlinks.

> [!TIP]
> [![Try it now](./media/common/try-it-now.png)](https://woodgrovedemo.com/#usecase=PolicyAgreement)
> 
> To try out this feature, go to the Woodgrove Groceries demo and start the “Add links to terms of use and privacy policies” use case.

To configure a single-select checkbox, follow these steps:

1. On the **Page layouts** page, find the attribute with data type of **Boolean** that you want to configure.

1. Select the value in the **Label** column and enter the text you want to display next to the checkbox. Use Markdown language to add hyperlinks. For example:

   - To configure the label for a **Terms of use** attribute, you could enter:

      `I have read and agree to the [terms of use](https://woodgrove.com/terms-of-use)`.

   - Or, you could combine your terms of use and privacy policy into a single required checkbox:

      `I have read and agree to the [terms of use](https://woodgrove.com/terms-of-use) and the [privacy policy](https://woodgrove.com/privacy)`.

1. Select **Ok**.

   :::image type="content" source="media/how-to-define-custom-attributes/page-layout-single-checkbox.png" alt-text="Screenshot of updating the checkbox label in the page layout options." lightbox="media/how-to-define-custom-attributes/page-layout-single-checkbox.png":::

1. On the **Page layouts** page, select **Save**.


### To configure multiselect checkboxes (CheckboxMultiSelect)

An attribute with a String data type can be configured as a CheckboxMultiSelect user input type, which is a series of one or more checkboxes that appear under the attribute label. The user can select one or more checkboxes. You can define the text for individual checkboxes and include hyperlinks to other content. Making this attribute "Required" means that the user must select at least one of the checkboxes.

1. On the **Page layouts** page, find the attribute with data type of **String** that you want to configure as a series of checkboxes.

1. Select the value in the **Label** column and enter the heading you want to display above the series of checkboxes, for example `How did you hear about us?`.

1. Select the value in the **User Input Type** column to open the editor pane.

1. In the editor pane, under **User input type**, select **CheckboxMultiSelect**.

1. For each checkbox you want to add, start on a new line and enter the following information:

   - Under **Text**, enter the text you want to display next to the checkbox. Use Markdown language to add hyperlinks.

   - Under **Values**, enter a value to be written on the user object and returned as the claim if the user selects the checkbox.

1. Select **Ok**.

   :::image type="content" source="media/how-to-define-custom-attributes/page-layout-multicheckbox.png" alt-text="Screenshot of adding a multiselect checkbox to a string attribute in the page layout options." lightbox="media/how-to-define-custom-attributes/page-layout-multicheckbox.png":::

1. On the **Page layouts** page, select **Save**.

### To configure radio buttons (RadioSingleSelect)

An attribute with a String data type can be configured as a RadioSingleSelect user input type, which is a series of radio buttons that appear under the attribute label. The user can select only one radio button. You can define the text for individual radio buttons and include hyperlinks to other content.

1. On the **Page layouts** page, find the attribute with data type of **String** that you want to configure as a radio button or series of radio buttons.

1. Select the value in the **Label** column and enter the heading you want to display above the series of radio buttons, for example `Sweatshirt size`.

1. Select the value in the **User Input Type** column to open the editor pane.

1. In the editor pane, under **User input type**, select **RadioSingleSelect**.

1. For each radio button you want to add, start on a new line and enter the following information:

   - Under **Text**, enter the text you want to display next to the radio button. Use Markdown language to add hyperlinks.

   - Under **Values**, enter a value to be written on the user object and returned as the claim if the user selects the radio button.

1. Select **Ok**.

   :::image type="content" source="media/how-to-define-custom-attributes/page-layout-radio-button.png" alt-text="Screenshot of adding a radio button to a string attribute in the page layout options." lightbox="media/how-to-define-custom-attributes/page-layout-radio-button.png":::

1. On the **Page layouts** page, select **Save**.

## Next steps

[Add attributes to the ID token returned to your application](how-to-add-attributes-to-token.md)

[Learn more about creating a sign-up and sign-in user flow for customers](how-to-user-flow-sign-up-sign-in-customers.md)
