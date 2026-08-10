---
title: CSS reference guide for customizing company branding
description: Reference guide for the CSS template selectors for customizing Microsoft Entra sign-in page company branding.
manager: pmwongera
ms.topic: reference
ms.date: 07/21/2026
ms.reviewer: almars
ms.custom: sfi-image-nochange, msecd-doc-authoring-1015
ai-usage: ai-assisted
#Customer Intent: As an IT admin, I want to reference the CSS template for customizing company branding so that I can style my organization's sign-in pages.
---

# CSS template reference guide

Configuring your company branding for the user sign-in process provides a seamless experience in your applications that use Microsoft Entra ID as the identity and access management service. Use this CSS reference guide if you're using the [CSS template](https://download.microsoft.com/download/7/2/7/727f287a-125d-4368-a673-a785907ac5ab/custom-styles-template-013023.css) as part of the [customize company branding](reference-company-branding-css-template.md) process.

> [!IMPORTANT]
> Tenants created after January 5, 2026 don't have custom CSS available for company branding in Microsoft Entra ID. Tenants created before January 5, 2026, can continue to use custom CSS.
>
> Microsoft Entra External ID tenants aren't affected.

## Deprecation of custom CSS positioning properties

As part of the [Microsoft Secure Future Initiative](https://www.microsoft.com/trust-center/security/secure-future-initiative), Microsoft Entra ID is retiring support for custom CSS *positioning properties* in company branding. These properties control where elements appear on the sign-in page and how they're layered, sized, and displayed. For example, they can move, overlap, resize, or hide page content. Retiring them keeps sign-in page layouts consistent and predictable across Microsoft Entra ID.

This change is the first step toward retiring the custom CSS feature entirely. Microsoft plans to provide advance notice, recommended migration paths, and future advanced customization options before that retirement.

For more information, see the blog post [Microsoft Entra ID enhances security of branded sign-ins](https://techcommunity.microsoft.com/blog/microsoft-entra-blog/microsoft-entra-id-enhances-security-of-branded-sign-ins/4537471).

### Timeline

- **After July 21, 2026**: Tenants that don't already use the affected positioning properties can't configure them.
- **Later**: The affected positioning properties will be deprecated globally. After deprecation, these properties are blocked and no longer function.
- **Eventually**: Custom CSS will be fully retired. Microsoft will share more guidance, including recommended migration paths, before retirement.

### Who's affected

This change affects organizations whose Microsoft Entra ID tenant uses any of the deprecated positioning properties in their custom CSS. Microsoft Entra External ID tenants aren't affected. Tenants that don't already use these properties aren't affected, because they can't configure the properties after July 21, 2026.

Microsoft notifies affected customers directly in advance.

### Deprecated properties

If your custom CSS uses any of the following properties, remove them from your configuration. These properties don't have a supported migration or replacement.

- `position` (including `top`, `right`, `bottom`, `left`, and `z-index`)
- `margin` (including `margin-top`, `margin-bottom`, `margin-left`, and `margin-right`)
- `transform`
- `translate`
- `opacity`
- `overflow`
- `filter`
- `pointer-events`
- `clip-path`
- `mix-blend-mode`

### Check and update your custom CSS

To check whether your custom CSS uses any deprecated properties, use Microsoft Graph to export your current company branding configuration, and then check it with the tenant branding inspector tool. You need a Global Administrator or Branding Administrator account.

1. Go to [Microsoft Graph Explorer](https://developer.microsoft.com/graph/graph-explorer), and then sign in to your tenant.
1. If you don't already know your tenant ID, send a `GET` request to the following URL, and then copy the `id` value from the response:

    ```http
    https://graph.microsoft.com/v1.0/organization
    ```

1. Send a `GET` request to the following URL to return all configured company branding localizations. Replace `<tenant-id>` with your tenant ID:

    ```http
    https://graph.microsoft.com/v1.0/organization/<tenant-id>/branding/localizations
    ```

1. Copy the response, or export it to a JSON file.
1. Go to the [tenant branding inspector tool](https://entra-branding-tools.github.io/tenant-branding-inspector/).
1. Paste the copied response, or upload the exported JSON file, into the tool. The tool lists each locale and the deprecated properties that it uses.

To remove the deprecated properties, edit your CSS file, upload it on the **Company Branding** page in the [Microsoft Entra admin center](https://entra.microsoft.com), and then save your changes. To validate the visual impact before you update production, apply the changes in a test tenant first.

## HTML selectors

The following CSS styles become the default body and link styles for the whole page. Styles that you apply to other links or text override these selectors.

- `body` - Styles for the whole page
- Styles for links:
    - `a, a:link` - All links
    - `a:hover` - When the mouse is over the link
    - `a:focus` - When the link has focus
    - `a:focus:hover` - When the link has focus *and* the mouse is over the link
    - `a:active` - When the link is being clicked

<a name='azure-ad-css-selectors'></a>

## Microsoft Entra CSS selectors

Use the following CSS selectors to configure the details of the sign-in experience.

>[!Note]
>To customize internal navigation links, use the new custom CSS selector: `.ext-link`.

- `.ext-background-image` - Container that includes the background image in the default lightbox template
- `.ext-header` - Header at the top of the container
- `.ext-header-logo` - Header logo at the top of the container

   :::image type="content" source="media/reference-company-branding-css-template/header-logo.png" alt-text="Screenshot of the sign-in screen with the .ext-header and .ext-header-logo areas highlighted.":::

- `.ext-middle` - Style for the full-screen background that aligns the sign-in box vertically to the middle and horizontally to the center
- `.ext-vertical-split-main-section` - Style for the container of the partial-screen background in the vertical split template that contains both a sign-in box and a background (This style is also known as the Active Directory Federation Services (ADFS) template.)
- `.ext-vertical-split-background-image-container` - Sign-in box background in the vertical split/ADFS template
- `.ext-sign-in-box` - Sign-in box container
- `.ext-title` - Title text

   :::image type="content" source="media/reference-company-branding-css-template/sign-in-box-title.png" alt-text="Screenshot of the sign-in box, with the portion of the box that is styled with the .ext-sign-in-box selector.":::

- `.ext-subtitle` - Subtitle text

- Styles for links:
    - `.ext-link` - Internal navigation links

- Styles for primary buttons:
    - `.ext-button.ext-primary` - Primary button default style
    - `.ext-button.ext-primary:hover` - When the mouse is over the button
    - `.ext-button.ext-primary:focus` - When the button has focus
    - `.ext-button.ext-primary:focus:hover` - When the button has focus *and* the mouse is over the button
    - `.ext-button.ext-primary:active` - When the button is being clicked

   :::image type="content" source="media/reference-company-branding-css-template/primary-button.png" alt-text="Screenshot of the sign-in box with the primary - Next - button highlighted.":::

- Styles for secondary buttons:
    - `.ext-button.ext-secondary` - Secondary buttons
    - `.ext-button.ext-secondary:hover` - When the mouse is over the button
    - `.ext-button.ext-secondary:focus` - When the button has focus
    - `.ext-button.ext-secondary:focus:hover` - When the button has focus *and* the mouse is over the button
    - `.ext-button.ext-secondary:active` - When the button is being clicked

   :::image type="content" source="media/reference-company-branding-css-template/secondary-button.png" alt-text="Screenshot of the sign-in box at the Sign-in options step, with the secondary - Back - button highlighted.":::

- `.ext-error` - Error text

   :::image type="content" source="media/reference-company-branding-css-template/error-text.png" alt-text="Screenshot of the sign-in box with error text highlighted.":::

- Styles for text boxes:
    - `.ext-input.ext-text-box` - Text boxes
    - `.ext-input.ext-text-box.ext-has-error` - When there's a validation error associated with the text box
    - `.ext-input.ext-text-box:hover` - When the mouse is over the text box
    - `.ext-input.ext-text-box:focus` - When the text box has focus
    - `.ext-input.ext-text-box:focus:hover` - When the text box has focus *and* the mouse is over the text box

   :::image type="content" source="media/reference-company-branding-css-template/ext-text-box.png" alt-text="Screenshot of the sign-in box with the text box with sample text highlighted.":::

- `.ext-boilerplate-text` - Custom message text at the bottom of the sign-in box
- `.ext-promoted-fed-cred-box` - Sign-in options text box

   :::image type="content" source="media/reference-company-branding-css-template/boilerplate-fed-cred.png" alt-text="Screenshot of the sign-in box with the optional boilerplate text area highlighted.":::

- Styles for the footer:
    - `.ext-footer` - Footer area at the bottom of the page
    - `.ext-footer-links` - Links area in the footer at the bottom of the page
    - `.ext-footer-item` - Link items (such as "Terms of use" or "Privacy & cookies") in the footer at the bottom of the page
    - `.ext-debug-item` - Debug details ellipsis in the footer at the bottom of the page
