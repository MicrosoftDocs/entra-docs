---
title: Customize the sign-in experience for your application with branding themes (Preview)
description: Learn about how to create branding themes and apply them to the sign-in experience for your application.
author: rolyon
manager: pmwongera
ms.author: rolyon
ms.date: 09/30/2025
ms.reviewer: 
ms.service: identity-platform
ms.topic: how-to
#Customer intent: As a developer integrating with Microsoft Entra ID, I want to customize the sign-in experience for my application.

---

# Customize the sign-in experience for your application with branding themes (Preview)

> [!IMPORTANT]
> Branding themes for applications are currently in PREVIEW.
> This information relates to a prerelease product that may be substantially modified before it's released. Microsoft makes no warranties, expressed or implied, with respect to the information provided here.

Previously, you could only use a single branding theme for your entire tenant when users sign in to your applications. Now you can create unique authentication experiences for applications in your tenant. Each application can have its own theme, which you can customize with a background image or color, favicon, layout, header, and footer. This customization overrides any configurations made to the default branding. If you don't make any changes to the elements, the default elements are displayed.

This article describes how you can create multiple branding themes for different applications in your tenant.

## Prerequisites

- A Microsoft Entra [workforce](../../fundamentals/create-new-tenant.md) or [external](quickstart-tenant-setup.md) tenant.
- Have at least the [Organizational Branding Administrator](../../identity/role-based-access-control/permissions-reference.md#organizational-branding-administrator) role.
- Have at least the [Application Administrator](../../identity/role-based-access-control/permissions-reference.md#application-administrator) role for applications that you want to apply a theme to.
- A registered application in your tenant. If you haven't registered an application yet, see [Register an application](../../identity-platform/quickstart-register-app.md).
- Review the file size requirements for each image you want to add. Use a photo editor if needed to create correctly sized and formatted images: PNG, JPG, or JPEG with image size 245x36px and maximum file size 10KB.

## Branding theme properties

When you create a branding theme, here are some of the properties you can customize.

:::image type="content" source="./media/how-to-customize-branding-themes-apps/sign-in-page-map-expanded.png" alt-text="Screenshot of the sign-in page, with each of the company branding elements highlighted." lightbox="./media/how-to-customize-branding-themes-apps/sign-in-page-map-expanded.png":::

| Property | Description |
| --- | --- |
| Favicon | Small icon that appears on the left side of the browser tab. |
| Header | Space across the top of the sign-in page, behind the header log. |
| Header logo | Logo that appears in the upper-left corner of the sign-in page. |
| Background image | The entire space behind the sign-in box. |
| Page background color | The entire space behind the sign-in box. |
| Banner logo | Logo that appears at the top of the sign-in box |
| Sign-in page title | Larger text that appears below the banner logo. |
| Sign-in page description | Text to describe the sign-in page. |
| Username hint and text | The text that appears before a user enters their information. |
| Self-service password reset | A link you can add below the sign-in page text for password resets. |
| Sign-in page text | Text you can add below the username field. |
| Footer link: Privacy & Cookies | Link you can add to the lower-right corner for privacy information. |
| Footer: Terms of Use | Text in the lower-right corner of the page where you can add Terms of use information. |
| Footer | Space across the bottom of the page for privacy and Terms of Use information. |
| Template | The layout of the page and sign-in boxes. |

## How branding themes work

Here are some important things to know about how branding themes work.

- Branding themes can be applied to specific applications, while company branding applies tenant-wide.
- Company branding is used as fallback for any properties not defined in the branding theme.
- Default branding is used for any properties not defined in company branding.

## Limits and constraints

Here are some of the limits and constraints for branding themes.

- You can create up to 5 branding themes per tenant.
- The live preview capability previews style and layout changes and only shows the Sign in page. Live preview does not include any custom text overrides.
- You can't use the name **Default theme** for your branding theme name. This name is reserved for company branding settings.

## Create a new theme

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com/) as [Organizational Branding Administrator](../../identity/role-based-access-control/permissions-reference.md#organizational-branding-administrator) and [Application Administrator](../../identity/role-based-access-control/permissions-reference.md#application-administrator).

1. Browse to **Entra ID** > **Custom branding**.

1. On the **Company branding** page, select **Branding Themes** and then select the **Themes** tab.
   
    :::image type="content" source="./media/how-to-customize-branding-themes-apps/create-new-theme.png" alt-text="Screenshot of the Company Branding page and the Themes tab." lightbox="./media/how-to-customize-branding-themes-apps/create-new-theme.png":::

1. Select **Create new theme**.
   
1. On the **Basics** tab, enter a **Name** for your theme.

    :::image type="content" source="./media/how-to-customize-branding-themes-apps/add-application-to-theme.png" alt-text="Screenshot of the Create a theme page and the Basics tab to apply themes to applications." lightbox="./media/how-to-customize-branding-themes-apps/add-application-to-theme.png":::

1. To select the applications that will use this theme, under **Apply theme to**, select **Add applications**. (Or you can [add applications later](#apply-a-theme-to-applications).)

1. On the **Layout** tab, select the placement of web page elements on the sign-in page.

   - **Layout template** – Choose whether the sign-in pane is centre-aligned on the page or right-aligned.
   - **Header** – To show an image in a page header, select the checkbox and browse for the image you want to display. Requirements: Transparent PNG, JPG, or JPEG with image size 245x36px and maximum file size 10KB.
   - **Footer** – To show a page footer that includes links to your published privacy and cookies and/or terms of use statements, select the appropriate checkbox, enter the link text, and add the URL for your content.
     
    :::image type="content" source="./media/how-to-customize-branding-themes-apps/layout-tab.png" alt-text="Screenshot of the Create a theme page and the Layout tab to specify the sign-in experience." lightbox="./media/how-to-customize-branding-themes-apps/layout-tab.png":::

1. Select the **Preview** button to see your changes to the layout.
   
    :::image type="content" source="./media/how-to-customize-branding-themes-apps/preview-button.png" alt-text="Screenshot of the Preview button to preview a layout." lightbox="./media/how-to-customize-branding-themes-apps/preview-button.png":::

    :::image type="content" source="./media/how-to-customize-branding-themes-apps/sign-in-preview.png" alt-text="Screenshot of the Microsoft Sign in experience and the background layout." lightbox="./media/how-to-customize-branding-themes-apps/sign-in-preview.png":::

1. On the **Styling** tab, modify any of the background elements.

   - **Background color** – The color that replaces the background image whenever the image can't be loaded, for example due to connection latency.
   - **Background image** – The large image that displays on the sign-in page. If you upload an image, it scales and crops to fill the browser window.
   - **Favicon** – The icon that displays in the web browser tab.
   - **Banner logo** – Displays on the sign-in page and in the user's access panel.
   - **Square logo (light theme)** – Represents user accounts in your tenant.
   - **Square logo (dark theme)** – If the light theme square logo displays poorly on dark backgrounds, you can upload a logo to be used in its place when dark backgrounds are used.
   - **Custom CSS** – Upload your own CSS file to replace default Microsoft styling with your own styling for: color, font, text size, position of elements, and displays for different devices and screen sizes.
     
    :::image type="content" source="./media/how-to-customize-branding-themes-apps/styling-tab.png" alt-text="Screenshot of the Create a theme page and the Styling tab settings." lightbox="./media/how-to-customize-branding-themes-apps/styling-tab.png":::

1. Select the **Preview** button to see your styling changes.
   
    :::image type="content" source="./media/how-to-customize-branding-themes-apps/sign-in.png" alt-text="Screenshot of the customized Sign in experience." lightbox="./media/how-to-customize-branding-themes-apps/sign-in.png":::

1. On the **Custom text** tab, select a page you want to customize, such as Sign-in, Sign-up, Attribute collection, or One-time code.

    :::image type="content" source="./media/how-to-customize-branding-themes-apps/custom-text-tab.png" alt-text="Screenshot of the Create a theme page and the Custom text tab settings." lightbox="./media/how-to-customize-branding-themes-apps/custom-text-tab.png":::

1. Customize the text for the selected page and then select **Add**.

    Custom text set for a theme may impact localized UX as they will not be localized. To ensure full localization of all text, set custom text for each theme language.
  
    :::image type="content" source="./media/how-to-customize-branding-themes-apps/custom-text-edit.png" alt-text="Screenshot of the Edit custom text page for the Sign-in page." lightbox="./media/how-to-customize-branding-themes-apps/custom-text-edit.png":::

1. On the **Review** tab, review your settings.

1. Select **Create** to create the theme.

## Apply a theme to applications

In this section, you apply a theme to applications in your tenant.

1. On the **Branding Themes** page, select the **Themes** tab.

1. Select a theme you created to open the overview.

1. Under **Basics**, select the pencil edit icon.
  
    :::image type="content" source="./media/how-to-customize-branding-themes-apps/edit-theme-overview.png" alt-text="Screenshot of the Overview tab of the edit theme page." lightbox="./media/how-to-customize-branding-themes-apps/edit-theme-overview.png":::

1. Under **Apply theme to**, select **Edit** to edit the list of applications.
  
    :::image type="content" source="./media/how-to-customize-branding-themes-apps/edit-basics.png" alt-text="Screenshot of the Edit Basics page to edit the list of applications." lightbox="./media/how-to-customize-branding-themes-apps/edit-basics.png":::

1. Search for or browse to your application. Select the check box, and then choose **Select**.
   
    :::image type="content" source="./media/how-to-customize-branding-themes-apps/select-application.png" alt-text="Screenshot of the Add applications page to select applications." lightbox="./media/how-to-customize-branding-themes-apps/select-application.png":::

## Edit a theme

In this section, you edit a theme.

1. On the **Branding Themes** page, select the **Themes** tab.

1. Select a theme you created to open the overview.

1. Select the pencil edit icon of the parts you want to edit.

## Add a language to a theme

In this section, you add a language to a theme.

1. On the **Branding Themes** page, select the **Themes** tab.

1. Select a theme you created to open the overview.

1. On the **Languages** tab, select **Add a language** to customize the language of the theme.
  
    :::image type="content" source="./media/how-to-customize-branding-themes-apps/languages-tab.png" alt-text="Screenshot of the Languages tab to add a language." lightbox="./media/how-to-customize-branding-themes-apps/languages-tab.png":::

## Use Microsoft Graph API

To create app-based branding with Microsoft Graph APIs, see .

## Related content

- [Configure your company branding](../../fundamentals/how-to-customize-branding.md)
