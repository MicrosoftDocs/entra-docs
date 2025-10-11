---
title: Customize the sign-in experience for your application with branding themes using the Microsoft Entra admin center (Preview)
description: Learn about how to create branding themes and apply them to the sign-in experience for your application using the Microsoft Entra admin center.
author: rolyon
manager: pmwongera
ms.author: rolyon
ms.date: 09/30/2025
ms.reviewer: 
ms.service: identity-platform
ms.topic: how-to
#Customer intent: As a developer integrating with Microsoft Entra ID, I want to customize the sign-in experience for my application.

---

# Customize the sign-in experience for your application with branding themes using the Microsoft Entra admin center (Preview)

> [!IMPORTANT]
> Branding themes for applications are currently in PREVIEW.
> This information relates to a prerelease product that may be substantially modified before it's released. Microsoft makes no warranties, expressed or implied, with respect to the information provided here.

Previously, you could only use a single branding theme for your entire tenant when users sign in to your applications. Now you can create unique authentication experiences for applications in your tenant. Each application can have its own theme, which you can customize with a background image or color, favicon, layout, header, and footer. This customization overrides any configurations made to the default branding. If you don't make any changes to the elements, the default elements are displayed.

This article describes how you can create multiple branding themes for different applications in your tenant.

## Prerequisites

- A Microsoft Entra [workforce](../fundamentals/create-new-tenant.md) or [external](../external-id/customers/quickstart-tenant-setup.md) tenant.
- Have at least the [Organizational Branding Administrator](../identity/role-based-access-control/permissions-reference.md#organizational-branding-administrator) role.
- Have at least the [Application Administrator](../identity/role-based-access-control/permissions-reference.md#application-administrator) role for applications that you want to apply a theme to.
- A registered application in your tenant. If you haven't registered an application yet, see [Register an application](../identity-platform/quickstart-register-app.md).
- Review the file size requirements for each image you want to add. Use a photo editor if needed to create correctly sized and formatted images: PNG, JPG, or JPEG with image size 245x36px and maximum file size 10KB.

## Step 1: Create a theme and attach it to your application

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com/) as [Organizational Branding Administrator](../identity/role-based-access-control/permissions-reference.md#organizational-branding-administrator) and [Application Administrator](../identity/role-based-access-control/permissions-reference.md#application-administrator).

1. On the **Company Branding** page, select the **Themes** tab, and then select **Create new theme**.
   
    :::image type="content" source="./media/how-to-customize-branding-themes-apps/create-new-theme.png" alt-text="Screenshot of the Company Branding page and the Themes tab." lightbox="./media/how-to-customize-branding-themes-apps/create-new-theme.png":::
   
1. Enter a **Name** for your theme. To select the applications that will use this theme, under **Apply theme to**, select **Add applications**. (Or you can add applications later and skip the next step.)

    :::image type="content" source="./media/how-to-customize-branding-themes-apps/add-application-to-theme.png" alt-text="Screenshot of the Create a theme page and the Basics tab to apply themes to applications." lightbox="./media/how-to-customize-branding-themes-apps/add-application-to-theme.png":::

1. Search for or browse to the application you created in **Step 1. Create your application**. Select the check box, and then choose **Select**.
   
    :::image type="content" source="./media/how-to-customize-branding-themes-apps/select-application.png" alt-text="Screenshot of the Add applications page to select applications." lightbox="./media/how-to-customize-branding-themes-apps/select-application.png":::

1. To customize the theme, select  **Next: Layout** and follow the steps in the next section. To create the theme and customize it later select **Review + create**.

## Step 2: Configure the branding theme properties

In this step, you configure branding properties on the theme you created.

1. On the **Layout** tab, select the placement of web page elements on the sign-in page.
   - **Layout template** – Choose whether the sign-in pane is centre-aligned on the page or right-aligned.
   - **Header** – To show an image in a page header, select the checkbox and browse for the image you want to display. Requirements: Transparent PNG, JPG, or JPEG with image size 245x36px and maximum file size 10KB.
   - **Footer** – To show a page footer that includes links to your published privacy and cookies and/or terms of use statements, select the appropriate checkbox, enter the link text, and add the URL for your content.
     
    :::image type="content" source="./media/how-to-customize-branding-themes-apps/layout-tab.png" alt-text="Screenshot of the Create a theme page and the Layout tab to specify the sign-in experience." lightbox="./media/how-to-customize-branding-themes-apps/layout-tab.png":::

1. Select **Preview** to see your changes to the layout.
   
    :::image type="content" source="./media/how-to-customize-branding-themes-apps/preview-button.png" alt-text="Screenshot of the Preview button to preview a layout." lightbox="./media/how-to-customize-branding-themes-apps/preview-button.png":::

    :::image type="content" source="./media/how-to-customize-branding-themes-apps/sign-in-preview.png" alt-text="Screenshot of the Microsoft Sign in experience and the background layout." lightbox="./media/how-to-customize-branding-themes-apps/sign-in-preview.png":::

1. To continue customizing the theme, select **Next: Styling** and follow the steps in the next section. Or select **Review + create** if you have finished setting up your theme.

1. On the **Styling** tab, modify any of the background elements.
   - **Background color** – The color that replaces the background image whenever the image can't be loaded, for example due to connection latency.
   - **Background image** – The large image that displays on the sign-in page. If you upload an image, it scales and crops to fill the browser window.
   - **Favicon** – The icon that displays in the web browser tab.
   - **Banner logo** – Displays on the sign-in page and in the user's access panel.
   - **Square logo (light theme)** – Represents user accounts in your tenant.
   - **Square logo (dark theme)** – If the light theme square logo displays poorly on dark backgrounds, you can upload a logo to be used in its place when dark backgrounds are used.
   - **Custom CSS** – Upload your own CSS file to replace default Microsoft styling with your own styling for: color, font, text size, position of elements, and displays for different devices and screen sizes.
     
    :::image type="content" source="./media/how-to-customize-branding-themes-apps/styling-tab.png" alt-text="Screenshot of the Create a theme page and the Styling tab settings." lightbox="./media/how-to-customize-branding-themes-apps/styling-tab.png":::

1. Select **Preview** to see your styling changes.
   
    :::image type="content" source="./media/how-to-customize-branding-themes-apps/sign-in.png" alt-text="Screenshot of the customized Sign in experience." lightbox="./media/how-to-customize-branding-themes-apps/sign-in.png":::

1. Select **Next: Custom text** to continue customizing or **Review + create** if you have finished setting up your theme.
1. On the **Custom text** tab, add custom text to the sign-up and sign-in experience.
   - **Select a page** – Select the sign-up and sign-in experience you want to customize. The options are **Sign-in**, **Sign-up**, and **Sign-in/up one time code**.
   - **Custom text** – Customize the text that appears on the selected page.
     
    :::image type="content" source="./media/how-to-customize-branding-themes-apps/create-a-theme.png" alt-text="Screenshot of the Create a theme page and the Custom text tab settings." lightbox="./media/how-to-customize-branding-themes-apps/create-a-theme.png":::

1. Select **Next: Review and Create** to create the theme.

You can also customize the language of the theme. Select the theme you created and select the **Languages** tab. Follow the steps to customize the language of the theme and select **Add** when you're finished.

## To edit the theme and apply it to applications

In this step, you can edit the themes you created and apply them to applications in your tenant.

1. On the **Company Branding** page, select the **Themes** tab, and then select the theme you created to open the overview.
1. To select the applications that will use this theme, under **Apply theme to**, select **Add applications**. (Or you can add applications later and skip the next step.)
1. Search for or browse to the application you created in **Step 1. Create your application**. Select the check box, and then choose **Select**.
1. To customize the theme, select **Next: Layout** and follow the steps in the next section. To create the theme and customize it later select **Review + create**.

## Use Microsoft Graph API

To create app-based branding with Microsoft Graph APIs, see .

## Known issues

## Related content
