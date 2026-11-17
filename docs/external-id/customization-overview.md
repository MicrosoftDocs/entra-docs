---
title: Microsoft Entra External ID Customization
titleSuffix: ""
description: Help your users recognize your brand and understand their next step with content, styling, and custom HTML in Microsoft Entra External ID.
ms.topic: overview
ms.date: 11/16/2026
ms.custom: msecd-doc-authoring-1026
ai-usage: ai-generated
#customer intent: As an administrator, I want to understand the customization options so that I can choose the right experience for my users.
---

# Microsoft Entra External ID customizations overview

[!INCLUDE [applies-to-external-only](includes/applies-to-external-only.md)]

Every sign-in shapes how your users experience your brand. Make that interaction distinctly yours, with recognizable design, clear guidance, and support where your users need it. Microsoft Entra External ID is introducing a new, modern authentication experience and expanded customization capabilities to help you deliver that experience without building and maintaining authentication controls yourself.

Bring your brand to life, with as much customization as your experience needs. Make the polished, modern foundation yours with built-in branding and styling, or create a broader canvas with custom HTML and JavaScript that helps your users navigate each step with confidence.

<a name='preview-scope'></a>

> [!IMPORTANT]
> The modern Fluent experience, Basic and Advanced styling, and custom HTML with custom JavaScript are scheduled to become available in preview on December 7, 2026. This information relates to a prerelease product that may be substantially modified before it's released. Microsoft makes no warranties, expressed or implied, with respect to the information provided here.

<a name='progressive-control-model'></a>

<a name='choose-the-customization-your-customers-need'></a>

<a name='choose-a-customization-option'></a>

<a name='combine-customization-layers'></a>

## Choose the customization your brand needs

Start with a polished foundation and layer in the customization your brand needs, from coordinated colors to a distinctive page experience.

All options build on the familiar branding themes platform, so each application can have its own distinct brand identity while Microsoft continues to provide the secure, trusted authentication experience underneath.

| Customization option | What you can deliver |
|---|---|
| [Modern authentication experience (Fluent)](modern-authentication-experience.md) | Your brand identity layered onto a polished, modern foundation with built-in branding and content properties, clear guidance, and familiar controls. |
| [Basic styling](styling.md#configure-basic-styling) | Your brand color carried across supported UI elements in light and dark modes, configurable in minutes. |
| [Advanced styling](styling.md#configure-advanced-styling) | Your design system reflected in supported typography, spacing, and UI details, with precise styling control. |
| [Custom HTML and JavaScript](custom-html-javascript.md) | Your own page layout and content, shaped with HTML and brought to life with JavaScript for step-aware guidance, while the familiar Microsoft authentication experience remains underneath. |

<a name='content-images-and-appearance'></a>

<a name='recognizable-pages-and-useful-guidance'></a>

## Modern authentication experience (Fluent)

The modern authentication experience is more than a visual refresh. Using Microsoft's Fluent design language, it brings clearer guidance, familiar controls, and new dark mode support to supported sign-up and sign-in journeys. That attention to detail carries through the journey, with clear instructions, visual cues, and thoughtful interactions that work together to create a seamless experience.

Essential customization is built into this foundation. Add supported logos, backgrounds, text, and links through the same familiar branding themes experience, without writing code. New properties for dark mode assets keep your brand recognizable across themes, while new content properties let you add custom guidance where your users need it.

:::image type="content" source="customers/media/modern-ux-customization/overview-modern-light.png" alt-text="Screenshot of the Contoso sign-in experience in light mode with a branded background, logo, and guidance." lightbox="customers/media/modern-ux-customization/overview-modern-light.png":::

:::image type="content" source="customers/media/modern-ux-customization/overview-modern-dark.png" alt-text="Screenshot of the Contoso sign-in experience in dark mode with a dark background and sign-in box." lightbox="customers/media/modern-ux-customization/overview-modern-dark.png":::

Learn how to enable and personalize the experience in [Modern authentication experience](modern-authentication-experience.md).

<a name='a-consistent-visual-identity'></a>

## Basic styling

Your brand color sets the tone for a cohesive authentication experience. Start by entering your brand color to generate coordinated light and dark palettes. Basic styling then carries that color automatically across supported buttons, links, and other UI elements, giving you a branded experience in minutes without styling each element individually.

:::image type="content" source="customers/media/modern-ux-customization/brand-color-ramp.png" alt-text="Screenshot of the light-theme and dark-theme brand-color ramps in the admin center, each with 16 stops numbered 10 through 160." lightbox="customers/media/modern-ux-customization/brand-color-ramp.png":::

Learn how to [apply your brand color with basic styling](styling.md#configure-basic-styling).

## Advanced styling

When color alone isn't enough, bring the finer details of your design system into the authentication experience. Advanced styling uses **design tokens**: named settings that define how UI components look, such as font sizes, colors, and corner radii. These settings give you precise control over typography, colors, layout and spacing, borders, shadows, and animation across more than 23 component types.

Build on your basic styling palette with targeted changes to the visual details that matter to your application, or define your styling from the ground up using supported tokens. Separate light and dark configurations let you adapt colors, contrast, and visual details to suit each mode.

:::image type="content" source="customers/media/modern-ux-customization/overview-advanced-styling.png" alt-text="Screenshot of a Contoso Airways sign-in page with customized purple colors, typography, and rounded controls." lightbox="customers/media/modern-ux-customization/overview-advanced-styling.png":::

Learn how to [customize your authentication experience with advanced styling](styling.md#configure-advanced-styling).

<a name='more-context-around-the-sign-in-box'></a>

## Custom HTML and JavaScript

Your experience. Microsoft's authentication. Custom HTML gives your brand more room around the Microsoft-rendered sign-in controls. Shape the page with your own layout, imagery, navigation, and content. Place onboarding guidance beside the sign-in box, make support easy to find, or add branded footers with privacy notices and compliance information relevant to your application.

Pair custom HTML with advanced styling to carry your page's design into the sign-in box using supported design tokens.

Custom JavaScript enables dynamic content that adapts to your users' current step, from relevant instructions during verification to progress indication throughout the flow, using documented events for screen changes and action processing. The page doesn't just look branded. It helps your users move forward.

:::image type="content" source="customers/media/modern-ux-customization/overview-custom-html.png" alt-text="Screenshot of a Contoso Journeys custom HTML page with branded navigation, contextual guidance, and a progress indicator around the sign-in box." lightbox="customers/media/modern-ux-customization/overview-custom-html.png":::

Learn how to [build branded, interactive authentication pages with custom HTML and JavaScript](custom-html-javascript.md).

<a name='admin-configuration'></a>

## Availability and scope

The modern authentication experience, styling, and custom HTML and JavaScript are scheduled to become available in preview on **December 7, 2026**, for Microsoft Entra External ID tenants with the preview enabled. Branding themes let you scope the new customizations to specific applications.

> [!IMPORTANT]
> Enabling the preview applies the modern authentication experience to all authentication flows in your tenant, even when customizations are scoped to specific applications. Flows listed under "Not supported or limited" might not work or might continue to use the current experience. Review these limitations before enabling the preview.
>
> Features in preview might change or not work as expected. Some edge-case screens might still appear in the current experience.

### Supported in the preview

- Modern authentication experience with light and dark modes.
- Basic styling with generated color palettes 
- Advanced styling using design tokens.
- Custom HTML with external JavaScript. A custom domain is required.

### Not supported or limited

- Federation flows aren't supported.
- The end-user UX for administrators is partially supported. Unsupported administrator flows and some edge-case screens use the current experience.
- Custom CSS isn't honored.
- Branding theme language settings in the Microsoft Entra admin center don't support the new properties. You can still configure these properties per locale through the API.
- New properties aren't available through tenant-wide company branding and don't apply to custom interfaces built with native authentication.

For theme creation and assignment, see [Customize branding themes](~/fundamentals/how-to-customize-branding-themes-apps.md). 

The preview also introduces a redesigned branding themes experience in the Microsoft Entra admin center, with a new, modern layout for configuring your customizations.

## Get started with customization

After enabling the preview, start with a test application and choose the customization options that fit your brand and your users' needs. Combine built-in branding, styling, and custom HTML and JavaScript as needed.

1. Identify the branding, guidance, and languages your application's audience needs.
1. [Create or select a branding theme and assign it to your test application](~/fundamentals/how-to-customize-branding-themes-apps.md).
3. Configure the [modern authentication experience](modern-authentication-experience.md) with your text, assets, and theme mode.
4. Add [Basic or Advanced styling](styling.md) to customize supported visual properties. Use [custom HTML and JavaScript](custom-html-javascript.md#set-up-a-custom-page) to create your own page layout and add content that adapts to each step of your users' journey.
1. Test the complete supported journey across languages, light and dark modes, and mobile layouts, including error and recovery paths. If you use externally hosted resources, confirm that your users can still complete authentication when those resources are unavailable.

## Programmatic customization

Microsoft Graph provides the [branding theme](/graph/api/resources/organizationalbrandingtheme?view=graph-rest-beta&preserve-view=true) and [theme localization](/graph/api/resources/organizationalbrandingthemelocalization?view=graph-rest-beta&preserve-view=true) references for automated or programmatic configuration.

<a name='next-steps'></a>

## Next steps

- [Modern authentication experience](modern-authentication-experience.md).
- [Basic and Advanced styling](styling.md).
- [Custom HTML and JavaScript](custom-html-javascript.md).
