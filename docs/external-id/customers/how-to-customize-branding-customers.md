---
title: Customize Hosted Page Branding
description: Customize Microsoft-hosted authentication pages in Microsoft Entra External ID with company logos, background images, colors, and sign-in text.
ms.topic: how-to
ms.date: 11/13/2026
ms.custom: it-pro, sfi-image-nochange, msecd-doc-authoring-1030
ai-usage: ai-assisted
#customer intent: As an IT administrator, I want to customize Microsoft-hosted authentication pages so that my customers see consistent company branding.
---

# Customize Microsoft Entra External ID hosted page branding

After creating an external tenant, configure **Company branding** to customize its Microsoft-hosted authentication pages. Add background images, colors, company logos, and text to create a consistent sign-in experience across your apps.
You can also manage company branding programmatically with Microsoft Graph. Before you begin, ensure you have an external tenant, a registered application, and a user flow, as described in [Prerequisites](#prerequisites).

[!INCLUDE [authentication-approaches](../includes/applies-to-authentication-approaches.md)]

## Prerequisites

- If you haven't already created your own Microsoft Entra external tenant, create one now.
- [Register an application](/entra/identity-platform/quickstart-register-app).  
- [Create a user flow](how-to-user-flow-sign-up-sign-in-customers.md).
- Review the file size requirements for each image you want to add. You might need a photo editor to resize images. PNG is preferred, but JPG is accepted.

<a name='comparing-the-default-sign-in-experiences-between-the-external-tenant-and-the-azure-ad-tenant'></a>

## Review preview customization options

For guidance on the modern Fluent experience, Basic and Advanced styling, and custom HTML, see the [modern UX and customization overview](../customization-overview.md). Those preview capabilities use application branding themes, not the default-branding procedure below.

These capabilities are scheduled to become available in preview on December 7, 2026, for external tenants with the preview enabled. Continue using the default-branding instructions below to customize that experience.

## Branding elements

Your tenant starts with neutral branding that doesn't include preexisting Microsoft branding. Customize individual branding properties to suit your company. If custom company branding fails to load, the sign-in page reverts to neutral branding.

You can customize this neutral branding with a custom background image or color, favicon, layout, header, and footer. You can also customize the sign-in form and add custom text to different instances or upload [custom CSS](~/fundamentals/reference-company-branding-css-template.md). 
The following image displays the neutral default branding of the tenant. You can find the numbered branding elements and their corresponding descriptions after the image.

   :::image type="content" source="media/how-to-customize-branding-customers/ciam-neutral-branding.png" alt-text="Screenshot of a neutral sign-in page with numbered branding elements." lightbox="media/how-to-customize-branding-customers/ciam-neutral-branding.png":::

1. Neutral background.
1. Favicon.
1. Banner logo.
1. Footer as a page layout element.
1. Footer hyperlinks, such as **Privacy & cookies** and **Terms of use**.

## How to customize the default sign-in experience

To customize the default sign-in, sign-up, and sign-out pages, edit the company branding settings. You can also upload [custom CSS](~/fundamentals/reference-company-branding-css-template.md).

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Organizational Branding Administrator](~/identity/role-based-access-control/permissions-reference.md#organizational-branding-administrator).
1. If you have access to multiple tenants, use the **Settings** icon :::image type="icon" source="media/common/admin-center-settings-icon.png" border="false"::: in the top menu to switch to the external tenant you created earlier from the **Directories + subscriptions** menu.
1. Browse to **Company branding** either by using the search bar or by navigating to **Entra ID** > **Custom Branding**.
1. On the **Default sign-in** tab, select **Edit**.

   :::image type="content" source="media/how-to-customize-branding-customers/company-branding-default-edit-button.png" alt-text="Screenshot of the company branding edit button.":::

### To customize the sign-in page background and layout

Configure the background and layout to control how Microsoft-hosted pages display your branding:

1. On the **Basics** tab, modify any of the background elements.

    - **Favicon** – The icon that displays in the web browser tab.

    - **Background image** – The large image that displays on the sign-in page. If you upload an image, it scales and crops to fill the browser window.

    - **Page background color** – The color that replaces the background image whenever the image can’t be loaded, for example due to connection latency.

   :::image type="content" source="media/how-to-customize-branding-customers/company-branding-basics-tab.png" alt-text="Screenshot of the company branding basics tab." lightbox="media/how-to-customize-branding-customers/company-branding-basics-tab.png":::

1. Select **Next: Layout** to continue customizing or **Review + save** to save your changes.

1. On the **Layout** tab, select the placement of web page elements on the sign-in page.

    - **Template** – Choose whether the background displays full-screen or partial-screen.

    - **Header** – Show or hide the header.

    - **Footer** – Show or hide the footer.

    - **Custom CSS** – Upload a CSS file to customize colors, fonts, text size, element positions, and display across devices and screen sizes.

   :::image type="content" source="media/how-to-customize-branding-customers/company-branding-layout-tab.png" alt-text="Screenshot of the company branding layout tab." lightbox="media/how-to-customize-branding-customers/company-branding-layout-tab.png":::

1. Select **Next: Header** to continue customizing or **Review + save** to save your changes.

### To customize the logo, privacy link, and terms of use

Configure the header and footer to display your logo and policy links:

1. On the **Header** tab, select the logo to display in the header of the sign-in page. 

   :::image type="content" source="media/how-to-customize-branding-customers/company-branding-header-tab.png" alt-text="Screenshot of the company branding header tab.":::

1. Select **Next: Footer** to continue customizing or **Review + save** to save your changes.

1. On the **Footer** tab, you can customize the URLs and link text for the privacy and terms of use hyperlinks that appear in the footer of the sign-in page.  

    - **Privacy & Cookies** – Select the checkbox next to Privacy & Cookies to display this hyperlink in the footer. The Microsoft default privacy link displays unless you enter your own hyperlink Display text and URL.

    - **Terms of Use** – Select the checkbox next to Terms of Use to display this hyperlink in the footer. The Microsoft terms of use link displays unless you enter your own hyperlink Display text and URL.

   :::image type="content" source="media/how-to-customize-branding-customers/company-branding-footer-tab.png" alt-text="Screenshot of the company branding footer tab." lightbox="media/how-to-customize-branding-customers/company-branding-footer-tab.png":::

1. Select **Next: Sign-in form** to continue customizing or **Review + save** to save your changes.

### To customize the sign-in form

Configure logos, hint text, and page text for the sign-in form:

1. On the **Sign-in form** tab, configure elements of the sign-in form: 

    - **Banner logo** – Displays on the sign-in page and in the user’s access panel.

    - **Square logo (light theme)** – Represents user accounts in your organization.

    - **Square logo (dark theme)** – Upload an alternative to the light theme square logo for use on dark backgrounds.

   :::image type="content" source="media/how-to-customize-branding-customers/company-branding-sign-in-form-tab.png" alt-text="Screenshot of the company branding sign-in form tab." lightbox="media/how-to-customize-branding-customers/company-branding-sign-in-form-tab.png":::

1. Scroll to the lower half of the page and configure more elements of the sign-in form:

    - **Username hint text** – The hint text that displays in the username input field on the sign-in page (not recommended if guest users sign in to your app).

    - **Sign-in page text** – Appears at the bottom of the sign-in and sign-up pages. Guidelines:

        - Use a maximum of 1,024 characters.
        - Don't include sensitive information.
        - Use this syntax to format text:
            - Hyperlink: `[text](link)`
            - Bold: `**text** or __text__`
            - Italics: `*text* or _text_`
            - Underline: `++text++`

### To customize self-service password reset

Configure the password reset link on Microsoft-hosted sign-in pages:

1. Scroll to the **Self-service password reset** section to configure options for showing, hiding, or customizing the self-service password reset link on the sign-in page.

    - **Show self-service password reset** – Select this checkbox to display the self-service password link.
    - **Common URL** – Enter a password reset URL to use in place of the default Microsoft link.
    - **Account collection display text** – Enter link text to replace the Microsoft default "Can’t access your account" text.
    - **Password collection display text** – Enter link text to replace the Microsoft default "Forgot password" text.
 
      :::image type="content" source="media/how-to-customize-branding-customers/company-branding-self-service-password-reset.png" alt-text="Screenshot of the company branding Self-service password reset. " lightbox="media/how-to-customize-branding-customers/company-branding-self-service-password-reset.png":::

1. Select **Next: Text** to continue customizing or **Review + save** to save your changes.

### To customize user attributes

Customize labels for attributes such as Given Name, Surname, City, and Postal Code, and other sign-up and sign-in text. Use Microsoft Graph or the **Text** tab in **Company Branding** to customize this text:

1. On the **Text** tab, select **Add Custom Text**.
1. Select any of the options:

    - Select **Attributes** to override the default values.
    - Select **Attribute collection** to add a new attribute option to collect during sign-up.
    - Select **Sign in** to add custom text for the sign-in page.
    - Select **Sign up** to add custom text for the sign-up page.
    - Select **Sign-in/up one time code (SISU OTC)** to add a custom title.

      :::image type="content" source="media/how-to-customize-branding-customers/custom-text.png" alt-text="Screenshot of the company branding text tab." lightbox="media/how-to-customize-branding-customers/custom-text.png":::
 
1. Select **Next: Review** to review all your modifications. Then select **Save** if you'd like to save your changes or **Previous** if you want to continue customizing.

> [!IMPORTANT] 
> Customize sign-up and sign-in strings through language customization in **User flows** or through **Company branding**. Both options modify the same JSON file, so the most recent change overrides the previous one.

## Customize the sign-out experience

The sign-out experience automatically matches your sign-in branding. If you haven't customized sign-in branding, sign-out pages use the tenant's default neutral branding.

## How to customize the tenant name

You can customize your tenant name in the Microsoft Entra admin center to replace the Microsoft banner logo in the neutral default sign-in experience. The new tenant name also appears in the verification email sent to the user.

:::image type="content" source="media/how-to-customize-branding-customers/tenant-name.png" alt-text="Screenshot of the tenant name." lightbox="media/how-to-customize-branding-customers/tenant-name.png":::

To change the tenant name, follow these steps:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com/) as at least an [Organizational Branding Administrator](~/identity/role-based-access-control/permissions-reference.md#organizational-branding-administrator).
1. If you have access to multiple tenants, use the **Settings** icon :::image type="icon" source="media/common/admin-center-settings-icon.png" border="false"::: in the top menu to switch to the external tenant you created earlier from the **Directories + subscriptions** menu.
1. In the search bar, type and select **Tenant properties**.
1. Edit the **Name** field. 

   :::image type="content" source="media/how-to-customize-branding-customers/tenant-name-edit.png" alt-text="Screenshot of editing the tenant name.":::

1. Select **Save**.

## Customize your branding with the Microsoft Graph API

You can use the Microsoft Graph API to customize a few items programmatically. For example, you can use the API to upload a custom background image, change the color of the sign-in page, and add a custom logo. For more information, see the [update default branding](/graph/api/organizationalbranding-update) article. 

## Related content

- To learn more about customizing the language of the tenant, see [Language customization](how-to-customize-languages-customers.md).
- For an understanding of the differences in workforce tenant branding, see the [How to customize branding for your workforce](~/fundamentals/how-to-customize-branding.md).
- For information about how to create unique authentication experiences for applications in your tenant, see [Customize the sign-in experience for your application with branding themes](~/fundamentals/how-to-customize-branding-themes-apps.md).
