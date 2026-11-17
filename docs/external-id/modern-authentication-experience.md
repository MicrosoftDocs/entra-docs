---
title: Microsoft Entra External ID Sign-In Experience
titleSuffix: ""
description: Give your users a recognizable, clearly guided sign-in experience with modern controls, light and dark modes, and new branding and content properties.
ms.topic: concept-article
ms.date: 11/16/2026
ms.custom: msecd-doc-authoring-1026
ai-usage: ai-generated
#customer intent: As an administrator, I want to understand the modern authentication experience so that I can personalize branding and guidance for my users.
---

# Microsoft Entra External ID modern authentication experience overview

[!INCLUDE [applies-to-external-only](includes/applies-to-external-only.md)]

Help your users recognize your brand and navigate the authentication experience with confidence. Built on Microsoft's Fluent design language, Microsoft Entra External ID's refreshed experience brings clearer guidance, familiar controls, and light and dark modes to supported journeys.

Make this polished foundation yours with built-in branding and content properties. Add your logos, tailor sign-in guidance, and make support easy to find through the supported branding settings.

> [!IMPORTANT]
> The modern authentication experience (Fluent) is scheduled to become available in preview on December 7, 2026. This information relates to a prerelease product that may be substantially modified before it's released. Microsoft makes no warranties, expressed or implied, with respect to the information provided here.
>
> For an overview of the customization options, see [Customize your authentication experience](customization-overview.md).

## What's improved for your users

The modern experience is more than a visual refresh. Thoughtful interactions help your users understand what's being requested and what to do next. Examples include:

- **Floating labels** keep field prompts visible as your users enter information.
- **Show and hide password controls** let your users check what they've entered and hide it again when they're done.
- **Auto-progressing code-entry boxes** show the code length and make individual digits easier to check.
- **Easier switching between sign-in methods** gives your users a consistent way to choose another available credential throughout the flow.
- **Clearer consent explanations** help your users understand what they're agreeing to.
- **Plain-language error guidance** helps them find a way forward when something goes wrong.
- **Familiar controls and consistent visual cues** make the next action easier to recognize without relearning each screen.
- **Responsive layouts** keep the experience usable as your users move between desktop and mobile devices.
- **Upfront guidance and support options** keep essentials visible, with more detail just an expansion away.

The controls and layouts are part of the Microsoft-provided experience, not components you need to build. You can add your own guidance and support text through [branding themes](~/fundamentals/how-to-customize-branding-themes-apps.md). Branding settings don't enable new authentication methods, add sign-up steps, or change consent requirements.

:::row:::
   :::column span="":::
      :::image type="content" source="customers/media/modern-ux-customization/modern-code-entry-light.png" alt-text="Screenshot of the Contoso code-entry experience in light mode with individual boxes for verification-code digits." lightbox="customers/media/modern-ux-customization/modern-code-entry-light.png":::
   :::column-end:::
   :::column span="":::
      :::image type="content" source="customers/media/modern-ux-customization/modern-code-entry-dark.png" alt-text="Screenshot of the Contoso code-entry experience in dark mode with individual boxes for verification-code digits." lightbox="customers/media/modern-ux-customization/modern-code-entry-dark.png":::
   :::column-end:::
:::row-end:::

<a name='establish-your-baseline'></a>

## Light and dark modes

Use **Theme mode** to set the authentication experience to light or dark mode, or have it adapt to your users' device preferences.

Branding themes support separate light and dark versions of the header image, background image, square logo, and banner logo. Each version is used in its corresponding mode.

:::row:::
   :::column span="":::
      :::image type="content" source="customers/media/modern-ux-customization/overview-modern-light.png" alt-text="Screenshot of the Contoso sign-in experience in light mode with a branded background, logo, and guidance." lightbox="customers/media/modern-ux-customization/overview-modern-light.png":::
   :::column-end:::
   :::column span="":::
      :::image type="content" source="customers/media/modern-ux-customization/overview-modern-dark.png" alt-text="Screenshot of the Contoso sign-in experience in dark mode with a dark background and sign-in box." lightbox="customers/media/modern-ux-customization/overview-modern-dark.png":::
   :::column-end:::
:::row-end:::

| Theme mode | Behavior |
|---|---|
| **Light only** | The page stays in light mode. |
| **Dark only** | The page stays in dark mode. |
| **Both (adaptive)** (default) | The page follows the user's device theme setting. |

:::image type="content" source="customers/media/modern-ux-customization/ignite-layout-appearance.png" alt-text="Screenshot of layout and appearance settings showing alignment templates and theme modes." lightbox="customers/media/modern-ux-customization/ignite-layout-appearance.png":::

## New branding and content properties

The following properties are added to [branding themes](~/fundamentals/how-to-customize-branding-themes-apps.md) in this preview. Existing branding properties, including light-mode images, page titles, descriptions, and username hints, remain available.

:::image type="content" source="customers/media/modern-ux-customization/modern-branding-property-map.png" alt-text="Annotated screenshot identifying the header, favicon, logos, background, sign-in text, create-account link, guidance, and Help on a Contoso sign-in page." lightbox="customers/media/modern-ux-customization/modern-branding-property-map.png":::

### Dark mode assets

| Property | Description | Image requirements |
|---|---|---|
| **Header image (dark mode)** | Image displayed in the page header in dark mode when the header is shown. | PNG or JPG, 245 x 36 px. Maximum file size: 10 KB. |
| **Background image (dark mode)** | Image displayed behind the sign-in box in dark mode. | PNG or JPG, 1920 x 1080 px. Maximum file size: 300 KB. |
| **Banner logo (dark mode)** | Logo displayed at the top of the sign-in box in dark mode. | PNG or JPG, 245 x 36 px. Maximum file size: 50 KB. |

Dark-mode images are configured separately from existing light-mode images and have the same format, dimensions, and file size requirements as their light-mode counterparts.

### Sign-in guidance and support

| Property | Description and example use | Format and recommended length |
|---|---|---|
| **Display message box (short)** | Always-visible guidance below the sign-in box, such as which account to use. | Markdown; 150 characters or fewer recommended. |
| **Display message box (long)** | Additional guidance in an expandable section below the sign-in box, such as account-recovery instructions. | Markdown; 1,024 characters or fewer recommended. |
| **Support text** | Troubleshooting details, reached through Help or certain errors, such as a help desk link or phone number. | Markdown; 300 characters or fewer recommended. |

:::image type="content" source="customers/media/modern-ux-customization/modern-expanded-guidance.png" alt-text="Annotated screenshot of short guidance and expanded long guidance below the sign-in controls." lightbox="customers/media/modern-ux-customization/modern-expanded-guidance.png":::

:::image type="content" source="customers/media/modern-ux-customization/modern-troubleshooting-support.png" alt-text="Annotated screenshot of the Help panel with support text and expanded troubleshooting details while long guidance is collapsed." lightbox="customers/media/modern-ux-customization/modern-troubleshooting-support.png":::

### Create-account link

The **Create account** settings control the visibility, display text, and destination of the account-creation link shown during sign-in.

| Setting | Description |
|---|---|
| **Show create account link** | Specifies whether the link is displayed. |
| **Create account display text** | Text displayed for the link. |
| **Create account link** | URL opened when the user selects the link. |

When the link is enabled, configure its display text and destination URL. These settings don't change the application's sign-up user-flow configuration.

<a name='identify-your-theme-and-localization'></a>

## Preview availability and configuration

The modern authentication experience and new properties are scheduled to become available in preview on **December 7, 2026**, for external tenants with the preview enabled. Customizations are configured through branding themes assigned to specific applications. The new properties aren't available through tenant-wide company branding and don't apply to custom interfaces built with native authentication.

> [!IMPORTANT]
> Enabling the preview applies the modern authentication experience to all authentication flows in your tenant, even when customizations are scoped to specific applications. Federation flows aren't supported at this time, and end-user experiences for administrators are partially supported. Unsupported flows might not work or might continue to use the current experience. Review [Availability and scope](customization-overview.md#availability-and-scope) before enabling the preview.

The preview also introduces a redesigned branding themes experience in the Microsoft Entra admin center. For theme creation and assignment, see [Customize branding themes](~/fundamentals/how-to-customize-branding-themes-apps.md).

Language-specific text and assets are configured per locale. Branding theme language settings in the admin center don't support the new properties. During the preview, use the [Microsoft Graph theme localization API](/graph/api/resources/organizationalbrandingthemelocalization?view=graph-rest-beta&preserve-view=true) to configure these properties per locale. For general language behavior, see [Customize the language of the authentication experience](customers/how-to-customize-languages-customers.md).

## Related content

- [Authentication customization overview](customization-overview.md).
- [Basic and Advanced styling](styling.md).
- [Custom HTML and JavaScript](custom-html-javascript.md).
