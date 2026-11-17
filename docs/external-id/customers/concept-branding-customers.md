---
title: Authentication Branding
description: Learn how to customize Microsoft-hosted sign-in and sign-up pages in Microsoft Entra External ID with company branding, text, and languages.
ms.topic: concept-article
ms.date: 11/13/2026
ms.custom: it-pro, sfi-image-nochange, msecd-doc-authoring-1030
ai-usage: ai-assisted
#customer intent: As an IT administrator, I want to understand branding and language options so that I can customize Microsoft-hosted authentication pages for my customers.
---

# Customize Microsoft Entra External ID authentication branding

After creating an external tenant, you can customize the Microsoft-hosted pages customers use to sign in, sign up, or sign out. The tenant comes with neutral branding that you can tailor to your company's needs. Add a background image or color, favicon, layout, header, and footer, or upload custom CSS. These settings customize the hosted authentication pages, not your application's interface. For more information, see [Customize the neutral branding in your external tenant](how-to-customize-branding-customers.md).

[!INCLUDE [authentication-approaches](../includes/applies-to-authentication-approaches.md)]

If the custom company branding fails to load, the sign-in page reverts to the neutral branding. 

The following list and image outline the elements of the neutral branding sign-in experience:

1. Background image and color.
1. Favicon.
1. Banner logo.
1. Footer as a page layout element.
1. Footer links, such as **Privacy & cookies** and **Terms of use**, and troubleshooting details available from the ellipsis menu.

   :::image type="content" source="media/how-to-customize-branding-customers/ciam-neutral-branding.png" alt-text="Screenshot of a neutral sign-in page with numbered branding elements." lightbox="media/how-to-customize-branding-customers/ciam-neutral-branding.png":::

As a comparison, here’s how the [default Microsoft sign-in experience](~/fundamentals/how-to-customize-branding.md) in a Microsoft Entra ID tenant looks:

   :::image type="content" source="media/how-to-customize-branding-customers/microsoft-branding.png" alt-text="Screenshot of the Microsoft Entra ID default Microsoft branding." lightbox="media/how-to-customize-branding-customers/microsoft-branding.png":::



## Preview customization options

The [modern UX and customization overview](../customization-overview.md) covers the Fluent experience, Basic and Advanced styling, and custom HTML with optional JavaScript. These new capabilities are configured through application branding themes; this section doesn't extend them to default company branding. Microsoft retains control of authentication fields and actions.

These capabilities are scheduled to become available in preview on December 7, 2026, for external tenants with the preview enabled. The existing company-branding procedures continue to apply to default branding.

## Text customization

You can customize text for built-in attributes, such as Given Name, Surname, City, and Postal Code, on Microsoft-hosted sign-up and sign-in pages. Customize strings under **Company Branding** or through language customization in **User flows**. Both options modify the same JSON file, so the most recent change overrides the previous one.

## Language customization

Customize branding elements for users who sign in with a specific browser language. Elements you don't customize retain their defaults.
Add language customizations under **Company Branding** or for a specific user flow under **User flows**. For supported languages and instructions, see [Customize the language of the authentication experience](how-to-customize-languages-customers.md).

## Microsoft Graph APIs

You can also manage company branding and configure all assets programmatically. 
- For the default branding, use the [organizationalBranding resource type](/graph/api/resources/organizationalbranding) and its associated methods.
- To customize branding based on locale, use the [organizationalBrandingLocalization resource type](/graph/api/resources/organizationalbrandinglocalization) and its associated methods.

## Next steps
- [Customize the user experience for your customers](how-to-customize-branding-customers.md)
- [Customize the language of the authentication experience](how-to-customize-languages-customers.md)
