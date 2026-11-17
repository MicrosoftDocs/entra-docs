---
title: Microsoft Entra External ID Styling
titleSuffix: ""
description: Align customer sign-in with your brand using Basic color ramps or Advanced design tokens, then configure and validate each appearance.
ms.topic: concept-article
ms.date: 11/15/2026
ms.custom: msecd-doc-authoring-1026
ai-usage: ai-generated
#customer intent: As an administrator, I want to understand the styling options so that I can align customer authentication with my organization's visual design.
---

# Microsoft Entra External ID styling overview

[!INCLUDE [applies-to-external-only](includes/applies-to-external-only.md)]

Carry your brand's visual identity throughout the authentication experience, from recognizable colors to distinctive typography and shapes. Basic and Advanced styling in Microsoft Entra External ID let you make the modern authentication experience yours, building on Microsoft's Fluent design language.

Use **Basic styling** to create a branded authentication experience with minimal effort. Set your brand colors in the Microsoft Entra admin center to generate a coordinated palette for supported controls and states in light and dark modes, without configuring individual style overrides. Use **Advanced styling** for finer control over supported colors, typography, spacing, borders, and other visual properties to reflect your design system.

Both options work through [branding themes](~/fundamentals/how-to-customize-branding-themes-apps.md).

> [!IMPORTANT]
> Basic and Advanced styling are scheduled to become available in preview on December 7, 2026. This information relates to a prerelease product that may be substantially modified before it's released. Microsoft makes no warranties, expressed or implied, with respect to the information provided here.
>
> For an overview of the customization options, see [Customize your authentication experience](customization-overview.md).

## How design tokens work

**Design tokens** are named values for colors, font sizes, spacing, and corner radii. Controls use these theme values to keep their appearance consistent. A shared token affects all elements that use it; a component-specific property targets a particular supported area or control.

| Example token | What it defines | Example value |
|---|---|---|
| `colorBrandBackground` | A brand-colored background for controls that use this visual role. | `#0F6CBD` |
| `fontSizeBase300` | A font size in the shared typography scale. | `14px` |
| `borderRadiusMedium` | A corner radius in the shared shape scale. | `4px` |

**Basic styling** requires no design-token knowledge: enter your brand color in the admin center to automatically generate and apply a ramp to supported controls and states. **Advanced styling** lets you override individual tokens and component-specific properties.

Values are grouped by purpose under `lightTheme` and `darkTheme` in the `designTokens` configuration. Each mode is configured independently and can use different values. Standard Fluent tokens you don't override retain the mode's defaults.

<a name='configure-basic-styling'></a>

## Basic styling

Basic styling creates a branded authentication experience without design-token knowledge. In your theme's **Styling** settings, select **Basic** under **Styling method**, then set **Light theme brand color** and **Dark theme brand color**. The admin center automatically generates and applies a coordinated palette to supported controls and states.

Each mode has its own palette, designed to meet contrast requirements and support accessibility. Use the built-in contrast checker to review each brand color against white text, and validate the final experience in both modes.

:::image type="content" source="customers/media/modern-ux-customization/ignite-basic-styling.png" alt-text="Screenshot of Basic styling with separate light-theme and dark-theme brand colors and generated ramps numbered 10 through 160." lightbox="customers/media/modern-ux-customization/ignite-basic-styling.png":::

### How ramp values are used

The palette contains 16 related shades, numbered **10 through 160** in increments of 10. Different controls and states use different shades in each mode; the ramp isn't a gradient displayed across the page.

:::image type="content" source="customers/media/modern-ux-customization/brand-color-ramp.png" alt-text="Screenshot of the light-theme and dark-theme brand-color ramps in the admin center, each with 16 stops numbered 10 through 160." lightbox="customers/media/modern-ux-customization/brand-color-ramp.png":::

The following table shows the default ramp mappings before explicit color overrides. Where three values appear, their order is **normal / hover / pressed**.

| Element or state | Light-mode ramp values | Dark-mode ramp values |
|---|---|---|
| Primary-button background | 80 / 70 / 40 | 70 / 80 / 40 |
| Built-in link text | 70 / 60 / 40 | 100 / 110 / 90 |
| Text-input and dropdown focus underline: focused / focused and pressed | 80 / 60 | 100 / 90 |
| Code-entry box focused border | 80 | 100 |
| Checked checkbox indicator and selected radio indicator | 80 / 70 / 60 | 100 / 110 / 90 |
| Loading spinner: moving arc / track | 80 / 140 | 100 / 50 |

The palette doesn't automatically recolor every element, such as logos, page backgrounds, or error messages. For token mappings, overrides, and programmatic requirements, see [Color-ramp behavior and semantic mappings](#color-ramp-behavior-and-semantic-mappings) in the appendix.

<a name='configure-advanced-styling'></a>

## Advanced styling

Use Advanced styling when a brand ramp alone doesn't meet your design requirements. You can keep the ramp and add individual token overrides or component-specific properties rather than replacing the entire theme.

You can combine Advanced styling with [custom HTML](custom-html-javascript.md): use design tokens to style the supported authentication controls and custom HTML to define the surrounding page layout and content.

These settings change appearance, not authentication requirements, flow logic, or the controls' internal structure. They don't provide arbitrary CSS or a dependency on generated class names.

:::image type="content" source="customers/media/modern-ux-customization/overview-advanced-styling.png" alt-text="Screenshot of a Contoso Airways sign-in page with customized purple colors, typography, and rounded controls." lightbox="customers/media/modern-ux-customization/overview-advanced-styling.png":::

### JSON template

Start with this light- and dark-theme template. Keep only the overrides you need, preserve existing settings, and replace the example font URL if used.

<br>

<details>
<summary><strong>Expand the JSON template</strong></summary>

```json
{
  "lightTheme": {
    "themeColorRamp": {
      "10": "#080117",
      "20": "#21005D",
      "30": "#32147A",
      "40": "#432B8F",
      "50": "#553FA3",
      "60": "#6753B7",
      "70": "#7967CA",
      "80": "#8C7BDD",
      "90": "#9F90EF",
      "100": "#B2A5FF",
      "110": "#C2B7FF",
      "120": "#D1C9FF",
      "130": "#DFDBFF",
      "140": "#EBE8FF",
      "150": "#F5F3FF",
      "160": "#FCFBFF"
    },
    "colorStyles": {
      "colorNeutralBackground1": "#FFFFFF",
      "colorNeutralForeground1": "#242424",
      "colorNeutralStroke1": "#D1D1D1"
    },
    "typographyStyles": {
      "fontFamilyBase": "'Segoe UI', sans-serif",
      "fontSizeBase300": "14px",
      "fontWeightSemibold": 600
    },
    "spacingStyles": {
      "spacingHorizontalM": "12px",
      "spacingVerticalM": "12px"
    },
    "borderStyles": {
      "borderRadiusMedium": "8px",
      "strokeWidthThin": "1px"
    },
    "backgroundStyles": {
      "opacity": 1,
      "fillColor": "#ffffff"
    },
    "titleStyles": {
      "textAlign": "center",
      "textDecoration": "none",
      "maxWidth": "100%",
      "color": "#242424"
    },
    "primaryButtonStyles": {
      "alignSelf": "auto",
      "backgroundColor": "#0f6cbd",
      "borderColor": "transparent",
      "borderRadius": "4px",
      "borderSize": "1px",
      "borderStyle": "none",
      "color": "#ffffff",
      "textAlign": "center",
      "textDecoration": "none",
      "maxWidth": "100%",
      "minWidth": "auto",
      "opacity": 1,
      "width": "auto"
    },
    "inputStyles": {
      "borderRadius": "4px",
      "textAlign": "left",
      "textDecoration": "none",
      "maxWidth": "100%",
      "minWidth": "0",
      "borderStyle": "solid",
      "opacity": 1,
      "lineHeight": "22px",
      "floatingPlaceholderColor": "#707070",
      "floatingPlaceholderBackgroundColor": "#ffffff",
      "disabledPlaceholderColor": "#bdbdbd",
      "floatingLabelMarginTop": "8px",
      "stackedInputMarginTop": "24px",
      "validationErrorFontSize": "12px",
      "transitionDuration": "200ms",
      "transitionTimingFunction": "cubic-bezier(0,0,0,1)"
    },
    "fontFaceStyles": [
      {
        "fontFamily": "CustomBrandFont",
        "srcUrl": "https://cdn.example.com/fonts/custom-brand-font.woff2",
        "fontWeight": "100 900",
        "fontStyle": "normal",
        "fontStretch": "normal",
        "fontDisplay": "swap"
      }
    ],
    "buttonContainerStyles": {
      "flexDirection": "column",
      "justifyContent": "flex-start",
      "alignItems": "stretch",
      "columnGap": "12px",
      "rowGap": "12px",
      "flexWrap": "nowrap"
    },
    "footerStyles": {
      "textAlign": "center",
      "textDecoration": "none",
      "maxWidth": "100%",
      "opacity": 1,
      "borderStyle": "none",
      "backgroundColor": "#ffffff",
      "color": "#424242",
      "paddingVertical": "12px",
      "paddingHorizontal": "12px"
    },
    "headerStyles": {
      "borderRadius": "0",
      "height": "48px",
      "maxWidth": "100%",
      "minWidth": "0",
      "opacity": 1,
      "logoPosition": "left",
      "logoSize": "24px",
      "logoPadding": "0",
      "backgroundColor": "transparent",
      "paddingHorizontal": "16px",
      "paddingVertical": "12px",
      "color": "#242424"
    },
    "linkStyles": {
      "textAlign": "left",
      "textDecoration": "none"
    },
    "paragraphStyles": {
      "textAlign": "left",
      "textDecoration": "none",
      "maxWidth": "100%"
    },
    "secondaryButtonStyles": {
      "alignSelf": "auto",
      "backgroundColor": "#ffffff",
      "borderColor": "#d1d1d1",
      "borderRadius": "4px",
      "borderSize": "1px",
      "borderStyle": "solid",
      "color": "#242424",
      "textAlign": "center",
      "textDecoration": "none",
      "maxWidth": "100%",
      "minWidth": "auto",
      "opacity": 1,
      "width": "auto"
    },
    "signInContainerStyles": {
      "maxWidth": "440px",
      "minWidth": "320px",
      "maxHeight": "none",
      "minHeight": "0",
      "height": "auto",
      "width": "440px",
      "borderStyle": "none",
      "opacity": 1,
      "logoPosition": "center",
      "logoSize": "36px",
      "logoPadding": "0",
      "backgroundColor": "#ffffff",
      "borderRadius": "12px",
      "padding": "40px"
    },
    "slotSubHeadingStyles": {
      "backgroundColor": "transparent",
      "color": "inherit",
      "borderColor": "transparent",
      "borderRadius": "0",
      "borderStyle": "none",
      "borderWidth": "0",
      "paddingHorizontal": "0",
      "paddingVertical": "0"
    },
    "slotFormStyles": {
      "backgroundColor": "transparent",
      "color": "inherit",
      "borderColor": "transparent",
      "borderRadius": "0",
      "borderStyle": "none",
      "borderWidth": "0",
      "paddingHorizontal": "0",
      "paddingVertical": "0"
    },
    "subtleButtonStyles": {
      "alignSelf": "auto",
      "backgroundColor": "transparent",
      "borderColor": "transparent",
      "borderRadius": "4px",
      "borderSize": "1px",
      "borderStyle": "none",
      "color": "#424242",
      "textAlign": "center",
      "textDecoration": "none",
      "maxWidth": "100%",
      "minWidth": "auto",
      "opacity": 1,
      "width": "auto"
    },
    "tileStyles": {
      "mainTextColor": "#242424",
      "mainTextFontSize": "14px",
      "mainTextFontWeight": 600,
      "secondaryTextColor": "#616161",
      "secondaryTextFontSize": "12px",
      "listRowGap": "12px"
    }
  },
  "darkTheme": {
    "themeColorRamp": {
      "10": "#080117",
      "20": "#21005D",
      "30": "#32147A",
      "40": "#432B8F",
      "50": "#553FA3",
      "60": "#6753B7",
      "70": "#7967CA",
      "80": "#8C7BDD",
      "90": "#9F90EF",
      "100": "#B2A5FF",
      "110": "#C2B7FF",
      "120": "#D1C9FF",
      "130": "#DFDBFF",
      "140": "#EBE8FF",
      "150": "#F5F3FF",
      "160": "#FCFBFF"
    },
    "colorStyles": {
      "colorNeutralBackground1": "#292929",
      "colorNeutralForeground1": "#FFFFFF",
      "colorNeutralStroke1": "#666666"
    },
    "typographyStyles": {
      "fontFamilyBase": "'Segoe UI', sans-serif",
      "fontSizeBase300": "14px",
      "fontWeightSemibold": 600
    },
    "spacingStyles": {
      "spacingHorizontalM": "12px",
      "spacingVerticalM": "12px"
    },
    "borderStyles": {
      "borderRadiusMedium": "8px",
      "strokeWidthThin": "1px"
    },
    "backgroundStyles": {
      "opacity": 1,
      "fillColor": "#292929"
    },
    "titleStyles": {
      "textAlign": "center",
      "textDecoration": "none",
      "maxWidth": "100%",
      "color": "#ffffff"
    },
    "primaryButtonStyles": {
      "alignSelf": "auto",
      "backgroundColor": "#115ea3",
      "borderColor": "transparent",
      "borderRadius": "4px",
      "borderSize": "1px",
      "borderStyle": "none",
      "color": "#ffffff",
      "textAlign": "center",
      "textDecoration": "none",
      "maxWidth": "100%",
      "minWidth": "auto",
      "opacity": 1,
      "width": "auto"
    },
    "inputStyles": {
      "borderRadius": "4px",
      "textAlign": "left",
      "textDecoration": "none",
      "maxWidth": "100%",
      "minWidth": "0",
      "borderStyle": "solid",
      "opacity": 1,
      "lineHeight": "22px",
      "floatingPlaceholderColor": "#999999",
      "floatingPlaceholderBackgroundColor": "#292929",
      "disabledPlaceholderColor": "#5c5c5c",
      "floatingLabelMarginTop": "8px",
      "stackedInputMarginTop": "24px",
      "validationErrorFontSize": "12px",
      "transitionDuration": "200ms",
      "transitionTimingFunction": "cubic-bezier(0,0,0,1)"
    },
    "fontFaceStyles": [
      {
        "fontFamily": "CustomBrandFont",
        "srcUrl": "https://cdn.example.com/fonts/custom-brand-font.woff2",
        "fontWeight": "100 900",
        "fontStyle": "normal",
        "fontStretch": "normal",
        "fontDisplay": "swap"
      }
    ],
    "buttonContainerStyles": {
      "flexDirection": "column",
      "justifyContent": "flex-start",
      "alignItems": "stretch",
      "columnGap": "12px",
      "rowGap": "12px",
      "flexWrap": "nowrap"
    },
    "footerStyles": {
      "textAlign": "center",
      "textDecoration": "none",
      "maxWidth": "100%",
      "opacity": 1,
      "borderStyle": "none",
      "backgroundColor": "#292929",
      "color": "#d6d6d6",
      "paddingVertical": "12px",
      "paddingHorizontal": "12px"
    },
    "headerStyles": {
      "borderRadius": "0",
      "height": "48px",
      "maxWidth": "100%",
      "minWidth": "0",
      "opacity": 1,
      "logoPosition": "left",
      "logoSize": "24px",
      "logoPadding": "0",
      "backgroundColor": "transparent",
      "paddingHorizontal": "16px",
      "paddingVertical": "12px",
      "color": "#ffffff"
    },
    "linkStyles": {
      "textAlign": "left",
      "textDecoration": "none"
    },
    "paragraphStyles": {
      "textAlign": "left",
      "textDecoration": "none",
      "maxWidth": "100%"
    },
    "secondaryButtonStyles": {
      "alignSelf": "auto",
      "backgroundColor": "#292929",
      "borderColor": "#666666",
      "borderRadius": "4px",
      "borderSize": "1px",
      "borderStyle": "solid",
      "color": "#ffffff",
      "textAlign": "center",
      "textDecoration": "none",
      "maxWidth": "100%",
      "minWidth": "auto",
      "opacity": 1,
      "width": "auto"
    },
    "signInContainerStyles": {
      "maxWidth": "440px",
      "minWidth": "320px",
      "maxHeight": "none",
      "minHeight": "0",
      "height": "auto",
      "width": "440px",
      "borderStyle": "none",
      "opacity": 1,
      "logoPosition": "center",
      "logoSize": "36px",
      "logoPadding": "0",
      "backgroundColor": "#292929",
      "borderRadius": "12px",
      "padding": "40px"
    },
    "slotSubHeadingStyles": {
      "backgroundColor": "transparent",
      "color": "inherit",
      "borderColor": "transparent",
      "borderRadius": "0",
      "borderStyle": "none",
      "borderWidth": "0",
      "paddingHorizontal": "0",
      "paddingVertical": "0"
    },
    "slotFormStyles": {
      "backgroundColor": "transparent",
      "color": "inherit",
      "borderColor": "transparent",
      "borderRadius": "0",
      "borderStyle": "none",
      "borderWidth": "0",
      "paddingHorizontal": "0",
      "paddingVertical": "0"
    },
    "subtleButtonStyles": {
      "alignSelf": "auto",
      "backgroundColor": "transparent",
      "borderColor": "transparent",
      "borderRadius": "4px",
      "borderSize": "1px",
      "borderStyle": "none",
      "color": "#d6d6d6",
      "textAlign": "center",
      "textDecoration": "none",
      "maxWidth": "100%",
      "minWidth": "auto",
      "opacity": 1,
      "width": "auto"
    },
    "tileStyles": {
      "mainTextColor": "#ffffff",
      "mainTextFontSize": "14px",
      "mainTextFontWeight": 600,
      "secondaryTextColor": "#adadad",
      "secondaryTextFontSize": "12px",
      "listRowGap": "12px"
    }
  }
}
```

</details>

### Shared token categories

Shared tokens define reusable visual values across supported authentication controls, helping you keep colors, typography, and other styling consistent. In your JSON, group overrides under the categories below and include only the properties you want to change. See [Appendix 2](#appendix-2-shared-fluent-token-reference) for properties and examples.

| Category | What it changes | Reference |
|---|---|---|
| **Brand ramp** (`themeColorRamp`) | The complete palette used to generate semantic brand colors. | [Fluent Theme Designer](https://storybooks.fluentui.dev/react/?path=/docs/theme-theme-designer--docs) |
| **Color overrides** (`themeColorOverrides`) | Individual semantic brand or neutral colors after the ramp is resolved, including hover and pressed treatments. | [Fluent colors](https://storybooks.fluentui.dev/react/?path=/docs/theme-colors--docs) |
| **Colors** (`colorStyles`) | Surface, text, border, status, and supported state colors. | [Color tokens](https://fluent2.microsoft.design/color-tokens/) |
| **Typography** (`typographyStyles`) | Font families, sizes, weights, and line heights. | [Typography](https://storybooks.fluentui.dev/react/?path=/docs/theme-typography--docs) |
| **Spacing** (`spacingStyles`) | Shared horizontal and vertical spacing. | [Spacing](https://storybooks.fluentui.dev/react/?path=/docs/theme-spacing--docs) |
| **Borders** (`borderStyles`) | Corner radii and stroke widths. | [Radii](https://storybooks.fluentui.dev/react/?path=/docs/theme-border-radii--docs) and [stroke widths](https://storybooks.fluentui.dev/react/?path=/docs/theme-stroke-widths--docs) |
| **Shadows** (`shadowStyles`) | Elevation and branded shadows. | [Shadows](https://storybooks.fluentui.dev/react/?path=/docs/theme-shadows--docs) |
| **Animation** (`animationStyles`) | Supported durations and easing. | [Design tokens](https://fluent2.microsoft.design/design-tokens) |

### Component-specific options

Use component-specific categories when a change should target a particular area rather than a shared Fluent token. A property affects the relevant component only where that component is present in the selected layout and authentication journey.

| Categories | Configuration area |
|---|---|
| `backgroundStyles`, `signInContainerStyles` | Background-layer appearance and sign-in-container dimensions, logo placement, background, shape, and padding. |
| `headerStyles`, `footerStyles` | Header and footer appearance, dimensions, and spacing. |
| `inputStyles` | Input appearance, floating labels, validation-text size, spacing, and transitions. |
| `primaryButtonStyles`, `secondaryButtonStyles`, `subtleButtonStyles` | Appearance and dimensions of each button type. |
| `buttonContainerStyles` | Button-group direction, alignment, wrapping, and gaps. |
| `linkStyles`, `paragraphStyles`, `titleStyles` | Visual properties for the corresponding text areas. |
| `slotSubHeadingStyles`, `slotFormStyles` | Appearance of supported custom HTML content slots. |
| `tileStyles` | Tile text colors, sizes, weights, and row spacing. |
| `fontFaceStyles` | Registration of supported custom font files. |

### Defaults and custom fonts

Omitted standard Fluent tokens retain the selected mode's defaults. Include only the values you intend to change. Uploading every default makes those values explicit overrides and can prevent later Fluent default improvements from taking effect.

Custom fonts require supported HTTPS-hosted font sources on custom-domain surfaces. Register the font with `fontFaceStyles`, then select its family in `typographyStyles`, for example with `fontFamilyBase`. Registering a font doesn't select it, and specifying a family name doesn't load a font file.

The [styling appendices](#appendix-design-token-properties-and-examples) cover color-ramp behavior, shared Fluent tokens, and component-specific properties. For the underlying design model, see [Fluent UI React theming](https://react.fluentui.dev/?path=/docs/concepts-theming--docs). Tokens in a newer Fluent catalog aren't necessarily supported by External ID.

## Light and dark configuration

`lightTheme` and `darkTheme` are independent, with no inheritance between them. Add shared properties to both, but adapt colors and images to each mode rather than copying the light configuration unchanged.

Check text contrast, keyboard focus, hover, pressed and disabled states, and validation messages in both modes. Validate the rendered result, not just the ramp: explicit color overrides can replace ramp-derived colors.

## Configure Advanced styling in the admin center

1. Open your branding theme's **Styling** settings and select **Advanced** under **Styling method**.
1. Edit the design-token JSON directly in the editor, or select **Upload** to use a JSON file. You can also download the JSON template to get started or use **Download** to keep a copy for offline editing.
1. Add or update the properties you need under `lightTheme` and `darkTheme`. Remove an override property to use its default or ramp-derived value instead. The default JSON includes ramps generated from your Basic styling brand colors; preserve those ramps and any existing settings you still need. Use [Appendix 2](#appendix-2-shared-fluent-token-reference) for shared tokens and [Appendix 3](#appendix-3-component-specific-styling-reference) for component-specific properties.
1. Select **Save** to save your JSON edits, then **Apply** to apply the styling changes. Preview and validate the authentication experience in both modes.

:::image type="content" source="customers/media/modern-ux-customization/ignite-advanced-styling.png" alt-text="Screenshot of Advanced styling with a design-token editor and upload and download controls for styling configuration." lightbox="customers/media/modern-ux-customization/ignite-advanced-styling.png":::

## Preview availability and configuration

Basic and Advanced styling are scheduled to become available in preview on December 7, 2026. Styling is part of the [modern Fluent experience](modern-authentication-experience.md) for application branding themes in external tenants with the preview enabled. For theme creation and application assignment, see [Customize branding themes](~/fundamentals/how-to-customize-branding-themes-apps.md).

Programmatic styling is configured through the theme localization's `designTokens` stream in Microsoft Graph. A configuration applies to the selected theme and language; it doesn't automatically update another theme or localization. See the [Microsoft Graph theme localization reference](/graph/api/resources/organizationalbrandingthemelocalization?view=graph-rest-beta&preserve-view=true).

<a id="appendix-design-token-properties-and-examples"></a>

## Appendices

| Reference | Contents |
|---|---|
| [Appendix 1: Color ramps and semantic mappings](#appendix-1-color-ramps-and-semantic-mappings) | How ramp values map to light- and dark-mode colors, override behavior, and programmatic requirements. |
| [Appendix 2: Shared Fluent token reference](#appendix-2-shared-fluent-token-reference) | Brand palettes, colors, typography, spacing, borders, shadows, and animation. |
| [Appendix 3: Component-specific styling reference](#appendix-3-component-specific-styling-reference) | Custom fonts and properties for page areas, controls, text, and content slots. |

Expand categories in Appendices 2 and 3 for properties and example values. Each example omits the outer theme container; copy only needed overrides under `lightTheme`, `darkTheme`, or both in your existing `designTokens` configuration.

Examples illustrate JSON format, not a complete theme, guaranteed defaults, or accessibility compliance. Preserve other settings and validate your application's layouts and journeys.

<a id="color-ramp-behavior-and-semantic-mappings"></a>

## Appendix 1: Color ramps and semantic mappings

Each color in the ramp is called a *stop*. Fluent assigns these colors to named settings, called *semantic tokens*, for backgrounds (`colorBrandBackground`), links (`colorBrandForegroundLink`), and borders (`colorBrandStroke1`). Other tokens set colors for states such as hover (`colorBrandBackgroundHover`).

The table shows these assignments for all 16 stops. Several tokens can share a stop, and the same token can use different stops in light and dark modes. Not every authentication page uses every token.

<br>

<details>
<summary><strong>Semantic color mappings for all 16 ramp values</strong></summary>

| Ramp value | Light-mode semantic tokens | Dark-mode semantic tokens |
|---|---|---|
| 10 | No semantic color mapping in this mode. | `colorBrandBackground2Pressed` |
| 20 | No semantic color mapping in this mode. | `colorBrandBackground2` |
| 30 | `colorBrandForeground2Pressed` | `colorBrandStroke2Pressed` |
| 40 | `colorBrandForegroundLinkPressed`, `colorBrandBackgroundPressed`, `colorBrandBackground4Static` | `colorBrandBackgroundPressed`, `colorBrandBackground2Hover`, `colorBrandBackground4Static` |
| 50 | `colorBrandForegroundOnLightPressed` | `colorBrandForegroundOnLightPressed`, `colorBrandStroke2`, `colorBrandStroke2Hover`, `colorBrandStroke2Contrast` |
| 60 | `colorBrandForegroundLinkHover`, `colorCompoundBrandForeground1Pressed`, `colorBrandForeground2Hover`, `colorBrandForegroundOnLightSelected`, `colorBrandBackgroundSelected`, `colorCompoundBrandBackgroundPressed`, `colorBrandBackground3Static`, `colorCompoundBrandStrokePressed` | `colorBrandForegroundInvertedPressed`, `colorBrandForegroundOnLightSelected`, `colorBrandBackgroundSelected`, `colorBrandBackground3Static` |
| 70 | `colorNeutralForeground2BrandPressed`, `colorNeutralForeground3BrandPressed`, `colorBrandForegroundLink`, `colorBrandForegroundLinkSelected`, `colorCompoundBrandForeground1Hover`, `colorBrandForeground2`, `colorBrandForegroundOnLightHover`, `colorBrandBackgroundHover`, `colorCompoundBrandBackgroundHover`, `colorCompoundBrandStrokeHover` | `colorBrandForegroundInvertedHover`, `colorBrandForegroundOnLightHover`, `colorBrandBackground` |
| 80 | `colorNeutralForeground2BrandHover`, `colorNeutralForeground2BrandSelected`, `colorNeutralForeground3BrandHover`, `colorNeutralForeground3BrandSelected`, `colorCompoundBrandForeground1`, `colorBrandForeground1`, `colorBrandForegroundOnLight`, `colorBrandBackground`, `colorCompoundBrandBackground`, `colorBrandBackgroundStatic`, `colorNeutralStrokeAccessibleSelected`, `colorBrandStroke1`, `colorBrandStroke2Pressed`, `colorCompoundBrandStroke` | `colorBrandForegroundInverted`, `colorBrandForegroundOnLight`, `colorBrandBackgroundHover`, `colorBrandBackgroundStatic` |
| 90 | No semantic color mapping in this mode. | `colorNeutralForeground2BrandPressed`, `colorNeutralForeground3BrandPressed`, `colorBrandForegroundLinkPressed`, `colorCompoundBrandForeground1Pressed`, `colorCompoundBrandBackgroundPressed`, `colorCompoundBrandStrokePressed` |
| 100 | `colorBrandForegroundInverted`, `colorBrandForegroundInvertedPressed` | `colorNeutralForeground2BrandHover`, `colorNeutralForeground2BrandSelected`, `colorNeutralForeground3BrandHover`, `colorNeutralForeground3BrandSelected`, `colorBrandForegroundLink`, `colorBrandForegroundLinkSelected`, `colorCompoundBrandForeground1`, `colorBrandForeground1`, `colorCompoundBrandBackground`, `colorNeutralStrokeAccessibleSelected`, `colorBrandStroke1`, `colorCompoundBrandStroke` |
| 110 | `colorBrandForegroundInvertedHover` | `colorBrandForegroundLinkHover`, `colorCompoundBrandForeground1Hover`, `colorBrandForeground2`, `colorCompoundBrandBackgroundHover`, `colorCompoundBrandStrokeHover` |
| 120 | `colorBrandStroke2Hover` | No semantic color mapping in this mode. |
| 130 | `colorBrandBackground2Pressed` | `colorBrandForeground2Hover` |
| 140 | `colorBrandBackgroundInvertedPressed`, `colorBrandStroke2`, `colorBrandStroke2Contrast` | `colorBrandBackgroundInvertedPressed` |
| 150 | `colorBrandBackground2Hover`, `colorBrandBackgroundInvertedSelected` | `colorBrandBackgroundInvertedSelected` |
| 160 | `colorBrandBackground2`, `colorBrandBackgroundInvertedHover` | `colorBrandForeground2Pressed`, `colorBrandBackgroundInvertedHover` |

</details>

### Ramp behavior and configuration

Ramp changes affect only parts of built-in controls that use these tokens. An input's branded underline and keyboard focus outline are separate, as are a checkbox's indicator and label.

The ramp doesn't change neutral body or title text, page or sign-in-card backgrounds, logos, images, error or success colors, or normal secondary- and subtle-button backgrounds. Customize these separately with supported Advanced styling properties. Disabled controls and high-contrast mode can use neutral or system colors.

Settings in `themeColorOverrides`, `colorStyles`, or component-specific categories can override ramp colors. If a color doesn't change, check for overrides and whether that part of the page uses a brand token.

The admin center generates a ramp from your brand color. Programmatic configuration requires all 16 `themeColorRamp` values, including stops unused in that mode; the service doesn't generate missing stops from one color.

## Appendix 2: Shared Fluent token reference

Shared tokens define visual values used across supported Fluent controls. Expand a category for its complete property example; omitted standard tokens retain the selected mode's defaults.

### `themeColorRamp`

A complete brand palette, with stops from `10` through `160`. Fluent uses these values to derive semantic brand colors; see [Color-ramp behavior and semantic mappings](#color-ramp-behavior-and-semantic-mappings).

Reference: [Fluent Theme Designer](https://storybooks.fluentui.dev/react/?path=/docs/theme-theme-designer--docs) and [theme colors](https://storybooks.fluentui.dev/react/?path=/docs/theme-colors--docs).

<br>

<details>
<summary><strong>Properties and example values</strong></summary>

```json
{
  "themeColorRamp": {
    "10": "#020305",
    "20": "#111723",
    "30": "#17243A",
    "40": "#1B3150",
    "50": "#1E3F66",
    "60": "#1F4D7A",
    "70": "#1B5A8F",
    "80": "#1267A3",
    "90": "#0075B8",
    "100": "#0F82C5",
    "110": "#2B8FD0",
    "120": "#479CDA",
    "130": "#62A9E3",
    "140": "#7EB6EB",
    "150": "#9AC3F2",
    "160": "#B6D0F8"
  }
}
```

</details>

### `themeColorOverrides`

Individual semantic color overrides applied after the brand ramp is resolved. Names identify visual roles and states such as hover, pressed, selected, disabled, or inverted.

Reference: [Fluent theme colors](https://storybooks.fluentui.dev/react/?path=/docs/theme-colors--docs).

<br>

<details>
<summary><strong>Properties and example values</strong></summary>

```json
{
  "themeColorOverrides": {
    "colorNeutralForeground1": "#242424",
    "colorNeutralForeground1Hover": "#242424",
    "colorNeutralForeground1Pressed": "#242424",
    "colorNeutralForeground1Selected": "#242424",
    "colorNeutralForeground2": "#424242",
    "colorNeutralForeground2Hover": "#242424",
    "colorNeutralForeground2Pressed": "#242424",
    "colorNeutralForeground2Selected": "#242424",
    "colorNeutralForeground2BrandHover": "#0f6cbd",
    "colorNeutralForeground2BrandPressed": "#115ea3",
    "colorNeutralForeground2BrandSelected": "#0f6cbd",
    "colorNeutralForeground3": "#616161",
    "colorNeutralForeground3Hover": "#424242",
    "colorNeutralForeground3Pressed": "#424242",
    "colorNeutralForeground3Selected": "#424242",
    "colorNeutralForeground3BrandHover": "#0f6cbd",
    "colorNeutralForeground3BrandPressed": "#115ea3",
    "colorNeutralForeground3BrandSelected": "#0f6cbd",
    "colorNeutralForeground4": "#707070",
    "colorNeutralForegroundDisabled": "#bdbdbd",
    "colorNeutralForegroundInvertedDisabled": "rgba(255, 255, 255, 0.4)",
    "colorBrandForegroundLink": "#115ea3",
    "colorBrandForegroundLinkHover": "#0f548c",
    "colorBrandForegroundLinkPressed": "#0c3b5e",
    "colorBrandForegroundLinkSelected": "#115ea3",
    "colorNeutralForeground2Link": "#424242",
    "colorNeutralForeground2LinkHover": "#242424",
    "colorNeutralForeground2LinkPressed": "#242424",
    "colorNeutralForeground2LinkSelected": "#242424",
    "colorCompoundBrandForeground1": "#0f6cbd",
    "colorCompoundBrandForeground1Hover": "#115ea3",
    "colorCompoundBrandForeground1Pressed": "#0f548c",
    "colorBrandForeground1": "#0f6cbd",
    "colorBrandForeground2": "#115ea3",
    "colorBrandForeground2Hover": "#0f548c",
    "colorBrandForeground2Pressed": "#0a2e4a",
    "colorNeutralForeground1Static": "#242424",
    "colorNeutralForegroundStaticInverted": "#ffffff",
    "colorNeutralForegroundInverted": "#ffffff",
    "colorNeutralForegroundInvertedHover": "#ffffff",
    "colorNeutralForegroundInvertedPressed": "#ffffff",
    "colorNeutralForegroundInvertedSelected": "#ffffff",
    "colorNeutralForegroundInverted2": "#ffffff",
    "colorNeutralForegroundOnBrand": "#ffffff",
    "colorNeutralForegroundInvertedLink": "#ffffff",
    "colorNeutralForegroundInvertedLinkHover": "#ffffff",
    "colorNeutralForegroundInvertedLinkPressed": "#ffffff",
    "colorNeutralForegroundInvertedLinkSelected": "#ffffff",
    "colorBrandForegroundInverted": "#479ef5",
    "colorBrandForegroundInvertedHover": "#62abf5",
    "colorBrandForegroundInvertedPressed": "#479ef5",
    "colorBrandForegroundOnLight": "#0f6cbd",
    "colorBrandForegroundOnLightHover": "#115ea3",
    "colorBrandForegroundOnLightPressed": "#0e4775",
    "colorBrandForegroundOnLightSelected": "#0f548c",
    "colorNeutralBackground1": "#ffffff",
    "colorNeutralBackground1Hover": "#f5f5f5",
    "colorNeutralBackground1Pressed": "#e0e0e0",
    "colorNeutralBackground1Selected": "#ebebeb",
    "colorNeutralBackground2": "#fafafa",
    "colorNeutralBackground2Hover": "#f0f0f0",
    "colorNeutralBackground2Pressed": "#dbdbdb",
    "colorNeutralBackground2Selected": "#e6e6e6",
    "colorNeutralBackground3": "#f5f5f5",
    "colorNeutralBackground3Hover": "#ebebeb",
    "colorNeutralBackground3Pressed": "#d6d6d6",
    "colorNeutralBackground3Selected": "#e0e0e0",
    "colorNeutralBackground4": "#f0f0f0",
    "colorNeutralBackground4Hover": "#fafafa",
    "colorNeutralBackground4Pressed": "#f5f5f5",
    "colorNeutralBackground4Selected": "#ffffff",
    "colorNeutralBackground5": "#ebebeb",
    "colorNeutralBackground5Hover": "#f5f5f5",
    "colorNeutralBackground5Pressed": "#f0f0f0",
    "colorNeutralBackground5Selected": "#fafafa",
    "colorNeutralBackground6": "#e6e6e6",
    "colorNeutralBackgroundInverted": "#292929",
    "colorNeutralBackgroundStatic": "#333333",
    "colorNeutralBackgroundAlpha": "rgba(255, 255, 255, 0.5)",
    "colorNeutralBackgroundAlpha2": "rgba(255, 255, 255, 0.8)",
    "colorSubtleBackground": "transparent",
    "colorSubtleBackgroundHover": "#f5f5f5",
    "colorSubtleBackgroundPressed": "#e0e0e0",
    "colorSubtleBackgroundSelected": "#ebebeb",
    "colorSubtleBackgroundLightAlphaHover": "rgba(255, 255, 255, 0.7)",
    "colorSubtleBackgroundLightAlphaPressed": "rgba(255, 255, 255, 0.5)",
    "colorSubtleBackgroundLightAlphaSelected": "transparent",
    "colorSubtleBackgroundInverted": "transparent",
    "colorSubtleBackgroundInvertedHover": "rgba(0, 0, 0, 0.1)",
    "colorSubtleBackgroundInvertedPressed": "rgba(0, 0, 0, 0.3)",
    "colorSubtleBackgroundInvertedSelected": "rgba(0, 0, 0, 0.2)",
    "colorTransparentBackground": "transparent",
    "colorTransparentBackgroundHover": "transparent",
    "colorTransparentBackgroundPressed": "transparent",
    "colorTransparentBackgroundSelected": "transparent",
    "colorNeutralBackgroundDisabled": "#f0f0f0",
    "colorNeutralBackgroundInvertedDisabled": "rgba(255, 255, 255, 0.1)",
    "colorNeutralStencil1": "#e6e6e6",
    "colorNeutralStencil2": "#fafafa",
    "colorNeutralStencil1Alpha": "rgba(0, 0, 0, 0.1)",
    "colorNeutralStencil2Alpha": "rgba(0, 0, 0, 0.05)",
    "colorBackgroundOverlay": "rgba(0, 0, 0, 0.4)",
    "colorScrollbarOverlay": "rgba(0, 0, 0, 0.5)",
    "colorBrandBackground": "#0f6cbd",
    "colorBrandBackgroundHover": "#115ea3",
    "colorBrandBackgroundPressed": "#0c3b5e",
    "colorBrandBackgroundSelected": "#0f548c",
    "colorCompoundBrandBackground": "#0f6cbd",
    "colorCompoundBrandBackgroundHover": "#115ea3",
    "colorCompoundBrandBackgroundPressed": "#0f548c",
    "colorBrandBackgroundStatic": "#0f6cbd",
    "colorBrandBackground2": "#ebf3fc",
    "colorBrandBackground2Hover": "#cfe4fa",
    "colorBrandBackground2Pressed": "#96c6fa",
    "colorBrandBackground3Static": "#0f548c",
    "colorBrandBackground4Static": "#0c3b5e",
    "colorBrandBackgroundInverted": "#ffffff",
    "colorBrandBackgroundInvertedHover": "#ebf3fc",
    "colorBrandBackgroundInvertedPressed": "#b4d6fa",
    "colorBrandBackgroundInvertedSelected": "#cfe4fa",
    "colorNeutralCardBackground": "#fafafa",
    "colorNeutralCardBackgroundHover": "#ffffff",
    "colorNeutralCardBackgroundPressed": "#f5f5f5",
    "colorNeutralCardBackgroundSelected": "#ebebeb",
    "colorNeutralCardBackgroundDisabled": "#f0f0f0",
    "colorNeutralStrokeAccessible": "#616161",
    "colorNeutralStrokeAccessibleHover": "#575757",
    "colorNeutralStrokeAccessiblePressed": "#4d4d4d",
    "colorNeutralStrokeAccessibleSelected": "#0f6cbd",
    "colorNeutralStroke1": "#d1d1d1",
    "colorNeutralStroke1Hover": "#c7c7c7",
    "colorNeutralStroke1Pressed": "#b3b3b3",
    "colorNeutralStroke1Selected": "#bdbdbd",
    "colorNeutralStroke2": "#e0e0e0",
    "colorNeutralStroke3": "#f0f0f0",
    "colorNeutralStrokeSubtle": "#e0e0e0",
    "colorNeutralStrokeOnBrand": "#ffffff",
    "colorNeutralStrokeOnBrand2": "#ffffff",
    "colorNeutralStrokeOnBrand2Hover": "#ffffff",
    "colorNeutralStrokeOnBrand2Pressed": "#ffffff",
    "colorNeutralStrokeOnBrand2Selected": "#ffffff",
    "colorBrandStroke1": "#0f6cbd",
    "colorBrandStroke2": "#b4d6fa",
    "colorBrandStroke2Hover": "#77b7f7",
    "colorBrandStroke2Pressed": "#0f6cbd",
    "colorBrandStroke2Contrast": "#b4d6fa",
    "colorCompoundBrandStroke": "#0f6cbd",
    "colorCompoundBrandStrokeHover": "#115ea3",
    "colorCompoundBrandStrokePressed": "#0f548c",
    "colorNeutralStrokeDisabled": "#e0e0e0",
    "colorNeutralStrokeInvertedDisabled": "rgba(255, 255, 255, 0.4)",
    "colorTransparentStroke": "transparent",
    "colorTransparentStrokeInteractive": "transparent",
    "colorTransparentStrokeDisabled": "transparent",
    "colorNeutralStrokeAlpha": "rgba(0, 0, 0, 0.05)",
    "colorNeutralStrokeAlpha2": "rgba(255, 255, 255, 0.2)",
    "colorStrokeFocus1": "#ffffff",
    "colorStrokeFocus2": "#000000",
    "colorNeutralShadowAmbient": "rgba(0,0,0,0.12)",
    "colorNeutralShadowKey": "rgba(0,0,0,0.14)",
    "colorNeutralShadowAmbientLighter": "rgba(0,0,0,0.06)",
    "colorNeutralShadowKeyLighter": "rgba(0,0,0,0.07)",
    "colorNeutralShadowAmbientDarker": "rgba(0,0,0,0.20)",
    "colorNeutralShadowKeyDarker": "rgba(0,0,0,0.24)",
    "colorBrandShadowAmbient": "rgba(0,0,0,0.30)",
    "colorBrandShadowKey": "rgba(0,0,0,0.25)"
  }
}
```

</details>

### `colorStyles`

Semantic, neutral, brand, palette, and status colors. A value affects elements that use that color role; validate foreground and background combinations together.

Reference: [Fluent theme colors](https://storybooks.fluentui.dev/react/?path=/docs/theme-colors--docs).

<br>

<details>
<summary><strong>Properties and example values</strong></summary>

```json
{
  "colorStyles": {
    "colorNeutralForeground1": "#242424",
    "colorNeutralForeground1Hover": "#242424",
    "colorNeutralForeground1Pressed": "#242424",
    "colorNeutralForeground1Selected": "#242424",
    "colorNeutralForeground2": "#424242",
    "colorNeutralForeground2Hover": "#242424",
    "colorNeutralForeground2Pressed": "#242424",
    "colorNeutralForeground2Selected": "#242424",
    "colorNeutralForeground2BrandHover": "#0f6cbd",
    "colorNeutralForeground2BrandPressed": "#115ea3",
    "colorNeutralForeground2BrandSelected": "#0f6cbd",
    "colorNeutralForeground3": "#616161",
    "colorNeutralForeground3Hover": "#424242",
    "colorNeutralForeground3Pressed": "#424242",
    "colorNeutralForeground3Selected": "#424242",
    "colorNeutralForeground3BrandHover": "#0f6cbd",
    "colorNeutralForeground3BrandPressed": "#115ea3",
    "colorNeutralForeground3BrandSelected": "#0f6cbd",
    "colorNeutralForeground4": "#707070",
    "colorNeutralForegroundDisabled": "#bdbdbd",
    "colorNeutralForegroundInvertedDisabled": "rgba(255, 255, 255, 0.4)",
    "colorBrandForegroundLink": "#115ea3",
    "colorBrandForegroundLinkHover": "#0f548c",
    "colorBrandForegroundLinkPressed": "#0c3b5e",
    "colorBrandForegroundLinkSelected": "#115ea3",
    "colorNeutralForeground2Link": "#424242",
    "colorNeutralForeground2LinkHover": "#242424",
    "colorNeutralForeground2LinkPressed": "#242424",
    "colorNeutralForeground2LinkSelected": "#242424",
    "colorCompoundBrandForeground1": "#0f6cbd",
    "colorCompoundBrandForeground1Hover": "#115ea3",
    "colorCompoundBrandForeground1Pressed": "#0f548c",
    "colorBrandForeground1": "#0f6cbd",
    "colorBrandForeground2": "#115ea3",
    "colorBrandForeground2Hover": "#0f548c",
    "colorBrandForeground2Pressed": "#0a2e4a",
    "colorNeutralForeground1Static": "#242424",
    "colorNeutralForegroundStaticInverted": "#ffffff",
    "colorNeutralForegroundInverted": "#ffffff",
    "colorNeutralForegroundInvertedHover": "#ffffff",
    "colorNeutralForegroundInvertedPressed": "#ffffff",
    "colorNeutralForegroundInvertedSelected": "#ffffff",
    "colorNeutralForegroundInverted2": "#ffffff",
    "colorNeutralForegroundOnBrand": "#ffffff",
    "colorNeutralForegroundInvertedLink": "#ffffff",
    "colorNeutralForegroundInvertedLinkHover": "#ffffff",
    "colorNeutralForegroundInvertedLinkPressed": "#ffffff",
    "colorNeutralForegroundInvertedLinkSelected": "#ffffff",
    "colorBrandForegroundInverted": "#479ef5",
    "colorBrandForegroundInvertedHover": "#62abf5",
    "colorBrandForegroundInvertedPressed": "#479ef5",
    "colorBrandForegroundOnLight": "#0f6cbd",
    "colorBrandForegroundOnLightHover": "#115ea3",
    "colorBrandForegroundOnLightPressed": "#0e4775",
    "colorBrandForegroundOnLightSelected": "#0f548c",
    "colorNeutralBackground1": "#ffffff",
    "colorNeutralBackground1Hover": "#f5f5f5",
    "colorNeutralBackground1Pressed": "#e0e0e0",
    "colorNeutralBackground1Selected": "#ebebeb",
    "colorNeutralBackground2": "#fafafa",
    "colorNeutralBackground2Hover": "#f0f0f0",
    "colorNeutralBackground2Pressed": "#dbdbdb",
    "colorNeutralBackground2Selected": "#e6e6e6",
    "colorNeutralBackground3": "#f5f5f5",
    "colorNeutralBackground3Hover": "#ebebeb",
    "colorNeutralBackground3Pressed": "#d6d6d6",
    "colorNeutralBackground3Selected": "#e0e0e0",
    "colorNeutralBackground4": "#f0f0f0",
    "colorNeutralBackground4Hover": "#fafafa",
    "colorNeutralBackground4Pressed": "#f5f5f5",
    "colorNeutralBackground4Selected": "#ffffff",
    "colorNeutralBackground5": "#ebebeb",
    "colorNeutralBackground5Hover": "#f5f5f5",
    "colorNeutralBackground5Pressed": "#f0f0f0",
    "colorNeutralBackground5Selected": "#fafafa",
    "colorNeutralBackground6": "#e6e6e6",
    "colorNeutralBackgroundInverted": "#292929",
    "colorNeutralBackgroundStatic": "#333333",
    "colorNeutralBackgroundAlpha": "rgba(255, 255, 255, 0.5)",
    "colorNeutralBackgroundAlpha2": "rgba(255, 255, 255, 0.8)",
    "colorSubtleBackground": "transparent",
    "colorSubtleBackgroundHover": "#f5f5f5",
    "colorSubtleBackgroundPressed": "#e0e0e0",
    "colorSubtleBackgroundSelected": "#ebebeb",
    "colorSubtleBackgroundLightAlphaHover": "rgba(255, 255, 255, 0.7)",
    "colorSubtleBackgroundLightAlphaPressed": "rgba(255, 255, 255, 0.5)",
    "colorSubtleBackgroundLightAlphaSelected": "transparent",
    "colorSubtleBackgroundInverted": "transparent",
    "colorSubtleBackgroundInvertedHover": "rgba(0, 0, 0, 0.1)",
    "colorSubtleBackgroundInvertedPressed": "rgba(0, 0, 0, 0.3)",
    "colorSubtleBackgroundInvertedSelected": "rgba(0, 0, 0, 0.2)",
    "colorTransparentBackground": "transparent",
    "colorTransparentBackgroundHover": "transparent",
    "colorTransparentBackgroundPressed": "transparent",
    "colorTransparentBackgroundSelected": "transparent",
    "colorNeutralBackgroundDisabled": "#f0f0f0",
    "colorNeutralBackgroundInvertedDisabled": "rgba(255, 255, 255, 0.1)",
    "colorNeutralStencil1": "#e6e6e6",
    "colorNeutralStencil2": "#fafafa",
    "colorNeutralStencil1Alpha": "rgba(0, 0, 0, 0.1)",
    "colorNeutralStencil2Alpha": "rgba(0, 0, 0, 0.05)",
    "colorBackgroundOverlay": "rgba(0, 0, 0, 0.4)",
    "colorScrollbarOverlay": "rgba(0, 0, 0, 0.5)",
    "colorBrandBackground": "#0f6cbd",
    "colorBrandBackgroundHover": "#115ea3",
    "colorBrandBackgroundPressed": "#0c3b5e",
    "colorBrandBackgroundSelected": "#0f548c",
    "colorCompoundBrandBackground": "#0f6cbd",
    "colorCompoundBrandBackgroundHover": "#115ea3",
    "colorCompoundBrandBackgroundPressed": "#0f548c",
    "colorBrandBackgroundStatic": "#0f6cbd",
    "colorBrandBackground2": "#ebf3fc",
    "colorBrandBackground2Hover": "#cfe4fa",
    "colorBrandBackground2Pressed": "#96c6fa",
    "colorBrandBackground3Static": "#0f548c",
    "colorBrandBackground4Static": "#0c3b5e",
    "colorBrandBackgroundInverted": "#ffffff",
    "colorBrandBackgroundInvertedHover": "#ebf3fc",
    "colorBrandBackgroundInvertedPressed": "#b4d6fa",
    "colorBrandBackgroundInvertedSelected": "#cfe4fa",
    "colorNeutralCardBackground": "#fafafa",
    "colorNeutralCardBackgroundHover": "#ffffff",
    "colorNeutralCardBackgroundPressed": "#f5f5f5",
    "colorNeutralCardBackgroundSelected": "#ebebeb",
    "colorNeutralCardBackgroundDisabled": "#f0f0f0",
    "colorNeutralStrokeAccessible": "#616161",
    "colorNeutralStrokeAccessibleHover": "#575757",
    "colorNeutralStrokeAccessiblePressed": "#4d4d4d",
    "colorNeutralStrokeAccessibleSelected": "#0f6cbd",
    "colorNeutralStroke1": "#d1d1d1",
    "colorNeutralStroke1Hover": "#c7c7c7",
    "colorNeutralStroke1Pressed": "#b3b3b3",
    "colorNeutralStroke1Selected": "#bdbdbd",
    "colorNeutralStroke2": "#e0e0e0",
    "colorNeutralStroke3": "#f0f0f0",
    "colorNeutralStrokeSubtle": "#e0e0e0",
    "colorNeutralStrokeOnBrand": "#ffffff",
    "colorNeutralStrokeOnBrand2": "#ffffff",
    "colorNeutralStrokeOnBrand2Hover": "#ffffff",
    "colorNeutralStrokeOnBrand2Pressed": "#ffffff",
    "colorNeutralStrokeOnBrand2Selected": "#ffffff",
    "colorBrandStroke1": "#0f6cbd",
    "colorBrandStroke2": "#b4d6fa",
    "colorBrandStroke2Hover": "#77b7f7",
    "colorBrandStroke2Pressed": "#0f6cbd",
    "colorBrandStroke2Contrast": "#b4d6fa",
    "colorCompoundBrandStroke": "#0f6cbd",
    "colorCompoundBrandStrokeHover": "#115ea3",
    "colorCompoundBrandStrokePressed": "#0f548c",
    "colorNeutralStrokeDisabled": "#e0e0e0",
    "colorNeutralStrokeInvertedDisabled": "rgba(255, 255, 255, 0.4)",
    "colorTransparentStroke": "transparent",
    "colorTransparentStrokeInteractive": "transparent",
    "colorTransparentStrokeDisabled": "transparent",
    "colorNeutralStrokeAlpha": "rgba(0, 0, 0, 0.05)",
    "colorNeutralStrokeAlpha2": "rgba(255, 255, 255, 0.2)",
    "colorStrokeFocus1": "#ffffff",
    "colorStrokeFocus2": "#000000",
    "colorNeutralShadowAmbient": "rgba(0,0,0,0.12)",
    "colorNeutralShadowKey": "rgba(0,0,0,0.14)",
    "colorNeutralShadowAmbientLighter": "rgba(0,0,0,0.06)",
    "colorNeutralShadowKeyLighter": "rgba(0,0,0,0.07)",
    "colorNeutralShadowAmbientDarker": "rgba(0,0,0,0.20)",
    "colorNeutralShadowKeyDarker": "rgba(0,0,0,0.24)",
    "colorBrandShadowAmbient": "rgba(0,0,0,0.30)",
    "colorBrandShadowKey": "rgba(0,0,0,0.25)",
    "colorPaletteRedBackground1": "#fdf6f6",
    "colorPaletteRedBackground2": "#f1bbbc",
    "colorPaletteRedBackground3": "#d13438",
    "colorPaletteRedForeground1": "#bc2f32",
    "colorPaletteRedForeground2": "#751d1f",
    "colorPaletteRedForeground3": "#d13438",
    "colorPaletteRedBorderActive": "#d13438",
    "colorPaletteRedBorder1": "#f1bbbc",
    "colorPaletteRedBorder2": "#d13438",
    "colorPaletteGreenBackground1": "#f1faf1",
    "colorPaletteGreenBackground2": "#9fd89f",
    "colorPaletteGreenBackground3": "#107c10",
    "colorPaletteGreenForeground1": "#0e700e",
    "colorPaletteGreenForeground2": "#094509",
    "colorPaletteGreenForeground3": "#107c10",
    "colorPaletteGreenBorderActive": "#107c10",
    "colorPaletteGreenBorder1": "#9fd89f",
    "colorPaletteGreenBorder2": "#107c10",
    "colorPaletteDarkOrangeBackground1": "#fdf6f3",
    "colorPaletteDarkOrangeBackground2": "#f4bfab",
    "colorPaletteDarkOrangeBackground3": "#da3b01",
    "colorPaletteDarkOrangeForeground1": "#c43501",
    "colorPaletteDarkOrangeForeground2": "#7a2101",
    "colorPaletteDarkOrangeForeground3": "#da3b01",
    "colorPaletteDarkOrangeBorderActive": "#da3b01",
    "colorPaletteDarkOrangeBorder1": "#f4bfab",
    "colorPaletteDarkOrangeBorder2": "#da3b01",
    "colorPaletteYellowBackground1": "#fffef5",
    "colorPaletteYellowBackground2": "#fef7b2",
    "colorPaletteYellowBackground3": "#fde300",
    "colorPaletteYellowForeground1": "#817400",
    "colorPaletteYellowForeground2": "#817400",
    "colorPaletteYellowForeground3": "#fde300",
    "colorPaletteYellowBorderActive": "#fde300",
    "colorPaletteYellowBorder1": "#fef7b2",
    "colorPaletteYellowBorder2": "#fde300",
    "colorPaletteBerryBackground1": "#fdf5fc",
    "colorPaletteBerryBackground2": "#edbbe7",
    "colorPaletteBerryBackground3": "#c239b3",
    "colorPaletteBerryForeground1": "#af33a1",
    "colorPaletteBerryForeground2": "#6d2064",
    "colorPaletteBerryForeground3": "#c239b3",
    "colorPaletteBerryBorderActive": "#c239b3",
    "colorPaletteBerryBorder1": "#edbbe7",
    "colorPaletteBerryBorder2": "#c239b3",
    "colorPaletteLightGreenBackground1": "#f2fbf2",
    "colorPaletteLightGreenBackground2": "#a7e3a5",
    "colorPaletteLightGreenBackground3": "#13a10e",
    "colorPaletteLightGreenForeground1": "#11910d",
    "colorPaletteLightGreenForeground2": "#0b5a08",
    "colorPaletteLightGreenForeground3": "#13a10e",
    "colorPaletteLightGreenBorderActive": "#13a10e",
    "colorPaletteLightGreenBorder1": "#a7e3a5",
    "colorPaletteLightGreenBorder2": "#13a10e",
    "colorPaletteMarigoldBackground1": "#fefbf4",
    "colorPaletteMarigoldBackground2": "#f9e2ae",
    "colorPaletteMarigoldBackground3": "#eaa300",
    "colorPaletteMarigoldForeground1": "#d39300",
    "colorPaletteMarigoldForeground2": "#835b00",
    "colorPaletteMarigoldForeground3": "#eaa300",
    "colorPaletteMarigoldBorderActive": "#eaa300",
    "colorPaletteMarigoldBorder1": "#f9e2ae",
    "colorPaletteMarigoldBorder2": "#eaa300",
    "colorPaletteRedForegroundInverted": "#dc5e62",
    "colorPaletteGreenForegroundInverted": "#359b35",
    "colorPaletteYellowForegroundInverted": "#fef7b2",
    "colorPaletteDarkRedBackground2": "#d69ca5",
    "colorPaletteDarkRedForeground2": "#420610",
    "colorPaletteDarkRedBorderActive": "#750b1c",
    "colorPaletteCranberryBackground2": "#eeacb2",
    "colorPaletteCranberryForeground2": "#6e0811",
    "colorPaletteCranberryBorderActive": "#c50f1f",
    "colorPalettePumpkinBackground2": "#efc4ad",
    "colorPalettePumpkinForeground2": "#712d09",
    "colorPalettePumpkinBorderActive": "#ca5010",
    "colorPalettePeachBackground2": "#ffddb3",
    "colorPalettePeachForeground2": "#8f4e00",
    "colorPalettePeachBorderActive": "#ff8c00",
    "colorPaletteGoldBackground2": "#ecdfa5",
    "colorPaletteGoldForeground2": "#6c5700",
    "colorPaletteGoldBorderActive": "#c19c00",
    "colorPaletteBrassBackground2": "#e0cea2",
    "colorPaletteBrassForeground2": "#553e06",
    "colorPaletteBrassBorderActive": "#986f0b",
    "colorPaletteBrownBackground2": "#ddc3b0",
    "colorPaletteBrownForeground2": "#50301a",
    "colorPaletteBrownBorderActive": "#8e562e",
    "colorPaletteForestBackground2": "#bdd99b",
    "colorPaletteForestForeground2": "#294903",
    "colorPaletteForestBorderActive": "#498205",
    "colorPaletteSeafoamBackground2": "#a8f0cd",
    "colorPaletteSeafoamForeground2": "#00723b",
    "colorPaletteSeafoamBorderActive": "#00cc6a",
    "colorPaletteDarkGreenBackground2": "#9ad29a",
    "colorPaletteDarkGreenForeground2": "#063b06",
    "colorPaletteDarkGreenBorderActive": "#0b6a0b",
    "colorPaletteLightTealBackground2": "#a6e9ed",
    "colorPaletteLightTealForeground2": "#00666d",
    "colorPaletteLightTealBorderActive": "#00b7c3",
    "colorPaletteTealBackground2": "#9bd9db",
    "colorPaletteTealForeground2": "#02494c",
    "colorPaletteTealBorderActive": "#038387",
    "colorPaletteSteelBackground2": "#94c8d4",
    "colorPaletteSteelForeground2": "#00333f",
    "colorPaletteSteelBorderActive": "#005b70",
    "colorPaletteBlueBackground2": "#a9d3f2",
    "colorPaletteBlueForeground2": "#004377",
    "colorPaletteBlueBorderActive": "#0078d4",
    "colorPaletteRoyalBlueBackground2": "#9abfdc",
    "colorPaletteRoyalBlueForeground2": "#002c4e",
    "colorPaletteRoyalBlueBorderActive": "#004e8c",
    "colorPaletteCornflowerBackground2": "#c8d1fa",
    "colorPaletteCornflowerForeground2": "#2c3c85",
    "colorPaletteCornflowerBorderActive": "#4f6bed",
    "colorPaletteNavyBackground2": "#a3b2e8",
    "colorPaletteNavyForeground2": "#001665",
    "colorPaletteNavyBorderActive": "#0027b4",
    "colorPaletteLavenderBackground2": "#d2ccf8",
    "colorPaletteLavenderForeground2": "#3f3682",
    "colorPaletteLavenderBorderActive": "#7160e8",
    "colorPalettePurpleBackground2": "#c6b1de",
    "colorPalettePurpleForeground2": "#341a51",
    "colorPalettePurpleBorderActive": "#5c2e91",
    "colorPaletteGrapeBackground2": "#d9a7e0",
    "colorPaletteGrapeForeground2": "#4c0d55",
    "colorPaletteGrapeBorderActive": "#881798",
    "colorPaletteLilacBackground2": "#e6bfed",
    "colorPaletteLilacForeground2": "#63276d",
    "colorPaletteLilacBorderActive": "#b146c2",
    "colorPalettePinkBackground2": "#f7c0e3",
    "colorPalettePinkForeground2": "#80215d",
    "colorPalettePinkBorderActive": "#e43ba6",
    "colorPaletteMagentaBackground2": "#eca5d1",
    "colorPaletteMagentaForeground2": "#6b0043",
    "colorPaletteMagentaBorderActive": "#bf0077",
    "colorPalettePlumBackground2": "#d696c0",
    "colorPalettePlumForeground2": "#43002b",
    "colorPalettePlumBorderActive": "#77004d",
    "colorPaletteBeigeBackground2": "#d7d4d4",
    "colorPaletteBeigeForeground2": "#444241",
    "colorPaletteBeigeBorderActive": "#7a7574",
    "colorPaletteMinkBackground2": "#cecccb",
    "colorPaletteMinkForeground2": "#343231",
    "colorPaletteMinkBorderActive": "#5d5a58",
    "colorPalettePlatinumBackground2": "#cdd6d8",
    "colorPalettePlatinumForeground2": "#3b4447",
    "colorPalettePlatinumBorderActive": "#69797e",
    "colorPaletteAnchorBackground2": "#bcc3c7",
    "colorPaletteAnchorForeground2": "#202427",
    "colorPaletteAnchorBorderActive": "#394146",
    "colorStatusSuccessBackground1": "#f1faf1",
    "colorStatusSuccessBackground2": "#9fd89f",
    "colorStatusSuccessBackground3": "#107c10",
    "colorStatusSuccessForeground1": "#0e700e",
    "colorStatusSuccessForeground2": "#094509",
    "colorStatusSuccessForeground3": "#107c10",
    "colorStatusSuccessForegroundInverted": "#54b054",
    "colorStatusSuccessBorderActive": "#107c10",
    "colorStatusSuccessBorder1": "#9fd89f",
    "colorStatusSuccessBorder2": "#107c10",
    "colorStatusWarningBackground1": "#fff9f5",
    "colorStatusWarningBackground2": "#fdcfb4",
    "colorStatusWarningBackground3": "#f7630c",
    "colorStatusWarningForeground1": "#bc4b09",
    "colorStatusWarningForeground2": "#8a3707",
    "colorStatusWarningForeground3": "#bc4b09",
    "colorStatusWarningForegroundInverted": "#faa06b",
    "colorStatusWarningBorderActive": "#f7630c",
    "colorStatusWarningBorder1": "#fdcfb4",
    "colorStatusWarningBorder2": "#bc4b09",
    "colorStatusDangerBackground1": "#fdf3f4",
    "colorStatusDangerBackground2": "#eeacb2",
    "colorStatusDangerBackground3": "#c50f1f",
    "colorStatusDangerForeground1": "#b10e1c",
    "colorStatusDangerForeground2": "#6e0811",
    "colorStatusDangerForeground3": "#c50f1f",
    "colorStatusDangerForegroundInverted": "#dc626d",
    "colorStatusDangerBorderActive": "#c50f1f",
    "colorStatusDangerBorder1": "#eeacb2",
    "colorStatusDangerBorder2": "#c50f1f",
    "colorStatusDangerBackground3Hover": "#b10e1c",
    "colorStatusDangerBackground3Pressed": "#960b18"
  }
}
```

</details>

### `typographyStyles`

The shared type scale: font sizes, line heights, font-family stacks, and numeric font weights. A font-family value selects a font but does not download it.

Reference: [Fluent typography](https://storybooks.fluentui.dev/react/?path=/docs/theme-typography--docs) and [font tokens](https://storybooks.fluentui.dev/react/?path=/docs/theme-fonts--docs).

<br>

<details>
<summary><strong>Properties and example values</strong></summary>

```json
{
  "typographyStyles": {
    "fontSizeBase100": "10px",
    "fontSizeBase200": "12px",
    "fontSizeBase300": "14px",
    "fontSizeBase400": "16px",
    "fontSizeBase500": "20px",
    "fontSizeBase600": "24px",
    "fontSizeHero700": "28px",
    "fontSizeHero800": "32px",
    "fontSizeHero900": "40px",
    "fontSizeHero1000": "68px",
    "lineHeightBase100": "14px",
    "lineHeightBase200": "16px",
    "lineHeightBase300": "20px",
    "lineHeightBase400": "22px",
    "lineHeightBase500": "28px",
    "lineHeightBase600": "32px",
    "lineHeightHero700": "36px",
    "lineHeightHero800": "40px",
    "lineHeightHero900": "52px",
    "lineHeightHero1000": "92px",
    "fontFamilyBase": "'Segoe UI', 'Segoe UI Web (West European)', -apple-system, BlinkMacSystemFont, Roboto, 'Helvetica Neue', sans-serif",
    "fontFamilyMonospace": "Consolas, 'Courier New', Courier, monospace",
    "fontFamilyNumeric": "Bahnschrift, 'Segoe UI', 'Segoe UI Web (West European)', -apple-system, BlinkMacSystemFont, Roboto, 'Helvetica Neue', sans-serif",
    "fontWeightRegular": 400,
    "fontWeightMedium": 500,
    "fontWeightSemibold": 600,
    "fontWeightBold": 700
  }
}
```

</details>

### `spacingStyles`

Horizontal and vertical spacing scales. Names identify direction and size, from `None` through `XXXL`; a shared spacing change can affect several components.

Reference: [Fluent spacing tokens](https://storybooks.fluentui.dev/react/?path=/docs/theme-spacing--docs).

<br>

<details>
<summary><strong>Properties and example values</strong></summary>

```json
{
  "spacingStyles": {
    "spacingHorizontalNone": "0",
    "spacingHorizontalXXS": "2px",
    "spacingHorizontalXS": "4px",
    "spacingHorizontalSNudge": "6px",
    "spacingHorizontalS": "8px",
    "spacingHorizontalMNudge": "10px",
    "spacingHorizontalM": "12px",
    "spacingHorizontalL": "16px",
    "spacingHorizontalXL": "20px",
    "spacingHorizontalXXL": "24px",
    "spacingHorizontalXXXL": "32px",
    "spacingVerticalNone": "0",
    "spacingVerticalXXS": "2px",
    "spacingVerticalXS": "4px",
    "spacingVerticalSNudge": "6px",
    "spacingVerticalS": "8px",
    "spacingVerticalMNudge": "10px",
    "spacingVerticalM": "12px",
    "spacingVerticalL": "16px",
    "spacingVerticalXL": "20px",
    "spacingVerticalXXL": "24px",
    "spacingVerticalXXXL": "32px"
  }
}
```

</details>

### `borderStyles`

Shared corner-radius and stroke-width scales. Use a component-specific category when the change should apply to only one type of control.

Reference: [Fluent border radii](https://storybooks.fluentui.dev/react/?path=/docs/theme-border-radii--docs) and [stroke widths](https://storybooks.fluentui.dev/react/?path=/docs/theme-stroke-widths--docs).

<br>

<details>
<summary><strong>Properties and example values</strong></summary>

```json
{
  "borderStyles": {
    "borderRadiusNone": "0",
    "borderRadiusSmall": "2px",
    "borderRadiusMedium": "4px",
    "borderRadiusLarge": "6px",
    "borderRadiusXLarge": "8px",
    "borderRadiusCircular": "10000px",
    "strokeWidthThin": "1px",
    "strokeWidthThick": "2px",
    "strokeWidthThicker": "3px",
    "strokeWidthThickest": "4px"
  }
}
```

</details>

### `shadowStyles`

Standard and brand-colored elevation shadows. The numeric suffix identifies the Fluent elevation level.

Reference: [Fluent shadow tokens](https://storybooks.fluentui.dev/react/?path=/docs/theme-shadows--docs).

<br>

<details>
<summary><strong>Properties and example values</strong></summary>

```json
{
  "shadowStyles": {
    "shadow2": "0 0 2px rgba(0,0,0,0.12), 0 1px 2px rgba(0,0,0,0.14)",
    "shadow4": "0 0 2px rgba(0,0,0,0.12), 0 2px 4px rgba(0,0,0,0.14)",
    "shadow8": "0 0 2px rgba(0,0,0,0.12), 0 4px 8px rgba(0,0,0,0.14)",
    "shadow16": "0 0 2px rgba(0,0,0,0.12), 0 8px 16px rgba(0,0,0,0.14)",
    "shadow28": "0 0 8px rgba(0,0,0,0.12), 0 14px 28px rgba(0,0,0,0.14)",
    "shadow64": "0 0 8px rgba(0,0,0,0.12), 0 32px 64px rgba(0,0,0,0.14)",
    "shadow2Brand": "0 0 2px rgba(0,0,0,0.30), 0 1px 2px rgba(0,0,0,0.25)",
    "shadow4Brand": "0 0 2px rgba(0,0,0,0.30), 0 2px 4px rgba(0,0,0,0.25)",
    "shadow8Brand": "0 0 2px rgba(0,0,0,0.30), 0 4px 8px rgba(0,0,0,0.25)",
    "shadow16Brand": "0 0 2px rgba(0,0,0,0.30), 0 8px 16px rgba(0,0,0,0.25)",
    "shadow28Brand": "0 0 8px rgba(0,0,0,0.30), 0 14px 28px rgba(0,0,0,0.25)",
    "shadow64Brand": "0 0 8px rgba(0,0,0,0.30), 0 32px 64px rgba(0,0,0,0.25)"
  }
}
```

</details>

### `animationStyles`

Durations and easing curves for supported transitions. Duration values use time units; curve values describe the transition timing function.

<br>

<details>
<summary><strong>Properties and example values</strong></summary>

```json
{
  "animationStyles": {
    "durationUltraFast": "50ms",
    "durationFaster": "100ms",
    "durationFast": "150ms",
    "durationNormal": "200ms",
    "durationGentle": "250ms",
    "durationSlow": "300ms",
    "durationSlower": "400ms",
    "durationUltraSlow": "500ms",
    "curveAccelerateMax": "cubic-bezier(0.9,0.1,1,0.2)",
    "curveAccelerateMid": "cubic-bezier(1,0,1,1)",
    "curveAccelerateMin": "cubic-bezier(0.8,0,0.78,1)",
    "curveDecelerateMax": "cubic-bezier(0.1,0.9,0.2,1)",
    "curveDecelerateMid": "cubic-bezier(0,0,0,1)",
    "curveDecelerateMin": "cubic-bezier(0.33,0,0.1,1)",
    "curveEasyEaseMax": "cubic-bezier(0.8,0,0.2,1)",
    "curveEasyEase": "cubic-bezier(0.33,0,0.67,1)",
    "curveLinear": "cubic-bezier(0,0,1,1)"
  }
}
```

</details>

## Appendix 3: Component-specific styling reference

These categories configure custom fonts or target a supported page area or control. Each description remains visible; expand the category's example to view its properties and value formats.

### `fontFaceStyles`

An array of custom font declarations. `fontFamily` names the font, `srcUrl` identifies its HTTPS resource, and the remaining properties describe its weight, style, stretch, and loading strategy. Use a supported custom-domain surface and select the registered family in `typographyStyles`.

<br>

<details>
<summary><strong>Properties and example values</strong></summary>

```json
{
  "fontFaceStyles": [
    {
      "fontFamily": "CustomBrandFont",
      "srcUrl": "https://cdn.example.com/fonts/custom-brand-font.woff2",
      "fontWeight": "100 900",
      "fontStyle": "normal",
      "fontStretch": "normal",
      "fontDisplay": "swap"
    }
  ]
}
```

</details>

### `backgroundStyles`

Background-layer settings. `opacity` uses a number from `0` through `1`; `fillColor` supplies a fill color.

<br>

<details>
<summary><strong>Properties and example values</strong></summary>

```json
{
  "backgroundStyles": {
    "opacity": 1,
    "fillColor": "#ffffff"
  }
}
```

</details>

### `buttonContainerStyles`

Button-group layout. `flexDirection` sets the arrangement direction, `justifyContent` and `alignItems` set axis alignment, `flexWrap` controls wrapping, and the gap properties set spacing.

<br>

<details>
<summary><strong>Properties and example values</strong></summary>

```json
{
  "buttonContainerStyles": {
    "flexDirection": "column",
    "justifyContent": "flex-start",
    "alignItems": "stretch",
    "columnGap": "12px",
    "rowGap": "12px",
    "flexWrap": "nowrap"
  }
}
```

</details>

### `footerStyles`

Footer appearance and spacing properties. Color values describe the background and foreground; horizontal and vertical padding apply to the corresponding pair of sides.

<br>

<details>
<summary><strong>Properties and example values</strong></summary>

```json
{
  "footerStyles": {
    "textAlign": "center",
    "textDecoration": "none",
    "maxWidth": "100%",
    "opacity": 1,
    "borderStyle": "none",
    "backgroundColor": "#ffffff",
    "color": "#424242",
    "paddingVertical": "12px",
    "paddingHorizontal": "12px"
  }
}
```

</details>

### `headerStyles`

Header dimensions, appearance, logo settings, and padding. Use size values with units where appropriate, and a number from `0` through `1` for opacity.

<br>

<details>
<summary><strong>Properties and example values</strong></summary>

```json
{
  "headerStyles": {
    "borderRadius": "0",
    "height": "48px",
    "maxWidth": "100%",
    "minWidth": "0",
    "opacity": 1,
    "logoPosition": "left",
    "logoSize": "24px",
    "logoPadding": "0",
    "backgroundColor": "transparent",
    "paddingHorizontal": "16px",
    "paddingVertical": "12px",
    "color": "#242424"
  }
}
```

</details>

### `inputStyles`

Input and floating-label appearance, spacing, validation-text size, and transition settings. Placeholder colors, label margins, and transition properties can be configured independently.

<br>

<details>
<summary><strong>Properties and example values</strong></summary>

```json
{
  "inputStyles": {
    "borderRadius": "4px",
    "textAlign": "left",
    "textDecoration": "none",
    "maxWidth": "100%",
    "minWidth": "0",
    "borderStyle": "solid",
    "opacity": 1,
    "lineHeight": "22px",
    "floatingPlaceholderColor": "#707070",
    "floatingPlaceholderBackgroundColor": "#ffffff",
    "disabledPlaceholderColor": "#bdbdbd",
    "floatingLabelMarginTop": "8px",
    "stackedInputMarginTop": "24px",
    "validationErrorFontSize": "12px",
    "transitionDuration": "200ms",
    "transitionTimingFunction": "cubic-bezier(0,0,0,1)"
  }
}
```

</details>

### `linkStyles`

Link text-alignment and decoration properties. Use semantic color tokens when configuring link colors and their interaction states.

<br>

<details>
<summary><strong>Properties and example values</strong></summary>

```json
{
  "linkStyles": {
    "textAlign": "left",
    "textDecoration": "none"
  }
}
```

</details>

### `paragraphStyles`

Paragraph text-alignment, decoration, and maximum-width properties.

<br>

<details>
<summary><strong>Properties and example values</strong></summary>

```json
{
  "paragraphStyles": {
    "textAlign": "left",
    "textDecoration": "none",
    "maxWidth": "100%"
  }
}
```

</details>

### `primaryButtonStyles`

Primary-button appearance, alignment, dimensions, and opacity. `borderSize` is the button border-width property; use `color` for text and `backgroundColor` for the surface.

<br>

<details>
<summary><strong>Properties and example values</strong></summary>

```json
{
  "primaryButtonStyles": {
    "alignSelf": "auto",
    "backgroundColor": "#0f6cbd",
    "borderColor": "transparent",
    "borderRadius": "4px",
    "borderSize": "1px",
    "borderStyle": "none",
    "color": "#ffffff",
    "textAlign": "center",
    "textDecoration": "none",
    "maxWidth": "100%",
    "minWidth": "auto",
    "opacity": 1,
    "width": "auto"
  }
}
```

</details>

### `secondaryButtonStyles`

Secondary-button appearance, alignment, dimensions, and opacity. These values are separate from the primary-button category.

<br>

<details>
<summary><strong>Properties and example values</strong></summary>

```json
{
  "secondaryButtonStyles": {
    "alignSelf": "auto",
    "backgroundColor": "#ffffff",
    "borderColor": "#d1d1d1",
    "borderRadius": "4px",
    "borderSize": "1px",
    "borderStyle": "solid",
    "color": "#242424",
    "textAlign": "center",
    "textDecoration": "none",
    "maxWidth": "100%",
    "minWidth": "auto",
    "opacity": 1,
    "width": "auto"
  }
}
```

</details>

### `signInContainerStyles`

Sign-in-container dimensions, logo settings, background, border treatment, radius, and padding. Check sizing changes at narrow widths and with longer localized content.

<br>

<details>
<summary><strong>Properties and example values</strong></summary>

```json
{
  "signInContainerStyles": {
    "maxWidth": "440px",
    "minWidth": "320px",
    "maxHeight": "none",
    "minHeight": "0",
    "height": "auto",
    "width": "440px",
    "borderStyle": "none",
    "opacity": 1,
    "logoPosition": "center",
    "logoSize": "36px",
    "logoPadding": "0",
    "backgroundColor": "#ffffff",
    "borderRadius": "12px",
    "padding": "40px"
  }
}
```

</details>

### `slotSubHeadingStyles`

Colors, border, radius, and padding for the supported custom HTML subheading content slot. Horizontal and vertical padding apply to both sides of the corresponding axis.

<br>

<details>
<summary><strong>Properties and example values</strong></summary>

```json
{
  "slotSubHeadingStyles": {
    "backgroundColor": "transparent",
    "color": "inherit",
    "borderColor": "transparent",
    "borderRadius": "0",
    "borderStyle": "none",
    "borderWidth": "0",
    "paddingHorizontal": "0",
    "paddingVertical": "0"
  }
}
```

</details>

### `slotFormStyles`

Colors, border, radius, and padding for the supported custom HTML form content slot. These settings style the slot rather than changing authentication-control behavior.

<br>

<details>
<summary><strong>Properties and example values</strong></summary>

```json
{
  "slotFormStyles": {
    "backgroundColor": "transparent",
    "color": "inherit",
    "borderColor": "transparent",
    "borderRadius": "0",
    "borderStyle": "none",
    "borderWidth": "0",
    "paddingHorizontal": "0",
    "paddingVertical": "0"
  }
}
```

</details>

### `subtleButtonStyles`

Subtle-button appearance, alignment, dimensions, and opacity. These values are separate from the primary- and secondary-button categories.

<br>

<details>
<summary><strong>Properties and example values</strong></summary>

```json
{
  "subtleButtonStyles": {
    "alignSelf": "auto",
    "backgroundColor": "transparent",
    "borderColor": "transparent",
    "borderRadius": "4px",
    "borderSize": "1px",
    "borderStyle": "none",
    "color": "#424242",
    "textAlign": "center",
    "textDecoration": "none",
    "maxWidth": "100%",
    "minWidth": "auto",
    "opacity": 1,
    "width": "auto"
  }
}
```

</details>

### `tileStyles`

Primary and secondary tile text colors and sizes, primary-text weight, and the vertical gap between tile rows.

<br>

<details>
<summary><strong>Properties and example values</strong></summary>

```json
{
  "tileStyles": {
    "mainTextColor": "#242424",
    "mainTextFontSize": "14px",
    "mainTextFontWeight": 600,
    "secondaryTextColor": "#616161",
    "secondaryTextFontSize": "12px",
    "listRowGap": "12px"
  }
}
```

</details>

### `titleStyles`

Title text-alignment, decoration, maximum-width, and color properties.

<br>

<details>
<summary><strong>Properties and example values</strong></summary>

```json
{
  "titleStyles": {
    "textAlign": "center",
    "textDecoration": "none",
    "maxWidth": "100%",
    "color": "#242424"
  }
}
```

</details>

## Related content

- [Authentication customization overview](customization-overview.md).
- [Modern authentication experience](modern-authentication-experience.md).
- [Custom HTML and JavaScript](custom-html-javascript.md).
